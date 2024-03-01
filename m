Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FE58ADB
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329977; cv=none; b=aum0c3dbwOBJ1mAQnOFdRhj9/Y28pBRUDuTRpZnqnKFsiHzCyb84PZPrmrZdZ435rywHp84UIYEay2MidYzOfTwcIftciJP99MIHAq3O2by++lTafC0hXKM+byyvxtTtTRRvmbe2yAEKBsdRy+Q20ISbKip0XEBJj8y9i0HWdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329977; c=relaxed/simple;
	bh=VMH61/tHRAbj2Ekc0mQyrj2xuDBqI7ViaojJrJByZW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9Q+ZNCas9x8plw6OedHJOnZAQfaRF4qznYkXESohucvqxaq7ejrTGiqo+LEI7uPaxEdowc8JA40CLXjNYFEERmY5nIm8qIf07zAMxdlWwlIjHUbIWv/GqhMTuMCcFYY26evmylYa8Zrbo9lY8/kdBrhgZJICeLwMyLwH8VoXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYeW/M1O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VXU5xXqD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYeW/M1O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VXU5xXqD"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tledTIFDDr1sldln/W0Iqtq8p3bbY99HUvZ3jjp5lks=;
	b=DYeW/M1ORa4YklCaqL330/U85u/jJ+vZdIf5XzcCr1ZY8J/qa4tkUvBtBUyrosws1Hp3ox
	fGCNR3vwyXJH7mvvWemhuptLbwbDMIpZNfXelPUl85mEdRWx1JZ6P/9Wws6Fk/Hfg0cbMw
	gfHmTsKbtOCui97hgqP+kSTDOdz40MB+Ygiql02qRl61ZregVOlBI3Uo5/Rl0d98bjlV9S
	i2AiEKCIeGaop0mWb1xOTnHdNeCXSPavl4SdFCES7EmT++cWQjoA8JyNAGaFt1p+GHwIXk
	FNCI8PqstTDTWvZEdrC4uIG6lrukcv50FKN4Ygl8Tez7tdf3V3VTZ5qT0bUZXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tledTIFDDr1sldln/W0Iqtq8p3bbY99HUvZ3jjp5lks=;
	b=VXU5xXqD7rHLIprKYFCb/dOHvMV74MKNJXd1UQwUXThVIFJHiP3eKZA1Gmxa9738uXpO2Y
	8jYRQNUskQ+VH8CA==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org
Subject: [PATCH 11/18] serial: rda: Use uart_prepare_sysrq_char() to handle sysrq.
Date: Fri,  1 Mar 2024 22:45:24 +0100
Message-ID: <20240301215246.891055-12-bigeasy@linutronix.de>
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

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-unisoc@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/rda-uart.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 13deb355cf1bc..82def9b8632a5 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -394,7 +394,8 @@ static void rda_uart_receive_chars(struct uart_port *po=
rt)
 		val &=3D 0xff;
=20
 		port->icount.rx++;
-		tty_insert_flip_char(&port->state->port, val, flag);
+		if (!uart_prepare_sysrq_char(port, val))
+			tty_insert_flip_char(&port->state->port, val, flag);
=20
 		status =3D rda_uart_read(port, RDA_UART_STATUS);
 	}
@@ -405,10 +406,9 @@ static void rda_uart_receive_chars(struct uart_port *p=
ort)
 static irqreturn_t rda_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port =3D dev_id;
-	unsigned long flags;
 	u32 val, irq_mask;
=20
-	uart_port_lock_irqsave(port, &flags);
+	uart_port_lock(port);
=20
 	/* Clear IRQ cause */
 	val =3D rda_uart_read(port, RDA_UART_IRQ_CAUSE);
@@ -425,7 +425,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 		rda_uart_send_chars(port);
 	}
=20
-	uart_port_unlock_irqrestore(port, flags);
+	uart_unlock_and_check_sysrq(port);
=20
 	return IRQ_HANDLED;
 }
@@ -590,18 +590,12 @@ static void rda_uart_port_write(struct uart_port *por=
t, const char *s,
 {
 	u32 old_irq_mask;
 	unsigned long flags;
-	int locked;
+	int locked =3D 1;
=20
-	local_irq_save(flags);
-
-	if (port->sysrq) {
-		locked =3D 0;
-	} else if (oops_in_progress) {
-		locked =3D uart_port_trylock(port);
-	} else {
-		uart_port_lock(port);
-		locked =3D 1;
-	}
+	if (oops_in_progress)
+		locked =3D uart_port_trylock_irqsave(port, &flags);
+	else
+		uart_port_lock_irqsave(port, &flags);
=20
 	old_irq_mask =3D rda_uart_read(port, RDA_UART_IRQ_MASK);
 	rda_uart_write(port, 0, RDA_UART_IRQ_MASK);
@@ -615,9 +609,7 @@ static void rda_uart_port_write(struct uart_port *port,=
 const char *s,
 	rda_uart_write(port, old_irq_mask, RDA_UART_IRQ_MASK);
=20
 	if (locked)
-		uart_port_unlock(port);
-
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
=20
 static void rda_uart_console_write(struct console *co, const char *s,
--=20
2.43.0

