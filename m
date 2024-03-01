Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134358ADD
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329977; cv=none; b=scxXc6FsZOCWF+UKCdZQnUz0hL96JA1VNNR94bbOb2YcxM/vmBZJ7M3DKDr54OgRXs/beElumSrEyJNzdOlEheZHUyAshY4Zqq764gSFTJ7LhgXoLylSkMZagKCIj5xH5rK/0TwF4XLhHYbrESPIgfB/DD7xBZ4Krh9/Y8/tpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329977; c=relaxed/simple;
	bh=Z26sQXqoRz5d7FR7ubORTC35ekQGKh6UTTKavUvCI04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIRaFirKi8Rg+2mB7RdZNoDd4z3+kh4XV8qeDxOmyfTkhFN9x3QmaB1Fb94cT+g59Z6Lth+LibcF8XFa2+E2AQy4i+lEY/tp0kM3fgLvfGxcOg8hkMfcTn1ybK7AIeQxygo0EoPq+3A0FdTVRKUdWiEXzTVL1h0Wox6S2pnoVkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JQE6hsuD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=naHLAMDr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JQE6hsuD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="naHLAMDr"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNzlMgcB7Ml8SwiiDSy2k2m2CzXu6bUYS/NmyaqyVvY=;
	b=JQE6hsuD4GBq+eQWc1quSwSjrpKc+JJK9sl7nxnUK6YtebPrz+us/3ItDp3nCY+aXVJaKU
	J5MJhR1O4NE02wDDBMTp7Frme1R84yw2W/iDfnKVd0MMqpvy3BdFsr3vqgqqPDn4es10kC
	TOyr48sCvlSD/pFbbyFXjnDnK91V3ChT+Q9fVrelgUUXtnbE4HEGPq8OYEochRaUceNK+v
	dFcJq5HzvYjikpjiLO8Iuo6JjnQupfD/xM54Wyl6XVOYVpWn9SpxG6HCJNtcjUKc4XtldN
	ywzBmmqbm2xjS7QDlKCdwR1ANQEyAP4aUuWRQZeEvB2Umk1tlH/w91kfT28eZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNzlMgcB7Ml8SwiiDSy2k2m2CzXu6bUYS/NmyaqyVvY=;
	b=naHLAMDrbDn1VJoY3UrOJIMmXbzlyfLeNOfYuiezN0L9NJsU7IConNvIk0CYZk/r2oE0cR
	sOmLRPGu8VdeuICw==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/18] serial: lpc32xx_hs: Use uart_prepare_sysrq_char() to handle sysrq.
Date: Fri,  1 Mar 2024 22:45:22 +0100
Message-ID: <20240301215246.891055-10-bigeasy@linutronix.de>
In-Reply-To: <20240301215246.891055-1-bigeasy@linutronix.de>
References: <20240301215246.891055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The port lock is a spinlock_t which is becomes a sleeping lock on PREEMPT_R=
T.
The driver splits the locking function into two parts: local_irq_save() and
uart_port_lock() and this breaks PREEMPT_RT.

Handle sysrq requests sysrq once the port lock is dropped.
Remove the special case in the console write routine an always use the
complete locking function.

Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/lpc32xx_hs.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_h=
s.c
index ec20329f06036..e70fa59dbcc3b 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -136,20 +136,16 @@ static void lpc32xx_hsuart_console_write(struct conso=
le *co, const char *s,
 	int locked =3D 1;
=20
 	touch_nmi_watchdog();
-	local_irq_save(flags);
-	if (up->port.sysrq)
-		locked =3D 0;
-	else if (oops_in_progress)
-		locked =3D uart_port_trylock(&up->port);
+	if (oops_in_progress)
+		locked =3D uart_port_trylock_irqsave(&up->port, &flags);
 	else
-		uart_port_lock(&up->port);
+		uart_port_lock_irqsave(&up->port, &flags);
=20
 	uart_console_write(&up->port, s, count, lpc32xx_hsuart_console_putchar);
 	wait_for_xmit_empty(&up->port);
=20
 	if (locked)
-		uart_port_unlock(&up->port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 }
=20
 static int __init lpc32xx_hsuart_console_setup(struct console *co,
@@ -268,7 +264,8 @@ static void __serial_lpc32xx_rx(struct uart_port *port)
 			tty_insert_flip_char(tport, 0, TTY_FRAME);
 		}
=20
-		tty_insert_flip_char(tport, (tmp & 0xFF), flag);
+		if (!uart_prepare_sysrq_char(port, tmp & 0xff))
+			tty_insert_flip_char(tport, (tmp & 0xFF), flag);
=20
 		tmp =3D readl(LPC32XX_HSUART_FIFO(port->membase));
 	}
@@ -333,7 +330,7 @@ static irqreturn_t serial_lpc32xx_interrupt(int irq, vo=
id *dev_id)
 		__serial_lpc32xx_tx(port);
 	}
=20
-	uart_port_unlock(port);
+	uart_unlock_and_check_sysrq(port);
=20
 	return IRQ_HANDLED;
 }
--=20
2.43.0

