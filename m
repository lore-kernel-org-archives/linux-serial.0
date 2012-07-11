From: Raphael Assenat <raph@8d.com>
Subject: [PATCH] 8250: Add new UART type SC16C550
Date: Wed, 11 Jul 2012 15:54:53 -0400
Message-ID: <20120711195453.GC4260@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:56477 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571Ab2GKUXz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Jul 2012 16:23:55 -0400
Received: from raph.usine.8d.com ([192.168.142.55] helo=renkinjitsu.usine.8d.com)
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1Sp2zt-0006yL-NA
	for linux-serial@vger.kernel.org; Wed, 11 Jul 2012 15:54:54 -0400
Received: from raph by renkinjitsu.usine.8d.com with local (Exim 4.72)
	(envelope-from <raph@8d.com>)
	id 1Sp2zt-0001Fj-H3
	for linux-serial@vger.kernel.org; Wed, 11 Jul 2012 15:54:53 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

    The NXP SC16C550 has a 16 Byte FIFO and support Automatic Flow Control,
    enabled by setting bit 5 of MCR (a.k.a. AFE).
    
    This patch adds a new 8250 port type (PORT_SC16C550) to support
    this chip correcly. Should also work for TI TL16550C/D.
    
    Tested on a custom OMAP board with an SC16C554 (quad uart) attached
    to the GPMC. We experienced receive overruns when not using AFE.
    
    Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 6e1958a..ffea4f3 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -282,6 +282,13 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR,
 	},
+	[PORT_SC16C550] = {
+		.name		= "SC16C550",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 65db992..e472af3 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -47,7 +47,8 @@
 #define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
 #define PORT_TEGRA	20	/* NVIDIA Tegra internal UART */
 #define PORT_XR17D15X	21	/* Exar XR17D15x UART */
-#define PORT_MAX_8250	21	/* max port ID */
+#define PORT_SC16C550	22	/* NXP SC16C550 and equivalents */
+#define PORT_MAX_8250	22	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
