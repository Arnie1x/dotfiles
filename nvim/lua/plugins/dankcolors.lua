return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#131313',
				base01 = '#131313',
				base02 = '#79837a',
				base03 = '#79837a',
				base04 = '#c7d4c8',
				base05 = '#f8fff9',
				base06 = '#f8fff9',
				base07 = '#f8fff9',
				base08 = '#ffb79f',
				base09 = '#ffb79f',
				base0A = '#d2ded2',
				base0B = '#9ef29d',
				base0C = '#f7fff8',
				base0D = '#d2ded2',
				base0E = '#f3fff4',
				base0F = '#f3fff4',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#79837a',
				fg = '#f8fff9',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#d2ded2',
				fg = '#131313',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#79837a' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#f7fff8', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#f3fff4',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#d2ded2',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#d2ded2',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#f7fff8',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#9ef29d',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#c7d4c8' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#c7d4c8' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#79837a',
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
