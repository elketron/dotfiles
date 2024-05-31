return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<leader>hc", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for i = 1, 5, 1 do
      vim.keymap.set("n", "<leader>" .. i, function()
        harpoon:list():select(i)
      end)
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>hp", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<leader>hn", function()
      harpoon:list():next()
    end)

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set("n", "<leader>ha", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })
  end,
}
