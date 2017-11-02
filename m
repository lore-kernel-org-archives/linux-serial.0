From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] serial: sh-sci: Fix unlocked access to SCSCR register
Date: Thu,  2 Nov 2017 11:14:55 +0100
Message-ID: <20171102101455.28398-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-serial@vger.kernel.org

From: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>

The SCSCR register access in sci_break_ctl() is not locked.

sci_start_tx() and sci_set_termios() changes the SCSCR register,
but does not lock sci_port.

Therefore, this patch adds lock during register access.

Also, remove the log output that leads to a double lock.

Some analysis of where locks are not taken is as follows.
It appears that the lock is not taken in:
  - sci_start_tx(), sci_stop_tx()  as this is installed as a callback.
    And all callers of the callback take the lock.
  - start_rx as callers take the lock.
  - stop_rx. this is both installed as a callback and called directly.
    In both cases the caller takes the lock.

Signed-off-by: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2 [Simon Horman]
* Also take lock around call to sci_start_rx() in sci_rx_dma_release()
* Enhanced changelog to describe where locks are not taken and why.

v1 [Takatoshi Akiyama]

This is a patch from the Gen3 3.3.2 BSP.
Geert, please consider it for mainline.
---
 drivers/tty/serial/sh-sci.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d5714deaaf92..d5e07ddae523 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1226,8 +1226,11 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
 			  sg_dma_address(&s->sg_rx[0]));
 	dma_release_channel(chan);
-	if (enable_pio)
+	if (enable_pio) {
+		spin_lock_irqsave(&port->lock, flags);
 		sci_start_rx(port);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
 }
 
 static void sci_dma_rx_complete(void *arg)
@@ -1294,8 +1297,11 @@ static void sci_tx_dma_release(struct sci_port *s, bool enable_pio)
 	dma_unmap_single(chan->device->dev, s->tx_dma_addr, UART_XMIT_SIZE,
 			 DMA_TO_DEVICE);
 	dma_release_channel(chan);
-	if (enable_pio)
+	if (enable_pio) {
+		spin_lock_irqsave(&port->lock, flags);
 		sci_start_tx(port);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
 }
 
 static void sci_submit_rx(struct sci_port *s)
@@ -2004,6 +2010,7 @@ static void sci_enable_ms(struct uart_port *port)
 static void sci_break_ctl(struct uart_port *port, int break_state)
 {
 	unsigned short scscr, scsptr;
+	unsigned long flags;
 
 	/* check wheter the port has SCSPTR */
 	if (!sci_getreg(port, SCSPTR)->size) {
@@ -2014,6 +2021,7 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 		return;
 	}
 
+	spin_lock_irqsave(&port->lock, flags);
 	scsptr = serial_port_in(port, SCSPTR);
 	scscr = serial_port_in(port, SCSCR);
 
@@ -2027,6 +2035,7 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 
 	serial_port_out(port, SCSPTR, scsptr);
 	serial_port_out(port, SCSCR, scscr);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int sci_startup(struct uart_port *port)
@@ -2255,6 +2264,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	int min_err = INT_MAX, err;
 	unsigned long max_freq = 0;
 	int best_clk = -1;
+	unsigned long flags;
 
 	if ((termios->c_cflag & CSIZE) == CS7)
 		smr_val |= SCSMR_CHR;
@@ -2364,6 +2374,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_port_out(port, SCCKS, sccks);
 	}
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	sci_reset(port);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
@@ -2381,9 +2393,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			case 27: smr_val |= SCSMR_SRC_27; break;
 			}
 		smr_val |= cks;
-		dev_dbg(port->dev,
-			 "SCR 0x%x SMR 0x%x BRR %u CKS 0x%x DL %u SRR %u\n",
-			 scr_val, smr_val, brr, sccks, dl, srr);
 		serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
 		serial_port_out(port, SCSMR, smr_val);
 		serial_port_out(port, SCBRR, brr);
@@ -2397,7 +2406,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		scr_val = s->cfg->scscr & (SCSCR_CKE1 | SCSCR_CKE0);
 		smr_val |= serial_port_in(port, SCSMR) &
 			   (SCSMR_CKEDG | SCSMR_SRC_MASK | SCSMR_CKS);
-		dev_dbg(port->dev, "SCR 0x%x SMR 0x%x\n", scr_val, smr_val);
 		serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
 		serial_port_out(port, SCSMR, smr_val);
 	}
@@ -2434,7 +2442,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	scr_val |= SCSCR_RE | SCSCR_TE |
 		   (s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0));
-	dev_dbg(port->dev, "SCSCR 0x%x\n", scr_val);
 	serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
 	if ((srr + 1 == 5) &&
 	    (port->type == PORT_SCIFA || port->type == PORT_SCIFB)) {
@@ -2481,8 +2488,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	s->rx_frame = (100 * bits * HZ) / (baud / 10);
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	s->rx_timeout = DIV_ROUND_UP(s->buf_len_rx * 2 * s->rx_frame, 1000);
-	dev_dbg(port->dev, "DMA Rx t-out %ums, tty t-out %u jiffies\n",
-		s->rx_timeout * 1000 / HZ, port->timeout);
 	if (s->rx_timeout < msecs_to_jiffies(20))
 		s->rx_timeout = msecs_to_jiffies(20);
 #endif
@@ -2490,6 +2495,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CREAD) != 0)
 		sci_start_rx(port);
 
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	sci_port_disable(s);
 
 	if (UART_ENABLE_MS(port, termios->c_cflag))
-- 
2.11.0
