return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#111509',
				base01 = '#111509',
				base02 = '#878d78',
				base03 = '#878d78',
				base04 = '#dce4c9',
				base05 = '#fbfff2',
				base06 = '#fbfff2',
				base07 = '#fbfff2',
				base08 = '#ff5d3f',
				base09 = '#ff5d3f',
				base0A = '#b0ef23',
				base0B = '#5bff4c',
				base0C = '#dbff8c',
				base0D = '#b0ef23',
				base0E = '#c7ff4c',
				base0F = '#c7ff4c',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#878d78',
				fg = '#fbfff2',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#b0ef23',
				fg = '#111509',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#878d78' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#dbff8c', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#c7ff4c',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#b0ef23',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#b0ef23',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#dbff8c',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#5bff4c',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#dce4c9' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#dce4c9' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#878d78',
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
