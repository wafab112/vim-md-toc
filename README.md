# Markdown Table of Contents vim-plugin
## Install
Copy or link the `mdtoc.vim`-file into the `autoload`-directory.
Then in your `vimrc` call the `mdtoc#load()`-function:
```vim
call mdtoc#load()
```

## Usage
Upon typing `:MdToc`-command, a quickfix-window opens with all the headings
in your current markdown-file.
When pressing `<CR>` you jump to that heading.
