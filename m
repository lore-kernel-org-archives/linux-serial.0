Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE122098
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329973; cv=none; b=F5uXah8EfedmjyWamTj0v32RfmVtzduuARDbrfj7uMdxtZccEa5ezwEifZF2WoOSAwhPlu3RkzKie0PSB4Xa4Ws0j/BJsZ+RJwe0hDVryNl66j+vFOELIJusIozZOeVuOWp7kJ/WZP9tsiXonfZSzr6nQhltF8+ez2SG2Jmk3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329973; c=relaxed/simple;
	bh=y5xpoIyunCZo8pZWw66B7Bmm7D6Ggt2M2grbviX3iKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5GZvA5XJI0ieL93Qd1C8dSErRSe2ASUga8msO0i82c5AtkDctHPeI3sfXE/44fA7SoDvttNEj8btZa5iHVOUV/RdE67cb05hEESfBDBOMekXRIJ8A8J4d1EG4URQVzbsp7zZRhjpKI0oObGL4ndFnu3HOZP4uIRunMcVvXUAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OuM36w8/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1GF65Qo8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OuM36w8/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1GF65Qo8"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uU/09Z2yXckVBdWhsFvdpwmXoXppERpLDZbklHxaGSY=;
	b=OuM36w8//gkcAhmojG/EfnkCSaY1NFYmUiYENAS28cc0ptuD+0hhwdY2a3tSEnFxwfkQiB
	6RUBdGiufq6wTCL7DmMMLhSCSo6ue6W8ef12wznrHV6GXj4As1+WdX5fC9NZ3NdYtZ5Gpl
	nz7EUZ5zgYzLS3inOqSdUg0+t/P8ERGORawSWDBidoRlYhpSyitLhL0tivAvHzXB8+2Aiq
	7zIOaD5zaGy3xKM5Md6mbmA85hePlAgHzYJ3PVt4HLNyH23+MAC5Iwf+cH8ofOaAQS3q3Y
	rUJrBfA9MgFXxAk85btf58BaeOl6KNfw1oiyaMVf/aXaIM9tcTq8EzH+EU6cFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uU/09Z2yXckVBdWhsFvdpwmXoXppERpLDZbklHxaGSY=;
	b=1GF65Qo8mo4mV/D68HUFJ/RZLwfPAj9ndnJW4tFgRtzWcNEZqjoFVm1awscLVMb/QJUE85
	sW4psdEEbW6dUQAg==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH 01/18] serial: amba-pl011: Use uart_prepare_sysrq_char().
Date: Fri,  1 Mar 2024 22:45:14 +0100
Message-ID: <20240301215246.891055-2-bigeasy@linutronix.de>
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

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/amba-pl011.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl01=
1.c
index cf2c890a560f0..2fa3fb30dc6c7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -348,10 +348,7 @@ static int pl011_fifo_to_tty(struct uart_amba_port *ua=
p)
 				flag =3D TTY_FRAME;
 		}
=20
-		uart_port_unlock(&uap->port);
-		sysrq =3D uart_handle_sysrq_char(&uap->port, ch & 255);
-		uart_port_lock(&uap->port);
-
+		sysrq =3D uart_prepare_sysrq_char(&uap->port, ch & 255);
 		if (!sysrq)
 			uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
 	}
@@ -1017,7 +1014,7 @@ static void pl011_dma_rx_callback(void *data)
 	ret =3D pl011_dma_rx_trigger_dma(uap);
=20
 	pl011_dma_rx_chars(uap, pending, lastbuf, false);
-	uart_port_unlock_irq(&uap->port);
+	uart_unlock_and_check_sysrq(&uap->port);
 	/*
 	 * Do this check after we picked the DMA chars so we don't
 	 * get some IRQ immediately from RX.
@@ -1540,11 +1537,10 @@ static void check_apply_cts_event_workaround(struct=
 uart_amba_port *uap)
 static irqreturn_t pl011_int(int irq, void *dev_id)
 {
 	struct uart_amba_port *uap =3D dev_id;
-	unsigned long flags;
 	unsigned int status, pass_counter =3D AMBA_ISR_PASS_LIMIT;
 	int handled =3D 0;
=20
-	uart_port_lock_irqsave(&uap->port, &flags);
+	uart_port_lock(&uap->port);
 	status =3D pl011_read(uap, REG_RIS) & uap->im;
 	if (status) {
 		do {
@@ -1573,7 +1569,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 		handled =3D 1;
 	}
=20
-	uart_port_unlock_irqrestore(&uap->port, flags);
+	uart_unlock_and_check_sysrq(&uap->port);
=20
 	return IRQ_RETVAL(handled);
 }
@@ -2322,13 +2318,10 @@ pl011_console_write(struct console *co, const char =
*s, unsigned int count)
=20
 	clk_enable(uap->clk);
=20
-	local_irq_save(flags);
-	if (uap->port.sysrq)
-		locked =3D 0;
-	else if (oops_in_progress)
-		locked =3D uart_port_trylock(&uap->port);
+	if (oops_in_progress)
+		locked =3D uart_port_trylock_irqsave(&uap->port, &flags);
 	else
-		uart_port_lock(&uap->port);
+		uart_port_lock_irqsave(&uap->port, &flags);
=20
 	/*
 	 *	First save the CR then disable the interrupts
@@ -2354,8 +2347,7 @@ pl011_console_write(struct console *co, const char *s=
, unsigned int count)
 		pl011_write(old_cr, uap, REG_CR);
=20
 	if (locked)
-		uart_port_unlock(&uap->port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&uap->port, flags);
=20
 	clk_disable(uap->clk);
 }
--=20
2.43.0

