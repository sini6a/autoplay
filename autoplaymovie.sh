#!/bin/bash
clear
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# CHANGE AS NEEDED
downloadfolder="$HOME/Downloads"
videofolder="$HOME/Videos"

echo -e "Folder to search for last torrent: ${GREEN}$downloadfolder${NC}"
echo -e "Folder where 'peerflix' will download: ${GREEN}$videofolder${NC}"


# CHANGE TO downloadfolder AND STORE LAST DOWNLOADED TORRENT NAME IN VARIABLE name
cd $downloadfolder || sleep infinity
name="$(ls *.torrent -t | head -n1)"
echo -e "Now streaming: ${GREEN}$name${NC}"

urxvt -e peerflix --path "$videofolder" "$downloadfolder/$name" -m &

cd $videofolder || sleep infinity
name="$(ls -t | head -n1)"

cd "$name"
moviename="$(ls *.mp4 || ls *.mkv || ls *.avi)"
echo
echo -e "Downloading in: ${GREEN}$name${NC}"
echo
echo -e "Movie Name: ${GREEN}$moviename${NC}"
subtitle="$videofolder/$name/$moviename"
python3.6 "$DIR/OpenSubtitlesDownload.py" "$subtitle" -l hrv,scc,mac
