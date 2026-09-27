# ---------------------
# Env variables
# ---------------------
$env.EDITOR = default "nvim"
$env.VISUAL = default "nvim"
$env.SHELL = "/home/ibaby/.local/bin/nu"

source "~/.cargo/env.nu"
$env.CARGO_HOME = $env.CARGO_HOME? | default $"($env.HOME)/.cargo"

$env.CARGO_TARGET_DIR = ($env.HOME + "/.cargo-target")
mkdir ~/goinfre/.cargo-src/ # I use it as a symlink for ~/.cargo/registry/src/

if ("~/sgoinfre" | path exists) {
    $env.XDG_CACHE_HOME = $"($env.HOME)/sgoinfre"
}

# ---------------------
# PATH env var
# ---------------------
let paths: list<string> = [
    $"($env.HOME)/.local/bin"
    $"($env.HOME )/.fzf/bin"
    $"($env.CARGO_HOME)/bin"
    "/usr/local/bin"
    "/usr/local/sbin"
]

for path in $paths {
    if ($path | path exists) {
        path add $path
    }
}

# ---------------------
# Zoxide
# ---------------------
let zoxide_path = "~/.zoxide.nu"
if not ($zoxide_path | path exists) and (which zoxide | is-not-empty) {
    ^zoxide init nushell | save --force $zoxide_path
}

# ---------------------
# Carapace
# ---------------------
let carapace_path = $"($nu.cache-dir)/carapace.nu"
$env.CARAPACE_BRIDGES = 'fish'
if not ($carapace_path | path exists) and (which carapace | is-not-empty) {
    mkdir $nu.cache-dir
    ^carapace _carapace nushell | save $carapace_path
}

# ---------------------
# Starship
# ---------------------
const starship_path = $"($nu.data-dir)/vendor/autoload/starship.nu"
if not ($starship_path | path exists) and (which starship | is-not-empty) {
    mkdir ($starship_path | path dirname)
    ^starship init nu | save -f $starship_path
}
