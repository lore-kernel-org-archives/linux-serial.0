From: Hector Palacios <hector.palacios@digi.com>
Subject: [PATCH 3/3] serial: mxs-auart: move irq handling to a tasklet
Date: Fri, 29 Nov 2013 17:35:27 +0100
Message-ID: <1385742927-11358-4-git-send-email-hector.palacios@digi.com>
References: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: fabio.estevam@freescale.com, marex@denx.de, gregkh@linuxfoundation.org, b32955@freescale.com, hector.palacios@digi.com, u.kleine-koenig@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The ISR was handling CTS flag and RX/TX processing.
Occasionally interrupts were coming in the middle of the ISR and
led to blocking transmission (with hw flow) or loss of data.
This patch moves this processing to a tasklet that the ISR schedules.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/tty/serial/mxs-auart.c | 61 +++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index e5540c89dd48..7021269c70b2 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -148,6 +148,10 @@ struct mxs_auart_port {
 	struct clk *clk;
 	struct device *dev;
 
+	struct tasklet_struct tasklet;
+	unsigned int irq_status;
+	unsigned int status;
+
 	/* for DMA */
 	struct scatterlist tx_sgl;
 	struct dma_chan	*tx_dma_chan;
@@ -680,38 +684,48 @@ static void mxs_auart_settermios(struct uart_port *u,
 	}
 }
 
+/*
+ * tasklet handling tty stuff outside the interrupt handler.
+ */
+static void mxs_auart_tasklet_func(unsigned long data)
+{
+	struct uart_port *port = (struct uart_port *)data;
+	struct mxs_auart_port *s = to_auart_port(port);
+
+	/* Handle status irq */
+	if (s->irq_status & AUART_INTR_CTSMIS) {
+		uart_handle_cts_change(&s->port, s->status & AUART_STAT_CTS);
+		writel(AUART_INTR_CTSMIS,
+		       s->port.membase + AUART_INTR_CLR);
+	}
+	/* Handle receive irq */
+	if (s->irq_status & (AUART_INTR_RTIS | AUART_INTR_RXIS)) {
+		if (!auart_dma_enabled(s))
+			mxs_auart_rx_chars(s);
+	}
+	/* Handle transmit irq */
+	if (s->irq_status & AUART_INTR_TXIS)
+		mxs_auart_tx_chars(s);
+}
+
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
-	u32 istat;
 	struct mxs_auart_port *s = context;
-	u32 stat = readl(s->port.membase + AUART_STAT);
 
-	istat = readl(s->port.membase + AUART_INTR);
+	s->status = readl(s->port.membase + AUART_STAT);
+	s->irq_status = readl(s->port.membase + AUART_INTR);
 
-	/* ack irq */
-	writel(istat & (AUART_INTR_RTIS
+	/* ack irqs */
+	writel(s->irq_status & (AUART_INTR_RTIS
 		| AUART_INTR_TXIS
 		| AUART_INTR_RXIS
 		| AUART_INTR_CTSMIS),
 			s->port.membase + AUART_INTR_CLR);
 
-	if (istat & AUART_INTR_CTSMIS) {
-		uart_handle_cts_change(&s->port, stat & AUART_STAT_CTS);
-		writel(AUART_INTR_CTSMIS,
-				s->port.membase + AUART_INTR_CLR);
-		istat &= ~AUART_INTR_CTSMIS;
-	}
-
-	if (istat & (AUART_INTR_RTIS | AUART_INTR_RXIS)) {
-		if (!auart_dma_enabled(s))
-			mxs_auart_rx_chars(s);
-		istat &= ~(AUART_INTR_RTIS | AUART_INTR_RXIS);
-	}
-
-	if (istat & AUART_INTR_TXIS) {
-		mxs_auart_tx_chars(s);
-		istat &= ~AUART_INTR_TXIS;
-	}
+	/* Handle interrupt with tasklet */
+	if (s->irq_status & (AUART_INTR_RTIS | AUART_INTR_RXIS |
+			     AUART_INTR_CTSMIS | AUART_INTR_TXIS))
+		tasklet_schedule(&s->tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -1112,6 +1126,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	auart_port[s->port.line] = s;
 
+	tasklet_init(&s->tasklet, mxs_auart_tasklet_func, (unsigned long)s);
+
 	mxs_auart_reset(&s->port);
 
 	ret = uart_add_one_port(&auart_driver, &s->port);
@@ -1141,6 +1157,7 @@ static int mxs_auart_remove(struct platform_device *pdev)
 	struct mxs_auart_port *s = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&auart_driver, &s->port);
+	tasklet_kill(&s->tasklet);
 
 	auart_port[pdev->id] = NULL;
