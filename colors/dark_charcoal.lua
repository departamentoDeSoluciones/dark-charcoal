vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "dark_charcoal"

require("dark_charcoal").setup({ transparent = true })
