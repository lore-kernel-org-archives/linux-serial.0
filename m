From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2 7/9] serial: imx: default to half duplex rs485
Date: Fri, 23 Jun 2017 11:49:43 +0200
Message-ID: <20170623094945.31908-8-u.kleine-koenig@pengutronix.de>
References: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170623094945.31908-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

The i.MX driver defaulted to full duplex rs485 which is rather
unusual and doesn't match the default implemented in other drivers.

So change the default to half duplex.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/tty/serial/imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index bbefddd92bfe..d5deeef0cd5b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2137,8 +2137,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.fifosize = 32;
 	sport->port.ops = &imx_pops;
 	sport->port.rs485_config = imx_rs485_config;
-	sport->port.rs485.flags =
-		SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX;
+	sport->port.rs485.flags = SER_RS485_RTS_ON_SEND;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	init_timer(&sport->timer);
 	sport->timer.function = imx_timeout;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
