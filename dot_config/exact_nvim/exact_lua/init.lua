require("config.options")
require("config.keymaps_nvim")
require("config.keymaps")
require("config.gui")
require("config.lazy")
require("config.terminal") -- 因為會被lazy.nvim override，所以要放在最後
