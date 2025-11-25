#!/usr/bin/env python3

import i3ipc
import subprocess
import sys
import time
import logging

# Configuração de ícones/nomes para classes de janelas
# Use o comando 'xprop WM_CLASS' para descobrir o nome da classe
WINDOW_ICONS = {
    "firefox": "Firefox",
    "Brave-browser": "Brave",
    "google-chrome": "Chrome",
    "Alacritty": "Term",
    "Kitty": "Term",
    "Code": "VSCode",
    "Spotify": "Spotify",
    "discord": "Discord",
    "Thunar": "Arquivos",
    "Nemo": "Arquivos",
    "libreoffice": "Office",
    "org.gnome.Nautilus": "Arquivos",
    "vlc": "VLC",
    "obsidian": "Obsidian"
}

def get_i3_socket():
    """Tenta obter o caminho do socket do i3 via comando."""
    try:
        output = subprocess.check_output(["i3", "--get-socketpath"]).decode("utf-8").strip()
        return output
    except Exception:
        return None

def on_window_change(i3, _):
    try:
        # CORREÇÃO CRÍTICA:
        # Em vez de get_workspaces(), usamos get_tree().workspaces()
        # Isso retorna objetos 'Con' (Container) reais que possuem as folhas (janelas)
        tree = i3.get_tree()
        workspaces = tree.workspaces()
        
        for ws in workspaces:
            # Pula workspaces sem número definido (scratchpad, etc)
            if ws.num is None:
                continue

            # Obtém todas as janelas (leaves) dentro deste workspace
            leaves = ws.leaves()
            
            classes = set()
            for leaf in leaves:
                # window_class pode ser None para algumas janelas internas
                if leaf.window_class:
                    classes.add(leaf.window_class)
            
            # Lógica de nomeação
            if not classes:
                # Se vazio, usa apenas o número
                new_name = str(ws.num)
            else:
                # Mapeia as classes para os nomes bonitos
                icon_list = [WINDOW_ICONS.get(cls, cls) for cls in classes]
                # Remove duplicatas e ordena
                icon_str = " | ".join(sorted(list(set(icon_list))))
                new_name = f"{ws.num}: {icon_str}"
            
            # Só envia comando se o nome for diferente para economizar recursos
            if ws.name != new_name:
                print(f"Renomeando: {ws.name} -> {new_name}")
                i3.command(f'rename workspace "{ws.name}" to "{new_name}"')
                
    except Exception as e:
        print(f"Erro no loop: {e}")

# --- Inicialização com Retry ---
max_retries = 5
for attempt in range(max_retries):
    try:
        socket_path = get_i3_socket()
        if socket_path:
            ipc = i3ipc.Connection(socket_path=socket_path)
        else:
            ipc = i3ipc.Connection()
        break
    except Exception as e:
        if attempt < max_retries - 1:
            time.sleep(1)
        else:
            sys.exit(1)

# Event Listeners
# Escuta eventos de janela e de workspace
ipc.on("window::new", on_window_change)
ipc.on("window::close", on_window_change)
ipc.on("window::move", on_window_change)
ipc.on("workspace::focus", on_window_change) # Garante atualização ao trocar

# Loop principal
try:
    # Executa uma vez na inicialização para corrigir nomes já existentes
    on_window_change(ipc, None)
    ipc.main()
except KeyboardInterrupt:
    sys.exit(0)
