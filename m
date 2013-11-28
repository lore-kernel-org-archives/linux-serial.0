From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] serial: pl011: use DMA RX polling by default
Date: Thu, 28 Nov 2013 10:41:04 +0100
Message-ID: <1385631664-32607-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:53589 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab3K1JlS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 04:41:18 -0500
Received: by mail-la0-f43.google.com with SMTP id n7so5827602lam.16
        for <linux-serial@vger.kernel.org>; Thu, 28 Nov 2013 01:41:17 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Jongsung Kim <neidhard.kim@lge.com>, Chanho Min <chanho.min@lge.com>, Russell King <rmk+kernel@arm.linux.org.uk>

Making DMA RX polling optional when DMA is on was just
over-cautious: there is one single system in the kernel tree
using this facility, Ux500 and after some testing I turned
this on also for Ux500, which means it should simply be on
by default if DMA is enabled.

Cc: Jongsung Kim <neidhard.kim@lge.com>
Cc: Chanho Min <chanho.min@lge.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 include/linux/amba/serial.h     | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7203864992a5..501d96453466 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -327,7 +327,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 		dmaengine_slave_config(chan, &rx_conf);
 		uap->dmarx.chan = chan;
 
-		if (plat && plat->dma_rx_poll_enable) {
+		if (plat) {
 			/* Set poll rate if specified. */
 			if (plat->dma_rx_poll_rate) {
 				uap->dmarx.auto_poll_rate = false;
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index 0ddb5c02ad8b..0891ea0458f6 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -203,7 +203,6 @@ struct amba_pl011_data {
 	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
 	void *dma_rx_param;
 	void *dma_tx_param;
-	bool dma_rx_poll_enable;
 	unsigned int dma_rx_poll_rate;
 	unsigned int dma_rx_poll_timeout;
         void (*init) (void);
-- 
1.8.3.1

