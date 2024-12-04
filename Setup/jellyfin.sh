#!/bin/bash
JELLYFINDIR="/usr/bin"
CONFIGDIR="/etc/jellyfin"
FFMPEGDIR="/usr/lib/jellyfin-ffmpeg"

$JELLYFINDIR/jellyfin \
 -d $CONFIGDIR/data \
 -C $CONFIGDIR/cache \
 -c $CONFIGDIR/config \
 -l $CONFIGDIR/log \
 --ffmpeg $FFMPEGDIR/ffmpeg
