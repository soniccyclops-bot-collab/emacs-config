# Installation & Setup Guide

Quick setup instructions for Nathan's Emacs configuration.

## Prerequisites

### 1. Emacs Version
Requires **GNU Emacs 28.1+**. Check your version:
```bash
emacs --version
```

Install latest Emacs:
```bash
# Ubuntu/Debian
sudo apt install emacs

# macOS with Homebrew  
brew install emacs

# Arch Linux
sudo pacman -S emacs
```

### 2. Git
```bash
git --version
# Install if needed: sudo apt install git
```

## Installation

### 1. Backup Existing Config
```bash
mv ~/.emacs.d ~/.emacs.d.backup
mv ~/.emacs ~/.emacs.backup  # if exists
```

### 2. Clone Configuration
```bash
git clone https://github.com/soniccyclops-bot-collab/emacs-config.git ~/.emacs.d
```

### 3. Install Language Servers

#### C/C++ (clangd)
```bash
# Ubuntu/Debian
sudo apt install clangd

# macOS
brew install llvm

# Arch Linux  
sudo pacman -S clang
```

#### Python (python-lsp-server)
```bash
pip3 install --user python-lsp-server[all]
# or
pipx install python-lsp-server[all]
```

#### Common Lisp (SBCL)
```bash
# Ubuntu/Debian
sudo apt install sbcl

# macOS
brew install sbcl

# Arch Linux
sudo pacman -S sbcl
```

#### Clojure & Leiningen
```bash
# Clojure CLI tools
curl -O https://download.clojure.org/install/linux-install-1.11.1.1113.sh
chmod +x linux-install-1.11.1.1113.sh
sudo ./linux-install-1.11.1.1113.sh

# Leiningen (user-space install)
curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/.local/bin/lein
chmod +x ~/.local/bin/lein

# Ensure ~/.local/bin is in PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 4. First Startup

```bash
emacs
```

**First startup will:**
1. Install all packages automatically (takes 2-5 minutes)
2. Compile byte-code for faster loading
3. Download and install Nerd Fonts (if needed)

**If startup fails:**
- Check network connection
- Restart Emacs and wait for packages to finish installing
- Check `*Messages*` buffer for specific errors

### 5. Font Setup (Optional)

For best icon display, install Nerd Fonts:
```bash
# In Emacs
M-x nerd-icons-install-fonts

# Or manually download from https://www.nerdfonts.com/
```

## Post-Installation

### Create Local Config
Create `~/.emacs.d/local.el` for personal settings:
```elisp
;; ~/.emacs.d/local.el
(setq user-full-name "Nathan"
      user-mail-address "nathan@example.com")

;; Custom project paths
(setq projectile-project-search-path '("~/code-projects/" "~/repos/"))

;; Preferred theme
(load-theme 'doom-tomorrow-night t)
```

### Test Language Support

#### Test C++ LSP
```bash
mkdir ~/test-cpp && cd ~/test-cpp
cat > hello.cpp << 'EOF'
#include <iostream>
int main() {
    std::cout << "Hello World!" << std::endl;
    return 0;
}
EOF

emacs hello.cpp
# Should show LSP symbols, completion, etc.
```

#### Test Python
```python
# Create test.py
def hello(name):
    return f"Hello {name}!"

if __name__ == "__main__":
    print(hello("World"))
    
# Open in Emacs: emacs test.py
# Test: C-c C-c to send to Python shell
```

#### Test Clojure
```bash
mkdir ~/test-clojure && cd ~/test-clojure
lein new app hello
cd hello
emacs src/hello/core.clj
# In Emacs: C-c C-j to start CIDER REPL
```

## Quick Test Commands

Once Emacs is running, try these commands:

| Command | Description |
|---------|-------------|
| `M-x package-list-packages` | Show installed packages |
| `C-h v emacs-version` | Check Emacs version |
| `C-c p p` | Switch between projects |
| `C-x C-f` | Find file with completion |
| `M-x magit-status` | Open Git interface |
| `C-c T` | Open file tree |
| `F2` | Open dashboard |

## Common Issues

### Packages Won't Install
```bash
# Clear package cache
rm -rf ~/.emacs.d/elpa

# Restart Emacs and wait for reinstall
emacs
```

### LSP Not Working
1. Check language server is installed: `which clangd`
2. Open a file in the target language
3. Run `M-x lsp-doctor` for diagnostics
4. Check `*lsp-log*` buffer for errors

### Fonts Look Wrong
1. Install Nerd Fonts: `M-x nerd-icons-install-fonts`
2. Restart Emacs
3. Check font rendering with: `M-x nerd-icons-insert`

### Slow Startup
1. Check `*Messages*` for package installation progress
2. Wait for byte-compilation to complete
3. Subsequent startups should be ~2-3 seconds

## Next Steps

1. **Read the manual**: `C-h i` → Emacs
2. **Customize**: Edit files in `~/.emacs.d/config/`
3. **Learn keybindings**: `C-h b` to see all bindings
4. **Explore packages**: `M-x package-list-packages`
5. **Join community**: /r/emacs, #emacs on IRC

Happy hacking! ¯\_(ツ)_/¯