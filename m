From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH v2 2/3] tty: serial: imx: remove dead code imx_dma_rxint
Date: Fri, 20 Oct 2017 14:20:20 -0700
Message-ID: <20171020212021.13065-2-troy.kisky@boundarydevices.com>
References: <20171020212021.13065-1-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171020212021.13065-1-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, nandor.han@ge.com
Cc: Troy Kisky <troy.kisky@boundarydevices.com>, linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Since commit 4dec2f119e86 ("imx-serial: RX DMA startup latency")
the interrupt routine no longer will start rx dma.

imx_dma_rxint no longer needs to be called to try and start dma.
It won't start dma because dma_is_rxing is
already true meaning dma is already started.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v2: split into 2 patches
---
 drivers/tty/serial/imx.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index bf47b15df2e8..15b0ecb4cf60 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -732,29 +732,6 @@ static void imx_disable_rx_int(struct imx_port *sport)
 }
 
 static void clear_rx_errors(struct imx_port *sport);
-static int start_rx_dma(struct imx_port *sport);
-/*
- * If the RXFIFO is filled with some data, and then we
- * arise a DMA operation to receive them.
- */
-static void imx_dma_rxint(struct imx_port *sport)
-{
-	unsigned long temp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sport->port.lock, flags);
-
-	temp = readl(sport->port.membase + USR2);
-	if ((temp & USR2_RDR) && !sport->dma_is_rxing) {
-
-		imx_disable_rx_int(sport);
-
-		/* tell the DMA to receive the data. */
-		start_rx_dma(sport);
-	}
-
-	spin_unlock_irqrestore(&sport->port.lock, flags);
-}
 
 /*
  * We have a modem side uart, so the meanings of RTS and CTS are inverted.
@@ -816,11 +793,8 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	sts = readl(sport->port.membase + USR1);
 	sts2 = readl(sport->port.membase + USR2);
 
-	if (sts & (USR1_RRDY | USR1_AGTIM)) {
-		if (sport->dma_is_enabled)
-			imx_dma_rxint(sport);
-		else
-			imx_rxint(irq, dev_id);
+	if (!sport->dma_is_enabled && (sts & (USR1_RRDY | USR1_AGTIM))) {
+		imx_rxint(irq, dev_id);
 		ret = IRQ_HANDLED;
 	}
 
-- 
2.11.0
