return {
	adapter = {
		type = "executable",
		command = "php-debug-adapter",
	},
	configurations = {
		{
			type = "php",
			request = "launch",
			name = "Listen for Xdebug",
			port = 9003,
			pathMappings = {
				["/var/www/html"] = "${workspaceFolder}",
			},
		},
	},
}
