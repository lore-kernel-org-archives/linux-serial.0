From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 0/9] bcm63xx_uart and of-serial updates
Date: Mon, 20 Oct 2014 13:53:59 -0700
Message-ID: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:54015 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbaJTUyy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Oct 2014 16:54:54 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

In the course of bringing up a new platform[1] that uses this hardware,
I made a couple of improvements:

 - Allow the driver to be built for targets that do not define
   CONFIG_BCM63xx (as mine doesn't)
 - Use devm_ioremap_resource() to simplify the initialization code
 - Allow OF earlycon to be hardwired "on" in the kernel build, so it can
   eventually replace the MIPS EARLY_PRINTK scheme
 - Update documentation; fix typos/grammar


V1->V2:

 - Add acks from Florian
 - Rebase on tty-next (3.18-rc1)
 - bcm63xx_uart: add patches 3,4,6
 - Rework my earlycon change (patches 7,8) to use a config option
   instead of a function call

[1] https://github.com/cernekee/linux/commits/bcm3384


Kevin Cernekee (9):
  tty: serial: bcm63xx: Allow bcm63xx_uart to be built on other
    platforms
  tty: serial: bcm63xx: Update the Kconfig help text
  tty: serial: bcm63xx: Fix typo in MODULE_DESCRIPTION
  Documentation: DT: Add entries for bcm63xx UART
  tty: serial: bcm63xx: Enable DT earlycon support
  tty: serial: bcm63xx: Eliminate unnecessary request/release functions
  tty: serial: of-serial: Suppress warnings if OF earlycon is invoked
    twice
  tty: serial: of-serial: Allow OF earlycon to default to "on"
  MAINTAINERS: Add entry for rp2 (Rocketport Express/Infinity) driver

 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 34 ++++++++++++++
 MAINTAINERS                                        |  6 +++
 drivers/of/fdt.c                                   | 17 +++++--
 drivers/tty/serial/Kconfig                         | 30 +++++++++----
 drivers/tty/serial/bcm63xx_uart.c                  | 52 +++++++++++++---------
 include/linux/serial_bcm63xx.h                     |  2 -
 6 files changed, 106 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

-- 
2.1.1

