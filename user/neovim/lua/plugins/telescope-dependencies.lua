-- lua/plugins/telescope-dependencies.lua

return {
	-- This is a core dependency for Telescope
	"nvim-lua/plenary.nvim",

	-- The FZF extension for Telescope
	-- Requires `fzf` and a C compiler to be installed.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	-- All the other extensions loaded in your config
	"nvim-telescope/telescope-ui-select.nvim",
	"gbprod/telescope-undo.nvim",
	"AckslD/nvim-neoclip.lua",
	"brenoprata10/telescope-live-grep-args.nvim",

	-- Note: The extensions for 'advanced_git_search' and 'noice'
	-- are part of their own plugins, which you would need to install separately
	-- if you use them. We'll leave them out for now to keep it simple.
}
