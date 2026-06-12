return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#091516',
				base01 = '#091516',
				base02 = '#7f9596',
				base03 = '#7f9596',
				base04 = '#d5f1f2',
				base05 = '#f2feff',
				base06 = '#f2feff',
				base07 = '#f2feff',
				base08 = '#ff3f83',
				base09 = '#ff3f83',
				base0A = '#26f2fe',
				base0B = '#4cff5c',
				base0C = '#8cf9ff',
				base0D = '#26f2fe',
				base0E = '#4cf5ff',
				base0F = '#4cf5ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#7f9596',
				fg = '#f2feff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#26f2fe',
				fg = '#091516',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#7f9596' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#8cf9ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#4cf5ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#26f2fe',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#26f2fe',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#8cf9ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#4cff5c',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#d5f1f2' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#d5f1f2' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#7f9596',
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
