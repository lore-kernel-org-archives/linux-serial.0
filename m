Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9313D518;
	Fri, 27 Dec 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735339534; cv=none; b=YeiZmFESzjcati2hIGE8hLZ6rfDLvx4sD8btNkUnfRMuv8fRQfMO9jKxdhtgtjJL+4d9jBXbyMUZEw2U0MYmzAieMn2nj69hsMkkgedbebrCy/YKktoC0YRFFzW8L6LnV168rmwXszs7YGNVue0r6o2n5RjatOP+WzyuF9y+8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735339534; c=relaxed/simple;
	bh=2BzpnH0P0efFtE1Tbnr5i3eNkIVGDAWc3r18CJcfwIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YwZ8Qwi+ibHZ3zDwgIbT61OdGVQskTM+gAhUBY5ojYxbU2ghiwX65vOJxdujcUOwo11TBW+z+B6ksEOgIC6iK+WWP8fDA4IKCmBR5toLwi28YbwwHLgANCZu76dhdxJ+rRzZdYjHTJCspj4u//i95eBXs+eDV5ifGSsuiNu3NuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qA5wjkWg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQjK0vpt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qA5wjkWg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQjK0vpt"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735339524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uASmd5u/xWtAyaeV0vxHBkcxGYrtczlQqrX77S+KG1c=;
	b=qA5wjkWgOJuHMIXH34o12zQeK+ZeyEsTjboLIjjVEBtxj4UimdyR5xVba4MVcVBUiD7oVN
	DLyPFnVZkIxg6uSQ6mWZHrvAkbRSFrJocs08KXewD6wmOmHh3mxN9wfFCJ+ZaQV994Ssh8
	hEVaOKU8JCj/HUgLN7ImouyykgxZbrcUYCwsJ2SFS9pDHR4ezT+VcXBTSKjhU7KQrA+0pP
	Y0+sbflknmSjfN5GIXW5q668hv+bfQ4N4LQW62WKh7jpKehFfRDFd3r9i0Vt5pKydwZSKV
	bc+vLqrNK6233a+uCq8XSEf/5cg1bD7dSDvNpcabe3JM8cazZYJBeYxinL6xXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735339524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uASmd5u/xWtAyaeV0vxHBkcxGYrtczlQqrX77S+KG1c=;
	b=uQjK0vptV2fE3FlpE/zF+iPl8BrHVUktiMNexK34QZwM1QRvdDhikKbNBbFHakP/LmVrtM
	YvMA27RctXuoq1CA==
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
	Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH tty-next v4 1/6] serial: 8250: Adjust the timeout for FIFO mode
Date: Fri, 27 Dec 2024 23:51:17 +0106
Message-Id: <20241227224523.28131-2-john.ogness@linutronix.de>
In-Reply-To: <20241227224523.28131-1-john.ogness@linutronix.de>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a console has written a record into UART_TX, it uses
wait_for_xmitr() to wait until the data has been sent out before
returning. However, wait_for_xmitr() will timeout after 10ms,
regardless if the data has been transmitted or not.

For single bytes, this timeout is sufficient even at very slow
baud rates, such as 1200bps. However, when FIFO mode is used,
there may be 64 bytes pushed into the FIFO at once. At a baud
rate of 115200bps, the 10ms timeout is still sufficient. But
when using lower baud rates (such as 57600bps), the timeout
is _not_ sufficient. This causes longer lines to be cut off,
resulting in lost and horribly misformatted output on the
console.

When using FIFO mode, take the number of bytes into account to
determine an appropriate maximum timeout. Increasing the timeout
does not affect performance since ideally the timeout never
occurs.

Fixes: 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/tty/serial/8250/8250_port.c | 32 +++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1a65d3e5f3c0..3a946ebe9139 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2078,7 +2078,8 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	serial8250_rpm_put(up);
 }
 
-static void wait_for_lsr(struct uart_8250_port *up, int bits)
+/* Returns true if @bits were set, false on timeout */
+static bool wait_for_lsr(struct uart_8250_port *up, int bits)
 {
 	unsigned int status, tmout = 10000;
 
@@ -2093,11 +2094,11 @@ static void wait_for_lsr(struct uart_8250_port *up, int bits)
 		udelay(1);
 		touch_nmi_watchdog();
 	}
+
+	return (tmout != 0);
 }
 
-/*
- *	Wait for transmitter & holding register to empty
- */
+/* Wait for transmitter and holding register to empty with timeout */
 static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 {
 	unsigned int tmout;
@@ -3322,6 +3323,16 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
+static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (wait_for_lsr(up, UART_LSR_THRE))
+			return;
+	}
+}
+
 /*
  * Print a string to the serial port using the device FIFO
  *
@@ -3331,13 +3342,15 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 static void serial8250_console_fifo_write(struct uart_8250_port *up,
 					  const char *s, unsigned int count)
 {
-	int i;
 	const char *end = s + count;
 	unsigned int fifosize = up->tx_loadsz;
+	unsigned int tx_count = 0;
 	bool cr_sent = false;
+	unsigned int i;
 
 	while (s != end) {
-		wait_for_lsr(up, UART_LSR_THRE);
+		/* Allow timeout for each byte of a possibly full FIFO */
+		fifo_wait_for_lsr(up, fifosize);
 
 		for (i = 0; i < fifosize && s != end; ++i) {
 			if (*s == '\n' && !cr_sent) {
@@ -3348,7 +3361,14 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 				cr_sent = false;
 			}
 		}
+		tx_count = i;
 	}
+
+	/*
+	 * Allow timeout for each byte written since the caller will only wait
+	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
+	 */
+	fifo_wait_for_lsr(up, tx_count);
 }
 
 /*
-- 
2.39.5

