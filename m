Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30943E8C61;
	Tue, 31 Mar 2026 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966507; cv=none; b=fD09ocLNJqGk3sTOphuuEt/W4+Nu01ERa3pD3qsaij1amnbDVPq7qj+NcmDgGUSVhgDp4fLMr3OEqWvM0qmTQJ1ly6cBq02o3ZwJjOtu7oVQ9glgrd5HchZJnCkPY9j0pjmJ+Y/hPfCTaRiF8n7DClc2+J793xVz8oi2w3DdRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966507; c=relaxed/simple;
	bh=hurB+IT63Gjk8f/mZKMqq/3FPOlqLZLSy/FpWyDjWFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKfIOyBR6TWXU2xQsqyC37r3OmMgS6N3l8RkoRwVpyvvc3ecdx0VJZCueNVaDwzDMTNmHHetIpNfYr9CLdr9l2yPgwyQ2zpzXZuoe8BVWWLSMOBgk/u/G7hy/t3i5QwPJ2q2HWa4ygIOkqpKNq+hM/XpQVFAf/JigZNWHdsaEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ko8KCFD1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KeXL0KK6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ko8KCFD1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KeXL0KK6"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774966503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qwbkcNVm6DsTKRo3QYBwenazzCiJkM5s05aeWj2+Aww=;
	b=ko8KCFD1sBr9ZOkoTQz2+KohMmz6S39BC6p5rvF730+2kC/73UZziAHGCfb/HL2EumIy0h
	mGFE+lgrU7XixVlAjLwuIAmT+Zo0iM7Xq3U5cfneiMz0IrKDD1aVpZnvCkKMjymCgrQmnU
	j8bdQTaUivpkky6xsgyX3w0egtK4WJRoFwkb9Mhbqa4jZf3Gch+qAC3lvEnvlGZnWY1NuL
	EAKAvYe1qaPiY5KyEcKtM5ahuwYt/buYnpDzz1D5QUEr7bWw6H0n+MkkXeo7XsdJhfT1sq
	MKhQCuuhxwzI8I7ctNpajmg8VZknhgGkYatb2eEPZmc+SP7WNTMvEUfkmVUqRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774966503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qwbkcNVm6DsTKRo3QYBwenazzCiJkM5s05aeWj2+Aww=;
	b=KeXL0KK6nY7mfZCwfcPN1oWTLQOBa9zKZRGLXy3TVwDhqtr8CZSn5ZIcr1GEdtcEXHLpaG
	gFehax3MNvK10sAg==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Joseph Tilahun <jtilahun@astranis.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v1] serial: 8250: Add support for console hardware flow control
Date: Tue, 31 Mar 2026 16:20:56 +0206
Message-ID: <20260331141502.6233-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel documentation specifies that the console option 'r' can
be used to enable hardware flow control for console writes. The 8250
driver does include code for hardware flow control on the console if
the UPF_CONS_FLOW flag is set, but there is no code path that sets
this flag. However, that is not the only issue. The problems are:

1. Specifying the console option 'r' does not lead to UPF_CONS_FLOW
   being set.

2. Even if UPF_CONS_FLOW would be set, serial8250_register_8250_port()
   clears it.

3. When the console option 'r' is specified, uart_set_options()
   attempts to initialize the port for CRTSCTS. However, afterwards
   it does not set the UPSTAT_CTS_ENABLE status bit and therefore on
   boot, uart_cts_enabled() is always false. This policy bit is
   important for console drivers as a criteria if they may poll CTS.

4. Even though uart_set_options() attempts to initialized the port
   for CRTSCTS, the 8250 set_termios() callback does not enable the
   RTS signal (TIOCM_RTS) and thus the hardware is not properly
   initialized for CTS polling.

5. Even if modem control was properly setup for CTS polling
   (TIOCM_RTS), uart_configure_port() clears TIOCM_RTS, thus
   breaking CTS polling.

6. wait_for_xmitr() and serial8250_console_write() use the
   UPF_CONS_FLOW bit to decide if CTS polling should occur. However,
   the condition should also include a check that it is not in rs485
   mode and CRTSCTS is actually enabled in the hardware.

Address all these issues as conservatively as possible by gating them
behind checks focussed on the user specifying console hardware flow
control support and the hardware being configured for CTS polling
at the time of the write to the uart.

Since checking the UPSTAT_CTS_ENABLE status bit is a part of the new
condition gate, these changes also support runtime termios updates to
disable/enable CRTSCTS.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c |  7 +++++++
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++++--
 drivers/tty/serial/serial_core.c    | 18 +++++++++++++++++-
 include/linux/serial_core.h         |  8 ++++++++
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb7..fd3441dd9a559 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -693,6 +693,7 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 int serial8250_register_8250_port(const struct uart_8250_port *up)
 {
 	struct uart_8250_port *uart;
+	bool console_hwflow;
 	int ret;
 
 	if (up->port.uartclk == 0)
@@ -716,6 +717,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	if (uart->port.type == PORT_8250_CIR)
 		return -ENODEV;
 
+	/* Preserve specified console hardware flow control. */
+	console_hwflow = uart->port.flags & UPF_CONS_FLOW;
+
 	if (uart->port.dev)
 		uart_remove_one_port(&serial8250_reg, &uart->port);
 
@@ -757,6 +761,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			goto err;
 	}
 
+	if (console_hwflow)
+		uart->port.flags |= UPF_CONS_FLOW;
+
 	if (up->port.flags & UPF_FIXED_TYPE)
 		uart->port.type = up->port.type;
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index af78cc02f38e7..88f5309a940e9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1988,7 +1988,7 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 	wait_for_lsr(up, bits);
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
+	if (uart_console_hwflow_active(&up->port)) {
 		for (tmout = 1000000; tmout; tmout--) {
 			unsigned int msr = serial_in(up, UART_MSR);
 			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
@@ -2782,6 +2782,12 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial8250_set_efr(port, termios);
 		serial8250_set_divisor(port, baud, quot, frac);
 		serial8250_set_fcr(port, termios);
+		/* Consoles manually poll CTS for hardware flow control. */
+		if (uart_console(port) &&
+		    !(port->rs485.flags & SER_RS485_ENABLED)
+		    && termios->c_cflag & CRTSCTS) {
+			port->mctrl |= TIOCM_RTS;
+		}
 		serial8250_set_mctrl(port, port->mctrl);
 	}
 
@@ -3351,7 +3357,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		 * it regardless of the CTS state. Therefore, only use fifo
 		 * if we don't use control flow.
 		 */
-		!(up->port.flags & UPF_CONS_FLOW);
+		!uart_console_hwflow_active(&up->port);
 
 	if (likely(use_fifo))
 		serial8250_console_fifo_write(up, s, count);
@@ -3421,6 +3427,10 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	if (ret)
 		return ret;
 
+	/* Allow user-specified hardware flow control. */
+	if (flow == 'r')
+		port->flags |= UPF_CONS_FLOW;
+
 	if (port->dev)
 		pm_runtime_get_sync(port->dev);
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 89cebdd278410..cce1fd728a1e4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2235,6 +2235,15 @@ uart_set_options(struct uart_port *port, struct console *co,
 	port->mctrl |= TIOCM_DTR;
 
 	port->ops->set_termios(port, &termios, &dummy);
+
+	/*
+	 * If console hardware flow control was specified and is supported,
+	 * the related policy UPSTAT_CTS_ENABLE must be set to allow console
+	 * drivers to identify if CTS should be used for polling.
+	 */
+	if (flow == 'r' && (termios.c_cflag & CRTSCTS))
+		port->status |= UPSTAT_CTS_ENABLE;
+
 	/*
 	 * Allow the setting of the UART parameters with a NULL console
 	 * too:
@@ -2541,7 +2550,14 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * We probably don't need a spinlock around this, but
 		 */
 		scoped_guard(uart_port_lock_irqsave, port) {
-			port->mctrl &= TIOCM_DTR;
+			unsigned int mask = TIOCM_DTR;
+
+			/* Console hardware flow control polls CTS. */
+			if (uart_console_hwflow_active(port))
+				mask |= TIOCM_RTS;
+
+			port->mctrl &= mask;
+
 			if (!(port->rs485.flags & SER_RS485_ENABLED))
 				port->ops->set_mctrl(port, port->mctrl);
 		}
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 666430b478997..07bd3bd6c8355 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1163,6 +1163,14 @@ static inline bool uart_softcts_mode(struct uart_port *uport)
 	return ((uport->status & mask) == UPSTAT_CTS_ENABLE);
 }
 
+static inline bool uart_console_hwflow_active(struct uart_port *uport)
+{
+	return uart_console(uport) &&
+	       !(uport->rs485.flags & SER_RS485_ENABLED) &&
+	       (uport->flags & UPF_CONS_FLOW) &&
+	       uart_cts_enabled(uport);
+}
+
 /*
  * The following are helper functions for the low level drivers.
  */

base-commit: d50dd728ced93a1900ff0be924b6f273baf59fb2
-- 
2.47.3

