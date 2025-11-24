return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  tag = "0.1.5",
  -- 1. WE LIST ALL DEPENDENCIES HERE (Combined from your other file)
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "debugloop/telescope-undo.nvim",
    "folke/noice.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "AckslD/nvim-neoclip.lua",
    { 
      "nvim-telescope/telescope-fzf-native.nvim", 
      build = "make",
      cond = function() return vim.fn.executable("make") == 1 end 
    },
    "nvim-tree/nvim-web-devicons",
  },
  
  config = function()
    -- 2. SETUP VARIABLES
    local builtin = require("telescope.builtin")
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")
    local actions = require("telescope.actions")
    
    -- Fix for the crash: Require this SAFELY inside the function
    local undo_actions = require("telescope-undo.actions")

    -- 3. COMBINED KEYMAPS
    
    -- A. Kickstart Defaults (The ones from init.lua)
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
    
    -- B. Your Custom Keymaps (The ones from your file)
    vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Live Grep Args" })
    vim.keymap.set("n", "<leader>fc", '<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}"})<CR>', { desc = "Live Grep Code" })
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Search Git Commits" })
    
    -- Fuzzy search in current buffer
    vim.keymap.set("n", "<leader>/", function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
        layout_config = { width = 0.7 },
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    -- 4. CUSTOM SETTINGS (Hidden files, etc)
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
    table.insert(vimgrep_arguments, "--hidden")
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    -- 5. SETUP TELESCOPE
    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
            -- Your custom select logic
            ["<CR>"] = function(prompt_bufnr)
               local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
               local multi = picker:get_multi_selection()
               if not vim.tbl_isempty(multi) then
                 require("telescope.actions").close(prompt_bufnr)
                 for _, j in pairs(multi) do
                   if j.path ~= nil then
                     vim.cmd(string.format("%s %s", "edit", j.path))
                   end
                 end
               else
                 require("telescope.actions").select_default(prompt_bufnr)
               end
            end,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        undo = {
          use_delta = true,
          mappings = {
            i = {
              ["<C-cr>"] = undo_actions.yank_additions,
              ["<S-cr>"] = undo_actions.yank_deletions,
              ["<cr>"] = undo_actions.restore,
            },
          },
        },
      },
    })

    -- 6. LOAD EXTENSIONS SAFELY
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")
    pcall(telescope.load_extension, "neoclip")
    pcall(telescope.load_extension, "undo")
    pcall(telescope.load_extension, "live_grep_args")
    pcall(telescope.load_extension, "noice")
    -- pcall(telescope.load_extension, "advanced_git_search") -- Uncomment if installed
  end,
}
