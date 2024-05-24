# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

export QT_QPA_PLATFORM="wayland;xcb"
export PATH="/usr/lib/ccache/bin/:$PATH"
export CHROME_EXECUTABLE=$(which google-chrome-stable)

# -----------------------------------------------------
# START STARSHIP
# -----------------------------------------------------
eval "$(starship init bash)"

# -----------------------------------------------------
# PYWAL
# -----------------------------------------------------
cat ~/.cache/wal/sequences

# -----------------------------------------------------
# PFETCH if on wm
# -----------------------------------------------------
pfetch
