From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] serial: 8250: add uart_config entry for PORT_RT2880
Date: Fri,  2 Oct 2015 17:50:31 +0100
Message-ID: <1443804631-10024-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: slash.tmp@free.fr
List-Id: linux-serial@vger.kernel.org

This adds an entry to the uart_config table for PORT_RT2880
enabling rx/tx FIFOs.  The UART is actually a Palmchip BK-3103
which is found in several devices from Alchemy/RMI, Ralink, and
Sigma Designs.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/tty/serial/8250/8250_port.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8e351c4..8f53ed5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -261,6 +261,14 @@ configured less than Maximum supported fifo bytes */
 				  UART_FCR7_64BYTE,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_RT2880] = {
+		.name		= "Palmchip BK-3103",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.rxtrig_bytes	= {1, 4, 8, 14},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
-- 
2.5.3
