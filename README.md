
# Video


https://github.com/user-attachments/assets/b327ddbc-1fc1-4904-92cb-2233c8a5a894



# Getting started
Clone this repo
```sh
git clone https://github.com/ADIOR-enigma/hyprbadapple
cd hyprbadapple
```

## Dependencies
- `hyprland` - the window manager itself
- `mpv`  - to play the audio file in the background
- `socat`  -  to unpause mpv for syncing

 \
Arch-based
```sh
sudo pacman -S mpv socat --needed
```

Other distros
> idk, figure it out

## Build
You will need to compile the provided C source files before running. A build script is included for convenience. Make sure you have `gcc`, `wayland-scanner` and `pkg-config` installed.
```sh
./build.sh
```


## Configuring
See useful stats for configuration
```sh
cd baprocess

sudo pacman -S python-opencv python-numpy python-pillow python-tqdm --needed
python pack.py

# skipping video decode...
# total frames : 6572
# most boxes   : 153
# total boxes  : 309476
# grid size    : 64x48
# wrote output/boxes.bin
```

## Start
> [!IMPORTANT]
> To force stop cleanly, press `SUPER + U` after you started

Follow these steps to start the animation:

1. Move back to the main `hyprbadapple` directory (since you were in `baprocess`).
2. Run the `start.sh` script to launch the animation.
3. The terminal will close automatically.

Easy copy-paste command:
```sh
cd ..
sh start.sh && exit
```

Or, if you prefer to launch directly without the `start.sh` script:
```sh
cd ..
hyprctl eval "dofile'$PWD/init.lua'" && exit
```
> `&& exit` is used to exit the terminal after starting

### Constants
You can edit some constants based on these values and your monitor resolution \
in `config.lua`
```lua
MAX_BOXES = 153, -- the `most boxes` from python

SCALE    = 24,  -- scale  -> resolution height / (grid height)
OFFSET_X = 192, -- center -> [(resolution width) - (grid width * scale)] / 2
OFFSET_Y = 46,  -- depends on your top|bottom bars - can be 0 if you want it to fullscreen
```

`resolution` is your monitor resolution which can be accessed from

```sh
hypctl monitors

# Monitor eDP-1 (ID 0):
#	        1920x1200@60 at 0x0
```
e.g. 1920x1200 and grid size: 64x48
 > 1920 is the resolution width \
 > 1200 is the resolution height \
 > 64 is the grid width \
 > 48 is the grid height

So, `SCALE` = `1200/48` = `25` \
and, `OFFSET_X` = `(1920 - 64*25)/2` = `160`
 > 25 is from `SCALE`

 \
Change this to launch different window e.g. `kitty` `foot`
```lua
LAUNCH = "./box", -- window launch command
-- local LAUNCH = "kitty";
-- local LAUNCH = "firefox";
```
 > It's not recommended to launch heavy window like a browser
 > or something similar as it may crash
