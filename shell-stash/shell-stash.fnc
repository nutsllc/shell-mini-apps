# --------------------------------------------
# Shell Stash
# --------------------------------------------
function _usage() {
    echo "Usage: ss [OPTIONS] [COMMAND] FILE"
    echo "  This script will move/copy a file/directory to temporary space named Stash."
    echo
    echo "Command:"
    echo "  p | pop                        picked file/directory out from Stash."
    echo "  a | popall                     picked all file/directory out within Stash."
    echo "  e | empty                      empty Stash."
    echo
    echo "Options:"
    echo "  -h, --help                     show help."
    echo "  -v, --version                  show script version."
    echo
}

function _shell_stash() {
    #local stashDir=${DOTPATH}/.ShellStash
    local stashDir=${HOME}/.shell-stash
    mkdir -p ${stashDir}

    [ ${#@} -eq 0 ] && {
        #echo "========================== Stash =========================="
        ls -lAGhF ${stashDir} | sed '1d'
        #echo "==========================================================="
        echo "$(ls -lAG ${stashDir} | sed '1d' | wc -l) item(s) in Shell Stash."
        return 0
    }

    local mvORcp=mv
    local arg=()

    while (( $# > 0 )); do
        case $1 in
            -h )
                _usage
                return 0
                ;;
            -v )
                echo "ShellStash v1.0.0"
                return 0
                ;;
            -* )
                if [[ "$1" =~ 'c' ]]; then
                    mvORcp=cp
                fi
                shift
                ;;
            * )
                arg+=$1
                shift
                ;;
        esac
    done

#    echo "arg: ${arg}"
#    echo "arg[0]: ${arg[0]}"
#    echo "arg[1]: ${arg[1]}"
#    echo "arg[2]: ${arg[2]}"
#    echo "mvORcp: ${mvORcp}"

    case ${arg[1]} in
        e | empty )
            rm -rf ${stashDir} && echo "empty shell stash."
            return 0
            ;;
        p | pop )
            [ -z ${arg[2]} ] && {
                local target=$(
                    find ${stashDir} -mindepth 1 -maxdepth 1 | \
                    peco --prompt "Shell Stash>"
                )
            } || target=${stashDir}/${arg[2]}

            [ -e "$(basename ${target})" ] && {
                echo "$(basename ${target}) is already exist."
                return 1
            }

            [ ! -z ${target} ] && {
                [ ${mvORcp} = 'cp' ] && {
                    ${mvORcp} -r "${target}" .
                } || {
                    ${mvORcp} "${target}" .
                }
                echo "pop: $(basename ${target})"
            }
            ;;
        a | all )
            mv ${stashDir}/* .
            echo "pop all file/directory"
            return 0
            ;;
        * )
            [ ! -e "${arg}" ] && {
                echo "no file/dir"
                return 1
            }

            [ ! -e "${stashDir}/${arg}" ] && {
                [ ${mvORcp} = 'cp' ] && {
                    ${mvORcp} -r "${arg}" ${stashDir}
                } || {
                    ${mvORcp} "${arg}" ${stashDir}
                }
                echo "put: ${arg}"
            } || {
                for i in $(seq 99); do
                    filename="${arg}-$i"
                    [ ! -e "${stashDir}/${filename}" ] && {
                        ${mvORcp} "${arg}" "${stashDir}/${filename}"
                        echo "put: ${filename}"
                        break;
                    }
                done
            }
            ;;
    esac
}
alias ss='_shell_stash'
