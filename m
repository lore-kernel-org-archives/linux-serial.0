From: Jakub Kicinski <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: [PATCH 2/4] sc16is7xx: don't wipe out port configuration on shutdown
Date: Tue, 17 Mar 2015 00:28:47 +0100
Message-ID: <1426548529-21738-3-git-send-email-moorray3@wp.pl>
References: <1426548529-21738-1-git-send-email-moorray3@wp.pl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426548529-21738-1-git-send-email-moorray3-5tc4TXWwyLM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Karol=20D=C4=99bog=C3=B3rski?= <k.debogorski-XA5MxPtj9CQ@public.gmane.org>, Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>

EFCR register contains RS-485 configuration which should not
be changed by shutdown.  Instead of doing a write only update
the appropriate bits.

Signed-off-by: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
---
 drivers/tty/serial/sc16is7xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 11bb44039a57..e6b396e584f3 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -903,9 +903,11 @@ static void sc16is7xx_shutdown(struct uart_port *port)
 	/* Disable all interrupts */
 	sc16is7xx_port_write(port, SC16IS7XX_IER_REG, 0);
 	/* Disable TX/RX */
-	sc16is7xx_port_write(port, SC16IS7XX_EFCR_REG,
-			     SC16IS7XX_EFCR_RXDISABLE_BIT |
-			     SC16IS7XX_EFCR_TXDISABLE_BIT);
+	sc16is7xx_port_update(port, SC16IS7XX_EFCR_REG,
+			      SC16IS7XX_EFCR_RXDISABLE_BIT |
+			      SC16IS7XX_EFCR_TXDISABLE_BIT,
+			      SC16IS7XX_EFCR_RXDISABLE_BIT |
+			      SC16IS7XX_EFCR_TXDISABLE_BIT);
 
 	sc16is7xx_power(port, 0);
 }
-- 
2.1.0
