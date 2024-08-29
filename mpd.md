https://wiki.archlinux.org/index.php/Music_Player_Daemon
```shell
sudo apt-get install mpd mpc ncmpcpp  

mkdir .mpd  
mkdir -p ~/.mpd/playlists
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}  

cp /usr/share/doc/mpd/mpdconf.example ~/.mpd/mpd.conf
vim ~/.mpd/mpd.conf
```
```
# Required files
db_file            "~/.config/mpd/database"
log_file           "~/.config/mpd/log"

# Optional
music_directory    "~/Music"
playlist_directory "~/.config/mpd/playlists"
pid_file           "~/.config/mpd/pid"
state_file         "~/.config/mpd/state"
sticker_file       "~/.config/mpd/sticker.sql"

#run as current local user
#user                 "mpd"

#To change the volume for mpd independent from other programs
mixer_type            "software"

# for visualization
audio_output {
    type                    "fifo"
    name                    "my_fifo"
    path                    "/tmp/mpd.fifo"
    format                  "44100:16:2"
}
```
```shell
$ mpd config_file
```
if you got the following message: Failed to bind to '[::]:6600': Address already in use
```shell
$ sudo service mpd stop
```
https://wiki.archlinux.org/index.php/Ncmpcpp
```shell
$ cp /usr/share/doc/ncmpcpp/config ~/.ncmpcpp/
$ vim ~/.ncmpcpp/config
```
```
visualizer_fifo_path = "/tmp/mpd.fifo"
visualizer_output_name = "my_fifo"
visualizer_sync_interval = "30" 
visualizer_in_stereo = "yes"
#visualizer_type = "wave" (spectrum/wave)
visualizer_type = "spectrum" (spectrum/wave)
```
```shell
$ ncmpcpp
```
