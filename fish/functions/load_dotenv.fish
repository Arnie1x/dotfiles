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

    # Read and export each KEY=VALUE (use command cat to avoid bat alias)
    for line in (command cat $envfile)        
        # Skip blank lines and comments (lines starting with # or whitespace followed by #)
        if string match -qr '^\s*($|#)' -- $line
            continue
        end
        
        # Skip lines that don't contain '=' 
        if not string match -q '*=*' -- $line
            continue
        end
        
        # Split on first '=' only
        set pair (string split -m1 '=' -- $line)
        
        set key (string trim -- $pair[1])
        
        # Handle case where there might be no value after =
        if test (count $pair) -lt 2
            set val ""
        else
            set val (string trim -- $pair[2])
        end
        
        # Validate key name (must be valid variable name)
        if not string match -qr '^[a-zA-Z_][a-zA-Z0-9_]*$' -- $key
            echo "⚠️  Skipping invalid variable name: '$key'"
            continue
        end
        
        # Remove surrounding quotes from value if present
        if string match -qr '^".*"$' -- $val
            set val (string sub -s 2 -e -1 -- $val)
        else if string match -qr "^'.*'\$" -- $val
            set val (string sub -s 2 -e -1 -- $val)
        end
        
        # Set the environment variable (allow empty values)
        set -gx $key $val
        echo "✓ $key"
    end
end