#!/usr/bin/env zsh

# Check if Homebrew's bin exists and if it's not already in the PATH
if [ -x "/opt/homebrew/bin/brew" ] && [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

# Install VS Code Extensions
extensions=(
    monokai.theme-monokai-pro-vscode
    PKief.material-icon-theme
    ms-python.python
    ms-python.pylint
    ms-python.vscode-pylance
    ms-python.debugpy
    ms-python.black-formatter
    ms-vscode-remote.vscode-remote-extensionpack
    ms-azuretools.vscode-docker
    GitHub.copilot
    formulahendry.code-runner
    ritwickdey.LiveServer
)

# Get a list of all currently installed extensions.
installed_extensions=$(code --list-extensions)

for extension in "${extensions[@]}"; do
    if echo "$installed_extensions" | grep -qi "^$extension$"; then
        echo "$extension is already installed. Skipping..."
    else
        echo "Installing $extension..."
        code --install-extension "$extension"
    fi
done

echo "VS Code extensions have been installed."

# Define the target directory for VS Code user settings on macOS
VSCODE_USER_SETTINGS_DIR="${HOME}/Library/Application Support/Code/User/"

# Check if VS Code settings directory exists
if [ -d "$VSCODE_USER_SETTINGS_DIR" ]; then
    # Backup existing settings.json and keybindings.json, if they exist
    cp "${VSCODE_USER_SETTINGS_DIR}/settings.json" "${VSCODE_USER_SETTINGS_DIR}/settings.json.backup"

    # Copy your custom settings.json and keybindings.json to the VS Code settings directory
    cp "settings/vscode_settings.json" "${VSCODE_USER_SETTINGS_DIR}/settings.json"

    echo "VS Code settings have been updated."
else
    echo "VS Code user settings directory does not exist. Please ensure VS Code is installed."
fi
