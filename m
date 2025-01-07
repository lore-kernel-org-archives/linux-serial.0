Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60511F7574;
	Tue,  7 Jan 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285230; cv=none; b=seeOjyWxvW1mXePxEd3xN/QDZMlrlMX/DE4WymQebb0LVMYbiSDr/gNN9EBE/dMkXOqFMu3PUbX0Elxesrhxn/jXCh6UgOAKQEaXLblg6aXegYPwJbJFgRBe9zTL+w7B8wUq/JLQAKg4xX3VjrP1FTXIkorngzCSXnnxDEoVjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285230; c=relaxed/simple;
	bh=xoEKJl7W1y0MwDU9yqj3w6HHZd25I6yetBuQMwqyHOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVWcsTn6lJ2na4VCiIe8hIk9PYnJb00AaW3rqsRKOM3LZSoCqq0HMqTP4dK4+elBuvAfvJ4EfLWn5zC04j8w2Z+hr1C+oNanIGyUr4G1d14BliD0XosAQBtgzxDLEZ4c8fr1xD6ycC7cq084jg+PodByNulSX6IXNMrhfFKyyu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=afi5bwTI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6zm8OTot; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="afi5bwTI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6zm8OTot"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736285225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+C20CE/6jV0p4sUYOQkXzzELl/Lbh4IHLGETviL3Hbg=;
	b=afi5bwTI933XJ2JWDC8sQBjxiwmolsU8jhrE/Q4hXIeVdYPvsO5EtQkS84XXeKZPAxRvzK
	LX1XbwkGMGBCHupuQXlNqni3wMiQ37yIgc9bKFtOGNSvCozmUeyg6cjeJ5HSe9Tyv1KbXi
	SQOXTYskM6mPuD3RpzjUB5exKfar4tRj2aspufqEBNRMpnEOtULfXtAw91Z1HWF5AjGosn
	uLlGFoX5Lv2IgqaoLjNVrlNLjUR+YX4CDj703TBBzHcdbg+gqdf4F3lFzCsTk6jLrvGUrh
	E8pi8w7JRdT2kYEa3RyXaaBmhBnLUpy3/TTQYf1LagQg2FI9Q+zkCXuDhCelJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736285225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+C20CE/6jV0p4sUYOQkXzzELl/Lbh4IHLGETviL3Hbg=;
	b=6zm8OTot0Vxq9xDFz1fpcViI67qsrgHkIuciMnAkk1o+gQ5SbM3eP8vVCwCyg7I/ykdTP4
	M1a7AZ9TecTaMxCQ==
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
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Wahren <wahrenst@gmx.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty-next v5 4/6] serial: 8250: Provide flag for IER toggling for RS485
Date: Tue,  7 Jan 2025 22:33:00 +0106
Message-Id: <20250107212702.169493-5-john.ogness@linutronix.de>
In-Reply-To: <20250107212702.169493-1-john.ogness@linutronix.de>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For RS485 mode, if SER_RS485_RX_DURING_TX is not available, the
console ->write() callback needs to enable/disable Tx. It does
this by calling the ->rs485_start_tx() and ->rs485_stop_tx()
callbacks. However, some of these callbacks also disable/enable
interrupts and makes power management calls. This causes 2
problems for console writing:

1. A console write can occur in contexts that are illegal for
   pm_runtime_*(). It is not even necessary for console writing
   to use pm_runtime_*() because a console already does this in
   serial8250_console_setup() and serial8250_console_exit().

2. The console ->write() callback already handles
   disabling/enabling the interrupts by properly restoring the
   previous IER value.

Add an argument @toggle_ier to the ->rs485_start_tx() and
->rs485_stop_tx() callbacks to specify if they may disable/enable
receive interrupts while using pm_runtime_*(). Console writing
will not allow the toggling.

For all call sites other than console writing there is no
functional change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/8250/8250.h            |  4 ++--
 drivers/tty/serial/8250/8250_bcm2835aux.c |  4 ++--
 drivers/tty/serial/8250/8250_omap.c       |  2 +-
 drivers/tty/serial/8250/8250_port.c       | 26 +++++++++++++----------
 include/linux/serial_8250.h               |  4 ++--
 5 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index e5310c65cf52..11e05aa014e5 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -231,8 +231,8 @@ void serial8250_rpm_put_tx(struct uart_8250_port *p);
 
 int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
 			    struct serial_rs485 *rs485);
-void serial8250_em485_start_tx(struct uart_8250_port *p);
-void serial8250_em485_stop_tx(struct uart_8250_port *p);
+void serial8250_em485_start_tx(struct uart_8250_port *p, bool toggle_ier);
+void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier);
 void serial8250_em485_destroy(struct uart_8250_port *p);
 extern struct serial_rs485 serial8250_em485_supported;
 
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index fdb53b54e99e..0609582a62f7 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -46,7 +46,7 @@ struct bcm2835aux_data {
 	u32 cntl;
 };
 
-static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
+static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up, bool toggle_ier)
 {
 	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
 		struct bcm2835aux_data *data = dev_get_drvdata(up->port.dev);
@@ -65,7 +65,7 @@ static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
 		serial8250_out_MCR(up, UART_MCR_RTS);
 }
 
-static void bcm2835aux_rs485_stop_tx(struct uart_8250_port *up)
+static void bcm2835aux_rs485_stop_tx(struct uart_8250_port *up, bool toggle_ier)
 {
 	if (up->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
 		serial8250_out_MCR(up, 0);
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 42b4aa56b902..c2b75e3f106d 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -365,7 +365,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 
 	if (up->port.rs485.flags & SER_RS485_ENABLED &&
 	    up->port.rs485_config == serial8250_em485_config)
-		serial8250_em485_stop_tx(up);
+		serial8250_em485_stop_tx(up, true);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 15abd95fcf06..d7976a21cca9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -578,7 +578,7 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 
 deassert_rts:
 	if (p->em485->tx_stopped)
-		p->rs485_stop_tx(p);
+		p->rs485_stop_tx(p, true);
 
 	return 0;
 }
@@ -1398,10 +1398,11 @@ static void serial8250_stop_rx(struct uart_port *port)
 /**
  * serial8250_em485_stop_tx() - generic ->rs485_stop_tx() callback
  * @p: uart 8250 port
+ * @toggle_ier: true to allow enabling receive interrupts
  *
  * Generic callback usable by 8250 uart drivers to stop rs485 transmission.
  */
-void serial8250_em485_stop_tx(struct uart_8250_port *p)
+void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
@@ -1422,8 +1423,10 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
 		serial8250_clear_and_reinit_fifos(p);
 
-		p->ier |= UART_IER_RLSI | UART_IER_RDI;
-		serial_port_out(&p->port, UART_IER, p->ier);
+		if (toggle_ier) {
+			p->ier |= UART_IER_RLSI | UART_IER_RDI;
+			serial_port_out(&p->port, UART_IER, p->ier);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
@@ -1438,7 +1441,7 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	serial8250_rpm_get(p);
 	uart_port_lock_irqsave(&p->port, &flags);
 	if (em485->active_timer == &em485->stop_tx_timer) {
-		p->rs485_stop_tx(p);
+		p->rs485_stop_tx(p, true);
 		em485->active_timer = NULL;
 		em485->tx_stopped = true;
 	}
@@ -1470,7 +1473,7 @@ static void __stop_tx_rs485(struct uart_8250_port *p, u64 stop_delay)
 		em485->active_timer = &em485->stop_tx_timer;
 		hrtimer_start(&em485->stop_tx_timer, ns_to_ktime(stop_delay), HRTIMER_MODE_REL);
 	} else {
-		p->rs485_stop_tx(p);
+		p->rs485_stop_tx(p, true);
 		em485->active_timer = NULL;
 		em485->tx_stopped = true;
 	}
@@ -1559,6 +1562,7 @@ static inline void __start_tx(struct uart_port *port)
 /**
  * serial8250_em485_start_tx() - generic ->rs485_start_tx() callback
  * @up: uart 8250 port
+ * @toggle_ier: true to allow disabling receive interrupts
  *
  * Generic callback usable by 8250 uart drivers to start rs485 transmission.
  * Assumes that setting the RTS bit in the MCR register means RTS is high.
@@ -1566,11 +1570,11 @@ static inline void __start_tx(struct uart_port *port)
  * stoppable by disabling the UART_IER_RDI interrupt.  (Some chips set the
  * UART_LSR_DR bit even when UART_IER_RDI is disabled, foiling this approach.)
  */
-void serial8250_em485_start_tx(struct uart_8250_port *up)
+void serial8250_em485_start_tx(struct uart_8250_port *up, bool toggle_ier)
 {
 	unsigned char mcr = serial8250_in_MCR(up);
 
-	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
+	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX) && toggle_ier)
 		serial8250_stop_rx(&up->port);
 
 	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
@@ -1604,7 +1608,7 @@ static bool start_tx_rs485(struct uart_port *port)
 	if (em485->tx_stopped) {
 		em485->tx_stopped = false;
 
-		up->rs485_start_tx(up);
+		up->rs485_start_tx(up, true);
 
 		if (up->port.rs485.delay_rts_before_send > 0) {
 			em485->active_timer = &em485->start_tx_timer;
@@ -3424,7 +3428,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	if (em485) {
 		if (em485->tx_stopped)
-			up->rs485_start_tx(up);
+			up->rs485_start_tx(up, false);
 		mdelay(port->rs485.delay_rts_before_send);
 	}
 
@@ -3462,7 +3466,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (em485) {
 		mdelay(port->rs485.delay_rts_after_send);
 		if (em485->tx_stopped)
-			up->rs485_stop_tx(up);
+			up->rs485_stop_tx(up, false);
 	}
 
 	serial_port_out(port, UART_IER, ier);
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index e0717c8393d7..144de7a7948d 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -161,8 +161,8 @@ struct uart_8250_port {
 	void			(*dl_write)(struct uart_8250_port *up, u32 value);
 
 	struct uart_8250_em485 *em485;
-	void			(*rs485_start_tx)(struct uart_8250_port *);
-	void			(*rs485_stop_tx)(struct uart_8250_port *);
+	void			(*rs485_start_tx)(struct uart_8250_port *up, bool toggle_ier);
+	void			(*rs485_stop_tx)(struct uart_8250_port *up, bool toggle_ier);
 
 	/* Serial port overrun backoff */
 	struct delayed_work overrun_backoff;
-- 
2.39.5

