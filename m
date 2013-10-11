From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 3/4] serial: imx: fix the wrong number of scatterlist entries when xmit->head is 0
Date: Fri, 11 Oct 2013 18:31:00 +0800
Message-ID: <1381487461-12850-4-git-send-email-b32955@freescale.com>
References: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:26989
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755287Ab3JKKp4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Oct 2013 06:45:56 -0400
In-Reply-To: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, Huang Shijie <b32955@freescale.com>

When the (xmit->tail > xmit->head) is true and the xmit->head is 0,
we only need one DMA scatterlist in actually. Current code uses two DMA
scatterlists in this case, this is obviously wrong.

This patch fixes it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c6c3b16..cadf7e5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -532,7 +532,7 @@ static void dma_tx_work(struct work_struct *w)
 		return;
 	}
 
-	if (xmit->tail > xmit->head) {
+	if (xmit->tail > xmit->head && xmit->head > 0) {
 		sport->dma_tx_nents = 2;
 		sg_init_table(sgl, 2);
 		sg_set_buf(sgl, xmit->buf + xmit->tail,
-- 
1.7.2.rc3


