# .bash_profile
# ==============================================================================
# Copyright (C) 2023 Ljubomir Kurij <ljubomir_kurij@protonmail.com>
#
#  .bash_profile - This file contains user specific defaults used by all Bourne
#                  (and related) shells when invoked as an interactive login
#                  shell, or as a non-interactive shell with the --login option
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.
#
# ==============================================================================


# ------------------------------------------------------------------------------
# User specific aliases
# ------------------------------------------------------------------------------

# Aliases that require only base system utilities
alias cls='clear'
alias ls='ls -1AFhl --color'
alias lst='ls -t'
alias lsa='ls -AFhl --color'
alias lsta='lsa -t'
alias rmv='rm -vi'
alias rdir='rm -dr'
alias rmexc='for file in ./*; do [[ -e "$file" ]] && [[ -x "$file" ]] || continue; rm -vi "$file"; done'
alias cpv='cp -v'
alias mvv='mv -v'
alias dfh='df -Th'
alias duh='du -hsc'

# Aliases that require additional packages
if [[ -e /usr/bin/whereis ]]; then
    if [ $( whereis find ) != "find:" ]; then
        alias rm~='find -P . -type f -name "*~" -exec rm -vi '"'"'{}'"'"' \;'
    fi
    if [ $( whereis mount_msdosfs ) != "mount_msdosfs:" ]; then
        alias mount_usb_stick='sudo mount_msdosfs -o longnames -g 0 -m 775 -L ca_ES.UTF-8'
    fi
    if [ $( whereis rsync ) != "rsync:" ]; then
        alias rsyncv='rsync -avu --progress'
    fi
    if [ $( whereis wget ) != "wget:" AND $( whereis grep ) != "grep:" ]; then
        alias getpublicip='echo -e "Public IP Address is:" $(wget -q -O - checkip.dyndns.org | grep -i -o "[0-9]{3}\.[0-9]{3}\.[0-9]{3}\.[0-9]{3}")';
    fi
    if [ $( whereis lynx ) != "lynx:" ]; then
        alias nbs_exchange='lynx -dump http://www.nbs.rs/kursnaListaModul/srednjiKurs.faces?lang=eng | head -n41';
    fi
    if [ $( whereis freecolor ) != "freecolor:" ]; then
        alias memory='freecolor -t -m';
    fi
    if [ $( whereis valgrind ) != "valgrind:" ]; then
        alias profilemyapp='G_DEBUG=gc-friendly G_SLICE=always-malloc valgrind --tool=memcheck --leak-check=full';
    fi
    if [ $( whereis fuse-ext2 ) != "fuse-ext2:" ]; then
        alias mount_extfs='sudo fuse-ext2 -o ro,allow_other,gid=0,umask=002';
    fi
    if [ $( whereis ntfs-3g ) != "ntfs-3g:" ]; then
        alias mount_ntfs='sudo ntfs-3g -o rw';
    fi
fi


# ------------------------------------------------------------------------------
# User specific functions
# ------------------------------------------------------------------------------

# Function that prints information about bash shell
function bashinfo() {
    # Prints information about bash shell to stdout
    fstline=0
    bash --version | while read line; do
        if [ 0 -eq $fstline ]; then
            fstline=1
            printf "%s\e[0;32mBash: \e[0;31m%s\e[0m\\n" "$1" "$line"
        else
            printf "%s      %s\\n" "$1" "$line"
        fi
    done
    unset fstline
}

# Function that checks for required applications
function check_required_pkgs() {
    # Checks for required applications and prints results to stdout
    ts=$( date '+%Y-%m-%d %k:%M:%S' )
    printf "%s Checking if required applications are present ...\\n" "$ts"
    if [ -e /usr/bin/whereis ]; then
        apps="find freecolor fuse-ext2 lynx most ntfs-3g ps rsync valgrind wget whereis xargs"
        for app in $apps; do
            result=$( whereis $app )
            ts=$( date '+%Y-%m-%d %k:%M:%S' )
            if [ "$result" != "$app"":" ]; then
                printf "%s %-21s ... \e[0;31mNOT FOUND\e[0m\\n" "$ts" "$app"
            else
                printf "%s %-21s ... \e[0;32mFOUND\e[0m\\n" "$ts" "$app"
            fi
        done
    else
        ts=$( date '+%Y-%m-%d %k:%M:%S' )
        printf "%s %-21s ... \e[0;31mNOT FOUND\e[0m\\n" "$ts" "whereis"
    fi

    # Check if git completion and git prompt scripts are installed in the user
    # home directory
    printf "\\n"
    ts=$( date '+%Y-%m-%d %k:%M:%S' )
    printf "%s Checking if git completion and git prompt scripts are present ...\\n" "$ts"
    ts=$( date '+%Y-%m-%d %k:%M:%S' )
    if [[ -e ~/git-completion.bash ]]; then
        printf "%s %-21s ... \e[0;32mFOUND\e[0m\\n" "$ts" "~/git-completion.bash"
    else
        printf "%s %-21s ... \e[0;31mNOT FOUND\e[0m\\n" "$ts" "~/git-completion.bash"
    fi
    ts=$( date '+%Y-%m-%d %k:%M:%S' )
    if [[ -e ~/git-prompt.sh ]]; then
        printf "%s %-21s ... \e[0;32mFOUND\e[0m\\n" "$ts" "~/git-prompt.sh"
    else
        printf "%s %-21s ... \e[0;31mNOT FOUND\e[0m\\n" "$ts" "~/git-prompt.sh"
    fi

    unset ts
}


# Function to kill process by giving the app name
function killbyname() {
    if [[ $( whereis ps ) != "ps:" && $( whereis xargs ) != "xargs:" ]]; then
        # Kill proces by app name
        ps -C "$1" | tail -n 1 | tr -s " " | cut -d " " -f 1 | xargs kill -9
    fi
}


# Function that prints welcome message
function welcome() {
    # Prints welcome message
    bshspcr="              "
    gccspcr="               "
    
    # Get host OS
    os=$( uname -o )
    
    [ $( tty | egrep -i pts ) ] && clear
    printf "                    \e[0;31m%s\e[0m\\n" "$( uname -n )"
    printf "\\n"
    if [[ "$os" == *Linux* ]]; then
        printf "\e[0;32m            System:\e[0;31m %s\e[0m\\n" "$( uname -i )"
    elif [[ "$os" == *BSD* ]]; then
        printf "\e[0;32m            System:\e[0;31m %s\e[0m\\n" "$( uname -smr )"
    elif [[ "$os" == *Msys* ]]; then
        osn=$( systeminfo | grep -i "^OS Name" | tr -s " " | cut -d " " -f 3- )
        osv=$( systeminfo | grep -i "^OS Version" | tr -s " " | cut -d " " -f 3- )
        printf "\e[0;32m            System:\e[0;31m %s %s\e[0m\\n" "$osn" "$osv"
        unset osn
        unset osv
    else
        printf "\e[0;32m            System:\e[0;31m %s\e[0m\\n" "Unsupported system"
    fi
    printf "\\n"
    printf "\e[0;32mKernel Information:\e[0;31m %s\e[0m\\n" "$( uname -svr )"
    printf "\\n"
    bashinfo "$bshspcr"
    printf "\\n"
    if [[ "$os" == *Linux* || "$os" == *BSD* ]]; then
        printf "Uptime for this computer is %s\\n" "$( uptime )"
    else
        bt=$( systeminfo | grep -i "^System Boot Time" | tr -s " " | cut -d " " -f 4- )
        printf "System boot time is %s\\n" "$bt"
        unset bt
    fi
    printf "\\n"
    printf "\\n"
    if [[ "$os" == *Linux* || "$os" == *BSD* ]]; then
        printf "Hello \e[0;36m%s\e[0m today is %s\\n" "$USER" "$( date )"
    else
        printf "Hello \e[0;36m%s\e[0m today is %s\\n" "$USERNAME" "$( date )"
    fi
    printf "\\n"
    if [[ "$os" == *Linux* || "$os" == *BSD* ]]; then
        printf "\e[0;32mLogged in:\e[0m\\n"
        who
    fi
    printf "\\n"
    unset bshspcr
    unset gccspcr
    unset os
}


# ------------------------------------------------------------------------------
# Language options
# ------------------------------------------------------------------------------
LANG=en_US.UTF-8; export LANG
CHARSET=UTF-8; export CHARSET


# ------------------------------------------------------------------------------
# Command history options
# ------------------------------------------------------------------------------
HISTSIZE=2000      # Set length of command history
HISTFILESIZE=2000  # Set length of bash history file


# ------------------------------------------------------------------------------
# Command line text editing options
# ------------------------------------------------------------------------------
set -o vi  # Set Vi as default text editing mode


# ------------------------------------------------------------------------------
# Prompt options
# ------------------------------------------------------------------------------

# Give some color to prompt
PS1='\[\e[0;32m\][\[\e[0;36m\]\u\[\e[0m\]@\h \[\e[0;35m\]\W\[\e[0;32m]\]\$\[\e[0m\] '

# Enable Bash Git Prompt if git-prompt.sh is present
if [[ -e ~/git-prompt.sh ]]; then
    # Allow git prompt only in repos
    GIT_PROMPT_ONLY_IN_REPO=1

    # Source git prompt script
    . ~/git-prompt.sh

    # Add git prompt to existing prompt
    PS1='\[\e[0;32m\][\[\e[0;36m\]\u\[\e[0m\]@\h \[\e[0;35m\]\W\[\e[0;32m]\]$(__git_ps1 " [%s]")\$\[\e[0m\] '
fi

# Source Bahs completion scripts if git-completion.bash is present
if [[ -e ~/git-completion.bash ]]; then
    . ~/git-completion.bash
fi


# ------------------------------------------------------------------------------
# Man pages options
# ------------------------------------------------------------------------------

# Give some color to the manpages if all required packages are installed
if [[ -e /usr/bin/whereis && $( whereis most ) != "most:" ]]; then
    export MANPAGER="$( whereis most | cut -d " " -f2 )" "-s"
fi

# ------------------------------------------------------------------------------
# Invoke welcome message
# ------------------------------------------------------------------------------
welcome

# End of .bash_profile