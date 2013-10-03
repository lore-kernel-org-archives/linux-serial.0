From: Hector Palacios <hector.palacios@digi.com>
Subject: [PATCH v3 2/2] serial: mxs-auart: wait for FIFO to flush before shutdown
Date: Thu, 3 Oct 2013 09:32:04 +0200
Message-ID: <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
References: <1380785524-20490-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.111]:19079 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752194Ab3JCHcn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Oct 2013 03:32:43 -0400
In-Reply-To: <1380785524-20490-1-git-send-email-hector.palacios@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: hector.palacios@digi.com, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org, b32955@freescale.com, marex@denx.de, fabio.estevam@freescale.com, shawn.guo@linaro.org, jslaby@suse.cz

The shutdown function was not waiting for the FIFO (which may be the
real 16 byte FIFO or the DMA buffer, if DMA is enabled) to flush
before disabling the AUART.
This lead to many bytes not being transferred (specially at low
baudrates), as they were still in the DMA buffer when the AUART was
shutdown.
This patch also adds the check for the BUSY flag on the tx_empty
callback.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/tty/serial/mxs-auart.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 9f046177..30edb91 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -757,9 +757,26 @@ static int mxs_auart_startup(struct uart_port *u)
 	return 0;
 }
 
+static unsigned int mxs_auart_tx_empty(struct uart_port *u)
+{
+	unsigned long stat;
+
+	stat = readl(u->membase + AUART_STAT);
+	if ((stat & (AUART_STAT_BUSY | AUART_STAT_TXFE)) == AUART_STAT_TXFE)
+		return TIOCSER_TEMT;
+
+	return 0;
+}
+
 static void mxs_auart_shutdown(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
+	unsigned int to;
+
+	/* Wait for the FIFO to flush */
+	to = u->timeout;
+	while (!mxs_auart_tx_empty(u) && to--)
+		mdelay(1);
 
 	if (auart_dma_enabled(s))
 		mxs_auart_dma_exit(s);
@@ -774,14 +791,6 @@ static void mxs_auart_shutdown(struct uart_port *u)
 	clk_disable_unprepare(s->clk);
 }
 
-static unsigned int mxs_auart_tx_empty(struct uart_port *u)
-{
-	if (readl(u->membase + AUART_STAT) & AUART_STAT_TXFE)
-		return TIOCSER_TEMT;
-	else
-		return 0;
-}
-
 static void mxs_auart_start_tx(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
-- 
1.8.4

