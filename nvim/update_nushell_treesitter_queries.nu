def main []: nothing -> nothing {
    let remote = "https://raw.githubusercontent.com/nushell/tree-sitter-nu/main/queries/nu/"
    let local = (
      $env.XDG_DATA_HOME?
      | default ($env.HOME | path join ".local" "share")
      | path join "nvim" "lazy" "nvim-treesitter" "queries" "nu"
    )

    let files = [
        "folds.scm"
        "highlights.scm"
        "indents.scm"
        "injections.scm"
        "textobjects.scm"
    ]

    print "remote: " $remote
    print "local: " $local
    print "files: " $files

    mkdir $local
    $files | par-each {|file|
        http get $"($remote)/($file)" | save --force $"($local)/($file)"
    }
}
