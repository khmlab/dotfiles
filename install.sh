#!/usr/bin/env zsh
############################
# This script creates symlinks from the home directory to any desired dotfiles in $HOME/dotfiles
# And also installs MacOS Software
# And also installs Homebrew Packages and Casks (Apps)
# And also sets up VS Code
############################

# dotfiles directory
dotfiledir="${HOME}/dotfiles"

# list of files/folders to symlink in ${homedir}
files=(zshrc zprofile zprompt bashrc bash_profile bash_prompt aliases)

# change to the dotfiles directory
echo "Changing to the ${dotfiledir} directory"
cd "${dotfiledir}" || exit

# create symlinks (will overwrite old dotfiles)
for file in "${files[@]}"; do
    echo "Creating symlink to $file in home directory."
    ln -sf "${dotfiledir}/.${file}" "${HOME}/.${file}"
done


if [[ "$(uname)" == "Darwin" ]]; then
    echo "Detected macOS, running setup for macOS"
    # Add macOS specific commands here
    # Run the MacOS Script
    ./macOS.sh
    # Run the Homebrew Script
    ./brew.sh
    # Run VS Code Script
    ./vscode.sh
    echo "Installation Complete!"
elif [[ "$(uname)" == "Linux" ]]; then
    echo "Running on Linux"
    # Add Linux specific commands here
else
    echo "Unknown operating system"
    # Handle the case of an unknown operating system here
fi
