From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 60/76] pch_uart: fix exclusive access issue
Date: Wed, 16 Mar 2011 14:12:30 -0700
Message-ID: <1300309966-5745-60-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32781 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754961Ab1CPVPD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:03 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/pch_uart.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 0c95051..da0ba0f 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -636,8 +636,7 @@ static void pch_dma_tx_complete(void *arg)
 	priv->tx_dma_use = 0;
 	priv->nent = 0;
 	kfree(priv->sg_tx_p);
-	if (uart_circ_chars_pending(xmit))
-		pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_TX_INT);
+	pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_TX_INT);
 }
 
 static int pop_tx(struct eg20t_port *priv, int size)
@@ -793,6 +792,14 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 		return 0;
 	}
 
+	if (priv->tx_dma_use) {
+		dev_dbg(priv->port.dev, "%s:Tx is not completed. (%lu)\n",
+			__func__, jiffies);
+		pch_uart_hal_disable_interrupt(priv, PCH_UART_HAL_TX_INT);
+		priv->tx_empty = 1;
+		return 0;
+	}
+
 	fifo_size = max(priv->fifo_size, 1);
 	tx_empty = 1;
 	if (pop_tx_x(priv, xmit->buf)) {
-- 
1.7.4.1

