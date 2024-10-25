Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF11F80D8;
	Fri, 25 Oct 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853856; cv=none; b=Ot48Mr3e1yBzSRiJsBHoZ03z71PlmCH2e3Iotl/hvp2a8J5UQSh/Qt1B6w5OK/bsYeq/mLr88Pu30GOXN93SBvPmbMJBgjicN0BIHQQvQR7sSPfc+K2RBqB4Z6rsCW1vEK1bfNWwaXK4q/RXtUbsCF+Vc7gNaw8yV+of5VjTDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853856; c=relaxed/simple;
	bh=vXRWkgXiczn96x/I0cfbeAy+ExITWcvoS1QIlW3Lt1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZSZw8K0gQL1X3xvY+PnnasGx8cCAN5VICMJ669bKGM48MWdRQer/CsaynrLtdOQS39I5p9K8bYHXwyL1qS7KQUbmuNfRhwvZ2NNrXLHBApi4A3vKAsv1Vm2u0Ft4B37nB8XKmVl2+xayzy7FesxbSV8cD1ySlzDFPi0pcnBxog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=slrwLbOG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Ai98LwU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="slrwLbOG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Ai98LwU"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729853852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4tycoxXMZP2qAEgVyWrz9W3wqW1U06QeuS7WtgHLseQ=;
	b=slrwLbOGv/F1VYgap0ous/jqd4LPXjiFrtb3BPBmMYFkSuDjBh2mFPfkGJq8sK8x4nmjx0
	xFB9z/WVqzVLbBRThpuzYmmOBp608Huy6bcjs7jh81z2Sl3VXw73z12YkTfTQWR6dL4z8n
	OQv9j8/0lhf9zs3KKpUwRpaYQJ4L0GUpPkDlpClY7+Q8CF4hYfLQuR4hRjfesw/EU5Toau
	C3NM22ABiGRgs7ijV/HSzw8SUAn7RJ/2Y9vcFsEnpboXYztmNXVccx6aNISD/9bGUpvNy3
	sdt6SL5ml+TsDGGlv8HVFHQUeoI8VUf0jQA6Ki5j1mAIAzbgFTsRAKoLGzaF+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729853852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4tycoxXMZP2qAEgVyWrz9W3wqW1U06QeuS7WtgHLseQ=;
	b=6Ai98LwU1yRYVVR8VovVPP2dQVZbVhhWcHFPpUNgmaYbyJCHM0FfZyU778L/xjXWeBhio3
	y13LfZg0w+N6aLAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Wahren <wahrenst@gmx.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty-next v3 4/6] serial: 8250: Specify console context for rs485_start/stop_tx
Date: Fri, 25 Oct 2024 13:03:26 +0206
Message-Id: <20241025105728.602310-5-john.ogness@linutronix.de>
In-Reply-To: <20241025105728.602310-1-john.ogness@linutronix.de>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For RS485 mode, if SER_RS485_RX_DURING_TX is not available, the
console write callback needs to enable/disable TX. It does this
by calling the rs485_start/stop_tx() callbacks. However, these
callbacks will disable/enable interrupts, which is a problem
for console write, as it must be responsible for
disabling/enabling interrupts.

Add an argument @in_con to the rs485_start/stop_tx() callbacks
to specify if they are being called from console write. If so,
the callbacks will not handle interrupt disabling/enabling.

For all call sites other than console write, there is no
functional change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250.h            |  4 +--
 drivers/tty/serial/8250/8250_bcm2835aux.c |  4 +--
 drivers/tty/serial/8250/8250_omap.c       |  2 +-
 drivers/tty/serial/8250/8250_port.c       | 34 +++++++++++++++--------
 include/linux/serial_8250.h               |  4 +--
 5 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index e5310c65cf52..0d8717be0df7 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -231,8 +231,8 @@ void serial8250_rpm_put_tx(struct uart_8250_port *p);
 
 int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
 			    struct serial_rs485 *rs485);
-void serial8250_em485_start_tx(struct uart_8250_port *p);
-void serial8250_em485_stop_tx(struct uart_8250_port *p);
+void serial8250_em485_start_tx(struct uart_8250_port *p, bool in_con);
+void serial8250_em485_stop_tx(struct uart_8250_port *p, bool in_con);
 void serial8250_em485_destroy(struct uart_8250_port *p);
 extern struct serial_rs485 serial8250_em485_supported;
 
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index fdb53b54e99e..c9a106a86b56 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -46,7 +46,7 @@ struct bcm2835aux_data {
 	u32 cntl;
 };
 
-static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
+static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up, bool in_con)
 {
 	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
 		struct bcm2835aux_data *data = dev_get_drvdata(up->port.dev);
@@ -65,7 +65,7 @@ static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
 		serial8250_out_MCR(up, UART_MCR_RTS);
 }
 
-static void bcm2835aux_rs485_stop_tx(struct uart_8250_port *up)
+static void bcm2835aux_rs485_stop_tx(struct uart_8250_port *up, bool in_con)
 {
 	if (up->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
 		serial8250_out_MCR(up, 0);
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index b3be0fb184a3..fcbed7e98231 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -365,7 +365,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 
 	if (up->port.rs485.flags & SER_RS485_ENABLED &&
 	    up->port.rs485_config == serial8250_em485_config)
-		serial8250_em485_stop_tx(up);
+		serial8250_em485_stop_tx(up, false);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 09ac521d232a..7c50387194ad 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -558,7 +558,7 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 
 deassert_rts:
 	if (p->em485->tx_stopped)
-		p->rs485_stop_tx(p);
+		p->rs485_stop_tx(p, false);
 
 	return 0;
 }
@@ -1398,10 +1398,11 @@ static void serial8250_stop_rx(struct uart_port *port)
 /**
  * serial8250_em485_stop_tx() - generic ->rs485_stop_tx() callback
  * @p: uart 8250 port
+ * @in_con: true if called from console write, otherwise false
  *
  * Generic callback usable by 8250 uart drivers to stop rs485 transmission.
  */
-void serial8250_em485_stop_tx(struct uart_8250_port *p)
+void serial8250_em485_stop_tx(struct uart_8250_port *p, bool in_con)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
@@ -1419,7 +1420,9 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
 		serial8250_clear_and_reinit_fifos(p);
 
-		__serial8250_start_rx_int(p);
+		/* In console context, caller handles interrupt enabling. */
+		if (!in_con)
+			__serial8250_start_rx_int(p);
 	}
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
@@ -1434,7 +1437,7 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	serial8250_rpm_get(p);
 	uart_port_lock_irqsave(&p->port, &flags);
 	if (em485->active_timer == &em485->stop_tx_timer) {
-		p->rs485_stop_tx(p);
+		p->rs485_stop_tx(p, false);
 		em485->active_timer = NULL;
 		em485->tx_stopped = true;
 	}
@@ -1466,7 +1469,7 @@ static void __stop_tx_rs485(struct uart_8250_port *p, u64 stop_delay)
 		em485->active_timer = &em485->stop_tx_timer;
 		hrtimer_start(&em485->stop_tx_timer, ns_to_ktime(stop_delay), HRTIMER_MODE_REL);
 	} else {
-		p->rs485_stop_tx(p);
+		p->rs485_stop_tx(p, false);
 		em485->active_timer = NULL;
 		em485->tx_stopped = true;
 	}
@@ -1555,6 +1558,7 @@ static inline void __start_tx(struct uart_port *port)
 /**
  * serial8250_em485_start_tx() - generic ->rs485_start_tx() callback
  * @up: uart 8250 port
+ * @in_con: true if called from console write, otherwise false
  *
  * Generic callback usable by 8250 uart drivers to start rs485 transmission.
  * Assumes that setting the RTS bit in the MCR register means RTS is high.
@@ -1562,12 +1566,20 @@ static inline void __start_tx(struct uart_port *port)
  * stoppable by disabling the UART_IER_RDI interrupt.  (Some chips set the
  * UART_LSR_DR bit even when UART_IER_RDI is disabled, foiling this approach.)
  */
-void serial8250_em485_start_tx(struct uart_8250_port *up)
+void serial8250_em485_start_tx(struct uart_8250_port *up, bool in_con)
 {
 	unsigned char mcr = serial8250_in_MCR(up);
 
-	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
-		serial8250_stop_rx(&up->port);
+	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
+		/*
+		 * In console context, caller handles interrupt disabling. So
+		 * only LSR_DR masking is needed.
+		 */
+		if (in_con)
+			__serial8250_stop_rx_mask_dr(&up->port);
+		else
+			serial8250_stop_rx(&up->port);
+	}
 
 	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
 		mcr |= UART_MCR_RTS;
@@ -1600,7 +1612,7 @@ static bool start_tx_rs485(struct uart_port *port)
 	if (em485->tx_stopped) {
 		em485->tx_stopped = false;
 
-		up->rs485_start_tx(up);
+		up->rs485_start_tx(up, false);
 
 		if (up->port.rs485.delay_rts_before_send > 0) {
 			em485->active_timer = &em485->start_tx_timer;
@@ -3402,7 +3414,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	if (em485) {
 		if (em485->tx_stopped)
-			up->rs485_start_tx(up);
+			up->rs485_start_tx(up, true);
 		mdelay(port->rs485.delay_rts_before_send);
 	}
 
@@ -3440,7 +3452,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (em485) {
 		mdelay(port->rs485.delay_rts_after_send);
 		if (em485->tx_stopped)
-			up->rs485_stop_tx(up);
+			up->rs485_stop_tx(up, true);
 	}
 
 	serial_port_out(port, UART_IER, ier);
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index e0717c8393d7..c25c026d173d 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -161,8 +161,8 @@ struct uart_8250_port {
 	void			(*dl_write)(struct uart_8250_port *up, u32 value);
 
 	struct uart_8250_em485 *em485;
-	void			(*rs485_start_tx)(struct uart_8250_port *);
-	void			(*rs485_stop_tx)(struct uart_8250_port *);
+	void			(*rs485_start_tx)(struct uart_8250_port *up, bool in_con);
+	void			(*rs485_stop_tx)(struct uart_8250_port *up, bool in_con);
 
 	/* Serial port overrun backoff */
 	struct delayed_work overrun_backoff;
-- 
2.39.5

