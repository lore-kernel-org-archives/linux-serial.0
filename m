From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 00/14] OF earlycon cleanup
Date: Fri,  6 Mar 2015 14:25:16 -0500
Message-ID: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

I thought I'd respin this to address the bugs in v1.

I'm still having an open conversation with Rob Herring about the
OF_EARLYCON_DECLARE macro and earlycon console names.

* Changes from v1 *

- Rebase on top of device-tree compiler patch submission,
  "libfdt: Add fdt_path_offset_namelen()"
- Fixed x86 build breakage, conditionally compile of_setup_earlycon();
  Note: this should have already been the case since of_setup_earlycon()
  is dead code without CONFIG_OF_EARLY_FLATTREE
- Fixed Geert's suggestion to change the printf specifier for ->mapbase
- Fixed initial console index value for earlycon name without trailing
  numerals


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

Lastly, this patch series adds an omap8250 OF earlycon. I don't think
the last patch requires the "Split 8250 driver" to work but it won't
apply cleanly without it.

Requires: 1) "libfdt: Add fdt_path_offset_namelen()"
	  2) the last patch which adds omap8250 earlycon requires some
	     kind of fixmap support, such as "ARM: early fixmap support
	     for earlycon", which has not yet been accepted upstream.

Regards,

Peter Hurley (14):
  of: earlycon: Fix 'stdout-path' with ':' path terminator
  serial: earlycon: Fixup earlycon console name and index
  serial: earlycon: Emit earlycon name in the OF table
  of: earlycon: Fixup earlycon console name and index
  of: earlycon: Add options string handling
  of: earlycon: of_setup_earlycon() requires CONFIG_OF_EARLY_FLATTREE
  of: earlycon: Initialize port fields from DT properties
  of: earlycon: Move address translation to of_setup_earlycon()
  serial: earlycon: Common log banner for command line and DT
  serial: earlycon: Show the earlycon "driver" in banner
  of: earlycon: Allow multiple OF_EARLYCON_DECLARE() with same name
  of: earlycon: Log more helpful message if earlycon not found
  serial: 8250_early: Use port->regshift
  serial: 8250_omap: Add omap8250 earlycon

 drivers/of/fdt.c                     |  18 +++----
 drivers/of/fdt_address.c             |  11 +++-
 drivers/tty/serial/8250/8250_early.c |  29 +++++++++-
 drivers/tty/serial/earlycon.c        | 100 ++++++++++++++++++++++++++++-------
 include/linux/of_fdt.h               |   2 +-
 include/linux/serial_core.h          |  20 +++++--
 6 files changed, 144 insertions(+), 36 deletions(-)

-- 
2.3.1
