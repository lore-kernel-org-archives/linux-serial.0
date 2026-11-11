Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435402;
	b=LoIGKUU8/niQMbLXNcoSCeWUb9lMtvgtTIIfTmhMcym5C/lTdwCF7bVsSAuC3prycS2C
	 dirtMg4Gp7abtOJVTQstYyfuHC2R5KDHEzPEXmraL6+of1KeAmTF4aij40YszBSlG4oPN
	 5FKkRAQx8uK57ByFslVvpvjO0H8SyRxZtfaIW3vUkV/ezyV64f3NLYVvty9ul9D8ev+rK
	 JV6uf8k7x6tDxao2GLixzukD3p4VhELGTjdnsStm7u05zDGvzV2sapL8sODCUka1j24wD
	 qZ9yGJkKVZhBAIPPQhLLquRLzH29jbieYdVbyAa4P3ySOf2SVlfxRCgo3c86ayOcRMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZHEvTQZaDSERMBrfaBr2M8K3I74LqKqS4UfdKeh+wYI=;
	b=FZdXw3fkLS5FufNElnbv0vfUzW+9ITzdY+ecbKP0fZSwcGiPerpbBNKtoBAzKNlvGli7
	 BilY2kOcIn5+kgNyVQMTdKC985cNxoIfH0rK4pfWU0x3cfKdKHizcc6UwKKgwp4yGUzhD
	 Rw3//O9drICTCrZ5R5/2ZP5kjjECxX+e1B7AwD0hSBun3yw/+8w6YkD/jR408n9FTOpxP
	 dP8A/pOKOjiZEXuYIG1V3xFpplEtDksZLZHHD3KSjjK/9ZWtZvCESqoNRruKJwN7TONC3
	 i621sajx3dEfqHBvpt1+MCopgpvLmivWIa/4zCsfbK+at+gI50UgJj85aB3zRquzCmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B7FHTk0r;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805660A2600
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 22:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A805660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B7FHTk0r
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-53ec9237600so1787611b6e.3
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435400; x=1795040200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZHEvTQZaDSERMBrfaBr2M8K3I74LqKqS4UfdKeh+wYI=;
        b=B7FHTk0r1WxL0H1ux/7wSRexdADMGNOV3s2R5een0ZZrdgn8/UZcFdgt5osomCtsjw
         NAmHumQ6fVkghRjJZV9Awy4KyrFswlcgfDIsMKJEaW67Zahp6Qsm1vtHoMQjb18gCeJz
         YjxifRDVdiS/EoGXMewpgDn9WeTun/BNWXJCdCpR8cVJZ2PDgiN0c6jGAEmgylqR1Aeg
         geZwfon2pBlFYOoQUo83tIjxMbw8pJQPPLYuwjpUcxOphi7roClwRpIVLoBfRBumQW9N
         iwlkJnQPl3oZw/8ZQYWUJ1PP9FEwJrqR9bs1O4/XksG0yBIxWqwsCVIYqFaUfmduSWZx
         /gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435401; x=1795040201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZHEvTQZaDSERMBrfaBr2M8K3I74LqKqS4UfdKeh+wYI=;
        b=P0vMpTECqOo+JLI68y8UN7oDpliMXnwzLAolZ1FsjhJA2Y4pOnAqKLruf5kmUg5kOU
         CBlfavS8bOXiHzr1hzWpj+V1EPW0SooSmkJyavNWXlNrs8IhSLICqaxyOt8BbH4JrD8d
         64WxuBZQkJ2XpKvIq5QDCunZ3Qajh8nHcrqNtnpGT+LT+aQwEKGn/zkGmRH3WFEnF5jH
         bW8JrORmdWXG2isrhC26H2IScICvA3/TYmXUpkVhbt5TXzpt+AuB3RkyxEllVPQ/c8i6
         rR/EjWzjvrxPQ2UCYbRvMibDTwiiuDfmbbqxBCU8XwMxEcIW8uJ2BM0SB8oUrVG7UuQt
         bfcg==
X-Forwarded-Encrypted: i=1; AL+hErH0FNOAmsVTG0tfEdv25xb7NuqGWoI0eGvDVjBbpgyN86dCkSapy/vDnGERF0ps0+h1iPRdjzTcfeQloDg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xAkSpjU0X7ztTjpwuZGKGQ4p1LsNu3QElgUeKjSb2Daks+AMg
	3X/PQPZ8wK8HZx6ePGfibSsdco30X4QRKZsTYlpzgg5/uBkz6w8Ym+xn
X-Gm-Gg: AYBFou1dPVHEVDhIh1uRyUbtU765X7TQqU8336Ohui7gOQvBCn613KvKvz2TgWq2dtx
	AHagBN3YMzG5KjKYgxrqxOuwXLqMTRgjxP7HhQwCLHrEGmW3QGvlglwg7nwjEuRmqEas3vwSnrZ
	a3wDAC4LlK1ah73POOqabzaFuXjoJUjuic9+C7dguleBbHta6fsdFM/qdMqc4ZU6QZcDa7mhG50
	xcNyCUAHHtgg6VuGhFUTg7mOrGUx7YKQnEZU7dSWwxHy4DQRf9Vdbne2WZo5qDqq5C5Re1A3V+e
	mkAZ5+n0CVjjSz8Zy2MTswsCHKyDT7QzQu3FyOhchO0mW53Wd4BLyhuRtjBQdK1EKfUcyspTqJu
	SZKKoVW8A0yVGbFQ22RR4sRcxBbXyP6o+fjdO9uFlPijYFus/suUeL0elSI05hFGuoXnfDdsIiU
	LJZ/KctDQ0OOMCJBa3uK7j/RRLQNDoTuAnNDJHXsPgzHrVIOWi+V7Sq+FKGWwBX2biuQWtJezwX
	J859fhb3Pwk7Omz0Sx3g4MfuV5HDfBvWMPDNdtIVGjQvB3U+a7AW+FTA3HJxxtD/NY0owD2FdW+
	TMJ2VD6tYXnOKH9WMbZlkF8U9SRag/2tZhUAqjVtV0VY/ATZDmfFJNhTCitWUQIPAP4QZ1CQkPJ
	Ds2Tsft4AiDZCeY6xjkvaEDyMGgf2ef27k0v7FaXh8+zI+DudwvFr1xX89VCRDwZQG7lrpBQKIf
	pn/eL8UWRrFlsIeds1XMsAmEy3MompMAQdhX9EN3l7VqrVU+PRmUQEWMlVPoqko4tBUooiDqH9
X-Received: by 2002:a05:6808:e8d:b0:53a:88c6:96c8 with SMTP id 5614622812f47-56b97100593mr3406869b6e.55.1794435400488;
        Wed, 11 Nov 2026 14:16:40 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5917498b6e.1.2026.11.11.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:40 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 15:16:30 -0700
Subject: [PATCH v12 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-serial-8250-dma-cancel-v1-v12-5-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

uart_flush_buffer() resets the transmit FIFO before calling the driver's
flush callback. An asynchronous DMA transfer can still access that storage
after the callback returns, while a new write can immediately reuse it.

Add uart_xmit_block() and uart_xmit_unblock() so a driver can reserve the
flushed storage until its transfer and completion callbacks have retired.
Serialize the reservation with FIFO producers using the port lock.

While the storage is reserved, write_room() reports no space and write()
and put_char() accept no data. Defer write-ready notifications until the
reservation is released, preserving one-shot TTY wakeups. Keep the flush's
write-ready notification under the port lock so it cannot race another
reservation.

Wake tty->write_wait after flushing even when writes remain blocked.
tty_wait_until_sent() waits for the logical FIFO to empty, independently
of whether its storage can be reused. Notify these drain waiters without
invoking the line discipline's write_wakeup() callback, so a reservation
does not prevent a completed logical flush from waking a drain waiter or
consume a one-shot write-ready notification prematurely.

Suppress ordinary TX starts while the FIFO storage is blocked. Preserve
high-priority flow-control characters, which use separate storage.
Releasing the reservation wakes writers through the existing TTY wakeup
path. This preserves immediate logical flushing while applying write
backpressure until the storage is reusable.

Track port readiness separately from DMA ownership. Retirement releases the
reservation even during startup or shutdown, while writes and wakeups stay
gated until successful startup or resume. Reopening or restarting a port
wakes deferred writers with either a new or retained FIFO. Restart queued
output when reusing a FIFO after suspension. Keep its write-ready
notification pending until the retained output drains below the normal
wakeup threshold. Share that threshold check with generic 8250 and OMAP
TX DMA completion through uart_write_wakeup_if_needed().

Publish resume readiness under the same port lock as the TX restart,
without clearing any reservation. A concurrent flush can then reserve a
new transfer without resume releasing its storage prematurely.

Assert the port-lock requirement at uart_write_wakeup(), alongside the
reservation helpers, so callers cannot inspect readiness or release a
one-shot notification concurrently with a reservation change.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
---
 drivers/tty/serial/8250/8250_dma.c  |   4 +-
 drivers/tty/serial/8250/8250_omap.c |   3 +-
 drivers/tty/serial/serial_core.c    | 104 ++++++++++++++++++++++++++++++++----
 include/linux/serial_core.h         |  34 +++++++++++-
 4 files changed, 129 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 57fc7915adac..43c55cb991a5 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -15,7 +15,6 @@ static void __dma_tx_complete(void *param)
 {
 	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
-	struct tty_port		*tport = &p->port.state->port;
 	unsigned long	flags;
 	int		ret;
 
@@ -30,8 +29,7 @@ static void __dma_tx_complete(void *param)
 
 	uart_xmit_advance(&p->port, dma->tx_size);
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(&p->port);
+	uart_write_wakeup_if_needed(&p->port);
 
 	ret = serial8250_tx_dma(p);
 	if (ret || !dma->tx_running)
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index f1980c15f85a..366fa787292c 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1107,8 +1107,7 @@ static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 		omap8250_restore_regs(p);
 	}
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(&p->port);
+	uart_write_wakeup_if_needed(&p->port);
 
 	if (!kfifo_is_empty(&tport->xmit_fifo) && !uart_tx_stopped(&p->port)) {
 		int ret;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af4..0f6613814ce3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -100,6 +100,11 @@ static inline struct uart_port *uart_port_check(struct uart_state *state)
 	return state->uart_port;
 }
 
+static bool uart_xmit_writable(const struct uart_state *state)
+{
+	return state->xmit_ready && !state->xmit_blocked;
+}
+
 /**
  * uart_write_wakeup - schedule write processing
  * @port: port to be processed
@@ -114,15 +119,77 @@ static inline struct uart_port *uart_port_check(struct uart_state *state)
 void uart_write_wakeup(struct uart_port *port)
 {
 	struct uart_state *state = port->state;
+
+	lockdep_assert_held_once(&port->lock);
+
 	/*
 	 * This means you called this function _after_ the port was
 	 * closed.  No cookie for you.
 	 */
 	BUG_ON(!state);
+	if (!uart_xmit_writable(state))
+		return;
 	tty_port_tty_wakeup(&state->port);
 }
 EXPORT_SYMBOL(uart_write_wakeup);
 
+/* Publish readiness without releasing any transfer's storage reservation. */
+static void uart_xmit_enable(struct uart_port *port)
+{
+	struct uart_state *state = port->state;
+
+	lockdep_assert_held_once(&port->lock);
+	if (state->xmit_ready)
+		return;
+	state->xmit_ready = true;
+	uart_write_wakeup_if_needed(port);
+}
+
+/**
+ * uart_xmit_block - reserve flushed transmit storage
+ * @port: port whose transmit storage is still in use
+ *
+ * A driver may call this from ->flush_buffer() if DMA still owns the old
+ * transmit data. The logical FIFO has already been emptied, but writers
+ * must not overwrite its storage until uart_xmit_unblock() is called.
+ * write_room() reports zero and write()/put_char() accept no data meanwhile.
+ * Line-discipline write wakeups are deferred until the reservation is released.
+ *
+ * The driver must unblock after retiring the transfer, including on shutdown.
+ * Serial core separately gates writes and wakeups until startup or resume
+ * has made the port ready.
+ * Repeated calls are idempotent, not nested reservations.
+ *
+ * Context: @port->lock held.
+ */
+void uart_xmit_block(struct uart_port *port)
+{
+	lockdep_assert_held_once(&port->lock);
+	port->state->xmit_blocked = true;
+}
+EXPORT_SYMBOL_GPL(uart_xmit_block);
+
+/**
+ * uart_xmit_unblock - release reserved transmit storage and wake writers
+ * @port: port whose storage is available again
+ *
+ * The old transfer must no longer access the FIFO storage, and any required
+ * DMA synchronization must have completed before this call.
+ * Retirement is recorded even while the port is inactive. Writes and wakeups
+ * remain deferred until startup or resume has made the port ready.
+ *
+ * Context: @port->lock held.
+ */
+void uart_xmit_unblock(struct uart_port *port)
+{
+	lockdep_assert_held_once(&port->lock);
+	if (!port->state->xmit_blocked)
+		return;
+	port->state->xmit_blocked = false;
+	uart_write_wakeup(port);
+}
+EXPORT_SYMBOL_GPL(uart_xmit_unblock);
+
 static void uart_stop(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
@@ -141,7 +208,10 @@ static void __uart_start(struct uart_state *state)
 	struct serial_port_device *port_dev;
 	int err;
 
-	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port))
+	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port) || !state->xmit_ready)
+		return;
+	/* High-priority flow-control characters have their own storage. */
+	if (state->xmit_blocked && !port->x_char)
 		return;
 
 	port_dev = port->port_dev;
@@ -375,6 +445,11 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
 		return -EIO;
 
 	serial_base_port_startup(uport);
+	scoped_guard(uart_port_lock_irq, uport) {
+		uart_xmit_enable(uport);
+		if (!kfifo_is_empty(&port->xmit_fifo) || uport->x_char)
+			__uart_start(state);
+	}
 
 	return 0;
 }
@@ -397,8 +472,11 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 
-	if (uport)
+	if (uport) {
+		scoped_guard(uart_port_lock_irq, uport)
+			state->xmit_ready = false;
 		serial_base_port_shutdown(uport);
+	}
 
 	if (tty_port_initialized(port)) {
 		tty_port_set_initialized(port, false);
@@ -593,7 +671,7 @@ static int uart_put_char(struct tty_struct *tty, u8 c)
 		return 0;
 	}
 
-	if (port)
+	if (port && uart_xmit_writable(state))
 		ret = kfifo_put(&state->port.xmit_fifo, c);
 	uart_port_unlock_deref(port, flags);
 	return ret;
@@ -624,7 +702,7 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
 		return 0;
 	}
 
-	if (port)
+	if (port && uart_xmit_writable(state))
 		ret = kfifo_in(&state->port.xmit_fifo, buf, count);
 
 	__uart_start(state);
@@ -640,7 +718,7 @@ static unsigned int uart_write_room(struct tty_struct *tty)
 	unsigned int ret;
 
 	port = uart_port_ref_lock(state, &flags);
-	if (!state->port.xmit_buf)
+	if (!state->port.xmit_buf || !uart_xmit_writable(state))
 		ret = 0;
 	else
 		ret = kfifo_avail(&state->port.xmit_fifo);
@@ -682,8 +760,12 @@ static void uart_flush_buffer(struct tty_struct *tty)
 	kfifo_reset(&state->port.xmit_fifo);
 	if (port->ops->flush_buffer)
 		port->ops->flush_buffer(port);
+	/* Serialize the wakeup with reservation changes, including another flush. */
+	uart_write_wakeup(port);
 	uart_port_unlock_deref(port, flags);
-	tty_port_tty_wakeup(&state->port);
+
+	/* Drain waiters observe FIFO emptiness, not write readiness. */
+	wake_up_interruptible(&tty->write_wait);
 }
 
 /*
@@ -1748,8 +1830,10 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	if (WARN(!uport, "detached port still initialized!\n"))
 		return;
 
-	scoped_guard(uart_port_lock_irq, uport)
+	scoped_guard(uart_port_lock_irq, uport) {
+		state->xmit_ready = false;
 		uport->ops->stop_rx(uport);
+	}
 
 	serial_base_port_shutdown(uport);
 	uart_port_shutdown(port);
@@ -2391,9 +2475,10 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		unsigned int mctrl;
 
 		tty_port_set_suspended(port, true);
-		tty_port_set_initialized(port, false);
 
 		scoped_guard(uart_port_lock_irq, uport) {
+			state->xmit_ready = false;
+			tty_port_set_initialized(port, false);
 			ops->stop_tx(uport);
 			if (!(uport->rs485.flags & SER_RS485_ENABLED))
 				ops->set_mctrl(uport, 0);
@@ -2498,8 +2583,9 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 					if (!(uport->rs485.flags & SER_RS485_ENABLED))
 						ops->set_mctrl(uport, uport->mctrl);
 					ops->start_tx(uport);
+					tty_port_set_initialized(port, true);
+					uart_xmit_enable(uport);
 				}
-				tty_port_set_initialized(port, true);
 			} else {
 				/*
 				 * Failed to resume - maybe hardware went away?
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4eeb8253752a..2297b870cb86 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -208,8 +208,17 @@ struct gpio_desc;
  *	Flush any write buffers, reset any DMA state and stop any ongoing DMA
  *	transfers.
  *
- *	This will be called whenever the @port->state->xmit circular buffer is
- *	cleared.
+ *	This is called after the transmit FIFO has been cleared, with @port->lock
+ *	still held. A driver whose asynchronous transfer can still access the
+ *	flushed storage must call uart_xmit_block() before returning. This keeps
+ *	write_room() at zero and prevents write() and put_char() from reusing the
+ *	storage until the driver calls uart_xmit_unblock().
+ *
+ *	Release the reservation only after the transfer and its callbacks have
+ *	retired and any required DMA synchronization has completed. Shutdown must
+ *	also retire the transfer and release the reservation before returning,
+ *	since serial core then frees the transmit buffer. Serial core separately
+ *	gates writes and wakeups until startup or resume has made the port ready.
  *
  *	Locking: @port->lock taken.
  *	Interrupts: locally disabled.
@@ -834,6 +843,9 @@ enum uart_pm_state {
  */
 struct uart_state {
 	struct tty_port		port;
+	/* TX readiness and storage ownership; protected by the UART port lock. */
+	bool			xmit_ready;
+	bool			xmit_blocked;
 
 	enum uart_pm_state	pm_state;
 
@@ -909,6 +921,24 @@ struct uart_driver {
 };
 
 void uart_write_wakeup(struct uart_port *port);
+void uart_xmit_block(struct uart_port *port);
+void uart_xmit_unblock(struct uart_port *port);
+
+/**
+ * uart_write_wakeup_if_needed - notify writers when queued output is low
+ * @port: port to be processed
+ *
+ * Keep one-shot write-wakeup notifications pending until fewer than
+ * %WAKEUP_CHARS remain in the transmit FIFO. This also applies to output
+ * retained across suspend and resume.
+ *
+ * Context: @port->lock held.
+ */
+static inline void uart_write_wakeup_if_needed(struct uart_port *port)
+{
+	if (kfifo_len(&port->state->port.xmit_fifo) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
 
 /**
  * enum UART_TX_FLAGS -- flags for uart_port_tx_flags()

-- 
2.53.0

