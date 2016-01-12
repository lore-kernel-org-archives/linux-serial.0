From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 00/11] Earlycon cleanup
Date: Tue, 12 Jan 2016 11:41:01 -0800
Message-ID: <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Sebastian Frias <sf84@laposte.net>, Paul Burton <paul.burton@imgtec.com>, Peter Hurley <peter@hurleysoftware.com>
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


Rob has expressed a desire to have the DT parts live in drivers/of/fdt.c
The problem with this approach is two-fold. Firstly, the number of required
parameters quickly becomes ugly (base address, io reg width, io reg offset,
io reg stride, endianness, earlycon name). Secondly, drivers are already
requiring access to alternate DT properties, like clocks, to initialize
earlycons, and this requirement will continue.

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
 drivers/tty/serial/8250/8250_early.c |  36 +++++++++--
 drivers/tty/serial/amba-pl011.c      |   1 -
 drivers/tty/serial/arc_uart.c        |   1 -
 drivers/tty/serial/earlycon.c        | 117 ++++++++++++++++++++++++++---------
 drivers/tty/serial/msm_serial.c      |   2 -
 drivers/tty/serial/samsung.c         |   6 --
 drivers/tty/serial/sprd_serial.c     |   2 -
 include/asm-generic/vmlinux.lds.h    |   6 +-
 include/linux/of_fdt.h               |   2 +-
 include/linux/serial_core.h          |  25 +++++---
 12 files changed, 160 insertions(+), 81 deletions(-)

-- 
2.7.0
