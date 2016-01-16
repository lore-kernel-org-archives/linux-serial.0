From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5 00/11] Earlycon cleanup
Date: Sat, 16 Jan 2016 13:37:13 -0800
Message-ID: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
References: <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg, Grant & Rob,

This patch series is a rebase of the v3 from April last year.

This patch series builds on my earlier "Extensible console matching &
direct earlycon" to add several useful features to earlycon:
* Proper port i/o configuration from DT node with of_serial properties
  (such as reg-io-width, reg-shift and reg-offset, and endianness)
* Proper console name & index initialization from earlycon name
  (for both command line and DT-defined earlycons)
* Support for DT 'stdout-path' options pass-through to earlycon setup
* Improved log messages for troubleshooting
* Support for multiple OF earlycon declarations so different
  compatible strings can specify the same OF earlycon

* Changes from v3
  - Added 32-bit big-endian support
  - Removed the omap8250 earlycon (will follow later)
* Changes from v4
  - Rolled in Rob's acks (thanks for reviewing this series)
  - Removed the conditional guard of of_fdt.h header inclusion (Rob's comment)
  - Left in the omap8250 earlycon (rebased w/o the wip so applies cleanly)

Regards,

Peter Hurley (11):
  earlycon: Use common framework for earlycon declarations
  serial: earlycon: Fixup earlycon console name and index
  of: earlycon: Fixup earlycon console name and index
  of: earlycon: Add options string handling
  of: earlycon: Initialize port fields from DT properties
  of: earlycon: Move address translation to of_setup_earlycon()
  serial: earlycon: Common log banner for command line and DT
  serial: earlycon: Show the earlycon "driver" in banner
  serial: 8250_early: Use port->regshift
  of: earlycon: Log more helpful message if stdout-path node not found
  serial: 8250_omap: Add omap8250 earlycon

 drivers/of/fdt.c                     |  32 +++++-----
 drivers/of/fdt_address.c             |  11 +++-
 drivers/tty/serial/8250/8250_early.c |  37 ++++++++++--
 drivers/tty/serial/amba-pl011.c      |   1 -
 drivers/tty/serial/arc_uart.c        |   1 -
 drivers/tty/serial/earlycon.c        | 114 ++++++++++++++++++++++++++---------
 drivers/tty/serial/msm_serial.c      |   2 -
 drivers/tty/serial/samsung.c         |   6 --
 drivers/tty/serial/sprd_serial.c     |   2 -
 include/asm-generic/vmlinux.lds.h    |   6 +-
 include/linux/of_fdt.h               |   2 +-
 include/linux/serial_core.h          |  25 +++++---
 12 files changed, 158 insertions(+), 81 deletions(-)

-- 
2.7.0
