From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 0/3] tty: serial: make of_serial work on Ralink SoC
Date: Sat, 13 Apr 2013 11:33:35 +0200
Message-ID: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:39366 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283Ab3DMJho (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Apr 2013 05:37:44 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, John Crispin <blogic@openwrt.org>

Ralink SoC uses the same 8250 iotype as AU1x00. In order to make this work form
a devicetree, the correct iotype needs to be probed inside
of_platform_serial_setup().

Ralink SoC has a different iosize than AU1x00, which causes
serial8250_port_size() to return 0x1000 instead of the correct 0x100. Instead of
adding another static if statement we probe the real iosize from the resource
inside the devicetree.

Gabor Juhos (2):
  tty: serial: add iosize field to struct uart_port
  tty: of_serial: initialize port.iosize from resource

John Crispin (1):
  tty: of_serial: allow rt288x-uart to load from OF

 drivers/tty/serial/8250/8250_core.c |    3 +++
 drivers/tty/serial/of_serial.c      |   11 +++++++++--
 include/linux/serial_core.h         |    1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
1.7.10.4

