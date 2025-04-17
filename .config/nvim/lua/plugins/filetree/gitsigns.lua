return {
	"lewis6991/gitsigns.nvim",
	lazy = true,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = true,
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "-" },
			topdelete = { text = "↑" },
			changedelete = { text = "·" },
		},
		signs_staged = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "-" },
			topdelete = { text = "↑" },
			changedelete = { text = "·" },
		},
	},
}
