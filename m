Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E758AD1
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329976; cv=none; b=S0nVjkn7e+0SlYcuK0w+Q8wgtKzTL+s92nHZiLQx2f2T4sej8IGPlqBNUDiPffTV2wFnQl04I3orTql5UmUTlvbxLQ0DynY1XZcz7KiXYF3/Hd8VCZcXTunonffWCjyaI44ZVbfFTMRliiaP4ejHd0grEB8SoN2eXQMuacux8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329976; c=relaxed/simple;
	bh=d0+vsfDJBJUqS2Fkhl3INsvp+GpH/URMcC4GhMT1Fgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB+UrLuUbsKejkR/JeA/IXzvec3xLl4dTL2IYLnBH3zikqBNMlD3BUllkIxI44laVJe9Iag0ClnBRpDRtNdJeZbK0cQ6dpLwKLlWCBFZRZuU1+AQSy+tOvigyeNHdRWYz0r+HBDltfugA7TsfZrPxxxxTmy8sU15yEjndkOTP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=btylfPwW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5S1ziX4Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="btylfPwW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5S1ziX4Z"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neIqKSHS/D/i5nWAr8RrJwghx1+ApKIn7UCJC7a4zDI=;
	b=btylfPwWS9W4OhA7XC7wc2BZuaBJ7KjLDHmIDK9/iQlLfh8DtSq8ZJnxWWSs50h/nmjqaG
	VeYJoS+++sbC4Jxc0NNKxTRC0Hqg1WBJmxOni05IPfsO+2a8pv1qU3v4cFz3/yfLAvmLqH
	NMdOrjHmMdhlQ+JdiFBCLhsQ0zCIwUpOCdBwoFfx/5SVIsWg2gK4b2mvmx6ekaxWNQ8pf1
	L2lxxxt9JaLtLKK40PJUd/LbX0TuMIZoqfBuw5aVcc/IgxhtSY4L3J7phaqlUUAMojUcZZ
	e/gXEaeS9s0o4W8TtVQg7K3lGew4qZimwvlSrdOxvLKgiZs5lrnEITB+W5jw7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neIqKSHS/D/i5nWAr8RrJwghx1+ApKIn7UCJC7a4zDI=;
	b=5S1ziX4ZKs4Y/mf1jyZJiT7B2ElYQ1p2EVaXdPDGya0A/BwtKZZhUsxdxjNgxkeJ3Siymg
	uY/BeBEDnSZszoCQ==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/18] serial: omap: Use uart_prepare_sysrq_char().
Date: Fri,  1 Mar 2024 22:45:19 +0100
Message-ID: <20240301215246.891055-7-bigeasy@linutronix.de>
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/omap-serial.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-ser=
ial.c
index f5a0b401af63b..9be1c871cf116 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -508,7 +508,7 @@ static void serial_omap_rdi(struct uart_omap_port *up, =
unsigned int lsr)
=20
 	up->port.icount.rx++;
=20
-	if (uart_handle_sysrq_char(&up->port, ch))
+	if (uart_prepare_sysrq_char(&up->port, ch))
 		return;
=20
 	uart_insert_char(&up->port, lsr, UART_LSR_OE, ch, TTY_NORMAL);
@@ -563,7 +563,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_i=
d)
 		}
 	} while (max_count--);
=20
-	uart_port_unlock(&up->port);
+	uart_unlock_and_check_sysrq(&up->port);
=20
 	tty_flip_buffer_push(&up->port.state->port);
=20
@@ -1212,13 +1212,10 @@ serial_omap_console_write(struct console *co, const=
 char *s,
 	unsigned int ier;
 	int locked =3D 1;
=20
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
 	/*
 	 * First save the IER then disable the interrupts
@@ -1245,8 +1242,7 @@ serial_omap_console_write(struct console *co, const c=
har *s,
 		check_modem_status(up);
=20
 	if (locked)
-		uart_port_unlock(&up->port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 }
=20
 static int __init
--=20
2.43.0

