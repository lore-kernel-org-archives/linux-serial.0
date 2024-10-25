Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34FE1F80CB;
	Fri, 25 Oct 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853854; cv=none; b=eLSgcpI54Ko4e4YBm4S2QL4j1lYRtdq1Ii2BYXWt1yOP6ggmbMeA69ePdlF4fVf1LfFqQ5XQbHcNJ+0PDqDVGA9Iby08mqcVKAE5+xIKbYmDjj9tgB0xqK3Ztm0L3oMFkwf/S0ct1MBBOb0TOpw4L5sKgCXQIi7N1l/9VLmIwNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853854; c=relaxed/simple;
	bh=f3+cAPfK4RNXXSnDuLv/8Vb+cYWmESyrDKzGzGUS+f0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ML2rtf/k+aL0Dx8Sj3+yOMRJxekszNUY1Y/Fc8s0Xyis5oZpwkm53s6mg1y+Y+a50VIenLrOw2SfJU4TAo7uzx3obP17gnBgbUj5yyPDLtzvWE1jw1W/c9IHP/TShz0z/2U3SCNpnms0orfrjXQd2xfv9R3VaMLY+DsdTsx1W3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KEa8E1l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYx1aTc9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KEa8E1l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYx1aTc9"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729853851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uqo1w8ChYQdngURCDum4RxzHCiFXSNcp0ppGWjfcIRs=;
	b=0KEa8E1lizdsEtz/CP98LmuxFbdk0lKDtf0vyc0eP9p9JPkwo456dzbW/B4O7vfy2W3iA5
	WRvANjE9vpkAJwkw3LaykMKUJa+AWEqhRZLg1V05qTWfBnwfpb+hfFpaKSA82QK/aaqMGv
	yG3Mmt3q4KpHEKALOjKfM87Hvd8LBXdarnoTtY+MuMNt5n/QrVMot6UHpiIaDIvPlSVqsP
	4iq1pJAQbN1hc34dbgMD4dbJSE6j69KVJ171Mrq6bYsaiRNuu7YEfnbLHOkbd/oDlQgGpC
	zX3FrpGRr78G2oOowVXi/ixAbQ+CM4H5WOXLNPtqPcsSo71Z30Zq84JE0HjCzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729853851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uqo1w8ChYQdngURCDum4RxzHCiFXSNcp0ppGWjfcIRs=;
	b=cYx1aTc9gdCNISApxi3ofM1UDkCWGROWg8TZ3+MkNPzEJa0DOKj5VFEcZB42zyFyRH4nEK
	FUi59G7fNy6IjPDA==
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
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH tty-next v3 2/6] serial: 8250: Use high-level write function for FIFO
Date: Fri, 25 Oct 2024 13:03:24 +0206
Message-Id: <20241025105728.602310-3-john.ogness@linutronix.de>
In-Reply-To: <20241025105728.602310-1-john.ogness@linutronix.de>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently serial8250_console_fifo_write() directly writes into the
UART_TX register, rather than using the high-level function
serial8250_console_putchar(). This is because
serial8250_console_putchar() waits for the holding register to
become empty. That would defeat the purpose of the FIFO code.

Move the LSR_THRE waiting to a new function
serial8250_console_wait_putchar() so that the FIFO code can use
serial8250_console_putchar(). This will be particularly important
for a follow-up commit, where output bytes are inspected to track
newlines.

This is only refactoring and has no functional change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index adc48eeeac2b..8f7c9968ad41 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3268,11 +3268,16 @@ EXPORT_SYMBOL_GPL(serial8250_set_defaults);
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
@@ -3312,6 +3317,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 {
 	const char *end = s + count;
 	unsigned int fifosize = up->tx_loadsz;
+	struct uart_port *port = &up->port;
 	unsigned int tx_count = 0;
 	bool cr_sent = false;
 	unsigned int i;
@@ -3325,10 +3331,10 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 
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
@@ -3408,7 +3414,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (likely(use_fifo))
 		serial8250_console_fifo_write(up, s, count);
 	else
-		uart_console_write(port, s, count, serial8250_console_putchar);
+		uart_console_write(port, s, count, serial8250_console_wait_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
-- 
2.39.5

