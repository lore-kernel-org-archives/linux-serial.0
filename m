From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 4/3] tty: serial: bcm63xx: Enable DT earlycon support
Date: Sun, 19 Oct 2014 10:26:15 -0700
Message-ID: <1413739575-10222-1-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:59099 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbaJSR1Y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 19 Oct 2014 13:27:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>

This enables early console output if there is a chosen/stdout-path
property referencing a UART node with the "brcm,bcm6345-uart" compatible
string.  The bootloader sets up the pinmux and baud/parity/etc.
Tested on bcm3384 (MIPS, DT).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/Kconfig        |  1 +
 drivers/tty/serial/bcm63xx_uart.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 815b652..fdd851e 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1297,6 +1297,7 @@ config SERIAL_BCM63XX_CONSOLE
 	bool "Console on BCM63xx serial port"
 	depends on SERIAL_BCM63XX=y
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 	help
 	  If you have enabled the serial port on the BCM63xx CPU
 	  you can make it the console by answering Y to this option.
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 2315190..48bd509 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -782,6 +782,26 @@ static int __init bcm63xx_console_init(void)
 
 console_initcall(bcm63xx_console_init);
 
+static void bcm_early_write(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, bcm_console_putchar);
+	wait_for_xmitr(&dev->port);
+}
+
+static int __init bcm_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = bcm_early_write;
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(bcm63xx_uart, "brcm,bcm6345-uart", bcm_early_console_setup);
+
 #define BCM63XX_CONSOLE	(&bcm63xx_console)
 #else
 #define BCM63XX_CONSOLE	NULL
-- 
2.1.1

