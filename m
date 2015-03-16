From: Jakub Kicinski <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: [PATCH 3/4] sc16is7xx: expose RTS inversion in RS-485 mode
Date: Tue, 17 Mar 2015 00:28:48 +0100
Message-ID: <1426548529-21738-4-git-send-email-moorray3@wp.pl>
References: <1426548529-21738-1-git-send-email-moorray3@wp.pl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426548529-21738-1-git-send-email-moorray3-5tc4TXWwyLM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Karol=20D=C4=99bog=C3=B3rski?= <k.debogorski-XA5MxPtj9CQ@public.gmane.org>, Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>

Hardware is capable of inverting RTS signal when working
in RS-485 mode.  Expose this functionality to user space.
Relay on a matching combination of standard flags
(SER_RS485_RTS_ON_SEND and SER_RS485_RTS_AFTER_SEND) to
detect when user space is requesting inverted RTS mode.

Signed-off-by: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
---
 drivers/tty/serial/sc16is7xx.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e6b396e584f3..24902d589b07 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -829,16 +829,30 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 }
 
 static int sc16is7xx_config_rs485(struct uart_port *port,
-				   struct serial_rs485 *rs485)
+				  struct serial_rs485 *rs485)
 {
-	if (port->rs485.flags & SER_RS485_ENABLED)
-		sc16is7xx_port_update(port, SC16IS7XX_EFCR_REG,
-				      SC16IS7XX_EFCR_AUTO_RS485_BIT,
-				      SC16IS7XX_EFCR_AUTO_RS485_BIT);
-	else
-		sc16is7xx_port_update(port, SC16IS7XX_EFCR_REG,
-				      SC16IS7XX_EFCR_AUTO_RS485_BIT,
-				      0);
+	const u32 mask = SC16IS7XX_EFCR_AUTO_RS485_BIT |
+			 SC16IS7XX_EFCR_RTS_INVERT_BIT;
+	u32 efcr = 0;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		bool rts_during_rx, rts_during_tx;
+
+		rts_during_rx = rs485->flags & SER_RS485_RTS_AFTER_SEND;
+		rts_during_tx = rs485->flags & SER_RS485_RTS_ON_SEND;
+
+		efcr |= SC16IS7XX_EFCR_AUTO_RS485_BIT;
+
+		if (!rts_during_rx && rts_during_tx)
+			/* default */;
+		else if (rts_during_rx && !rts_during_tx)
+			efcr |= SC16IS7XX_EFCR_RTS_INVERT_BIT;
+		else
+			return -EINVAL;
+	}
+
+	sc16is7xx_port_update(port, SC16IS7XX_EFCR_REG, mask, efcr);
+
 	port->rs485 = *rs485;
 
 	return 0;
-- 
2.1.0
