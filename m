From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 13/18] serial: sh-sci: Constify platform data
Date: Wed, 11 Jan 2017 16:43:35 +0200
Message-ID: <20170111144340.29074-14-laurent.pinchart+renesas@ideasonboard.com>
References: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The driver modifies platform data for internal purpose only. Fix that
and make the platform data structure const.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 97 +++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ca68a7d562ea..4a54fd5909ed 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -114,7 +114,7 @@ struct sci_port {
 
 	/* Platform configuration */
 	const struct sci_port_params *params;
-	struct plat_sci_port	*cfg;
+	const struct plat_sci_port *cfg;
 	unsigned int		overrun_reg;
 	unsigned int		overrun_mask;
 	unsigned int		error_mask;
@@ -420,41 +420,6 @@ static void sci_serial_out(struct uart_port *p, int offset, int value)
 		WARN(1, "Invalid register access\n");
 }
 
-static int sci_probe_regmap(struct plat_sci_port *cfg)
-{
-	switch (cfg->type) {
-	case PORT_SCI:
-		cfg->regtype = SCIx_SCI_REGTYPE;
-		break;
-	case PORT_IRDA:
-		cfg->regtype = SCIx_IRDA_REGTYPE;
-		break;
-	case PORT_SCIFA:
-		cfg->regtype = SCIx_SCIFA_REGTYPE;
-		break;
-	case PORT_SCIFB:
-		cfg->regtype = SCIx_SCIFB_REGTYPE;
-		break;
-	case PORT_SCIF:
-		/*
-		 * The SH-4 is a bit of a misnomer here, although that's
-		 * where this particular port layout originated. This
-		 * configuration (or some slight variation thereof)
-		 * remains the dominant model for all SCIFs.
-		 */
-		cfg->regtype = SCIx_SH4_SCIF_REGTYPE;
-		break;
-	case PORT_HSCIF:
-		cfg->regtype = SCIx_HSCIF_REGTYPE;
-		break;
-	default:
-		pr_err("Can't probe register map for given port\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void sci_port_enable(struct sci_port *sci_port)
 {
 	unsigned int i;
@@ -2539,9 +2504,50 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	return 0;
 }
 
+static const struct sci_port_params *
+sci_probe_regmap(const struct plat_sci_port *cfg)
+{
+	unsigned int regtype;
+
+	if (cfg->regtype != SCIx_PROBE_REGTYPE)
+		return &sci_port_params[cfg->regtype];
+
+	switch (cfg->type) {
+	case PORT_SCI:
+		regtype = SCIx_SCI_REGTYPE;
+		break;
+	case PORT_IRDA:
+		regtype = SCIx_IRDA_REGTYPE;
+		break;
+	case PORT_SCIFA:
+		regtype = SCIx_SCIFA_REGTYPE;
+		break;
+	case PORT_SCIFB:
+		regtype = SCIx_SCIFB_REGTYPE;
+		break;
+	case PORT_SCIF:
+		/*
+		 * The SH-4 is a bit of a misnomer here, although that's
+		 * where this particular port layout originated. This
+		 * configuration (or some slight variation thereof)
+		 * remains the dominant model for all SCIFs.
+		 */
+		regtype = SCIx_SH4_SCIF_REGTYPE;
+		break;
+	case PORT_HSCIF:
+		regtype = SCIx_HSCIF_REGTYPE;
+		break;
+	default:
+		pr_err("Can't probe register map for given port\n");
+		return NULL;
+	}
+
+	return &sci_port_params[regtype];
+}
+
 static int sci_init_single(struct platform_device *dev,
 			   struct sci_port *sci_port, unsigned int index,
-			   struct plat_sci_port *p, bool early)
+			   const struct plat_sci_port *p, bool early)
 {
 	struct uart_port *port = &sci_port->port;
 	const struct resource *res;
@@ -2578,13 +2584,9 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->irqs[3] = sci_port->irqs[0];
 	}
 
-	if (p->regtype == SCIx_PROBE_REGTYPE) {
-		ret = sci_probe_regmap(p);
-		if (unlikely(ret))
-			return ret;
-	}
-
-	sci_port->params = &sci_port_params[p->regtype];
+	sci_port->params = sci_probe_regmap(p);
+	if (unlikely(sci_port->params == NULL))
+		return -EINVAL;
 
 	switch (p->type) {
 	case PORT_SCIFB:
@@ -2804,7 +2806,7 @@ static char early_serial_buf[32];
 
 static int sci_probe_earlyprintk(struct platform_device *pdev)
 {
-	struct plat_sci_port *cfg = dev_get_platdata(&pdev->dev);
+	const struct plat_sci_port *cfg = dev_get_platdata(&pdev->dev);
 
 	if (early_serial_console.data)
 		return -EEXIST;
@@ -3095,10 +3097,9 @@ static int __init early_console_setup(struct earlycon_device *device,
 	device->port.serial_out	= sci_serial_out;
 	device->port.type = type;
 	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
+	port_cfg.type = type;
 	sci_ports[0].cfg = &port_cfg;
-	sci_ports[0].cfg->type = type;
-	sci_probe_regmap(sci_ports[0].cfg);
-	sci_ports[0].params = &sci_port_params[sci_ports[0].cfg->regtype];
+	sci_ports[0].params = sci_probe_regmap(&port_cfg);
 	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
 	sci_serial_out(&sci_ports[0].port, SCSCR,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
-- 
Regards,

Laurent Pinchart

