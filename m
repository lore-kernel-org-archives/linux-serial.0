From: Shenwei Wang <shenwei.wang@freescale.com>
Subject: [PATCH v4 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
Date: Thu, 30 Jul 2015 09:32:42 -0500
Message-ID: <1438266762-4397-1-git-send-email-shenwei.wang@freescale.com>
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
To: gregkh@linuxfoundation.org, festevam@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When system goes into low power states like SUSPEND_MEM and
HIBERNATION, the hardware IP block may be powered off to reduce
the power consumption. This power down may cause problems on
some imx platforms, because the hardware settings are reset to
its power on default values which may differ from the ones when
it power off. This patch added the dev_pm_ops and implemented
two callbacks: suspend_noirq and resume_noirq, which will save
the necessory hardware parameters right before power down and
recover them before system uses the hardware.

Because added the dev_pm_ops, the old suspend/resume callbacks
under platform_driver will not be called any more. Changed their
prototypes and moved those two callbacks into dev_pm_ops too.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
Change log:

PATCH v4
	Added the return value check for clk_enable.
	Replace the number 0x1 with UCR2_SRST.

PATCH v3
	After added the dev_pm_ops, the old suspend/resume callbacks
	under platform_driver will not be called. Changed their
	prototypes and moved them into dev_pm_ops too.

PATCH v2
	Change pr_debug to dev_dbg per GregK's review feedback.

 drivers/tty/serial/imx.c | 128 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 96 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 2c90dc3..a935c8e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -216,6 +216,7 @@ struct imx_port {
 	unsigned int		tx_bytes;
 	unsigned int		dma_tx_nents;
 	wait_queue_head_t	dma_wait;
+	unsigned int            saved_reg[10];
 };

 struct imx_port_ucrs {
@@ -1811,36 +1812,6 @@ static struct uart_driver imx_reg = {
 	.cons           = IMX_CONSOLE,
 };

-static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
-{
-	struct imx_port *sport = platform_get_drvdata(dev);
-	unsigned int val;
-
-	/* enable wakeup from i.MX UART */
-	val = readl(sport->port.membase + UCR3);
-	val |= UCR3_AWAKEN;
-	writel(val, sport->port.membase + UCR3);
-
-	uart_suspend_port(&imx_reg, &sport->port);
-
-	return 0;
-}
-
-static int serial_imx_resume(struct platform_device *dev)
-{
-	struct imx_port *sport = platform_get_drvdata(dev);
-	unsigned int val;
-
-	/* disable wakeup from i.MX UART */
-	val = readl(sport->port.membase + UCR3);
-	val &= ~UCR3_AWAKEN;
-	writel(val, sport->port.membase + UCR3);
-
-	uart_resume_port(&imx_reg, &sport->port);
-
-	return 0;
-}
-
 #ifdef CONFIG_OF
 /*
  * This function returns 1 iff pdev isn't a device instatiated by dt, 0 iff it
@@ -1992,16 +1963,109 @@ static int serial_imx_remove(struct platform_device *pdev)
 	return uart_remove_one_port(&imx_reg, &sport->port);
 }

+static int imx_serial_port_suspend_noirq(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_port *sport = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = clk_enable(sport->clk_ipg);
+	if (ret)
+		dev_err(dev, "UART%d suspend error!\r\n", sport->port.line);
+
+	/* Save necessary regs */
+	sport->saved_reg[0] = readl(sport->port.membase + UCR1);
+	sport->saved_reg[1] = readl(sport->port.membase + UCR2);
+	sport->saved_reg[2] = readl(sport->port.membase + UCR3);
+	sport->saved_reg[3] = readl(sport->port.membase + UCR4);
+	sport->saved_reg[4] = readl(sport->port.membase + UFCR);
+	sport->saved_reg[5] = readl(sport->port.membase + UESC);
+	sport->saved_reg[6] = readl(sport->port.membase + UTIM);
+	sport->saved_reg[7] = readl(sport->port.membase + UBIR);
+	sport->saved_reg[8] = readl(sport->port.membase + UBMR);
+	sport->saved_reg[9] = readl(sport->port.membase + IMX21_UTS);
+
+	if (ret == 0)
+		clk_disable(sport->clk_ipg);
+
+	return 0;
+}
+
+static int imx_serial_port_resume_noirq(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_port *sport = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = clk_enable(sport->clk_ipg);
+	if (ret)
+		dev_err(dev, "UART%d resume error!\r\n", sport->port.line);
+
+	writel(sport->saved_reg[4], sport->port.membase + UFCR);
+	writel(sport->saved_reg[5], sport->port.membase + UESC);
+	writel(sport->saved_reg[6], sport->port.membase + UTIM);
+	writel(sport->saved_reg[7], sport->port.membase + UBIR);
+	writel(sport->saved_reg[8], sport->port.membase + UBMR);
+	writel(sport->saved_reg[9], sport->port.membase + IMX21_UTS);
+	writel(sport->saved_reg[0], sport->port.membase + UCR1);
+	writel(sport->saved_reg[1] | UCR2_SRST, sport->port.membase + UCR2);
+	writel(sport->saved_reg[2], sport->port.membase + UCR3);
+	writel(sport->saved_reg[3], sport->port.membase + UCR4);
+
+	if (ret == 0)
+		clk_disable(sport->clk_ipg);
+
+	return 0;
+}
+
+static int imx_serial_port_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_port *sport = platform_get_drvdata(pdev);
+	unsigned int val;
+
+	/* enable wakeup from i.MX UART */
+	val = readl(sport->port.membase + UCR3);
+	val |= UCR3_AWAKEN;
+	writel(val, sport->port.membase + UCR3);
+
+	uart_suspend_port(&imx_reg, &sport->port);
+
+	return 0;
+}
+
+static int imx_serial_port_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_port *sport = platform_get_drvdata(pdev);
+	unsigned int val;
+
+	/* disable wakeup from i.MX UART */
+	val = readl(sport->port.membase + UCR3);
+	val &= ~UCR3_AWAKEN;
+	writel(val, sport->port.membase + UCR3);
+
+	uart_resume_port(&imx_reg, &sport->port);
+
+	return 0;
+}
+
+static const struct dev_pm_ops imx_serial_port_pm_ops = {
+	.suspend_noirq = imx_serial_port_suspend_noirq,
+	.resume_noirq = imx_serial_port_resume_noirq,
+	.suspend = imx_serial_port_suspend,
+	.resume = imx_serial_port_resume,
+};
+
 static struct platform_driver serial_imx_driver = {
 	.probe		= serial_imx_probe,
 	.remove		= serial_imx_remove,

-	.suspend	= serial_imx_suspend,
-	.resume		= serial_imx_resume,
 	.id_table	= imx_uart_devtype,
 	.driver		= {
 		.name	= "imx-uart",
 		.of_match_table = imx_uart_dt_ids,
+		.pm	= &imx_serial_port_pm_ops,
 	},
 };

--
2.5.0.rc2
