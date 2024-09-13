Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153743144;
	Fri, 13 Sep 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236344; cv=none; b=cqDFoGbKB5rjuDxuI2Qb7PD7cmalx4BLbWxjTk2QBz7AiRvirg/MWFaps9UQUlG4nT5I7I0Jq43xXX1iZmOMLUANakcZ2mRXY8f7hsvKB+Syhuw30NghaRkBBB4vfQ24BjvDBADDViopMUeEoxoG/DgxIoRv+8nCzwXXDvSfbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236344; c=relaxed/simple;
	bh=S5uPkoT9yo7idV+N+2sbJKMsKlKO8GaUe/m9ysT6lvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cYVlZofsl4CTa1bH983p+cOQ2Y7DoE8/EqHhWHJ3zJ5qFOXIkf+V/aNl4UYgl4uEd3fi7d8Tt9a+wtD34Z2dedx7vO2V9gw7Fm2FqI6tPJlMgjrnUcDR/PYFBYPnyECzuMxNByJmH7ve6MnVVqer7MnGnkpTE5HKWeSa0UhPgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YO3EBjdY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9lYq6idM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YO3EBjdY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9lYq6idM"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726236340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYB7nNBL+zvMdCuk+woBwavomuKxjvWKg5JZQriJJBA=;
	b=YO3EBjdYG4KJDNN/HlxajsvfsOdF47cI4yzlWKG4VIQk/MOQeoxB/PmtwiLv2UPaEBWyp3
	kTWVt4gMPR0NNgH4kwv2RAMD9JqfmjQn2R6O5xAu1mUj9yFflzeUww13cAzsh7JcvonWBj
	Z+fDESke4Q1YRVuPdQc8jvl4/8k/+TUtWbNN4AH07rGIbHYprSxtCpHkWTpMUvTaTtKy5V
	bq28tRbq4eVt8J4rWwjLW3A1M2qRUPysEB/4Jw12hsNY2WmNpdBwGdsWlKpfieApUZr1oB
	LJ99D8lW+/p/tjhBFF1k/M3QVjcVF7zfk0BPWOkZa+UCqLTvNQ193EqCI7bNhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726236340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYB7nNBL+zvMdCuk+woBwavomuKxjvWKg5JZQriJJBA=;
	b=9lYq6idML3UQwt4B0sMBRzIpLEgcec9pkloDjQkY0Sr+qc6p2zOPyDTfsSZcXzy9WsgIL5
	r92mMqE95aCvLPAg==
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
	Sunil V L <sunilvl@ventanamicro.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH next v2 1/4] serial: 8250: Split out IER from rs485_start_tx()
Date: Fri, 13 Sep 2024 16:11:35 +0206
Message-Id: <20240913140538.221708-2-john.ogness@linutronix.de>
In-Reply-To: <20240913140538.221708-1-john.ogness@linutronix.de>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move IER handling out of rs485_start_tx() callback and into a new
wrapper serial8250_rs485_start_tx(). Replace all callback call sites
with wrapper, except for the console write() callback, where it is
inappropriate to modify IER.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250.h      |  2 ++
 drivers/tty/serial/8250/8250_port.c | 27 +++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index e5310c65cf52..6e90223ba1d6 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -236,6 +236,8 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p);
 void serial8250_em485_destroy(struct uart_8250_port *p);
 extern struct serial_rs485 serial8250_em485_supported;
 
+void serial8250_rs485_start_tx(struct uart_8250_port *up);
+
 /* MCR <-> TIOCM conversion */
 static inline int serial8250_TIOCM_to_MCR(int tiocm)
 {
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2786918aea98..ba8d9cefc451 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1370,7 +1370,6 @@ static void serial8250_stop_rx(struct uart_port *port)
 	serial8250_rpm_get(up);
 
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-	up->port.read_status_mask &= ~UART_LSR_DR;
 	serial_port_out(port, UART_IER, up->ier);
 
 	serial8250_rpm_put(up);
@@ -1543,16 +1542,20 @@ static inline void __start_tx(struct uart_port *port)
  *
  * Generic callback usable by 8250 uart drivers to start rs485 transmission.
  * Assumes that setting the RTS bit in the MCR register means RTS is high.
- * (Some chips use inverse semantics.)  Further assumes that reception is
- * stoppable by disabling the UART_IER_RDI interrupt.  (Some chips set the
- * UART_LSR_DR bit even when UART_IER_RDI is disabled, foiling this approach.)
+ * (Some chips use inverse semantics.)
+ * It does not disable RX interrupts. Use the wrapper function
+ * serial8250_rs485_start_tx() if that is also needed.
  */
 void serial8250_em485_start_tx(struct uart_8250_port *up)
 {
 	unsigned char mcr = serial8250_in_MCR(up);
 
+	/*
+	 * Some chips set the UART_LSR_DR bit even when UART_IER_RDI is
+	 * disabled, so explicitly mask it.
+	 */
 	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
-		serial8250_stop_rx(&up->port);
+		up->port.read_status_mask &= ~UART_LSR_DR;
 
 	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
 		mcr |= UART_MCR_RTS;
@@ -1562,6 +1565,18 @@ void serial8250_em485_start_tx(struct uart_8250_port *up)
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_start_tx);
 
+/**
+ * serial8250_rs485_start_tx() - stop rs485 reception, enable transmission
+ * @up: uart 8250 port
+ */
+void serial8250_rs485_start_tx(struct uart_8250_port *up)
+{
+	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		serial8250_stop_rx(&up->port);
+
+	up->rs485_start_tx(up);
+}
+
 /* Returns false, if start_tx_timer was setup to defer TX start */
 static bool start_tx_rs485(struct uart_port *port)
 {
@@ -1585,7 +1600,7 @@ static bool start_tx_rs485(struct uart_port *port)
 	if (em485->tx_stopped) {
 		em485->tx_stopped = false;
 
-		up->rs485_start_tx(up);
+		serial8250_rs485_start_tx(up);
 
 		if (up->port.rs485.delay_rts_before_send > 0) {
 			em485->active_timer = &em485->start_tx_timer;
-- 
2.39.2

