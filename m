Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715667;
	b=0tukHrLW3kZiUXpDwGv81JJi0EYQAiIwOG7JtEkxpO4IQ/Y1qW9iLxfwVGdc8VhbObiT
	 xspTt9GS9LXMDBc0EdSPPkj0PNQCyY5rVFG1yCIlZUl//LOemkD9+/6sXBDszdKkoCU/M
	 ogEbkIv3fWqBos6Wk7lQrEXxSjfGtaJu14gz0Jzb4UCP5eCyQRcivYU0Br8mZAqyKwC1k
	 A5cTLbdMOZbDa3QflX9VFOXUxkUi8tlJO+a53w6vCjQIgz+3KwyETiJ9TlPMpp8Tn4ZIO
	 Uo7NyzhIc/8nJ3Gemk0FpP3WZPU45zN9tT+CxaXKpr7ZNyGAt2DrZowFyDijf9n+FSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=jMCspzJcufBWvR+JGv+XcZWocsm9qIJeCt7Ki3YILZU=;
	b=X7bfRyBfl7Q4EAQDWnhdcCp+hjmhuVV0GDD5MLAHYmLBlpsWaEKNEkERXEg7frwr4b6W
	 YvBMLURa0MCrEFKfz6PHrJSRCLZ6NMDOmFopUdIjUqlnTu2DXIh76Xb3mn1BP57TE/mcd
	 S/nC0ikPB1SbvyZNvxS0XFN0NTl/+pFgAkHrtKMNBYn0P8MPNGyWax/HkD9uqXUJIIf6v
	 20KIoxW7W0e5L9PCsSKmx7/I6bc5+WJ4GioXdVwMdEhGB2BMy9EbbU/gLCEQtXQNK2I4/
	 TFBsA62YrMKGBR9mrolaatYhhVHpMRt63xqeo51SDKWialckZEmlGVTYidANF3fuReQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="U/DBPImR";
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950CB606A328
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 950CB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U/DBPImR
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-48e94879f02so159224fac.0
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 17:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792715665; x=1793320465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jMCspzJcufBWvR+JGv+XcZWocsm9qIJeCt7Ki3YILZU=;
        b=U/DBPImR3U6tfv1AtMgl/kgAAwNAnr41YIiob/vyWuuzRMHMMO9X8bZqcW5735metR
         6atGw8x82BxlcY+3d9WEg3uSKu42/qKmanalUwCbdrDyojOFT6rSfKE2x/JxEV5tHt3j
         5ku98c36ZK9EGyYWI3erKANozucCinZ3RRBQdY18odP7NY44vRnPq5HzOyWBcbBKvgUA
         EnJaPWjRtMsqx/I7zPLwunGUIt5a9IgO/mxv/jwpn8DJBe/Ec92bcBFMApLocVKbMRxk
         o8QKV82KuJM3d3Iq/LX/Xkh63xI52oOvpIECzHm3mn+QHk0IWPWa4PxDrms9XTBGbIwK
         19oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792715665; x=1793320465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMCspzJcufBWvR+JGv+XcZWocsm9qIJeCt7Ki3YILZU=;
        b=q5nSNpM2GvK0AKFCrzzssFqfNYnsfRuhg2zMfjPRvilcDIQ4utTs3fh+JOd7mJ6F75
         xY0w5jjkOgFenwCz5XIsewqWPZ1sc1fi5WV/oNHn+WGzNtkvv8r7X2sVzpOfE0xFPGDN
         p0h44hldBvHkdbykLk8t7Db4H1jAgvmCR3vpEeCHGc9a0L6qP4aFD4jztzrYzXjiJhNU
         JkKvJYMUcaLesVOfM7Kvig9WNoqfqkiLQp4eZFrfb5eMjzUsTb7YogkFpPvoiinJa7EN
         3cmMC8JzlKU27Cf8/O94IWIhbEIg4g+gkqz6b0VzF+fX/XUZ8GkwhL3i/ibj1vbBloaC
         /aog==
X-Forwarded-Encrypted: i=1; AKwUvByIYjs+UPcJXSrz/hRdsH6wCia+OoE7ZdaDwhAwq1sqi5elsso+BgRWygXA8OW/vnv+oMk6iEeXk52hTt0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPJ121jcHwH332X1bGtkV6UDKKJBzgrurtYNTSw9J0dHsDUFid
	bFdGEa0MDGZzk6vuM+fJl0e19OVgkXzlO/PBL5bwhHivtFoKMvbl8cv95VcrHgBY
X-Gm-Gg: AYBFou3WE7zyXX4kzB7JmOWNvB6KjMrVSktLZBCcqj29qFHOGBFj+Wz3GBcfvnggQMP
	Q+1zdheZk8kOF0Gh3VmG6SUZ486G7ZewOnwkNeCTjidjjtzsA9vRp/fr9PsDOfQs5YlCSCD3+Zp
	0XuPwSQdgJXs+XBWxSzCLhD2EjQ24U7aUKPdLIiZrjYtjAgVUyuijUFnXP7NUar5U+qaUWCGB/M
	HVpoeesMMBMCExtj015sckRtL9KlFmmqDZwA4iZysklZFQ1aYmvnc50dX6WsAT9jZX/jAEDjM4n
	FFw1OB6/EDAe0ReeQcSV90SPkUo/Meg4iV2Vo2Zu5Ei0UBUKjhnfA8VXwpk793sQ7wEGesBhGUt
	he+uOvMXemXu7LyhEAXvmaGDyc5WPBpiHdd0KXvgp9jttzT5mKIz1Vc2MRbtA0SO/lj+bKXUZGD
	XOZ8Bb2N8Gwz42xEwJ4IRiz7Acg82Zz99eOU6T231hqIT5vCxsO2xMZvtkZHkC1NAWKzr/kUMvp
	DJ0vRBlLgiuplxMROuMiOBSGhpfYj6pGZm+Hzgus+6eNuBvkLwjIFKHR0b1yq9DuIRgMQbWm/0D
	1+rXsxCXj2O7RVInP+BhZjQtE5vxH/9yWRGbJFezl5AtHcQyH5R247Vw9y2PUZA3ujPGHtomB1n
	1Iza2q3rbiL8/t7UXyTMuKt44p83spx+qaThrh+MjAeuWaPXKPBu8jSvvd5zkUJVu/hMuqj/G/p
	VuZw==
X-Received: by 2002:a05:6871:e496:b0:48f:e137:dc80 with SMTP id 586e51a60fabf-4a8224969b9mr300487fac.57.1792715665383;
        Thu, 22 Oct 2026 17:34:25 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a820a9bcf6sm459716fac.12.2026.10.22.17.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:34:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 18:34:05 -0600
Subject: [PATCH v2 4/4] serial: 8250: retire canceled RX DMA before reusing
 the receive buffer
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
Message-Id: <20261022-submit-serial-8250-dma-cancel-v1-v2-4-088ea51e3891@gmail.com>
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

The RX timeout path pauses a transfer, copies its data and terminates it
asynchronously. Clearing rx_running at that point lets another receive
reuse the buffer and cookie while the old callback is still waiting for
the port lock. Inspecting the new cookie cannot distinguish that callback
from the completion of a new transfer.

Reserve the receive buffer until a worker has drained the canceled
callbacks. Deliver the paused data before allowing the interrupt handler
to drain the FIFO through PIO. Normal retirement only releases ownership;
leave subsequent receive handling to the UART interrupt instead of reading
LSR and restarting DMA from the worker.

Reject new flush work during shutdown, including late Intel MID DMA
timeouts. Serialize those timeout callers with the port lock. Stop and
drain retirement work before freeing the channels and buffer.

Check pause failures before accessing the buffer. A successful pause is
the quiescence guarantee, even when a provider still reports IN_PROGRESS.
On pause, status or termination failure, mask receive interrupts and let
the worker stop DMA before handing the FIFO to PIO. Preserve stop_rx() and
shutdown while restoring deferred interrupts, and hold a runtime PM
reference around worker register accesses. Keep RX on PIO until reopen.

Abort the DesignWare idle sequence when RX cannot be stopped. Preserve its
empty-FIFO timeout workaround during PIO recovery. If the provider still
cannot terminate the channel in process context, retain its buffer and
leave receive interrupts masked.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  14 +++-
 drivers/tty/serial/8250/8250_dma.c  | 149 +++++++++++++++++++++++++++++-------
 drivers/tty/serial/8250/8250_dw.c   |  15 +++-
 drivers/tty/serial/8250/8250_mid.c  |   6 +-
 drivers/tty/serial/8250/8250_port.c |   5 +-
 5 files changed, 151 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ec837c380695..e3b5a605bb55 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -23,6 +23,7 @@ struct uart_8250_dma {
 	/* Completion processing with the port lock held. */
 	void (*tx_complete)(struct uart_8250_port *p);
 	struct work_struct tx_flush_work;
+	struct work_struct rx_flush_work;
 	struct uart_8250_port *port;
 
 	/* Filter function */
@@ -60,6 +61,10 @@ struct uart_8250_dma {
 	bool			shutting_down;
 	bool			tx_terminating;
 	bool			tx_flushed;
+	bool			rx_terminating;
+	bool			rx_err;
+	/* Receive interrupt enables deferred during RX DMA recovery. */
+	u8			rx_ier;
 };
 
 struct old_serial_port {
@@ -412,7 +417,7 @@ extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
 				   struct scatterlist *sgl, unsigned int nents);
 extern int serial8250_rx_dma(struct uart_8250_port *);
-extern void serial8250_rx_dma_flush(struct uart_8250_port *);
+int serial8250_rx_dma_flush(struct uart_8250_port *p);
 extern int serial8250_request_dma(struct uart_8250_port *);
 extern void serial8250_release_dma(struct uart_8250_port *);
 
@@ -468,7 +473,12 @@ static inline int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	return -1;
 }
-static inline void serial8250_rx_dma_flush(struct uart_8250_port *p) { }
+
+static inline int serial8250_rx_dma_flush(struct uart_8250_port *p)
+{
+	return 0;
+}
+
 static inline int serial8250_request_dma(struct uart_8250_port *p)
 {
 	return -1;
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bb30d3588f16..4cadb3eef941 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -84,55 +84,108 @@ void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
 }
 EXPORT_SYMBOL_GPL(serial8250_tx_dma_sync_buffer);
 
-static void __dma_rx_complete(struct uart_8250_port *p)
+static void serial8250_rx_dma_copy(struct uart_8250_port *p,
+				   const struct dma_tx_state *state)
 {
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tty_port = &p->port.state->port;
-	struct dma_tx_state	state;
-	enum dma_status		dma_status;
-	int			count;
-
-	/*
-	 * New DMA Rx can be started during the completion handler before it
-	 * could acquire port's lock and it might still be ongoing. Don't to
-	 * anything in such case.
-	 */
-	dma_status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
-	if (dma_status == DMA_IN_PROGRESS)
-		return;
-
-	count = dma->rx_size - state.residue;
+	size_t			count = dma->rx_size - state->residue;
 
 	if (tty_insert_flip_string(tty_port, dma->rx_buf, count) != count)
 		p->port.icount.buf_overrun++;
 	p->port.icount.rx += count;
-	dma->rx_running = 0;
 
 	tty_flip_buffer_push(tty_port);
 }
 
+static void serial8250_rx_dma_mask(struct uart_8250_port *p)
+{
+	u8 rx_ier = UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE;
+
+	p->dma->rx_ier |= p->ier & rx_ier;
+	p->ier &= ~rx_ier;
+	serial_port_out(&p->port, UART_IER, p->ier);
+}
+
+static void serial8250_rx_dma_recover(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	/* Keep PIO and new descriptors out until the worker stops the channel. */
+	dma->rx_err = true;
+	dma->rx_terminating = true;
+	serial8250_rx_dma_mask(p);
+	schedule_work(&dma->rx_flush_work);
+}
+
 static void dma_rx_complete(void *param)
 {
 	struct uart_8250_port *p = param;
 	struct uart_8250_dma *dma = p->dma;
+	struct dma_tx_state state;
+	enum dma_status status;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(&p->port, &flags);
-	if (dma->shutting_down)
+	if (dma->shutting_down || dma->rx_terminating)
 		goto out;
-	if (dma->rx_running)
-		__dma_rx_complete(p);
+	if (dma->rx_running) {
+		status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+		if (status == DMA_ERROR) {
+			serial8250_rx_dma_recover(p);
+			goto out;
+		}
+		if (status != DMA_COMPLETE)
+			goto out;
+		serial8250_rx_dma_copy(p, &state);
+		dma->rx_running = 0;
+	}
 
 	/*
-	 * Cannot be combined with the previous check because __dma_rx_complete()
-	 * changes dma->rx_running.
+	 * The completed transfer no longer owns the receive buffer.
 	 */
-	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
+	if (!dma->rx_running && (p->ier & UART_IER_RDI) &&
+	    (serial_lsr_in(p) & UART_LSR_DR))
 		p->dma->rx_dma(p);
 out:
 	uart_port_unlock_irqrestore(&p->port, flags);
 }
 
+static void serial8250_rx_dma_flush_work(struct work_struct *work)
+{
+	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, rx_flush_work);
+	struct uart_8250_port *p = dma->port;
+	int ret;
+
+	if (dma->rx_err) {
+		ret = dmaengine_terminate_sync(dma->rxchan);
+		if (ret) {
+			/* Retain ownership and keep RX masked if DMA cannot be stopped. */
+			dev_err(p->port.dev, "failed to stop RX DMA: %d\n", ret);
+			return;
+		}
+	} else {
+		dmaengine_synchronize(dma->rxchan);
+	}
+
+	guard(serial8250_rpm)(p);
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	dma->rx_terminating = false;
+	dma->rx_running = 0;
+	if (dma->shutting_down)
+		return;
+
+	if (dma->rx_err) {
+		/* PIO may now drain the FIFO; stop_rx() can cancel these enables. */
+		p->ier |= dma->rx_ier;
+		dma->rx_ier = 0;
+		serial_port_out(&p->port, UART_IER, p->ier);
+		dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
+	}
+}
+
 int serial8250_tx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;
@@ -242,6 +295,8 @@ int serial8250_rx_dma(struct uart_8250_port *p)
 
 	if (dma->shutting_down || dma->rx_running)
 		return 0;
+	if (dma->rx_err)
+		return -EIO;
 
 	serial8250_do_prepare_rx_dma(p);
 
@@ -262,16 +317,49 @@ int serial8250_rx_dma(struct uart_8250_port *p)
 	return 0;
 }
 
-void serial8250_rx_dma_flush(struct uart_8250_port *p)
+int serial8250_rx_dma_flush(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
+	struct dma_tx_state state;
+	enum dma_status status;
+	int ret;
 
-	if (!dma || !dma->rxchan || !dma->rx_running)
-		return;
+	lockdep_assert_held_once(&p->port.lock);
 
-	dmaengine_pause(dma->rxchan);
-	__dma_rx_complete(p);
-	dmaengine_terminate_async(dma->rxchan);
+	if (!dma || dma->shutting_down || !dma->rxchan || !dma->rx_running)
+		return 0;
+	if (dma->rx_terminating) {
+		if (dma->rx_err) {
+			/* A termios or RS485 change may have enabled RX interrupts. */
+			serial8250_rx_dma_mask(p);
+			return -EIO;
+		}
+		return 0;
+	}
+
+	ret = dmaengine_pause(dma->rxchan);
+	if (ret)
+		goto recover;
+
+	status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	if (status == DMA_ERROR) {
+		ret = -EIO;
+		goto recover;
+	}
+	/* Some providers still report IN_PROGRESS after a successful pause. */
+	serial8250_rx_dma_copy(p, &state);
+	dma->rx_terminating = true;
+	ret = dmaengine_terminate_async(dma->rxchan);
+	if (ret)
+		goto recover;
+
+	/* Keep the buffer reserved until any old completion has returned. */
+	schedule_work(&dma->rx_flush_work);
+	return 0;
+
+recover:
+	serial8250_rx_dma_recover(p);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
 
@@ -369,8 +457,12 @@ int serial8250_request_dma(struct uart_8250_port *p)
 
 	dma->port = p;
 	INIT_WORK(&dma->tx_flush_work, serial8250_tx_dma_flush_work);
+	INIT_WORK(&dma->rx_flush_work, serial8250_rx_dma_flush_work);
 	dma->tx_terminating = false;
 	dma->tx_flushed = false;
+	dma->rx_terminating = false;
+	dma->rx_err = false;
+	dma->rx_ier = 0;
 
 	scoped_guard(uart_port_lock_irqsave, &p->port)
 		dma->shutting_down = false;
@@ -396,6 +488,7 @@ void serial8250_release_dma(struct uart_8250_port *p)
 		return;
 
 	cancel_work_sync(&dma->tx_flush_work);
+	cancel_work_sync(&dma->rx_flush_work);
 
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d1..8a637a85f101 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -134,6 +134,7 @@ static int dw8250_idle_enter(struct uart_port *p)
 	unsigned int usr_reg = d->pdata ? d->pdata->usr_reg : DW_UART_USR;
 	struct uart_8250_port *up = up_to_u8250p(p);
 	int retries;
+	int ret;
 	u32 lsr;
 
 	lockdep_assert_held_once(&p->lock);
@@ -147,7 +148,12 @@ static int dw8250_idle_enter(struct uart_port *p)
 	serial_port_out(p, UART_IER, 0);
 
 	if (up->dma) {
-		serial8250_rx_dma_flush(up);
+		ret = serial8250_rx_dma_flush(up);
+		if (ret) {
+			serial_port_out(p, UART_IER, up->ier);
+			d->in_idle = 0;
+			return ret;
+		}
 		if (serial8250_tx_dma_running(up))
 			serial8250_tx_dma_pause(up);
 	}
@@ -435,10 +441,11 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * read.  If we don't do this then the "RX TIMEOUT" interrupt will
 	 * fire forever.
 	 *
-	 * This problem has only been observed so far when not in DMA mode
-	 * so we limit the workaround only to non-DMA mode.
+	 * Only read the FIFO when DMA no longer owns it, including PIO fallback
+	 * after a DMA error.
 	 */
-	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) && !up->dma && rx_timeout) {
+	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) &&
+	    (!up->dma || !up->dma->rx_running) && rx_timeout) {
 		status = serial_lsr_in(up);
 
 		/*
diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 44b43163df51..83f928b1f643 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -94,7 +94,8 @@ static int tng_handle_irq(struct uart_port *p)
 	/* Rx DMA */
 	err = hsu_dma_get_status(chip, mid->dma_index * 2 + 1, &status);
 	if (err > 0) {
-		serial8250_rx_dma_flush(up);
+		scoped_guard(uart_port_lock_irqsave, p)
+			serial8250_rx_dma_flush(up);
 		ret |= 1;
 	} else if (err == 0)
 		ret |= hsu_dma_do_irq(chip, mid->dma_index * 2 + 1, status);
@@ -148,7 +149,8 @@ static int dnv_handle_irq(struct uart_port *p)
 	if (fisr & BIT(2)) {
 		err = hsu_dma_get_status(&mid->dma_chip, 1, &status);
 		if (err > 0) {
-			serial8250_rx_dma_flush(up);
+			scoped_guard(uart_port_lock_irqsave, p)
+				serial8250_rx_dma_flush(up);
 			ret |= 1;
 		} else if (err == 0)
 			ret |= hsu_dma_do_irq(&mid->dma_chip, 1, status);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f36f7e18ab95..2f901e97aade 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1305,6 +1305,8 @@ static void serial8250_stop_rx(struct uart_port *port)
 
 	guard(serial8250_rpm)(up);
 
+	if (up->dma)
+		up->dma->rx_ier = 0;
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	serial_port_out(port, UART_IER, up->ier);
 }
@@ -1816,8 +1818,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 		fallthrough;
 	case UART_IIR_RLSI:
 	case UART_IIR_RX_TIMEOUT:
-		serial8250_rx_dma_flush(up);
-		return true;
+		return !serial8250_rx_dma_flush(up);
 	}
 	return up->dma->rx_dma(up);
 }

-- 
2.53.0

