From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH RESEND v2 2/8] tty: serial: fsl_lpuart: support suspend/resume
Date: Tue, 19 Jul 2016 13:13:04 +0530
Message-ID: <20160719074310.16872-3-bhuvanchandra.dv@toradex.com>
References: <20160719074310.16872-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160719074310.16872-1-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, stefan@agner.ch, kernel@pengutronix.de, jslaby@suse.com, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

Add suspend/resume support.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/tty/serial/fsl_lpuart.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fabfa7e..75a2098 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -483,9 +483,8 @@ static void lpuart_dma_rx_complete(void *arg)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
-static void lpuart_timer_func(unsigned long data)
+static void lpuart_dma_rx_terminate(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = (struct lpuart_port *)data;
 	struct tty_port *port = &sport->port.state->port;
 	struct dma_tx_state state;
 	unsigned long flags;
@@ -510,6 +509,11 @@ static void lpuart_timer_func(unsigned long data)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
+static void lpuart_timer_func(unsigned long data)
+{
+	lpuart_dma_rx_terminate((struct lpuart_port *)data);
+}
+
 static inline void lpuart_prepare_rx(struct lpuart_port *sport)
 {
 	unsigned long flags;
@@ -1925,7 +1929,12 @@ static int lpuart_suspend(struct device *dev)
 		writeb(temp, sport->port.membase + UARTCR2);
 	}
 
+	if (sport->dma_rx_in_progress)
+		lpuart_dma_rx_terminate(sport);
+
 	uart_suspend_port(&lpuart_reg, &sport->port);
+	if (sport->port.suspended && !sport->port.irq_wake)
+		clk_disable_unprepare(sport->clk);
 
 	return 0;
 }
@@ -1935,6 +1944,9 @@ static int lpuart_resume(struct device *dev)
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	unsigned long temp;
 
+	if (sport->port.suspended && !sport->port.irq_wake)
+		clk_prepare_enable(sport->clk);
+
 	if (sport->lpuart32) {
 		lpuart32_setup_watermark(sport);
 		temp = lpuart32_read(sport->port.membase + UARTCTRL);
-- 
2.9.0
