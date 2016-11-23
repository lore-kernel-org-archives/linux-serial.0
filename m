From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/4] serial: imx: Add LED trigger support
Date: Wed, 23 Nov 2016 11:01:06 +0100
Message-ID: <20161123100106.15969-5-s.hauer@pengutronix.de>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161123100106.15969-1-s.hauer@pengutronix.de>
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
Cc: kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a70356d..5eaf576 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -444,6 +444,8 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
 		return;
 	}
 
+	uart_led_trigger_tx(&sport->port);
+
 	if (sport->dma_is_enabled) {
 		/*
 		 * We've just sent a X-char Ensure the TX DMA is enabled
@@ -569,6 +571,7 @@ static void imx_dma_tx(struct imx_port *sport)
 	/* fire it */
 	sport->dma_is_txing = 1;
 	dmaengine_submit(desc);
+	uart_led_trigger_tx(&sport->port);
 	dma_async_issue_pending(chan);
 	return;
 }
@@ -655,6 +658,8 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags, temp;
 
+	uart_led_trigger_rx(&sport->port);
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	while (readl(sport->port.membase + USR2) & USR2_RDR) {
@@ -729,6 +734,8 @@ static void imx_dma_rxint(struct imx_port *sport)
 	unsigned long temp;
 	unsigned long flags;
 
+	uart_led_trigger_rx(&sport->port);
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	temp = readl(sport->port.membase + USR2);
@@ -2184,14 +2191,27 @@ static int serial_imx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sport);
 
-	return uart_add_one_port(&imx_reg, &sport->port);
+	ret = uart_add_one_port(&imx_reg, &sport->port);
+	if (ret)
+		return ret;
+
+	uart_add_led_triggers(&imx_reg, &sport->port);
+
+	return 0;
 }
 
 static int serial_imx_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	int ret;
 
-	return uart_remove_one_port(&imx_reg, &sport->port);
+	ret = uart_remove_one_port(&imx_reg, &sport->port);
+	if (ret)
+		return ret;
+
+	uart_remove_led_triggers(&sport->port);
+
+	return 0;
 }
 
 static void serial_imx_restore_context(struct imx_port *sport)
-- 
2.10.2
