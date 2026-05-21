if hl.plugin.hyprcapture then
	local recording_folder = "/tmp/recording"
	local screenshot_folder = "/tmp/screenshot"
	for _, folder in ipairs({ recording_folder, screenshot_folder }) do
		if not os.execute("test -d " .. folder) then
			os.execute("mkdir " .. folder)
		end
	end
	hl.config({
		plugin = {
			hyprcapture = {
				default_mode = "region",
				fusion_mode = true,
				confirm_before_capture = false,
				fullscreen_scope = "per-monitor",
				window_background = "follow-system",
				save = true,
				clipboard = true,
				show_thumbnail = true,
				save_dir = screenshot_folder,
				record_save_dir = recording_folder,
			},
		},
	})
end
