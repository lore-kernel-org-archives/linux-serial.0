From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v4 5/9] serial: fsl_lpuart: Use common rs485 device tree parsing function
Date: Tue, 18 Jul 2017 12:59:44 +0200
Message-ID: <20170718105948.21986-6-u.kleine-koenig@pengutronix.de>
References: <20170718105948.21986-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170718105948.21986-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

We just got a common helper for parsing the rs485 specific
device tree properties. Use it and drop the open coded parser.

As a side effect this adds support for parsing rs485-rts-delay and
rs485-rx-during-tx. As the driver doesn't support this though, probing
fails if these are defined.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/tty/serial/fsl_lpuart.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 4becfbf35c4c..cac81b143abe 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2161,6 +2161,24 @@ static int lpuart_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	of_get_rs485_mode(np, &sport->port.rs485);
+
+	if (sport->port.rs485.flags & SER_RS485_RX_DURING_TX) {
+		dev_err(&pdev->dev, "driver doesn't support RX during TX\n");
+		return -ENOSYS;
+	}
+
+	if (sport->port.rs485.delay_rts_before_send ||
+	    sport->port.rs485.delay_rts_after_send) {
+		dev_err(&pdev->dev, "driver doesn't support RTS delays\n");
+		return -ENOSYS;
+	}
+
+	if (sport->port.rs485.flags & SER_RS485_ENABLED) {
+		sport->port.rs485.flags |= SER_RS485_RTS_ON_SEND;
+		writeb(UARTMODEM_TXRTSE, sport->port.membase + UARTMODEM);
+	}
+
 	sport->dma_tx_chan = dma_request_slave_channel(sport->port.dev, "tx");
 	if (!sport->dma_tx_chan)
 		dev_info(sport->port.dev, "DMA tx channel request failed, "
@@ -2171,12 +2189,6 @@ static int lpuart_probe(struct platform_device *pdev)
 		dev_info(sport->port.dev, "DMA rx channel request failed, "
 				"operating without rx DMA\n");
 
-	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time")) {
-		sport->port.rs485.flags |= SER_RS485_ENABLED;
-		sport->port.rs485.flags |= SER_RS485_RTS_ON_SEND;
-		writeb(UARTMODEM_TXRTSE, sport->port.membase + UARTMODEM);
-	}
-
 	return 0;
 }
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
