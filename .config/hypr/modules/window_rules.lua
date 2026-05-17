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
	size = "50% 70%",
})

hl.window_rule({
	name = "opacity-copyq",
	match = { class = "com.github.hluk.copyq" },
	opacity = 0.9,
})

hl.window_rule({
	name = "opacity-slack",
	match = { class = "Slack" },
	opacity = 0.95,
})

hl.window_rule({
	name = "opacity-spotify",
	match = { class = "spotify" },
	opacity = 0.95,
})

hl.window_rule({
	name = "opacity-spotube",
	match = { class = "Spotube" },
	opacity = 0.95,
})

hl.window_rule({
	name = "opacity-ulauncher",
	match = { class = "ulauncher" },
	opacity = 0.95,
})

hl.window_rule({
	name = "firefox-pip-no-focus",
	match = { class = "firefox", title = "Picture-in-Picture" },
	focus_on_activate = false,
})

hl.window_rule({
	name = "firefox-pip-opacity",
	match = { class = "firefox", title = "Picture-in-Picture" },
	opacity = 1.0,
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
