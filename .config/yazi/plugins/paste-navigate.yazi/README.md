# paste-navigate.yazi

A Yazi plugin that allows easy navigation or creation of new files and directories by pasting a path or typing it manually. Useful when some wiki tells you that a config file should be in ~/.config/some-folder/some-file.conf, instead of creating both the directory and the file manually, you can just paste the whole path and the plugin will create everything.

https://github.com/user-attachments/assets/c3378f82-0ec6-43e8-aab4-28d663d1343b

## Installation

**Via ya pkg:**
```bash
ya pkg add pakhromov/paste-navigate
```

**Manual:**
```bash
git clone https://github.com/pakhromov/paste-navigate.yazi ~/.config/yazi/plugins/paste-navigate.yazi
```

Add the following to `~/.config/yazi/keymap.toml`:
```toml
[[mgr.prepend_keymap]]
on = "<C-p>"
run = "plugin paste-navigate"
desc = "Navigate to path"
```

## Usage

Press the keybind to open the input dialog, then type any path:

- **Existing directory** - navigates to it
- **Non-existent directory** - creates it and navigates to it
- **File path** - creates any missing parent directories, creates the file if it doesn't exist, navigates to its directory and reveals it

Supports `~/`, `$HOME`, and relative paths.
