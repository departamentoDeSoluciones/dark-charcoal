local M = {}

M.palette = {
	bg = "#1f1f1f", -- Cambia este valor para oscurecer el fondo de edición
	fg = "#fdfff8",
	comment = "#7f8984",
	keyword = "#ff5e1c",
	func = "#71a6da",
	type = "#b8c3bd",
	string = "#dc7476",
	constant = "#ff888a",
	variable = "#c8ceca",
	operator = "#8b918d",
	inactive = "#5d625f",
	cursorline = "#292929",
	visual = "#2b3844",
	ghost = "#607d8b", -- Nuevo color para Inlay Hints y Copilot
	cursor = "#fdfff8",
	black = "#1f1f1f",
	white = "#fdfff8",
	error = "#ff888a",
	warning = "#ff5e1c",
	info = "#71a6da",
	hint = "#b8c3bd",
	diff_add = "#b8c3bd",
	diff_change = "#71a6da",
	diff_delete = "#dc7476",
	diff_text = "#ff5e1c",
}

M.config = {
	transparent = false,
	italic_comments = true,
	italic_keywords = false,
	bold_functions = false,
	italic_ghost_text = true,
}

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

local theme_group = vim.api.nvim_create_augroup("DarkCharcoalThemeAutocmds", { clear = true })

vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter" }, {
	group = theme_group,
	callback = function(args)
		if vim.bo[args.buf].buftype ~= "terminal" then
			return
		end

		local win = vim.api.nvim_get_current_win()

		if vim.api.nvim_win_get_buf(win) ~= args.buf then
			return
		end

		vim.wo[win].winhighlight = table.concat({
			"Normal:TermNormal",
			"NormalNC:TermNormalNC",
			"NormalFloat:TermNormal",
			"FloatBorder:TermBorder",
			"SignColumn:TermNormal",
			"EndOfBuffer:TermNormal",
		}, ",")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
	group = theme_group,
	callback = function(args)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end

		local win = vim.api.nvim_get_current_win()
		vim.wo[win].winhighlight =
			"Normal:SolidEditor,NormalNC:SolidEditor,SignColumn:SolidEditor,EndOfBuffer:SolidEditor"
	end,
})

function M.setup(user_config)
	M.config = vim.tbl_extend("force", M.config, user_config or {})
	local p = M.palette
	local c = M.config

	hl("Normal", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("NormalNC", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("SolidEditor", { fg = p.fg, bg = p.bg })

	hl("NormalFloat", { fg = p.fg, bg = c.transparent and "NONE" or p.cursorline })
	hl("FloatBorder", { fg = p.inactive, bg = c.transparent and "NONE" or p.cursorline })
	hl("Cursor", { fg = p.bg, bg = p.cursor })
	hl("CursorLine", { bg = p.cursorline })
	hl("CursorColumn", { bg = p.cursorline })
	hl("ColorColumn", { bg = p.cursorline })
	hl("LineNr", { fg = p.inactive })
	hl("CursorLineNr", { fg = p.keyword, bold = true })
	hl("SignColumn", { bg = c.transparent and "NONE" or p.bg })
	hl("FoldColumn", { fg = p.inactive })
	hl("Folded", { fg = p.comment, bg = p.cursorline })
	hl("VertSplit", { fg = p.cursorline })
	hl("WinSeparator", { fg = p.cursorline })
	hl("StatusLine", { fg = p.fg, bg = p.cursorline })
	hl("StatusLineNC", { fg = p.inactive, bg = p.cursorline })
	hl("TabLine", { fg = p.inactive, bg = p.cursorline })
	hl("TabLineFill", { bg = p.cursorline })
	hl("TabLineSel", { fg = p.fg, bg = p.bg, bold = true })
	hl("Pmenu", { fg = p.fg, bg = p.cursorline })
	hl("PmenuSel", { fg = p.fg, bg = p.visual })
	hl("PmenuSbar", { bg = p.cursorline })
	hl("PmenuThumb", { bg = p.inactive })
	hl("WildMenu", { fg = p.bg, bg = p.keyword })
	hl("Search", { fg = p.bg, bg = p.keyword })
	hl("IncSearch", { fg = p.bg, bg = p.constant })
	hl("CurSearch", { fg = p.bg, bg = p.constant })
	hl("Substitute", { fg = p.bg, bg = p.string })
	hl("MatchParen", { fg = p.keyword, bold = true })
	hl("Visual", { bg = p.visual })
	hl("VisualNOS", { bg = p.visual })
	hl("Conceal", { fg = p.inactive })
	hl("Whitespace", { fg = p.cursorline })
	hl("EndOfBuffer", { fg = p.cursorline })
	hl("NonText", { fg = p.cursorline })
	hl("SpecialKey", { fg = p.inactive })
	hl("Title", { fg = p.func, bold = true })
	hl("Question", { fg = p.string })
	hl("MoreMsg", { fg = p.string })
	hl("ModeMsg", { fg = p.fg })
	hl("MsgArea", { fg = p.fg })
	hl("MsgSeparator", { fg = p.cursorline })
	hl("WarningMsg", { fg = p.warning })
	hl("ErrorMsg", { fg = p.error, bold = true })
	hl("Directory", { fg = p.func })

	hl("Comment", { fg = p.comment, italic = c.italic_comments })
	hl("Constant", { fg = p.constant })
	hl("String", { fg = p.string })
	hl("Character", { fg = p.string })
	hl("Number", { fg = p.constant })
	hl("Boolean", { fg = p.constant })
	hl("Float", { fg = p.constant })
	hl("Identifier", { fg = p.variable })
	hl("Function", { fg = p.func, bold = c.bold_functions })
	hl("Statement", { fg = p.keyword, italic = c.italic_keywords })
	hl("Conditional", { fg = p.keyword })
	hl("Repeat", { fg = p.keyword })
	hl("Label", { fg = p.keyword })
	hl("Operator", { fg = p.operator })
	hl("Keyword", { fg = p.keyword, italic = c.italic_keywords })
	hl("Exception", { fg = p.keyword })
	hl("PreProc", { fg = p.type })
	hl("Include", { fg = p.keyword })
	hl("Define", { fg = p.keyword })
	hl("Macro", { fg = p.keyword })
	hl("PreCondit", { fg = p.keyword })
	hl("Type", { fg = p.type })
	hl("StorageClass", { fg = p.keyword })
	hl("Structure", { fg = p.type })
	hl("Typedef", { fg = p.type })
	hl("Special", { fg = p.func })
	hl("SpecialChar", { fg = p.constant })
	hl("Tag", { fg = p.keyword })
	hl("Delimiter", { fg = p.operator })
	hl("SpecialComment", { fg = p.comment, bold = true })
	hl("Debug", { fg = p.warning })
	hl("Underlined", { fg = p.func, underline = true })
	hl("Ignore", { fg = p.inactive })
	hl("Error", { fg = p.error, undercurl = true, sp = p.error })
	hl("Todo", { fg = p.bg, bg = p.keyword, bold = true })

	hl("@variable", { fg = p.variable })
	hl("@variable.builtin", { fg = p.constant })
	hl("@variable.parameter", { fg = p.variable })
	hl("@variable.member", { fg = p.variable })
	hl("@constant", { fg = p.constant })
	hl("@constant.builtin", { fg = p.constant })
	hl("@constant.macro", { fg = p.constant })
	hl("@module", { fg = p.type })
	hl("@module.builtin", { fg = p.type })
	hl("@label", { fg = p.keyword })
	hl("@string", { fg = p.string })
	hl("@string.documentation", { fg = p.comment })
	hl("@string.regexp", { fg = p.constant })
	hl("@string.escape", { fg = p.constant })
	hl("@string.special", { fg = p.constant })
	hl("@string.special.symbol", { fg = p.constant })
	hl("@string.special.url", { fg = p.func, underline = true })
	hl("@character", { fg = p.string })
	hl("@character.special", { fg = p.constant })
	hl("@boolean", { fg = p.constant })
	hl("@number", { fg = p.constant })
	hl("@number.float", { fg = p.constant })
	hl("@type", { fg = p.type })
	hl("@type.builtin", { fg = p.type })
	hl("@type.definition", { fg = p.type })
	hl("@attribute", { fg = p.keyword })
	hl("@attribute.builtin", { fg = p.keyword })
	hl("@property", { fg = p.variable })
	hl("@function", { fg = p.func })
	hl("@function.builtin", { fg = p.func })
	hl("@function.call", { fg = p.func })
	hl("@function.macro", { fg = p.keyword })
	hl("@function.method", { fg = p.func })
	hl("@function.method.call", { fg = p.func })
	hl("@constructor", { fg = p.type })
	hl("@operator", { fg = p.operator })
	hl("@keyword", { fg = p.keyword })
	hl("@keyword.coroutine", { fg = p.keyword, italic = true })
	hl("@keyword.function", { fg = p.keyword, italic = true })
	hl("@keyword.operator", { fg = p.keyword })
	hl("@keyword.import", { fg = p.keyword, italic = true })
	hl("@keyword.type", { fg = p.keyword })
	hl("@keyword.modifier", { fg = p.keyword, italic = true })
	hl("@keyword.repeat", { fg = p.keyword, italic = true })
	hl("@keyword.return", { fg = p.keyword, italic = true })
	hl("@keyword.debug", { fg = p.keyword })
	hl("@keyword.exception", { fg = p.keyword, italic = true })
	hl("@keyword.conditional", { fg = p.keyword, italic = true })
	hl("@keyword.conditional.ternary", { fg = p.keyword, italic = true })
	hl("@keyword.directive", { fg = p.keyword })
	hl("@keyword.directive.define", { fg = p.keyword })

	hl("@punctuation.delimiter", { fg = p.operator })
	hl("@punctuation.bracket", { fg = p.operator })
	hl("@punctuation.special", { fg = p.operator })
	hl("@comment", { fg = p.comment, italic = c.italic_comments })
	hl("@comment.documentation", { fg = p.comment, italic = c.italic_comments })
	hl("@comment.error", { fg = p.error })
	hl("@comment.warning", { fg = p.warning })
	hl("@comment.todo", { fg = p.keyword })
	hl("@comment.note", { fg = p.func })
	hl("@tag", { fg = p.keyword })
	hl("@tag.builtin", { fg = p.keyword })
	hl("@tag.attribute", { fg = p.type })
	hl("@tag.delimiter", { fg = p.operator })

	hl("DiagnosticError", { fg = p.error })
	hl("DiagnosticWarn", { fg = p.warning })
	hl("DiagnosticInfo", { fg = p.info })
	hl("DiagnosticHint", { fg = p.hint })
	hl("DiagnosticOk", { fg = p.type })
	hl("DiagnosticVirtualTextError", { fg = p.error, bg = c.transparent and "NONE" or p.cursorline })
	hl("DiagnosticVirtualTextWarn", { fg = p.warning, bg = c.transparent and "NONE" or p.cursorline })
	hl("DiagnosticVirtualTextInfo", { fg = p.info, bg = c.transparent and "NONE" or p.cursorline })
	hl("DiagnosticVirtualTextHint", { fg = p.hint, bg = c.transparent and "NONE" or p.cursorline })
	hl("DiagnosticUnderlineError", { undercurl = true, sp = p.error })
	hl("DiagnosticUnderlineWarn", { undercurl = true, sp = p.warning })
	hl("DiagnosticUnderlineInfo", { undercurl = true, sp = p.info })
	hl("DiagnosticUnderlineHint", { undercurl = true, sp = p.hint })
	hl("DiagnosticSignError", { fg = p.error })
	hl("DiagnosticSignWarn", { fg = p.warning })
	hl("DiagnosticSignInfo", { fg = p.info })
	hl("DiagnosticSignHint", { fg = p.hint })
	hl("DiagnosticFloatingError", { fg = p.error })
	hl("DiagnosticFloatingWarn", { fg = p.warning })
	hl("DiagnosticFloatingInfo", { fg = p.info })
	hl("DiagnosticFloatingHint", { fg = p.hint })

	hl("@lsp.type.class", { fg = p.type })
	hl("@lsp.type.comment", { fg = p.comment, italic = c.italic_comments })
	hl("@lsp.type.decorator", { fg = p.keyword })
	hl("@lsp.type.enum", { fg = p.type })
	hl("@lsp.type.enumMember", { fg = p.constant })
	hl("@lsp.type.event", { fg = p.keyword })
	hl("@lsp.type.function", { fg = p.func })
	hl("@lsp.type.interface", { fg = p.type })
	hl("@lsp.type.keyword", { fg = p.keyword })
	hl("@lsp.type.macro", { fg = p.keyword })
	hl("@lsp.type.method", { fg = p.func })
	hl("@lsp.type.modifier", { fg = p.keyword })
	hl("@lsp.type.namespace", { fg = p.type })
	hl("@lsp.type.number", { fg = p.constant })
	hl("@lsp.type.operator", { fg = p.operator })
	hl("@lsp.type.parameter", { fg = p.variable })
	hl("@lsp.type.property", { fg = p.variable })
	hl("@lsp.type.regexp", { fg = p.constant })
	hl("@lsp.type.string", { fg = p.string })
	hl("@lsp.type.struct", { fg = p.type })
	hl("@lsp.type.type", { fg = p.type })
	hl("@lsp.type.typeParameter", { fg = p.type })
	hl("@lsp.type.variable", { fg = p.variable })
	hl("LspInlayHint", { fg = p.ghost, italic = true })
	hl("CopilotSuggestion", { fg = p.ghost, italic = true })

	hl("DiffAdd", { fg = p.diff_add, bg = p.cursorline })
	hl("DiffAdd", { fg = p.diff_add, bg = p.cursorline })
	hl("DiffChange", { fg = p.diff_change, bg = p.cursorline })
	hl("DiffDelete", { fg = p.diff_delete, bg = p.cursorline })
	hl("DiffText", { fg = p.diff_text, bg = p.cursorline })
	hl("Added", { fg = p.diff_add })
	hl("Changed", { fg = p.diff_change })
	hl("Removed", { fg = p.diff_delete })
	hl("GitSignsAdd", { fg = p.diff_add })
	hl("GitSignsChange", { fg = p.diff_change })
	hl("GitSignsDelete", { fg = p.diff_delete })

	hl("TelescopeNormal", { fg = p.fg, bg = c.transparent and "NONE" or p.cursorline })
	hl("TelescopeBorder", { fg = p.inactive, bg = c.transparent and "NONE" or p.cursorline })
	hl("TelescopePromptNormal", { fg = p.fg, bg = c.transparent and "NONE" or p.cursorline })
	hl("TelescopePromptBorder", { fg = p.inactive, bg = c.transparent and "NONE" or p.cursorline })
	hl("TelescopePromptTitle", { fg = p.bg, bg = p.keyword })
	hl("TelescopePreviewTitle", { fg = p.bg, bg = p.func })
	hl("TelescopeResultsTitle", { fg = p.bg, bg = p.type })
	hl("TelescopeSelection", { bg = p.visual })
	hl("TelescopeSelectionCaret", { fg = p.keyword })
	hl("TelescopeMatching", { fg = p.keyword, bold = true })

	hl("WhichKey", { fg = p.keyword })
	hl("WhichKeyGroup", { fg = p.func })
	hl("WhichKeyDesc", { fg = p.fg })
	hl("WhichKeySeparator", { fg = p.inactive })
	hl("WhichKeyValue", { fg = p.constant })

	hl("NeoTreeNormal", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("NeoTreeNormalNC", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("NeoTreeEndOfBuffer", { fg = p.bg, bg = c.transparent and "NONE" or p.bg })
	hl("NeoTreeWinSeparator", { fg = p.cursorline, bg = c.transparent and "NONE" or p.bg })
	hl("NeoTreeRootName", { fg = p.keyword, bold = true })
	hl("NeoTreeDirectoryName", { fg = p.func })
	hl("NeoTreeDirectoryIcon", { fg = p.func })
	hl("NeoTreeFileName", { fg = p.fg })
	hl("NeoTreeFileIcon", { fg = p.type })
	hl("NeoTreeGitAdded", { fg = p.diff_add })
	hl("NeoTreeGitModified", { fg = p.diff_change })
	hl("NeoTreeGitDeleted", { fg = p.diff_delete })

	hl("NvimTreeNormal", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("NvimTreeNormalNC", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("NvimTreeEndOfBuffer", { fg = p.inactive, bg = c.transparent and "NONE" or p.bg })
	hl("NvimTreeWinSeparator", { fg = p.cursorline, bg = c.transparent and "NONE" or p.bg })
	hl("IblIndent", { fg = p.cursorline })
	hl("IblScope", { fg = p.inactive })
	hl("IblWhitespace", { fg = p.cursorline })

	hl("CmpItemAbbr", { fg = p.fg })
	hl("CmpItemAbbrDeprecated", { fg = p.inactive, strikethrough = true })
	hl("CmpItemAbbrMatch", { fg = p.keyword, bold = true })
	hl("CmpItemAbbrMatchFuzzy", { fg = p.keyword, bold = true })
	hl("CmpItemKind", { fg = p.type })
	hl("CmpItemKindClass", { fg = p.type })
	hl("CmpItemKindColor", { fg = p.constant })
	hl("CmpItemKindConstant", { fg = p.constant })
	hl("CmpItemKindConstructor", { fg = p.type })
	hl("CmpItemKindEnum", { fg = p.type })
	hl("CmpItemKindEnumMember", { fg = p.constant })
	hl("CmpItemKindEvent", { fg = p.keyword })
	hl("CmpItemKindField", { fg = p.variable })
	hl("CmpItemKindFile", { fg = p.func })
	hl("CmpItemKindFolder", { fg = p.func })
	hl("CmpItemKindFunction", { fg = p.func })
	hl("CmpItemKindInterface", { fg = p.type })
	hl("CmpItemKindKeyword", { fg = p.keyword })
	hl("CmpItemKindMethod", { fg = p.func })
	hl("CmpItemKindModule", { fg = p.type })
	hl("CmpItemKindOperator", { fg = p.operator })
	hl("CmpItemKindProperty", { fg = p.variable })
	hl("CmpItemKindReference", { fg = p.variable })
	hl("CmpItemKindSnippet", { fg = p.string })
	hl("CmpItemKindStruct", { fg = p.type })
	hl("CmpItemKindText", { fg = p.fg })
	hl("CmpItemKindTypeParameter", { fg = p.type })
	hl("CmpItemKindUnit", { fg = p.constant })
	hl("CmpItemKindValue", { fg = p.constant })
	hl("CmpItemKindVariable", { fg = p.variable })
	hl("CmpItemMenu", { fg = p.comment })

	hl("MasonNormal", { fg = p.fg, bg = c.transparent and "NONE" or p.cursorline })
	hl("MasonHeader", { fg = p.bg, bg = p.keyword })
	hl("MasonHighlight", { fg = p.keyword })
	hl("MasonHighlightBlock", { fg = p.bg, bg = p.keyword })

	hl("NotifyERRORBorder", { fg = p.error })
	hl("NotifyWARNBorder", { fg = p.warning })
	hl("NotifyINFOBorder", { fg = p.info })
	hl("NotifyDEBUGBorder", { fg = p.inactive })
	hl("NotifyTRACEBorder", { fg = p.type })
	hl("NotifyERRORIcon", { fg = p.error })
	hl("NotifyWARNIcon", { fg = p.warning })
	hl("NotifyINFOIcon", { fg = p.info })
	hl("NotifyDEBUGIcon", { fg = p.inactive })
	hl("NotifyTRACEIcon", { fg = p.type })
	hl("NotifyERRORTitle", { fg = p.error })
	hl("NotifyWARNTitle", { fg = p.warning })
	hl("NotifyINFOTitle", { fg = p.info })
	hl("NotifyDEBUGTitle", { fg = p.inactive })
	hl("NotifyTRACETitle", { fg = p.type })

	hl("DashboardHeader", { fg = p.keyword })
	hl("DashboardFooter", { fg = p.comment })
	hl("DashboardCenter", { fg = p.fg })
	hl("DashboardShortcut", { fg = p.func })
	hl("DashboardIcon", { fg = p.type })

	hl("NoiceCmdline", { fg = p.fg, bg = c.transparent and "NONE" or p.cursorline })
	hl("NoiceCmdlineIcon", { fg = p.keyword })
	hl("NoiceCmdlinePopupBorder", { fg = p.inactive })
	hl("NoiceConfirmBorder", { fg = p.func })

	hl("LazyNormal", { fg = p.fg, bg = c.transparent and "NONE" or p.cursorline })
	hl("LazyH1", { fg = p.bg, bg = p.keyword })
	hl("LazyButton", { fg = p.fg, bg = p.cursorline })
	hl("LazyButtonActive", { fg = p.bg, bg = p.func })
	hl("LazyCommit", { fg = p.string })
	hl("LazyCommitType", { fg = p.type })
	hl("LazyProgressDone", { fg = p.func })
	hl("LazyProgressTodo", { fg = p.inactive })

	hl("HopNextKey", { fg = p.keyword, bold = true })
	hl("HopNextKey1", { fg = p.keyword, bold = true })
	hl("HopNextKey2", { fg = p.func })
	hl("LeapMatch", { fg = p.bg, bg = p.keyword })
	hl("LeapLabelPrimary", { fg = p.bg, bg = p.keyword })
	hl("LeapLabelSecondary", { fg = p.bg, bg = p.func })
	hl("FlashMatch", { fg = p.bg, bg = p.func })
	hl("FlashCurrent", { fg = p.bg, bg = p.keyword })
	hl("FlashLabel", { fg = p.bg, bg = p.constant })

	hl("BufferLineFill", { bg = p.cursorline })
	hl("BufferLineBackground", { fg = p.inactive, bg = p.cursorline })
	hl("BufferLineBufferVisible", { fg = p.inactive, bg = p.cursorline })
	hl("BufferLineBufferSelected", { fg = p.fg, bg = p.bg, bold = true, italic = false })
	hl("BufferLineTab", { fg = p.inactive, bg = p.cursorline })
	hl("BufferLineTabSelected", { fg = p.fg, bg = p.bg })
	hl("BufferLineTabClose", { fg = p.error })
	hl("BufferLineIndicatorSelected", { fg = p.keyword })
	hl("BufferLineSeparator", { fg = p.cursorline, bg = p.cursorline })
	hl("BufferLineSeparatorSelected", { fg = p.cursorline, bg = p.bg })
	hl("BufferLineCloseButton", { fg = p.inactive })
	hl("BufferLineCloseButtonSelected", { fg = p.error })
	hl("BufferLineModified", { fg = p.warning })
	hl("BufferLineModifiedSelected", { fg = p.warning })
	hl("BufferLineDuplicate", { fg = p.inactive })
	hl("BufferLinePick", { fg = p.keyword, bold = true })
	hl("BufferLinePickSelected", { fg = p.keyword, bold = true })

	hl("lualine_a_normal", { fg = p.bg, bg = p.keyword })
	hl("lualine_a_insert", { fg = p.bg, bg = p.func })
	hl("lualine_a_visual", { fg = p.bg, bg = p.type })
	hl("lualine_a_replace", { fg = p.bg, bg = p.string })
	hl("lualine_a_command", { fg = p.bg, bg = p.constant })
	hl("lualine_a_terminal", { fg = p.bg, bg = p.warning })
	hl("lualine_a_inactive", { fg = p.inactive, bg = p.cursorline })
	hl("lualine_b_normal", { fg = p.fg, bg = p.cursorline })
	hl("lualine_c_normal", { fg = p.fg, bg = c.transparent and "NONE" or p.cursorline })

	hl("IlluminatedWordText", { bg = p.visual })
	hl("IlluminatedWordRead", { bg = p.visual })
	hl("IlluminatedWordWrite", { bg = p.visual })
	hl("LspReferenceText", { bg = p.visual })
	hl("LspReferenceRead", { bg = p.visual })
	hl("LspReferenceWrite", { bg = p.visual })

	hl("SpellBad", { undercurl = true, sp = p.error })
	hl("SpellCap", { undercurl = true, sp = p.warning })
	hl("SpellLocal", { undercurl = true, sp = p.info })
	hl("SpellRare", { undercurl = true, sp = p.type })

	hl("TermNormal", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("TermNormalNC", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("TermBorder", { fg = p.inactive, bg = c.transparent and "NONE" or p.bg })
	hl("ToggleTermNormal", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("ToggleTermFloat", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("ToggleTermBorder", { fg = p.inactive, bg = c.transparent and "NONE" or p.bg })

	hl("TroubleNormal", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("TroubleNormalNC", { fg = p.fg, bg = c.transparent and "NONE" or p.bg })
	hl("TroubleCount", { fg = p.constant, bg = c.transparent and "NONE" or p.bg })
	hl("TroubleIndent", { fg = p.cursorline, bg = c.transparent and "NONE" or p.bg })

	vim.g.terminal_color_0 = p.bg
	vim.g.terminal_color_1 = p.error
	vim.g.terminal_color_2 = p.type
	vim.g.terminal_color_3 = p.warning
	vim.g.terminal_color_4 = p.func
	vim.g.terminal_color_5 = p.string
	vim.g.terminal_color_6 = p.info
	vim.g.terminal_color_7 = p.fg
	vim.g.terminal_color_8 = p.inactive
	vim.g.terminal_color_9 = p.error
	vim.g.terminal_color_10 = p.type
	vim.g.terminal_color_11 = p.warning
	vim.g.terminal_color_12 = p.func
	vim.g.terminal_color_13 = p.string
	vim.g.terminal_color_14 = p.info
	vim.g.terminal_color_15 = p.fg
end

return M
