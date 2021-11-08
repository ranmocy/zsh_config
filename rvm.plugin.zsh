# RVM, lazy loaded
#
# Dependence:
# * plugin base

function rvm() {
    # Boost Ruby
    export RUBY_GC_HEAP_INIT_SLOTS=1000000 # 1M
    export RUBY_GC_HEAP_FREE_SLOTS=500000  # 0.5M
    export RUBY_GC_HEAP_GROWTH_FACTOR=1.1
    export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=10000000 # 10M
    export RUBY_GC_MALLOC_LIMIT_MAX=1000000000    # 1G
    export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1

    # Disable auto adding lines to my precise dotfiles
    export rvm_ignore_dotfiles=yes
    if [ -s "$HOME/.rvm/scripts/rvm" ]; then
        unset -f rvm
        export PATH=$HOME/.rvm/bin:$PATH
        source "$HOME/.rvm/scripts/rvm"
        rvm $@ # call real script
    else
        confirm "RVM is not installed, do you want to install?" && \
        (
            type gpg && gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB;
            curl -sSL https://get.rvm.io | bash
         )
    fi
}

# Rbenv
# current-rbenv-info() {
#   local version=$(rbenv version-name)
#   # local gemset=$(rbenv gemset active 2&>/dev/null | sed -e ":a" -e '$ s/\n/+/gp;N;b a' | head -n1)
#   local gemset=$(rbenv gemset active 2&>/dev/null | head -n1)
#   if [ -z "$gemset" ]; then
#     echo "$version"
#   else
#     echo "$version@$gemset"
#   fi
# }
