Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426AA44D01F;
	Wed,  6 May 2026 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069774; cv=none; b=YEFORl9Atq2BQ57AZNO70JCq4eCiOkFB4U7MirI9mPusYf0I38zLNWoeop5Rk39JRjyjp875c9dLnrLULbB+mCqqM30hieVWUyiOMnnjVyDsRu1utjrB3U8CxReI+/Pgcs3YMig7SFek+Jo4vrW3fOnLhMRJwu3neqVFtOXh944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069774; c=relaxed/simple;
	bh=OwK2+KUiqVlBtuRKWTGsaku1Osmx+eiL0WY4SFFVsOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTM4zXhDUE2dCEdKdLYXQMsorhxacrtGWMGpsbUTtGjZq0O0LPbByJQqMXqQUJsy3nFLgq6S9cO9SJuQkdkOX+mSFM6TgB576y1QzhR64Jiue2vbnWdmSKlPURy8HElDPeNkQKr0dXpEL0AA23WZHWFXqmcALd8XPB9uI7uVPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WBLLmWLn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xS3RfLb5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WBLLmWLn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xS3RfLb5"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778069770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAPOjJugKWAvr3Uc5M20TcCUXRCkx0HO6mcN/GZ90rA=;
	b=WBLLmWLnlmpWwVAjsBVQKsDU43a2+1pi1EuRE2heYyjd6IlXSvOYOjXATVJNm8k33+EOYx
	jPqAziBN0J51e+eVD/16PfRnsj16rHXsXOiQIcPS/NKdTwS8LMh+gWJL7NDKF0fUFmF5SO
	ZK+/bHUP913QrEc/z8pphy5L9WM4CpD8+kzS0jSvXEj38SIFe+6H0+1o/b4GifqdIa/0hV
	3HL+9zK27mO6ggjfwldy0XCows6PgshdC+f6o9scyWQV9vQcjFnH2CVuQkx5DGF/0UZQKr
	VmYpcfHXiyvbOPLWsK3HFN23olIoDeI0KBHn2YktMwUFgEAx84iQ/Zvv+mJrIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778069770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAPOjJugKWAvr3Uc5M20TcCUXRCkx0HO6mcN/GZ90rA=;
	b=xS3RfLb5iBZfRTrJhAEwrA3n9BiVnPdiQrXAhBMlUFbR/kpD7vW+aiXgyxAWAVn6O4ogxM
	ioZHKGJgCSDZF0Bw==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	Joseph Tilahun <jtilahun@astranis.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v4 6/6] serial: 8250: Add support for console flow control
Date: Wed,  6 May 2026 14:22:01 +0206
Message-ID: <20260506121606.5805-7-john.ogness@linutronix.de>
In-Reply-To: <20260506121606.5805-1-john.ogness@linutronix.de>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
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
cons_flow is set, but there is no code path that actually sets this.
However, that is not the only issue. The problems are:

1. Specifying the console option 'r' does not lead to cons_flow being
   set.

2. Even if cons_flow would be set, serial8250_register_8250_port()
   clears it.

3. When the console option 'r' is specified, uart_set_options()
   attempts to initialize the port for CRTSCTS. However, afterwards
   it does not set the UPSTAT_CTS_ENABLE status bit and therefore on
   boot, uart_cts_enabled() is always false. This policy bit is
   important for console drivers as a criteria if they may poll CTS.

4. Even though uart_set_options() attempts to initialize the port
   for CRTSCTS, the 8250 set_termios() callback does not enable the
   RTS signal (TIOCM_RTS) and thus the hardware is not properly
   initialized for CTS polling.

5. Even if modem control was properly setup for CTS polling
   (TIOCM_RTS), uart_configure_port() clears TIOCM_RTS, thus
   breaking CTS polling.

6. wait_for_xmitr() and serial8250_console_write() use cons_flow
   to decide if CTS polling should occur. However, the condition
   should also include a check that it is not in RS485 mode and
   CRTSCTS is actually enabled in the hardware.

Address all these issues as conservatively as possible by gating them
behind checks focussed on the user specifying console hardware flow
control support and the hardware being configured for CTS polling
at the time of the write to the UART.

Since checking the UPSTAT_CTS_ENABLE status bit is a part of the new
condition gate, these changes also support runtime termios updates to
disable/enable CRTSCTS.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c |  6 +++++-
 drivers/tty/serial/8250/8250_port.c | 13 +++++++++++--
 drivers/tty/serial/serial_core.c    | 21 ++++++++++++++++++++-
 include/linux/serial_core.h         |  8 ++++++++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index b0275204e1167..1f03da85e3414 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -693,6 +693,7 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 int serial8250_register_8250_port(const struct uart_8250_port *up)
 {
 	struct uart_8250_port *uart;
+	bool cons_flow;
 	int ret;
 
 	if (up->port.uartclk == 0)
@@ -716,6 +717,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	if (uart->port.type == PORT_8250_CIR)
 		return -ENODEV;
 
+	/* Preserve specified console flow control. */
+	cons_flow = uart_cons_flow_enabled(&uart->port);
+
 	if (uart->port.dev)
 		uart_remove_one_port(&serial8250_reg, &uart->port);
 
@@ -746,7 +750,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	uart->lsr_save_mask	= up->lsr_save_mask;
 	uart->dma		= up->dma;
 
-	uart_set_cons_flow_enabled(&uart->port, uart_cons_flow_enabled(&up->port));
+	uart_set_cons_flow_enabled(&uart->port, uart_cons_flow_enabled(&up->port) | cons_flow);
 
 	/* Take tx_loadsz from fifosize if it wasn't set separately */
 	if (uart->port.fifosize && !uart->tx_loadsz)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719789013f6df..9ba3876bffa50 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1989,7 +1989,7 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 	tx_ready = wait_for_lsr(up, bits);
 
 	/* Wait up to 1s for flow control if necessary */
-	if (uart_cons_flow_enabled(&up->port)) {
+	if (uart_console_hwflow_active(&up->port)) {
 		for (tmout = 1000000; tmout; tmout--) {
 			unsigned int msr = serial_in(up, UART_MSR);
 			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
@@ -2786,6 +2786,12 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
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
 
@@ -3355,7 +3361,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		 * it regardless of the CTS state. Therefore, only use fifo
 		 * if we don't use control flow.
 		 */
-		!uart_cons_flow_enabled(&up->port);
+		!uart_console_hwflow_active(&up->port);
 
 	if (likely(use_fifo))
 		serial8250_console_fifo_write(up, s, count);
@@ -3425,6 +3431,9 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	if (ret)
 		return ret;
 
+	/* Track user-specified console flow control. */
+	uart_set_cons_flow_enabled(port, flow == 'r');
+
 	if (port->dev)
 		pm_runtime_get_sync(port->dev);
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 89cebdd278410..840336f95c5f6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2235,6 +2235,18 @@ uart_set_options(struct uart_port *port, struct console *co,
 	port->mctrl |= TIOCM_DTR;
 
 	port->ops->set_termios(port, &termios, &dummy);
+
+	/*
+	 * If console hardware flow control was specified and is supported,
+	 * the related policy UPSTAT_CTS_ENABLE must be set to allow console
+	 * drivers to identify if CTS should be used for polling.
+	 */
+	if (flow == 'r' && (termios.c_cflag & CRTSCTS)) {
+		/* Synchronize @status RMW update against the console. */
+		guard(uart_port_lock_irqsave)(port);
+		port->status |= UPSTAT_CTS_ENABLE;
+	}
+
 	/*
 	 * Allow the setting of the UART parameters with a NULL console
 	 * too:
@@ -2541,7 +2553,14 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
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
index 4f7bbdd900176..17fcff466e301 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1175,6 +1175,14 @@ static inline bool uart_cons_flow_enabled(const struct uart_port *uport)
 	return uport->cons_flow;
 }
 
+static inline bool uart_console_hwflow_active(struct uart_port *uport)
+{
+	return uart_console(uport) &&
+	       !(uport->rs485.flags & SER_RS485_ENABLED) &&
+	       uart_cons_flow_enabled(uport) &&
+	       uart_cts_enabled(uport);
+}
+
 /*
  * The following are helper functions for the low level drivers.
  */
-- 
2.47.3

