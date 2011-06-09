From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct accessors
Date: Thu,  9 Jun 2011 11:48:45 +0100
Message-ID: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50278 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab1FIKsv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Jun 2011 06:48:51 -0400
Received: by wya21 with SMTP id 21so1010754wya.19
        for <linux-serial@vger.kernel.org>; Thu, 09 Jun 2011 03:48:50 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@suse.de>

Don't pass a pointer to the USR register through the private_data field
of the platform data.  This isn't type safe and it's not clear what is
happening.  Add the USR offset to serial_reg.h and use an explicit
serial_in() to read it with the correct accessor.

Fix up the only in-tree user to not pass anything through private_data.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_serial.c |    1 -
 drivers/tty/serial/8250.c                 |    3 +--
 include/linux/serial_reg.h                |    3 +++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
index f726162..5ccfdcc 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_serial.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
@@ -63,7 +63,6 @@ void __init msp_serial_setup(void)
 	up.flags        = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	up.type         = PORT_16550A;
 	up.line         = 0;
-	up.private_data		= (void*)UART0_STATUS_REG;
 	if (early_serial_setup(&up))
 		printk(KERN_ERR "Early serial init of port 0 failed\n");
 
diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index b40f7b9..0596caa 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1666,8 +1666,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 			 * interrupt meaning an LCR write attempt occurred while the
 			 * UART was busy. The interrupt must be cleared by reading
 			 * the UART status register (USR) and the LCR re-written. */
-			unsigned int status;
-			status = *(volatile u32 *)up->port.private_data;
+			(void)serial_in(up, UART_DWAPB_USR);
 			serial_out(up, UART_LCR, up->lcr);
 
 			handled = 1;
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index c75bda3..abfd8ea 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -350,6 +350,9 @@
 #define UART_OMAP_SYSS		0x16	/* System status register */
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
+/* Extra serial register definitions for the Synopsys DesignWare UART. */
+#define UART_DWAPB_USR		0x1F	/* UART status register */
+
 /*
  * These are the definitions for the MDR1 register
  */
-- 
1.7.4.1

