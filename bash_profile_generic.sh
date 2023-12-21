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
# Command line text editiong options
# ------------------------------------------------------------------------------
set -o vi  # Set Vi as default text editing mode


# ------------------------------------------------------------------------------
# User specific aliases
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# User specific functions
# ------------------------------------------------------------------------------
function check_required_pkgs() {
    ts=$( date '+%Y-%m-%d %k:%M:%S' )
    printf "%s Checking for required packages ...\\n" "$ts"
    if [ -f /usr/bin/whereis ]; then
        apps="find freecolor fuse-ext2 lynx most ntfs-3g rsync valgrind wget"
        for app in $apps; do
            result=$( whereis $app )
            ts=$( date '+%Y-%m-%d %k:%M:%S' )
            if [ "$result" != "$app"":" ]; then
                printf "%s App %10s ... NOT INSTALLED\\n" "$ts" "$app"
            else
                printf "%s App %10s ... INSTALLED\\n" "$ts" "$app"
            fi
        done
    else
        ts=$( date '+%Y-%m-%d %k:%M:%S' )
        printf "%s Can not find 'whereis' ... ABORTING!\\n" "$ts"
    fi
}

check_required_pkgs