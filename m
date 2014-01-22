From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH] serial: imx: always wake up the processes in the TX callback
Date: Wed, 22 Jan 2014 16:23:37 +0800
Message-ID: <1390379017-23737-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:6165
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302AbaAVJAp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Jan 2014 04:00:45 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Huang Shijie <b32955@freescale.com>

The current code only wakes up the processes when the circle
buffer has less data then the WAKEUP_CHARS.

But sometimes, the circle buffer may has data more then the WAKEUP_CHARS,
in such case, the processes will hang.

This patch makes it always wakes up the processes in the TX callback.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d799140..dff0f0a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -496,8 +496,7 @@ static void dma_tx_callback(void *data)
 
 	dev_dbg(sport->port.dev, "we finish the TX DMA.\n");
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
+	uart_write_wakeup(&sport->port);
 
 	if (waitqueue_active(&sport->dma_wait)) {
 		wake_up(&sport->dma_wait);
-- 
1.7.2.rc3


