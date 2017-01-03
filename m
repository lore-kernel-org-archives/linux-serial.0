From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 01/19] serial: sh-sci: Set the SCSCR TE and RE bits in the driver
Date: Wed,  4 Jan 2017 01:06:21 +0200
Message-ID: <20170103230639.19660-2-laurent.pinchart+renesas@ideasonboard.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The Transmit Enable and Receive Enable bits are set in the scscr field
of all instances of the sh-sci platform data. Set them in the driver
directly to prepare for their removal from platform data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 91e7dddbf72c..1e573611719e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2341,7 +2341,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_port_out(port, SCFCR, ctrl);
 	}
 
-	scr_val |= s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0);
+	scr_val |= SCSCR_RE | SCSCR_TE |
+		   (s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0));
 	dev_dbg(port->dev, "SCSCR 0x%x\n", scr_val);
 	serial_port_out(port, SCSCR, scr_val);
 	if ((srr + 1 == 5) &&
@@ -2791,7 +2792,8 @@ static void serial_console_write(struct console *co, const char *s,
 
 	/* first save SCSCR then disable interrupts, keep clock source */
 	ctrl = serial_port_in(port, SCSCR);
-	ctrl_temp = (sci_port->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0)) |
+	ctrl_temp = SCSCR_RE | SCSCR_TE |
+		    (sci_port->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0)) |
 		    (ctrl & (SCSCR_CKE1 | SCSCR_CKE0));
 	serial_port_out(port, SCSCR, ctrl_temp);
 
@@ -2994,7 +2996,6 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	p->flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 	p->type = SCI_OF_TYPE(match->data);
 	p->regtype = SCI_OF_REGTYPE(match->data);
-	p->scscr = SCSCR_RE | SCSCR_TE;
 
 	if (of_find_property(np, "uart-has-rtscts", NULL))
 		p->capabilities |= SCIx_HAVE_RTSCTS;
@@ -3162,9 +3163,9 @@ static int __init early_console_setup(struct earlycon_device *device,
 	sci_ports[0].cfg = &port_cfg;
 	sci_ports[0].cfg->type = type;
 	sci_probe_regmap(sci_ports[0].cfg);
-	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR) |
-			 SCSCR_RE | SCSCR_TE;
-	sci_serial_out(&sci_ports[0].port, SCSCR, port_cfg.scscr);
+	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
+	sci_serial_out(&sci_ports[0].port, SCSCR,
+		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
 	return 0;
-- 
Regards,

Laurent Pinchart

