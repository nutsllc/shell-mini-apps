function _display_directory_size() {
    printf "$(pwd)\t\t" && du -sh | cut -f1
}
alias dirsize="_display_directory_size"

function _display_sub_directory_size() {
    #du -sh ${1:-"$(pwd)"}/* 2>&1 | grep -v "Operation not permitted" | sort -hr
    du -sh ${1:-.}/* 2>&1 | grep -v "Operation not permitted" | head -n 10 | sort -hr
}
alias subdirsize="_display_sub_directory_size"

function _find_fat_files() {
    find ${1:-.} -type f -print0 |
        xargs -0 du |
        sort -rn |
        head -n 10 |
        cut -f2 |
        xargs -I{} du -sh {}
}
alias fatf='_find_fat_files'

function _find_fat_dirs() {
    find ${1:-.} -maxdepth 1 -type d -print0 |
        xargs -0 du -d 1 |
        sort -rn |
        uniq |
        head -n 11 |
        tail -n +2 |
        cut -f2 |
        xargs -I{} du -sh {}
}
alias fatd='_find_fat_dirs'
