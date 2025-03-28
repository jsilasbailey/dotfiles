-- A simple Neovim plugin for piping 'Co-authored-by' completions to nvim-cmp
local M = {}
local cmp = require("cmp")

--- @alias coauthor string
--- @type coauthor[]
local coauthors_state = {}

--- Scans `git log` for recent commit authors asynchronously
--- @param callback fun(result: coauthor[])
local function scan_git_log_async(callback)
  vim.system({
    "sh",
    "-c",
    "git log --pretty=short | git shortlog -nes | cut -f 2",
  }, { text = true }, function(out)
    local data = out.stdout

    if out.code == 0 and data then
      local authors = {}
      for line in data:gmatch("[^\r\n]+") do
        authors[line] = true
      end

      callback(vim.tbl_keys(authors))
    else
      vim.schedule(function()
        vim.notify("[coauthors] Git shortlog error: " .. out.stderr, vim.log.levels.ERROR)
      end)
    end
  end)
end

-- Register the plugin with nvim-cmp
function M.setup()
  ---@diagnostic disable-next-line: missing-fields
  cmp.register_source("coauthors", {
    name = "coauthors",
    get_keyword_pattern = function()
      return [[Co-authored-by:\s*\zs.*]]
    end,
    complete = function(_, _, callback)
      local items = {}

      for _, coauthor in ipairs(coauthors_state) do
        table.insert(items, { label = coauthor })
      end

      callback({ items = items })
    end,
  })

  -- Scan when opening commit messages, not too slow atm
  vim.api.nvim_create_autocmd("BufRead", {
    pattern = "COMMIT_EDITMSG",
    callback = function()
      scan_git_log_async(function(git_authors)
        coauthors_state = git_authors
      end)
    end,
  })
end

return M
