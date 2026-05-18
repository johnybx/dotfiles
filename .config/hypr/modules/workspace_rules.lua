-- Default workspace positions
hl.workspace_rule({
	workspace = "1",
	monitor = "desc:China Star Optoelectronics Technology Co. Ltd 0x1640 0x00006004",
	default = true,
})
hl.workspace_rule({
	workspace = "2",
	monitor = "desc:Acer Technologies CB272 0x0381304E",
	default = true,
	on_created_empty = "kitty -- tmux",
})
hl.workspace_rule({
	workspace = "3",
	monitor = "desc:Acer Technologies Acer CB271H B 0x919029CC",
	default = true,
	on_created_empty = "firefox",
})
hl.workspace_rule({
	workspace = "4",
	monitor = "desc:Acer Technologies Acer CB271H B 0x919029CC",
	on_created_empty = "slack",
})
hl.workspace_rule({
	workspace = "5",
	monitor = "desc:Acer Technologies Acer CB271H B 0x919029CC",
	on_created_empty = "protonmail-bridge & thunderbird",
})
hl.workspace_rule({ workspace = "special:magic", on_created_empty = "kitty -- tmux" })
