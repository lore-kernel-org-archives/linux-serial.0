From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [RFC PATCH 1/4] serial: use kfifo instead of circ_buf
Date: Mon, 15 Nov 2010 16:01:02 -0500
Message-ID: <1289854865-11865-2-git-send-email-wfp5p@virginia.edu>
References: <1289854865-11865-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:57508 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758473Ab0KOVJu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Nov 2010 16:09:50 -0500
In-Reply-To: <1289854865-11865-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

The serial subsystem used struct circ_buf as provided by
circ_buf.h.  Use kfifo instead as suggested by Alan Cox.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 drivers/serial/8250.c        |   20 ++++++----
 drivers/serial/jsm/jsm_tty.c |   26 +++++--------
 drivers/serial/serial_core.c |   78 +++++++++--------------------------------
 include/linux/serial_core.h  |    4 +-
 4 files changed, 41 insertions(+), 87 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 4d8e14b..69c68d2 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1461,8 +1461,10 @@ ignore_char:
 
 static void transmit_chars(struct uart_8250_port *up)
 {
-	struct circ_buf *xmit = &up->port.state->xmit;
+	struct kfifo *xmit_fifo = &up->port.state->xmit_fifo;
+	u8 iobuf;
 	int count;
+	int len;
 
 	if (up->port.x_char) {
 		serial_outp(up, UART_TX, up->port.x_char);
@@ -1474,26 +1476,28 @@ static void transmit_chars(struct uart_8250_port *up)
 		serial8250_stop_tx(&up->port);
 		return;
 	}
-	if (uart_circ_empty(xmit)) {
+	if (kfifo_is_empty(xmit_fifo)) {
 		__stop_tx(up);
 		return;
 	}
 
 	count = up->tx_loadsz;
 	do {
-		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		len = kfifo_out(xmit_fifo, &iobuf, 1);
+		if (!len)
+			break;
+		serial_out(up, UART_TX, iobuf);
 		up->port.icount.tx++;
-		if (uart_circ_empty(xmit))
+		if (kfifo_is_empty(xmit_fifo))
 			break;
 	} while (--count > 0);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	if (kfifo_len(xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(&up->port);
 
 	DEBUG_INTR("THRE...");
 
-	if (uart_circ_empty(xmit))
+	if (kfifo_is_empty(xmit_fifo))
 		__stop_tx(up);
 }
 
@@ -1762,7 +1766,7 @@ static void serial8250_backup_timeout(unsigned long data)
 	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	if ((iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
-	    (!uart_circ_empty(&up->port.state->xmit) || up->port.x_char) &&
+	    (!kfifo_is_empty(&up->port.state->xmit_fifo ) || up->port.x_char) &&
 	    (lsr & UART_LSR_THRE)) {
 		iir &= ~(UART_IIR_ID | UART_IIR_NO_INT);
 		iir |= UART_IIR_THRI;
diff --git a/drivers/serial/jsm/jsm_tty.c b/drivers/serial/jsm/jsm_tty.c
index 7a4a914..3eb54ee 100644
--- a/drivers/serial/jsm/jsm_tty.c
+++ b/drivers/serial/jsm/jsm_tty.c
@@ -846,12 +846,14 @@ void jsm_check_queue_flow_control(struct jsm_channel *ch)
 int jsm_tty_write(struct uart_port *port)
 {
 	int bufcount;
+	int len;
+	u8 c;
 	int data_count = 0,data_count1 =0;
 	u16 head;
 	u16 tail;
 	u16 tmask;
 	u32 remain;
-	int temp_tail = port->state->xmit.tail;
+	struct kfifo *xmit_fifo = &port->state->xmit_fifo;
 	struct jsm_channel *channel = (struct jsm_channel *)port;
 
 	tmask = WQUEUEMASK;
@@ -867,13 +869,10 @@ int jsm_tty_write(struct uart_port *port)
 	data_count = 0;
 	if (bufcount >= remain) {
 		bufcount -= remain;
-		while ((port->state->xmit.head != temp_tail) &&
-		(data_count < remain)) {
-			channel->ch_wqueue[head++] =
-			port->state->xmit.buf[temp_tail];
-
-			temp_tail++;
-			temp_tail &= (UART_XMIT_SIZE - 1);
+		while ((!kfifo_is_empty(xmit_fifo)) &&
+		       (data_count < remain)) {
+			len = kfifo_out(xmit_fifo, &c, 1);
+			channel->ch_wqueue[head++] = c;
 			data_count++;
 		}
 		if (data_count == remain) head = 0;
@@ -882,20 +881,15 @@ int jsm_tty_write(struct uart_port *port)
 	data_count1 = 0;
 	if (bufcount > 0) {
 		remain = bufcount;
-		while ((port->state->xmit.head != temp_tail) &&
+		while ((!kfifo_is_empty(xmit_fifo)) &&
 			(data_count1 < remain)) {
-			channel->ch_wqueue[head++] =
-				port->state->xmit.buf[temp_tail];
-
-			temp_tail++;
-			temp_tail &= (UART_XMIT_SIZE - 1);
+			len = kfifo_out(xmit_fifo, &c, 1);
+			channel->ch_wqueue[head++] = c;
 			data_count1++;
 
 		}
 	}
 
-	port->state->xmit.tail = temp_tail;
-
 	data_count += data_count1;
 	if (data_count) {
 		head &= tmask;
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index c4ea146..5ef653b 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -94,7 +94,7 @@ static void __uart_start(struct tty_struct *tty)
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->uart_port;
 
-	if (!uart_circ_empty(&state->xmit) && state->xmit.buf &&
+	if (!kfifo_is_empty(&state->xmit_fifo) &&
 	    !tty->stopped && !tty->hw_stopped)
 		port->ops->start_tx(port);
 }
@@ -141,7 +141,6 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state, int in
 {
 	struct uart_port *uport = state->uart_port;
 	struct tty_port *port = &state->port;
-	unsigned long page;
 	int retval = 0;
 
 	if (port->flags & ASYNC_INITIALIZED)
@@ -161,14 +160,10 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state, int in
 	 * Initialise and allocate the transmit and temporary
 	 * buffer.
 	 */
-	if (!state->xmit.buf) {
-		/* This is protected by the per port mutex */
-		page = get_zeroed_page(GFP_KERNEL);
-		if (!page)
+	if (!kfifo_initialized(&state->xmit_fifo)) {
+		retval = kfifo_alloc(&state->xmit_fifo, PAGE_SIZE, GFP_KERNEL);
+		if (retval)
 			return -ENOMEM;
-
-		state->xmit.buf = (unsigned char *) page;
-		uart_circ_clear(&state->xmit);
 	}
 
 	retval = uport->ops->startup(uport);
@@ -256,10 +251,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	/*
 	 * Free the transmit buffer page.
 	 */
-	if (state->xmit.buf) {
-		free_page((unsigned long)state->xmit.buf);
-		state->xmit.buf = NULL;
-	}
+	kfifo_free(&state->xmit_fifo);
 }
 
 /**
@@ -462,21 +454,13 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 }
 
 static inline int __uart_put_char(struct uart_port *port,
-				struct circ_buf *circ, unsigned char c)
+				struct kfifo *fifo, unsigned char c)
 {
-	unsigned long flags;
 	int ret = 0;
 
-	if (!circ->buf)
+	if (!kfifo_initialized(fifo))
 		return 0;
-
-	spin_lock_irqsave(&port->lock, flags);
-	if (uart_circ_chars_free(circ) != 0) {
-		circ->buf[circ->head] = c;
-		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
-		ret = 1;
-	}
-	spin_unlock_irqrestore(&port->lock, flags);
+	kfifo_in_locked(fifo, &c, sizeof(c), &port->lock);
 	return ret;
 }
 
@@ -484,7 +468,7 @@ static int uart_put_char(struct tty_struct *tty, unsigned char ch)
 {
 	struct uart_state *state = tty->driver_data;
 
-	return __uart_put_char(state->uart_port, &state->xmit, ch);
+	return __uart_put_char(state->uart_port, &state->xmit_fifo, ch);
 }
 
 static void uart_flush_chars(struct tty_struct *tty)
@@ -493,13 +477,11 @@ static void uart_flush_chars(struct tty_struct *tty)
 }
 
 static int uart_write(struct tty_struct *tty,
-					const unsigned char *buf, int count)
+		      const unsigned char *buf, int count)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port;
-	struct circ_buf *circ;
-	unsigned long flags;
-	int c, ret = 0;
+	int ret = 0;
 
 	/*
 	 * This means you called this function _after_ the port was
@@ -511,25 +493,11 @@ static int uart_write(struct tty_struct *tty,
 	}
 
 	port = state->uart_port;
-	circ = &state->xmit;
 
-	if (!circ->buf)
+	if (!kfifo_initialized(&state->xmit_fifo))
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
-	while (1) {
-		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
-		if (count < c)
-			c = count;
-		if (c <= 0)
-			break;
-		memcpy(circ->buf + circ->head, buf, c);
-		circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
-		buf += c;
-		count -= c;
-		ret += c;
-	}
-	spin_unlock_irqrestore(&port->lock, flags);
+	ret = kfifo_in_locked(&state->xmit_fifo, buf, count, &port->lock);
 
 	uart_start(tty);
 	return ret;
@@ -538,25 +506,13 @@ static int uart_write(struct tty_struct *tty,
 static int uart_write_room(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&state->uart_port->lock, flags);
-	ret = uart_circ_chars_free(&state->xmit);
-	spin_unlock_irqrestore(&state->uart_port->lock, flags);
-	return ret;
+	return PAGE_SIZE - kfifo_len(&state->xmit_fifo);
 }
 
 static int uart_chars_in_buffer(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&state->uart_port->lock, flags);
-	ret = uart_circ_chars_pending(&state->xmit);
-	spin_unlock_irqrestore(&state->uart_port->lock, flags);
-	return ret;
+	return kfifo_len(&state->xmit_fifo);
 }
 
 static void uart_flush_buffer(struct tty_struct *tty)
@@ -578,7 +534,7 @@ static void uart_flush_buffer(struct tty_struct *tty)
 	pr_debug("uart_flush_buffer(%d) called\n", tty->index);
 
 	spin_lock_irqsave(&port->lock, flags);
-	uart_circ_clear(&state->xmit);
+	kfifo_reset(&state->xmit_fifo);
 	if (port->ops->flush_buffer)
 		port->ops->flush_buffer(port);
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -899,7 +855,7 @@ static int uart_get_lsr_info(struct tty_struct *tty,
 	 * interrupt happens).
 	 */
 	if (uport->x_char ||
-	    ((uart_circ_chars_pending(&state->xmit) > 0) &&
+	    ((!kfifo_is_empty(&state->xmit_fifo)) &&
 	     !tty->stopped && !tty->hw_stopped))
 		result &= ~TIOCSER_TEMT;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 41603d6..cf07aa7 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -206,7 +206,7 @@
 
 #include <linux/compiler.h>
 #include <linux/interrupt.h>
-#include <linux/circ_buf.h>
+#include <linux/kfifo.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/tty.h>
@@ -375,7 +375,7 @@ struct uart_state {
 	struct tty_port		port;
 
 	int			pm_state;
-	struct circ_buf		xmit;
+	struct kfifo		xmit_fifo;
 
 	struct tasklet_struct	tlet;
 	struct uart_port	*uart_port;
-- 
1.7.3.2

