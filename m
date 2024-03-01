Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBEF57873
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329974; cv=none; b=njE4XDmXzoNifH+sjETCAonmObSkoTRMB0aamv1b3lj62ft225QF1ctLqLqvjv8k2fLSgwUW3QGFgMp93kjnWN4TuNA0El2mUSuu8bcENUH2CE9wSGXWprJdkfFtg0PlHhmHGrDmpJlxpe1hC60CygAcjg9vbpVJOrWz0rxKIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329974; c=relaxed/simple;
	bh=vt9PBEtGbohZDGrGc4PLnmYjZUk1n9QtGVrTPVAxhyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ai5+/eww/pkCYErGrpcleZx9RM1LqJZZRdudblMClLD04SFsKrcjpW0ZeL2U+bKrK2Iw2ZGaEtYHDYMhXEpfowMH1RTQtjLr/TKC8ZqnOIHHaGvA/MkJpO8GW2kGzttSXTCjmrctdrelDAH+C2bhw+50J2TzfxCbWLKCLsGHWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gsXiTTmu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GfLsnBuT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gsXiTTmu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GfLsnBuT"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0wQNW0zEI8swe9n40nxYYuKvTQNfbOQZBPRnKtnIEk=;
	b=gsXiTTmuxhZpmQOghewy9Y617Dl1pm1ASBlUnSBMW1bJ2hxAUG8LlcsBiT41dYGR0gwk+g
	zR2+rxmmUAOJ64baRHrlo6BVpBcH0yPxBcHyIQT+xoXJCQaH8cnLRPT5WAFFaPR+wv7QU9
	vn1WQ0zt8RlRkHoXLIgrdM1Tqz2VHfG9v6U/zZL6uLz0OmiX8csNVij9ydDn8KHkBQ6Nr7
	sNplJ3mn6hXB2V6IQeeGOc1BIGwYVBj+g57xr2egoX+vNW60l2yepn2RIfVhQG7OLzYqJo
	GJgRgEZNvhSYSzlBTRR8rQvMJfSeHZ/2Mh3ygzqgfC+YDXsz41ehDbsjdOCRkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0wQNW0zEI8swe9n40nxYYuKvTQNfbOQZBPRnKtnIEk=;
	b=GfLsnBuT4TCymPLvf91/y2bIaxkF68ngJeoYhNqf67Blhgmp6GohAhSi7d+eA1AI6h2GWr
	P+C1ylMMh2QKbhDg==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 02/18] serial: ar933x: Use uart_prepare_sysrq_char().
Date: Fri,  1 Mar 2024 22:45:15 +0100
Message-ID: <20240301215246.891055-3-bigeasy@linutronix.de>
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
 drivers/tty/serial/ar933x_uart.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_u=
art.c
index 8d09ace062e59..7790cbc57391a 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -378,7 +378,7 @@ static void ar933x_uart_rx_chars(struct ar933x_uart_por=
t *up)
 		up->port.icount.rx++;
 		ch =3D rdata & AR933X_UART_DATA_TX_RX_MASK;
=20
-		if (uart_handle_sysrq_char(&up->port, ch))
+		if (uart_prepare_sysrq_char(&up->port, ch))
 			continue;
=20
 		if ((up->port.ignore_status_mask & AR933X_DUMMY_STATUS_RD) =3D=3D 0)
@@ -468,7 +468,7 @@ static irqreturn_t ar933x_uart_interrupt(int irq, void =
*dev_id)
 		ar933x_uart_tx_chars(up);
 	}
=20
-	uart_port_unlock(&up->port);
+	uart_unlock_and_check_sysrq(&up->port);
=20
 	return IRQ_HANDLED;
 }
@@ -627,14 +627,10 @@ static void ar933x_uart_console_write(struct console =
*co, const char *s,
 	unsigned int int_en;
 	int locked =3D 1;
=20
-	local_irq_save(flags);
-
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
@@ -654,9 +650,7 @@ static void ar933x_uart_console_write(struct console *c=
o, const char *s,
 	ar933x_uart_write(up, AR933X_UART_INT_REG, AR933X_UART_INT_ALLINTS);
=20
 	if (locked)
-		uart_port_unlock(&up->port);
-
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 }
=20
 static int ar933x_uart_console_setup(struct console *co, char *options)
--=20
2.43.0

