From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/4] Serial: UART driver changes for Cavium OCTEON.
Date: Mon,  1 Dec 2008 15:49:28 -0800
Message-ID: <1228175368-5536-4-git-send-email-ddaney@caviumnetworks.com>
References: <4934774E.6080805@caviumnetworks.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:48178 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbYLAXtp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Dec 2008 18:49:45 -0500
In-Reply-To: <4934774E.6080805@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk
Cc: linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>, Tomaso Paoletti <tpaoletti@caviumnetworks.com>

Cavium UART implementation is not covered by existing uart_configS.
Define a new uart_config (PORT_OCTEON) which is specified by OCTEON
platform device registration code.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/serial/8250.c       |    7 +++++++
 include/linux/serial_core.h |    3 ++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 3ae4974..daa0056 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -279,6 +279,13 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_OCTEON] = {
+		.name		= "OCTEON",
+		.fifo_size	= 64,
+		.tx_loadsz	= 64,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 #if defined (CONFIG_SERIAL_8250_AU1X00)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b9e7756..fd772b5 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -40,7 +40,8 @@
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
 #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
-#define PORT_MAX_8250	16	/* max port ID */
+#define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
+#define PORT_MAX_8250	17	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
-- 
1.5.6.5

