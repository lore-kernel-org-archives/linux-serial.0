From: Aaron Brice <aaron.brice@datasoft.com>
Subject: [PATCH] tty: serial: fsl_lpuart: Fix Tx DMA edge case
Date: Thu,  6 Oct 2016 15:13:04 -0700
Message-ID: <1475791984-17705-1-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, bhuvanchandra.dv@toradex.com, stefan@agner.ch
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In the case where head == 0 on the circular buffer, there should be one
DMA buffer, not two.  The second zero-length buffer would break the
lpuart driver, transfer would never complete.

Signed-off-by: Aaron Brice <aaron.brice@datasoft.com>
---
 drivers/tty/serial/fsl_lpuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index de9d510..76103f2 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -328,7 +328,7 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 
 	sport->dma_tx_bytes = uart_circ_chars_pending(xmit);
 
-	if (xmit->tail < xmit->head) {
+	if (xmit->tail < xmit->head || xmit->head == 0) {
 		sport->dma_tx_nents = 1;
 		sg_init_one(sgl, xmit->buf + xmit->tail, sport->dma_tx_bytes);
 	} else {
@@ -359,7 +359,6 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 	sport->dma_tx_in_progress = true;
 	sport->dma_tx_cookie = dmaengine_submit(sport->dma_tx_desc);
 	dma_async_issue_pending(sport->dma_tx_chan);
-
 }
 
 static void lpuart_dma_tx_complete(void *arg)
-- 
2.7.4
