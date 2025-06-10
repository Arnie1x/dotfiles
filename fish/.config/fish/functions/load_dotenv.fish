function load_dotenv
    # Determine which file to load
    if test (count $argv) -gt 0
        set envfile $argv[1]
    else
        set envfile .env
    end

    # Check existence
    if not test -f $envfile
        echo "⚠️  File '$envfile' not found."
        return 1
    end

    echo "Loading environment from $envfile"

    # Read and export each KEY=VALUE
    for line in (cat $envfile)
        # skip blank lines and comments
        if not string match -qr '^\s*($|#)' -- $line
            # split on first '='
            set pair (string split -m1 '=' -- $line)
            set key  $pair[1]
            set val  $pair[2]
            # skip empty values
            if not test -z "$val"
                set -gx $key $val
            end
        end
    end
end
