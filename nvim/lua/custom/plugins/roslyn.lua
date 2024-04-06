local on_attach = function(client, bufnr)
  local map = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('<leader>cc', vim.lsp.buf.code_action, '[C]ode [A]ction')

  map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  map('gD', vim.lsp.buf.type_definition, 'Type [D]efinition')

  local telescope_builtin = require('lazy-require').require_on_exported_call 'telescope.builtin'
  map('gr', telescope_builtin.lsp_references, '[G]o to [R]eferences')
  map('gi', telescope_builtin.lsp_implementations, '[G]o to [I]mplementations')

  map('<leader>ds', telescope_builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  map('<leader>ws', telescope_builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  map('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  -- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  -- map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  -- map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  -- map("<leader>wl", function()
  -- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, "[W]orkspace [L]ist Folders")

  -- we want to use the null-ls formatter, so disable the built-in one
  -- local disable_formatting = { "pyright", "sumneko_lua" }
  -- if vim.tbl_contains(disable_formatting, client.name) then
  --     client.server_capabilities.documentFormattingProvider = false
  -- end

  if client.server_capabilities.documentFormattingProvider then
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format, { desc = 'Format current buffer with LSP' })

    map('<leader>fm', vim.lsp.buf.format, 'Format buffer')
  end

  -- -- CodeLens
  -- local libpl_codelens = require("lazy-require").require_on_exported_call("libpl.codelens")
  -- map("<leader>cl", libpl_codelens.run, "Run [C]ode[L]ens")
  -- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  -- 	buffer = bufnr,
  -- 	callback = function(opts)
  -- 		libpl_codelens.refresh(opts.buf)
  -- 	end,
  -- })
end
return {
  {
    'pmd-coutinho/roslyn.nvim',
    dependencies = {
      'tjdevries/lazy-require.nvim',
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      require('roslyn').setup {
        dotnet_cmd = 'dotnet', -- this is the default
        roslyn_version = '4.8.0-3.23475.7', -- this is the default
        on_attach = on_attach, -- required
        capabilities = capabilities, -- required
        roslyn_lsp_dll_path = '/Users/pedrocoutinho/repos/dotfiles/lsp/Microsoft.CodeAnalysis.LanguageServer.dll', -- required
      }
    end,
  },
}
