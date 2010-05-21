From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] sh: fix Oops in the serial SCI driver
Date: Fri, 21 May 2010 17:22:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005211721030.8450@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46938 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933438Ab0EUPWY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 May 2010 11:22:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org

Fix an Oops, triggering, if the DMA buffer allocation for the Rx channel in
sh-sci.c fails.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/serial/sh-sci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 304a877..7b273c9 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -1007,8 +1007,9 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 	s->chan_rx = NULL;
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
 	dma_release_channel(chan);
-	dma_free_coherent(port->dev, s->buf_len_rx * 2,
-			  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
+	if (sg_dma_address(&s->sg_rx[0]))
+		dma_free_coherent(port->dev, s->buf_len_rx * 2,
+				  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
 	if (enable_pio)
 		sci_start_rx(port);
 }
-- 
1.6.2.4

