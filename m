Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67581F3D47;
	Tue,  7 Jan 2025 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285228; cv=none; b=fxAeAFBRSoWR0l03+LeLA0NDFzD4J7ICfBxE5wJnh54kAirkeAMuloFnrBimwcFryYCSxx+NHNFUJ/Ytm5HZl+rrjZP9ZNXYh+QnNx3OUXBHqY3G+FLHk21IkXqB+9OpfaVFB7OEpXiOvVMDRNH0lEXPwVsqfI95/Hwhrq4a6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285228; c=relaxed/simple;
	bh=aASTNKlKjZuw3fqXpnn84K4ZGSMAkwvO2wilf3jlqtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imuOKDpcqzupPyOXbItb/rGqa5z7zB7jT5ZB0cIqKqycyIFTHYUPnSWbt+2PS73aeNyhL5CFC+iTfKruMqmfeHt8/5Cj22H0RLAwEnGboFkyd1AdsXVW8IA++MVzz3agisfWcjtvh16ZSqMaCOxRq/N9Z1f7J3WU1Tpf0UO9+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=STZ9capF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8Pz7zK+U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STZ9capF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8Pz7zK+U"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736285225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/zOrW+LUkSiZr+TvOblyugUylHsj+wMZv3FMYyd9KnU=;
	b=STZ9capF54VzMUuFLF72oG+cJ4dB9zQ9ProQ1zbyZfGn52tBZ8CMK+G0kwYKZNXclTwvsL
	tG/fHJUz2wT8xXJUuHhEAJnBSO6wrCnOjYnU+8r88R3sTIWUZfZ06ZPq3/DUZi2VVTczEn
	HeWuS+vpdVDMAA8XaGg3QaV3T83e0Dkv4Yr/xcpXKQwGtX45vhnHDpTHOMQeFE0TWSdZqc
	F4wF3Uro/Ei/VJW6w96J/0bsDs6IcB75Jwyadhlq92GYE4I2vKcSVHOiLWeLFY9FVGVPBA
	9mhtkoRnz1cEdt4O/j/QbZObObhkV8GK9eLhAV/tqVPS3g9UouMrbqvtEH4Yig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736285225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/zOrW+LUkSiZr+TvOblyugUylHsj+wMZv3FMYyd9KnU=;
	b=8Pz7zK+Um3oHCIr62tLdX6zwRR9MuTmfUxG6SKxzEng2pZbV5LBvr2aBqyQJpZyIgvegHi
	VKMSzwQk5lJZsLAw==
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
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH tty-next v5 3/6] serial: 8250: Use high-level writing function for FIFO
Date: Tue,  7 Jan 2025 22:32:59 +0106
Message-Id: <20250107212702.169493-4-john.ogness@linutronix.de>
In-Reply-To: <20250107212702.169493-1-john.ogness@linutronix.de>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently serial8250_console_fifo_write() directly writes into
the UART_TX register rather than using the high-level function
serial8250_console_putchar(). This is because
serial8250_console_putchar() waits for the holding register to
become empty, which would defeat the purpose of the FIFO code.

Move the LSR_THRE waiting to a new function
serial8250_console_wait_putchar() so that the FIFO code can use
serial8250_console_putchar(). This will be particularly important
for a follow-up commit, where output bytes are inspected to track
newlines.

This is only refactoring and has no functional change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ca8f6f3855eb..15abd95fcf06 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3298,11 +3298,16 @@ EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
 static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
+{
+	serial_port_out(port, UART_TX, ch);
+}
+
+static void serial8250_console_wait_putchar(struct uart_port *port, unsigned char ch)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
 	wait_for_xmitr(up, UART_LSR_THRE);
-	serial_port_out(port, UART_TX, ch);
+	serial8250_console_putchar(port, ch);
 }
 
 /*
@@ -3352,6 +3357,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 {
 	const char *end = s + count;
 	unsigned int fifosize = up->tx_loadsz;
+	struct uart_port *port = &up->port;
 	unsigned int tx_count = 0;
 	bool cr_sent = false;
 	unsigned int i;
@@ -3362,10 +3368,10 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 
 		for (i = 0; i < fifosize && s != end; ++i) {
 			if (*s == '\n' && !cr_sent) {
-				serial_out(up, UART_TX, '\r');
+				serial8250_console_putchar(port, '\r');
 				cr_sent = true;
 			} else {
-				serial_out(up, UART_TX, *s++);
+				serial8250_console_putchar(port, *s++);
 				cr_sent = false;
 			}
 		}
@@ -3445,7 +3451,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (likely(use_fifo))
 		serial8250_console_fifo_write(up, s, count);
 	else
-		uart_console_write(port, s, count, serial8250_console_putchar);
+		uart_console_write(port, s, count, serial8250_console_wait_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
-- 
2.39.5

