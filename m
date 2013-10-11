From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 4/4] serial: imx: use the dmaengine_tx_status
Date: Fri, 11 Oct 2013 18:31:01 +0800
Message-ID: <1381487461-12850-5-git-send-email-b32955@freescale.com>
References: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:43510 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932471Ab3JKKp6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Oct 2013 06:45:58 -0400
In-Reply-To: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, Huang Shijie <b32955@freescale.com>

Use the dmaengine_tx_status to simplify the code, do not change any logic.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index cadf7e5..13c2c2d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -521,7 +521,7 @@ static void dma_tx_work(struct work_struct *w)
 	unsigned long flags;
 	int ret;
 
-	status = chan->device->device_tx_status(chan, (dma_cookie_t)0, NULL);
+	status = dmaengine_tx_status(chan, (dma_cookie_t)0, NULL);
 	if (DMA_IN_PROGRESS == status)
 		return;
 
@@ -926,7 +926,7 @@ static void dma_rx_callback(void *data)
 	/* unmap it first */
 	dma_unmap_sg(sport->port.dev, sgl, 1, DMA_FROM_DEVICE);
 
-	status = chan->device->device_tx_status(chan, (dma_cookie_t)0, &state);
+	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
 	count = RX_BUF_SIZE - state.residue;
 	dev_dbg(sport->port.dev, "We get %d bytes.\n", count);
 
-- 
1.7.2.rc3


