# My dotfiles

This repo contains [@sluvs's](http://github.com/sIuv) dotfiles.
Install like so:

```bash
cd
git clone git@github.com:sIuv/dotfiles.git .dotfiles
.dotfiles/script/bootstrap.sh
```

Add any local changes to ~/.localrc


## emacs setup

### Windows 10
#### Daemon
Create shortcut of runemacs.exe and place it in shell:startup.
Add --daemon to the target.

#### Client
Create a shortcut to emacsclientw.exe.
Add -n -c -a "" to target.
