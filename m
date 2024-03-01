Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139F58ADE
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329978; cv=none; b=AKxrKhOWxDbIXKBgNkOrfBmX/X6A+RRfJNs3dxwnmsBUV7UVDagkcGIFowJt75oEmMmmdGHACB7RbGhpgnm/pC3gSWMIoUJRi8VkQ95fujEVQGjDaiSgC9AWXd/QBcm0jiOFCkwQElwAOhmiZh1kGXKeRc5l7W8CQ4rmNnuTh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329978; c=relaxed/simple;
	bh=hqclxZ7fQ/fIk6kCqEFEfBDFCnJcwa8pzL6FMEtMsRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLsmlMHVL1x5/wcTkTkJLYFm9HS+4QTs1DJo5g1NIRSE6HAy7rXuL8/4SEOLQkA+UonU/j7KaeRHp8O5DSP7G+qXEN5XOTgOUIbkXeDvqjqBFGr8yKV8omfBh2LTEtTDHgFckx58rFOUVTNb0x5CRu8sqDSfYus9pi/OZjHwN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXkNRzW5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cfVr8DqJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXkNRzW5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cfVr8DqJ"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3rJ+VIa9zH6PXhEPo5PwUUJJVp/71Z7DvgBQX7HX44=;
	b=kXkNRzW5SN42CuG3j4/V7kKEiVAOe873xyPaCkeIungLWwGlx26c1O7Gte0RgDGuR9gXGX
	8qOyauCNcFgAhVPEwLDbj0sUHQIJOone7Vc7ygZklYUTCxaNrNrcR+EgO50IlRSv6DoVWL
	Iq0zLDH1hqr+y2QZEPDjqCZ+O0s9y4C2qpZpZA/dFeB6nolEQOUpuoiOh9bgRwplT6NCX8
	oA0Y7W/Lw76wap0jfYm4aSz3PDbld83b4N39aV6AEnJTr1oMcS8dJISzYm0DWGscBsl4X3
	bixYSHMbKe8hKAZw94bAlb502yitVjeBmw15J9VnGzQlkFf13dO3PYZifpvDJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3rJ+VIa9zH6PXhEPo5PwUUJJVp/71Z7DvgBQX7HX44=;
	b=cfVr8DqJ/HJJ86+hlhTql0ysW451KIZ/tbZ1sIj2K94z5XE31vEEP5vJ92oRjVlR7a/uz+
	3byohSZL5uh0qbAQ==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 12/18] serial: sifive: Use uart_prepare_sysrq_char() to handle sysrq.
Date: Fri,  1 Mar 2024 22:45:25 +0100
Message-ID: <20240301215246.891055-13-bigeasy@linutronix.de>
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

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/sifive.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index a4cc569a78a25..0670fd9f84967 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -412,7 +412,8 @@ static void __ssp_receive_chars(struct sifive_serial_po=
rt *ssp)
 			break;
=20
 		ssp->port.icount.rx++;
-		uart_insert_char(&ssp->port, 0, 0, ch, TTY_NORMAL);
+		if (!uart_prepare_sysrq_char(&ssp->port, ch))
+			uart_insert_char(&ssp->port, 0, 0, ch, TTY_NORMAL);
 	}
=20
 	tty_flip_buffer_push(&ssp->port.state->port);
@@ -534,7 +535,7 @@ static irqreturn_t sifive_serial_irq(int irq, void *dev=
_id)
 	if (ip & SIFIVE_SERIAL_IP_TXWM_MASK)
 		__ssp_transmit_chars(ssp);
=20
-	uart_port_unlock(&ssp->port);
+	uart_unlock_and_check_sysrq(&ssp->port);
=20
 	return IRQ_HANDLED;
 }
@@ -791,13 +792,10 @@ static void sifive_serial_console_write(struct consol=
e *co, const char *s,
 	if (!ssp)
 		return;
=20
-	local_irq_save(flags);
-	if (ssp->port.sysrq)
-		locked =3D 0;
-	else if (oops_in_progress)
-		locked =3D uart_port_trylock(&ssp->port);
+	if (oops_in_progress)
+		locked =3D uart_port_trylock_irqsave(&ssp->port, &flags);
 	else
-		uart_port_lock(&ssp->port);
+		uart_port_lock_irqsave(&ssp->port, &flags);
=20
 	ier =3D __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
 	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
@@ -807,8 +805,7 @@ static void sifive_serial_console_write(struct console =
*co, const char *s,
 	__ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
=20
 	if (locked)
-		uart_port_unlock(&ssp->port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&ssp->port, flags);
 }
=20
 static int sifive_serial_console_setup(struct console *co, char *options)
--=20
2.43.0

