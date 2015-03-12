#compdef tmuxinator mux
#autoload

# Install:
# $ mkdir -p ~/.tmuxinator/completion
# $ cp _tmuxinator ~/.tmuxinator/completion
# $ vi ~/.zshrc  # add the following codes
# fpath=($HOME/.tmuxinator/completion ${fpath})
# autoload -U compinit
# compinit

_tmuxinator() {
  local commands projects
  commands=(
    'start:start a tmux session using project'\''s tmuxinator config'
    'open:create a new project file and open it in your editor'
    'copy:copy source_project project file to a new project called new_project'
    'delete:deletes the project called project_name'
    'implode:deletes all existing projects!'
    'list:list all existing projects'
    'doctor:look for problems in your configuration'
    'help:shows this help document'
    'version:shows tmuxinator version number'
  )
  projects=(${$(echo ~/.tmuxinator/*.yml):r:t})
  # commands=(${(f)"$(tmuxinator commands zsh)"})
  # projects=(${(f)"$(tmuxinator completions start)"})

  if (( CURRENT == 2 )); then
    _describe -t projects "tmuxinator projects" projects
    _describe -t commands "tmuxinator subcommands" commands
  elif (( CURRENT == 3)); then
    case $words[2] in
      copy|debug|delete|open|start)
        _arguments '*:projects:($projects)'
      ;;
    esac
  fi

  return
}

_tmuxinator
