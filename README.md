# CM3588-Setup
Setup Jellyfin, qbittorrent-nox, as well their needed libraries and users permissions.

## Features
* Fast setup of jellyfin as well enabled in systemd.
* Faste setup of qbittorrent-nox and qbtuser with the security safe practices.
* Can run 3 Streams 4k-80fps.

## Mainland China Read below:
## Beginners (Linux)
You can download nmap to scan all your network and find what ip is your CM3588 installed. `nmap --min-rate 5000 192.168.1.1-254` No need for `--min-rate 5000` (it just speeds the process).
This script focuses on ubuntu minimal (jammy/noble) [Check Friendlyelec Wiki](https://wiki.friendlyelec.com/wiki/index.php/CM3588) for installing them. Recommended way is installing through USB. (SD Card works great but becarefull with storage).
Configuring `/etc/fstab`.
`sudo blkid /dev/nvme0n1p1`
And in your `/etc/fstab` file you put:
`UUID="xxxx-x-xxx-xxxxxxx-xxxx" /your/folder/path ext4 defaults 0 2`
Jellyfin port is `8096` qbittorrent-nox `8080`.
Remember to disable `Use UPnP / NAT-PMP to forward the port from my router` option in qbittorrent or put a strong password if you want to connect to it outside of your home network.
This option is found in `Tools -> Options... -> Web UI.
## Make jellyfin run 3 streams 4k-80fps
* Install the .deb package in Setup. 
If you want to know more read the [VPU jellyfin blog](https://jellyfin.org/docs/general/administration/hardware-acceleration/rockchip/)
* In transcodding enable:
** Rockchip MPP (RKMPP)
** H264
** HEVC
** AV1
** HEVC 10 bit
** Enable hardware encoding
** Enable Tone mapping (BT.2390)
With this settings you should be ready to watch streams.
The script needs more work, I'll be updating when I have time.
## For foreigners or chinese living in China.
You need a way to download github and other files like the ubuntu img.
If you don't want to use badao or other stuff a way to proceed is getting a server or allowing someone to connect through ssh and using proxychains:
* As well you can use [Algo-VPN](https://github.com/trailofbits/algo) or a [Fast-Algo-Setup-VPN](https://github.com/N4hu4t/Algo-VPN) (uses wireguard):
```
ssh root@server_outside_of_china_ip -D <choose a port to open> -fCN
sudo vim /etc/proxychains.conf
# remove the socks4 and add socks 5 with the port you choose to open in the server.
proxychains install.sh or run install-CN.sh
```
Gl
