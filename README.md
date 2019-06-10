> **WARNING!** This repository is no longer maintained.

# Maximum Awesome Squared

> Config files for vim and tmux, lovingly tended by a small subculture of
> peace-loving hippies. Built for Mac OS X

This is a fork of the awesome [square/maximum-awesome](https://github.com/square/maximum-awesome) repo. I added the following some plugins, settings and themes, which suits more my preferences. It's a bit more opiniated than the original (although keeping it lightweight), but I think would be great for Vim beginners (like me).
You can add () any additional vim plugins by adding the git repository info in the ```.gitmodules``` file.

----

## Planned for the future
* Full Ubuntu/Debian support
* Better installation experience in both platforms

## What it looks like?

![Maximum Awesome Squared animation](http://i.imgur.com/GUUm9q0.gif)

## What's in it?

### Mac OS X specific
* [MacVim](https://code.google.com/p/macvim/) (independent or for use in a terminal)
* [iTerm 2](http://www.iterm2.com/)

### Linux specific
* Gvim (vim-gnome package)

### Both platforms
* [tmux](http://tmux.sourceforge.net/)
* ctags
* [the_silver_searcher](https://github.com/ggreer/the_silver_searcher)
* Awesome syntax highlighting with the [Solarized color scheme](http://ethanschoonover.com/solarized)

### Plugins & themes
* Jellybeans theme
* [Vim-airline](https://github.com/bling/vim-airline) (this needs to be in the original repo imo)
* Console dialogs, disabled MacVim's popup dialog
* YouCompleteMe plugin
* [auto-pairs](https://github.com/vim-scripts/Auto-Pairs) plugin
* and [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors), great for refactoring

---

### vim

* `,d` brings up [NERDTree](https://github.com/scrooloose/nerdtree), a sidebar buffer for navigating and manipulating files
* `,t` brings up [ctrlp.vim](https://github.com/kien/ctrlp.vim), a project file filter for easily opening specific files
* `,b` restricts ctrlp.vim to open buffers
* `,a` starts project search with [ack.vim](https://github.com/mileszs/ack.vim) using [ag](https://github.com/ggreer/the_silver_searcher) (like ack)
* `ds`/`cs` delete/change surrounding characters (e.g. `"Hey!"` + `ds"` = `Hey!`, `"Hey!"` + `cs"'` = `'Hey!'`) with [vim-surround](https://github.com/tpope/vim-surround)
* `\\\` toggles current line comment
* `\\` toggles visual selection comment lines
* `vii`/`vai` visually select *in* or *around* the cursor's indent
* `,[space]` strips trailing whitespace
* `^]` jump to definition using ctags
* `,l` begins aligning lines on a string, usually used as `,l=` to align assignments
* `^hjkl` move between windows, shorthand for `^w hjkl`

### tmux

* `^a` is the prefix
* mouse scroll initiates tmux scroll
* `prefix v` makes a vertical split
* `prefix s` makes a horizontal split

## Install

    rake

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Acknowledgements

Thanks to the vimsters at Square who put this together. Thanks to Tim Pope for
his awesome vim plugins.

