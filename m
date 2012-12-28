From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: [serial driver PATCH] Fix typo in sanity check
Date: Sat, 29 Dec 2012 00:16:33 +0100
Message-ID: <50DE2851.40307@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from re04.intra2net.com ([82.165.46.26]:41088 "EHLO
	re04.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab2L2ARx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Dec 2012 19:17:53 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org

Detected by cppcheck:
[others/linux/drivers/tty/serial/mxs-auart.c:553]: (style) Same expression on both sides of '||'.

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
---
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6db23b0..fa31bc3 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -550,7 +550,7 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 		return 0;
 
 	/* We do not get the right DMA channels. */
-	if (s->dma_channel_rx == -1 || s->dma_channel_rx == -1)
+	if (s->dma_channel_rx == -1 || s->dma_channel_tx == -1)
 		return -EINVAL;
 
 	/* init for RX */
-- 
1.7.11.7

