function load_pyenv
    # Determine which venv folder to use
    if test (count $argv) -gt 0
        set venv_dir $argv[1]
    else if test -d venv
        set venv_dir venv
    else if test -d .venv
        set venv_dir .venv
    else if test -d env
        set venv_dir env
    else if test -d .env
        set venv_dir .env
    else
        echo "⚠️  No virtualenv folder found (tried: venv, .venv, env, .env)."
        return 1
    end

    # Locate an activation script
    if test -f $venv_dir/bin/activate.fish
        source $venv_dir/bin/activate.fish
        echo "Activated virtualenv (Fish) in '$venv_dir'"
    else if test -f $venv_dir/bin/activate
        # fallback to POSIX activate (works in Fish too, though less ideal)
        source $venv_dir/bin/activate
        echo "Activated virtualenv (POSIX) in '$venv_dir'"
    else if test -f $venv_dir/Scripts/activate.fish
        # Windows layout
        source $venv_dir/Scripts/activate.fish
        echo "Activated virtualenv (Fish) in '$venv_dir'"
    else if test -f $venv_dir/Scripts/activate
        source $venv_dir/Scripts/activate
        echo "Activated virtualenv (POSIX) in '$venv_dir'"
    else
        echo "❌  No activation script found in '$venv_dir'."
        return 1
    end
end
