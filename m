From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 4/8] serial: imx: save and restore context in the suspend path
Date: Tue, 11 Aug 2015 10:21:23 -0700
Message-ID: <1439313687-28502-5-git-send-email-edubezval@gmail.com>
References: <1439313687-28502-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439313687-28502-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

This change teaches the imx serial driver to save its
context and restore it across suspend and resume path.
To do so, it introduces serial_imx_restore_context()
and serial_imx_save_context() functions. They use
a shadow set of registers to save key registers
and restore them accordingly. These functions can
be reused on other situations, when the device
context is lost.

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 58 ++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 167dea1..fe3d41c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -217,6 +217,7 @@ struct imx_port {
 	unsigned int		dma_tx_nents;
 	wait_queue_head_t	dma_wait;
 	unsigned int            saved_reg[10];
+	bool			context_saved;
 };
 
 struct imx_port_ucrs {
@@ -1972,6 +1973,40 @@ static int serial_imx_remove(struct platform_device *pdev)
 	return uart_remove_one_port(&imx_reg, &sport->port);
 }
 
+static void serial_imx_restore_context(struct imx_port *sport)
+{
+	if (!sport->context_saved)
+		return;
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
+	sport->context_saved = false;
+}
+
+static void serial_imx_save_context(struct imx_port *sport)
+{
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
+	sport->context_saved = true;
+}
+
 static void serial_imx_enable_wakeup(struct imx_port *sport, bool on)
 {
 	unsigned int val;
@@ -2001,17 +2036,7 @@ static int imx_serial_port_suspend_noirq(struct device *dev)
 	if (ret)
 		return ret;
 
-	/* Save necessary regs */
-	sport->saved_reg[0] = readl(sport->port.membase + UCR1);
-	sport->saved_reg[1] = readl(sport->port.membase + UCR2);
-	sport->saved_reg[2] = readl(sport->port.membase + UCR3);
-	sport->saved_reg[3] = readl(sport->port.membase + UCR4);
-	sport->saved_reg[4] = readl(sport->port.membase + UFCR);
-	sport->saved_reg[5] = readl(sport->port.membase + UESC);
-	sport->saved_reg[6] = readl(sport->port.membase + UTIM);
-	sport->saved_reg[7] = readl(sport->port.membase + UBIR);
-	sport->saved_reg[8] = readl(sport->port.membase + UBMR);
-	sport->saved_reg[9] = readl(sport->port.membase + IMX21_UTS);
+	serial_imx_save_context(sport);
 
 	clk_disable(sport->clk_ipg);
 
@@ -2028,16 +2053,7 @@ static int imx_serial_port_resume_noirq(struct device *dev)
 	if (ret)
 		return ret;
 
-	writel(sport->saved_reg[4], sport->port.membase + UFCR);
-	writel(sport->saved_reg[5], sport->port.membase + UESC);
-	writel(sport->saved_reg[6], sport->port.membase + UTIM);
-	writel(sport->saved_reg[7], sport->port.membase + UBIR);
-	writel(sport->saved_reg[8], sport->port.membase + UBMR);
-	writel(sport->saved_reg[9], sport->port.membase + IMX21_UTS);
-	writel(sport->saved_reg[0], sport->port.membase + UCR1);
-	writel(sport->saved_reg[1] | UCR2_SRST, sport->port.membase + UCR2);
-	writel(sport->saved_reg[2], sport->port.membase + UCR3);
-	writel(sport->saved_reg[3], sport->port.membase + UCR4);
+	serial_imx_restore_context(sport);
 
 	clk_disable(sport->clk_ipg);
 
-- 
2.5.0
