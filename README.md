# 🌙 Dark Charcoal.nvim

A clean, high-contrast dark theme for Neovim, focused on readability and warm accents.

## 🎨 Palette

| Color | Hex | Role |
| :--- | :--- | :--- |
| **Dark Charcoal** | `#1f1f1f` | Background (bg) |
| **Warm White** | `#fdfff8` | Foreground (fg) |
| **Bright Orange** | `#ff5e1c` | Keywords |
| **Soft Blue** | `#71a6da` | Functions |
| **Muted Coral** | `#dc7476` | Strings |
| **Soft Coral** | `#ff888a` | Constants & Errors |

## 🔌 Supported Plugins

Tailored highlights for a seamless and modern Neovim workflow:

* **Core:** Treesitter, Native LSP
* **UI & Navigation:** NeoTree, Telescope, Dashboard, Bufferline, Lualine, Indent Blankline, Notify
* **Workflow & Tools:** CMP, WhichKey, Mason, GitSigns, ToggleTerm, Flash

## 🚀 Installation

**Using [lazy.nvim](https://github.com/folke/lazy.nvim):**

```lua
{
  "departamentoDeSoluciones/dark-charcoal", 
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme dark_charcoal")
  end,
}
