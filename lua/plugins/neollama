return {
	"paradoxical-dev/neollama",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("neollama").setup({
			autoscroll = true,
			hide_cursor = true, -- Decides if cursor will be hidden in menu windows
			max_chats = 10, -- Maximum number of persistent sessions
			hide_pasted_text = true, -- Appended visual selection will be hidden from chat window if set to true
			local_port = "http://localhost:11434/api", -- Endpoint must include /api not just the port
			model_paramaters = {
				temperature = 0.7,
				top_k = 40,
				top_p = 0.9,
				-- Add other required parameters here
			},
			params = {
				model = "gemma4", -- Must be changed If llama3.1 is not available
				stream = true,
				default_options = { -- If a default setting is not explicitly set the models default will be used instead
					mirostat = 0,
					mirostat_eta = 0.1,
					mirostat_tau = 5.0,
					num_ctx = 2048,
					repeat_last_n = 64,
					repeat_penalty = 1.1,
					temperature = 0.8,
					seed = 0,
					tfs_z = 1.0,
					num_predict = 128,
					top_k = 40,
					top_p = 40,
				},
				extra_opts = {
					-- Visit https://github.com/ollama/ollama/blob/main/docs/api.md for example values
					num_keep = "",
					typical_p = "",
					presence_penalty = "",
					frequency_penalty = "",
					penalize_newline = "",
					numa = "",
					num_batch = "",
					num_gpu = "",
				},
			},
			web_agent = { -- See `Web Agent` section for more details
				enabled = true, -- Default option for new sessions
				manual = false,
				include_sources = true, -- Append sources or queries to chat response
				include_queries = true,
				spinner_hl = { link = "Comment" },
				-- User-Agent header to simulate browser
				user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36",
				timeout = 15,
				content_limit = 4000, -- Word count limit for scraped content
				retry_count = 3, -- Attempts to retry a single URL before continuing
				agent_models = { -- Customize the helper agents
					use_current = true, -- If true then the below config will be ignored
					buffer_agent = { model = "llama3.2" },
					reviewing_agent = {
						model = "llama3.2",
						options = {
							num_ctx = 4096,
							temperature = 0.2,
							top_p = 0.1,
						},
					},
					integration_agent = {
						model = "llama3.2",
						options = {
							num_ctx = 4096,
						},
					},
				},
			},
			layout = {
				border = {
					default = "rounded", -- single|double|rounded|solid
				},
				size = {
					width = "70%", -- Size and position can be percent string or integer
					height = "80%",
				},
				position = "50%",
				hl = {
					title = { link = "Comment" },
					default_border = { link = "FloatBorder" },
				},
				popup = {
					hl = {
						user_header = { link = "Keyword" },
						model_header = { link = "Function" },
						virtual_text = { link = "Conditional" },
					},
					virtual_text = { "╒", "│", "╘" }, -- The text which encapsulates the model response
				},
				input = {
					icon = ">",
					hl = { link = "Comment" }, -- Controls the highlight given to the user input in the main chat window
				},
				model_picker = {
					icon = "",
					hl = { link = "Keyword" },
				},
				session_picker = {
					default_icon = "󰄰 ",
					current_icon = "󰄴 ",
					current_hl = { link = "Keyword" },
					default_hl = { link = "Comment" },
				},
			},
			keymaps = {
				-- These keymaps will only be applied when within neollama session and will be reverted when the session is hidden or closed
				toggle_layout = "<leader>ct",
				window_next = "}",
				window_prev = "{",
				change_config = "<leader>cs",
			},
		})
		-- Initialization keymaps will be set externally
		vim.api.nvim_set_keymap(
			"n",
			"<leader>nc",
			'<cmd>lua require("neollama").initialize()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"v",
			"<leader>c",
			'<cmd>lua require("neollama").initialize()<CR>',
			{ noremap = true, silent = true }
		)
	end,
}
