From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 01/27] serial: sh-sci: Drop the interface clock
Date: Mon, 14 Dec 2015 19:57:10 +0100
Message-ID: <1450119456-964-2-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

As no platform defines an interface clock the SCI driver always falls
back to a clock named "peripheral_clk".
  - On SH platforms that clock is the base clock for the SCI functional
    clock and has the same frequency,
  - On ARM platforms that clock doesn't exist, and clk_get() will return
    the default clock for the device.
We can thus make the functional clock mandatory and drop the interface
clock.

EPROBE_DEFER is handled for clocks that may be referenced from DT (i.e.
"fck", and the deprecated "sci_ick").

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Acked-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
[geert: Handle EPROBE_DEFER, reformat description, break long comment line]
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
---
v3:
  - Add Acked-by,

v2:
  - Add Acked-by,
  - Amendment by geert.
---
 .../bindings/serial/renesas,sci-serial.txt         |  4 +-
 drivers/tty/serial/sh-sci.c                        | 64 ++++++++++++++--------
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 73f825e5e6448815..2c9e6b8477e92792 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -42,7 +42,7 @@ Required properties:
 
   - clocks: Must contain a phandle and clock-specifier pair for each entry
     in clock-names.
-  - clock-names: Must contain "sci_ick" for the SCIx UART interface clock.
+  - clock-names: Must contain "fck" for the SCIx UART functional clock.
 
 Note: Each enabled SCIx UART should have an alias correctly numbered in the
 "aliases" node.
@@ -63,7 +63,7 @@ Example:
 		interrupt-parent = <&gic>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
 	};
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 960e50a97558cff5..cc6fa55231ba3536 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -92,8 +92,6 @@ struct sci_port {
 	struct timer_list	break_timer;
 	int			break_flag;
 
-	/* Interface clock */
-	struct clk		*iclk;
 	/* Function clock */
 	struct clk		*fclk;
 
@@ -457,9 +455,8 @@ static void sci_port_enable(struct sci_port *sci_port)
 
 	pm_runtime_get_sync(sci_port->port.dev);
 
-	clk_prepare_enable(sci_port->iclk);
-	sci_port->port.uartclk = clk_get_rate(sci_port->iclk);
 	clk_prepare_enable(sci_port->fclk);
+	sci_port->port.uartclk = clk_get_rate(sci_port->fclk);
 }
 
 static void sci_port_disable(struct sci_port *sci_port)
@@ -476,7 +473,6 @@ static void sci_port_disable(struct sci_port *sci_port)
 	sci_port->break_flag = 0;
 
 	clk_disable_unprepare(sci_port->fclk);
-	clk_disable_unprepare(sci_port->iclk);
 
 	pm_runtime_put_sync(sci_port->port.dev);
 }
@@ -1622,7 +1618,7 @@ static int sci_notifier(struct notifier_block *self,
 		struct uart_port *port = &sci_port->port;
 
 		spin_lock_irqsave(&port->lock, flags);
-		port->uartclk = clk_get_rate(sci_port->iclk);
+		port->uartclk = clk_get_rate(sci_port->fclk);
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
@@ -2241,6 +2237,42 @@ static struct uart_ops sci_uart_ops = {
 #endif
 };
 
+static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
+{
+	/* Get the SCI functional clock. It's called "fck" on ARM. */
+	sci_port->fclk = clk_get(dev, "fck");
+	if (PTR_ERR(sci_port->fclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (!IS_ERR(sci_port->fclk))
+		return 0;
+
+	/*
+	 * But it used to be called "sci_ick", and we need to maintain DT
+	 * backward compatibility.
+	 */
+	sci_port->fclk = clk_get(dev, "sci_ick");
+	if (PTR_ERR(sci_port->fclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (!IS_ERR(sci_port->fclk))
+		return 0;
+
+	/* SH has historically named the clock "sci_fck". */
+	sci_port->fclk = clk_get(dev, "sci_fck");
+	if (!IS_ERR(sci_port->fclk))
+		return 0;
+
+	/*
+	 * Not all SH platforms declare a clock lookup entry for SCI devices,
+	 * in which case we need to get the global "peripheral_clk" clock.
+	 */
+	sci_port->fclk = clk_get(dev, "peripheral_clk");
+	if (!IS_ERR(sci_port->fclk))
+		return 0;
+
+	dev_err(dev, "failed to get functional clock\n");
+	return PTR_ERR(sci_port->fclk);
+}
+
 static int sci_init_single(struct platform_device *dev,
 			   struct sci_port *sci_port, unsigned int index,
 			   struct plat_sci_port *p, bool early)
@@ -2333,22 +2365,9 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->sampling_rate = p->sampling_rate;
 
 	if (!early) {
-		sci_port->iclk = clk_get(&dev->dev, "sci_ick");
-		if (IS_ERR(sci_port->iclk)) {
-			sci_port->iclk = clk_get(&dev->dev, "peripheral_clk");
-			if (IS_ERR(sci_port->iclk)) {
-				dev_err(&dev->dev, "can't get iclk\n");
-				return PTR_ERR(sci_port->iclk);
-			}
-		}
-
-		/*
-		 * The function clock is optional, ignore it if we can't
-		 * find it.
-		 */
-		sci_port->fclk = clk_get(&dev->dev, "sci_fck");
-		if (IS_ERR(sci_port->fclk))
-			sci_port->fclk = NULL;
+		ret = sci_init_clocks(sci_port, &dev->dev);
+		if (ret < 0)
+			return ret;
 
 		port->dev = &dev->dev;
 
@@ -2405,7 +2424,6 @@ static int sci_init_single(struct platform_device *dev,
 
 static void sci_cleanup_single(struct sci_port *port)
 {
-	clk_put(port->iclk);
 	clk_put(port->fclk);
 
 	pm_runtime_disable(port->port.dev);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
