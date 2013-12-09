From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] serial: pl011: also enable DMA Rx polling with no platform
 data
Date: Mon, 9 Dec 2013 12:53:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1312091229550.30018@axis700.grange>
References: <1385631664-32607-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64093 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760360Ab3LILxm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Dec 2013 06:53:42 -0500
In-Reply-To: <1385631664-32607-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jongsung Kim <neidhard.kim@lge.com>, Chanho Min <chanho.min@lge.com>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

An earlier patch "serial: pl011: use DMA RX polling by default" enabled
DMA Rx polling on PL011 only in configurations, using platform data. A
simple extension of that patch also enables DMA Rx polling when no
platform data is used, e.g. in Device Tree configurations. In such cases
a default poll timeout and an automatically calculated poll rate will be
used.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/tty/serial/amba-pl011.c |   39 ++++++++++++++++++---------------------
 1 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e593f8d..baecdfa 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -327,28 +327,25 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 		dmaengine_slave_config(chan, &rx_conf);
 		uap->dmarx.chan = chan;
 
-		if (plat) {
-			/* Set poll rate if specified. */
-			if (plat->dma_rx_poll_rate) {
-				uap->dmarx.auto_poll_rate = false;
-				uap->dmarx.poll_rate = plat->dma_rx_poll_rate;
-			} else {
-				/*
-				 * 100 ms defaults to poll rate if not
-				 * specified. This will be adjusted with
-				 * the baud rate at set_termios.
-				 */
-				uap->dmarx.auto_poll_rate = true;
-				uap->dmarx.poll_rate =  100;
-			}
-			/* 3 secs defaults poll_timeout if not specified. */
-			if (plat->dma_rx_poll_timeout)
-				uap->dmarx.poll_timeout =
-					plat->dma_rx_poll_timeout;
-			else
-				uap->dmarx.poll_timeout = 3000;
-		} else
+		/* Set poll rate if specified. */
+		if (plat && plat->dma_rx_poll_rate) {
 			uap->dmarx.auto_poll_rate = false;
+			uap->dmarx.poll_rate = plat->dma_rx_poll_rate;
+		} else {
+			/*
+			 * 100 ms defaults to poll rate if not
+			 * specified. This will be adjusted with
+			 * the baud rate at set_termios.
+			 */
+			uap->dmarx.auto_poll_rate = true;
+			uap->dmarx.poll_rate =  100;
+		}
+		/* 3 secs defaults poll_timeout if not specified. */
+		if (plat && plat->dma_rx_poll_timeout)
+			uap->dmarx.poll_timeout =
+				plat->dma_rx_poll_timeout;
+		else
+			uap->dmarx.poll_timeout = 3000;
 
 		dev_info(uap->port.dev, "DMA channel RX %s\n",
 			 dma_chan_name(uap->dmarx.chan));
-- 
1.7.2.5

