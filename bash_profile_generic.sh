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

LANG=en_US.UTF-8; export LANG
CHARSET=UTF-8; export CHARSET

# Set length of command history and bash history file
HISTSIZE=2000
HISTFILESIZE=2000

# Check for needed packages
for app in find freecolor fuse-ext2 lynx most ntfs-3g rsync valgrind wget; do
    result=$( whereis $app )
    if [ "$result" != "$app"":" ]; then
        ts=$( date '+%Y-%m-%d %k:%M:%S' )
        echo -e "$ts WARNING: Could not find: '$app' ..." >> ./.missing_packages
    fi
done

# Set Vi as default text editing mode
set -o vi

# Define user specific aliases
alias cls='clear'
alias clsa='cls;lsa'
alias ls='ls -1AFhl --color'
alias lst='ls -t'
alias lsa='ls -AFhl --color'
alias lsta='lsa -t'
alias rmv='rm -vi'
alias rdir='rm -dr'
alias rm~='find -P . -type f -name "*~" -exec rm -vi '"'"'{}'"'"' \;'
alias rmexc='for file in ./*; do [[ -f "$file" ]] && [[ -x "$file" ]] || continue; rm -vi "$file"; done'
alias cpv='cp -v'
if [ -e /usr/local/bin/rsync ]; then
    alias rsyncv='rsync -avu --progress'
fi
alias mvv='mv -v'
alias dfh='df -Th'
alias duh='du -hsc'
alias mount_usb_stick='sudo mount_msdosfs -o longnames -g 0 -m 775 -L ca_ES.UTF-8'
if [ -e /usr/local/bin/wget ]; then
    alias getpublicip='echo -e "Public IP Address is:" $(wget -q -O - checkip.dyndns.org | egrep -i -o "[0-9]{3}\.[0-9]{3}\.[0-9]{3}\.[0-9]{3}")';
else
    echo -e "WARNING: Package 'wget' not installed.";
fi
if [ -e /usr/local/bin/lynx ]; then
    alias nbs_exchange='lynx -dump http://www.nbs.rs/kursnaListaModul/srednjiKurs.faces?lang=eng | head -n41';
else
    echo -e "WARNING: Package 'lynx' not installed.";
fi
if [ -e /usr/local/bin/freecolor ]; then
    alias memory='freecolor -t -m';
else
    echo -e "WARNING: Package 'freecolor' not installed.";
fi
if [ -e /usr/local/bin/valgrind ]; then
    alias profilemyapp='G_DEBUG=gc-friendly G_SLICE=always-malloc valgrind --tool=memcheck --leak-check=full';
else
    echo -e "WARNING: Package 'valgrind' not installed.";
fi
if [ -e /usr/local/bin/fuse-ext2 ]; then
    alias mount_extfs='sudo fuse-ext2 -o ro,allow_other,gid=0,umask=002';
else
    echo -e "WARNING: Package 'fusefs-ext2' not installed.";
fi
if [ -e /usr/local/bin/ntfs-3g ]; then
    alias mount_ntfs='sudo ntfs-3g -o rw';
else
    echo -e "WARNING: Package 'fusefs-ntfs' not installed.";
fi
