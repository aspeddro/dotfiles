# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to the completion cache file
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-completions
  zsh-syntax-highlighting
  zsh-autosuggestions
  gh
)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# Add gcloub, bq and other google cloud binaries on PATH
# https://aur.archlinux.org/packages/google-cloud-cli
source /etc/profile.d/google-cloud-cli.sh

export GPG_TTY=$(tty)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Start SSH agent on login
# https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login/18915067#18915067
SSH_ENV=$HOME/.ssh/environment
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.utils ] && source ~/.utils

# opam configuration
[[ ! -r /home/pedro/.opam/opam-init/init.zsh ]] || source /home/pedro/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
