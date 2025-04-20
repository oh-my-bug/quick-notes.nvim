# quick-notes.nvim

Quick Notes is a Neovim plugin for effortlessly capturing notes tied to your current project.

## How It Works

This plugin generates a Markdown file for every open project and ensures your changes are preserved.

Here is my tipical use case:
- open project
- open Quick Notes window (I use <leader>n keymap as short for "Note")
- modify note's content
- close Quick Notes window (your changes will be saved right before close)

I use it for a TODO list, ideas, questions, etc. It helps me maintain focus and captures key information for later review or processing.

# Installation

## [Lazy](https://lazy.folke.io/)

```lua
{
    "oh-my-bug/quick-notes.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local quick_notes = require("quick-notes")
      quick_notes.setup()
      vim.keymap.set("n", "<leader>n", quick_notes.toggle, {})
    end,
}
```

## Config

Setup function accepts optional config to customize plugin behaviour.

Config example with all available params:
```lua
{
  notes_dir = "/Users/oh-my-bug/Documents/project-notes/",
  name = "Custom Name"
}
```

- **notes_dir** - specifies directory where to store Markdown files with notes.\
  By default plugin saves your notes in Neovim's data folder
- **name** - used to customize visible file name for Quick Notes window.\
  Note: actual file name to store your notes is generated based on project directory name
