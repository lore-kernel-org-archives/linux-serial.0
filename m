From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 00/10] UART driver support for BMIPS multiplatform kernels
Date: Wed, 12 Nov 2014 12:53:57 -0800
Message-ID: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35791 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbaKLUyc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 15:54:32 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

V1->V2:

Add a new UPIO_MEM32BE iotype instead of a separate big_endian flag.

Change some of the of_*_is_* APIs to return bool, where appropriate.

Fix a few minor comment issues.


Kevin Cernekee (9):
  serial: core: Add big-endian iotype
  of: Fix of_device_is_compatible() comment
  of: Change of_device_is_available() to return bool
  of: Add helper function to check MMIO register endianness
  serial: pxa: Add fifo-size and {big,native}-endian properties
  serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
  serial: pxa: Update DT binding documentation
  serial: earlycon: Set UPIO_MEM32BE based on DT properties
  serial: pxa: Add OF_EARLYCON support

Tushar Behera (1):
  tty: Fallback to use dynamic major number

 .../devicetree/bindings/serial/mrvl-serial.txt     | 34 +++++++++++-
 drivers/of/base.c                                  | 47 ++++++++++++----
 drivers/of/fdt.c                                   |  9 ++-
 drivers/tty/serial/Kconfig                         |  2 +-
 drivers/tty/serial/earlycon.c                      |  4 +-
 drivers/tty/serial/pxa.c                           | 64 +++++++++++++++++++++-
 drivers/tty/serial/serial_core.c                   |  2 +
 drivers/tty/tty_io.c                               | 19 ++++++-
 include/linux/of.h                                 | 12 +++-
 include/linux/serial_core.h                        | 15 ++---
 10 files changed, 176 insertions(+), 32 deletions(-)

-- 
2.1.1

