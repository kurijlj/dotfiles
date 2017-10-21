# ~/.bashrc: This file contains user specific defaults used by all Bourne (and
# related) shells.

# Source global definitions
if [ -f /etc/profile ]; then
	. /etc/profile
fi

# Source Bahs completion scripts
if [ -f /etc/bash_completion.d/git-completion.bash ]; then
	. /etc/bash_completion.d/git-completion.bash
fi

# Set Vi as default text editing mode
set -o vi

# Give some color to prompt
PS1='\[\e[0;32m\][\[\e[0;36m\]\u\[\e[0m\]@\h \[\e[0;35m\]\W\[\e[0;32m]\]\$\[\e[0m\] '

# Give some color to manpages
export MANPAGER="/usr/bin/most -s"

# User specific path
if [[ -d ~/.bin ]]; then
	export PATH=${PATH}:~/.bin
fi

# Enable EGSnrc environment
#export EGS_CONFIG=/home/ljubak/HEN_HOUSE/specs/i686-pc-linux-gnu.conf
#export EGS_HOME=/home/ljubak/egsnrc_mp/
#export LD_LIBRARY_PATH=/home/ljubak/HEN_HOUSE/egs++/dso/linux32:$LD_LIBRARY_PATH
#. /home/ljubak/HEN_HOUSE/scripts/egsnrc_bashrc_additions
export EGS_HOME=/home/ljubak/EGSnrc/egs_home/
export EGS_CONFIG=/home/ljubak/EGSnrc/HEN_HOUSE/specs/linux.conf
source /home/ljubak/EGSnrc/HEN_HOUSE/scripts/egsnrc_bashrc_additions

# User specific aliases
alias cls='clear'
alias clsa='cls;lsa'
alias g16pass='tr -dc a-z0-9A-Z:_! < /dev/urandom | fold -w16 | head -1'
alias ls='ls -A1Fh --color --group-directories-first'
alias lsa='ls -Alh --color --group-directories-first'
alias rmv='rm -vi'
alias rdir='rm -dr'
alias rm~='find -P . -type f -name "*~" -exec rm -vi '"'"'{}'"'"' \;'
alias rmexc='for file in ./*; do [[ -f "$file" ]] && [[ -x "$file" ]] || continue; rm -vi "$file"; done'
alias cpv='cp -v'
alias rsyncv='rsync -avu --progress'
alias mvv='mv -v'
alias dfh='df -Th'
alias duh='du -hsc'
alias dosbox='pushd /home/share/Archive/Software/DosboxMount/; dosbox -conf ./config &> /dev/null &'
alias vivaldi='/usr/local/bin/vivaldi --disable-gpu %U'
alias getpublicip='echo -e "Public IP Address is:" $(wget -q -O - checkip.dyndns.org | egrep -i -o "[0-9]{3}\.[0-9]{3}\.[0-9]{3}\.[0-9]{3}")'
alias profilemyapp='G_DEBUG=gc-friendly G_SLICE=always-malloc valgrind --tool=memcheck --leak-check=full'
alias startxs='startx -- -nolisten tcp'
alias reload_conky='killall -SIGUSR1 conky'
alias nbs_exchange='lynx -dump http://www.nbs.rs/kursnaListaModul/srednjiKurs.faces?lang=lat | head -n43'
alias cqlock2='cqlock -s mid-high'
alias chckgdrive='rclone check "GoogleDrive:/TagSpaces" "/home/ljubak/Dropbox/TagSpaces" -v'
alias chcktagspaces='rclone check "/home/ljubak/Dropbox/TagSpaces" "GoogleDrive:/TagSpaces" -v'
alias syncgdrive='rclone sync "GoogleDrive:/TagSpaces" "/home/ljubak/Dropbox/TagSpaces" -v -u'
alias synctagspaces='rclone sync "/home/ljubak/Dropbox/TagSpaces" "GoogleDrive:/TagSpaces" -v -u'

# Aliases for internet radiostations
#alias smthjzz='vlc http://uk1.smoothandjazz.com:8090 > /dev/null 2>&1 &'
#alias clss102='vlc http://tuner.classical102.com:80 > /dev/null 2>&1 &'
#alias goldfm='vlc http://uk2.internet-radio.com:30092 > /dev/null 2>&1 &'

# Unused aliases
#alias skype='export LIBV4LCONTROL_FLAGS=1 && LD_PRELOAD=/usr/lib/\
#	i386-linux-gnu/libv4l/v4l1compat.so /usr/bin/skype'
#alias btut='vim -R /home/share/Linux/documentation/General/+\ Aliens\ Bash\ Tutorial.txt'
#alias mntlja='sudo mount -o loop /home/share/Linux/documentation/Magazines/Linux\ Journal/Linux\ Journal\ Archive\ \[1994-2010\].iso /media/cdrom0'
#alias umntlja='sudo umount /media/cdrom0'
#alias pictodvi='xrandr --output DVI-I-1 --mode 1920x1080'
#alias pictohdmi='xrandr --output HDMI-1 --mode 1360x768'


# User specific functions

function spin() {
	# Animates spinner to stdout
	if [[ $1 -ge 3 ]]; then
		cnt="$1"
	else
		cnt=2
	fi
	for i in `seq 1 "$cnt"`; do
		echo -ne "\e[0;31m-"
		sleep .05
		echo -ne "\b\\"
		sleep .05
		echo -ne "\b|"
		sleep .05
		echo -ne "\b/"
		sleep .05
		echo -ne "\b-\b\e[0m"
	done
	echo -ne ""
	unset cnt
}

function ifceinfo() {
	# Prints network interface configuration to stdout
	ntaddr=`/sbin/ifconfig -v "$1" | egrep -i "inet "`
	hwaddr=`/sbin/ifconfig -v "$1" | egrep -io "([[:alnum:]]{2}:){5}([[:alnum:]]{2})"`
	inet=`egrep -io "inet ([[:digit:]]{1,3}\.){3}([[:digit:]]{1,3})" <<< "$ntaddr" | cut -d" " -f2`
	ntmask=`egrep -io "netmask ([[:digit:]]{1,3}\.){3}([[:digit:]]{1,3})" <<< "$ntaddr" | cut -d" " -f2`
	bcast=`egrep -io "broadcast ([[:digit:]]{1,3}\.){3}([[:digit:]]{1,3})" <<< "$ntaddr" | cut -d" " -f2`
	echo -e "\e[0;32m     Interface: \e[0;31m$1\e[0m"
	echo -e "\e[0;32m          inet:\e[0m $inet"
	echo -e "\e[0;32m       netmask:\e[0m $ntmask"
	if [[ "$bcast" ]]; then echo -e "\e[0;32m     broadcast:\e[0m $bcast"; fi
	if [[ "$hwaddr" ]]; then echo -e "\e[0;32m         ether:\e[0m $hwaddr"; fi
	echo -e ""
	unset bcast
	unset ntmask
	unset inet
	unset hwaddr
	unset netaddr
}

function netinfo() {
	# Prints network configuration to stdout
	ifcs=`/sbin/ifconfig -a -v | egrep -i "^[[:alnum:]]+:" | cut -d: -f1 | tr "\n\r" " "`
	echo -e ""
	echo -e "\e[0;32m--------------- \e[0;31mNetwork Information \e[0;32m---------------\e[0m"
	echo -e ""
	for ifce in $ifcs; do ifceinfo "$ifce"; done
	echo -e "\e[0;32m---------------------------------------------------\e[0m"
	echo -e ""
	unset ifce
	unset ifcs
}

function bashinfo() {
	# Prints information about systems export HEN_HOUSE="" EGS_HOME="" EGS_CONFIG=""bash shell to stdout
	fstline=0
	bash --version | while read line; do
		if [[ 0 -eq $fstline ]]; then
			fstline=1
			echo -e "$1\e[0;32mBash: \e[0;31m$line\e[0m"
		else
			echo -e "$1      $line"
		fi
	done
	unset fstline
}

function gccinfo() {
	# Prints information about systems gcc compiler to stdout
	fstline=0
	gcc --version | while read line; do
		if [[ 0 -eq $fstline ]]; then
			fstline=1
			echo -e "$1\e[0;32mgcc: \e[0;31m$line\e[0m"
		else
			echo -e "$1     $line"
		fi
	done
	unset fstline
}

function welcome() {
	# Prints welcome message
	bshspcr="              "
	gccspcr="               "
	[[ `tty | egrep -i pts` ]] && clear
	echo -e "                    \e[0;31m$HOSTNAME\e[0m"
	echo -e ""
	echo -e "\e[0;32m            System:\e[0;31m" `cat /etc/slackware-version` "\e[0m"
	echo -e ""
	echo -e "\e[0;32mKernel Information:\e[0;31m" `uname -smr` "\e[0m"
	echo -e ""
	bashinfo "$bshspcr"
	echo -e ""
	gccinfo "$gccspcr"
	echo -e "              \e[0;32mglib:\e[0;31m" `glib-config --version` "\e[0m"
	echo -e ""
	echo -e "Uptime for this computer is" `uptime`
	echo -e "\n"
	echo -e "Hello \e[0;36m$USER\e[0m today is" `date`
	echo -e ""
	echo -e "\e[0;32mLogged in:\e[0m"
	who
	netinfo
	echo -e ""
	unset bshspcr
	unset gccspcr
}

function tosmlfns() {
	# To Small Filenames function
	if [[ -n $1 ]] && [[ -f $1 ]]; then
		srcdir=$(dirname "$1")
		newname=$(basename "$1" | tr "[A-Z] " "[a-z]_")
		mv -v "$1" "$srcdir/$newname"
	else
		echo "$1 is not a file!"
	fi
	unset srcdir
	unset newname
}

function hyptounds() {
	# Hyphens to Underscores function
	if [[ -n $1 ]] && [[ -f $1 ]]; then
		srcdir=$(dirname "$1")
		newname=$(basename "$1" | tr "-" "_")
		mv -v "$1" "$srcdir/$newname"
	else
		echo "$1 is not a file!"
	fi
	unset srcdir
	unset newname
}

function gvim() {
	# Calls gvim with NERDTree and &> /dev/null
	if [[ -n $1 ]] && [[ -f $1 ]]; then
		/usr/bin/gvim +NERDTree "$1" &> /dev/null
	else
		/usr/bin/gvim +NERDTree &> /dev/null
	fi
}

function gvimr() {
	# Calls gvim read only with NERDTree and &> /dev/null
	if [[ -n $1 ]] && [[ -f $1 ]]; then
		/usr/bin/gvim -R +NERDTree "$1" &> /dev/null
	else
		echo "\"$1\" is not a file!"
	fi
}

function prnals() {
	# Prints list of user defined aliases to stdout
	echo -e ""
	echo -e "\e[0;31mAvailable aliases list:\e[0m"
	echo -e "\e[0;36m====================================================\
\e[0m"
	cat ~/.bashrc | egrep -i "^alias [[:alpha:]]" | sort | while read line
	do
		name=$(echo -e "$line" | cut -d" " -f2- | sed 's/=/-/' | \
			cut -d"-" -f1)
		value=$(echo -e "$line" | cut -d" " -f2- | sed 's/=/-/' | \
			cut -d"-" -f2-)
		#echo -e "\e[0;31m$name\e[0m\t\t$value"
		printf "\e[0;31m%15s\e[0m\t%s\n" "$name" "$value"
		unset name
		unset value
	done
	echo -e ""
}

function readpdf() {
	# Used to run evince in background from command line and with
	# &> /dev/null
	if [[ -n $1 ]] && [[ -f $1 ]]; then
		/usr/local/bin/evince "$1" &> /dev/null &
	else
		echo "\"$1\" is not a file!"
	fi
}

function killbyname() {
	# Kill proces by app name
	ps -C "$1" | tail -n 1 | tr -s " " | cut -d " " -f 1 | xargs kill -9
}

#function alsa_skype() {
#	# Runs skype using apulse platform
#	devno=`cat /proc/asound/cards | egrep -i "USB-Audio" | cut -d" " -f2`
#	APULSE_CAPTURE_DEVICE="hw:$devno,0" apulse skype &
#}


# Print welcome message
welcome

