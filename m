From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 40/79] max3110: add sysrq support
Date: Wed, 26 Oct 2011 14:12:45 +0200
Message-ID: <1319631204-23262-40-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32778 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab1JZMNq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:46 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

This patch moves several occurences of similar code inside receive_chars(),
which now also takes care of checking for break and calling sysrq handling
code.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/mrst_max3110.c |   99 ++++++++++++++++---------------------
 drivers/tty/serial/mrst_max3110.h |    1 +
 2 files changed, 44 insertions(+), 56 deletions(-)

diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index c8f9868..42aa439 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -27,6 +27,10 @@
  *    interrupt for a low speed UART device
  */
 
+#ifdef CONFIG_MAGIC_SYSRQ
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
@@ -73,9 +77,9 @@ struct uart_max3110 {
 /* global data structure, may need be removed */
 static struct uart_max3110 *pmax;
 
-static void receive_chars(struct uart_max3110 *max,
-				unsigned char *str, int len);
-static int max3110_read_multi(struct uart_max3110 *max, u8 *buf);
+static int receive_chars(struct uart_max3110 *max,
+				unsigned short *str, int len);
+static int max3110_read_multi(struct uart_max3110 *max);
 static void max3110_con_receive(struct uart_max3110 *max);
 
 static int max3110_write_then_read(struct uart_max3110 *max,
@@ -108,7 +112,6 @@ static int max3110_out(struct uart_max3110 *max, const u16 out)
 {
 	void *buf;
 	u16 *obuf, *ibuf;
-	u8  ch;
 	int ret;
 
 	buf = kzalloc(8, GFP_KERNEL | GFP_DMA);
@@ -125,11 +128,7 @@ static int max3110_out(struct uart_max3110 *max, const u16 out)
 		goto exit;
 	}
 
-	/* If some valid data is read back */
-	if (*ibuf & MAX3110_READ_DATA_AVAILABLE) {
-		ch = *ibuf & 0xff;
-		receive_chars(max, &ch, 1);
-	}
+	receive_chars(max, ibuf, 1);
 
 exit:
 	kfree(buf);
@@ -142,12 +141,11 @@ exit:
  *
  * Return how many valide bytes are read back
  */
-static int max3110_read_multi(struct uart_max3110 *max, u8 *rxbuf)
+static int max3110_read_multi(struct uart_max3110 *max)
 {
 	void *buf;
 	u16 *obuf, *ibuf;
-	u8 *pbuf, valid_str[M3110_RX_FIFO_DEPTH];
-	int i, j, blen;
+	int ret, blen;
 
 	blen = M3110_RX_FIFO_DEPTH * sizeof(u16);
 	buf = kzalloc(blen * 2, GFP_KERNEL | GFP_DMA);
@@ -165,19 +163,10 @@ static int max3110_read_multi(struct uart_max3110 *max, u8 *rxbuf)
 		return 0;
 	}
 
-	/* If caller doesn't provide a buffer, then handle received char */
-	pbuf = rxbuf ? rxbuf : valid_str;
-
-	for (i = 0, j = 0; i < M3110_RX_FIFO_DEPTH; i++) {
-		if (ibuf[i] & MAX3110_READ_DATA_AVAILABLE)
-			pbuf[j++] = ibuf[i] & 0xff;
-	}
-
-	if (j && (pbuf == valid_str))
-		receive_chars(max, valid_str, j);
+	ret = receive_chars(max, ibuf, M3110_RX_FIFO_DEPTH);
 
 	kfree(buf);
-	return j;
+	return ret;
 }
 
 static void serial_m3110_con_putchar(struct uart_port *port, int ch)
@@ -276,8 +265,7 @@ static void send_circ_buf(struct uart_max3110 *max,
 {
 	void *buf;
 	u16 *obuf, *ibuf;
-	u8 valid_str[WORDS_PER_XFER];
-	int i, j, len, blen, dma_size, left, ret = 0;
+	int i, len, blen, dma_size, left, ret = 0;
 
 
 	dma_size = WORDS_PER_XFER * sizeof(u16) * 2;
@@ -307,13 +295,7 @@ static void send_circ_buf(struct uart_max3110 *max,
 				pr_warning(PR_FMT "%s(): get err msg %d\n",
 						__func__, ret);
 
-			for (i = 0, j = 0; i < len; i++) {
-				if (ibuf[i] & MAX3110_READ_DATA_AVAILABLE)
-					valid_str[j++] = ibuf[i] & 0xff;
-			}
-
-			if (j)
-				receive_chars(max, valid_str, j);
+			receive_chars(max, ibuf, len);
 
 			max->port.icount.tx += len;
 			left -= len;
@@ -353,30 +335,48 @@ static void serial_m3110_start_tx(struct uart_port *port)
 		wake_up(&max->wq);
 }
 
-static void receive_chars(struct uart_max3110 *max, unsigned char *str, int len)
+static int
+receive_chars(struct uart_max3110 *max, unsigned short *str, int len)
 {
 	struct uart_port *port = &max->port;
 	struct tty_struct *tty;
-	int usable;
+	char buf[M3110_RX_FIFO_DEPTH];
+	int r, w, usable;
 
 	/* If uart is not opened, just return */
 	if (!port->state)
-		return;
+		return 0;
 
 	tty = port->state->port.tty;
 	if (!tty)
-		return;
+		return 0;
+
+	for (r = 0, w = 0; r < len; r++) {
+		if (str[r] & MAX3110_BREAK &&
+		    uart_handle_break(port))
+			continue;
+
+		if (str[r] & MAX3110_READ_DATA_AVAILABLE) {
+			if (uart_handle_sysrq_char(port, str[r] & 0xff))
+				continue;
+
+			buf[w++] = str[r] & 0xff;
+		}
+	}
 
-	while (len) {
-		usable = tty_buffer_request_room(tty, len);
+	if (!w)
+		return 0;
+
+	for (r = 0; w; r += usable, w -= usable) {
+		usable = tty_buffer_request_room(tty, w);
 		if (usable) {
-			tty_insert_flip_string(tty, str, usable);
-			str += usable;
+			tty_insert_flip_string(tty, buf + r, usable);
 			port->icount.rx += usable;
 		}
-		len -= usable;
 	}
 	tty_flip_buffer_push(tty);
+
+	return r;
 }
 
 /*
@@ -391,28 +391,15 @@ static void receive_chars(struct uart_max3110 *max, unsigned char *str, int len)
  */
 static void max3110_con_receive(struct uart_max3110 *max)
 {
-	int loop = 1, num, total = 0;
-	u8 recv_buf[512], *pbuf;
+	int loop = 1, num;
 
-	pbuf = recv_buf;
 	do {
-		num = max3110_read_multi(max, pbuf);
+		num = max3110_read_multi(max);
 
 		if (num) {
 			loop = 5;
-			pbuf += num;
-			total += num;
-
-			if (total >= 504) {
-				receive_chars(max, recv_buf, total);
-				pbuf = recv_buf;
-				total = 0;
-			}
 		}
 	} while (--loop);
-
-	if (total)
-		receive_chars(max, recv_buf, total);
 }
 
 static int max3110_main_thread(void *_max)
diff --git a/drivers/tty/serial/mrst_max3110.h b/drivers/tty/serial/mrst_max3110.h
index c37ea48..35af073 100644
--- a/drivers/tty/serial/mrst_max3110.h
+++ b/drivers/tty/serial/mrst_max3110.h
@@ -7,6 +7,7 @@
 /* status bits for all 4 MAX3110 operate modes */
 #define MAX3110_READ_DATA_AVAILABLE	(1 << 15)
 #define MAX3110_WRITE_BUF_EMPTY		(1 << 14)
+#define MAX3110_BREAK			(1 << 10)
 
 #define WC_TAG			(3 << 14)
 #define RC_TAG			(1 << 14)
-- 
1.7.7

