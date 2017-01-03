From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 18/19] serial: sh-sci: Remove unused platform data capabilities field
Date: Wed,  4 Jan 2017 01:06:38 +0200
Message-ID: <20170103230639.19660-19-laurent.pinchart+renesas@ideasonboard.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The field isn't set by any platform but is only used internally in the
driver to hold data parsed from DT. Move it to the sci_port structure.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 11 +++++++----
 include/linux/serial_sci.h  |  6 ------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1f3025f2d21d..5fc2606fc525 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -149,6 +149,7 @@ struct sci_port {
 	unsigned int			rx_timeout;
 #endif
 
+	bool has_rtscts;
 	bool autorts;
 };
 
@@ -681,7 +682,7 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 
 		/* Enable RXD and TXD pin functions */
 		ctrl &= ~(SCPCR_RXDC | SCPCR_TXDC);
-		if (to_sci_port(port)->cfg->capabilities & SCIx_HAVE_RTSCTS) {
+		if (to_sci_port(port)->has_rtscts) {
 			/* RTS# is output, driven 1 */
 			ctrl |= SCPCR_RTSC;
 			serial_port_out(port, SCPDR,
@@ -1737,7 +1738,7 @@ static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	mctrl_gpio_set(s->gpios, mctrl);
 
-	if (!(s->cfg->capabilities & SCIx_HAVE_RTSCTS))
+	if (!s->has_rtscts)
 		return;
 
 	if (!(mctrl & TIOCM_RTS)) {
@@ -2808,6 +2809,7 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
 	struct plat_sci_port *p;
+	struct sci_port *sp;
 	int id;
 
 	if (!IS_ENABLED(CONFIG_OF) || !np)
@@ -2828,13 +2830,14 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 		return NULL;
 	}
 
+	sp = &sci_ports[id];
 	*dev_id = id;
 
 	p->type = SCI_OF_TYPE(match->data);
 	p->regtype = SCI_OF_REGTYPE(match->data);
 
 	if (of_find_property(np, "uart-has-rtscts", NULL))
-		p->capabilities |= SCIx_HAVE_RTSCTS;
+		sp->has_rtscts = true;
 
 	return p;
 }
@@ -2862,7 +2865,7 @@ static int sci_probe_single(struct platform_device *dev,
 	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
 		return PTR_ERR(sciport->gpios);
 
-	if (p->capabilities & SCIx_HAVE_RTSCTS) {
+	if (sciport->has_rtscts) {
 		if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
 							UART_GPIO_CTS)) ||
 		    !IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index b4419931bf4c..f9a4526f4ec5 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -44,17 +44,11 @@ struct plat_sci_port_ops {
 };
 
 /*
- * Port-specific capabilities
- */
-#define SCIx_HAVE_RTSCTS	BIT(0)
-
-/*
  * Platform device specific platform_data struct
  */
 struct plat_sci_port {
 	unsigned int	type;			/* SCI / SCIF / IRDA / HSCIF */
 	upf_t		flags;			/* UPF_* flags */
-	unsigned long	capabilities;		/* Port features/capabilities */
 
 	unsigned int	sampling_rate;
 	unsigned int	scscr;			/* SCSCR initialization */
-- 
Regards,

Laurent Pinchart
