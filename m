Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C55155CB3;
	Fri, 27 Dec 2024 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735339534; cv=none; b=u9WfkBHf2VxDtrzXUkQv69trjz0gcyXnW0DIzYPl7gy646j/4wS2WhhsMEnlwPxb/rTgy/LF485fckCUkDCgAmxPM2zlUuB/vVcitwHPtr20YS5pbnTS5Gnstp+jDbQHcjOy1kRfRtO9ZqNFPt+74mEzCWnVAvf8J5elzuV7hFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735339534; c=relaxed/simple;
	bh=847dnAyEyJU9u4HAy5/kzMTmcQ7OLra1Lu+DFPIQlm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N0rbX6n6EPPy0irmSXV28lx7+LWW/p4/cRXXVhKyhyDXd52QIEpOMlNCHUaxFQhcq35v5y95cyWaGO+76rCjp21zHVn09UTCrqrQgejXDkwPfWt+icQa16cBQcwxXci55auyyKpCVheCtAuRXY5K1SFtPRxzze4TvM3h6AWghFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=abxtdc+e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dddETy03; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="abxtdc+e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dddETy03"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735339525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRm5QPZ8g+hOoTns/vkCG62fDERJWECzx09fOxeCZMk=;
	b=abxtdc+eMP8oYVqwVJeHXRvtPnQmU1MZod0+tFOPuDfF83vdhKffvhAzTqmQN6fqZdjKek
	yOavVJ3l7/HxVCMEIrSDtLadM0t/c8iZuzAC1lekGKfNLhL24yKYDpI2atx4OZ8wgNGoy6
	zMszJ7W6NxBYLxAX9djCohlbOgvSQ/29OsTIE9rGSZCu/3uD3RQ+WNHzDb31613kngHU4u
	/qaKrWHYfYg9Q1W9IYcaYdkCbiuff5TqZNBHp1YbTn1k6ESCCpEWKzzx6Wktday6o2aqjk
	6gskrXzhQ5C+JtfyBU6Ni7t5HeqjDwfWef6l3t+tZWlALUV5/zoIVlnQIS2Q+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735339525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRm5QPZ8g+hOoTns/vkCG62fDERJWECzx09fOxeCZMk=;
	b=dddETy03MjCIrFxjUMsaYMPUU1IdZScxuXGOHH1Dq7z6pQFZ9TFZooA0DHRa+71Hxie0d3
	Ggw+Uq0g1iIFg4AA==
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
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH tty-next v4 3/6] serial: 8250: Use high-level writing function for FIFO
Date: Fri, 27 Dec 2024 23:51:19 +0106
Message-Id: <20241227224523.28131-4-john.ogness@linutronix.de>
In-Reply-To: <20241227224523.28131-1-john.ogness@linutronix.de>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
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
index aeacf9d452e4..812f003c252d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3297,11 +3297,16 @@ EXPORT_SYMBOL_GPL(serial8250_set_defaults);
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
@@ -3351,6 +3356,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 {
 	const char *end = s + count;
 	unsigned int fifosize = up->tx_loadsz;
+	struct uart_port *port = &up->port;
 	unsigned int tx_count = 0;
 	bool cr_sent = false;
 	unsigned int i;
@@ -3361,10 +3367,10 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 
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
@@ -3444,7 +3450,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (likely(use_fifo))
 		serial8250_console_fifo_write(up, s, count);
 	else
-		uart_console_write(port, s, count, serial8250_console_putchar);
+		uart_console_write(port, s, count, serial8250_console_wait_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
-- 
2.39.5

