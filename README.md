# MacVim configuration

Configuration files/plugins for `MacVim` on `macOS`

## Tested versions

* macOS 10.14
* MacVim 8.1.873

## Installation

```
$ git clone https://github.com/bsnux/vim-osx
$ cd vim-osx
$ git submodule init
$ git submodule update
$ mkdir ~/.vim
$ ln -s vim-osx/vimrc ~/.vimrc
$ ln -s vim-osx/gvimrc ~/.gvimrc
$ ln -s vim-osx/pack ~/.vim/pack
```

### Installing a plugin for autoloading

```
$ cd vim-osx
$ git submodule add https://github.com/<repo> pack/bsnux/start/<name>
```

### Installing an optional plugin

```
$ cd vim-osx
$ git submodule add https://github.com/<repo> pack/bsnux/opt/<name>
```

Add this line to your `/.vimrc`:

```
packadd! <name>
```

## Updating plugins

```
git submodule update --remote --merge
```

## Deleting a plugin

```
git submodule deinit vim/pack/bsnux/start/<name>
git rm vim/pack/bsnux/start/<name>
rm -Rf .git/modules/vim/pack/bsnux/start/<name>
```
