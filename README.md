# Dotfiles

Personal configuration files for a comfortable terminal environment.

## Included Components

### 1. Shell Environment (Zsh)

* **.zshenv**: Environment variables, PATH, and local `.env` loading.
* **.zshrc**: Interactive shell settings including completion, aliases, and NVM lazy loading.
* **Powerlevel10k**: Highly customizable Zsh theme configuration.
* **Zsh-autosuggestions**: Fish-like fast autosuggestions for Zsh.

### 2. Neovim Configuration

* **External Repo**: Automatically clones `config-nvim` into `~/.config/nvim` during setup.
* **Features**:
  * **LSP**: Integrated with Mason for easy server management.
  * **UI**: TokyoNight theme, Lualine, and Noice for enhanced visuals.
  * **Tools**: ToggleTerm (with Lazygit integration), Telescope, and Neo-tree.

### 3. Terminal & Tools

* **Tmux**: Terminal multiplexer with true color support.
* **Curl**: Configured to work seamlessly with system-wide proxies.
* **LSD**: A modern replacement for the `ls` command.

### 4. Automated Setup Scripts

* **`setup.sh`**: The master script that orchestrates the entire installation process.
* **`proxy_setup.sh`**: Interactively prompts for a proxy URL and automatically configures `git`, `apt`, `npm`, `curl`, and your local `~/.env` file.
* **`install_apps.sh`**: Installs required packages (e.g., `htop`, `jq`, `tmux`, `tree`, `zstd`, `build-essential`, `python3-pip`, `npm`, etc.).

---

## Installation

The setup process is highly automated. Just clone the repository and run the setup script.

### 1. Clone the repository

```bash
git clone https://github.com/joannefornet/dotfiles.git ~/dotfiles
cd ~/dotfiles

```

### 2. Run Setup

Execute the master setup script.

```bash
chmod +x setup.sh
./setup.sh

```

**During the setup:**

1. **Proxy Configuration:** The script will first ask for a proxy URL. If you are behind a corporate firewall, enter your proxy (e.g., `http://YOUR_PROXY_IP:PORT`). If you don't need a proxy, simply press `Enter` to leave it blank and skip.
2. **Automated Installation:** It will automatically install system applications, link dotfiles, set your default shell to Zsh, and configure Neovim.
3. **Restart:** Once the script finishes, restart your terminal for all changes (like the Zsh shell and Powerlevel10k prompt) to take full effect.

```
