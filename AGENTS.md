# quadHead - Agent Guidelines

## Project Overview
quadHead is a Neovim plugin that uses tmux/wezterm to provide a lightweight terminal REPL for R and Python. It allows sending code from nvim buffers to REPL panes.

## Build/Lint/Test Commands
There is **no formal test suite or CI** in this repository. Manual testing is performed via nvim commands.

### Running the Plugin
```bash
# Source the plugin in nvim
:source plugin/quadHead.lua
# Or use your plugin manager to load quadHead

# Test commands available after loading
:QuadHeadTest               -- verify plugin loads
:QuadHeadSendTest          -- test sending code to REPL
:QuadHeadAttach <pane>     -- attach to existing tmux pane
:QuadHeadAttachR [pane]    -- attach R (radian) REPL
:QuadHeadAttachPy [pane]   -- attach Python (ipython) REPL
:QuadHeadList              -- list all attached targets
:QuadHeadSendLine          -- send current line to REPL
:QuadHeadSendSelection     -- send visual selection to REPL
:QuadHeadSendCell          -- send current cell to REPL
```

### Manual Testing
- Create a test nvim session with `nvim -u NONE`
- Source the plugin: `:source plugin/quadHead.lua`
- Run the QuadHead commands above
- Ensure tmux is installed and a session is running

### Linting
No formal linter is configured. If desired, install:
- **stylua** for Lua formatting: `stylua --check lua/`
- **luacheck** for Lua linting: `luacheck lua/`

## Code Style Guidelines

### File Organization
- Entry point: `plugin/quadHead.lua` - defines nvim commands
- Core modules in `lua/quadHead/`
- Backend implementations in `lua/quadHead/backend/`
- Module pattern: `local M = {} ... return M`

### Naming Conventions
- **Files**: snake_case (e.g., `backend.lua`, `start.lua`)
- **Functions/variables**: snake_case (e.g., `get_lang`, `pane_exists`)
- **Modules**: snake_case, prefixed with module name (e.g., `quadHead.config`)
- **Commands**: PascalCase with prefix (e.g., `QuadHeadSendLine`)

### Formatting
- **Indentation**: 2 spaces (no tabs)
- **Line endings**: Unix (LF)
- **Trailing whitespace**: Avoid
- **Max line length**: 100 characters (soft limit)

### Imports
- Use `local` for all module imports
- Consistent require paths: `require("quadHead.module")`
- Order: 1) external deps, 2) internal requires, 3) local vars

### Types
- This is plain Lua (no type checking)
- Use descriptive variable names to convey intent
- Document function parameters in comments when non-obvious

### Error Handling
- Use `error("module: message")` for fatal errors
- Use `pcall` for optional operations that shouldn't crash nvim
- Return `nil` for "not found" cases
- Print user-friendly messages: `print("quadHead: message")`

### Neovim API Usage
- Prefer `vim.api.nvim_*` over `vim.fn.*` for new code
- Use `vim.fn.system` for shell commands (tmux CLI)
- Use `vim.tbl_deep_extend` for config merging
- Check `vim.v.shell_error` after `vim.fn.system` calls

### Patterns to Follow
```lua
-- Module structure
local M = {}
local backend = require("quadHead.backend")

function M.func()
  -- implementation
end

return M
```

```lua
-- Error handling
if condition then
  error("quadHead: descriptive message")
end
```

```lua
-- Shell command with error check
local out = vim.fn.system({"tmux", "send-keys", ...})
if vim.v.shell_error ~= 0 then
  error(out)
end
```

```lua
-- Config pattern
local default_config = { key = "default" }
M.config = vim.tbl_deep_extend("force", default_config, opts or {})
```

### Patterns to Avoid
- Global variables (use `local`)
- Single-letter variable names except for common idioms (i, k, v for iteration)
- Deeply nested conditionals (refactor to early returns)
- Magic numbers (use named constants)

## File Structure
```
quadHead/
├── plugin/quadHead.lua    -- nvim command definitions
└── lua/quadHead/
    ├── init.lua           -- setup entry point
    ├── config.lua         -- configuration management
    ├── backend.lua       -- backend factory
    ├── backend/
    │   ├── tmux.lua       -- tmux implementation
    │   └── wezterm.lua    -- wezterm implementation
    ├── utils.lua         -- utilities (filetype detection)
    ├── start.lua         -- attach/start REPLs
    ├── targets.lua       -- target pane storage
    ├── cells.lua         -- cell detection (R/python)
    ├── send.lua          -- send code logic
    └── cwd.lua           -- working directory handling
```

## Common Tasks
- Adding a new REPL: modify `start.lua` and `utils.lua`
- Adding a new backend: implement in `backend/` with same interface
- Adding a command: add to `plugin/quadHead.lua` via `nvim_create_user_command`

## Debugging
- Use `:QuadHeadList` to see attached REPLs
- Use `:QuadHeadTest` to verify basic plugin loading
- Check `vim.v.shell_error` for shell command failures
- Use `vim.print()` for debugging output (nvim 0.10+)

## Configuration
The plugin supports a config table passed to `require("quadHead").setup()`:
```lua
require("quadHead").setup({
  backend = "tmux",  -- or "wezterm"
  cells = {},        -- custom cell delimiters
})
```