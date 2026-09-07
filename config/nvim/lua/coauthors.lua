local M = {}

local coauthors = {}

local function scan_git_log_async()
  vim.system({
    "sh",
    "-c",
    "git log --pretty=short | git shortlog -nes | cut -f 2",
  }, { text = true }, function(out)
    if out.code ~= 0 then
      vim.schedule(function()
        vim.notify(
          "[coauthors] Git shortlog error: " .. out.stderr,
          vim.log.levels.ERROR
        )
      end)
      return
    end

    local authors = {}
    for line in out.stdout:gmatch("[^\r\n]+") do
      authors[line] = true
    end

    coauthors = vim.tbl_keys(authors)
    table.sort(coauthors)
  end)
end

function M.complete(findstart, base)
  local line = vim.api.nvim_get_current_line()
  local _, prefix_end = line:find("^Co%-authored%-by:%s*")

  if findstart == 1 then
    return prefix_end or vim.fn.col(".") - 1
  end

  if not prefix_end then
    return {}
  end

  local items = {}
  for _, author in ipairs(coauthors) do
    if author:lower():find(base:lower(), 1, true) then
      table.insert(items, { word = author })
    end
  end
  return items
end

function M.attach()
  vim.bo.omnifunc = "v:lua.require'coauthors'.complete"
  scan_git_log_async()
end

return M
