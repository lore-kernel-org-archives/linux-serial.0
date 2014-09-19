From: Fugang Duan <b38611@freescale.com>
Subject: [PATCH] serial: imx: change the wait even to interruptiable
Date: Fri, 19 Sep 2014 15:42:57 +0800
Message-ID: <1411112577-26020-1-git-send-email-b38611@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-by2on0101.outbound.protection.outlook.com ([207.46.100.101]:35484
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750707AbaISIJo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 04:09:44 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shijie.huang@intel.com, b38611@freescale.com

From: Huang Shijie <shijie8@gmail.com>

The wait_event() makes the application hang for ever in the following case:
 [1] the hardware flow control is enabled.
 [2] the other end (or the remote end) is terminated, and the TX is still
     waiting for the hardware flow control signal to become asserted.

This patch fixes it by changing the wait_event to wait_event_interruptible.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 drivers/tty/serial/imx.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a9f63b2..925be44 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1225,9 +1225,18 @@ static void imx_shutdown(struct uart_port *port)
 	unsigned long flags;
 
 	if (sport->dma_is_enabled) {
+		int ret;
+
 		/* We have to wait for the DMA to finish. */
-		wait_event(sport->dma_wait,
+		ret = wait_event_interruptible(sport->dma_wait,
 			!sport->dma_is_rxing && !sport->dma_is_txing);
+		if (ret != 0) {
+			sport->dma_is_rxing = 0;
+			sport->dma_is_txing = 0;
+			dmaengine_terminate_all(sport->dma_chan_tx);
+			dmaengine_terminate_all(sport->dma_chan_rx);
+		}
+		imx_stop_tx(port);
 		imx_stop_rx(port);
 		imx_disable_dma(sport);
 		imx_uart_dma_exit(sport);
-- 
1.7.8

