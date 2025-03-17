-- Copyright 3bian Limited and CHERIoT Contributors.
-- SPDX-License-Identifier: Apache-2.0

set_project("Empty Project template")

sdkdir = path.absolute("third_party/cheriot_rtos/sdk")

set_toolchains("cheriot-clang")

includes(sdkdir)
includes(path.join(sdkdir, "lib"))

option("board")
    set_default("sonata-1.1")

compartment("entry_point")
    add_deps("debug",
             "freestanding",
             "stdio")
    add_files("src/main.cc")
    -- LCD Drivers
    add_files("third_party/display_drivers/core/lcd_base.c")
    add_files("third_party/display_drivers/core/lucida_console_12pt.c")
    add_files("third_party/display_drivers/st7735/lcd_st7735.c", {defines = "CHERIOT_NO_AMBIENT_MALLOC"})
    add_files("third_party/display_drivers/lcd_sonata_0.2.cc")
    add_files("third_party/display_drivers/lcd_sonata_1.0.cc")

firmware("empty-project")
    add_deps("entry_point")
    on_load(function(target)
        target:values_set("board", "$(board)")
        target:values_set("threads", {
            {
                compartment = "entry_point",
                priority = 1,
                entry_point = "init",
                stack_size = 0x1000,
                trusted_stack_frames = 2
            }
        }, {expand = false})
    end)
