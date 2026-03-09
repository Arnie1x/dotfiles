return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#1e100e',
				base01 = '#1e100e',
				base02 = '#a598a3',
				base03 = '#a598a3',
				base04 = '#ffeffd',
				base05 = '#fff8fe',
				base06 = '#fff8fe',
				base07 = '#fff8fe',
				base08 = '#ff9fa9',
				base09 = '#ff9fa9',
				base0A = '#ffb8f6',
				base0B = '#c1ffa5',
				base0C = '#ffd9fa',
				base0D = '#ffb8f6',
				base0E = '#ffc4f7',
				base0F = '#ffc4f7',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#a598a3',
				fg = '#fff8fe',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#ffb8f6',
				fg = '#1e100e',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#a598a3' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffd9fa', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffc4f7',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#ffb8f6',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#ffb8f6',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffd9fa',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#c1ffa5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#ffeffd' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#ffeffd' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#a598a3',
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
