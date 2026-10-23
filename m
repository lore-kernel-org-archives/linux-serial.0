Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715665;
	b=sBopoNYAk8n/lhLBQVpPSDO6dnshCvR16iFlQzgo5Ri+8TLPA2hAh3vG8pIGiNuHQC9d
	 UeEvizvqljNsP1udlJfxNPFKhgVIeTzSW1nHs1HiGphdgrRcci+A81stqKRcEWmH+X7TO
	 gPQ1k4gVYqZx36BLYWg4wS4uqu4d6J20ggSjbc5e4SlTNvzfM8RPiHf2OiHAi/1k/IH9/
	 06E+dZF5NsMucyOtUoGySRzNLvht8WHBLTcq2twXpflRwYazptFbSeRhUC58ZrfE7o75n
	 VVhjIryzI4twlYUARYnZqPC1P8Bki2Q9bjgaPZABWSlAZDLWnG3j5gu5gCF6v4I02WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xCNmnAMxphqz2uG35/ba+omaEbEimRYviBo2UjFGZcQ=;
	b=AdBS+zDcp5PioqO4/wOz0hLFjwWRy3M4hW2G5CcDtbslb8mfsnSqT5h53N1WLdOae7U7
	 YHwLxPsTJxYG/lyaBzOQ26J8KXy1FVDJsDQ2aYQsnV1ccvnyrc6BihvkUFxZO/HTvMeTn
	 dPFsl2662LaXE2nIy/HfidRgEqy89i9MpWV5KfzEcznlQUBDgMXxemT7fWPagvsUlATQ/
	 AI9alWZUN7jJoRYTDVWSmzPhXEPjjS1GojkSdit+jlA1zzj6EpjZPVrOzMOX4esQqUGlH
	 TOZT5kWlptp9YOBz8xk3yID5In6R/Pxs40RUDTCbI8ZkRot5XbOXge981YE7kHwoQMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y1pltY9J;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38399606A327
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38399606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y1pltY9J
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-451a49abd8aso286415fac.3
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 17:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792715663; x=1793320463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCNmnAMxphqz2uG35/ba+omaEbEimRYviBo2UjFGZcQ=;
        b=Y1pltY9JN9is/Ix+QWIDFlXbIS9eby0RgU4m7i3Fjs8M/G9sFBQ/6rPLYSq0lPsBWU
         OFmdiU7G+Do04R6O2kEzpZ6+8/lXiE3TI1fo8WMTwqKlfmL+w9Oir18EbCujM35qy6Mc
         hgnOIRGxmJzF7d8qjdbptDHZRNcZ3gQigzqEWl+Pyztc6y2CmycqupldCwYd9WVyUvP6
         YwUlfmgdvQLD/3ouyrBL5Ca1O+GYm0f7hMwz0wkvhP4NyYi//nNXlowGa17MM0YwW7RV
         zucQrh2xndMg4dIUKm1zX9Tt1551B/l9sgvZG0/t+CG96tMr6WXC94UckmvxCaY80rOA
         lLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792715663; x=1793320463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xCNmnAMxphqz2uG35/ba+omaEbEimRYviBo2UjFGZcQ=;
        b=xdK4mMB6WmkLTQ1rEUgZDFrZCQFbQGQkl92g+4vMj2OiXrcKE84o5ndhmUYM/C5H7K
         KjkThVxQw5QOMxX42dsv2USMMOsMGiXQWXBbFLQvXqj8u8WYcQ4+z7KlA+xCFhigTmkN
         CziD0608y7FNtK3c3sOofc/MnZTojE/SLlzqrZU8h86Jz57Hj0ZUwMfbxQvURih6hdXj
         yrWUAweSfT94dxf9VYXg8vFvixsRi4W+GIXtIpM69Q5D+hzBcvb19danm8NXHOdZcQwQ
         ppF8LdDwfk2T11/MW2oDkN/TNEK1o+lDxdFy6cl3CwSGN7LFVDh9alLW4Q1K+dlmIhQu
         08Gg==
X-Forwarded-Encrypted: i=1; AKwUvByvagfPh9fzSNASBk19XGO2OE57emgjMGtlemwNa+q2BZwV+hDOimhgA+nqj8V7DN+KKlCeCuYHQvBEhSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+Mqr9KzszimQG2p91NR+kvkOq2C7BlzDh6ueWa8YVEdwtthMX
	bJBDL2sUh3ziRliKrvF/kvOIw4sO8AdP+P9sBl1pUd4J0+ib11Q7067K4mkYjETF
X-Gm-Gg: AYBFou1d5MfMjvGRZj6fi07DAQ+7Y5T0BFncUVNVrhmXx5JqSbJENz423I2xA4ZF0jI
	mhGWq/j4xn0BVN/Uj+vlbqB0l7XEsL4jLuEmXahnH6nNFHbD6//FUGFYGKpZhTEVWXiNWF4pUqv
	XsmpEokjz3WDKHxlCKVoGQgGRRhzIwlDqAV9SLCziL4tDGR7/z+/noFfwnDlmdqkCzDQNza3DLK
	e4nxNPLk4jasBmwGCl47bj3ejoOwcTEEhH0uzCNH9BmP3zYPWyCR5G4NI7ploaTj1aXv7n8wLUs
	QznahPJOZXe2s6ngGBFZaH/+YJc7apMdswjw6hhMyxCv729LXu60Vk9HM7759zh5zQg3YVFCCJ9
	/B3oXtKDK4pm8PTkNdo74ophMlC5eew7W6NoNwcEQ65TOblBlVgCYz7oZbt32wPFUe6KHDTOfoG
	W+Q04xONc0Xlc2WZGDN/eN8QkhXo35PhzBkA5JXxJPypgGVGxTcr2DGmBqjTmvHqn7jzl1S+uxH
	rdu2/70eIz7Jq15IY/vSMjbfXE9NdUuCErEKvUhL/gugulBJPV9zfaij4jBiW4ZbRoBpiYOTs0o
	g/xDoIanxB2DfS7Yngwh3mJerDAU1IeJheEl/CaRVz7bzlBlPy8kbw8RDOUBdsAMX9I9R64SMCP
	5DhDwgGsm/safUirkMDASaheWfQf31/gKQe6ZK7NqMUHKTpyaT18OP7pgYuER1x+oSjCJuxykg5
	Iilw==
X-Received: by 2002:a05:6870:812e:b0:491:520f:e6d0 with SMTP id 586e51a60fabf-4a821ef8dcemr318338fac.4.1792715663148;
        Thu, 22 Oct 2026 17:34:23 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a820a9bcf6sm459716fac.12.2026.10.22.17.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:34:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 18:34:03 -0600
Subject: [PATCH v2 2/4] serial: core: allow drivers to reserve flushed
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
Message-Id: <20261022-submit-serial-8250-dma-cancel-v1-v2-2-088ea51e3891@gmail.com>
References: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
In-Reply-To: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
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
and put_char() accept no data. Releasing the reservation wakes writers
through the existing TTY wakeup path. This preserves immediate logical
flushing while applying write backpressure until the storage is reusable.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/serial_core.c | 47 +++++++++++++++++++++++++++++++++++++---
 include/linux/serial_core.h      | 16 ++++++++++++--
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af4..f82c812f842f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -123,6 +123,46 @@ void uart_write_wakeup(struct uart_port *port)
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
@@ -260,6 +300,7 @@ static int uart_alloc_xmit_buf(struct tty_port *port)
 	uport = uart_port_ref_lock(state, &flags);
 	if (!state->port.xmit_buf) {
 		state->port.xmit_buf = buf;
+		state->xmit_blocked = false;
 		kfifo_init(&state->port.xmit_fifo, state->port.xmit_buf,
 				PAGE_SIZE);
 		uart_port_unlock_deref(uport, flags);
@@ -593,7 +634,7 @@ static int uart_put_char(struct tty_struct *tty, u8 c)
 		return 0;
 	}
 
-	if (port)
+	if (port && !state->xmit_blocked)
 		ret = kfifo_put(&state->port.xmit_fifo, c);
 	uart_port_unlock_deref(port, flags);
 	return ret;
@@ -624,7 +665,7 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
 		return 0;
 	}
 
-	if (port)
+	if (port && !state->xmit_blocked)
 		ret = kfifo_in(&state->port.xmit_fifo, buf, count);
 
 	__uart_start(state);
@@ -640,7 +681,7 @@ static unsigned int uart_write_room(struct tty_struct *tty)
 	unsigned int ret;
 
 	port = uart_port_ref_lock(state, &flags);
-	if (!state->port.xmit_buf)
+	if (!state->port.xmit_buf || state->xmit_blocked)
 		ret = 0;
 	else
 		ret = kfifo_avail(&state->port.xmit_fifo);
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

