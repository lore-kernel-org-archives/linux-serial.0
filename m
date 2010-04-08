From: Christian Pellegrin <chripell@fsfe.org>
Subject: [PATCH -mm 1/1] max3100: Fixes for the MAX31x0 console
Date: Thu,  8 Apr 2010 19:02:32 +0200
Message-ID: <1270746152-25250-1-git-send-email-chripell@fsfe.org>
References: <g2qcabda6421004081002o97fec27fx1cc4640164930608@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:48902 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653Ab0DHRFN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Apr 2010 13:05:13 -0400
Received: by ewy20 with SMTP id 20so1084697ewy.1
        for <linux-serial@vger.kernel.org>; Thu, 08 Apr 2010 10:05:11 -0700 (PDT)
In-Reply-To: <g2qcabda6421004081002o97fec27fx1cc4640164930608@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@linux-foundation.org, feng.tang@intel.com, grant.likely@secretlab.ca, alan@lxorguk.ukuu.org.uk, linux-serial@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Cc: Christian Pellegrin <chripell@fsfe.org>

This patch fixes problems reported about the MAX31x0 console. RTS is
asserted only if flow control is explicitly enabled on kernel command
line. Chars inputed during console output are not lost.

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 drivers/serial/max3100.c |   48 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/max3100.c b/drivers/serial/max3100.c
index 6644222..c7def2f 100644
--- a/drivers/serial/max3100.c
+++ b/drivers/serial/max3100.c
@@ -147,6 +147,8 @@ struct max3100_port {
 	struct work_struct console_work;
 	/* char tx timeout */
 	int console_tout;
+	/* lock on receiving chars */
+	struct mutex rx_lock;
 #endif
 };
 
@@ -192,6 +194,19 @@ static void max3100_calc_parity(struct max3100_port *s, u16 *c)
 		*c |= max3100_do_parity(s, *c) << 8;
 }
 
+static void max3100_flip(struct max3100_port *s)
+{
+	if (s->port.state->port.tty != NULL) {
+#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
+		mutex_lock(&s->rx_lock);
+#endif
+		tty_flip_buffer_push(s->port.state->port.tty);
+#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
+		mutex_unlock(&s->rx_lock);
+#endif
+	}
+}
+
 static void max3100_resume_work(struct work_struct *w)
 {
 	struct max3100_port *s = container_of(w, struct max3100_port,
@@ -242,6 +257,10 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
 	unsigned int ch, flg, status = 0;
 	int ret = 0, cts;
 
+#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
+	mutex_lock(&s->rx_lock);
+#endif
+
 	if (rx & MAX3100_R && s->rx_enabled) {
 		dev_dbg(&s->spi->dev, "%s\n", __func__);
 		ch = rx & (s->parity & MAX3100_7BIT ? 0x7f : 0xff);
@@ -274,6 +293,10 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
 		uart_handle_cts_change(&s->port, cts ? TIOCM_CTS : 0);
 	}
 
+#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
+	mutex_unlock(&s->rx_lock);
+#endif
+
 	return ret;
 }
 
@@ -329,8 +352,8 @@ static irqreturn_t max3100_ist(int irq, void *dev_id)
 			}
 		}
 
-		if (rxchars > 16 && s->port.state->port.tty != NULL) {
-			tty_flip_buffer_push(s->port.state->port.tty);
+		if (rxchars > 16) {
+			max3100_flip(s);
 			rxchars = 0;
 		}
 		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -341,8 +364,8 @@ static irqreturn_t max3100_ist(int irq, void *dev_id)
 		  (!uart_circ_empty(xmit) &&
 		   !uart_tx_stopped(&s->port))));
 
-	if (rxchars > 0 && s->port.state->port.tty != NULL)
-		tty_flip_buffer_push(s->port.state->port.tty);
+	if (rxchars > 0)
+		max3100_flip(s);
 
 	return IRQ_HANDLED;
 }
@@ -699,6 +722,7 @@ static void max3100_console_work(struct work_struct *w)
 					      console_work);
 	unsigned long start;
 	u16 tx, rx;
+	int rxchars = 0;
 
 	while (s->console_head != s->console_tail &&
 	       (s->console_flags & MAX3100_SUSPENDING) == 0) {
@@ -710,10 +734,19 @@ static void max3100_console_work(struct work_struct *w)
 			 !time_after(jiffies, start + s->console_tout));
 		tx = s->console_buf[s->console_tail];
 		max3100_calc_parity(s, &tx);
-		tx |= MAX3100_WD | MAX3100_RTS;
+		tx |= MAX3100_WD | (s->rts ? MAX3100_RTS : 0);
 		max3100_sr(s, tx, &rx);
+		if (s->port.state->port.tty != NULL) {
+			rxchars += max3100_handlerx(s, rx);
+			if (rxchars > 16) {
+				max3100_flip(s);
+				rxchars = 0;
+			}
+		}
 		s->console_tail = (s->console_tail + 1) % CONSOLE_BUF_SIZE;
 	}
+	if (rxchars)
+		max3100_flip(s);
 }
 
 static void max3100_console_putchar(struct uart_port *port, int ch)
@@ -809,6 +842,10 @@ static int max3100_console_setup(struct console *co, char *options)
 	if (parity == 'o')
 		s->parity |= MAX3100_PARITY_ODD;
 	s->console_tout = 1 + (20 * HZ) / baud; /* jiffies to send 20 bits */
+	if (flow != 'n')
+		s->rts = 1;
+	else
+		s->rts = 0;
 
 	tx |= MAX3100_WC;
 	max3100_sr(s, tx, &rx);
@@ -912,6 +949,7 @@ static int __devinit max3100_probe(struct spi_device *spi)
 			 i, retval);
 
 #ifdef CONFIG_SERIAL_MAX3100_CONSOLE
+	mutex_init(&max3100s[i]->rx_lock);
 	if (pdata->console && !max3100_console_registered) {
 		register_console(&max3100_console);
 		max3100_console_registered = 1;
-- 
1.5.6.5

