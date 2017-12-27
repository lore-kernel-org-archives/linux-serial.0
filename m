From: Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] serial: imx: fix endless loop during suspend
Date: Wed, 27 Dec 2017 18:27:12 +0100
Message-ID: <1514395632-15390-2-git-send-email-martin@kaiser.cx>
References: <1514395632-15390-1-git-send-email-martin@kaiser.cx>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1514395632-15390-1-git-send-email-martin@kaiser.cx>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <kernel@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Before we go into suspend mode, we enable the imx uart's interrupt for
the awake bit in the UART Status Register 1. If, for some reason, the
awake bit is already set before we enter suspend mode, we get an
interrupt immediately when we enable interrupts for awake. The uart's
clk_ipg is already disabled at this point. We end up in the interrupt
handler, which usually tries to clear the awake bit. This doesn't work
with the clock disabled. Therefore, we keep getting interrupts forever,
resulting in an endless loop.

Move the calls to serial_imx_enable_wakeup() into the _noirq functions,
where interrupts are disabled and clk_ipg is active. This way, we can
safely clear the awake bit and enable the imx interrupt for awake.

Now that we do the wakeup configuration in .suspend_noirq, we need
separate functions for .suspend_noirq and .freeze_noirq. However,
.resume_noirq and .restore_noirq can still be shared. We just disable
the wakeup source there, this does not conflict with hibernation.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/imx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 250aa26..5df9172 100644
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
@@ -2245,6 +2247,9 @@ static int imx_serial_port_suspend_noirq(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* enable wakeup from i.MX UART */
+	serial_imx_enable_wakeup(sport, true);
+
 	serial_imx_save_context(sport);
 
 	clk_disable(sport->clk_ipg);
@@ -2264,6 +2269,9 @@ static int imx_serial_port_resume_noirq(struct device *dev)
 
 	serial_imx_restore_context(sport);
 
+	/* disable wakeup from i.MX UART */
+	serial_imx_enable_wakeup(sport, false);
+
 	clk_disable(sport->clk_ipg);
 
 	return 0;
@@ -2291,9 +2299,6 @@ static int imx_serial_port_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
-	/* enable wakeup from i.MX UART */
-	serial_imx_enable_wakeup(sport, true);
-
 	uart_suspend_port(&imx_reg, &sport->port);
 	disable_irq(sport->port.irq);
 
@@ -2306,9 +2311,6 @@ static int imx_serial_port_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
-	/* disable wakeup from i.MX UART */
-	serial_imx_enable_wakeup(sport, false);
-
 	uart_resume_port(&imx_reg, &sport->port);
 	enable_irq(sport->port.irq);
 
-- 
2.1.4
