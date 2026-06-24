# `.vimrc` Guide

## Positioning

This `.vimrc` is a stable Vim baseline for backend and server work.

It is designed around a few constraints:

- no plugin dependency
- safe to carry onto SSH hosts and minimal environments
- strong enough for config editing, search, and lightweight code changes
- intentionally not trying to replace a full IDE

The short version is:

> this is a server-friendly, backend-oriented Vim operating table focused on stability, portability, and low side effects

## Priority View

If you only want the most important parts, read this section first.

| Priority | Module | Core value | Day-to-day use |
| --- | --- | --- | --- |
| 1 | Save and quit | Fast common actions | `<Space>w`, `<Space>q`, `<Space>Q` |
| 1 | Search in current file | Smarter search flow | `/keyword`, `n`, `N`, `<Space>nh` |
| 1 | Project grep + quickfix | Cross-file search and jump | `<Space>gw`, `<Space>gW`, `<Space>cn`, `<Space>cp` |
| 1 | Split management | View and edit multiple files at once | `<Space>vv`, `<Space>sh`, `<Space>h/j/k/l` |
| 1 | Buffer management | Fast file switching | `<Space>bn`, `<Space>bp`, `<Space>bd`, `<Space>bl` |
| 1 | Invisible characters | Safer config editing | `<Space>ul` |
| 1 | Large-file protection | Prevents sluggish editing in logs and large files | automatic |
| 2 | Filetype indentation | Better defaults for Java and config formats | automatic |
| 2 | Config-file word rules | Better movement and text objects for keys with `-` | automatic for selected filetypes |
| 2 | Persistent undo | Undo survives Vim restarts | automatic |
| 2 | Black-hole delete | Deletes without polluting your yank register | `<Space>d` |
| 2 | Manual trim | Remove trailing whitespace only when needed | `:TrimTrailingWhitespace` |
| 3 | netrw | Built-in file browsing | `<Space>e`, `<Space>E` |
| 3 | Folding toggle | Folding when you need it, not before | `<Space>uf` |
| 3 | File path copy | Copy or display the current path | `:CopyFilePath` |

## Core Workflow

The intended workflow is:

1. open a file
2. verify spacing, indentation, and invisible characters
3. search inside the file or across the project
4. jump through results with quickfix
5. make small, low-risk edits
6. save and move on

This is why the config invests more in movement, grep, quickfix, and display clarity than in IDE-like completion features.

## Full Module Breakdown

| Module | Main settings | Why it exists | Trade-off |
| --- | --- | --- | --- |
| Basic | `nocompatible`, `mapleader=<Space>` | consistent Vim behavior and easy keymap prefix | space loses most of its default normal-mode use |
| Encoding | `utf-8` with Chinese fallbacks | reduces risk of opening older encoded files incorrectly | rare files may still need manual handling |
| Filetype | syntax and indent enabled | powers highlighting and file-specific rules | very low cost |
| UI | line numbers, relative numbers, cursorline, statusline | easier navigation and orientation | needs large-file protection to stay responsive |
| Invisible chars | `set list` with visible tabs and trailing spaces | especially useful for YAML and server config work | adds visual noise for some users |
| Search | `ignorecase`, `smartcase`, `incsearch`, `hlsearch` | efficient default search behavior | search highlight needs manual clearing |
| Edit behavior | `hidden`, `nowrap`, `mouse=a` | smoother multi-file editing in terminals | hidden buffers can hide unsaved work if you are careless |
| Indent | 4-space default | aligns with backend and Java editing | frontend formats need overrides |
| Backup and swap | no backup and no swapfile | fewer temp files on servers and containers | weaker crash recovery |
| Undo | persistent undo under `~/.vim/undo` | keeps editing history across sessions | leaves undo artifacts on disk |
| Completion | `wildmenu`, `wildignore` | cleaner command-line path completion | not semantic code completion |
| Performance | redraw and timeout tuning | better responsiveness in terminals | slow key sequences may time out sooner |
| Clipboard | conditional clipboard integration | works on both local and server Vim builds | remote shells without clipboard remain limited |
| Split behavior | `splitbelow`, `splitright` | more natural window placement | no real downside |
| Folding | indent-based but off by default | available without disrupting file open | must be manually enabled |
| Statusline | filename, flags, filetype, encoding, position | enough context without plugins | plain compared with plugin statuslines |
| Quickfix | quickfix and location-list mappings | project search navigation | text-based, not semantic analysis |
| Grep | `rg` first, fallback to `vimgrep` | fast project search on capable hosts | fallback is slower on large repos |
| Replace | current-word substitution helper | quick file-wide replacement setup | text replacement only, not refactoring |
| Filetype rules | Java, YAML, JSON, shell, SQL, Markdown, Dockerfile, and more | practical editing defaults for common backend files | intentionally lightweight language coverage |
| Large-file guard | disables heavy UI over 1 MB | keeps logs and large files usable | fewer editing cues in large files |
| Auto commands | restore last cursor position | good long-lived editing ergonomics | minimal downside |
| netrw | built-in file explorer | useful without plugins | more limited than tree plugins |
| Commands | trim whitespace, delete empty lines, copy path | small daily utilities | manual use required |

## High-Frequency Keymaps

### Basic

| Key | Action |
| --- | --- |
| `<Space>w` | save |
| `<Space>q` | quit |
| `<Space>Q` | force quit |
| `<Space>nh` | clear search highlight |
| `<Space>sr` | reload `~/.vimrc` |
| `<Space>ev` | edit `~/.vimrc` |

### Search and Quickfix

| Key | Action |
| --- | --- |
| `<Space>gw` | project search for current word |
| `<Space>gW` | exact-word project search for current word |
| `<Space>co` | open quickfix |
| `<Space>cc` | close quickfix |
| `<Space>cn` | next quickfix result |
| `<Space>cp` | previous quickfix result |
| `<Space>rw` | prepare file-wide replace for current word |

### Split and Buffer

| Key | Action |
| --- | --- |
| `<Space>vv` | vertical split |
| `<Space>sh` | horizontal split |
| `<Space>h/j/k/l` | move across windows |
| `<Space>bn` | next buffer |
| `<Space>bp` | previous buffer |
| `<Space>bd` | delete current buffer |
| `<Space>bl` | list buffers |

### UI Toggles

| Key | Action |
| --- | --- |
| `<Space>ul` | toggle invisible characters |
| `<Space>uw` | toggle wrap |
| `<Space>uf` | toggle folding |

### Editing Helpers

| Key | Action |
| --- | --- |
| `jk` | leave insert mode |
| `H` | jump to first non-blank character |
| `L` | jump to line end |
| `<Space>d` | delete into black-hole register |
| `<Space>p` | paste over selection without clobbering the yank register |
| `<Space>mj` | move current line or selection down |
| `<Space>mk` | move current line or selection up |

## Design Trade-Offs

| Decision | Chosen approach | Why | Cost |
| --- | --- | --- | --- |
| Plugins vs built-ins | built-ins | easy to copy to servers and low maintenance | no IDE-like feature set |
| Vim vs full IDE | Vim for light editing | strong for SSH, config work, and quick patching | large refactors still belong in an IDE |
| Auto trim vs manual trim | manual trim | avoids surprising diffs on save | requires explicit use |
| Swapfile vs clean filesystem | `noswapfile` | fewer temp files in server environments | weaker crash recovery |
| Visible list chars vs cleaner screen | list shown by default | catches whitespace issues early | noisier display |
| `rg` vs built-in grep | `rg` preferred | much faster project search | depends on `ripgrep` being installed |
| Markdown spell checking | off by default | avoids friction for mixed-language notes | must be enabled manually when needed |
| Java vs config-file word handling | hyphen handling only for config-like files | preserves normal Java identifier behavior | config-specific tuning is selective |

## Good Fits and Boundaries

| Scenario | Fit | Why |
| --- | --- | --- |
| Editing nginx, systemd, Docker, or SSH config on a server | very good | clean, quick, and whitespace-aware |
| Editing `.env`, YAML, and `.properties` files | very good | indentation, word rules, and visible spaces help a lot |
| Small Java changes | good | 4-space defaults and grep-based navigation are enough |
| Large log inspection | good | large-file protection keeps the editor responsive |
| Emergency debugging on a remote host | very good | no plugin dependency and low setup cost |
| Large Java refactors | poor | not semantic, no real refactoring support |
| Terminal IDE replacement | poor | not the goal of this config |
| LSP-heavy completion workflows | poor | should live in a different Neovim or IDE setup |

## Final Summary

| Dimension | Conclusion |
| --- | --- |
| Positioning | server/backend `.vimrc` baseline |
| Core value | stable, lightweight, portable, low side effects |
| Main workflow | grep -> quickfix -> jump -> light edit |
| Best file types | YAML, `.properties`, `.env`, Dockerfile, shell, Java |
| Biggest strength | no-plugin efficiency for backend maintenance work |
| Biggest boundary | not an IDE and not a semantic refactoring tool |
| Long-term viability | strong, as long as additions stay small and justified |

One-sentence version:

> this `.vimrc` is a lightweight Vim control panel for backend and server work, optimized for config editing, search, jumps, and safe maintenance rather than IDE features
