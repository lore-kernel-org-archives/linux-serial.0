Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F61DB94E;
	Fri, 13 Sep 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236346; cv=none; b=vFEhKOxefOHw/KQ2BFk3Bb9g5iZy7Fvz1RfkHFQnW3Y0mCI7XBqXnL2tMG/XQivzyXG2y8niWAI2JE8xtwBqkjRIPkEJcWG3BpA/Pbjcb/ACjRSw5V261QX0sCVSQIKZ1Um+E+lnCt7ldqww/52Phjs5k7r3JkU8ad+/RWbabh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236346; c=relaxed/simple;
	bh=vy7FDh7ONPzOVel+4x+VAurMui0tfYqeBSQf9+QBcAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ARNPjjz2hHsHSwsBNfANJ/QN5b+Bd4AAA7dThsWWz8rCXnHhnkpPUKYyUnSZqHEE+lUfsYJZFY3LbYNgfVX/G9aJlMb7Dv/JuEeAoDzBCgengQyxgWJU1ybkErq6QdbDd/Obmwxb6037db5lCYjRMnjSIdP5BJgNPbO2UFby6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UG6Uips7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4oR+/q8L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UG6Uips7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4oR+/q8L"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726236341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiGBWq4TbC9YpmLgN+63GvyKHjjpCb6BuHISr4eHJzI=;
	b=UG6Uips7GTBkxyDY8+Zxbbs4P7EyaDAY+9RSA14yZLfMXnsYHcJxqpqzoaFYEwi8Tuishe
	clnrMfSRP00rjN9i7g9btJOJeQo2XcyJZd7RnauLpr0Ntm+33Gvf6/vKzGxK9ndGxso7c8
	KZ1LDnwXF0z/1QOKHzcGEQ9VBLGZQ/x6/dJIaX3RHXTDhoCr4Fsp4J/l0kEA1fDV9Swxap
	idDjB9sQKDKl+Wgpv7II0Rf620NAvs2LNl9adWjFHCtQ4cGgn0vUzC374DcRODOjeeAzny
	ydfrE/o5A3C+77CwfJ9QchKOG4cuO8qdD70g+bY8vRcf9iE2sJOHE4Y3W7Ia/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726236341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiGBWq4TbC9YpmLgN+63GvyKHjjpCb6BuHISr4eHJzI=;
	b=4oR+/q8Llb+SI0hdGq9ERbrJTbkx5KIrm9eRoX9o9AyxahXkVSunySR9CWIjnIJlaLK6pI
	zX9jd95UAiniQODQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH next v2 2/4] serial: 8250: Split out IER from rs485_stop_tx()
Date: Fri, 13 Sep 2024 16:11:36 +0206
Message-Id: <20240913140538.221708-3-john.ogness@linutronix.de>
In-Reply-To: <20240913140538.221708-1-john.ogness@linutronix.de>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move IER handling out of rs485_stop_tx() callback and into a new
wrapper serial8250_rs485_stop_tx(). Replace all callback call sites
with wrapper, except for the console write() callback, where it is
inappropriate to modify IER.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 drivers/tty/serial/8250/8250_port.c | 30 ++++++++++++++++++++---------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 6e90223ba1d6..b1e4b5fef8cc 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -237,6 +237,7 @@ void serial8250_em485_destroy(struct uart_8250_port *p);
 extern struct serial_rs485 serial8250_em485_supported;
 
 void serial8250_rs485_start_tx(struct uart_8250_port *up);
+void serial8250_rs485_stop_tx(struct uart_8250_port *p);
 
 /* MCR <-> TIOCM conversion */
 static inline int serial8250_TIOCM_to_MCR(int tiocm)
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index afef1dd4ddf4..2b62d49a935d 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -366,7 +366,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 
 	if (up->port.rs485.flags & SER_RS485_ENABLED &&
 	    up->port.rs485_config == serial8250_em485_config)
-		serial8250_em485_stop_tx(up);
+		serial8250_rs485_stop_tx(up);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ba8d9cefc451..7ee74ec944d2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -558,7 +558,7 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 
 deassert_rts:
 	if (p->em485->tx_stopped)
-		p->rs485_stop_tx(p);
+		serial8250_rs485_stop_tx(p);
 
 	return 0;
 }
@@ -1380,14 +1380,13 @@ static void serial8250_stop_rx(struct uart_port *port)
  * @p: uart 8250 port
  *
  * Generic callback usable by 8250 uart drivers to stop rs485 transmission.
+ * It does not restore RX interrupts. Use the wrapper function
+ * serial8250_rs485_stop_tx() if that is also needed.
  */
 void serial8250_em485_stop_tx(struct uart_8250_port *p)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
-	/* Port locked to synchronize UART_IER access against the console. */
-	lockdep_assert_held_once(&p->port.lock);
-
 	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
 		mcr |= UART_MCR_RTS;
 	else
@@ -1397,16 +1396,29 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
 	/*
 	 * Empty the RX FIFO, we are not interested in anything
 	 * received during the half-duplex transmission.
-	 * Enable previously disabled RX interrupts.
 	 */
-	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
+	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
 		serial8250_clear_and_reinit_fifos(p);
+}
+EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
+
+/**
+ * serial8250_rs485_stop_tx() - stop rs485 transmission, restore RX interrupts
+ * @p: uart 8250 port
+ */
+void serial8250_rs485_stop_tx(struct uart_8250_port *p)
+{
+	/* Port locked to synchronize UART_IER access against the console. */
+	lockdep_assert_held_once(&p->port.lock);
+
+	p->rs485_stop_tx(p);
 
+	/* Enable previously disabled RX interrupts. */
+	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
 		p->ier |= UART_IER_RLSI | UART_IER_RDI;
 		serial_port_out(&p->port, UART_IER, p->ier);
 	}
 }
-EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
 
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 {
@@ -1418,7 +1430,7 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	serial8250_rpm_get(p);
 	uart_port_lock_irqsave(&p->port, &flags);
 	if (em485->active_timer == &em485->stop_tx_timer) {
-		p->rs485_stop_tx(p);
+		serial8250_rs485_stop_tx(p);
 		em485->active_timer = NULL;
 		em485->tx_stopped = true;
 	}
@@ -1450,7 +1462,7 @@ static void __stop_tx_rs485(struct uart_8250_port *p, u64 stop_delay)
 		em485->active_timer = &em485->stop_tx_timer;
 		hrtimer_start(&em485->stop_tx_timer, ns_to_ktime(stop_delay), HRTIMER_MODE_REL);
 	} else {
-		p->rs485_stop_tx(p);
+		serial8250_rs485_stop_tx(p);
 		em485->active_timer = NULL;
 		em485->tx_stopped = true;
 	}
-- 
2.39.2

