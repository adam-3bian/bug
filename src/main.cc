// Copyright 3bian Limited and CHERIoT Contributors.
// SPDX-License-Identifier: Apache-2.0

#include <compartment.h>
#include <cstdint>
#include <debug.hh>
#include <fail-simulator-on-error.h>

#include "../third_party/display_drivers/lcd.hh"
#include "lowrisc_logo.h"

/// Expose debugging features unconditionally for this compartment.
using Debug = ConditionalDebug<true, "Empty Project compartment">;

///////////////////////////////////////////////////////////////////////////////

/// Thread entry point.
void __cheri_compartment("entry_point") init()
{
    // Initialise the LCD
	auto lcd = SonataLcd();
	lcd.draw_image_rgb565({0, 0, 105, 80}, lowriscLogo105x80);

    while (true)
    {
    }
}
