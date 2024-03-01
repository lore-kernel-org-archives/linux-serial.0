Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31B5916A
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329979; cv=none; b=Gf9opYLh+LO15eKp0hN9OrfrNpdbY7HTs0goRLrSqxYAAdJHOkFRBwp2a572qd5rsDOQ95XBwMRVptgQA2pHbJvVsODjoHpquMuRPEfyEsNULVLf9nIaF65GyONI5oeqgny92qSrOjllKwRJMWvfrZjkeU+XbNGxSOwTKYIj5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329979; c=relaxed/simple;
	bh=TRua4hwsyKAOaNTpok6CuR9EPO46jceuHAEu7jLMil4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT+U1jxj3/U6+EIdkN6QlQl++Y4BhhhD8xsaGAsvmGEXMiYsw3t/pF2CBgfohi3a6+l4JQPTrBrzCn74i4SNmmmBy4vfK0cYXTwTIvPKmXPH5CcWnR48kUws8foi7x/Y7zA7+ouTsHMK1W4n0keAeyqiB+IwB4/jeJowO8tsETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G8lnie70; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mZROY3e1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G8lnie70";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZROY3e1"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOJuLzQLDJioNQIKELQPhw/86A1haCxeVutu0Df82AU=;
	b=G8lnie70jQEUnLtjpojJCSXjo08zJjviSEhHVTVWT8sMxU5r4IQIA1ptxiinYX6d7vfsdx
	ZqX7mQx43oA/p/1BC1gbL956aZia0ivyQl8+uml52WHcy0llKXwMtNLlEA5KdrHDZEvDWR
	lopfxrx504rG9MM/RRocACW7hx+DdpLydw7mrtv+Y8Hb4Pmp4cwQ95JZuvLFkX+qr6D648
	P5ZcBUxGLC3WO2/6C3jYPvs9P1FjzfaqQL3aDg4o5o1xvpRVjNTn6zCdeLq26RZk8Zl9IY
	YZiBAKNng2xcCeINYvdNwosUcsThSX4cgRQwTpTcj7v5HpEzHgyif11t19L84g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOJuLzQLDJioNQIKELQPhw/86A1haCxeVutu0Df82AU=;
	b=mZROY3e137rCOKQ5IsrCs8L9+EHN5vF1W0d0ODo7/spCVMdV2Ta6KWCwO1nv/9+supikBv
	jKaOTWhCaljADGDg==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 18/18] serial: pch: Use uart_prepare_sysrq_char().
Date: Fri,  1 Mar 2024 22:45:31 +0100
Message-ID: <20240301215246.891055-19-bigeasy@linutronix.de>
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
 drivers/tty/serial/pch_uart.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 92cb3c623cc31..89257cddf5405 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -564,7 +564,7 @@ static int pch_uart_hal_read(struct eg20t_port *priv, u=
nsigned char *buf,
 			if (uart_handle_break(port))
 				continue;
 		}
-		if (uart_handle_sysrq_char(port, rbr))
+		if (uart_prepare_sysrq_char(port, rbr))
 			continue;
=20
 		buf[i++] =3D rbr;
@@ -1070,7 +1070,7 @@ static irqreturn_t pch_uart_interrupt(int irq, void *=
dev_id)
 		handled |=3D (unsigned int)ret;
 	}
=20
-	uart_port_unlock(&priv->port);
+	uart_unlock_and_check_sysrq(&priv->port);
 	return IRQ_RETVAL(handled);
 }
=20
@@ -1550,22 +1550,17 @@ pch_console_write(struct console *co, const char *s=
, unsigned int count)
 {
 	struct eg20t_port *priv;
 	unsigned long flags;
-	int port_locked =3D 1;
+	int locked =3D 1;
 	u8 ier;
=20
 	priv =3D pch_uart_ports[co->index];
=20
 	touch_nmi_watchdog();
=20
-	local_irq_save(flags);
-	if (priv->port.sysrq) {
-		/* serial8250_handle_port() already took the port lock */
-		port_locked =3D 0;
-	} else if (oops_in_progress) {
-		port_locked =3D uart_port_trylock(&priv->port);
-	} else {
-		uart_port_lock(&priv->port);
-	}
+	if (oops_in_progress)
+		locked =3D uart_port_trylock_irqsave(&priv->port, &flags);
+	else
+		uart_port_lock_irqsave(&priv->port, &flags);
=20
 	/*
 	 *	First save the IER then disable the interrupts
@@ -1583,9 +1578,8 @@ pch_console_write(struct console *co, const char *s, =
unsigned int count)
 	wait_for_xmitr(priv, UART_LSR_BOTH_EMPTY);
 	iowrite8(ier, priv->membase + UART_IER);
=20
-	if (port_locked)
-		uart_port_unlock(&priv->port);
-	local_irq_restore(flags);
+	if (locked)
+		uart_port_unlock_irqrestore(&priv->port, flags);
 }
=20
 static int __init pch_console_setup(struct console *co, char *options)
--=20
2.43.0

