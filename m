From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [RFC v2 0/6] serdev multiplexing support
Date: Mon, 17 Jul 2017 17:24:30 +0200
Message-ID: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi!

This is a new attempt to add multiplexer support to serdev. It is now based
on the mux subsystem, making it more generic than the previous iteration
("[RFC 0/4] serdev GPIO-based multiplexing support").

Thanks to reviewers for their comments. This revision incorporates the
changes suggested as far as they are still applicable, which mostly applies
to those concerning the MAX9260 i2c adapter driver.

New patches have been added that fix a small issue in the mux include files
("mux: include compiler.h from mux/consumer.h"), and implement deferred
probing of serdev controllers ("serial: core: support deferring serdev
controller registration"), hopefully correctly.

This series depends on the "pinctrl: sh-pfc: r8a7792: Add SCIF1 pin groups"
patch as well as v15 of the mux subsystem series ("[PATCH v15 00/13] mux
controller abstraction and iio/i2c muxes").

CU
Uli


Ulrich Hecht (6):
  mux: include compiler.h from mux/consumer.h
  serdev: add method to set parity
  serdev: add multiplexer support
  serial: core: support deferring serdev controller registration
  max9260: add driver for i2c over GMSL passthrough
  ARM: dts: blanche: add SCIF1 and MAX9260 deserializer

 arch/arm/boot/dts/r8a7792-blanche.dts |  52 ++++++
 drivers/media/i2c/Kconfig             |   6 +
 drivers/media/i2c/Makefile            |   1 +
 drivers/media/i2c/max9260.c           | 288 ++++++++++++++++++++++++++++++++++
 drivers/tty/serdev/Kconfig            |   3 +
 drivers/tty/serdev/Makefile           |   1 +
 drivers/tty/serdev/core.c             |  26 ++-
 drivers/tty/serdev/mux.c              |  66 ++++++++
 drivers/tty/serdev/serdev-ttyport.c   |  17 ++
 drivers/tty/serial/serial_core.c      |   4 +
 include/linux/mux/consumer.h          |   2 +
 include/linux/serdev.h                |  20 ++-
 12 files changed, 482 insertions(+), 4 deletions(-)
 create mode 100644 drivers/media/i2c/max9260.c
 create mode 100644 drivers/tty/serdev/mux.c

-- 
2.7.4
