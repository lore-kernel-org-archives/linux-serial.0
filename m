Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410AB58AD7
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329976; cv=none; b=UCbGvVPNvSXizEPxqVdAs90EM1KT1KgUxX46LYjoCwwWENJ+O0B4U8KyfyhigcxgA1lTkz+nzGtMFKKux+g12ipfY90fsEH+ww7Jjr0sbdDF51Zhin+LV8Y4H6UIyZA+LhnLARUraTC8WjWXi9TRbYSuaviLKJCtGwH8oJDtm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329976; c=relaxed/simple;
	bh=PV8zmysWU6NKef6+WG93PWkFDYIEgZyYBwnADe5OGvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4PchC9r8tToCvatV1uZxCu7+L9iOO2Cv+51Y2WoGgWOUkv41C9yJ+SrO9lCcWbOBNVfWVi5M4CGu5HugwVCuZTjM5lAcUlcrvnGw1V/aCmp9N3vBDGYteE4poOlpOck3iSfEV8hCuhnolno+jD8d3IpXeBuchFjtCU5isrAkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l8BPYWC+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3SuRw3NY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l8BPYWC+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3SuRw3NY"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfrtyH8jEy/aviKS2/H/q8f4mQwnYfUS4DMZuSDZ9aI=;
	b=l8BPYWC+G0hKGAoMf9J8gp8c1QtpaO+6hGYFV1EQOp8xpqJI6Lhegfm3GPzNlGecjKzKqX
	Kx/Lo14Gi7k6Fi4rJiGWQTZgfMER8UcDB4K2JFa4kqNmenLX1lWLKhgqqSlFgceSQDG28H
	fq+Wqm0DJHhw2fmLq7oBfmM721WXZYJ5u2FYmDSjbcgiIJEOltTPtZ5v2UjC0RhxFdjgND
	KI+aMjU5j5efVOIppxH8O4zjosJSGRwtW+LSOUKSGYcJMbO81MzhL00bq+UTdudKWFGcjy
	RFvt5d/aNc3Cf2pR2K5SvKXK/okl7k9TixKR9uyie99itYKoo5ZnFXdgtIvv4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfrtyH8jEy/aviKS2/H/q8f4mQwnYfUS4DMZuSDZ9aI=;
	b=3SuRw3NYo0NvklGJxJe4pkkM6/pEPDPQ0CZoiUhwL1uIhAs43/hJtBQHqfKnt1O3bB0uX/
	3kld/OzridmeFMBw==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH 08/18] serial: sunplus: Use uart_prepare_sysrq_char().
Date: Fri,  1 Mar 2024 22:45:21 +0100
Message-ID: <20240301215246.891055-9-bigeasy@linutronix.de>
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

Delay handling sysrq until port lock is dropped.
Remove the special case in the console write routine an always use the
complete locking function.

Cc: Hammer Hsieh <hammerh0314@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/sunplus-uart.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus=
-uart.c
index 99f5285819d4b..f5e29eb4a4ce4 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -260,7 +260,7 @@ static void receive_chars(struct uart_port *port)
 		if (port->ignore_status_mask & SUP_DUMMY_READ)
 			goto ignore_char;
=20
-		if (uart_handle_sysrq_char(port, ch))
+		if (uart_prepare_sysrq_char(port, ch))
 			goto ignore_char;
=20
 		uart_insert_char(port, lsr, SUP_UART_LSR_OE, ch, flag);
@@ -287,7 +287,7 @@ static irqreturn_t sunplus_uart_irq(int irq, void *args)
 	if (isc & SUP_UART_ISC_TX)
 		transmit_chars(port);
=20
-	uart_port_unlock(port);
+	uart_unlock_and_check_sysrq(port);
=20
 	return IRQ_HANDLED;
 }
@@ -512,22 +512,16 @@ static void sunplus_console_write(struct console *co,
 	unsigned long flags;
 	int locked =3D 1;
=20
-	local_irq_save(flags);
-
-	if (sunplus_console_ports[co->index]->port.sysrq)
-		locked =3D 0;
-	else if (oops_in_progress)
-		locked =3D uart_port_trylock(&sunplus_console_ports[co->index]->port);
+	if (oops_in_progress)
+		locked =3D uart_port_trylock_irqsave(&sunplus_console_ports[co->index]->=
port, &flags);
 	else
-		uart_port_lock(&sunplus_console_ports[co->index]->port);
+		uart_port_lock_irqsave(&sunplus_console_ports[co->index]->port, &flags);
=20
 	uart_console_write(&sunplus_console_ports[co->index]->port, s, count,
 			   sunplus_uart_console_putchar);
=20
 	if (locked)
-		uart_port_unlock(&sunplus_console_ports[co->index]->port);
-
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&sunplus_console_ports[co->index]->port, fla=
gs);
 }
=20
 static int __init sunplus_console_setup(struct console *co, char *options)
--=20
2.43.0

