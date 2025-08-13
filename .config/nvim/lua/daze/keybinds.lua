-- local opts = { noremap = true, silent = true }

-- local remap = vim.api.nvim_set_keymap
-- -- Space key as leader,,,,
-- remap(""""",<Space>,<Nop>, opts)
-- "vim.g.mapleader = "" """,,,,
-- "vim.g.maplocalleader = "" """,,,,
-- ,,,,
-- -- Clear highlight on esc,,,,
-- "remap(""n""",<ESC>,<CMD>noh<CR>, opts),
-- ,,,,
-- -- Map ; to : and vice-versa for normal mode,,,,
-- "remap(""n""",:,;, opts),
-- "remap(""n""",;,:, opts),
-- ,,,,
-- -- Select all,,,,
-- "remap(""n""",<leader>a,ggVG, opts),
-- ,,,,
-- -- Toggle Netrw,,,,
-- "remap(""n""",<C-b>,<CMD>NvimTreeToggle<CR>, opts),
-- ,,,,
-- -- Don't replace data on visual paste,,,,
-- "remap(""v""",p," '""_dP'", opts),
-- ,,,,
-- -- format on save,,,,
-- --,,,,
-- "remap(""n""",<CMD> :w<CR>,<CMD> :w<CR> <leader>fm, opts),
-- -- Format current file,,,,
-- "-- remap(""n""",<leader>fm,<cmd> :Neoformat<CR>, opts),
-- "remap(""n""",<leader>fm," '<CMD> lua require(""conform"").format({ timeout_ms = 2000 })<CR>'", opts),
-- "-- remap(""n""",<leader>fm," '<CMD> lua require(""conform"").format.linewise.current()<CR>'", opts),
-- ,,,,
-- -- Toggle Comment,,,
-- "remap(""v""",<leader>/," '<ESC><CMD> lua require(""Comment.api"").toggle.linewise(vim.fn.visualmode())<CR>'", opts),
-- ,,,,
-- -- Telescope Binds,,,,
-- "remap(""n""",<leader>ff,<CMD>Telescope find_files<CR>, opts),
-- "remap(""n""",<leader>fw,<CMD>Telescope live_grep<CR>, opts),
-- "remap(""n""",<leader><leader>,<CMD>Telescope buffers<CR>, opts),
-- ,,,,
-- -- LSP Binds,,,,
-- "remap(""n""",<leader>rn,:lua vim.lsp.buf.rename()<CR>, opts),
-- "remap(""n""",<leader>e,<CMD> lua vim.diagnostic.open_float()<CR>, opts),
-- "remap(""n""",<leader>[,<CMD> lua vim.diagnostic.goto_prev()<CR>, opts),
-- "remap(""n""",<leader>],<CMD> lua vim.diagnostic.goto_next()<CR>, opts),
-- "remap(""n""",<leader>q,<CMD> lua vim.diagnostic.setloclist()<CR>, opts),
-- "remap(""n""",gD,<CMD> lua vim.lsp.buf.declaration()<CR>, opts),
-- "remap(""n""",gd,<CMD> lua vim.lsp.buf.definition()<CR>, opts),
-- "remap(""n""",<leader>ca,<CMD> lua vim.lsp.buf.code_action()<CR>, opts),
-- "remap(""n""",<leader>k,<CMD> lua vim.lsp.buf.hover()<CR>, opts),
-- "remap(""n""",gi,<CMD> lua vim.lsp.buf.implementation()<CR>, opts),
-- "remap(""n""",<C-k>,<CMD> lua vim.lsp.buf.signature_help()<CR>, opts),
-- ,,,,
-- -- Select all,,,,
-- "remap(""n""",<leader>a,ggVG, { noremap = true, silent = true })
-- ,,,,
-- -- Harpoon Binds,,,,
-- "remap(""n""",<leader>h,:lua require('harpoon.ui').toggle_quick_menu()<CR>, opts),
-- "remap(""n""",ma,:lua require('harpoon.mark').add_file()<CR>, opts),
-- "remap(""n""",<leader>1,:lua require('harpoon.ui').nav_file(1)<CR>, opts),
-- "remap(""n""",<leader>2,:lua require('harpoon.ui').nav_file(2)<CR>, opts),
-- "remap(""n""",<leader>3,:lua require('harpoon.ui').nav_file(3)<CR>, opts),
-- ,,,,
-- -- Buffer Navigation,,,,
-- "remap(""n""",<leader>n,:bnext<CR>, opts),
-- "remap(""n""",<leader>b,:bprevious<CR>, opts),
-- "remap(""n""",<leader>x,:bd<CR>, opts),
-- ,,,,
-- -- Leap search visible space,,,,
-- "remap(""n""",<leader>g,<CMD> lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<CR>, opts),
-- ,,,,
-- -- Move lines up and down,,,,
-- "remap(""n""",<S-Down>,:m .+1<CR>==, opts),
-- "remap(""n""",<S-Up>,:m .-2<CR>==, opts),
-- ,,,,
-- -- Diable Page Up and Down,,,,
-- "remap(""n""",<PageUp>,<Nop>, opts),
-- "remap(""n""",<PageDown>,<Nop>, opts), "remap(""n""",<S-PageUp>,<Nop>, opts), "remap(""n""",<S-PageDown>,<Nop>, opts),
-- ,,,,
-- -- JS REMOVE RANDOMASSS CHARACTERS REGEX,,,,
-- "-- noremap(""n""",<leader>r,<CMD>:%s/%x1b[[0-9;]*m//g <CR>),,
-- -- DAP,,,,
-- ,,,,
-- "remap(""n""",<leader>dc,<CMD> lua require('dap').continue()<CR>, opts),
-- "remap(""n""",<leader>ds,<CMD> lua require('dap').step_over()<CR>, opts),
-- "remap(""n""",<leader>di,<CMD> lua require('dap').step_into()<CR>, opts),
-- "remap(""n""",<leader>do,<CMD> lua require('dap').step_out()<CR>, opts),
-- "remap(""n""",<leader>db,<CMD> lua require('dap').toggle_breakpoint()<CR>, opts),
-- "remap(""n""",<leader>dw,<CMD> lua require('dapui').close()<CR>, opts),
-- "remap(""n""",<leader>d.,<CMD> lua require('dapui').float_element()<CR>, opts),
-- ,,,,
-- -- Hard mode,,,,
-- "-- remap(""n""",h,<Nop>, opts),
-- "-- remap(""n""",j,<Nop>, opts),
-- "-- remap(""n""",k,<Nop>, opts),
-- "-- remap(""n""",l,<Nop>, opts),

local opts = { noremap = true, silent = true }

local remap = vim.api.nvim_set_keymap

-- Space key as leader
remap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear highlight on esc
remap("n", "<ESC>", "<CMD>noh<CR>", opts)

-- Map ; to : and vice-versa for normal mode
remap("n", ":", ";", opts)
remap("n", ";", ":", opts)

-- Select all
remap("n", "<leader>a", "ggVG", opts)

-- Toggle Netrw
remap("n", "<C-b>", "<CMD>NvimTreeToggle<CR>", opts)

-- Don't replace data on visual paste
remap("v", "p", '"_dP', opts)

-- Format current file
-- remap("n", "<leader>fm", "<cmd> :Neoformat<CR>", opts)
remap("n", "<leader>fm", '<CMD> lua require("conform").format({ timeout_ms = 2000 })<CR>', opts)
-- remap("n", "<leader>fm", '<CMD> lua require("conform").format.linewise.current()<CR>', opts)

-- Toggle Comment
remap("n", "<leader>/", '<CMD> lua require("Comment.api").toggle.linewise.current()<CR>', opts)
remap("v", "<leader>/", '<ESC><CMD> lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', opts)

-- Telescope Binds
remap("n", "<leader>ff", "<CMD>Telescope find_files<CR>", opts)
remap(
	"n",
	"<leader>fw",
	":lua require('telescope.builtin').live_grep({ additional_args = { '--fixed-strings' }})<CR>",
	opts
)
remap("n", "<leader><leader>", "<CMD>Telescope buffers<CR>", opts)
remap("n", "<leader>fr", "<CMD>Telescope lsp_references<CR>", opts)
remap("n", "<leader>fi", "<CMD>Telescope lsp_implementations<CR>", opts)
remap("n", "<leader>fd", "<CMD>Telescope lsp_definitions<CR>", opts)
remap("n", "<leader>ft", "<CMD>Telescope lsp_type_definitions<CR>", opts)
remap("n", "<leader>fc", "<CMD>Telescope lsp_incoming_calls<CR>", opts)
remap("n", "<leader>fo", "<CMD>Telescope lsp_outgoing_calls<CR>", opts)
remap("n", "<leader>fs", "<CMD>Telescope lsp_document_symbols<CR>", opts)
remap("n", "<leader>fS", "<CMD>Telescope lsp_workspace_symbols<CR>", opts)
remap("n", "<leader>fD", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
remap("n", "<leader>fx", "<CMD>Telescope diagnostics<CR>", opts)
remap("n", "<leader>fX", "<CMD>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>", opts)
-- builtin.lsp_references 	Lists LSP references for word under the cursor
-- builtin.lsp_incoming_calls 	Lists LSP incoming calls for word under the cursor
-- builtin.lsp_outgoing_calls 	Lists LSP outgoing calls for word under the cursor
-- builtin.lsp_document_symbols 	Lists LSP document symbols in the current buffer
-- builtin.lsp_workspace_symbols 	Lists LSP document symbols in the current workspace
-- builtin.lsp_dynamic_workspace_symbols 	Dynamically Lists LSP for all workspace symbols
-- builtin.diagnostics 	Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
-- builtin.lsp_implementations 	Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
-- builtin.lsp_definitions 	Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
-- builtin.lsp_type_definitions
--
-- LSP Binds
remap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
remap("n", "<leader>e", "<CMD> lua vim.diagnostic.open_float()<CR>", opts)
remap("n", "<leader>[", "<CMD> lua vim.diagnostic.goto_prev()<CR>", opts)
remap("n", "<leader>]", "<CMD> lua vim.diagnostic.goto_next()<CR>", opts)
remap("n", "<leader>q", "<CMD> lua vim.diagnostic.setloclist()<CR>", opts)
remap("n", "gD", "<CMD> lua vim.lsp.buf.declaration()<CR>", opts)
remap("n", "gd", "<CMD> lua vim.lsp.buf.implementation()<CR>", opts)
remap("n", "<leader>ca", "<CMD> lua vim.lsp.buf.code_action()<CR>", opts)
remap("n", "<leader>k", "<CMD> lua vim.lsp.buf.hover()<CR>", opts)
remap("n", "gi", "<CMD> lua vim.lsp.buf.definition()<CR>", opts)
remap("n", "<C-k>", "<CMD> lua vim.lsp.buf.signature_help()<CR>", opts)

-- Select all
remap("n", "<leader>a", "ggVG", { noremap = true, silent = true })

-- Harpoon Binds
remap("n", "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
remap("n", "ma", ":lua require('harpoon.mark').add_file()<CR>", opts)
remap("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
remap("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
remap("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)

-- Buffer Navigation
remap("n", "<leader>n", ":bnext<CR>", opts)
remap("n", "<leader>b", ":bprevious<CR>", opts)
-- remap("n", "<leader>x", ":bd<CR>", opts)
remap("n", "<leader>x", "<CMD> lua require('daze.functions').CloseBuffer()<CR>", opts)

-- Git Hunks
remap("n", "<leader>gh", "<CMD> lua require('daze.functions').GitHunks()<CR>", opts)

-- Leap search visible space
remap("n", "<leader>g", "<CMD> lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<CR>", opts)

-- Diable Page Up and Down
remap("n", "<PageUp>", "<Nop>", opts)
remap("n", "<PageDown>", "<Nop>", opts)
remap("n", "<S-PageUp>", "<Nop>", opts)
remap("n", "<S-PageDown>", "<Nop>", opts)

remap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
remap("n", "<leader>e", "<CMD> lua vim.diagnostic.open_float()<CR>", opts)
remap("n", "<leader>[", "<CMD> lua vim.diagnostic.goto_prev()<CR>", opts)
remap("n", "<leader>]", "<CMD> lua vim.diagnostic.goto_next()<CR>", opts)
remap("n", "<leader>q", "<CMD> lua vim.diagnostic.setloclist()<CR>", opts)
remap("n", "gD", "<CMD> lua vim.lsp.buf.declaration()<CR>", opts)
remap("n", "gd", "<CMD> lua vim.lsp.buf.definition()<CR>", opts)
remap("n", "<leader>ca", "<CMD> lua vim.lsp.buf.code_action()<CR>", opts)
remap("n", "<leader>k", "<CMD> lua vim.lsp.buf.hover()<CR>", opts)
remap("n", "gi", "<CMD> lua vim.lsp.buf.implementation()<CR>", opts)
remap("n", "<C-k>", "<CMD> lua vim.lsp.buf.signature_help()<CR>", opts)

-- Move lines up and down
remap("n", "<S-Down>", ":m .+1<CR>==", opts)
remap("n", "<S-Up>", ":m .-2<CR>==", opts)
-- remap("n", "<leader>k", "<C-u>zz", { desc = "Half page up" })
-- remap("n", "<leader>j", "<C-d>zz", { desc = "Half page down" })
-- remap("v", "<leader>k", "<C-u>zz", { desc = "Half page up" })
-- remap("v", "<leader>j", "<C-d>zz", { desc = "Half page down" })

-- Hard mode
-- remap("n", "h", "<Nop>", opts)
-- remap("n", "j", "<Nop>", opts)
-- remap("n", "k", "<Nop>", opts)
-- remap("n", "l", "<Nop>", opts)
