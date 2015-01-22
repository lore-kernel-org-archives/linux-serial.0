From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 0/7] serial: 8250: restart console after suspend
Date: Thu, 22 Jan 2015 12:24:24 -0500
Message-ID: <1421947471-6396-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

This series fixes 8250 console resume from system sleep when the
console has been powered down, even though consoles aren't
suspending (eg., no_console_suspend on the kernel command line).

Patch 1 refactors the overly-complicated fall-through logic for
determining if the port should be shutdown.

Patches 2-5 refactor serial8250_do_set_termios() so that the
divisor programming can be used to reprogram the divisor when the
port has been powered-down during system sleep.

[ Patch 3, "serial: 8250: Refactor LCR computation" is, strictly
  speaking, not a required cleanup for this series. However, it
  will facilitate re-use by the omap_8250 driver.
]

Patch 6 implements the console restart by cribbing from an idea
first put forth by Doug Anderson <dianders@chromium.org> to
use the scratch register to discover the port has been powered-down.
This patch implements this restart for all 8250 drivers _except_
omap_8250 (which has a different divisor scheme) and 8250_dw
which unfortunately declares itself to be a PORT_8250 type (fixing
this in the 8250_dw driver will enable console restart for DW ports).

Patch 7 is a straggler fix which became obvious once all the
refactoring cleaned up serial8250_do_set_termios().

Regards,

Peter Hurley (7):
  serial: core: Simplify console suspend logic in uart_suspend_port()
  serial: 8250: Move UART_BUG_QUOT workaround
  serial: 8250: Refactor LCR computation
  serial: 8250: Refactor divisor programming
  serial: 8250: Refactor XR17V35X divisor calculation
  serial: 8250: Use canary to restart console after suspend
  serial: 8250: Prevent concurrent updates to shadow registers

 drivers/tty/serial/8250/8250_core.c | 187 ++++++++++++++++++++++++------------
 drivers/tty/serial/serial_core.c    |  35 ++++---
 include/linux/serial_8250.h         |   3 +
 3 files changed, 144 insertions(+), 81 deletions(-)

-- 
2.2.2
