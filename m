From: Matteo Croce <technoboy85@gmail.com>
Subject: [PATCH][MIPS][6/7] AR7: serial hack
Date: Thu, 20 Sep 2007 18:11:10 +0200
Message-ID: <200709201811.10447.technoboy85@gmail.com>
References: <200709201728.10866.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:5382 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575AbXITQLS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Sep 2007 12:11:18 -0400
Received: by an-out-0708.google.com with SMTP id d31so87802and
        for <linux-serial@vger.kernel.org>; Thu, 20 Sep 2007 09:11:17 -0700 (PDT)
In-Reply-To: <200709201728.10866.technoboy85@gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hack to use serial in the way the bootloader wants to.

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Nicolas Thill <nico@openwrt.org>

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index f94109c..94253b7 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -267,6 +267,13 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_AR7] = {
+		.name		= "TI-AR7",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
+	},
 };
 
 #if defined (CONFIG_SERIAL_8250_AU1X00)
@@ -2453,7 +2460,11 @@ static void serial8250_console_putchar(struct uart_port *port, int ch)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 
+#ifdef CONFIG_AR7
+	wait_for_xmitr(up, BOTH_EMPTY);
+#else
 	wait_for_xmitr(up, UART_LSR_THRE);
+#endif
 	serial_out(up, UART_TX, ch);
 }
 
diff --git a/include/linux/serialP.h b/include/linux/serialP.h
index e811a61..cf71de9 100644
--- a/include/linux/serialP.h
+++ b/include/linux/serialP.h
@@ -135,6 +135,10 @@ struct rs_multiport_struct {
  * the interrupt line _up_ instead of down, so if we register the IRQ
  * while the UART is in that state, we die in an IRQ storm. */
 #define ALPHA_KLUDGE_MCR (UART_MCR_OUT2)
+#elif defined(CONFIG_AR7)
+/* This is how it is set up by bootloader... */
+#define ALPHA_KLUDGE_MCR (UART_MCR_OUT2 | UART_MCR_OUT1 \
+			| UART_MCR_RTS | UART_MCR_DTR)
 #else
 #define ALPHA_KLUDGE_MCR 0
 #endif
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 09d17b0..8ad2c3b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -40,6 +40,7 @@
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
 #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
+#define PORT_AR7	16
 #define PORT_MAX_8250	16	/* max port ID */
 
 /*
