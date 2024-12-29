# Arch notes

Device: Lenovo Thinkpad X1 Extreme Gen 1

## Installation

### Git, dev tools, yay
```sh
sudo pacman -S git base-devel
mkdir ~/repos
cd ~/repos
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Audio
```sh
sudo pacman -S alsa-utils pulseaudio pulseaudio-alsa pavucontrol
```

### Video
```sh
sudo pacman -S libva libva-utils intel-media-drive intel-gpu-tools
```

### Hyprland and friends
```sh
sudo pacman -S hyprland hyprlock hyprpaper alacritty dunst rofi waybar htop stow
```

### VSCode
```sh
sudo pacman -S visual-studio-code-bin
```

### Browsers (Firefox & Chromium)
```sh
sudo pacman -S firefox chromium
```

### Image viewers, editors, etc
```sh
yay -S timg
yay -S loupe switcheroo drawing
```

References:
- https://wiki.archlinux.org/title/Visual_Studio_Code

## Configuration

### Video

- Disable NVidia card
    ```sh
    sudo cat > /etc/modprobe.d/nouveau-blacklist.conf <<EOF
    blacklist nouveau
    options nouveau modeset=0
    EOF
    reboot
    ```
- Enable chromium hardware acceleration
    ```sh
    cat > ~/.config/chromium-flags.conf <<EOF
    --ignore-gpu-blocklist
    --enable-zero-copy
    --enable-features=AcceleratedVideoDecodeLinuxGL
    --ozone-platform-hint=auto
    EOF
    ```

Verification:

- Run `sudo intel_gpu_top`, it should show applications that using GPU (hyprland at least)

### Audio

- Give myself control over audio devices
    ```sh
    sudo usedmod -aG audio $(whoami)
    ```
- Disable autospawn (edit `/etc/pulse/client.conf` and set `autospawn = no`)
- Enable Intel HDAudio:
    ```sh
    sudo echo "options snd-hda-intel model=auto" > /etc/modprobe.d/alsa.conf
    ``` 
- Run `pavucontrol` and enable built-in audio on configuration tab

Verification:
- Run `aplay -L` to get full list of devices
- Run `speaker-test -Dfront:CARD=J370 -c 2` to test Jabra J370 Usb Headset
- Run `speaker-test -Dsysdefault:CARD=PCH -c 2` to test interated audio

References:
- https://wiki.archlinux.org/title/PulseAudio
- https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture

### Use dotfiles
```sh
sudo pacman -S stow
cd ~
git clone git@github.com:nixxa/dotfiles.git
cd ~/dotfiles
stow alacritty
stow backgrounds
stow dunst
stow htop
stow hyprland
stow hyprlock
stow hyprpaper
stow rofi
stow waybar
stow scripts
cd ~
```