return {
	"sphamba/smear-cursor.nvim",
	opts = {
		stiffness = 0.5, -- Controls movement speed/snap
		trailing_stiffness = 0.5, -- Setting this equal to stiffness removes the trail
		matrix_pixel_threshold = 0.5,
		distance_stop_animating_vertical_bar = 0.1,
		legacy_computing_symbols_support = true,
	},
}
