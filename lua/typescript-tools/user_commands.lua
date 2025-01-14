local c = require "typescript-tools.protocol.constants"
local api = require "typescript-tools.api"

local M = {}

---@param name string
---@param fn function
local function create_command(name, fn)
  local command_completion = {
    nargs = "?",
    complete = function()
      return { "sync" }
    end,
  }
  vim.api.nvim_create_user_command(name, function(cmd)
    local words = cmd.fargs

    if #words == 1 and words[1] ~= "sync" then
      vim.notify("No such command", vim.log.levels.ERROR)
      return
    end

    fn(#words == 1)
  end, command_completion)
end

function M.setup_user_commands()
  create_command("TSToolsOrganizeImports", function(is_sync)
    api.organize_imports(c.OrganizeImportsMode.All, is_sync)
  end)

  create_command("TSToolsSortImports", function(is_sync)
    api.organize_imports(c.OrganizeImportsMode.SortAndCombine, is_sync)
  end)

  create_command("TSToolsRemoveUnusedImports", function(is_sync)
    api.organize_imports(c.OrganizeImportsMode.RemoveUnused, is_sync)
  end)

  create_command("TSToolsGoToSourceDefinition", function(is_sync)
    api.go_to_source_definition(is_sync)
  end)

  create_command("TSToolsRemoveUnused", function(is_sync)
    api.remove_unused(is_sync)
  end)

  create_command("TSToolsAddMissingImports", function(is_sync)
    api.add_missing_imports(is_sync)
  end)

  create_command("TSToolsFixAll", function(is_sync)
    api.fix_all(is_sync)
  end)
end

return M
