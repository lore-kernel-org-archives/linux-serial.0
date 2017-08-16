From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/6] serdev multiplexing support
Date: Wed, 16 Aug 2017 15:22:22 +0200
Message-ID: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi!

Here's a new version of serdev multiplexing support. Thanks to everybody who
commented; I think I have included all non-optional suggestions. :)
Changes are manifold, please refer to the changelog below.

This version drops "mux: include compiler.h from mux/consumer.h",
which is on its way upstream by now.

CU
Uli


Changes since RFC v2:
- parity: use an enum instead of the traditional enable/odd flags
- mux: include it in the serdev core, remove option
- mux: add "select MULTIPLEXER" to Kconfig
- serdev: use device "reg" node as serdev_device::nr
- mux: check if device has an of_node before trying to register mux
- serdev: remove check for !serdev->ops in,
  serdev_controller_write_wakeup(), it is not needed
- max9260: replace register numbers, magic protocol bytes and device ID with
  macros
- max9260: use enum instead of macros for the rx_state
- max9260: use wait_event_timeout() instead of
  wait_event_interruptible_timeout()
- max9260: pass all parameters for max9260_transact() as arguments
- max9260: add "max9260_" prefix to max9260_wait_for_transaction()
- max9260: return -ENODEV instead of -EINVAL if the device does not respond
  correctly
- max9260: change a number of length-bearing variables to size_t
- dt: number max9260 devices according to their "reg" node


Ulrich Hecht (6):
  serdev: add method to set parity
  serdev: add multiplexer support
  serial: core: support deferring serdev controller registration
  max9260: add driver for i2c over GMSL passthrough
  ARM: dts: blanche: add SCIF1 and MAX9260 deserializer
  dt-bindings: slave-device: add reg property

 .../devicetree/bindings/serial/slave-device.txt    |   2 +
 arch/arm/boot/dts/r8a7792-blanche.dts              |  52 ++++
 drivers/media/i2c/Kconfig                          |   6 +
 drivers/media/i2c/Makefile                         |   1 +
 drivers/media/i2c/max9260.c                        | 300 +++++++++++++++++++++
 drivers/tty/serdev/Kconfig                         |   1 +
 drivers/tty/serdev/Makefile                        |   2 +-
 drivers/tty/serdev/core.c                          |  25 +-
 drivers/tty/serdev/mux.c                           |  66 +++++
 drivers/tty/serdev/serdev-ttyport.c                |  18 ++
 drivers/tty/serial/serial_core.c                   |   4 +
 include/linux/serdev.h                             |  24 +-
 12 files changed, 497 insertions(+), 4 deletions(-)
 create mode 100644 drivers/media/i2c/max9260.c
 create mode 100644 drivers/tty/serdev/mux.c

-- 
2.7.4
