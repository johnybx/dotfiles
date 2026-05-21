-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "BreezeX-RosePine-Linux")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Integrated GPU
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")

-- Nvidia (commented out)
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("XDG_SESSION_TYPE", "wayland")
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("NVD_BACKEND", "direct")
-- hl.config({
--     cursor = {
--         no_hardware_cursors = true,
--     },
-- })
