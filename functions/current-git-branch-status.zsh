function current-git-branch-status {
    update-current-git-info
    if [ -n "$__CURRENT_GIT_BRANCH" ]; then
        local s="$PR_GREEN$__CURRENT_GIT_BRANCH$PR_LIGHT_BLUE"
        case "$__CURRENT_GIT_BRANCH_STATUS" in
            ahead)
                s+="↑"
                ;;
            diverged)
                s+="↕"
                ;;
            behind)
                s+="↓"
                ;;
        esac
        if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
            s+="⚡"
        fi
        echo "$s$PR_NO_COLOUR"
    fi
}
