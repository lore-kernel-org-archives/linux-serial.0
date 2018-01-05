From: Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2] serial: imx: fix endless loop during suspend
Date: Fri,  5 Jan 2018 17:46:43 +0100
Message-ID: <1515170803-31662-1-git-send-email-martin@kaiser.cx>
References: <1514395632-15390-1-git-send-email-martin@kaiser.cx>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514395632-15390-1-git-send-email-martin@kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
List-Id: linux-serial@vger.kernel.org

Before we go into suspend mode, we enable the imx uart's interrupt for
the awake bit in the UART Status Register 1. If, for some reason, the
awake bit is already set before we enter suspend mode, we get an
interrupt immediately when we enable interrupts for awake. The uart's
clk_ipg is disabled at this point (unless there's an ongoing transfer).
We end up in the interrupt handler, which usually tries to clear the
awake bit. This doesn't work with the clock disabled. Therefore, we
keep getting interrupts forever, resulting in an endless loop.

Clear the awake bit before setting the awaken bit to signal that we want
an imx interrupt when the awake bit will be set. This ensures that we're
not woken up by events that happened before we started going into
suspend mode.

Change the clock handling so that suspend prepares and enables the clock
and suspend_noirq disables it. Revert these operations in resume_noirq and
resume.

With these preparations in place, we can now modify awake and awaken in
the suspend function when the actual imx interrupt is disabled and the
required clk_ipg is active.

Update the thaw and freeze functions to use the new clock handling since
we share the suspend_noirq function between suspend and hibernate.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
changes in v2
 call serial_imx_enable_wakeup() in suspend, not in suspend_noirq
 keep the clock enalbed between suspend and suspend_noirq and
  between resume_noirq and resume

Hi Fabio and all,

here's a different approach for fixing the awake issue that I see on my
board. I tried to stick as much as possible to the original order in
which the operations were done. Could you do a quick check on imx6q?

Thanks,
   Martin

 drivers/tty/serial/imx.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 145ed61..e5d5250 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2221,8 +2221,10 @@ static void serial_imx_enable_wakeup(struct imx_port *sport, bool on)
 	unsigned int val;
 
 	val = readl(sport->port.membase + UCR3);
-	if (on)
+	if (on) {
+		writel(USR1_AWAKE, sport->port.membase + USR1);
 		val |= UCR3_AWAKEN;
+	}
 	else
 		val &= ~UCR3_AWAKEN;
 	writel(val, sport->port.membase + UCR3);
@@ -2239,11 +2241,6 @@ static int imx_serial_port_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_port *sport = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = clk_enable(sport->clk_ipg);
-	if (ret)
-		return ret;
 
 	serial_imx_save_context(sport);
 
@@ -2264,8 +2261,6 @@ static int imx_serial_port_resume_noirq(struct device *dev)
 
 	serial_imx_restore_context(sport);
 
-	clk_disable(sport->clk_ipg);
-
 	return 0;
 }
 
@@ -2273,15 +2268,19 @@ static int imx_serial_port_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_port *sport = platform_get_drvdata(pdev);
-
-	/* enable wakeup from i.MX UART */
-	serial_imx_enable_wakeup(sport, true);
+	int ret;
 
 	uart_suspend_port(&imx_reg, &sport->port);
 	disable_irq(sport->port.irq);
 
-	/* Needed to enable clock in suspend_noirq */
-	return clk_prepare(sport->clk_ipg);
+	ret = clk_prepare_enable(sport->clk_ipg);
+	if (ret)
+		return ret;
+
+	/* enable wakeup from i.MX UART */
+	serial_imx_enable_wakeup(sport, true);
+
+	return 0;
 }
 
 static int imx_serial_port_resume(struct device *dev)
@@ -2295,7 +2294,7 @@ static int imx_serial_port_resume(struct device *dev)
 	uart_resume_port(&imx_reg, &sport->port);
 	enable_irq(sport->port.irq);
 
-	clk_unprepare(sport->clk_ipg);
+	clk_disable_unprepare(sport->clk_ipg);
 
 	return 0;
 }
@@ -2307,8 +2306,7 @@ static int imx_serial_port_freeze(struct device *dev)
 
 	uart_suspend_port(&imx_reg, &sport->port);
 
-	/* Needed to enable clock in suspend_noirq */
-	return clk_prepare(sport->clk_ipg);
+	return clk_prepare_enable(sport->clk_ipg);
 }
 
 static int imx_serial_port_thaw(struct device *dev)
@@ -2318,7 +2316,7 @@ static int imx_serial_port_thaw(struct device *dev)
 
 	uart_resume_port(&imx_reg, &sport->port);
 
-	clk_unprepare(sport->clk_ipg);
+	clk_disable_unprepare(sport->clk_ipg);
 
 	return 0;
 }
-- 
2.1.4
