local M = {
	["dark (medium)"] = {
		type = "dark",
		primary = {},
		neutral = {
			dark = "#282828",
			light = "#D5C4A1",
		},
		colors = {
			red = "#FB4934",
			green = "#B8BB26",
			orange = "#e78a4e",
			yellow = "#FABD2F",
			blue = "#83A598",
			magenta = "#D3869B",
			cyan = "#8EC07C",
		},
	},
	["light (medium)"] = {
		type = "light",
		primary = {},
		neutral = {
			dark = "#FBF1C7",
			light = "#3c3836",
		},
		colors = {
			red = "#9d0006",
			green = "#6c782e",
			orange = "#af3a03",
			yellow = "#b57614",
			blue = "#076678",
			magenta = "#8f3f71",
			cyan = "#598f8d",
		},
	},
}

M["dark (medium)"].primary.base = M["dark (medium)"].colors.yellow
M["light (medium)"].primary.base = M["light (medium)"].colors.cyan

return M
