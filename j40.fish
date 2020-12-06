#! /usr/bin/fish
#
#      _   ___ _____
#     (_) /   |  _  |
#      _ / /| | |/' |
#     | / /_| |  /| |
#     | \___  \ |_/ /
#     | |   |_/\___/
#    _/ |
#   |__/
#
#   j40's fish shell settings
#
#   adapted from arcolinux's bashrc with a few extra stuff



##
##   -- Nice things to have --
##
##   pfetch     : neofetch's little brother
##   ohmyfish   : like ohmyzsh, but simpler and lighter
##   bobthefish : powerline for fish
##   lsd        : much better ls
##


# exit if not in interactive mode
not status -i; and exit

# Anaconda and Miniconda might break the
# clear command in some distros, this
# fixes it sending an escape character.
# Also I like to run pfetch after clear.
#
# <C-l> completely clears the terminal usually
#
alias clear='echo -n \033c'
## command -q neofetch; and alias clear="echo -\033c; neofetch"
command -s pfetch; and alias clear='echo -n \033c; pfetch'

# better lists, best with lsd
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -la'
alias l='ls'
alias l.='ls -A | egrep "^\."'
command -s lsd; and alias ls='lsd'

# typos
alias cd..='cd ..'
alias pdw='pwd'
alias :q='exit'

# Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# readable df
alias df='df -h'

# free
alias free='free -mt'

# use all cores
alias uac='sh ~/.bin/main/000*'

# continue download
alias wget='wget -c'

# list users
alias userlist='cut -d: -f1 /etc/passwd'

# merge new settings for the X server
alias merge='xrdb -merge ~/.Xresources'

# utilities for ps
alias psa='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'

# grub update
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# add new fonts
alias update-fc='sudo fc-cache -fv'

# skel backup shenanigans
alias skel='cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -rf /etc/skel/* ~'
alias bupskel='cp -Rf /etc/skel ~/.skel-backup-$(date +%Y.%m.%d-%H.%M.%S)'

# choose ya shell
alias tobash='sudo chsh $USER -s /bin/bash && echo "Now log out."'
alias tozsh='sudo chsh $USER -s /bin/zsh && echo "Now log out."'
alias tofish='sudo chsh $USER -s /usr/bin/fish "Now log out."'

# quickly kill conkies
alias kc='killall conky'

# shorthand hardware info
alias hw='hwinfo --short'

# check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

# youtube-dl
alias yta-aac='youtube-dl --extract-audio --audio-format aac '
alias yta-best='youtube-dl --extract-audio --audio-format best '
alias yta-flac='youtube-dl --extract-audio --audio-format flac '
alias yta-m4a='youtube-dl --extract-audio --audio-format m4a '
alias yta-mp3='youtube-dl --extract-audio --audio-format mp3 '
alias yta-opus='youtube-dl --extract-audio --audio-format opus '
alias yta-vorbis='youtube-dl --extract-audio --audio-format vorbis '
alias yta-wav='youtube-dl --extract-audio --audio-format wav '
alias ytv-best='youtube-dl -f bestvideo+bestaudio '

# rip as in recently installed packages, not rest in peace
alias rip='expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl'
alias riplong='expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl'

# get the error messages from journalctl
alias jctl='journalctl -p 3 -xb'

# Vim for important config files
# please do not mess those up
alias nlightdm='sudo vim /etc/lightdm/lightdm.conf'
alias npacman='sudo vim /etc/pacman.conf'
alias ngrub='sudo vim /etc/default/grub'
alias nmkinitcpio='sudo vim /etc/mkinitcpio.conf'
alias nslim='sudo vim /etc/slim.conf'
alias noblogout='sudo vim /etc/oblogout.conf'
alias nmirrorlist='sudo vim /etc/pacman.d/mirrorlist'
alias nconfgrub='sudo vim /boot/grub/grub.cfg'

# gpg
# >> verify signature for isos
alias gpg-check='gpg2 --keyserver-options auto-key-retrieve --verify'
# >> receive the key of a developer
alias gpg-retrieve='gpg2 --keyserver-options auto-key-retrieve --receive-keys'

# maintenance
alias big='expac -H M "%m\t%n" | sort -h | nl'

# maintenance
alias big='expac -H M "%m\t%n" | sort -h | nl'

# system info
alias probe='sudo -E hw-probe -all -upload'

# shutdown or reboot
alias ssn='sudo shutdown now'
alias sr='sudo reboot'

# universal extractor
# usage: ex <file>
function ex -d 'EXtractor for all kinds of archives'
    if test (count $argv) -eq 0
        echo "Hello! I'm ex. I'll try extract the first compressed file you give me!"
    else if test ! -e $argv[1]
        echo 'This one does not exist, maybe try this: ex <file>' 
    else if test ! -f $argv[1]
        echo 'This one is not a regular file, sorry...'
    else
        switch $argv[1]
            case *.tar.bz2; tar xjf $argv[1]
            case *.tar.gz;  tar xzf $argv[1]
            case *.bz2;     bunzip2 $argv[1]
            case *.rar;     unrar x $argv[1]
            case *.gz;      gunzip $argv[1]
            case *.tar;     tar xf $argv[1]
            case *.tbz2;    tar xjf $argv[1]
            case *.tgz;     tar xzf $argv[1]
            case *.zip;     unzip $argv[1]
            case *.Z;       uncompress $argv[1]
            case *.7z;      7z x $argv[1]
            case *.deb;     ar x $argv[1]
            case *.tar.xz;  tar xf $argv[1]
            case *.tar.zst; unzstd $argv[1]
            case *       
                echo "I don't know how to uncompress that, my bad."
        end
    end
end

# set vi mode
fish_vi_key_bindings


################
## -- Arch -- ##
################

if cat /etc/*-release | grep -q 'arch'

    # package management
    alias pacman='sudo pacman --color auto'
    alias update='sudo pacman -Syyu'
    alias pksyua='yay -Syu --noconfirm'
    alias upall='yay -Syu --noconfirm'
    # >> skip integrity checks
    alias yayskip='yay -S --mflags --skipinteg'
    alias trizenskip='trizen -S --skipinteg'
    # >> cleanup orphaned packages
    alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

    # get fastest mirrors in your neighborhood
    alias mirror='sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist'
    alias mirrord='sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist'
    alias mirrors='sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist'
    alias mirrora='sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist'

    # pacman unlock
    alias unlock='sudo rm /var/lib/pacman/db.lck'
    alias rmpacmanlock='sudo rm /var/lib/pacman/db.lck'

    # obvious typos typos
    alias udpate='sudo pacman -Syyu'
    alias upate='sudo pacman -Syyu'
    alias updte='sudo pacman -Syyu'
    alias updqte='sudo pacman -Syyu'
    alias upqll='yay -Syu --noconfirm'

end


################
## -- Arco -- ##
################

if cat /etc/*-release | grep -q 'arcolinux'

    # logout unlock
    alias rmlogoutlock='sudo rm /tmp/arcologout.lock'

    # mounting the folder Public for exchange between host and guest on virtualbox
    alias vbm='sudo /usr/local/bin/arcolinux-vbox-share'

    # iso and version used to install ArcoLinux
    alias iso='cat /etc/dev-rel | awk -F "=" "/ISO/ {print $2}"'

    # better lockscreen, verry self explanatory
    alias bls="betterlockscreen -u /usr/share/backgrounds/arcolinux/"

    # maintenance
    alias downgrada"sudo downgrade --ala-url https://bike.seedhost.eu/arcolinux/"
end

# those are commented 'cause my clear already calls one 'o them
# neofetch
# pfetch
clear
