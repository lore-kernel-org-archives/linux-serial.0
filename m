From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH tty-next v2 0/4] Device Tree probing for bcm63xx_uart
Date: Thu, 20 Feb 2014 10:15:50 -0800
Message-ID: <1392920154-3642-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:20432 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbaBTSSG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Feb 2014 13:18:06 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, gregory.0xf0@gmail.com, Florian Fainelli <f.fainelli@gmail.com>

Hi Greg,

This patchset make the bcm63xx_uart architecture agnostic such that it can be
built on something else than MIPS now. Finally it adds support for Device Tree
probing to the driver along with a DT binding documentation.

I would appreciate if this could go via your tree for consistency.

Thanks!

Florian Fainelli (4):
  tty: serial: bcm63xx_uart: include linux/io.h
  tty: serial: bcm63xx_uart: define UART_REG_SIZE constant
  tty: serial: bcm63xx_uart: add support for DT probing
  Documentation: devicetree: add bindings documentation for bcm63xx-uart

 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 27 ++++++++++++++++++++++
 drivers/tty/serial/bcm63xx_uart.c                  | 16 +++++++++++--
 include/linux/serial_bcm63xx.h                     |  2 ++
 3 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

-- 
1.8.3.2

