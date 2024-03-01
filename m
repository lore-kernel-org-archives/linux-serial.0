Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9958ABA
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329974; cv=none; b=oKkoKvZW8LtvkVxjRI5lIo8QuWAWaNoEvUE/YfX6gTyw0By5btWCDcGbrMNPzv8WY1Ur9q+10bcTlX7xbnsYB0B/MHJ8uoQCRIYdhgYMYBDLmvmUCQ3dqrJCup1vHrcmsJasr0xfLPXOBQozafFMIyW56LsF0LYjmVAN+auUuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329974; c=relaxed/simple;
	bh=A0Sl0tlJDQ4HRDzIJ/leO1z/5F4WjWEu3jha+E8ggsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NViKvsB8mZNK5/fRFD3dgGFihp7TkFvwpXbuWIqP+mGw+U4+fsbjmRQIK79SYbUnbAxqlXvyw3+01ThxUrtPjng0jdjckG9lZ44Lh3mIJTs6sbZha078bZ2Dm5w9zm/QNCQj3hCMSilTai5DdfQq1umVT4DrzdgLAXdlrJlPT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LJkVeVlz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/IvfRVUa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LJkVeVlz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/IvfRVUa"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIqFu/AADtWHsa2rj/FvPzDKlVU7ecbiMypUuA2TtPA=;
	b=LJkVeVlz6WczQ2ZtyWamJTorAMNcNKrme/ofxnWL7OhIZCYQCGVnzELmHZKFOxF8la5mIn
	3Zbw53AEx6atAj223AulIn6zF6H+qS+tAQ9dX/UXx6Mw+Mqe+ihoMKDA/WMOy9lXyonVWL
	eLfbCD3bPW/Qmx1y2abAYvriF3QXHIDJQNhyG+kLvAOONxNmSZtodpa9SWv9rxUQ5DzZnw
	1S45MU9pfXSr6/xFaiBMRsX2vxht7bLxQVOPCyVxtBtbVaOOvG2xMTHoyQU6kfY4OWmo+L
	PLC6ZBKoI2LrIgMbspKM8CtVU5y5MmCnxYA8WrpUNRnu8xj9QWfd5K+QiSHhLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIqFu/AADtWHsa2rj/FvPzDKlVU7ecbiMypUuA2TtPA=;
	b=/IvfRVUa7UMPx9bEPcu7lqfzoDyoFpIjZL+j/rfBa8vduINCAKBi7F60JxkqJ2md9X50UL
	oe+1fU4c5yfLRODw==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/18] serial: bcm63xx: Use uart_prepare_sysrq_char().
Date: Fri,  1 Mar 2024 22:45:16 +0100
Message-ID: <20240301215246.891055-4-bigeasy@linutronix.de>
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
 drivers/tty/serial/bcm63xx_uart.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx=
_uart.c
index a3cefa153456d..34801a6f300b6 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -285,10 +285,9 @@ static void bcm_uart_do_rx(struct uart_port *port)
 				flag =3D TTY_PARITY;
 		}
=20
-		if (uart_handle_sysrq_char(port, c))
+		if (uart_prepare_sysrq_char(port, c))
 			continue;
=20
-
 		if ((cstat & port->ignore_status_mask) =3D=3D 0)
 			tty_insert_flip_char(tty_port, c, flag);
=20
@@ -353,7 +352,7 @@ static irqreturn_t bcm_uart_interrupt(int irq, void *de=
v_id)
 					       estat & UART_EXTINP_DCD_MASK);
 	}
=20
-	uart_port_unlock(port);
+	uart_unlock_and_check_sysrq(port);
 	return IRQ_HANDLED;
 }
=20
@@ -703,20 +702,14 @@ static void bcm_console_write(struct console *co, con=
st char *s,
 {
 	struct uart_port *port;
 	unsigned long flags;
-	int locked;
+	int locked =3D 1;
=20
 	port =3D &ports[co->index];
=20
-	local_irq_save(flags);
-	if (port->sysrq) {
-		/* bcm_uart_interrupt() already took the lock */
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
 	/* call helper to deal with \r\n */
 	uart_console_write(port, s, count, bcm_console_putchar);
@@ -725,8 +718,7 @@ static void bcm_console_write(struct console *co, const=
 char *s,
 	wait_for_xmitr(port);
=20
 	if (locked)
-		uart_port_unlock(port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
=20
 /*
--=20
2.43.0

