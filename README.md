welcome to my ultrakill rice!

This is a very very early beta, so for now dont expect too much.

for this rice you'll need to install quickshell, fastfetch, the "imgborder" hyprland plugin, and the necessary dependencies.

to install them run the following commands (im not sure what the install commands are for other OS's, but these are for arch):

```
  yay -s quickshell-git
  
  hyprpm add https://github.com/hyprwm/hyprland-plugins
  
  sudo pacman -S cpio cmake git meson gcc 
  
  sudo pacman -S fastfetch
  
  hyprpm add https://codeberg.org/zacoons/imgborders
  
  hyprpm enable imgborders
```

for now the only folder i can share is the fastfetch config. by putting it in your .config folder it should work
