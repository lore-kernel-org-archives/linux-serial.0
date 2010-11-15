From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [RFC PATCH 2/4] serial: use kfifo instead of circ_buf in mrst_max3110
Date: Mon, 15 Nov 2010 16:01:03 -0500
Message-ID: <1289854865-11865-3-git-send-email-wfp5p@virginia.edu>
References: <1289854865-11865-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:57504 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758396Ab0KOVJt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Nov 2010 16:09:49 -0500
In-Reply-To: <1289854865-11865-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Compile tested only.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 drivers/serial/mrst_max3110.c |   45 ++++++++++++++++++----------------------
 1 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/serial/mrst_max3110.c b/drivers/serial/mrst_max3110.c
index b62857b..7cba9db 100644
--- a/drivers/serial/mrst_max3110.c
+++ b/drivers/serial/mrst_max3110.c
@@ -67,7 +67,7 @@ struct uart_max3110 {
 	unsigned long uart_flags;
 
 	/* console related */
-	struct circ_buf con_xmit;
+	struct kfifo con_xmit;
 };
 
 /* global data structure, may need be removed */
@@ -184,12 +184,11 @@ static void serial_m3110_con_putchar(struct uart_port *port, int ch)
 {
 	struct uart_max3110 *max =
 		container_of(port, struct uart_max3110, port);
-	struct circ_buf *xmit = &max->con_xmit;
+	struct kfifo *xmit = &max->con_xmit;
+
+	if (kfifo_avail(xmit))
+		kfifo_in(xmit, &ch, sizeof(ch));
 
-	if (uart_circ_chars_free(xmit)) {
-		xmit->buf[xmit->head] = (char)ch;
-		xmit->head = (xmit->head + 1) & (PAGE_SIZE - 1);
-	}
 }
 
 /*
@@ -272,11 +271,12 @@ static void serial_m3110_stop_rx(struct uart_port *port)
 
 #define WORDS_PER_XFER	128
 static void send_circ_buf(struct uart_max3110 *max,
-				struct circ_buf *xmit)
+			  struct kfifo *xmit)
 {
 	void *buf;
 	u16 *obuf, *ibuf;
 	u8 valid_str[WORDS_PER_XFER];
+	u8 c;
 	int i, j, len, blen, dma_size, left, ret = 0;
 
 
@@ -287,17 +287,16 @@ static void send_circ_buf(struct uart_max3110 *max,
 	obuf = buf;
 	ibuf = buf + dma_size/2;
 
-	while (!uart_circ_empty(xmit)) {
-		left = uart_circ_chars_pending(xmit);
+	while (!kfifo_is_empty(xmit)) {
+		left = kfifo_len(xmit);
 		while (left) {
 			len = min(left, WORDS_PER_XFER);
 			blen = len * sizeof(u16);
 			memset(ibuf, 0, blen);
 
 			for (i = 0; i < len; i++) {
-				obuf[i] = (u8)xmit->buf[xmit->tail] | WD_TAG;
-				xmit->tail = (xmit->tail + 1) &
-						(UART_XMIT_SIZE - 1);
+				ret = kfifo_out(xmit, &c, 1);
+				obuf[i] = c | WD_TAG;
 			}
 
 			/* Fail to send msg to console is not very critical */
@@ -325,17 +324,17 @@ static void send_circ_buf(struct uart_max3110 *max,
 static void transmit_char(struct uart_max3110 *max)
 {
 	struct uart_port *port = &max->port;
-	struct circ_buf *xmit = &port->state->xmit;
+	struct kfifo *xmit = &port->state->xmit_fifo;
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (kfifo_is_empty(xmit) || uart_tx_stopped(port))
 		return;
 
 	send_circ_buf(max, xmit);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	if (kfifo_len(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	if (uart_circ_empty(xmit))
+	if (kfifo_is_empty(xmit))
 		serial_m3110_stop_tx(port);
 }
 
@@ -419,7 +418,7 @@ static int max3110_main_thread(void *_max)
 	struct uart_max3110 *max = _max;
 	wait_queue_head_t *wq = &max->wq;
 	int ret = 0;
-	struct circ_buf *xmit = &max->con_xmit;
+	struct kfifo *xmit = &max->con_xmit;
 
 	init_waitqueue_head(wq);
 	pr_info(PR_FMT "start main thread\n");
@@ -784,7 +783,6 @@ static int serial_m3110_resume(struct spi_device *spi)
 static int __devinit serial_m3110_probe(struct spi_device *spi)
 {
 	struct uart_max3110 *max;
-	void *buffer;
 	u16 res;
 	int ret = 0;
 
@@ -829,14 +827,11 @@ static int __devinit serial_m3110_probe(struct spi_device *spi)
 		goto err_get_page;
 	}
 
-	buffer = (void *)__get_free_page(GFP_KERNEL);
-	if (!buffer) {
+	ret = kfifo_alloc(&max->con_xmit, PAGE_SIZE, GFP_KERNEL);
+	if (ret) {
 		ret = -ENOMEM;
 		goto err_get_page;
 	}
-	max->con_xmit.buf = buffer;
-	max->con_xmit.head = 0;
-	max->con_xmit.tail = 0;
 
 	max->main_thread = kthread_run(max3110_main_thread,
 					max, "max3110_main");
@@ -855,7 +850,7 @@ static int __devinit serial_m3110_probe(struct spi_device *spi)
 	return 0;
 
 err_kthread:
-	free_page((unsigned long)buffer);
+	kfifo_free(&max->con_xmit);
 err_get_page:
 	kfree(max);
 	return ret;
@@ -870,7 +865,7 @@ static int __devexit serial_m3110_remove(struct spi_device *dev)
 
 	uart_remove_one_port(&serial_m3110_reg, &max->port);
 
-	free_page((unsigned long)max->con_xmit.buf);
+	kfifo_free(&max->con_xmit);
 
 	if (max->main_thread)
 		kthread_stop(max->main_thread);
-- 
1.7.3.2

