local dap = require("dap")
local utils = require("daze.config.dap.utils")

-- 1. Setup Signs
utils.setup_signs()

-- 2. Python
local python = require("daze.config.dap.python")
dap.adapters.python = python.adapter
dap.configurations.python = python.configurations

-- 3. JavaScript / TypeScript
local js = require("daze.config.dap.javascript")
dap.adapters["pwa-node"] = js.adapter
for _, lang in ipairs(js.languages) do
	dap.configurations[lang] = js.configurations
end

-- 4. PHP
local php = require("daze.config.dap.php")
dap.adapters.php = php.adapter
dap.configurations.php = php.configurations

-- 5. Go
local go = require("daze.config.dap.go")
dap.adapters.delve = go.adapter
dap.configurations.go = go.configurations
