#!./bin/python
import i3ipc
import signal
import sys

icons = {
    # Navegadores
    "firefox": "",
    "Google-chrome": "",
    "Chromium": "",
    "Brave": "󰂲",
    "Brave": "",
    "Tor Browser": "",

    # Terminais
    "Alacritty": "",
    "kitty": "",
    "gnome-terminal": "",
    "URxvt": "",
    "xterm": "",
    "wezterm": "",

    # Editores / IDEs
    "Code": "󰨞",
    "code-oss": "󰨞",
    "Sublime_text": "",
    "nvim-qt": "",
    "jetbrains-pycharm": "",
    "jetbrains-idea": "",
    "Emacs": "",

    # Escritório / Documentos
    "libreoffice-writer": "",
    "libreoffice-calc": "",
    "Zathura": "",
    "Evince": "",
    "Okular": "",

    # Arquivos
    "Thunar": "",
    "Nautilus": "",
    "Pcmanfm": "",
    "Dolphin": "",

    # Chat e comunicação
    "discord": "󰙯",
    "TelegramDesktop": "",
    "teams": "",
    "Slack": "",
    "Element": "󰞷",
    "Signal": "󰍡",
    "zoom": "",
    "Skype": "",

    # Música, vídeo, streaming
    "Spotify": "",
    "Spotify Premium": "",
    "vlc": "",
    "mpv": "",
    "obs": "",
    "Audacious": "",

    # Notas, produtividade
    "Obsidian": "󰎚",
    "Notion": "󰊄",
    "Standard Notes": "󱞁",
    "Joplin": "󰎞",
    "keepassxc": "",
    "Bitwarden": "",

    # Desenvolvimento / Docker / Web
    "Insomnia": "",
    "Postman": "",
    "Docker": "",
    "dbeaver": "",

    # Sistema e utilitários
    "pavucontrol": "",
    "blueman-manager": "",
    "Gparted": "",
    "nvidia-settings": "󰍹",
    "htop": "",
    "VirtualBox Manager": "",

    # Games
    "Steam": "",
    "Lutris": "",
    "heroic": "󰻶",

    # Fallback
    "default": ""
}

# Get icon for a given window
def get_icon(window):
    cls = window.window_class
    return icons.get(cls, "")

# Rename all workspaces with icons based on focused windows
def rename_workspaces(i3):
    for ws in i3.get_workspaces():
        workspace = i3.get_tree().find_by_id(ws.ipc_data['id'])
        name = ws.name.split(':')[0]  # Get workspace number

        if workspace and workspace.leaves():
            focused = workspace.leaves()[0]
            icon = get_icon(focused)
            title = focused.name.split(' - ')[-1][:20]  # Short title
            new_name = f"{name}: {icon} {title}"
        else:
            new_name = f"{name}: "

        if ws.name != new_name:
            i3.command(f'rename workspace "{ws.name}" to "{new_name}"')

# Setup IPC
i3 = i3ipc.Connection()

# First renaming
rename_workspaces(i3)

# Event listeners
def on_event(i3, e):
    rename_workspaces(i3)

i3.on("window::new", on_event)
i3.on("window::close", on_event)
i3.on("window::move", on_event)
i3.on("window::title", on_event)
i3.on("workspace::focus", on_event)

# Keep running
signal.signal(signal.SIGINT, lambda sig, frame: sys.exit(0))
i3.main()

