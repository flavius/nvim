require("config.lazy")

-- Load Options and Keymaps
require("config.options")  -- Modular options
require("config.keymaps")  -- Modular keymaps

-- Load Plugins
require("lazy").setup("plugins")
