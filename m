Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1741E212E;
	Tue, 20 Aug 2024 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135412; cv=none; b=mVoDb13UNtRmH6lSPN2H9FrMhcNXA6t7Gov7Emp0JFaGdgi/IEALQmu3MPn/r6S0Zs+DicXGSwcZVeXmYbglACi9dfOcA7nVl3axDtGY2vNc5RF8UtrH7HQieaYaxgpHbGioo/hXOmoXFOCtcTO/xWyYZwdHS84c8KTcR3IN32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135412; c=relaxed/simple;
	bh=R4TOefOxndRBCPUXtpdDEsXMvKoXT/g+AiM/wcdCOiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cngrEnGiQZfKKmRwqcwsS8nAuSglItaU6ZZNBdUrbaEgCCbV3ZjrRRAQvJma+ng5/mOR32KkznLG0Bcjoe++Htu51hvaGM+ncH88jdMEnjhFLSDIO7qfc4WwqMleKKW/BkO93FMZ40D+cJ8bG7ZbXBd2dfPW7L1nlLd01012HBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JoHyeatM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ClkIjKV+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JoHyeatM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ClkIjKV+"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElxI59csI9kczE5ClB/S01RcILMnwACUfY2TZOkMQ4U=;
	b=JoHyeatMCnmKRPRHgthJM7/1nUTwBhU+wT8BCo/mp44hEBO5+yNjBUsGZ1pOTHnZNfXT06
	lUse3PXibj0w8U96MeLLZQmjkWYaLv1AHH4a/G9eByHiiA8APVPdK4uP6Skj/F2hWRP3JR
	CKFH849fTBa5WkCGlB+XzKiR342Zc2xkJ0YqA9MdN0s6/rMfN5k5LzOgQh08skSgzq49PL
	X/pCIPEu07f4mFiMmVrlYSm2bwu0Zjtlq5tImXv0CSEgQfYKvI6n6CvopaRhiK66BPhuP1
	rPx5TKtkUMithTktcwLKOaTTQEQ1Dy1sU5vRS9xXkrc4SL9Ma4jwJWfSzeCClw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElxI59csI9kczE5ClB/S01RcILMnwACUfY2TZOkMQ4U=;
	b=ClkIjKV+8w/CdQtbj4gYDFknd1XAWfeQu9aOMAs9rgjTzac0rSj01UQA4sPBrOxpSzoI5h
	JBDfiLk4OmYusqDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v8 14/35] serial: core: Acquire nbcon context in port->lock wrapper
Date: Tue, 20 Aug 2024 08:35:40 +0206
Message-Id: <20240820063001.36405-15-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the port->lock wrappers uart_port_lock(),
uart_port_unlock() (and their variants) only lock/unlock
the spin_lock.

If the port is an nbcon console that has implemented the
write_atomic() callback, the wrappers must also acquire/release
the console context and mark the region as unsafe. This allows
general port->lock synchronization to be synchronized against
the nbcon write_atomic() callback.

Note that __uart_port_using_nbcon() relies on the port->lock
being held while a console is added and removed from the
console list (i.e. all uart nbcon drivers *must* take the
port->lock in their device_lock() callbacks).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/serial_core.h | 82 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2cf03ff2056a..4ab65874a850 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -11,6 +11,8 @@
 #include <linux/compiler.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
+#include <linux/lockdep.h>
+#include <linux/printk.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/tty.h>
@@ -625,6 +627,60 @@ static inline void uart_port_set_cons(struct uart_port *up, struct console *con)
 	up->cons = con;
 	__uart_port_unlock_irqrestore(up, flags);
 }
+
+/* Only for internal port lock wrapper usage. */
+static inline bool __uart_port_using_nbcon(struct uart_port *up)
+{
+	lockdep_assert_held_once(&up->lock);
+
+	if (likely(!uart_console(up)))
+		return false;
+
+	/*
+	 * @up->cons is only modified under the port lock. Therefore it is
+	 * certain that it cannot disappear here.
+	 *
+	 * @up->cons->node is added/removed from the console list under the
+	 * port lock. Therefore it is certain that the registration status
+	 * cannot change here, thus @up->cons->flags can be read directly.
+	 */
+	if (hlist_unhashed_lockless(&up->cons->node) ||
+	    !(up->cons->flags & CON_NBCON) ||
+	    !up->cons->write_atomic) {
+		return false;
+	}
+
+	return true;
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline bool __uart_port_nbcon_try_acquire(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
+		return true;
+
+	return nbcon_device_try_acquire(up->cons);
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline void __uart_port_nbcon_acquire(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
+		return;
+
+	while (!nbcon_device_try_acquire(up->cons))
+		cpu_relax();
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline void __uart_port_nbcon_release(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
+		return;
+
+	nbcon_device_release(up->cons);
+}
+
 /**
  * uart_port_lock - Lock the UART port
  * @up:		Pointer to UART port structure
@@ -632,6 +688,7 @@ static inline void uart_port_set_cons(struct uart_port *up, struct console *con)
 static inline void uart_port_lock(struct uart_port *up)
 {
 	spin_lock(&up->lock);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -641,6 +698,7 @@ static inline void uart_port_lock(struct uart_port *up)
 static inline void uart_port_lock_irq(struct uart_port *up)
 {
 	spin_lock_irq(&up->lock);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -651,6 +709,7 @@ static inline void uart_port_lock_irq(struct uart_port *up)
 static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
 {
 	spin_lock_irqsave(&up->lock, *flags);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -661,7 +720,15 @@ static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *f
  */
 static inline bool uart_port_trylock(struct uart_port *up)
 {
-	return spin_trylock(&up->lock);
+	if (!spin_trylock(&up->lock))
+		return false;
+
+	if (!__uart_port_nbcon_try_acquire(up)) {
+		spin_unlock(&up->lock);
+		return false;
+	}
+
+	return true;
 }
 
 /**
@@ -673,7 +740,15 @@ static inline bool uart_port_trylock(struct uart_port *up)
  */
 static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
 {
-	return spin_trylock_irqsave(&up->lock, *flags);
+	if (!spin_trylock_irqsave(&up->lock, *flags))
+		return false;
+
+	if (!__uart_port_nbcon_try_acquire(up)) {
+		spin_unlock_irqrestore(&up->lock, *flags);
+		return false;
+	}
+
+	return true;
 }
 
 /**
@@ -682,6 +757,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
  */
 static inline void uart_port_unlock(struct uart_port *up)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock(&up->lock);
 }
 
@@ -691,6 +767,7 @@ static inline void uart_port_unlock(struct uart_port *up)
  */
 static inline void uart_port_unlock_irq(struct uart_port *up)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock_irq(&up->lock);
 }
 
@@ -701,6 +778,7 @@ static inline void uart_port_unlock_irq(struct uart_port *up)
  */
 static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
-- 
2.39.2

