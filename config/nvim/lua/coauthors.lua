-- A simple Neovim plugin for piping 'Co-authored-by' completions to nvim-cmp
local M = {}
local uv = (vim.uv or vim.loop)
local cmp = require("cmp")

--- @alias coauthor string
--- @type coauthor[]
local coauthors_state = {}

--- Scans git log for recent commit authors asynchronously using vim.uv
--- @param depth number
--- @param callback fun(result: coauthor[])
local function scan_git_log_async(depth, callback)
  local stdout = uv.new_pipe(false)
  local buffer = ""
  local found_authors = {}

  uv.spawn("git", {
    args = {
      "log",
      "-" .. depth,
      "--format=%aN <%aE>",
    },
    stdio = {
      uv.new_pipe(false),
      stdout,
      uv.new_pipe(false),
    },
  }, function(code, signal) -- on exit
    -- TODO: Nicer error messaging?
    -- print("exit code", code)
    -- print("exit signal", signal)
  end)

  uv.read_start(stdout, function(err, data)
    assert(not err, err)

    if data then
      buffer = buffer .. data
    else
      local lines = vim.split(buffer, "\n")
      for _, line in ipairs(lines) do
        found_authors[line] = true
      end

      callback(vim.tbl_keys(found_authors))
    end
  end)
end

local function as_source()
  return {
    name = "coauthors",
    complete = function(_, _, callback)
      local items = {}

      for _, coauthor in pairs(coauthors_state) do
        table.insert(items, {
          label = coauthor,
        })
      end

      callback({
        items = items,
      })
    end,
    keyword_length = 2, -- "Co" will trigger completions
  }
end

-- Register the plugin with nvim-cmp
function M.setup()
  cmp.register_source("coauthors", as_source())

  -- Scan when opening commit messages, not too slow atm
  vim.api.nvim_create_autocmd("BufRead", {
    pattern = "COMMIT_EDITMSG",
    callback = function()
      scan_git_log_async(100, function(git_authors)
        coauthors_state = git_authors
      end)
    end,
  })
end

return M
