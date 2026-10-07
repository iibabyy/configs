export alias res = exec nu
export alias c = clear

export alias v = nvim .
export alias vi = nvim
export alias vc = nvim ~/.config/
export alias vu = nvim $nu.default-config-dir # ~/.config/nushell
export alias vn = nvim ~/.config/nvim/

export alias ze = zellij
export alias zm = zellij attach --create main --layout main
export alias zk = zellij kill-all-sessions --yes

export alias ls = ls -d
export alias l = ls
export alias la = ls -la

export alias gg = lazygit
export alias gd = lazydocker

export alias agy = agy --dangerously-skip-permissions

export alias exa = ^exa --icons
export alias x = exa

# Git Aliases
export alias g = git
export alias ga = git add
export alias gc = git commit '-m'
export alias gcl = git clone
export alias gp = git push
export alias gpl = git pull
export alias gst = git status
export alias gsw = git switch

# Cargo Aliases
export alias cr = cargo run
export alias cb = cargo build
export alias cmod = cargo modules structure
export alias ct = cargo nextest run
export alias cw = cargo watch '-q' '-c' '-x'
