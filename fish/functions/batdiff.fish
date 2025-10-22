# Used to render git diffs with bat
function batdiff
    git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff
end