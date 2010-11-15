From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [RFC PATCH 4/4] serial: use kfifo instead of circ_buf for SGI IOC controllers
Date: Mon, 15 Nov 2010 16:01:05 -0500
Message-ID: <1289854865-11865-5-git-send-email-wfp5p@virginia.edu>
References: <1289854865-11865-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:57505 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758430Ab0KOVJt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Nov 2010 16:09:49 -0500
In-Reply-To: <1289854865-11865-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Not tested!

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 drivers/serial/ioc3_serial.c |   32 +++++++++++---------------------
 drivers/serial/ioc4_serial.c |   32 +++++++++++---------------------
 2 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/drivers/serial/ioc3_serial.c b/drivers/serial/ioc3_serial.c
index ee43efc..109369a 100644
--- a/drivers/serial/ioc3_serial.c
+++ b/drivers/serial/ioc3_serial.c
@@ -893,9 +893,9 @@ static int ioc3_set_proto(struct ioc3_port *port, int proto)
  */
 static void transmit_chars(struct uart_port *the_port)
 {
-	int xmit_count, tail, head;
+	int len;
 	int result;
-	char *start;
+	u8 iobuf[16];
 	struct tty_struct *tty;
 	struct ioc3_port *port = get_ioc3_port(the_port);
 	struct uart_state *state;
@@ -908,35 +908,25 @@ static void transmit_chars(struct uart_port *the_port)
 	state = the_port->state;
 	tty = state->port.tty;
 
-	if (uart_circ_empty(&state->xmit) || uart_tx_stopped(the_port)) {
+	if (kfifo_is_empty(&state->xmit_fifo) || uart_tx_stopped(the_port)) {
 		/* Nothing to do or hw stopped */
 		set_notification(port, N_ALL_OUTPUT, 0);
 		return;
 	}
 
-	head = state->xmit.head;
-	tail = state->xmit.tail;
-	start = (char *)&state->xmit.buf[tail];
-
 	/* write out all the data or until the end of the buffer */
-	xmit_count = (head < tail) ? (UART_XMIT_SIZE - tail) : (head - tail);
-	if (xmit_count > 0) {
-		result = do_write(port, start, xmit_count);
-		if (result > 0) {
-			/* booking */
-			xmit_count -= result;
+	while (!kfifo_is_empty(&state->xmit_fifo)) {
+		len = kfifo_out(&state->xmit_fifo, iobuf, 16);
+		result = do_write(port, start, len);
+		if (result > 0)
 			the_port->icount.tx += result;
-			/* advance the pointers */
-			tail += result;
-			tail &= UART_XMIT_SIZE - 1;
-			state->xmit.tail = tail;
-			start = (char *)&state->xmit.buf[tail];
-		}
 	}
-	if (uart_circ_chars_pending(&state->xmit) < WAKEUP_CHARS)
+
+	len = kfifo_len(&state->xmit_fifo);
+	if (len  < WAKEUP_CHARS)
 		uart_write_wakeup(the_port);
 
-	if (uart_circ_empty(&state->xmit)) {
+	if (kfifo_is_empty(&state->xmit_fifo)) {
 		set_notification(port, N_OUTPUT_LOWAT, 0);
 	} else {
 		set_notification(port, N_OUTPUT_LOWAT, 1);
diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
index fcfe826..f72cb7b 100644
--- a/drivers/serial/ioc4_serial.c
+++ b/drivers/serial/ioc4_serial.c
@@ -1623,9 +1623,9 @@ static int ioc4_set_proto(struct ioc4_port *port, int proto)
  */
 static void transmit_chars(struct uart_port *the_port)
 {
-	int xmit_count, tail, head;
+	int len;
 	int result;
-	char *start;
+	u8 iobuf[16];
 	struct tty_struct *tty;
 	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 	struct uart_state *state;
@@ -1638,35 +1638,25 @@ static void transmit_chars(struct uart_port *the_port)
 	state = the_port->state;
 	tty = state->port.tty;
 
-	if (uart_circ_empty(&state->xmit) || uart_tx_stopped(the_port)) {
+	if (kfifo_is_empty(&state->xmit_fifo) || uart_tx_stopped(the_port)) {
 		/* Nothing to do or hw stopped */
 		set_notification(port, N_ALL_OUTPUT, 0);
 		return;
 	}
 
-	head = state->xmit.head;
-	tail = state->xmit.tail;
-	start = (char *)&state->xmit.buf[tail];
-
 	/* write out all the data or until the end of the buffer */
-	xmit_count = (head < tail) ? (UART_XMIT_SIZE - tail) : (head - tail);
-	if (xmit_count > 0) {
-		result = do_write(port, start, xmit_count);
-		if (result > 0) {
-			/* booking */
-			xmit_count -= result;
+	while (!kfifo_is_empty(&state->xmit_fifo)) {
+		len = kfifo_out(&state->xmit_fifo, iobuf, 16);
+		result = do_write(port, start, len);
+		if (result > 0)
 			the_port->icount.tx += result;
-			/* advance the pointers */
-			tail += result;
-			tail &= UART_XMIT_SIZE - 1;
-			state->xmit.tail = tail;
-			start = (char *)&state->xmit.buf[tail];
-		}
 	}
-	if (uart_circ_chars_pending(&state->xmit) < WAKEUP_CHARS)
+
+	len = kfifo_len(&state->xmit_fifo);
+	if (len  < WAKEUP_CHARS)
 		uart_write_wakeup(the_port);
 
-	if (uart_circ_empty(&state->xmit)) {
+	if (kfifo_is_empty(&state->xmit_fifo)) {
 		set_notification(port, N_OUTPUT_LOWAT, 0);
 	} else {
 		set_notification(port, N_OUTPUT_LOWAT, 1);
-- 
1.7.3.2

