From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 10/27] serial: sh-sci: Convert from clk_get() to devm_clk_get()
Date: Mon, 14 Dec 2015 19:57:19 +0100
Message-ID: <1450119456-964-11-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Transfer clock cleanup handling to the core device management code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Acked-by,
  - Convert "sci_fck", as its removal has been moved after the BRG
    patches.
---
 drivers/tty/serial/sh-sci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 136ad2f633413cbc..b9eb4b525c0a7571 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2216,7 +2216,7 @@ static struct uart_ops sci_uart_ops = {
 static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 {
 	/* Get the SCI functional clock. It's called "fck" on ARM. */
-	sci_port->fclk = clk_get(dev, "fck");
+	sci_port->fclk = devm_clk_get(dev, "fck");
 	if (PTR_ERR(sci_port->fclk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 	if (!IS_ERR(sci_port->fclk))
@@ -2226,14 +2226,14 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	 * But it used to be called "sci_ick", and we need to maintain DT
 	 * backward compatibility.
 	 */
-	sci_port->fclk = clk_get(dev, "sci_ick");
+	sci_port->fclk = devm_clk_get(dev, "sci_ick");
 	if (PTR_ERR(sci_port->fclk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 	if (!IS_ERR(sci_port->fclk))
 		return 0;
 
 	/* SH has historically named the clock "sci_fck". */
-	sci_port->fclk = clk_get(dev, "sci_fck");
+	sci_port->fclk = devm_clk_get(dev, "sci_fck");
 	if (!IS_ERR(sci_port->fclk))
 		return 0;
 
@@ -2241,7 +2241,7 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	 * Not all SH platforms declare a clock lookup entry for SCI devices,
 	 * in which case we need to get the global "peripheral_clk" clock.
 	 */
-	sci_port->fclk = clk_get(dev, "peripheral_clk");
+	sci_port->fclk = devm_clk_get(dev, "peripheral_clk");
 	if (!IS_ERR(sci_port->fclk))
 		return 0;
 
@@ -2400,8 +2400,6 @@ static int sci_init_single(struct platform_device *dev,
 
 static void sci_cleanup_single(struct sci_port *port)
 {
-	clk_put(port->fclk);
-
 	pm_runtime_disable(port->port.dev);
 }
 
-- 
1.9.1

