From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC] serial: sh-sci: Fix unlocked access to SCSCR register
Date: Mon,  7 Nov 2016 16:42:53 +0100
Message-ID: <1478533373-10643-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>

The SCSCR register access in sci_break_ctl() is not locked.

sci_start_tx() and sci_set_termios() changes the SCSCR register,
but does not lock sci_port.

Therefore, this patch adds lock during register access.

Also, remove the log output that leads to a double lock.

Signed-off-by: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
This is a patch from the Gen3 3.3.2 BSP.
Geert, please consider it for mainline.

It appears that the lock is not taken in start_tx() as this is installed
as a callback. And all callers of the callback take the lock.
---
 drivers/tty/serial/sh-sci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 91e7dddbf72c..f4d705399d25 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1243,8 +1243,11 @@ static void sci_tx_dma_release(struct sci_port *s, bool enable_pio)
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
@@ -1934,6 +1937,7 @@ static void sci_enable_ms(struct uart_port *port)
 static void sci_break_ctl(struct uart_port *port, int break_state)
 {
 	unsigned short scscr, scsptr;
+	unsigned long flags;
 
 	/* check wheter the port has SCSPTR */
 	if (!sci_getreg(port, SCSPTR)->size) {
@@ -1944,6 +1948,7 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 		return;
 	}
 
+	spin_lock_irqsave(&port->lock, flags);
 	scsptr = serial_port_in(port, SCSPTR);
 	scscr = serial_port_in(port, SCSCR);
 
@@ -1957,6 +1962,7 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 
 	serial_port_out(port, SCSPTR, scsptr);
 	serial_port_out(port, SCSCR, scscr);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int sci_startup(struct uart_port *port)
@@ -2168,6 +2174,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	int min_err = INT_MAX, err;
 	unsigned long max_freq = 0;
 	int best_clk = -1;
+	unsigned long flags;
 
 	if ((termios->c_cflag & CSIZE) == CS7)
 		smr_val |= SCSMR_CHR;
@@ -2277,6 +2284,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_port_out(port, SCCKS, sccks);
 	}
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	sci_reset(port);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
@@ -2294,9 +2303,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			case 27: smr_val |= SCSMR_SRC_27; break;
 			}
 		smr_val |= cks;
-		dev_dbg(port->dev,
-			 "SCR 0x%x SMR 0x%x BRR %u CKS 0x%x DL %u SRR %u\n",
-			 scr_val, smr_val, brr, sccks, dl, srr);
 		serial_port_out(port, SCSCR, scr_val);
 		serial_port_out(port, SCSMR, smr_val);
 		serial_port_out(port, SCBRR, brr);
@@ -2310,7 +2316,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		scr_val = s->cfg->scscr & (SCSCR_CKE1 | SCSCR_CKE0);
 		smr_val |= serial_port_in(port, SCSMR) &
 			   (SCSMR_CKEDG | SCSMR_SRC_MASK | SCSMR_CKS);
-		dev_dbg(port->dev, "SCR 0x%x SMR 0x%x\n", scr_val, smr_val);
 		serial_port_out(port, SCSCR, scr_val);
 		serial_port_out(port, SCSMR, smr_val);
 	}
@@ -2342,7 +2347,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	scr_val |= s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0);
-	dev_dbg(port->dev, "SCSCR 0x%x\n", scr_val);
 	serial_port_out(port, SCSCR, scr_val);
 	if ((srr + 1 == 5) &&
 	    (port->type == PORT_SCIFA || port->type == PORT_SCIFB)) {
@@ -2391,8 +2395,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			bits++;
 		s->rx_timeout = DIV_ROUND_UP((s->buf_len_rx * 2 * bits * HZ) /
 					     (baud / 10), 10);
-		dev_dbg(port->dev, "DMA Rx t-out %ums, tty t-out %u jiffies\n",
-			s->rx_timeout * 1000 / HZ, port->timeout);
 		if (s->rx_timeout < msecs_to_jiffies(20))
 			s->rx_timeout = msecs_to_jiffies(20);
 	}
@@ -2401,6 +2403,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CREAD) != 0)
 		sci_start_rx(port);
 
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	sci_port_disable(s);
 
 	if (UART_ENABLE_MS(port, termios->c_cflag))
-- 
2.7.0.rc3.207.g0ac5344
