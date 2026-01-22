

# ~/.config/zsh/prompt.zsh

autoload -Uz colors add-zsh-hook
colors

# Colors

C_RESET='%f'
C_USER='%F{cyan}'
C_HOST='%F{blue}'
C_PATH='%F{blue}'
C_GIT='%F{magenta}'
C_OK='%F{green}'
C_ERR='%F{red}'
C_TIME='%F{yellow}'
C_DIVIDER='%F{white}'

# Git colors
GIT_MODIFIED_COLOR='%F{214}'   # orange
GIT_ADDED_COLOR='%F{green}'
GIT_DELETED_COLOR='%F{red}'
GIT_UNTRACKED_COLOR='%F{yellow}'
GIT_COLOR_RESET='%f'

# Icons
DIRECTORY_ICON=""

GIT_ICON=""
GIT_MODIFIED_ICON=""    # modified (unstaged)
GIT_STAGED_ICON="●"      # staged
GIT_UNTRACKED_ICON="?"   # untracked
GIT_DELETED_ICON="✖"     # deleted

#Command run time

CMD_START_TIME=0
CMD_DURATION=""

function prompt_preexec() {
  CMD_START_TIME=$EPOCHREALTIME
}
function prompt_precmd() {
  CMD_DURATION=""

  (( CMD_START_TIME == 0 )) && return

  local elapsed
  elapsed=$(( EPOCHREALTIME - CMD_START_TIME ))

  # show only if >= 1 second
  (( elapsed < 1 )) && return

  CMD_DURATION=$(printf "⏱ %.2fs" "$elapsed")
  CMD_START_TIME=0
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec prompt_preexec
add-zsh-hook precmd prompt_precmd
# Git

git_branch() {
  git symbolic-ref --short HEAD 2>/dev/null
}


git_dirty_icons() {
  local git_status icons=""
  git_status=$(git status --porcelain 2>/dev/null) || return

  # unstaged modifications
  echo "$git_status" | grep -q '^ M' &&
    icons+=" ${GIT_MODIFIED_COLOR}${GIT_MODIFIED_ICON}${GIT_COLOR_RESET}"

  # staged (added / modified / renamed / deleted)
  echo "$git_status" | grep -q '^[AMDR]' &&
    icons+=" ${GIT_ADDED_COLOR}${GIT_STAGED_ICON}${GIT_COLOR_RESET}"

  # deleted (unstaged)
  echo "$git_status" | grep -q '^ D' &&
    icons+=" ${GIT_DELETED_COLOR}${GIT_DELETED_ICON}${GIT_COLOR_RESET}"

  # untracked
  echo "$git_status" | grep -q '^??' &&
    icons+=" ${GIT_UNTRACKED_COLOR}${GIT_UNTRACKED_ICON}${GIT_COLOR_RESET}"

  echo "$icons"
}
# update_git() {
#   if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
#     GIT_INFO=" $(git_branch)$(git_dirty)"
#   else
#     GIT_INFO=""
#   fi
# }

update_git() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    GIT_INFO="${GIT_ICON} $(git_branch)$(git_dirty_icons)"
  else
    GIT_INFO=""
  fi
}

add-zsh-hook chpwd update_git
add-zsh-hook precmd update_git

STATUS_SYMBOL='%(?.%F{green}✔.%F{red}✘)%f'
# Divider

divider() {
  local char="-"
  printf '%*s' "$COLUMNS" '' | tr ' ' "$char"
}

PROMPT='
%F{white}$(divider)%f
%F{cyan}%n%f@%F{cyan}%m%f %F{blue}${CMD_DURATION}%f %F{magenta}${GIT_INFO}%f  
%F{yellow}${DIRECTORY_ICON}%f %F{yellow}%~%f
${STATUS_SYMBOL} %F{red}󰅂%f '

RPROMPT='%F{blue}%D{%a|%d/%m/%y|%H:%M:%S}%f'

