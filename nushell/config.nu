# ---------------------
# Nushell config
# use `config nu --doc` to see all available config options
# ---------------------
$env.config = ($env.config | merge deep {
	# Deactivate the banner when Nushell start
    show_banner: false,

    # Default editor (change this to your preferred editor, e.g. "nano", "code", "emacs")
    buffer_editor: "nvim",

    # use_kitty_protocol (bool): Enable the Kitty keyboard enhancement protocol.
    use_kitty_protocol: true,

    # history: {
    #     # history.file_format (string): The format used for the command history file.
    #     file_format: sqlite,
    #
    #     # history.max_size (int): Maximum number of entries allowed in the history.
    #     max_size: 3_000,
    # },
})

# ---------------------
# Carapace
# ---------------------
source $"($nu.cache-dir)/carapace.nu"

# ---------------------
# Custom exports
# ---------------------
use custom *

# ---------------------
# Starship
# ---------------------
source ($nu.data-dir | path join "vendor" "autoload" "starship.nu")

# ---------------------
# Zoxide
# ---------------------
source "~/.zoxide.nu"

use nu_scripts/stdlib-candidate-archive/std-rfc/clip
use nu_scripts/modules/background_task/task.nu
use nu_scripts/modules/fun/wordle.nu
use nu_scripts/aliases/eza/eza-aliases.nu *
