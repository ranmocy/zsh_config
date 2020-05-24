# BENCHMARK=true

_get_current_milliseconds(){
    /usr/local/bin/gdate +%s.%N
}

if [[ $BENCHMARK == true ]]; then
    BENCHMARK_TOTAL_BEGIN_TIME=`_get_current_milliseconds`
fi

benchmark(){
    if [[ $BENCHMARK == true ]]; then
        start_time=`_get_current_milliseconds`
        $@
        echo $@:"\t"$(( `_get_current_milliseconds` - $start_time ))
    else
        $@
    fi
}

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zshrc.d/oh-my-zsh

# Set name of the theme to load.
# Look in $HOME/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ranmocy"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zshrc.d/custom

# Which plugins would you like to load? (plugins can be found in $HOME/.oh-my-zsh/plugins/*)
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(confirm notify cmdnotify nvm)

# User configuration

# Path
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi
export PATH=$HOME/bin_corp:$HOME/bin:$HOME/Library/Android/sdk/platform-tools:$PATH
fpath=($HOME/.zshrc.d/completions $fpath)

# Loading modules
if [ ! -f $ZSH/oh-my-zsh.sh ]; then
    git clone 'git://github.com/robbyrussell/oh-my-zsh.git' $ZSH
fi
if [ ! -f $HOME/.zshrc.d/z/z.sh ]; then
    git clone 'git://github.com/rupa/z.git' $HOME/.zshrc.d/z
fi
if [ ! -f $HOME/.zshrc.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    git clone 'git://github.com/zsh-users/zsh-syntax-highlighting.git' $HOME/.zshrc.d/zsh-syntax-highlighting
fi

benchmark source $ZSH/oh-my-zsh.sh
benchmark source $HOME/.zshrc.d/super.zsh
benchmark source $HOME/.zshrc.d/alias.zsh
benchmark source $HOME/.zshrc.d/functions.zsh
benchmark source $HOME/.zshrc.d/auto_completion.zsh
benchmark source $HOME/.zshrc.d/z/z.sh
benchmark source $HOME/.zshrc.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [ -f $HOME/bin_corp/sensitive.zsh ]; then
    benchmark source $HOME/bin_corp/sensitive.zsh
fi

if [[ $BENCHMARK == true ]]; then
    BENCHMARK_TOTAL_END_TIME=`_get_current_milliseconds`
    BENCHMARK_TOTAL_TIME=$(( $BENCHMARK_TOTAL_END_TIME - $BENCHMARK_TOTAL_BEGIN_TIME ))
    echo Total: $BENCHMARK_TOTAL_TIME
fi
