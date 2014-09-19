From: Fugang Duan <b38611@freescale.com>
Subject: [PATCH] serial: imx: terminate the RX DMA when the UART is suspending
Date: Fri, 19 Sep 2014 15:33:12 +0800
Message-ID: <1411111992-25029-1-git-send-email-b38611@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-by2on0139.outbound.protection.outlook.com ([207.46.100.139]:55808
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751125AbaISIPt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 04:15:49 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shijie.huang@intel.com, b38611@freescale.com

From: Huang Shijie <shijie8@gmail.com>

When the uart port is suspending, the RX data is useless.
So in this case, we can terminate the RX DMA right now.

Signed-off-by: Huang Shijie <b32955@freescale.com>
Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 drivers/tty/serial/imx.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 070a37e..a9f63b2 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -435,12 +435,14 @@ static void imx_stop_rx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
-	/*
-	 * We are maybe in the SMP context, so if the DMA TX thread is running
-	 * on other cpu, we have to wait for it to finish.
-	 */
-	if (sport->dma_is_enabled && sport->dma_is_rxing)
-		return;
+	if (sport->dma_is_enabled && sport->dma_is_rxing) {
+		if (sport->port.suspended) {
+			dmaengine_terminate_all(sport->dma_chan_rx);
+			sport->dma_is_rxing = 0;
+		} else {
+			return;
+		}
+	}
 
 	temp = readl(sport->port.membase + UCR2);
 	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
-- 
1.7.8

