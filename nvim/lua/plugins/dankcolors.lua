return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#101418',
				base01 = '#101418',
				base02 = '#999fa5',
				base03 = '#999fa5',
				base04 = '#eff7ff',
				base05 = '#f8fbff',
				base06 = '#f8fbff',
				base07 = '#f8fbff',
				base08 = '#ff9fbc',
				base09 = '#ff9fbc',
				base0A = '#a4d3ff',
				base0B = '#a5ffb1',
				base0C = '#cee8ff',
				base0D = '#a4d3ff',
				base0E = '#b4dbff',
				base0F = '#b4dbff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#999fa5',
				fg = '#f8fbff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#a4d3ff',
				fg = '#101418',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#999fa5' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#cee8ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#b4dbff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#a4d3ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#a4d3ff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#cee8ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffb1',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#eff7ff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#eff7ff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#999fa5',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
