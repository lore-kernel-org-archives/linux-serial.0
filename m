From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH/RFC 0/8] UART driver support for BMIPS multiplatform kernels
Date: Wed, 12 Nov 2014 00:46:25 -0800
Message-ID: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:62348 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaKLIrG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 03:47:06 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

Use the pxa serial driver to support BCM7xxx's UARTs; add code to allow
native-endian operation on both LE and BE systems.  Enable OF_EARLYCON
in the pxa driver.

After applying these changes I am able to build a multiplatform kernel
that boots to the prompt on BCM6328 (bcm63xx_uart) and BCM7346 (pxa).


Kevin Cernekee (7):
  serial: core: Add big_endian flag
  of: Add helper function to check MMIO register endianness
  serial: pxa: Add fifo-size and {big,native}-endian properties
  serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
  serial: pxa: Update DT binding documentation
  serial: earlycon: Set uart_port->big_endian based on DT properties
  serial: pxa: Add OF_EARLYCON support

Tushar Behera (1):
  tty: Fallback to use dynamic major number

 .../devicetree/bindings/serial/mrvl-serial.txt     | 34 +++++++++++-
 drivers/of/base.c                                  | 23 ++++++++
 drivers/of/fdt.c                                   |  9 +++-
 drivers/tty/serial/Kconfig                         |  2 +-
 drivers/tty/serial/earlycon.c                      |  3 +-
 drivers/tty/serial/pxa.c                           | 62 +++++++++++++++++++++-
 drivers/tty/tty_io.c                               | 19 +++++--
 include/linux/of.h                                 |  6 +++
 include/linux/serial_core.h                        |  5 +-
 9 files changed, 152 insertions(+), 11 deletions(-)

-- 
2.1.1

