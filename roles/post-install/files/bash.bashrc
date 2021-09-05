####### OPTIONNAL bashrc name #######
# /etc/bash_bashrc
# /etc/.bashrc
# /etc/bashrc
# /etc/bash.bashrc


# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# used for the prompt PS1
function PS1_get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
function update_PS1(){

    local PROMPT CHROOT force_color_prompt color_prompt

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        CHROOT=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color|*-256color) color_prompt=yes;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    #force_color_prompt=yes
    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
        else
        color_prompt=
        fi
    fi

    if [ "$color_prompt" = yes ]; then

        function get_color(){
            local COLORC BOLD DIM ITALIC UNDERLINE BLINK BACKGROUND COLOR FBACKGROUND

            COLORC="\033"

            if [ "$#" -le 2 ]; then
                if [ "$#" -eq 0 ]; then
                    COLORC+="[0;m"
                    echo ${COLORC}
                    return 0
                fi
                while (( "$#" )) ; do
                    case "${1}" in
                        -b|--bold)
                            BOLD=1
                            shift
                            ;;
                        -d|--dim)
                            DIM=1
                            shift
                            ;;
                        -i|--italic)
                            ITALIC=1
                            shift
                            ;;
                        -u|--underline)
                            UNDERLINE=1
                            shift
                            ;;
                        --bl|--blink)
                            BLINK=1
                            shift
                            ;;
                        --bk|--back|--background)
                            BACKGROUND=1
                            shift
                            ;;
                        --f-bk|--full-back)
                            FBACKGROUND=1
                            shift
                            ;;
                        [0-9][0-9][0-9]|[0-9][0-9]|[0-9]|[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])
                            COLOR=${1}
                            shift
                            ;;
                        *)
                            echo "Unknown parameter: ${1}" >&2
                            return 1
                    esac
                done

                if [ -z ${COLOR} ]; then
                    echo "Error you must provide a color"
                    return 1
                fi
            else
                echo "Error you provide so much parameter"
                return 1
            fi

            if [ "${#COLOR} " -le 3 ]; then
                COLORC+="["
                if ! [ -z "${BOLD}" ]; then
                    COLORC+="1;3"
                elif ! [ -z "${DIM}" ]; then
                    COLORC+="2;3"
                elif ! [ -z "${ITALIC}" ]; then
                    COLORC+="3;3"
                elif ! [ -z "${UNDERLINE}" ]; then
                    COLORC+="4;3"
                elif ! [ -z "${BLINK}" ]; then
                    COLORC+="5;3"
                elif ! [ -z "${BACKGROUND}" ]; then
                    COLORC+="4"
                else
                    COLORC+="0;3"
                fi

                if [ "${#COLOR} " -gt 1 ]; then
                    COLORC+="8;5;"
                fi
                COLORC+="${COLOR}m"
            else
                COLORC+="]1"
                if [ -z "${FBACKGROUND}" ]; then
                    COLORC+="0"
                else
                    COLORC+="1"
                fi
                COLORC+=";"
                if ! [[ ${COLOR} == \#* ]]; then
                    COLORC+="#"
                fi
                COLORC+="${COLOR}\033\\"
            fi

            echo ${COLORC}
            return 0
        }

        ## Colors
        # BLACK => 0
        # RED => 1
        # GREEN => 2
        # YELLOW => 3
        # BLUE => 4
        # PURPLE => 5
        # CYAN => 6
        # WHITE => 7
        # ORANGE => 202

        # Normal Colors
        # local Black=$(get_color 0)
        local Red=$(get_color 1)
        # local Green=$(get_color 28)
        local Yellow=$(get_color 3)
        local Blue=$(get_color 31)
        local Purple=$(get_color 46)
        local Cyan=$(get_color 6)
        local White=$(get_color 7)
        # local Orange=$(get_color 202)

        # Bold
        # local BBlack=$(get_color -b 0)
        local BRed=$(get_color -b 1)
        local BGreen=$(get_color -b 2)
        local BYellow=$(get_color -b 3)
        # local BBlue=$(get_color -b 4)
        # local BPurple=$(get_color -b 5)
        # local BCyan=$(get_color -b 6)
        local BWhite=$(get_color -b 7)
        # local BOrange=$(get_color -b 202)

        # # Dim
        # local DBlack=$(get_color -d 0)
        # local DRed=$(get_color -d 1)
        # local DGreen=$(get_color -d 2)
        # local DYellow=$(get_color -d 3)
        # local DBlue=$(get_color -d 4)
        # local DPurple=$(get_color -d 5)
        # local DCyan=$(get_color -d 6)
        # local DWhite=$(get_color -d 7)
        # local DOrange=$(get_color -d 202)

        # # Italic
        # local IBlack=$(get_color -i 0)
        # local IRed=$(get_color -i 1)
        # local IGreen=$(get_color -i 2)
        # local IYellow=$(get_color -i 3)
        # local IBlue=$(get_color -i 4)
        # local IPurple=$(get_color -i 5)
        # local ICyan=$(get_color -i 6)
        # local IWhite=$(get_color -i 7)
        # local IOrange=$(get_color -i 202)

        # # Underline
        # local UBlack=$(get_color -u 0)
        # local URed=$(get_color -u 1)
        # local UGreen=$(get_color -u 2)
        # local UYellow=$(get_color -u 3)
        # local UBlue=$(get_color -u 4)
        # local UPurple=$(get_color -u 5)
        # local UCyan=$(get_color -u 6)
        # local UWhite=$(get_color -u 7)
        # local UOrange=$(get_color -u 202)

        # # Blink
        # local BlBlack=$(get_color --bl 0)
        # local BlRed=$(get_color --bl 1)
        # local BlGreen=$(get_color --bl 2)
        # local BlYellow=$(get_color --bl 3)
        # local BlBlue=$(get_color --bl 4)
        # local BlPurple=$(get_color --bl 5)
        # local BlCyan=$(get_color --bl 6)
        # local BlWhite=$(get_color --bl 7)
        # local BlOrange=$(get_color --bl 202)

        # # Background
        # local BgBlack=$(get_color --bk 0)
        # local BgRed=$(get_color --bk 1)
        # local BgGreen=$(get_color --bk 2)
        # local BgYellow=$(get_color --bk 3)
        # local BgBlue=$(get_color --bk 4)
        # local BgPurple=$(get_color --bk 5)
        # local BgCyan=$(get_color --bk 6)
        # local BgWhite=$(get_color --bk 7)
        local BgOrange=$(get_color --bk 52)

        # No color (reset)
        NC=$(get_color)

        local BK
        if [ "${MACHINE_LEVEL}" -ge 3 ] &>/dev/null; then
            BK=${BgOrange}
        else
            BK=""
        fi
        

        PROMPT="${Blue}${BK} \t ${White}${BK}${CHROOT:+($CHROOT)}"

        if [ "`id -u`" -eq 0 ]; then
            PROMPT+="${BRed}"
        else
            PROMPT+="${BWhite}"
        fi

        PROMPT+="${BK}\u${White}${BK}@"

        if [ "${MACHINE_LEVEL}" -ge 2 ] &>/dev/null; then
            PROMPT+="${BRed}"
        elif [ "${MACHINE_LEVEL}" -eq 1 ] &>/dev/null; then
            PROMPT+="${BYellow}"
        else
            PROMPT+="${Cyan}"
        fi

        PROMPT+="${BK}\h${White}${BK}:${BGreen}\w ${White}\n${Yellow}\$(PS1_get_git_branch)${White}${BWhite}\$>${NC}"

        # Background terminal color
        echo -en $(get_color ffffff)
        echo -en $(get_color --f-bk 111222)

        unset -f get_color

    else
        PROMPT=" \t ${CHROOT:+($CHROOT)}\u@\h:\w\n\$(PS1_get_git_branch)$>"
    fi
    
    PS1=$PROMPT
    return 0
}
update_PS1
unset -f update_PS1
