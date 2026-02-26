# Icons
ICON_DIR=''
ICON_GIT=''
ICON_K8S=''
ICON_AZURE=''
ICON_TIME='󰔟'
ICON_DATE='󱑆'
ICON_COMMAND_STATUS='➜'

# Time info
_time_info="%F{yellow}[${ICON_DATE} %D{%f/%m/%y} ${ICON_TIME}%*]%f"

# Git info
_git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${ICON_GIT} %F{220}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}%1{✗%}%f"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}%1{%}%f"

# K8S info
k8s_prompt_info() {
    command -v kubectl > /dev/null || return

    local ctx ns
    ctx=$(kubectl config current-context 2> /dev/null)
    ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2> /dev/null)
    [[ -z $ns ]] && ns="default"

    echo "${ICON_K8S} ${JH_ZSH_THEME_K8S_PREFIX}$ctx:$ns${JH_ZSH_THEME_K8S_SUFFIX} "
}
JH_ZSH_THEME_K8S_PROMPT='$(k8s_prompt_info)'
JH_ZSH_THEME_K8S_PREFIX="%F{21}"
JH_ZSH_THEME_K8S_SUFFIX="%{$reset_color%}"

# Azure info
azure_prompt_info() {
    local subscription
    subscription=$(az account show | jq '.name' 2> /dev/null)

    [[ -z $subscription ]] && return

    echo "${ICON_AZURE} ${JH_ZSH_THEME_AZ_PREFIX}$subscription${JH_ZSH_THEME_AZ_SUFFIX} "
}
JH_ZSH_THEME_AZ_PROMPT='$(azure_prompt_info)'
JH_ZSH_THEME_AZ_PREFIX="%F{151}"
JH_ZSH_THEME_AZ_SUFFIX="%{$reset_color%}"

# Core
_command_status="%(?:%B%F{green}%1{${ICON_COMMAND_STATUS}%}%f%b :%B%F{red}%1{${ICON_COMMAND_STATUS}%}%f%b )"
_dir_info="${ICON_DIR} %F{cyan}%c%f "

PROMPT="
${_dir_info} ${_git_info} ${JH_ZSH_THEME_K8S_PROMPT} ${JH_ZSH_THEME_AZ_PROMPT} ${_time_info}
${_command_status} "