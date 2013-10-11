From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 2/4] serial: imx: check the DMA for imx_tx_empty
Date: Fri, 11 Oct 2013 18:30:59 +0800
Message-ID: <1381487461-12850-3-git-send-email-b32955@freescale.com>
References: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:6075 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932471Ab3JKKpy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Oct 2013 06:45:54 -0400
In-Reply-To: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, Huang Shijie <b32955@freescale.com>

Assume the following situation:

  If the DMA is enabled, and the a TX DMA operation is working,
But we have not issued the TX DMA operation (or we have issued the
TX DMA operation with dma_async_issue_pending(), but the DMA has not
started to move the data from the memory to the TXFIFO).

At this time, we may get the wrong status of the transmitter when we
call the imx_tx_empty. In such situation, only check the USR2_TXDC
does not enough for us.

This patch checks the DMA's situation, and return 0 when the TX DMA is
working.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 708ba89..c6c3b16 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -795,8 +795,15 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 static unsigned int imx_tx_empty(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
+	unsigned int ret;
 
-	return (readl(sport->port.membase + USR2) & USR2_TXDC) ?  TIOCSER_TEMT : 0;
+	ret = (readl(sport->port.membase + USR2) & USR2_TXDC) ?  TIOCSER_TEMT : 0;
+
+	/* If the TX DMA is working, return 0. */
+	if (sport->dma_is_enabled && sport->dma_is_txing)
+		ret = 0;
+
+	return ret;
 }
 
 /*
-- 
1.7.2.rc3


