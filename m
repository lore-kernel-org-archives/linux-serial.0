Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7081F80D7;
	Fri, 25 Oct 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853855; cv=none; b=NiOkmU/lwEcFr5LRrU0IGQm5GuzVVL0k7ELEoSrC/fEmY/jFWUR5y4j99/XFlAw4OhXga2yIsXBzP6Y3uh7J4EDQhUAlsdPCOg+sxLKFVfftV7D2bQ7RrW0gNqmEQbHw9XSwYhnxI2SzH3VZ5qUlwaKjKTzDpmlSRf9XKJ+McnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853855; c=relaxed/simple;
	bh=2hzU5AqMr50CjQLw4l8M/44tP5riHfjOe+aLhjrYJHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0kcaHNQPQPtoCGP84Gs4y6Ul48kD0jQ5FxcaSOeFwgOXK+4XrVCuIQJDxjKTzrjRVYpF7xpN4B7y0IodYf8zcvLQCyGV8ZbwCPL3T/8+EBokWuYa/opXs1o3xiu1Bdn/XxMgYVodqLOE/b0F56HBH7YmVcuFFkjc8rTcpbixhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FC/WpYCT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NAwLaY8u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FC/WpYCT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NAwLaY8u"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729853851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tv/1ishCi4YLrF78NQVKLK5eMVaeJDJpcjhAQwH+sE=;
	b=FC/WpYCT7mzyvi0bXizR5NCHCSobYzOioq6IWged4MAA+OPJ5h5dlPs1GdnqR+ooIZ6KKp
	IfK5UmlM4H1Mox62K8IgzF8mFpwuGphaHsysWZlZzDE6h6rbPxMNg4NtrQUMcS/fPtNpPc
	gCUNJCrt0R6TY1TGbnIH3sJ6+KCdwdvCHroqzDM5VJSwbBsX+U/2zC/EG+KL8iZhR4XuEs
	9DyESKdi9qGFT1UE3XrQ9NU5MRF6YIO8B3EJdZ2Cs8ZtS2Qrw+oWgiizkFNIn7WTO7yY8r
	tdQfEAHD919T/tBWdLXi0iOAdktqGZctzk/3zp4zyjjrlopqTzQwLGU7x71+eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729853851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tv/1ishCi4YLrF78NQVKLK5eMVaeJDJpcjhAQwH+sE=;
	b=NAwLaY8u+FpxWk77r2KwWtU9b6UnhkeJc4uwJfpGqz01NQc83Trfjnr4NgP6BlKjAH6C7f
	2g0AFEg5FJkXfFAw==
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
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH tty-next v3 3/6] serial: 8250: Split out rx stop/start code into helpers
Date: Fri, 25 Oct 2024 13:03:25 +0206
Message-Id: <20241025105728.602310-4-john.ogness@linutronix.de>
In-Reply-To: <20241025105728.602310-1-john.ogness@linutronix.de>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rx stop/start callbacks also disable/enable interrupts. This
is not acceptable for the console write callback since it must
manage all interrupt disabling/enabling.

Move the interrupt disabling/enabling/masking into helper
functions so that the console write callback can make use of
the appropriate parts in a follow-up commit.

This is essentially refactoring and should cause no functional
change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 37 ++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8f7c9968ad41..09ac521d232a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1360,18 +1360,37 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	port->irq = (irq > 0) ? irq : 0;
 }
 
-static void serial8250_stop_rx(struct uart_port *port)
+static void __serial8250_stop_rx_mask_dr(struct uart_port *port)
 {
-	struct uart_8250_port *up = up_to_u8250p(port);
+	port->read_status_mask &= ~UART_LSR_DR;
+}
 
+static void __serial8250_stop_rx_int(struct uart_8250_port *p)
+{
 	/* Port locked to synchronize UART_IER access against the console. */
-	lockdep_assert_held_once(&port->lock);
+	lockdep_assert_held_once(&p->port.lock);
+
+	p->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
+	serial_port_out(&p->port, UART_IER, p->ier);
+}
+
+static void __serial8250_start_rx_int(struct uart_8250_port *p)
+{
+	/* Port locked to synchronize UART_IER access against the console. */
+	lockdep_assert_held_once(&p->port.lock);
+
+	p->ier |= UART_IER_RLSI | UART_IER_RDI;
+	serial_port_out(&p->port, UART_IER, p->ier);
+}
+
+static void serial8250_stop_rx(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
 
 	serial8250_rpm_get(up);
 
-	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-	up->port.read_status_mask &= ~UART_LSR_DR;
-	serial_port_out(port, UART_IER, up->ier);
+	__serial8250_stop_rx_mask_dr(port);
+	__serial8250_stop_rx_int(up);
 
 	serial8250_rpm_put(up);
 }
@@ -1386,9 +1405,6 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
-	/* Port locked to synchronize UART_IER access against the console. */
-	lockdep_assert_held_once(&p->port.lock);
-
 	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
 		mcr |= UART_MCR_RTS;
 	else
@@ -1403,8 +1419,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
 		serial8250_clear_and_reinit_fifos(p);
 
-		p->ier |= UART_IER_RLSI | UART_IER_RDI;
-		serial_port_out(&p->port, UART_IER, p->ier);
+		__serial8250_start_rx_int(p);
 	}
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
-- 
2.39.5

