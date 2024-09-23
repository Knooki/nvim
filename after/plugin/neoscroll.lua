local neoscroll = require("neoscroll")
neoscroll.setup({
	hide_cursor = false,
	stop_eof = true,
	respect_scrolloff = false,
	cursor_scrolls_alone = true,
	easing = "linear",
	performance_mode = false,
})
local keymap = {
	-- Use the "sine" easing function
	["<C-u>"] = function()
		neoscroll.ctrl_u({
			duration = 100,
		})
	end,
	["<C-d>"] = function()
		neoscroll.ctrl_d({
			duration = 100,
		})
	end,
	-- Use the "circular" easing function
	["<C-b>"] = function()
		neoscroll.ctrl_b({
			duration = 100,
		})
	end,
	["<C-f>"] = function()
		neoscroll.ctrl_f({
			duration = 100,
		})
	end,
	-- When no value is passed the `easing` option supplied in `setup()` is used
	["<C-y>"] = function()
		neoscroll.scroll(-0.1, {
			move_cursor = false,
			duration = 100,
		})
	end,
	["<C-e>"] = function()
		neoscroll.scroll(0.1, {
			move_cursor = false,
			duration = 100,
		})
	end,
}
local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
	vim.keymap.set(modes, key, func)
end
