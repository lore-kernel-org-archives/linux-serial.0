Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564B1B412A;
	Mon, 16 Dec 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369169; cv=none; b=tgnvaC89zCEK5Ab3H/dU41FeBmIJ8mzfO8mc70DA2WN5rfXj8yyq0SgNHTCr//iwW1P/w1pjuHA1EaJX5N73vVYoAJccJ8znaPLjIXPJTO3+6sYkhi2XzKVjUXB0DSVKaH/EH8ch7bfAosvUD0lZnYc86w9pWLkt0vFTH+zM1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369169; c=relaxed/simple;
	bh=9ulM/VLZgmh6Vb61H3gobPJULnBEd94G/t+5gQOobO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIkjfAqkULFUsKl+qIXBaCSdoWLcyDC4NeNhV45TqAN3zIwZLNE0S1ylyMobAh3v9ru2ck8kvZjEdzPPsCJf7iVIc/HxrAZW+f0AuK3FFLT/yXbmwA+De8Puxl0Bz+/v44DBVWeO5yntIxBxeYjRfTQQNwC7TL1Jmtj+MjTxYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZVZKCP/s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iL1Jf2wy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZVZKCP/s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iL1Jf2wy"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734369166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHekKzUh6KDzBa4Wm/wnMVOz430Naq4Xufxov1IYktQ=;
	b=ZVZKCP/sC7pSSh58XjkURjnz0P+SeKRcufTrVly1ZJqqlHUKmrtq9qofVVmpWXdZAY0Yn3
	Rjpq5gO+BM7WAmgjqrazXBXYzrV0po4FTh/YgszxQr3cwcOCKAqUIICcBALL30lSuDscmC
	TEuA5fhW+MpMDz6YwuNrXV65RNPwmx1i/Rd8pry/AkmVZljT04oi0auxBvQG6tVp1xOwCq
	z0r5V5bI5Y1omlke6Ae/Undfns3ccPWdGe8AAi7Br7vVHkASnpcf/GnSwrnmx2pKsFUv2C
	OZOOXr2AkfqozNatVQhBmU53Ma5ekgdPxzFnI3iW7M8nnRBoLDnv+pyqJf+jEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734369166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHekKzUh6KDzBa4Wm/wnMVOz430Naq4Xufxov1IYktQ=;
	b=iL1Jf2wySkY85dB3YmsPSfqZLtfb/Nz/3G2uOCp9qAftgnocBHLyIYgT+EwarUX9q4BxAE
	flmXPleQcV62gCDQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Peter Collingbourne <pcc@google.com>
Subject: [PATCH tty-next v1 2/4] serial: 8250: Do not set UART_LSR_THRE in @read_status_mask
Date: Mon, 16 Dec 2024 18:18:42 +0106
Message-Id: <20241216171244.12783-3-john.ogness@linutronix.de>
In-Reply-To: <20241216171244.12783-1-john.ogness@linutronix.de>
References: <20241216171244.12783-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Linux 2.1.8 @read_status_mask is no longer used as a
general control of which bits are used from the LSR register.
Instead it has become an additional mask applied to
@ignore_status_mask. Since UART_LSR_THRE is never set for
@ignore_status_mask, it serves no purpose to set it for
@read_status_mask. In fact, it propagates the misconception
that @read_status_mask can be used as a general mask for LSR
bits.

Do not set UART_LSR_THRE for @read_status_mask.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 drivers/tty/serial/8250/8250_port.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 9eb9aa766811..5290aed76a5e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -412,7 +412,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	up->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+	up->port.read_status_mask = UART_LSR_OE | UART_LSR_DR;
 	if (termios->c_iflag & INPCK)
 		up->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
 	if (termios->c_iflag & (IGNBRK | PARMRK))
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4d742bfb7e9a..a5c1b069c67b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2786,7 +2786,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	port->read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+	port->read_status_mask = UART_LSR_OE | UART_LSR_DR;
 	if (termios->c_iflag & INPCK)
 		port->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-- 
2.39.5

