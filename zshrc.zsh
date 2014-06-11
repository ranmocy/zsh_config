# Switch for benchmark
# BENCHMARK=true

if [[ $BENCHMARK == true ]]; then
    BENCHMARK_TOTAL_BEGIN_TIME=`date +%s.%N`
fi

benchmark(){
    if [[ $BENCHMARK == true ]]; then
        start_time=`date +%s.%N`
        source $1
        echo $1:"\t"$(( `date +%s.%N` - $start_time ))
    else
        source $1
    fi
}


# Path to your oh-my-zsh configuration.
ZSH=$HOME/.zshrc.d/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

benchmark $ZSH/oh-my-zsh.sh
benchmark ~/.zshrc.d/super.zsh
benchmark ~/.zshrc.d/alias.zsh
benchmark ~/.zshrc.d/functions.zsh
benchmark ~/.zshrc.d/prompt.zsh
benchmark ~/.zshrc.d/auto_completion.zsh
benchmark ~/.zshrc.d/z/z.sh
benchmark ~/.zshrc.d/sensitive.zsh

if [[ $BENCHMARK == true ]]; then
  BENCHMARK_TOTAL_END_TIME=`date +%s.%N`
  BENCHMARK_TOTAL_TIME=$(( $BENCHMARK_TOTAL_END_TIME - $BENCHMARK_TOTAL_BEGIN_TIME ))
  echo Total: $BENCHMARK_TOTAL_TIME
fi
