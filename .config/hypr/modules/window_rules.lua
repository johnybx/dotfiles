-------------------------------
---- WINDOWS AND WORKSPACES ---
-------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- You'll probably like this: ignore maximize requests from all apps.
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "float-copyq",
	match = { class = "com.github.hluk.copyq" },
	float = true,
})

hl.window_rule({
	name = "size-copyq",
	match = { class = "com.github.hluk.copyq" },
	size = { "(monitor_w*0.5)", "(monitor_h*0.7)" },
})

hl.window_rule({
	name = "opacity-copyq",
	match = { class = "com.github.hluk.copyq" },
	opacity = "0.9 override",
})

hl.window_rule({
	name = "opacity-slack",
	match = { class = "slack" },
	opacity = "0.95 override",
})

hl.window_rule({
	name = "opacity-spotify",
	match = { class = "spotify" },
	opacity = "0.95 override",
})

hl.window_rule({
	name = "opacity-spotube",
	match = { class = "Spotube" },
	opacity = "0.95 override",
})

hl.window_rule({
	name = "opacity-ulauncher",
	match = { class = "ulauncher" },
	opacity = "0.95 override",
})

hl.window_rule({
	name = "firefox-pip-opacity",
	match = { class = "firefox", title = "Picture-in-Picture" },
	focus_on_activate = false,
	opacity = "1.0 override",
})

hl.window_rule({
	name = "telegram-no-focus",
	match = { class = "org.telegram.desktop" },
	focus_on_activate = false,
})

hl.window_rule({
	name = "no-focus-sweethome3d",
	match = {
		xwayland = true,
		class = "com-eteks-sweethome3d-SweetHome3D",
		title = "win[0-9]+",
	},
	no_focus = true,
})

hl.window_rule({
	name = "kitty-notes",
	match = { title = "kitty-notes" },
	size = { "monitor_w * 0.4", "monitor_h * 0.5" },
	border_size = 0,
	float = true,
	opacity = "1.0 override",
})
