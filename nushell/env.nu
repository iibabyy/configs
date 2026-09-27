# ---------------------
# Env variables
# ---------------------
$env.EDITOR = default "nvim"
$env.VISUAL = default "nvim"
$env.SHELL = "/home/ibaby/.local/bin/nu"

source "~/.cargo/env.nu"
$env.CARGO_HOME = $env.CARGO_HOME? | default $"($env.HOME)/.cargo"

if ("~/sgoinfre" | path exists) {
    $env.XDG_CACHE_HOME = $"($env.HOME)/sgoinfre"
}

# ---------------------
# Symlinks
# ---------------------
def setup-symlink-dir [
    path: path # the path of the symlink
    target: path, # the directory to link to
  --abort-if-not-found
] {
    try {
        if ($target | path exists) and ($target | path type) != 'dir' {
            error make --unspanned $"`($target)` is not a directory"
        } else if ($path | path exists) and ($path | path type) != 'symlink' {
            error make --unspanned $"`($path)` already exists and is not a symlink"
        }

        if $abort_if_not_found and not ($target | path exists) {
            return
        }

        mkdir $target
        if not ($path | path exists) {
            ln -s ($target | path expand) $path
        }
    }
}

$env.CARGO_TARGET_DIR = $"($env.HOME)/.cargo-target"
setup-symlink-dir $env.CARGO_TARGET_DIR ~/goinfre/.cargo-target

setup-symlink-dir ~/.cargo/registry/src/ ~/sgoinfre/.cargo-src/ --abort-if-not-found

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
