From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 4/9] serial: fsl_lpuart: Use common rs485 device tree parsing function
Date: Wed, 21 Jun 2017 12:21:25 +0200
Message-ID: <20170621102130.21024-5-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170621102130.21024-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

We just got a common helper for parsing the rs485 specific
device tree properties. Use it and drop the open coded parser.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/tty/serial/fsl_lpuart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 15df1ba78095..7988a8a981d1 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2054,8 +2054,9 @@ static int lpuart_probe(struct platform_device *pdev)
 		dev_info(sport->port.dev, "DMA rx channel request failed, "
 				"operating without rx DMA\n");
 
-	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time")) {
-		sport->port.rs485.flags |= SER_RS485_ENABLED;
+	of_get_rs485_mode(np, &sport->port.rs485);
+
+	if (sport->port.rs485.flags & SER_RS485_ENABLED) {
 		sport->port.rs485.flags |= SER_RS485_RTS_ON_SEND;
 		writeb(UARTMODEM_TXRTSE, sport->port.membase + UARTMODEM);
 	}
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
