-- In file: lua/plugins/neo-tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Set a global keymap to toggle Neo-tree. This works from any normal window.
    -- This handles your "Space e" request.
    vim.keymap.set("n", "<Space>e", "<cmd>Neotree toggle<CR>", {
      desc = "Explorer: Toggle Neo-tree",
    })

    require("neo-tree").setup({
      -- All your general Neo-tree settings go here.
      -- For example, to make it close when you open a file:
      close_if_last_window = true,

      -- This is the section where we define the keymaps for the Neo-tree window itself.
      default_mappings = {
        -- The key is the button you press, the value is the command Neo-tree runs.
        ["<CR>"] = "open",
        ["l"] = "open", -- Map 'l' to do the same thing as Enter
        ["h"] = "close_node",
        ["a"] = "add", -- This will prompt you to add a file or a directory
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_path", -- Copies the relative path of the file/folder
        ["q"] = "close_window",
        ["/"] = "fuzzy_find",

        -- You can also disable default keymaps you don't want by setting them to false.
        ["<space>"] = false, -- Disables the default mapping for spacebar
        ["P"] = false, -- Disables the default mapping for previewing a file
      },
    })
  end,
}
