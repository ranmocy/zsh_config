BENCHMARK_TOTAL_BEGIN_TIME=`date +%s.%N`

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

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

source $ZSH/oh-my-zsh.sh

# Switch for benchmark
# export BENCHMARK=true

benchmark_begin() {
  export BENCHMARK_START_TIME=`date +%s.%N`
}
benchmark_end() {
  export BENCHMARK_END_TIME=`date +%s.%N`
  if [[ $BENCHMARK == true ]]; then
    echo $1:$(( $BENCHMARK_END_TIME - $BENCHMARK_START_TIME ))
  fi
}

benchmark_begin; source $ZSH/oh-my-zsh.sh; benchmark_end oh-my-zsh;
benchmark_begin; source ~/.zshrc.d/super.zsh; benchmark_end super;
benchmark_begin; source ~/.zshrc.d/functions.zsh; benchmark_end functions;
benchmark_begin; source ~/.zshrc.d/alias.zsh; benchmark_end alias;
benchmark_begin; source ~/.zshrc.d/prompt.zsh; benchmark_end prompt;
benchmark_begin; source ~/.zshrc.d/auto_completion.zsh; benchmark_end auto_completion;
benchmark_begin; source ~/.zshrc.d/sensitive.zsh; benchmark_end functions;

if [[ $BENCHMARK == true ]]; then
  BENCHMARK_TOTAL_END_TIME=`date +%s.%N`
  export BENCHMARK_TOTAL_TIME=$(( $BENCHMARK_TOTAL_END_TIME - $BENCHMARK_TOTAL_BEGIN_TIME ))
  echo Total: $BENCHMARK_TOTAL_TIME
fi
