From: Hector Palacios <hector.palacios@digi.com>
Subject: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before shutdown
Date: Tue, 1 Oct 2013 18:18:35 +0200
Message-ID: <1380644315-31581-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.113]:57917 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750960Ab3JAQU2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Oct 2013 12:20:28 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: u.kleine-koenig@pengutronix.de, b32955@freescale.com, gregkh@linuxfoundation.org, shawn.guo@linaro.org, fabio.estevam@freescale.com, marex@denx.de, hector.palacios@digi.com

The shutdown function was not waiting for the DMA buffer to flush
before disabling the AUART. This lead to many bytes not being
transferred (specially at low baudrates), as they were still in the
DMA buffer when the AUART was shutdown.
This patch also adds the check for the BUSY flag.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>

https://jira.digi.com/browse/DEL-616
---
 drivers/tty/serial/mxs-auart.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index f85b8e6..0d8b2ca 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -750,12 +750,26 @@ static int mxs_auart_startup(struct uart_port *u)
 	return 0;
 }
 
+static unsigned int mxs_auart_tx_empty(struct uart_port *u);
+
 static void mxs_auart_shutdown(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
+	unsigned int to;
+
+	if (auart_dma_enabled(s)) {
+		/* Wait enough time to flush DMA buffer completely */
+		to = u->timeout * UART_XMIT_SIZE / u->fifosize;
+		while (!mxs_auart_tx_empty(u) && to--)
+			mdelay(1);
 
-	if (auart_dma_enabled(s))
 		mxs_auart_dma_exit(s);
+	}
+
+	/* Wait for transmitter to become empty ... */
+	to = u->timeout;
+	while ((readl(port->membase + AUART_STAT) & AUART_STAT_BUSY) && to--)
+		mdelay(1);
 
 	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_CLR);
 
-- 
1.8.4

