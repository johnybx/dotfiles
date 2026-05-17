hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "BreezeX-RosePine-Linux")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

hl.bind("ALT + Q", hl.dsp.window.close())

hl.config({
	misc = {
		disable_hyprland_logo = true,
	},
	animations = {
		enabled = false,
	},
})

hl.on("hyprland.start", function()
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'BreezeX-RosePine-Linux'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")
	hl.exec_cmd("nwg-hello; hyprctl dispatch exit")
end)
