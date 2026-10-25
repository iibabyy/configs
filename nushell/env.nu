# ---------------------
# Env variables
# ---------------------
$env.EDITOR = default "nvim"
$env.VISUAL = default "nvim"
$env.SHELL = "/home/ibaby/.local/bin/nu"

source "~/.cargo/env.nu"
$env.CARGO_HOME = $env.CARGO_HOME? | default $"($env.HOME)/.cargo"
$env.CARGO_TARGET_DIR = $"($env.HOME)/.cargo-target/"

if ("~/sgoinfre" | path exists) {
    $env.XDG_CACHE_HOME = $"($env.HOME)/sgoinfre/.cache"
}

# ---------------------
# Symlinks
# ---------------------
def setup-symlink [
    target: path, # the path to link to
    path: path # the symlink to create
    --file
] {
    let path = $path | str trim --right --char '/'
    let target = $target | str trim --right --char '/'

    if ($path | path exists) and ($path | path type) != 'symlink' {
        error make --unspanned $"`($path)` already exists and is not a symlink"
    }

    if $file {
        touch $target
    } else {
        mkdir $target
    }

    if not ($path | path exists) {
        if $file {
            ln ($target | path expand) $path
        } else {
            ln -s ($target | path expand) $path
        }
    }
}

setup-symlink ~/goinfre/.cargo-target/ $env.CARGO_TARGET_DIR
setup-symlink ~/sgoinfre/.cargo-src/ ~/.cargo/registry/src

# ---------------------
# PATH env var
# ---------------------
let paths: list<string> = [
    $"($env.HOME)/.local/bin"
    $"($env.HOME )/.fzf/bin"
    $"($env.HOME )/.nvim/bin"
    $"($env.HOME )/go/bin"
    $"($env.HOME )/.opencode/bin"
    $"($env.CARGO_HOME)/bin"
    "/usr/local/bin"
    "/usr/local/sbin"
    "/opt/homebrew/bin"
]

for path in $paths {
    path add $path
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
mkdir $nu.cache-dir
let missing = not ($carapace_path | path exists)
let empty = not $missing and (ls $carapace_path).0.size == 0B
if ($missing or $empty) and (which carapace | is-not-empty) {
    ^carapace _carapace nushell | save $carapace_path --force
} else if $missing {
    "" | save $carapace_path
}

# ---------------------
# Starship
# ---------------------
const starship_path = $"($nu.data-dir)/vendor/autoload/starship.nu"
mkdir ($starship_path | path dirname)
let missing = not ($starship_path | path exists)
let empty = not $missing and (ls $starship_path).0.size == 0B
if ($missing or $empty) and (which starship | is-not-empty) {
    ^starship init nu | save -f $starship_path
} else if $missing {
    "" | save $starship_path
}
