From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [RFC 0/4] serdev GPIO-based multiplexing support
Date: Wed, 14 Jun 2017 16:38:46 +0200
Message-ID: <1497451130-7741-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: robh@kernel.org, linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi!

This is an attempt to add multiplexer support to serdev, specifically
GPIO-based multiplexing.

Our use case is the Renesas Blanche V2H board with several MAX9260 GMSL
deserializers attached to one serial port. A sample driver that implements
i2c passthrough over the GMSL link is part of this series. This device
wants to be talked to with even parity, so a patch implementing parity
control in serdev is included as well.

The board-specific part of this series depends on the "pinctrl: sh-pfc:
r8a7792: Add SCIF1 pin groups" patch.

Please tell me if this is a suitable way to implement this functionality
in serdev, or how to improve it. Thank you.

CU
Uli


Ulrich Hecht (4):
  serdev: add method to set parity
  serdev: add GPIO-based multiplexer support
  max9260: add driver for i2c over GMSL passthrough
  ARM: dts: blanche: add SCIF1 and MAX9260 deserializer

 arch/arm/boot/dts/r8a7792-blanche.dts |  45 ++++++
 drivers/media/i2c/Kconfig             |   6 +
 drivers/media/i2c/Makefile            |   1 +
 drivers/media/i2c/max9260.c           | 294 ++++++++++++++++++++++++++++++++++
 drivers/tty/serdev/Kconfig            |   3 +
 drivers/tty/serdev/Makefile           |   1 +
 drivers/tty/serdev/core.c             |  55 ++++++-
 drivers/tty/serdev/mux-gpio.c         |  80 +++++++++
 drivers/tty/serdev/serdev-ttyport.c   |  17 ++
 include/linux/serdev.h                |  30 +++-
 10 files changed, 528 insertions(+), 4 deletions(-)
 create mode 100644 drivers/media/i2c/max9260.c
 create mode 100644 drivers/tty/serdev/mux-gpio.c

-- 
2.7.4
