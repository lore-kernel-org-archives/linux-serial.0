From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/2] serial: at91, fix rs485 properties
Date: Sun, 11 Oct 2015 15:22:44 +0200
Message-ID: <1444569765-9081-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Elen Song <elen.song@atmel.com>
List-Id: linux-serial@vger.kernel.org

There is a misplaced bracket in atmel_init_rs485 which sets
rs485-rx-during-tx and rs485-enabled-at-boot-time only if
rs485-rts-delay is set in of.

This is clearly a bug, so fix it by moving the bracket to the proper
place.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Elen Song <elen.song@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 473538ebbe8c..ad3e5768aab1 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1682,15 +1682,15 @@ static void atmel_init_rs485(struct uart_port *port,
 	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 
 	if (np) {
+		struct serial_rs485 *rs485conf = &port->rs485;
 		u32 rs485_delay[2];
 		/* rs485 properties */
 		if (of_property_read_u32_array(np, "rs485-rts-delay",
 					rs485_delay, 2) == 0) {
-			struct serial_rs485 *rs485conf = &port->rs485;
-
 			rs485conf->delay_rts_before_send = rs485_delay[0];
 			rs485conf->delay_rts_after_send = rs485_delay[1];
 			rs485conf->flags = 0;
+		}
 
 		if (of_get_property(np, "rs485-rx-during-tx", NULL))
 			rs485conf->flags |= SER_RS485_RX_DURING_TX;
@@ -1698,7 +1698,6 @@ static void atmel_init_rs485(struct uart_port *port,
 		if (of_get_property(np, "linux,rs485-enabled-at-boot-time",
 								NULL))
 			rs485conf->flags |= SER_RS485_ENABLED;
-		}
 	} else {
 		port->rs485       = pdata->rs485;
 	}
-- 
2.6.1
