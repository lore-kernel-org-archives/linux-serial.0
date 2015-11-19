From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 07/25] serial: sh-sci: Convert from clk_get() to devm_clk_get()
Date: Thu, 19 Nov 2015 19:38:46 +0100
Message-ID: <1447958344-836-8-git-send-email-geert+renesas@glider.be>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Transfer clock cleanup handling to the core device management code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index cba51da604253db6..9442961a198378c7 100644
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
@@ -2226,7 +2226,7 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	 * But it used to be called "sci_ick", and we need to maintain DT
 	 * backward compatibility.
 	 */
-	sci_port->fclk = clk_get(dev, "sci_ick");
+	sci_port->fclk = devm_clk_get(dev, "sci_ick");
 	if (PTR_ERR(sci_port->fclk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 	if (!IS_ERR(sci_port->fclk))
@@ -2236,7 +2236,7 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	 * Not all SH platforms declare a clock lookup entry for SCI devices,
 	 * in which case we need to get the global "peripheral_clk" clock.
 	 */
-	sci_port->fclk = clk_get(dev, "peripheral_clk");
+	sci_port->fclk = devm_clk_get(dev, "peripheral_clk");
 	if (!IS_ERR(sci_port->fclk))
 		return 0;
 
@@ -2395,8 +2395,6 @@ static int sci_init_single(struct platform_device *dev,
 
 static void sci_cleanup_single(struct sci_port *port)
 {
-	clk_put(port->fclk);
-
 	pm_runtime_disable(port->port.dev);
 }
 
-- 
1.9.1
