#!/bin/bash
# see `man 7 urxvt`
# https://emergent.unpythonic.net/01297173664 tmux related stuff

font_style="$(fc-list :lang=en:style=Regular family style | fzf)"
[[ $font_style == "" ]] && exit 1
size="$(seq 6 2 40 | fzf)"
[[ $size == "" ]] && exit 1
font="$(echo "$font_style" | cut -d":" -f1)"
style="$(echo "$font_style" | cut -d":" -f2)"
case "$TERM" in
	tmux*)  # this doesn't WORK, it does work in screen though
		sleep .1; 
		printf '\033P\33]50;%s\007' "xft:$font-$size:$style"
		printf '\033P\33]711;%s\007' "xft:$font-$size:$style"
		;;
	*)
		printf '\33]50;%s\007' "xft:$font-$size:$style"
		printf '\33]711;%s\007' "xft:$font-$size:$style"
		;;
esac
echo -e "URxvt.font:\txft:$font-$size:$style\nURxvt.boldFont: xft:$font-$size:$style" | xrdb -override
