Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3258AA5
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329974; cv=none; b=LvbemLDUYrOGzlGCD+lCxbn06PCOP17bU8gJO6HN4D37RnVm711raok9w8yg7/n/ZnOSE1lrObs1NzuNNwDNx81pguqFChqw5Mmj6YTyso58q+8m0HEtBY1xILC1Oro/5b2JDlZPYYyB937C8JJ4Ucb4+BKuNSAR+gPZFY/rJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329974; c=relaxed/simple;
	bh=1BfFvTW+7SYkzGkk18cHNE5iV+AG5gRxV2fSbGLrLko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juZRKtV0028bWpe5kIosgAQobrtYElJ5Ty48H2wsixkbcp2onhn2xSbB/WtXo1JvK74dqm54PMH71BYx3XO6ATRs2fyI8LNnFWJdOEIdzofP4DrZC/3ovkt5qm4heCx1l8noUKCXi9R7643diQ6T/m17O0JnzNoiwb2TTct5NXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w/6JWsip; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U6vXNia4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/6JWsip";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U6vXNia4"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7r1ch2QCFOhprkBXp7qfcKOLIETYbzIerJUqrI061g=;
	b=w/6JWsipW/VNMSxnbJX8VayPbqNtoFevsHC0HxJHEM28w+pOSJYMStG5tGBURutPNa4Uv0
	/Cdk7vy072Gsb8Ga/umkx9aOc0YCPdGtWI1uVIW4fHv+cuPTX57Fn0qo5FHPOagxmzEG9H
	wzlTGQ7okWDu7DSN+rXSTJxBaKZOqMEj34b9ZSeN1/2Ya5YReELIZ0xNy+wJyqWYK/osTF
	SKdHBUN0LXR8q46lK6ct0VxQoC8yzA2yVsnvoKAz1ciiQ20MrQdB7ECNOY+ANq+hSsB1Pz
	yKTTBP7wIDSBkwlrFUr/veUFOkNIpEHSiXAXYsBDnZMqq4NtZIqfB495vBRhsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7r1ch2QCFOhprkBXp7qfcKOLIETYbzIerJUqrI061g=;
	b=U6vXNia4v+kROl9sdz8uXe84USxD/w5gbTSFDQcdI6uy01AQNDumm3pKag2zc2pDX3elqF
	pAsAVrjwYp95xZDA==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 04/18] serial: meson: Use uart_prepare_sysrq_char().
Date: Fri,  1 Mar 2024 22:45:17 +0100
Message-ID: <20240301215246.891055-5-bigeasy@linutronix.de>
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

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/meson_uart.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uar=
t.c
index 8395688f5ee92..6feac459c0cf4 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -220,7 +220,7 @@ static void meson_receive_chars(struct uart_port *port)
 				continue;
 		}
=20
-		if (uart_handle_sysrq_char(port, ch))
+		if (uart_prepare_sysrq_char(port, ch))
 			continue;
=20
 		if ((status & port->ignore_status_mask) =3D=3D 0)
@@ -248,7 +248,7 @@ static irqreturn_t meson_uart_interrupt(int irq, void *=
dev_id)
 			meson_uart_start_tx(port);
 	}
=20
-	uart_port_unlock(port);
+	uart_unlock_and_check_sysrq(port);
=20
 	return IRQ_HANDLED;
 }
@@ -556,18 +556,13 @@ static void meson_serial_port_write(struct uart_port =
*port, const char *s,
 				    u_int count)
 {
 	unsigned long flags;
-	int locked;
+	int locked =3D 1;
 	u32 val, tmp;
=20
-	local_irq_save(flags);
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
 	val =3D readl(port->membase + AML_UART_CONTROL);
 	tmp =3D val & ~(AML_UART_TX_INT_EN | AML_UART_RX_INT_EN);
@@ -577,8 +572,7 @@ static void meson_serial_port_write(struct uart_port *p=
ort, const char *s,
 	writel(val, port->membase + AML_UART_CONTROL);
=20
 	if (locked)
-		uart_port_unlock(port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
=20
 static void meson_serial_console_write(struct console *co, const char *s,
--=20
2.43.0

