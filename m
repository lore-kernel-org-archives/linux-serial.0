Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778697;
	b=ON7e5NgPAEaUuWYOtb+8hGtopZ+aDHunFZ2yWcmS46+t7GsvlEO5fdq0kt0YodZMLrqv
	 /4KvwH5NgCJOBXu9hGGBw/1xZIAJVNA0CqUx2Pui9LncZQDqUppB+U56rht5XAljP8Jam
	 rjk4U/6ZFeoDpBTpU8L7ZvFFT9LOSM3Ol2YzSltI4UNg2hZh+Ddlry3JDjN6uTyFnXf4t
	 R1JpERhLB++5yAmPvmV+vnnf1Z9W7TCAEvMgGKHKy8gBAlHavSHOc4+Qzg9BmpXc5v+e9
	 BKr/ehjtD8nRJUmu3iB64Kmoe7Fcpx+GUW/DI/Dew9qyr+OFIHBi9PTqGEV/e8c34Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=YyvIsZLH5odQ9OcSqcettzCR4/nFwFLMVbl002HSWDQ=;
	b=jF4bEQOdAcX3UQvTIjRaewxnOPmAHCGFzhSxW4KTP+67o1QB3EnFs+l5qJmjhuLan1vd
	 iu9zreacASpf/bGsZDmewvHTSvuJP7o69LrRRWqhLNeJBVypNQYC2nnuls1+OqZdhHfQJ
	 LW2O2Futp+izeVtQ2XLabNVk5NK0qq9r97rJxnS0f8WQETU9BiFEI5Ct5P2Kai2/RWSNW
	 uxIcPOgv6HnRmEheWDUd9jcjTpXBmyt0y1yzP8UwbJjLEan3KmTKmk9K/ns4L+gr+k1V9
	 eO/V0zLpkoapUwDuTnKhaWMemDEpTX1wrakPzP+MhTaV7bLV7siD2MKnTixFUcC5P6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MmjdsJGp;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9B606A32A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 18:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F9B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MmjdsJGp
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-451a49abd8aso904498fac.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778695; x=1793383495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YyvIsZLH5odQ9OcSqcettzCR4/nFwFLMVbl002HSWDQ=;
        b=MmjdsJGpTjrnvIjT1Pzasc8X1ulew39LBn9FeZwjcJeE0vsKRyUfxICh21cikMCsjN
         ZXZSa/HWUwBr0/IDuU/bKP3e4/nGPf0NmmAsbgQUnhxKfQuf94sily0wDu+mvvNp/0Ul
         uloK8o+EZw2im+GlCqscjoqUmZH1fVZvOO+F0VHAMT+BZegl4eMqjgGChmAZmoGPhwmg
         7zhgMup+d8HbE6LRfoxizmLZuqCys3rg7ipdD/Ay+PX5M55IlxlDu+8/jY7k3Iieb7xP
         Uhnt1S1rbfjJxZ9zrTJP2UG1/KdmCEzzn98La9W2V6zemPswCSl0vk1Eqg1cLLMRuegr
         aNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778695; x=1793383495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyvIsZLH5odQ9OcSqcettzCR4/nFwFLMVbl002HSWDQ=;
        b=DuLCttQXn+Hf6Lb0csIK+nstp4DGoYtjwUm7GapEDH+tHEuc9naX5fSBM2yXE80Yol
         j4WpE8aaHbqDeBxpzGLlADuwtRZmqDgvNGEmYDMFQPk0dYEBh2vdU+v6F/m/fJkLa+Vm
         O2m+wnRlRvP4Qsq0kZjlQEBWsWbT1n79YOJrbcUp1NwxfmbQCuNmROH6ZcCiCqJRGXqM
         45gysO+gs70FuYIQbKYA9hq8ctlTQu4gGj08VvaLidEhtOH/8qUGM0f7I5IqUnxlBjm+
         fESAVcspPzVeGgQSbLy0pP0WH6XoCc5AKLm59oIY9msGc82yHfnZxcJDzuTthQFq0Xgz
         1dmA==
X-Forwarded-Encrypted: i=1; AKwUvBwPhaIpfvftk63ajhXAukbnlL+2UK17kybKX7V7+z9RSBJYdnJV9XHa8X1yGuwmhzpxRCG3QBMWVp3OE+k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIu+jerCw8r9w418Z1u20uSjhjbgIw5V743/YNhYzv917Tra3Im
	drdyEITavdsSR/yLSK375SE0bULI2LxVFhZEYZHhMyVH2koX4XSGz0fU
X-Gm-Gg: AYBFou0v1XU1oVNtG9K6yspve+icgOVRvP9kZQLd5vJB3WyGjMGydMWP0jV0w09IWCx
	fQg+GyHvixLEbjtIjtucm7gWdJq11iIYHqWitDqxRwvf8ZVVKCvrMDgufCrosKBD1DTQPncbXrA
	uGsbd6FMytEhvia1ZjUo4mKo0Xi/zNGzN+uJcyHLo+6fDKXG1i+NJrz0430aO1XTWvbUQTOUav3
	bSWnvckL65GiUxO5boBI7kgs4qjlBv6RtgWT95OSCQ/h7c+BN1R6KRwTOJGqV4Vhj5ZF9idD602
	X5EvN3KChbnkt2mEvSW846hvkij4O4CsauZhIVoY0KcMDFIttkr55ZRoEOjMfu/iF8turupA215
	MeLGPzNP4aB54azyh+Hrb77NXv751EV0BWcQ6UR/0Hl+Pt/tdtpeHMQXFQX+8C5m99rXLOOqVJH
	aadMKXl8tFh9WW3V52x5KOcnoP+Em5yVVIjl/j3G7wfWUE7wGpeG7HWXDV8mnFC8zJ6uoVWJnuE
	+cKp3JzRVJThaRrcOw54c3M9L9AwOdp5D/X16cc4Qj2M8dBNbz59eKF4sbeGNy0kSL+ZwHtRgiV
	zoFMXg7o3AXzHqEulE1lXw9mcXd73yd3pww1Sv6rQXHJWAoMeWNWuCXXWIHgNQ+fjxx7myfwkOZ
	qR/A1LHGECWxOwdTePxluJCYo+rm59r2MJL5iKkSo4CNgDkUuLzMEbhmv0E49zh2hHihRBtuiVq
	DRvA==
X-Received: by 2002:a05:6871:6d0e:b0:4a8:26f9:d217 with SMTP id 586e51a60fabf-4a83f00d1e1mr128273fac.1.1792778695376;
        Fri, 23 Oct 2026 11:04:55 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a838207cb9sm544329fac.5.2026.10.23.11.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:04:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 12:04:30 -0600
Subject: [PATCH v3 2/4] serial: core: allow drivers to reserve flushed
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
Message-Id: <20261023-submit-serial-8250-dma-cancel-v1-v3-2-d78f9e4c4932@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com>
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

uart_flush_buffer() resets the transmit FIFO before calling the driver's
flush callback. An asynchronous DMA transfer can still access that storage
after the callback returns, while a new write can immediately reuse it.

Add uart_xmit_block() and uart_xmit_unblock() so a driver can reserve the
flushed storage until its transfer and completion callbacks have retired.
Serialize the reservation with FIFO producers using the port lock.

While the storage is reserved, write_room() reports no space and write()
and put_char() accept no data. Defer write-ready notifications until the
reservation is released, preserving one-shot TTY wakeups. Keep the flush
wakeup under the port lock so it cannot race another reservation.

Suppress ordinary TX starts while the FIFO storage is blocked. Preserve
high-priority flow-control characters, which use separate storage.
Releasing the reservation wakes writers through the existing TTY wakeup
path. This preserves immediate logical flushing while applying write
backpressure until the storage is reusable.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/serial_core.c | 56 +++++++++++++++++++++++++++++++++++++---
 include/linux/serial_core.h      | 16 ++++++++++--
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af4..cb4e98886cee 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -119,10 +119,53 @@ void uart_write_wakeup(struct uart_port *port)
 	 * closed.  No cookie for you.
 	 */
 	BUG_ON(!state);
+	if (state->xmit_blocked)
+		return;
 	tty_port_tty_wakeup(&state->port);
 }
 EXPORT_SYMBOL(uart_write_wakeup);
 
+/**
+ * uart_xmit_block - reserve flushed transmit storage
+ * @port: port whose transmit storage is still in use
+ *
+ * A driver may call this from ->flush_buffer() if DMA still owns the old
+ * transmit data. The logical FIFO has already been emptied, but writers
+ * must not overwrite its storage until uart_xmit_unblock() is called.
+ * write_room() reports zero and write()/put_char() accept no data meanwhile.
+ * Write wakeups are deferred until the reservation is released.
+ *
+ * The driver must unblock after retiring the transfer, including on shutdown.
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
@@ -143,6 +186,9 @@ static void __uart_start(struct uart_state *state)
 
 	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port))
 		return;
+	/* High-priority flow-control characters have their own storage. */
+	if (state->xmit_blocked && !port->x_char)
+		return;
 
 	port_dev = port->port_dev;
 
@@ -260,6 +306,7 @@ static int uart_alloc_xmit_buf(struct tty_port *port)
 	uport = uart_port_ref_lock(state, &flags);
 	if (!state->port.xmit_buf) {
 		state->port.xmit_buf = buf;
+		state->xmit_blocked = false;
 		kfifo_init(&state->port.xmit_fifo, state->port.xmit_buf,
 				PAGE_SIZE);
 		uart_port_unlock_deref(uport, flags);
@@ -593,7 +640,7 @@ static int uart_put_char(struct tty_struct *tty, u8 c)
 		return 0;
 	}
 
-	if (port)
+	if (port && !state->xmit_blocked)
 		ret = kfifo_put(&state->port.xmit_fifo, c);
 	uart_port_unlock_deref(port, flags);
 	return ret;
@@ -624,7 +671,7 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
 		return 0;
 	}
 
-	if (port)
+	if (port && !state->xmit_blocked)
 		ret = kfifo_in(&state->port.xmit_fifo, buf, count);
 
 	__uart_start(state);
@@ -640,7 +687,7 @@ static unsigned int uart_write_room(struct tty_struct *tty)
 	unsigned int ret;
 
 	port = uart_port_ref_lock(state, &flags);
-	if (!state->port.xmit_buf)
+	if (!state->port.xmit_buf || state->xmit_blocked)
 		ret = 0;
 	else
 		ret = kfifo_avail(&state->port.xmit_fifo);
@@ -682,8 +729,9 @@ static void uart_flush_buffer(struct tty_struct *tty)
 	kfifo_reset(&state->port.xmit_fifo);
 	if (port->ops->flush_buffer)
 		port->ops->flush_buffer(port);
+	/* Serialize the wakeup with reservation changes, including another flush. */
+	uart_write_wakeup(port);
 	uart_port_unlock_deref(port, flags);
-	tty_port_tty_wakeup(&state->port);
 }
 
 /*
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4eeb8253752a..92164bd598ba 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -208,8 +208,16 @@ struct gpio_desc;
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
+ *	since serial core then frees the transmit buffer.
  *
  *	Locking: @port->lock taken.
  *	Interrupts: locally disabled.
@@ -834,6 +842,8 @@ enum uart_pm_state {
  */
 struct uart_state {
 	struct tty_port		port;
+	/* Flushed TX storage is reserved; protected by the UART port lock. */
+	bool			xmit_blocked;
 
 	enum uart_pm_state	pm_state;
 
@@ -909,6 +919,8 @@ struct uart_driver {
 };
 
 void uart_write_wakeup(struct uart_port *port);
+void uart_xmit_block(struct uart_port *port);
+void uart_xmit_unblock(struct uart_port *port);
 
 /**
  * enum UART_TX_FLAGS -- flags for uart_port_tx_flags()

-- 
2.53.0

