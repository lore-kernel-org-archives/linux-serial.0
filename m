From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 5/7] serial: sh-sci: SCIFA/B RX FIFO software timeout
Date: Fri,  9 Dec 2016 13:36:09 +0100
Message-ID: <1481286971-16667-6-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Implements support for FIFO fill thresholds greater than one with software
timeout.

This mechanism is not possible (or at least not useful) on SCIF family
hardware other than SCIFA and SCIFB because they do not support turning off
the DR hardware timeout interrupt separately from the RI interrupt.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 102 ++++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ce3cf03..0af4997 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -141,7 +141,10 @@ struct sci_port {
 	struct timer_list		rx_timer;
 	unsigned int			rx_timeout;
 #endif
+	unsigned int			rx_frame;
 	int				rx_trigger;
+	struct timer_list		rx_fifo_timer;
+	int				rx_fifo_timeout;
 
 	bool autorts;
 };
@@ -1159,6 +1162,24 @@ static int scif_set_rtrg(struct uart_port *port, int rx_trig)
 	return rx_trig;
 }
 
+static int scif_rtrg_enabled(struct uart_port *port)
+{
+	if (sci_getreg(port, HSRTRGR)->size)
+		return serial_port_in(port, HSRTRGR) != 0;
+	else
+		return (serial_port_in(port, SCFCR) &
+			(SCFCR_RTRG0 | SCFCR_RTRG1)) != 0;
+}
+
+static void rx_fifo_timer_fn(unsigned long arg)
+{
+	struct sci_port *s = (struct sci_port *)arg;
+	struct uart_port *port = &s->port;
+
+	dev_dbg(port->dev, "Rx timed out\n");
+	scif_set_rtrg(port, 1);
+}
+
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 static void sci_dma_tx_complete(void *arg)
 {
@@ -1615,9 +1636,9 @@ static inline void sci_free_dma(struct uart_port *port)
 
 static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 {
-#ifdef CONFIG_SERIAL_SH_SCI_DMA
 	struct uart_port *port = ptr;
 	struct sci_port *s = to_sci_port(port);
+#ifdef CONFIG_SERIAL_SH_SCI_DMA
 
 	if (s->chan_rx) {
 		u16 scr = serial_port_in(port, SCSCR);
@@ -1643,6 +1664,14 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 	}
 #endif
 
+	if (s->rx_trigger > 1 && s->rx_fifo_timeout > 0) {
+		if (!scif_rtrg_enabled(port))
+			scif_set_rtrg(port, s->rx_trigger);
+
+		mod_timer(&s->rx_fifo_timer, jiffies + DIV_ROUND_UP(
+			  s->rx_frame * s->rx_fifo_timeout, 1000));
+	}
+
 	/* I think sci_receive_chars has to be called irrespective
 	 * of whether the I_IXOFF is set, otherwise, how is the interrupt
 	 * to be disabled?
@@ -2226,14 +2255,20 @@ static void sci_reset(struct uart_port *port)
 		serial_port_out(port, SCLSR, status);
 	}
 
-	if (s->rx_trigger > 1)
-		scif_set_rtrg(port, s->rx_trigger);
+	if (s->rx_trigger > 1) {
+		if (s->rx_fifo_timeout) {
+			scif_set_rtrg(port, 1);
+			setup_timer(&s->rx_fifo_timer, rx_fifo_timer_fn,
+				    (unsigned long)s);
+		} else
+			scif_set_rtrg(port, s->rx_trigger);
+	}
 }
 
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
-	unsigned int baud, smr_val = SCSMR_ASYNC, scr_val = 0, i;
+	unsigned int baud, smr_val = SCSMR_ASYNC, scr_val = 0, i, bits;
 	unsigned int brr = 255, cks = 0, srr = 15, dl = 0, sccks = 0;
 	unsigned int brr1 = 255, cks1 = 0, srr1 = 15, dl1 = 0;
 	struct sci_port *s = to_sci_port(port);
@@ -2428,7 +2463,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		udelay(DIV_ROUND_UP(10 * 1000000, baud));
 	}
 
-#ifdef CONFIG_SERIAL_SH_SCI_DMA
 	/*
 	 * Calculate delay for 2 DMA buffers (4 FIFO).
 	 * See serial_core.c::uart_update_timeout().
@@ -2439,36 +2473,34 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * value obtained by this formula is too small. Therefore, if the value
 	 * is smaller than 20ms, use 20ms as the timeout value for DMA.
 	 */
-	if (s->chan_rx) {
-		unsigned int bits;
+	/* byte size and parity */
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		bits = 7;
+		break;
+	case CS6:
+		bits = 8;
+		break;
+	case CS7:
+		bits = 9;
+		break;
+	default:
+		bits = 10;
+		break;
+	}
 
-		/* byte size and parity */
-		switch (termios->c_cflag & CSIZE) {
-		case CS5:
-			bits = 7;
-			break;
-		case CS6:
-			bits = 8;
-			break;
-		case CS7:
-			bits = 9;
-			break;
-		default:
-			bits = 10;
-			break;
-		}
+	if (termios->c_cflag & CSTOPB)
+		bits++;
+	if (termios->c_cflag & PARENB)
+		bits++;
 
-		if (termios->c_cflag & CSTOPB)
-			bits++;
-		if (termios->c_cflag & PARENB)
-			bits++;
-		s->rx_timeout = DIV_ROUND_UP((s->buf_len_rx * 2 * bits * HZ) /
-					     (baud / 10), 10);
-		dev_dbg(port->dev, "DMA Rx t-out %ums, tty t-out %u jiffies\n",
-			s->rx_timeout * 1000 / HZ, port->timeout);
-		if (s->rx_timeout < msecs_to_jiffies(20))
-			s->rx_timeout = msecs_to_jiffies(20);
-	}
+	s->rx_frame = (100 * bits * HZ) / (baud / 10);
+#ifdef CONFIG_SERIAL_SH_SCI_DMA
+	s->rx_timeout = DIV_ROUND_UP(s->buf_len_rx * 2 * s->rx_frame, 1000);
+	dev_dbg(port->dev, "DMA Rx t-out %ums, tty t-out %u jiffies\n",
+		s->rx_timeout * 1000 / HZ, port->timeout);
+	if (s->rx_timeout < msecs_to_jiffies(20))
+		s->rx_timeout = msecs_to_jiffies(20);
 #endif
 
 	if ((termios->c_cflag & CREAD) != 0)
@@ -2728,6 +2760,7 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCIFA_ORER;
 		sci_port->sampling_rate_mask = SCI_SR_SCIFAB;
+		sci_port->rx_trigger = 48;
 		break;
 	case PORT_HSCIF:
 		port->fifosize = 128;
@@ -2741,6 +2774,7 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCIFA_ORER;
 		sci_port->sampling_rate_mask = SCI_SR_SCIFAB;
+		sci_port->rx_trigger = 32;
 		break;
 	case PORT_SCIF:
 		port->fifosize = 16;
@@ -2764,6 +2798,8 @@ static int sci_init_single(struct platform_device *dev,
 		break;
 	}
 
+	sci_port->rx_fifo_timeout = 0;
+
 	/* SCIFA on sh7723 and sh7724 need a custom sampling rate that doesn't
 	 * match the SoC datasheet, this should be investigated. Let platform
 	 * data override the sampling rate for now.
-- 
2.7.4
