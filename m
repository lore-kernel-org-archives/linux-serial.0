From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 00/13] Earlycon cleanup
Date: Wed,  8 Apr 2015 13:45:06 -0400
Message-ID: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg, Grant & Rob,

This patch series builds on my earlier "Extensible console matching &
direct earlycon" to add several useful features to earlycon:
* Proper port i/o configuration from DT node with of_serial properties
  (such as reg-io-width, reg-shift and reg-offset)
* Proper console name & index initialization from earlycon name
  (for both command line and DT-defined earlycons)
* Support for DT 'stdout-path' options pass-through to earlycon setup
* Improved log messages for troubleshooting
* Support for multiple OF earlycon declarations so different
  compatible strings can specify the same OF earlycon

* Changes from v1 *

- Rebase on top of device-tree compiler patch submission,
  "libfdt: Add fdt_path_offset_namelen()"
- Fixed x86 build breakage, conditionally compile of_setup_earlycon();
  Note: this should have already been the case since of_setup_earlycon()
  is dead code without CONFIG_OF_EARLY_FLATTREE
- Fixed Geert's suggestion to change the printf specifier for ->mapbase
- Fixed initial console index value for earlycon name without trailing
  numerals

* Changes from v2 *

- All earlycon declarations are now in a single table, with a common
  framework for devicetree and command line earlycons


Requires: 1) "libfdt: Add fdt_path_offset_namelen()" -- now in
	     upstream dtc
	  2) the last patch which adds omap8250 earlycon requires some
	     kind of fixmap support, such as "ARM: early fixmap support
	     for earlycon", which has not yet been accepted upstream.

Regards,

Peter Hurley (13):
  of: earlycon: Fix 'stdout-path' with ':' path terminator
  earlycon: Use common framework for earlycon declarations
  serial: earlycon: Fixup earlycon console name and index
  of: earlycon: Fixup earlycon console name and index
  of: earlycon: Add options string handling
  of: earlycon: of_setup_earlycon() requires CONFIG_OF_EARLY_FLATTREE
  of: earlycon: Initialize port fields from DT properties
  of: earlycon: Move address translation to of_setup_earlycon()
  serial: earlycon: Common log banner for command line and DT
  serial: earlycon: Show the earlycon "driver" in banner
  of: earlycon: Log more helpful message if earlycon not found
  serial: 8250_early: Use port->regshift
  serial: 8250_omap: Add omap8250 earlycon

 drivers/of/fdt.c                     |  28 ++++-----
 drivers/of/fdt_address.c             |  11 +++-
 drivers/tty/serial/8250/8250_early.c |  29 +++++++++-
 drivers/tty/serial/amba-pl011.c      |   1 -
 drivers/tty/serial/arc_uart.c        |   1 -
 drivers/tty/serial/earlycon.c        | 109 ++++++++++++++++++++++++++---------
 drivers/tty/serial/msm_serial.c      |   2 -
 drivers/tty/serial/samsung.c         |   6 --
 drivers/tty/serial/sprd_serial.c     |   2 -
 include/asm-generic/vmlinux.lds.h    |   8 +--
 include/linux/of_fdt.h               |   2 +-
 include/linux/serial_core.h          |  25 ++++----
 12 files changed, 151 insertions(+), 73 deletions(-)

-- 
2.3.5
