Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105958AD4
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329976; cv=none; b=bXsF0LN2mHHHWcnFpb0VMPyUjgWZj9zlBt5rW0gCnPF8z+0eqy8ZioutNd45Hv2u/kOeUJ7ngmrAo0Mch8y8mjFx3wA9xa5FjiInLLa/qu9y0uJTT1nQUqtPZp+v2RbbSHXEsqLTVmqq05C6Lm/a+bXvJLUhjF61OYrPTQ0kmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329976; c=relaxed/simple;
	bh=Duj6Luz9qImDdou3gmsCC4s4kjyfZoeFPrWjuFz0b+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiUdNTwlgya01ngWNL835kR9WJevuMKmQb7lHY39VuSZJDcR9vJ5qqDWoV7Ey0R7dj2E+JFrCKtkTgYQkufq/kMZpozfXZ4nzLjqWZTY1uhtV1wGC4rISgK9FcjdDW0b+N8YasauBye4/qoex/cUYS6e4KCsm02YjLtbgcIBXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mcB7Yyax; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bogcD9kt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mcB7Yyax";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bogcD9kt"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTkKclahS1ExJZZt5oqxL5Ekjnu0SVXe0SPP0GVKmbk=;
	b=mcB7YyaxVUtCyFzFBd/GhDnjelnRqTpIs8hg0Gb3VA3PWtd21e8fFG8ne8u/L1nIJvlJaM
	UxVBab17CXO/BmikROOpRH9O0cQMtMHxHa00QUfvmYEWZ2WMyIG/6+it2AwpshyoUGcU48
	Ci0mFLioKgBqCwKzc5Tyauta+J1Ev7xw0UURc9eVwqP38Cs1zbHBCcQRXuOS6JBlH5WLAI
	oKLar+MjnPHnXK2gzI+HWkhLGQCMMWFfBmFuktYIBI1zJfMwnIhJhkIOrSCu9j8qVZEmn6
	2KyKq6LlW149ZBjOiskmZXzMz9yZahQHl4Y+OQv3E2Reb3SYU6dux6ygqut17Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTkKclahS1ExJZZt5oqxL5Ekjnu0SVXe0SPP0GVKmbk=;
	b=bogcD9ktH+t2AfDh7+fFHbWHIi+KV6nnU2eDs6c9BMfhRki33Mjz4wwgVIBXd5wnM3frsY
	iJJxNTphhwSgWCBA==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 07/18] serial: pxa: Use uart_prepare_sysrq_char().
Date: Fri,  1 Mar 2024 22:45:20 +0100
Message-ID: <20240301215246.891055-8-bigeasy@linutronix.de>
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
 drivers/tty/serial/pxa.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 46e70e155aab2..e395ff29c1a2c 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -151,7 +151,7 @@ static inline void receive_chars(struct uart_pxa_port *=
up, int *status)
 				flag =3D TTY_FRAME;
 		}
=20
-		if (uart_handle_sysrq_char(&up->port, ch))
+		if (uart_prepare_sysrq_char(&up->port, ch))
 			goto ignore_char;
=20
 		uart_insert_char(&up->port, *status, UART_LSR_OE, ch, flag);
@@ -232,7 +232,7 @@ static inline irqreturn_t serial_pxa_irq(int irq, void =
*dev_id)
 	check_modem_status(up);
 	if (lsr & UART_LSR_THRE)
 		transmit_chars(up);
-	uart_port_unlock(&up->port);
+	uart_unlock_and_check_sysrq(&up->port);
 	return IRQ_HANDLED;
 }
=20
@@ -604,13 +604,10 @@ serial_pxa_console_write(struct console *co, const ch=
ar *s, unsigned int count)
 	int locked =3D 1;
=20
 	clk_enable(up->clk);
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
 	 *	First save the IER then disable the interrupts
@@ -628,10 +625,8 @@ serial_pxa_console_write(struct console *co, const cha=
r *s, unsigned int count)
 	serial_out(up, UART_IER, ier);
=20
 	if (locked)
-		uart_port_unlock(&up->port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 	clk_disable(up->clk);
-
 }
=20
 #ifdef CONFIG_CONSOLE_POLL
--=20
2.43.0

