Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661287;
	b=fDkvIOILKkrYBL/AcAh8nrk9kDxXcu8eQZzLaTm+VaezBEsTJhu1oHZZoFHhud5x6m+W
	 CS0NuzHegx2dfH/YgB7Rw2JYUnN49i1/CeQR2F4lWkgg5p+TAw0R9cdqUfZ7nsjCh5H0O
	 51DBuleUVmvsz98imyzDwVmilGkImCBkMQLgRGs8a5U+OcGM2zWIQgEeO+aQBHT6o2rlt
	 JApwCKsjavmWXChbE+RwIKYeLGlvXqAFMbdqPkp/lrOFHdvaeGbGbylqyAhu27mJl+heI
	 DjTuggXcsZHoSE+a/ruQczgpw0bdPcbow9uItLie6IyeIm59Rzqz3P6p5szHHZVrtqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=nXgXZUSLPJ2SYhx2+7LVQLzHvdnsFJZM3SR6gpGR+IU=;
	b=nw+Fb8gctGHvFNs6kPpfKrsigVRB507OQzHAE2or37qvV0ps4XoSisVnbd4VUUEW/v6h
	 w2eWAA0UeX6fEfcDiqi0zpNSfWaNnbDqYP9H3UOmDf1id3eL1IH8cvCdSUnx6W9q6cPU+
	 dQ8wRFw7N8hmy4DoLrHtReb0toI45hluvGEL6JNStfgkvksnT14A4pYftCZpPwQTDgsuI
	 Fw1J57Rz9z7ZheXbTwgVFIxMSBo3b/8l0WAsJ0nReYV3KTr59J3KsDIg/OpupIp0wVTtj
	 lDJqkrqKOHifkerres6aPikVPkSi/xHex/aou/8BxuEgxI+bqVZV7yMRtCqfVvT7tvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PC1Bs1Ta;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466996082BEF
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 466996082BEF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PC1Bs1Ta
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-705cb6cedd5so78334eaf.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 15:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661285; x=1794266085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nXgXZUSLPJ2SYhx2+7LVQLzHvdnsFJZM3SR6gpGR+IU=;
        b=PC1Bs1TaqUERCYB+ym7JA8cbC+sZOF8cbI9aBEm5bjIMBh+HEjj5eB3gY1YcFqoDLt
         hWL4CEcgNjDt5iBtBDeIzTchG+V2QW5nQuoO/KMpaQOEF8txNBO7mmcoPbnSegDDTIy0
         IGoJ49No1COhzuw9Nj96gMfAkND6gbHrO3yylEO4IucR+thdbi+0BI8Mif0ZCUfIs8q+
         IHHOPJwfK6IX2VSxnyPBRGmBx4ul5+8d7oorHr4NDG2cLr6hthHWIfBvt0jZYX0bMB6I
         pYwMR0PXPikh56nY71mOfeGjQ4ZCd6aaXtZemm+DrlZcZudYb/wUvjAqpNtMFmLNbE7K
         M5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661285; x=1794266085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nXgXZUSLPJ2SYhx2+7LVQLzHvdnsFJZM3SR6gpGR+IU=;
        b=wEVITGA4CT2ZMLWf527e6xsVCIcJ4hmr2le/L9aNII/Ei6Vm2JbyK2FyRHuZ5r3pfB
         IGiobir/DadyfKW4n/TFlsmsmqFNRqTizmA7E1ZSVWkSrzFWn/+FWE1EUy64bouC3x68
         VYUX7zBLN9UcJ+0lXI2jVo0boSQx4FhdrHaygzFygnP62LaDhacPvsdFMyZ/3jNnYTQD
         BE5LWiwvSOA0H0wTwZiecxfTHV4iJNE3wkLMFbulIodQq8jKPdFNxKcUVHx9w7Ep3vrp
         XrYXDy48MIJFQQdV3dv5z9sKr/xslQ/WFtSWwW72g9vR1O+lsVtRgQ8j6nLqv6xUYZfu
         ovGg==
X-Forwarded-Encrypted: i=1; AKwUvBwUALFqsA+CdYcpAKoX7J1rO3Hnfmft948DBKZxBWc5/p5HM9eZQfPrq3Nzhxpc9jIIdD7ePoMM3McprdU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5zA4Eo+jWdU/OjHKoF3nUcVPvkwQnmDrdlLaXYqWEtOtCvxKO
	zO3guwc8GXWO4CzU2IIwEhXTegO6FLmTiZi0tmSeaHX0A26Uexxc0lE+
X-Gm-Gg: AYBFou0GQ6r8oXTji3kIQ4pZtodsJrgZ8MaAHgeZlJv4ALhokc9UkdhLHa6qyfWasMP
	ZtN+knl6jrkEOObK97ZD6QuIfAeVqaKo8DOOAIK0R/q12CVVHrFA0UvkQ6eO6Xdp4Lq3KW1yg2c
	qTJEYZzxk5M6sWsyjpoMf8XK41pewLGNWQRanCJIDqvMqhmolxtVSaetPnLyiDD+3zhmrwmlFqV
	P5Ivh13P+Ody1YVQG9WNP4PBS6THmf0uf86wM+/ifGMeKQOHv6Ia3hHoItLawU+CDLrAUy3Nts+
	O36oHSwnzHcpdJsM7q/Sek8PfEhdN1Nb9LDP7vYKGfZ9xdRCDz9u0fnUvHz7GI1Ebyj0M8GhABZ
	Ilu6hresl5dh+CxnS7BW/WOB+5uDtMHzCY1EGJPCuoQHud+2Rh/9uHGh+/HAMv806/nTa6Qm4+4
	5X+SBbbFdvQc2uJswSR9xAcB/MddRlxF+h30W5c8+E3OLMI1jXE9LUpXK8coMYAlMI6hFOPa68Z
	bpH5BFtzTnArSqF6nSXgbI58Dn9c6/CIQL9+N+DgM/DF2PuuNKL5hs7S+ghBpoIGJ+S9qShT64T
	tGIyp5F8CLsG0QZbVp2h50htFxy+a3j3Mo03bdnFyBk7vrzTyDwq6tBCs5NatJ6daWPtWtwrct4
	1vgmyTKS2Z8afTSD19YdP8OZ2r0Bgf0Dn5qTNpSh0Il81l8sTkmaalsGPuMoMruXcB665YE2mbw
	Ecqt+JeADfC/T1E0RDSecbDHhQY3Wiwy4OJw2JlxX5ZCSpBt4tQdHK
X-Received: by 2002:a05:6820:c2cc:10b0:709:a86c:7c68 with SMTP id 006d021491bc7-714f2a53011mr3369727eaf.31.1793661285222;
        Mon, 02 Nov 2026 15:14:45 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm10134463eaf.4.2026.11.02.15.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:14:44 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 16:14:32 -0700
Subject: [PATCH v9 5/8] serial: core: allow drivers to reserve flushed
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
Message-Id: <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
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
wakeup threshold.

Publish resume readiness under the same port lock as the TX restart,
without clearing any reservation. A concurrent flush can then reserve a
new transfer without resume releasing its storage prematurely.

Assert the port-lock requirement at uart_write_wakeup(), alongside the
reservation helpers, so callers cannot inspect readiness or release a
one-shot notification concurrently with a reservation change.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/serial_core.c | 106 +++++++++++++++++++++++++++++++++++----
 include/linux/serial_core.h      |  18 ++++++-
 2 files changed, 113 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af4..baf786d5c34f 100644
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
@@ -114,15 +119,79 @@ static inline struct uart_port *uart_port_check(struct uart_state *state)
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
+	/* Retained output must drain before consuming a write-ready notification. */
+	if (kfifo_len(&state->port.xmit_fifo) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
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
@@ -141,7 +210,10 @@ static void __uart_start(struct uart_state *state)
 	struct serial_port_device *port_dev;
 	int err;
 
-	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port))
+	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port) || !state->xmit_ready)
+		return;
+	/* High-priority flow-control characters have their own storage. */
+	if (state->xmit_blocked && !port->x_char)
 		return;
 
 	port_dev = port->port_dev;
@@ -375,6 +447,11 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
 		return -EIO;
 
 	serial_base_port_startup(uport);
+	scoped_guard(uart_port_lock_irq, uport) {
+		uart_xmit_enable(uport);
+		if (!kfifo_is_empty(&port->xmit_fifo) || uport->x_char)
+			__uart_start(state);
+	}
 
 	return 0;
 }
@@ -397,8 +474,11 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
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
@@ -593,7 +673,7 @@ static int uart_put_char(struct tty_struct *tty, u8 c)
 		return 0;
 	}
 
-	if (port)
+	if (port && uart_xmit_writable(state))
 		ret = kfifo_put(&state->port.xmit_fifo, c);
 	uart_port_unlock_deref(port, flags);
 	return ret;
@@ -624,7 +704,7 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
 		return 0;
 	}
 
-	if (port)
+	if (port && uart_xmit_writable(state))
 		ret = kfifo_in(&state->port.xmit_fifo, buf, count);
 
 	__uart_start(state);
@@ -640,7 +720,7 @@ static unsigned int uart_write_room(struct tty_struct *tty)
 	unsigned int ret;
 
 	port = uart_port_ref_lock(state, &flags);
-	if (!state->port.xmit_buf)
+	if (!state->port.xmit_buf || !uart_xmit_writable(state))
 		ret = 0;
 	else
 		ret = kfifo_avail(&state->port.xmit_fifo);
@@ -682,8 +762,12 @@ static void uart_flush_buffer(struct tty_struct *tty)
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
@@ -1748,8 +1832,10 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	if (WARN(!uport, "detached port still initialized!\n"))
 		return;
 
-	scoped_guard(uart_port_lock_irq, uport)
+	scoped_guard(uart_port_lock_irq, uport) {
+		state->xmit_ready = false;
 		uport->ops->stop_rx(uport);
+	}
 
 	serial_base_port_shutdown(uport);
 	uart_port_shutdown(port);
@@ -2391,9 +2477,10 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		unsigned int mctrl;
 
 		tty_port_set_suspended(port, true);
-		tty_port_set_initialized(port, false);
 
 		scoped_guard(uart_port_lock_irq, uport) {
+			state->xmit_ready = false;
+			tty_port_set_initialized(port, false);
 			ops->stop_tx(uport);
 			if (!(uport->rs485.flags & SER_RS485_ENABLED))
 				ops->set_mctrl(uport, 0);
@@ -2498,8 +2585,9 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
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
index 4eeb8253752a..41598a38a408 100644
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
 
@@ -909,6 +921,8 @@ struct uart_driver {
 };
 
 void uart_write_wakeup(struct uart_port *port);
+void uart_xmit_block(struct uart_port *port);
+void uart_xmit_unblock(struct uart_port *port);
 
 /**
  * enum UART_TX_FLAGS -- flags for uart_port_tx_flags()

-- 
2.53.0

