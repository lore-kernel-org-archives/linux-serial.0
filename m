Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3EF2451F3;
	Fri, 25 Apr 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579605; cv=none; b=cQAjKPI7NFnG8boF+RP0t0prm8qmY0avMQVTJ5AbEoIILGFflMyMmxxaGHq3/PJrp5ZGrFSaf7+jTVtMm88xFWRf/XZ2kPc51IeBRQywuXcIlwEaZi/K1N5k1WuDO4WJDZi99soEvpvShYDcGQCqkC0lvLf3YZ7AkFBmeDElsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579605; c=relaxed/simple;
	bh=filZUCZu1uVbN8m4LwHDnoGpoCMzzgYVOEeequd4tbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsJCrPHrhB2B07qXJZgHN88NEVmZys4WjjwUa0NnDRShj78lWgnhUhX+XZxo4D8vDvPDTiWlvdtFMghRHWSB6ioJyo7ESzCWS4yoK6cVy5xAZPs8y/hi8qdms49GR1ZVuLT5QCyd0q7YSZgkRpc3nqXXvzGud0XsJ3F8SQK9PBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+6D1cBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+6D1cBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EC6C4CEEA;
	Fri, 25 Apr 2025 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745579604;
	bh=filZUCZu1uVbN8m4LwHDnoGpoCMzzgYVOEeequd4tbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+6D1cBNYAUgjXTHoAGcBbmgkWyaz5S6diid/vO3pA2yPTCGNrbQBlvtbG99PoEeY
	 WLVnRfzDCk+/61DNIIUAs6PTx8arPZIX38v1nT5Zif/rJJmINSEan7Y6aWI4smUwZL
	 3BRivWN0NQy707Y7LiAVhrEBI4mY3osOEHTY9ZF+iDApffMtKt/MyVLzEDNxaWq0WJ
	 hN4OQYuy+LaxscO4cS4cYswa3g3XWOwvZ4L5TTrvAIDyXFhET1ot/IQl7qhKQGmr7z
	 ltJugZrXiZHJgaEOWz5LuN98QO2E4DTjd7t+oBIumrsWo1TwDk8t2+Bgi/4xaFVJDV
	 uaukuUvSu15Vg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 4/6] serial: rename local uart_port_lock() -> uart_port_ref_lock()
Date: Fri, 25 Apr 2025 13:13:13 +0200
Message-ID: <20250425111315.1036184-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111315.1036184-1-jirislaby@kernel.org>
References: <20250425111315.1036184-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_port_lock() and uart_port_unlock() are (at the same time) defined
as:
* functions in include/linux/serial_core.h
* macros in drivers/tty/serial/serial_core.c

The former are sane uart port lock wrappers.

The latter _lock() does something completely different: it inspects
a uart_state, obtains a uart_port from it, and increases its reference
count. And if that all succeeded, the port is locked too.

Similarly, the _unlock() counterpart first unlocks and then decrements
the refcount too.

This state is REALLY CONFUSING.

So rename the latter (local .c macros):
* uart_port_lock() -> uart_port_ref_lock(), and
* uart_port_unlock() -> uart_port_unlock_deref().

Now, the forbidden while-at-it part: convert from a macro to an inline
-- do it here as the passed 'flags' have to be pointer to ulong now. So
we avoid doubled changes on identical LOCs.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 75 ++++++++++++++++----------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 5bc145643385..52e764be42c4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -75,22 +75,23 @@ static inline void uart_port_deref(struct uart_port *uport)
 		wake_up(&uport->state->remove_wait);
 }
 
-#define uart_port_lock(state, flags)					\
-	({								\
-		struct uart_port *__uport = uart_port_ref(state);	\
-		if (__uport)						\
-			uart_port_lock_irqsave(__uport, &flags);	\
-		__uport;						\
-	})
-
-#define uart_port_unlock(uport, flags)					\
-	({								\
-		struct uart_port *__uport = uport;			\
-		if (__uport) {						\
-			uart_port_unlock_irqrestore(__uport, flags);	\
-			uart_port_deref(__uport);			\
-		}							\
-	})
+static inline struct uart_port *uart_port_ref_lock(struct uart_state *state, unsigned long *flags)
+{
+	struct uart_port *uport = uart_port_ref(state);
+
+	if (uport)
+		uart_port_lock_irqsave(uport, flags);
+
+	return uport;
+}
+
+static inline void uart_port_unlock_deref(struct uart_port *uport, unsigned long flags)
+{
+	if (uport) {
+		uart_port_unlock_irqrestore(uport, flags);
+		uart_port_deref(uport);
+	}
+}
 
 static inline struct uart_port *uart_port_check(struct uart_state *state)
 {
@@ -127,10 +128,10 @@ static void uart_stop(struct tty_struct *tty)
 	struct uart_port *port;
 	unsigned long flags;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, &flags);
 	if (port)
 		port->ops->stop_tx(port);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 }
 
 static void __uart_start(struct uart_state *state)
@@ -168,9 +169,9 @@ static void uart_start(struct tty_struct *tty)
 	struct uart_port *port;
 	unsigned long flags;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, &flags);
 	__uart_start(state);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 }
 
 static void
@@ -258,14 +259,14 @@ static int uart_alloc_xmit_buf(struct tty_port *port)
 	if (!page)
 		return -ENOMEM;
 
-	uport = uart_port_lock(state, flags);
+	uport = uart_port_ref_lock(state, &flags);
 	if (!state->port.xmit_buf) {
 		state->port.xmit_buf = (unsigned char *)page;
 		kfifo_init(&state->port.xmit_fifo, state->port.xmit_buf,
 				PAGE_SIZE);
-		uart_port_unlock(uport, flags);
+		uart_port_unlock_deref(uport, flags);
 	} else {
-		uart_port_unlock(uport, flags);
+		uart_port_unlock_deref(uport, flags);
 		/*
 		 * Do not free() the page under the port lock, see
 		 * uart_free_xmit_buf().
@@ -289,11 +290,11 @@ static void uart_free_xmit_buf(struct tty_port *port)
 	 * console driver may need to allocate/free a debug object, which
 	 * can end up in printk() recursion.
 	 */
-	uport = uart_port_lock(state, flags);
+	uport = uart_port_ref_lock(state, &flags);
 	xmit_buf = port->xmit_buf;
 	port->xmit_buf = NULL;
 	INIT_KFIFO(port->xmit_fifo);
-	uart_port_unlock(uport, flags);
+	uart_port_unlock_deref(uport, flags);
 
 	free_page((unsigned long)xmit_buf);
 }
@@ -592,15 +593,15 @@ static int uart_put_char(struct tty_struct *tty, u8 c)
 	unsigned long flags;
 	int ret = 0;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, &flags);
 	if (!state->port.xmit_buf) {
-		uart_port_unlock(port, flags);
+		uart_port_unlock_deref(port, flags);
 		return 0;
 	}
 
 	if (port)
 		ret = kfifo_put(&state->port.xmit_fifo, c);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 	return ret;
 }
 
@@ -623,9 +624,9 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
 	if (WARN_ON(!state))
 		return -EL3HLT;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, &flags);
 	if (!state->port.xmit_buf) {
-		uart_port_unlock(port, flags);
+		uart_port_unlock_deref(port, flags);
 		return 0;
 	}
 
@@ -633,7 +634,7 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
 		ret = kfifo_in(&state->port.xmit_fifo, buf, count);
 
 	__uart_start(state);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 	return ret;
 }
 
@@ -644,9 +645,9 @@ static unsigned int uart_write_room(struct tty_struct *tty)
 	unsigned long flags;
 	unsigned int ret;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, &flags);
 	ret = kfifo_avail(&state->port.xmit_fifo);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 	return ret;
 }
 
@@ -657,9 +658,9 @@ static unsigned int uart_chars_in_buffer(struct tty_struct *tty)
 	unsigned long flags;
 	unsigned int ret;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, &flags);
 	ret = kfifo_len(&state->port.xmit_fifo);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 	return ret;
 }
 
@@ -678,13 +679,13 @@ static void uart_flush_buffer(struct tty_struct *tty)
 
 	pr_debug("uart_flush_buffer(%d) called\n", tty->index);
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref_lock(state, &flags);
 	if (!port)
 		return;
 	kfifo_reset(&state->port.xmit_fifo);
 	if (port->ops->flush_buffer)
 		port->ops->flush_buffer(port);
-	uart_port_unlock(port, flags);
+	uart_port_unlock_deref(port, flags);
 	tty_port_tty_wakeup(&state->port);
 }
 
-- 
2.49.0

