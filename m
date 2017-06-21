From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 3/9] serial: atmel: Use common rs485 device tree parsing function
Date: Wed, 21 Jun 2017 12:21:24 +0200
Message-ID: <20170621102130.21024-4-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170621102130.21024-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

We just got a common helper for parsing the rs485 specific
device tree properties. Use it and drop the open coded parser.

Note that the common function is more strict, so some device trees
needed fixing in the previous commit.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Cc: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

 drivers/tty/serial/atmel_serial.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index b753d2020068..a6b0c0087e2d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1706,22 +1706,7 @@ static void atmel_init_rs485(struct uart_port *port,
 	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 
 	if (np) {
-		struct serial_rs485 *rs485conf = &port->rs485;
-		u32 rs485_delay[2];
-		/* rs485 properties */
-		if (of_property_read_u32_array(np, "rs485-rts-delay",
-					rs485_delay, 2) == 0) {
-			rs485conf->delay_rts_before_send = rs485_delay[0];
-			rs485conf->delay_rts_after_send = rs485_delay[1];
-			rs485conf->flags = 0;
-		}
-
-		if (of_get_property(np, "rs485-rx-during-tx", NULL))
-			rs485conf->flags |= SER_RS485_RX_DURING_TX;
-
-		if (of_get_property(np, "linux,rs485-enabled-at-boot-time",
-								NULL))
-			rs485conf->flags |= SER_RS485_ENABLED;
+		of_get_rs485_mode(np, &port->rs485);
 	} else if (pdata) {
 		port->rs485 = pdata->rs485;
 	} else {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
