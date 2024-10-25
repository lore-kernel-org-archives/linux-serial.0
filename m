Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833D22B65A;
	Fri, 25 Oct 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853854; cv=none; b=YGFmsGf8S5E4O4xmwg2nxrzxRe8CAOm1RuO+CJMysuxbivzQJ5gctrSEigPf3CKpwJQxT0rtENTw+zzl4LbqUQ0m0udmf6MdEjdbso0pEjL0YCrA2oRVJ7HDPxdtwgzYUCi5GdrCD9W7tCWQdfxXJBRBFnsam18pNzoPoUIOWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853854; c=relaxed/simple;
	bh=PBj2BP4NeY2S1hM+Iyobipy6hAiL2dOKPCN9j5DWbdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+FE0bDV7QzbxgU1u/lqJS2dg/3IfCEf9JfS1c9md8zUU1S+GdK53dn+xWo5Ego4o9ZKtwzQ5FGMZiJRreICfiNv9OLOqlsGUeWOYgnYNuioK3w/VuExUP4h1La95oFKa0LdCF6sinFTbsNd1nB/S2es06kOVZR+iTDu1Ftd7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wSw70WpB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Z0Cl54o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wSw70WpB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Z0Cl54o"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729853850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4p/TMBIF+40aWKwCg6mhGWi1HCgLwJELTVe/GEMslzk=;
	b=wSw70WpBb/F3DXSghnDsWjzEU05DO2cspdnqmTn9OmN0zFBUrqpbM4qLY29gZ5mOt/hr03
	mxoWuF/ZGOgbNYyw76/Iuc2Xyxc1ti3hiVktXleti7Yg8aLEDarLdU9zBgmE0Ou2ZZMN8Z
	Q3iUxOIbhU+AID4q52l+0wRLrce3VMJMiBEX8FHjMwvn4bKqkRL3SiaIsh4loBRyk2APYw
	GEiaX74vXVJ5+alvSKXJ+kcxjMlF8CfbigCJyiDli+eKVNhpNDn846NHd3mI2XSCesZsHu
	MmyFgOxRiaCRNqSPkRY7PRLKeDr9vhIi9WnC/aKtKW5mHNRo7ErLmAWacolg4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729853850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4p/TMBIF+40aWKwCg6mhGWi1HCgLwJELTVe/GEMslzk=;
	b=/Z0Cl54oRWaU1yrSCt1Kjyct/3vz+0IUMHIn+v60lSvb+9Zjr5LVB/zKFpxTsdey742+FF
	cTwd6zGQazskO0CQ==
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
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for FIFO mode
Date: Fri, 25 Oct 2024 13:03:23 +0206
Message-Id: <20241025105728.602310-2-john.ogness@linutronix.de>
In-Reply-To: <20241025105728.602310-1-john.ogness@linutronix.de>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a console has fed a line into TX, it uses wait_for_xmitr()
to wait until the data has been sent out before returning to the
printk code. However, wait_for_xmitr() will timeout after 10ms,
regardless if the data has been transmitted or not.

For single bytes, this timeout is sufficient even at very slow
baud rates, such as 1200bps. However, when FIFO mode is used,
there may be 64 bytes pushed into the FIFO at once. At a baud
rate of 115200bps, the 10ms timeout is still sufficient.
However, when using lower baud rates (such as 57600bps), the
timeout is _not_ sufficient. This causes longer lines to be cut
off, resulting in lost and horribly misformatted output on the
console.

When using FIFO mode, take the number of bytes into account to
determine an appropriate max timeout. Increasing the timeout
does not affect performance since ideally the timeout never
occurs.

Fixes: 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3509af7dc52b..adc48eeeac2b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2059,11 +2059,12 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	serial8250_rpm_put(up);
 }
 
-static void wait_for_lsr(struct uart_8250_port *up, int bits)
+/* Returns true if @bits were set, false on timeout. */
+static bool wait_for_lsr(struct uart_8250_port *up, int bits)
 {
 	unsigned int status, tmout = 10000;
 
-	/* Wait up to 10ms for the character(s) to be sent. */
+	/* Wait up to 10ms for the character to be sent. */
 	for (;;) {
 		status = serial_lsr_in(up);
 
@@ -2074,10 +2075,13 @@ static void wait_for_lsr(struct uart_8250_port *up, int bits)
 		udelay(1);
 		touch_nmi_watchdog();
 	}
+
+	return (tmout != 0);
 }
 
 /*
  *	Wait for transmitter & holding register to empty
+ *	with timeout
  */
 static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 {
@@ -3306,13 +3310,18 @@ static void serial8250_console_restore(struct uart_8250_port *up)
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
+		/* Allow timeout for each byte of a possibly full FIFO. */
+		for (i = 0; i < fifosize; i++) {
+			if (wait_for_lsr(up, UART_LSR_THRE))
+				break;
+		}
 
 		for (i = 0; i < fifosize && s != end; ++i) {
 			if (*s == '\n' && !cr_sent) {
@@ -3323,6 +3332,13 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 				cr_sent = false;
 			}
 		}
+		tx_count = i;
+	}
+
+	/* Allow timeout for each byte written. */
+	for (i = 0; i < tx_count; i++) {
+		if (wait_for_lsr(up, UART_LSR_THRE))
+			break;
 	}
 }
 
-- 
2.39.5

