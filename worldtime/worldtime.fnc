function _print_world_time() {
    printf "Sydney:\t\t" && TZ=Australia/Sydney date "+[%l:%M %p] %A, %h %d, %Y"
    printf "Tokyo:\t\t" && TZ=Asia/Tokyo date "+[%l:%M %p] %A, %h %d, %Y"
    printf "Shanghai:\t" && TZ=Asia/Shanghai date "+[%l:%M %p] %A, %h %d, %Y"
    printf "London:\t\t" && TZ=Europe/London date "+[%l:%M %p] %A, %h %d, %Y"
    printf "New York:\t" && TZ=America/New_York date "+[%l:%M %p] %A, %h %d, %Y"
    printf "Los Angeles:\t" && TZ=America/Los_Angeles date "+[%l:%M %p] %A, %h %d, %Y"
}

#function _show_world_time() {
#    printf "Sydney:\t\t" && TZ=Australia/Sydney date
#    printf "Tokyo:\t\t" && TZ=Asia/Tokyo date
#    printf "Shanghai:\t" && TZ=Asia/Shanghai date
#    printf "London:\t\t" && TZ=Europe/London date
#    printf "New York:\t" && TZ=America/New_York date
#    printf "Los Angeles:\t" && TZ=America/Los_Angeles date
#}

function _show_world_time() {
    [ $# -eq 0 ] && {
        _print_world_time
    } || {
        while (( $# > 0 )); do
            _print_world_time | grep -i ${1:-''}
            shift
        done
    }
}
alias worldtime='_show_world_time'
