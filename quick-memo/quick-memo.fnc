function _send_mail_quick_memo() {
    [ -z $1 ] && echo "need e-mail address to send email." && return

    local subject="Quick Memo ($(date))"
    cat ${HOME}/.quick-memo/quick_memo.md | mail -s "${subject}" "$1"
    echo "e-mail (quick memo) has been sent to $1"
}

function _quick_memo() {
    if ! type gsed > /dev/null 2>&1; then
        echo "error: you need to install gsed (gnu-sed)"
        echo "install: brew install gnu-sed"
        return
    fi

    local quick_memo_dir="${HOME}/.quick-memo"
    mkdir -p ${quick_memo_dir}

    #header="## =====> $(date '+%Y%m%d %H:%M:%S') <=====\n\n"
    header="## =====> $(date) <=====\n\n"
    gsed -i -e "1s/^/${header}/" ${quick_memo_dir}/quick_memo.md
    vim ${quick_memo_dir}/quick_memo.md
}
alias qm='_quick_memo'
alias qmmail='_send_mail_quick_memo'
