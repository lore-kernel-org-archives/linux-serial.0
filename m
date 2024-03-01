Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C159169
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329979; cv=none; b=BKBRZ25LQmjNtEBTLVI1jRbNYlXuUpUvKR+0CWlWucS0wnZcafeltMc2GAE6imi8v4siWMdSv/8jhzg+CFNAMtqeIdbGqImEyPsuhcgpV9vCcRig+ggGRsnZ56zU8gGvH+0c0Qru/ONqwVJN6Yt1Ky/YY9AQCnzu4qRCU2Y9Q3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329979; c=relaxed/simple;
	bh=W1bZAcSWaD2tgfhQ6Fbubqq01v5jgI1caf8l+t9Rw+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXdzZ49i0bOXKlEb1lpFChgoQ7se1NUH+cmrDPmZ7yYLvfhyXTJSYvV8pJ4IaMYTidIeH99d9Mf+Du08gsnoBsz2dQHNStV/lsgiOBCm8RqZs7LD9R6KZIpkMsUijJyw5vBT2KBIBz2Rnfs5oKHt3K/ictJAxlJsyMhvX35rd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ml/Yf7C9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZDy191eZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ml/Yf7C9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZDy191eZ"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdLQfv7Xl2ik4I8lDwt6i1/NivYpaQJh5MZ/FKTlv14=;
	b=Ml/Yf7C9nbauHydI1iQZRS0OZ6eKh3M24hYsVUcsdj7L6yCVw+HGhUmm/GssBJhtm7Ka7T
	hC7LGrhyf2K8azqUvTFvbvu870yUrpfOE1Fn1zGHbc7kuticSIegX5cBNMwddXXinRxBrX
	EbEXtAVlOZ729Rtkk4Je++uDlwhthRN8WLUQ1N9uJELXai36qMOffha6y2yR3WIzHBZqZP
	uQUzT78hE8A/2gvP2lCo9LfwdWNYfbf47Uiterv3IY8SSyDVtbkVHrK17kz0cBzwuZEKnJ
	y1tOkkjKBXc0GptgIiHvjZ/mx05PiQn3rktY0yP8TS3aIPI3kJ3UXMf2H4avYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdLQfv7Xl2ik4I8lDwt6i1/NivYpaQJh5MZ/FKTlv14=;
	b=ZDy191eZ5/JmGBfVDX6KxFvPQQE3xQvZmuLH5xSwFRzxl1IDXRPeoklI0XTXS7Crt14VAL
	QUEfy9e4mGnCYpDA==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 17/18] serial: pch: Remove eg20t_port::lock.
Date: Fri,  1 Mar 2024 22:45:30 +0100
Message-ID: <20240301215246.891055-18-bigeasy@linutronix.de>
In-Reply-To: <20240301215246.891055-1-bigeasy@linutronix.de>
References: <20240301215246.891055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The struct eg20t_port has a spinlock_t which is used for locking while
access I/O of the device. Then there is the uart_portlock which is
sometimes and nests within eg20t_port's lock.

The uart_port lock is not used while using the struct in
pch_uart_hal_read() which might be okay. Then both locks are used in
pch_console_write() which looks odd especially the double try_lock part.

All in all it looks like the uart_port's lock could replace eg20t_port's
lock and simplify the code.

Remove eg20t_port::lock and use uart_port's lock for the lock scope.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/pch_uart.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 3911703918764..92cb3c623cc31 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -237,9 +237,6 @@ struct eg20t_port {
=20
 #define IRQ_NAME_SIZE 17
 	char				irq_name[IRQ_NAME_SIZE];
-
-	/* protect the eg20t_port private structure and io access to membase */
-	spinlock_t lock;
 };
=20
 /**
@@ -1013,7 +1010,7 @@ static irqreturn_t pch_uart_interrupt(int irq, void *=
dev_id)
 	int next =3D 1;
 	u8 msr;
=20
-	spin_lock(&priv->lock);
+	uart_port_lock(&priv->port);
 	handled =3D 0;
 	while (next) {
 		iid =3D pch_uart_hal_get_iid(priv);
@@ -1073,7 +1070,7 @@ static irqreturn_t pch_uart_interrupt(int irq, void *=
dev_id)
 		handled |=3D (unsigned int)ret;
 	}
=20
-	spin_unlock(&priv->lock);
+	uart_port_unlock(&priv->port);
 	return IRQ_RETVAL(handled);
 }
=20
@@ -1184,9 +1181,9 @@ static void pch_uart_break_ctl(struct uart_port *port=
, int ctl)
 	unsigned long flags;
=20
 	priv =3D container_of(port, struct eg20t_port, port);
-	spin_lock_irqsave(&priv->lock, flags);
+	uart_port_lock_irqsave(&priv->port, &flags);
 	pch_uart_hal_set_break(priv, ctl);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	uart_port_unlock_irqrestore(&priv->port, flags);
 }
=20
 /* Grab any interrupt resources and initialise any low level driver state.=
 */
@@ -1336,8 +1333,7 @@ static void pch_uart_set_termios(struct uart_port *po=
rt,
=20
 	baud =3D uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
=20
-	spin_lock_irqsave(&priv->lock, flags);
-	uart_port_lock(port);
+	uart_port_lock_irqsave(port, &flags);
=20
 	uart_update_timeout(port, termios->c_cflag, baud);
 	rtn =3D pch_uart_hal_set_line(priv, baud, parity, bits, stb);
@@ -1350,8 +1346,7 @@ static void pch_uart_set_termios(struct uart_port *po=
rt,
 		tty_termios_encode_baud_rate(termios, baud, baud);
=20
 out:
-	uart_port_unlock(port);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
=20
 static const char *pch_uart_type(struct uart_port *port)
@@ -1555,7 +1550,6 @@ pch_console_write(struct console *co, const char *s, =
unsigned int count)
 {
 	struct eg20t_port *priv;
 	unsigned long flags;
-	int priv_locked =3D 1;
 	int port_locked =3D 1;
 	u8 ier;
=20
@@ -1565,15 +1559,11 @@ pch_console_write(struct console *co, const char *s=
, unsigned int count)
=20
 	local_irq_save(flags);
 	if (priv->port.sysrq) {
-		/* call to uart_handle_sysrq_char already took the priv lock */
-		priv_locked =3D 0;
 		/* serial8250_handle_port() already took the port lock */
 		port_locked =3D 0;
 	} else if (oops_in_progress) {
-		priv_locked =3D spin_trylock(&priv->lock);
 		port_locked =3D uart_port_trylock(&priv->port);
 	} else {
-		spin_lock(&priv->lock);
 		uart_port_lock(&priv->port);
 	}
=20
@@ -1595,8 +1585,6 @@ pch_console_write(struct console *co, const char *s, =
unsigned int count)
=20
 	if (port_locked)
 		uart_port_unlock(&priv->port);
-	if (priv_locked)
-		spin_unlock(&priv->lock);
 	local_irq_restore(flags);
 }
=20
@@ -1694,8 +1682,6 @@ static struct eg20t_port *pch_uart_init_port(struct p=
ci_dev *pdev,
 	pci_enable_msi(pdev);
 	pci_set_master(pdev);
=20
-	spin_lock_init(&priv->lock);
-
 	iobase =3D pci_resource_start(pdev, 0);
 	mapbase =3D pci_resource_start(pdev, 1);
 	priv->mapbase =3D mapbase;
--=20
2.43.0

