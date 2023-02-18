local dap = require("nvim-dap")

dap.adapters.coreclr = {
    type = 'executable',
    command = '/path/to/dotnet/netcoredbg/netcoredbg',
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    },
}

-- virtual-text
require("nvim-dap-virtual-text").setup()

-- ui
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

require("dapui").setup()

-- keymaps
