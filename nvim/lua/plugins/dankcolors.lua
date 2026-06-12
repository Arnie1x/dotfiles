return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#1e100f',
				base01 = '#1e100f',
				base02 = '#a59999',
				base03 = '#a59999',
				base04 = '#fff0ef',
				base05 = '#fff8f8',
				base06 = '#fff8f8',
				base07 = '#fff8f8',
				base08 = '#ff9f9f',
				base09 = '#ff9f9f',
				base0A = '#ffbebb',
				base0B = '#b8ffa5',
				base0C = '#ffdcdb',
				base0D = '#ffbebb',
				base0E = '#ffc9c7',
				base0F = '#ffc9c7',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#a59999',
				fg = '#fff8f8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#ffbebb',
				fg = '#1e100f',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#a59999' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffdcdb', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffc9c7',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#ffbebb',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#ffbebb',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffdcdb',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#b8ffa5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#fff0ef' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#fff0ef' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#a59999',
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
