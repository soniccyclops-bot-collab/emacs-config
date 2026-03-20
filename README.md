# Nathan's Modern Emacs Configuration

A fast, clean, and powerful Emacs configuration optimized for C/C++, Python, Common Lisp, and Clojure development.

## Features

- **Fast Startup**: Optimized for quick loading with lazy package loading
- **Modern UI**: Clean interface with Doom themes, modeline, and icons
- **Smart Completion**: Ivy/Counsel/Swiper ecosystem with fuzzy matching
- **Language Support**: Full IDE features for target languages
- **LSP Integration**: Modern language server protocol support
- **Git Integration**: Comprehensive Magit workflow
- **Project Management**: Projectile with treemacs file explorer
- **Efficient Navigation**: Avy, ace-window, and hydras for quick movement

## Target Languages

### C/C++
- **LSP**: clangd integration with full IntelliSense
- **Debugging**: DAP mode with GDB support  
- **Build**: CMake integration and compilation
- **Modern C++**: Enhanced syntax highlighting

### Python
- **IDE**: Elpy with full Python development features
- **Virtual Environments**: pyvenv integration
- **Formatting**: Black and isort auto-formatting
- **Poetry**: Project dependency management
- **REPL**: Integrated Python shell

### Common Lisp
- **SLIME**: Superior Lisp interaction with SBCL
- **Documentation**: HyperSpec lookup integration
- **Editing**: Paredit for structured editing
- **REPL**: Full interactive development

### Clojure
- **CIDER**: Complete Clojure development environment
- **Refactoring**: clj-refactor with automated transformations
- **Linting**: flycheck-clj-kondo integration
- **Build Tools**: Leiningen support

## Installation

```bash
# Backup existing config
mv ~/.emacs.d ~/.emacs.d.backup

# Clone this config
git clone https://github.com/soniccyclops-bot-collab/emacs-config.git ~/.emacs.d

# Start Emacs (packages will install automatically)
emacs
```

## Key Features

### Completion & Navigation
- **Ivy/Counsel**: Fuzzy completion everywhere
- **Projectile**: Project-aware file navigation  
- **Treemacs**: Visual file tree explorer
- **Avy**: Jump to any visible text
- **Swiper**: Enhanced search with preview

### Editing Enhancements
- **Multiple Cursors**: Edit multiple locations simultaneously
- **Smart Parentheses**: Automatic delimiter handling
- **Expand Region**: Intelligent text selection
- **Undo Tree**: Visual undo/redo history
- **YASnippet**: Code templates and snippets

### UI & Appearance
- **Doom Themes**: Modern, beautiful color schemes
- **Doom Modeline**: Clean, informative status line
- **Nerd Icons**: Rich iconography throughout
- **Dashboard**: Welcoming startup screen
- **Centaur Tabs**: Buffer tabs for easy switching

### Version Control
- **Magit**: The best Git interface ever created
- **Git Gutter**: Show changes in the fringe
- **Diff Highlighting**: Visual diff support
- **Forge**: GitHub/GitLab integration

## Hydras (Quick Access)

- **C-c w**: Window management hydra
- **C-c z**: Text zoom hydra  
- **C-c n**: Navigation hydra

## Language-Specific Commands

### C/C++
```
C-c C-c  - Compile current file
C-c C-r  - Start GDB debugger
C-c h    - Open man page
```

### Python
```
C-c C-c  - Send buffer to Python shell
C-c C-r  - Send region to shell
C-c C-z  - Switch to Python shell
C-c C-d  - Show documentation
```

### Common Lisp
```
C-c C-z  - Start SLIME
C-c C-c  - Compile function
C-c C-k  - Compile and load file
C-c h    - HyperSpec lookup
```

### Clojure
```
C-c C-j  - Start CIDER REPL
C-c C-z  - Switch to REPL
C-c C-c  - Evaluate function
C-c C-k  - Load buffer
C-c C-d  - Show documentation
```

## Prerequisites

### System Dependencies
```bash
# LSP servers
npm install -g clangd  # C/C++
pip3 install python-lsp-server  # Python

# Language runtimes
sudo apt install sbcl  # Common Lisp
curl -O https://download.clojure.org/install/linux-install-1.11.1.1113.sh
chmod +x linux-install-1.11.1.1113.sh
sudo ./linux-install-1.11.1.1113.sh  # Clojure

# Leiningen for Clojure
curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/.local/bin/lein
chmod +x ~/.local/bin/lein
```

### Font Installation
Install [Nerd Fonts](https://www.nerdfonts.com/) for proper icon display:
```bash
# Or run in Emacs after installation
M-x nerd-icons-install-fonts
```

## Customization

### Personal Settings
Create `~/.emacs.d/local.el` for machine-specific settings:
```elisp
;; Example local.el
(setq user-full-name "Your Name"
      user-mail-address "your@email.com")

;; Custom project directories
(setq projectile-project-search-path '("~/code/" "~/projects/"))

;; Theme override
(load-theme 'doom-gruvbox t)
```

### Package Configuration
Edit files in `~/.emacs.d/config/` to customize specific features:
- `01-defaults.el` - Core Emacs settings
- `02-ui.el` - Appearance and themes  
- `03-editing.el` - Text editing features
- `04-completion.el` - Ivy/Counsel setup
- `05-navigation.el` - File and buffer navigation
- `06-version-control.el` - Git integration
- `07-programming.el` - General programming features
- `08-languages.el` - Language-specific configs
- `09-keybindings.el` - Keyboard shortcuts

## Performance

This configuration is optimized for fast startup:
- Lazy package loading with `use-package`
- Reduced garbage collection during init
- Minimal file handler manipulation
- Efficient package management

Typical startup time: ~2-3 seconds on modern hardware.

## Philosophy

This configuration balances:
- **Power** vs **Simplicity**: Full-featured but not overwhelming
- **Modern** vs **Stable**: Latest tools with proven reliability  
- **Opinionated** vs **Flexible**: Sensible defaults with customization hooks
- **Visual** vs **Functional**: Beautiful interface that enhances productivity

## License

MIT - Use, modify, and share freely.

Happy coding! (>_<)