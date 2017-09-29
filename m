From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 1/2] serial: sh-sci: Support for variable HSCIF hardware RX timeout
Date: Fri, 29 Sep 2017 15:08:53 +0200
Message-ID: <1506690534-27302-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1506690534-27302-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1506690534-27302-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: wsa@the-dreams.de, linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

HSCIF has facilities that allow changing the timeout after which an RX
interrupt is triggered even if the FIFO is not filled. This patch allows
changing the default (15 bits of silence) using the existing sysfs
attribute "rx_fifo_timeout".

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 52 ++++++++++++++++++++++++++++++++-------------
 drivers/tty/serial/sh-sci.h |  3 +++
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 784dd42..41bf910 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -152,6 +152,7 @@ struct sci_port {
 	int				rx_trigger;
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
+	u16				hscif_tot;
 
 	bool has_rtscts;
 	bool autorts;
@@ -1107,8 +1108,14 @@ static ssize_t rx_fifo_timeout_show(struct device *dev,
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	struct sci_port *sci = to_sci_port(port);
+	int v;
 
-	return sprintf(buf, "%d\n", sci->rx_fifo_timeout);
+	if (port->type == PORT_HSCIF)
+		v = sci->hscif_tot >> HSSCR_TOT_SHIFT;
+	else
+		v = sci->rx_fifo_timeout;
+
+	return sprintf(buf, "%d\n", v);
 }
 
 static ssize_t rx_fifo_timeout_store(struct device *dev,
@@ -1124,11 +1131,19 @@ static ssize_t rx_fifo_timeout_store(struct device *dev,
 	ret = kstrtol(buf, 0, &r);
 	if (ret)
 		return ret;
-	sci->rx_fifo_timeout = r;
-	scif_set_rtrg(port, 1);
-	if (r > 0)
-		setup_timer(&sci->rx_fifo_timer, rx_fifo_timer_fn,
-			    (unsigned long)sci);
+
+	if (port->type == PORT_HSCIF) {
+		if (r < 0 || r > 3)
+			return -EINVAL;
+		sci->hscif_tot = r << HSSCR_TOT_SHIFT;
+	} else {
+		sci->rx_fifo_timeout = r;
+		scif_set_rtrg(port, 1);
+		if (r > 0)
+			setup_timer(&sci->rx_fifo_timer, rx_fifo_timer_fn,
+				    (unsigned long)sci);
+	}
+
 	return count;
 }
 
@@ -2037,9 +2052,13 @@ static void sci_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 	sci_stop_rx(port);
 	sci_stop_tx(port);
-	/* Stop RX and TX, disable related interrupts, keep clock source */
+	/*
+	 * Stop RX and TX, disable related interrupts, keep clock source
+	 * and HSCIF TOT bits
+	 */
 	scr = serial_port_in(port, SCSCR);
-	serial_port_out(port, SCSCR, scr & (SCSCR_CKE1 | SCSCR_CKE0));
+	serial_port_out(port, SCSCR, scr &
+			(SCSCR_CKE1 | SCSCR_CKE0 | s->hscif_tot));
 	spin_unlock_irqrestore(&port->lock, flags);
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
@@ -2186,7 +2205,7 @@ static void sci_reset(struct uart_port *port)
 	unsigned int status;
 	struct sci_port *s = to_sci_port(port);
 
-	serial_port_out(port, SCSCR, 0x00);	/* TE=0, RE=0, CKE1=0 */
+	serial_port_out(port, SCSCR, s->hscif_tot);	/* TE=0, RE=0, CKE1=0 */
 
 	reg = sci_getreg(port, SCFCR);
 	if (reg->size)
@@ -2356,7 +2375,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		dev_dbg(port->dev,
 			 "SCR 0x%x SMR 0x%x BRR %u CKS 0x%x DL %u SRR %u\n",
 			 scr_val, smr_val, brr, sccks, dl, srr);
-		serial_port_out(port, SCSCR, scr_val);
+		serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
 		serial_port_out(port, SCSMR, smr_val);
 		serial_port_out(port, SCBRR, brr);
 		if (sci_getreg(port, HSSRR)->size)
@@ -2370,7 +2389,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		smr_val |= serial_port_in(port, SCSMR) &
 			   (SCSMR_CKEDG | SCSMR_SRC_MASK | SCSMR_CKS);
 		dev_dbg(port->dev, "SCR 0x%x SMR 0x%x\n", scr_val, smr_val);
-		serial_port_out(port, SCSCR, scr_val);
+		serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
 		serial_port_out(port, SCSMR, smr_val);
 	}
 
@@ -2407,7 +2426,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	scr_val |= SCSCR_RE | SCSCR_TE |
 		   (s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0));
 	dev_dbg(port->dev, "SCSCR 0x%x\n", scr_val);
-	serial_port_out(port, SCSCR, scr_val);
+	serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
 	if ((srr + 1 == 5) &&
 	    (port->type == PORT_SCIFA || port->type == PORT_SCIFB)) {
 		/*
@@ -2773,6 +2792,7 @@ static int sci_init_single(struct platform_device *dev,
 	}
 
 	sci_port->rx_fifo_timeout = 0;
+	sci_port->hscif_tot = 0;
 
 	/* SCIFA on sh7723 and sh7724 need a custom sampling rate that doesn't
 	 * match the SoC datasheet, this should be investigated. Let platform
@@ -2860,7 +2880,7 @@ static void serial_console_write(struct console *co, const char *s,
 	ctrl_temp = SCSCR_RE | SCSCR_TE |
 		    (sci_port->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0)) |
 		    (ctrl & (SCSCR_CKE1 | SCSCR_CKE0));
-	serial_port_out(port, SCSCR, ctrl_temp);
+	serial_port_out(port, SCSCR, ctrl_temp | sci_port->hscif_tot);
 
 	uart_console_write(port, s, count, serial_console_putchar);
 
@@ -2988,7 +3008,8 @@ static int sci_remove(struct platform_device *dev)
 		sysfs_remove_file(&dev->dev.kobj,
 				  &dev_attr_rx_fifo_trigger.attr);
 	}
-	if (port->port.type == PORT_SCIFA || port->port.type == PORT_SCIFB) {
+	if (port->port.type == PORT_SCIFA || port->port.type == PORT_SCIFB ||
+	    port->port.type == PORT_HSCIF) {
 		sysfs_remove_file(&dev->dev.kobj,
 				  &dev_attr_rx_fifo_timeout.attr);
 	}
@@ -3173,7 +3194,8 @@ static int sci_probe(struct platform_device *dev)
 		if (ret)
 			return ret;
 	}
-	if (sp->port.type == PORT_SCIFA || sp->port.type ==  PORT_SCIFB) {
+	if (sp->port.type == PORT_SCIFA || sp->port.type == PORT_SCIFB ||
+	    sp->port.type == PORT_HSCIF) {
 		ret = sysfs_create_file(&dev->dev.kobj,
 				&dev_attr_rx_fifo_timeout.attr);
 		if (ret) {
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 971b2ab..2b708cc 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -62,6 +62,9 @@ enum {
 #define SCSCR_TDRQE	BIT(15)	/* Tx Data Transfer Request Enable */
 #define SCSCR_RDRQE	BIT(14)	/* Rx Data Transfer Request Enable */
 
+/* Serial Control Register, HSCIF-only bits */
+#define HSSCR_TOT_SHIFT	14
+
 /* SCxSR (Serial Status Register) on SCI */
 #define SCI_TDRE	BIT(7)	/* Transmit Data Register Empty */
 #define SCI_RDRF	BIT(6)	/* Receive Data Register Full */
-- 
2.7.4
