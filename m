From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH v2 3/3] tty: serial: imx: remove imx_disable_rx_int
Date: Fri, 20 Oct 2017 14:20:21 -0700
Message-ID: <20171020212021.13065-3-troy.kisky@boundarydevices.com>
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

Since imx_disable_rx_int is only called by imx_startup,
let's integrate it into that function.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
v2: new patch
---
 drivers/tty/serial/imx.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 15b0ecb4cf60..506fcd742b47 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -710,27 +710,6 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void imx_disable_rx_int(struct imx_port *sport)
-{
-	unsigned long temp;
-
-	sport->dma_is_rxing = 1;
-
-	/* disable the receiver ready and aging timer interrupts */
-	temp = readl(sport->port.membase + UCR1);
-	temp &= ~(UCR1_RRDYEN);
-	writel(temp, sport->port.membase + UCR1);
-
-	temp = readl(sport->port.membase + UCR2);
-	temp &= ~(UCR2_ATEN);
-	writel(temp, sport->port.membase + UCR2);
-
-	/* disable the rx errors interrupts */
-	temp = readl(sport->port.membase + UCR4);
-	temp &= ~UCR4_OREN;
-	writel(temp, sport->port.membase + UCR4);
-}
-
 static void clear_rx_errors(struct imx_port *sport);
 
 /*
@@ -1024,6 +1003,7 @@ static int start_rx_dma(struct imx_port *sport)
 	struct dma_async_tx_descriptor *desc;
 	int ret;
 
+	sport->dma_is_rxing = 1;
 	sport->rx_ring.head = 0;
 	sport->rx_ring.tail = 0;
 	sport->rx_periods = RX_DMA_PERIODS;
@@ -1260,18 +1240,21 @@ static int imx_startup(struct uart_port *port)
 	if (sport->dma_is_inited && !sport->dma_is_enabled)
 		imx_enable_dma(sport);
 
-	temp = readl(sport->port.membase + UCR1);
-	temp |= UCR1_RRDYEN | UCR1_UARTEN;
+	temp = readl(sport->port.membase + UCR1) & ~UCR1_RRDYEN;
+	if (!sport->dma_is_enabled)
+		temp |= UCR1_RRDYEN;
+	temp |= UCR1_UARTEN;
 	if (sport->have_rtscts)
 			temp |= UCR1_RTSDEN;
 
 	writel(temp, sport->port.membase + UCR1);
 
-	temp = readl(sport->port.membase + UCR4);
-	temp |= UCR4_OREN;
+	temp = readl(sport->port.membase + UCR4) & ~UCR4_OREN;
+	if (!sport->dma_is_enabled)
+		temp |= UCR4_OREN;
 	writel(temp, sport->port.membase + UCR4);
 
-	temp = readl(sport->port.membase + UCR2);
+	temp = readl(sport->port.membase + UCR2) & ~UCR2_ATEN;
 	temp |= (UCR2_RXEN | UCR2_TXEN);
 	if (!sport->have_rtscts)
 		temp |= UCR2_IRTS;
@@ -1305,10 +1288,8 @@ static int imx_startup(struct uart_port *port)
 	 * In our iMX53 the average delay for the first reception dropped from
 	 * approximately 35000 microseconds to 1000 microseconds.
 	 */
-	if (sport->dma_is_enabled) {
-		imx_disable_rx_int(sport);
+	if (sport->dma_is_enabled)
 		start_rx_dma(sport);
-	}
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-- 
2.11.0
