From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 2/3] dmaenegine: edma: allow pause/resume for non-cyclic mode
Date: Mon, 27 Apr 2015 13:52:25 +0200
Message-ID: <87vbghaiva.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-serial@vger.kernel.org

The 8250_omap serial driver relies on dmaengine_pause() actually
pausing the DMA transfer. Before this patch dmaengine_pause() is
a NOP for non-cylic DMA transfers. This allowed the 8250_omap
driver to read DMA buffers while the DMA was still active,
resulting in lost serial data.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/dma/edma.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index bf09db7..88853af 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -300,8 +300,7 @@ static int edma_dma_pause(struct dma_chan *chan)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
 
-	/* Pause/Resume only allowed with cyclic mode */
-	if (!echan->edesc || !echan->edesc->cyclic)
+	if (!echan->edesc)
 		return -EINVAL;
 
 	edma_pause(echan->ch_num);
@@ -312,10 +311,6 @@ static int edma_dma_resume(struct dma_chan *chan)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
 
-	/* Pause/Resume only allowed with cyclic mode */
-	if (!echan->edesc->cyclic)
-		return -EINVAL;
-
 	edma_resume(echan->ch_num);
 	return 0;
 }
-- 
1.7.10.4
