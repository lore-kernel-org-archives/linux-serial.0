Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D759141
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329977; cv=none; b=Y9z42Zp30QpTZxrIy75fHmpaMYNoutPNEuGaW4r4+Lg+x1pjOD5kPUp8U2yYyxzPcUu4s5Y6uKZqvQtRYqfXprqTQRAnobwajO6f7KxuS5k9Ni0TZv4t823YUmXVYL/JMpP1GlrsynSYmHtZbb45e6F0g60kZueOskTdsf2OHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329977; c=relaxed/simple;
	bh=uymOQEaGyz5PP5tvxdnNv2kYIFvbiI3h6jTV0u0UjkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxbEl0epiIlgQtTgsAY66lV4VDPW98AiJz5R+wOf9uFE4WljGtmrhaSSx3vKCV5Hu23wWEKqI4cxvCAiV1aI8Vpsn766P777ACIwcxav19xmM/zKEcQI7Fz/OHAyMzgH1QE0wQDWsUL/fBnfeYPej08tynIurvX5T8da5ZfodTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=32PpjUGO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SsMk5Jrp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="32PpjUGO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SsMk5Jrp"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WNSSuDhcj1L0hdKTmzZHOjjPZHLEmPBI6eyJikJAxs=;
	b=32PpjUGOijguemtgK5OGL/uEcf+Ed5E32JT6lbtR3GdeCV/eo5rXQWWEWRbAFi8twtwK+Z
	DpCoTwloeyPP3686UB83pPO1uTmvR/F89B3IpF7mms7xnOvECB6bQuCtL94tOj84OMiFZ+
	zzdm3c4XGpuplfAOzcvELdBKzvPp2nWjC/dxcOGVNJno8zju2BTyiz2fcCRBpRpAF8yY9z
	da3gu/2i764YDfyrXFaXdfx176v+rJ+rBI0h+vHTNQRHJwyX7sxc+viQLOTIZ4CN0wbHWs
	aHTHl9HXan2ME0xdmsyxgcwR9DhvF/kj6ox19EMx1oecaTh1wVMO/mKJGoc3Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WNSSuDhcj1L0hdKTmzZHOjjPZHLEmPBI6eyJikJAxs=;
	b=SsMk5Jrp930Xb5w5e046HrQjoh1Hx9Ojuzkx+xUxFIuhu7kwcDYIMuFG26sXao5zaumeRr
	pvOTdEiB48/6juBg==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org
Subject: [PATCH 10/18] serial: owl: Use uart_prepare_sysrq_char() to handle sysrq.
Date: Fri,  1 Mar 2024 22:45:23 +0100
Message-ID: <20240301215246.891055-11-bigeasy@linutronix.de>
In-Reply-To: <20240301215246.891055-1-bigeasy@linutronix.de>
References: <20240301215246.891055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The port lock is a spinlock_t which is becomes a sleeping lock on PREEMPT_R=
T.
The driver splits the locking function into two parts: local_irq_save() and
uart_port_lock() and this breaks PREEMPT_RT.

Handle sysrq requests sysrq once the port lock is dropped.
Remove the special case in the console write routine an always use the
complete locking function.

Cc: "Andreas F=C3=A4rber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-actions@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/owl-uart.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index d9fe85397741d..8b60ac0ad7cd3 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -199,6 +199,7 @@ static void owl_uart_receive_chars(struct uart_port *po=
rt)
 	stat =3D owl_uart_read(port, OWL_UART_STAT);
 	while (!(stat & OWL_UART_STAT_RFEM)) {
 		char flag =3D TTY_NORMAL;
+		bool sysrq;
=20
 		if (stat & OWL_UART_STAT_RXER)
 			port->icount.overrun++;
@@ -217,7 +218,9 @@ static void owl_uart_receive_chars(struct uart_port *po=
rt)
 		val =3D owl_uart_read(port, OWL_UART_RXDAT);
 		val &=3D 0xff;
=20
-		if ((stat & port->ignore_status_mask) =3D=3D 0)
+		sysrq =3D uart_prepare_sysrq_char(port, val);
+
+		if (!sysrq && (stat & port->ignore_status_mask) =3D=3D 0)
 			tty_insert_flip_char(&port->state->port, val, flag);
=20
 		stat =3D owl_uart_read(port, OWL_UART_STAT);
@@ -229,10 +232,9 @@ static void owl_uart_receive_chars(struct uart_port *p=
ort)
 static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 {
 	struct uart_port *port =3D dev_id;
-	unsigned long flags;
 	u32 stat;
=20
-	uart_port_lock_irqsave(port, &flags);
+	uart_port_lock(port);
=20
 	stat =3D owl_uart_read(port, OWL_UART_STAT);
=20
@@ -246,7 +248,7 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 	stat |=3D OWL_UART_STAT_RIP | OWL_UART_STAT_TIP;
 	owl_uart_write(port, stat, OWL_UART_STAT);
=20
-	uart_port_unlock_irqrestore(port, flags);
+	uart_unlock_and_check_sysrq(port);
=20
 	return IRQ_HANDLED;
 }
@@ -508,18 +510,12 @@ static void owl_uart_port_write(struct uart_port *por=
t, const char *s,
 {
 	u32 old_ctl, val;
 	unsigned long flags;
-	int locked;
+	int locked =3D 1;
=20
-	local_irq_save(flags);
-
-	if (port->sysrq)
-		locked =3D 0;
-	else if (oops_in_progress)
-		locked =3D uart_port_trylock(port);
-	else {
-		uart_port_lock(port);
-		locked =3D 1;
-	}
+	if (oops_in_progress)
+		locked =3D uart_port_trylock_irqsave(port, &flags);
+	else
+		uart_port_lock_irqsave(port, &flags);
=20
 	old_ctl =3D owl_uart_read(port, OWL_UART_CTL);
 	val =3D old_ctl | OWL_UART_CTL_TRFS_TX;
@@ -541,9 +537,7 @@ static void owl_uart_port_write(struct uart_port *port,=
 const char *s,
 	owl_uart_write(port, old_ctl, OWL_UART_CTL);
=20
 	if (locked)
-		uart_port_unlock(port);
-
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
=20
 static void owl_uart_console_write(struct console *co, const char *s,
--=20
2.43.0

