#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q freedink | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook:sdl-soundfonts.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/freedink.svg
export DESKTOP=/usr/share/applications/freedink.desktop
export STARTUPWMCLASS=freedink
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/freedink /usr/bin/freedink-dfarc /usr/bin/freedinkedit /usr/lib/libfluidsynth.so*

# Turn AppDir into AppImage
quick-sharun --make-appimage
