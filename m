From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: [PATCH 3/5] serial: pl011: Set length of DMA transfer
Date: Fri, 07 Nov 2014 14:14:43 +0000
Message-ID: <545CD3D3.9000608@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:54369 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752925AbaKGOPR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Nov 2014 09:15:17 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


The DMA engines on some systems require that the dma_length is set
when using scatter gather lists.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d8d067a..7c5e263 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -246,6 +246,7 @@ static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
 	sg_set_page(&sg->sg, phys_to_page(dma_addr),
 		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
 	sg_dma_address(&sg->sg) = dma_addr;
+	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
 
 	return 0;
 }
-- 
1.7.1

