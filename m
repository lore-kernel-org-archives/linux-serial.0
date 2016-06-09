From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH 2/8] tty: serial: fsl_lpuart: support suspend/resume
Date: Thu, 9 Jun 2016 20:40:33 +0530
Message-ID: <20160609151039.20817-3-bhuvanchandra.dv@toradex.com>
References: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
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
Cc: linux-serial@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, stefan@agner.ch, kernel@pengutronix.de, jslaby@suse.com, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

In order to allow wake support in STOP sleep mode, clocks are
needed. Use imx_clk_gate2_cgr to disable automatic clock gating
in low power mode STOP. This allows to enable wake by UART using:
echo enabled > /sys/class/tty/ttyLP0/power/wakeup

However, if wake is not enabled, the driver should disable the
clocks explicitly to save power.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-vf610.c     | 12 ++++++------
 drivers/tty/serial/fsl_lpuart.c | 16 ++++++++++++++--
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 3a1f244..0476353 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -315,12 +315,12 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 
 	clk[VF610_CLK_PIT] = imx_clk_gate2("pit", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(7));
 
-	clk[VF610_CLK_UART0] = imx_clk_gate2("uart0", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(7));
-	clk[VF610_CLK_UART1] = imx_clk_gate2("uart1", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(8));
-	clk[VF610_CLK_UART2] = imx_clk_gate2("uart2", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(9));
-	clk[VF610_CLK_UART3] = imx_clk_gate2("uart3", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(10));
-	clk[VF610_CLK_UART4] = imx_clk_gate2("uart4", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(9));
-	clk[VF610_CLK_UART5] = imx_clk_gate2("uart5", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(10));
+	clk[VF610_CLK_UART0] = imx_clk_gate2_cgr("uart0", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(7), 0x2);
+	clk[VF610_CLK_UART1] = imx_clk_gate2_cgr("uart1", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(8), 0x2);
+	clk[VF610_CLK_UART2] = imx_clk_gate2_cgr("uart2", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(9), 0x2);
+	clk[VF610_CLK_UART3] = imx_clk_gate2_cgr("uart3", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(10), 0x2);
+	clk[VF610_CLK_UART4] = imx_clk_gate2_cgr("uart4", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(9), 0x2);
+	clk[VF610_CLK_UART5] = imx_clk_gate2_cgr("uart5", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(10), 0x2);
 
 	clk[VF610_CLK_I2C0] = imx_clk_gate2("i2c0", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(6));
 	clk[VF610_CLK_I2C1] = imx_clk_gate2("i2c1", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(7));
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
2.8.3
