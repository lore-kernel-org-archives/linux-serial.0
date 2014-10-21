From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 00/10] bcm63xx_uart and of-serial updates
Date: Tue, 21 Oct 2014 15:22:56 -0700
Message-ID: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:63869 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933387AbaJUWXX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 18:23:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de, geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

V2->V3:

Change DT clock node based on review feedback (thanks Arnd!)

Rebase on Linus' master branch


Kevin Cernekee (10):
  tty: serial: bcm63xx: Allow bcm63xx_uart to be built on other
    platforms
  tty: serial: bcm63xx: Add support for unnamed clock outputs from DT
  tty: serial: bcm63xx: Update the Kconfig help text
  tty: serial: bcm63xx: Fix typo in MODULE_DESCRIPTION
  Documentation: DT: Add entries for bcm63xx UART
  tty: serial: bcm63xx: Enable DT earlycon support
  tty: serial: bcm63xx: Eliminate unnecessary request/release functions
  tty: serial: of-serial: Suppress warnings if OF earlycon is invoked
    twice
  tty: serial: of-serial: Allow OF earlycon to default to "on"
  MAINTAINERS: Add entry for rp2 (Rocketport Express/Infinity) driver

 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 30 ++++++++++++
 MAINTAINERS                                        |  6 +++
 drivers/of/fdt.c                                   | 17 +++++--
 drivers/tty/serial/Kconfig                         | 30 ++++++++----
 drivers/tty/serial/bcm63xx_uart.c                  | 55 +++++++++++++---------
 include/linux/serial_bcm63xx.h                     |  2 -
 6 files changed, 104 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

-- 
2.1.1

