From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH] serial: sh-sci: use hrtimer for receive timeout
Date: Thu, 15 Feb 2018 13:02:41 +0100
Message-ID: <1518696161-23866-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: wsa@the-dreams.de, geert@linux-m68k.org, yoshihiro.shimoda.uh@renesas.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

High latencies of classic timers cause performance issues for high-
speed serial transmissions. This patch transforms rx_timer into an
hrtimer to reduce the minimum latency.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 47 +++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d9f399c..553f30c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/ktime.h>
 #include <linux/major.h>
 #include <linux/module.h>
 #include <linux/mm.h>
@@ -143,8 +144,8 @@ struct sci_port {
 	void				*rx_buf[2];
 	size_t				buf_len_rx;
 	struct work_struct		work_tx;
-	struct timer_list		rx_timer;
-	unsigned int			rx_timeout;
+	struct hrtimer			rx_timer;
+	unsigned int			rx_timeout;	/* microseconds */
 #endif
 	unsigned int			rx_frame;
 	int				rx_trigger;
@@ -1229,6 +1230,15 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 	}
 }
 
+static void start_hrtimer_us(struct hrtimer *hrt, unsigned long usec)
+{
+	long sec = usec / 1000000;
+	long nsec = (usec % 1000000) * 1000;
+	ktime_t t = ktime_set(sec, nsec);
+
+	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
+}
+
 static void sci_dma_rx_complete(void *arg)
 {
 	struct sci_port *s = arg;
@@ -1247,7 +1257,7 @@ static void sci_dma_rx_complete(void *arg)
 	if (active >= 0)
 		count = sci_dma_rx_push(s, s->rx_buf[active], s->buf_len_rx);
 
-	mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
+	start_hrtimer_us(&s->rx_timer, s->rx_timeout);
 
 	if (count)
 		tty_flip_buffer_push(&port->state->port);
@@ -1391,9 +1401,9 @@ static void work_fn_tx(struct work_struct *work)
 	dma_async_issue_pending(chan);
 }
 
-static void rx_timer_fn(struct timer_list *t)
+static enum hrtimer_restart rx_timer_fn(struct hrtimer *t)
 {
-	struct sci_port *s = from_timer(s, t, rx_timer);
+	struct sci_port *s = container_of(t, struct sci_port, rx_timer);
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
 	struct dma_tx_state state;
@@ -1410,7 +1420,7 @@ static void rx_timer_fn(struct timer_list *t)
 	active = sci_dma_rx_find_active(s);
 	if (active < 0) {
 		spin_unlock_irqrestore(&port->lock, flags);
-		return;
+		return HRTIMER_NORESTART;
 	}
 
 	status = dmaengine_tx_status(s->chan_rx, s->active_rx, &state);
@@ -1420,7 +1430,7 @@ static void rx_timer_fn(struct timer_list *t)
 			s->active_rx, active);
 
 		/* Let packet complete handler take care of the packet */
-		return;
+		return HRTIMER_NORESTART;
 	}
 
 	dmaengine_pause(chan);
@@ -1435,7 +1445,7 @@ static void rx_timer_fn(struct timer_list *t)
 	if (status == DMA_COMPLETE) {
 		spin_unlock_irqrestore(&port->lock, flags);
 		dev_dbg(port->dev, "Transaction complete after DMA engine was stopped");
-		return;
+		return HRTIMER_NORESTART;
 	}
 
 	/* Handle incomplete DMA receive */
@@ -1460,6 +1470,8 @@ static void rx_timer_fn(struct timer_list *t)
 	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
 
 	spin_unlock_irqrestore(&port->lock, flags);
+
+	return HRTIMER_NORESTART;
 }
 
 static struct dma_chan *sci_request_dma_chan(struct uart_port *port,
@@ -1571,7 +1583,8 @@ static void sci_request_dma(struct uart_port *port)
 			dma += s->buf_len_rx;
 		}
 
-		timer_setup(&s->rx_timer, rx_timer_fn, 0);
+		hrtimer_init(&s->rx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		s->rx_timer.function = rx_timer_fn;
 
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 			sci_submit_rx(s);
@@ -1630,9 +1643,9 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 		/* Clear current interrupt */
 		serial_port_out(port, SCxSR,
 				ssr & ~(SCIF_DR | SCxSR_RDxF(port)));
-		dev_dbg(port->dev, "Rx IRQ %lu: setup t-out in %u jiffies\n",
+		dev_dbg(port->dev, "Rx IRQ %lu: setup t-out in %u us\n",
 			jiffies, s->rx_timeout);
-		mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
+		start_hrtimer_us(&s->rx_timer, s->rx_timeout);
 
 		return IRQ_HANDLED;
 	}
@@ -1643,7 +1656,7 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 			scif_set_rtrg(port, s->rx_trigger);
 
 		mod_timer(&s->rx_fifo_timer, jiffies + DIV_ROUND_UP(
-			  s->rx_frame * s->rx_fifo_timeout, 1000));
+			  s->rx_frame * HZ * s->rx_fifo_timeout, 1000000));
 	}
 
 	/* I think sci_receive_chars has to be called irrespective
@@ -2079,7 +2092,7 @@ static void sci_shutdown(struct uart_port *port)
 	if (s->chan_rx) {
 		dev_dbg(port->dev, "%s(%d) deleting rx_timer\n", __func__,
 			port->line);
-		del_timer_sync(&s->rx_timer);
+		hrtimer_cancel(&s->rx_timer);
 	}
 #endif
 
@@ -2480,11 +2493,11 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (termios->c_cflag & PARENB)
 		bits++;
 
-	s->rx_frame = (100 * bits * HZ) / (baud / 10);
+	s->rx_frame = (10000 * bits) / (baud / 100);
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	s->rx_timeout = DIV_ROUND_UP(s->buf_len_rx * 2 * s->rx_frame, 1000);
-	if (s->rx_timeout < msecs_to_jiffies(20))
-		s->rx_timeout = msecs_to_jiffies(20);
+	s->rx_timeout = s->buf_len_rx * 2 * s->rx_frame;
+	if (s->rx_timeout < 20)
+		s->rx_timeout = 20;
 #endif
 
 	if ((termios->c_cflag & CREAD) != 0)
-- 
2.7.4
