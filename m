From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 4/5] serial: sirf: Introduce helper variable struct device_node *np
Date: Fri, 22 Apr 2016 17:22:23 +0200
Message-ID: <1461338544-29568-5-git-send-email-geert+renesas@glider.be>
References: <1461338544-29568-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461338544-29568-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - No changes.

 drivers/tty/serial/sirfsoc_uart.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index c6657de789977c90..1d1c0b9857ff6900 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1264,6 +1264,7 @@ MODULE_DEVICE_TABLE(of, sirfsoc_uart_ids);
 
 static int sirfsoc_uart_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct sirfsoc_uart_port *sirfport;
 	struct uart_port *port;
 	struct resource *res;
@@ -1276,13 +1277,13 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	};
 	const struct of_device_id *match;
 
-	match = of_match_node(sirfsoc_uart_ids, pdev->dev.of_node);
+	match = of_match_node(sirfsoc_uart_ids, np);
 	sirfport = devm_kzalloc(&pdev->dev, sizeof(*sirfport), GFP_KERNEL);
 	if (!sirfport) {
 		ret = -ENOMEM;
 		goto err;
 	}
-	sirfport->port.line = of_alias_get_id(pdev->dev.of_node, "serial");
+	sirfport->port.line = of_alias_get_id(np, "serial");
 	sirf_ports[sirfport->port.line] = sirfport;
 	sirfport->port.iotype = UPIO_MEM;
 	sirfport->port.flags = UPF_BOOT_AUTOCONF;
@@ -1291,25 +1292,24 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	port->private_data = sirfport;
 	sirfport->uart_reg = (struct sirfsoc_uart_register *)match->data;
 
-	sirfport->hw_flow_ctrl = of_property_read_bool(pdev->dev.of_node,
-		"sirf,uart-has-rtscts");
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart") ||
-		of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-uart"))
+	sirfport->hw_flow_ctrl =
+		of_property_read_bool(np, "sirf,uart-has-rtscts");
+	if (of_device_is_compatible(np, "sirf,prima2-uart") ||
+		of_device_is_compatible(np, "sirf,atlas7-uart"))
 		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
-	if (of_device_is_compatible(pdev->dev.of_node,
-		"sirf,prima2-usp-uart") || of_device_is_compatible(
-		pdev->dev.of_node, "sirf,atlas7-usp-uart")) {
+	if (of_device_is_compatible(np, "sirf,prima2-usp-uart") ||
+	    of_device_is_compatible(np, "sirf,atlas7-usp-uart")) {
 		sirfport->uart_reg->uart_type =	SIRF_USP_UART;
 		if (!sirfport->hw_flow_ctrl)
 			goto usp_no_flow_control;
-		if (of_find_property(pdev->dev.of_node, "cts-gpios", NULL))
-			sirfport->cts_gpio = of_get_named_gpio(
-					pdev->dev.of_node, "cts-gpios", 0);
+		if (of_find_property(np, "cts-gpios", NULL))
+			sirfport->cts_gpio =
+				of_get_named_gpio(np, "cts-gpios", 0);
 		else
 			sirfport->cts_gpio = -1;
-		if (of_find_property(pdev->dev.of_node, "rts-gpios", NULL))
-			sirfport->rts_gpio = of_get_named_gpio(
-					pdev->dev.of_node, "rts-gpios", 0);
+		if (of_find_property(np, "rts-gpios", NULL))
+			sirfport->rts_gpio =
+				of_get_named_gpio(np, "rts-gpios", 0);
 		else
 			sirfport->rts_gpio = -1;
 
@@ -1336,13 +1336,11 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 		gpio_direction_output(sirfport->rts_gpio, 1);
 	}
 usp_no_flow_control:
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-uart") ||
-	    of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-usp-uart"))
+	if (of_device_is_compatible(np, "sirf,atlas7-uart") ||
+	    of_device_is_compatible(np, "sirf,atlas7-usp-uart"))
 		sirfport->is_atlas7 = true;
 
-	if (of_property_read_u32(pdev->dev.of_node,
-			"fifosize",
-			&port->fifosize)) {
+	if (of_property_read_u32(np, "fifosize", &port->fifosize)) {
 		dev_err(&pdev->dev,
 			"Unable to find fifosize in uart node.\n");
 		ret = -EFAULT;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
