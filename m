Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795277;
	b=4x15TeMmRDMh6S74rFEhAvhbu6Zl+CyVgTJ5IKxjft/YSJsl1YR/TQWhK6i+Iy/5z4ph
	 oBVqqfZIfAhQ7g3yDuG0kd8PqTXg86M+ksCmME8F1C4tcxCoMKQXXkGtL9kbcEnf91FCs
	 VWbaJIzZj8HdY/zUxuWRSDt8O3gH3k85nTG54DrNpoD+mBBmSEuY0fTCeVJUhygFyWNYz
	 NxuYrtPkhO4GKExxBG3s3SADW1aH08StSmoE+l58BkIcekHrrtQLpfUwtuVWeWxXHzSaH
	 ILGzYvVA/k4D11FmE7RayEfD5ZhebuJeGceZ37iCPMCCVECyssGulC/rlMYkPjIGRZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=F2uIUTDdnxVwHKgACAyfkK/uND0dfem5GDacYqgCPG8=;
	b=TlLz2wO9RjYR0nqDa55YhW5XgnvCbMdS8GvvOidJfKCq3Rjm+jU/az1Ks6bWDLO4rinc
	 eRr3j3JC+yb+EGrbn0Kx98NunZ40A1N4sKOmP6z07HUSmbOeIjzDdMFmYw5ldWwqLyxyy
	 rJNS+czWb7+WNXvh2InsgRil77/BWNqJUceufvCf3aSlpo/TavwjtDY590mC1ECLPI+Bd
	 7e9M2djbt5jCZfosozjTm9mzG5d5JIYBDBwz1eS3GQ1+JT5J4KfnUuUq/GmakeG0fcLJU
	 8JkvOprPWe+bbCngbAdsFkHe6eOLNmUE+XzCq+RfUxvHEFfRFgWZWSfiDQcfJAtblRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wq7CSgd+;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B6606A334
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 22:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D3B6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wq7CSgd+
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43bf9548df4so1107057fac.0
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792795275; x=1793400075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F2uIUTDdnxVwHKgACAyfkK/uND0dfem5GDacYqgCPG8=;
        b=Wq7CSgd+XicFPEC3N9FVeoanm5+j6F+bvn2FCJ5ijx7kt4gMwnh+LN82ibMPRZS384
         VgDYQq0fAHX5YdX0SBCzX8jB12n5NW3lU70PMY2e/xcD5pwmpO9yORRgSs2zY78unJAS
         ozoO2qikQp9/Mjwseo0L4menV/9L7e0Q/vS34rAYnlykqK+ac0pkVejxnOrg39rXheXh
         3MEYDlQiziz4TTZYsyaPb2g/3D6vQ67lxFLiNRGQ5GqI8tPCKkvohf6luB8epxOsGDwr
         DHXnXgoFLnYJiek8OUBcNLKPGwQJZo+29hP1FLb1id1R9/oTtw8wWYhzRGZpZBc4bDYg
         kETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795275; x=1793400075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2uIUTDdnxVwHKgACAyfkK/uND0dfem5GDacYqgCPG8=;
        b=xz+Tf0rTIeMf5GWxGJNjPMiSnILv0JB7DCxXmiZ60GZMpgJvKbb2hwMDVs1yjnqneY
         PhGmUvQgkM8DAj4F5L3kYgkzOdUS6AQbsecUnu/ut0j2oXqudFucs9qo0FT3XJmVSvch
         lhsdvik7+vfUgZ5omrZrQXBa4kQuTHSit7uerg7V3fT75/MLGugQJZqCNntDKkc4c4nJ
         xY/yn6R1MYBThLhdEc95F3o0y7AxQXs3upVr52fFyCYOH9fNGjlabxkx/E8eQXkbDM0P
         mBl15vXR+0vgm6JWsj9AKew0wNjga/MoIWOzpQmh7PPyWUF/2tcY/VuKVlmnC7Ga6tHx
         YkLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvWivB+CZ0Q2CTAMxPrZWUSIF104k2wWuuRvM/S938KTonUduYlxMsfjdYqvrnB+9tCtJvyLnYHqnJuU0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVNuuZ1320QmusoUFKOeCB/bfSt2E3EwCvyGtF2amtjGSuHrhJ
	sfwukH4mxhDC5Je4Nf6nT+gkSmchSVrKga/FqkidhKudaaMPegJxv4k6
X-Gm-Gg: AYBFou3aUBwdh4X25ptqHFdcvNupeBTZLzoZ//LPqn9L6VNrpGpZ01R4mc7dRRQWGnU
	NV1jgRV6FeKuut5BCbiPrJ5m/acLKFzatjxk1GwOwIrTQRjpGut9bjW+ldAeUXd+AAEyUj38Ysa
	/Kp+7Jeur1+Pf05ExfB2CzXigw5Lf4EF4UnNf6ajbapwcVBXWA3aIcQw2OvHFNATwzyaZY3cWji
	1qzkdJAmMFXgt0JKjs2DHSQIlOOsEEguBD/j6pBGyecwovzk7d7qDQKjh3wW1Z25hMR65SOgK0t
	/BDuHWt070jl3AVybbTVB2gM4xA8VfcBilQfNC3zWJYke85scAPsxg1B1P4PeReDkWCTEK56pWk
	YErTc+cMkvHnKO3zDxHL8YUt5wSMNAK81+lAgJbkK9csRhTNmQu9eflvMebpobB6u16TtFTWPy2
	OkXf2yrMx0opojCnptAk6IyjjvkPSCme0n/eB0tSEpwItt51ggeuRgoPPIO01POsNnhkQAck1nT
	Uz2Tde6GXNy+UYPJyL3MR79xaowTe5BU2mOjzvYK6rZyGtbDZhIL/+7fDIa4GF6Hq/qtVh/AQin
	nfYz3IO1hp+6104yy7AYphuIodym1MZfvVIRcOfhmfy82du1rDEtllkDCm676HROT7lLNUtwVqb
	tkSOR7teusfKITUyBrv2dCfDh4SPkxK+a3zu+pM88r6mwUAFO+By5Hw93Sp6fxM1mBVP9AdlcGp
	QiKXA=
X-Received: by 2002:a05:6870:3c8e:b0:4a2:4c6c:c9d5 with SMTP id 586e51a60fabf-4a83effb874mr500515fac.7.1792795275448;
        Fri, 23 Oct 2026 15:41:15 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8431c012esm226213fac.11.2026.10.23.15.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:41:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 16:41:09 -0600
Subject: [PATCH v4 4/4] serial: 8250: retire canceled RX DMA before reusing
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
Message-Id: <20261023-submit-serial-8250-dma-cancel-v1-v4-4-e759de1839de@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com>
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com>
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
callbacks. Keep FIFO access separate from callback retirement: after a
successful pause and termination, clear rx_running while rx_terminating
prevents another descriptor from reusing the buffer. Deliver the paused
data before allowing the interrupt handler to drain the FIFO through PIO.
Normal retirement only releases ownership and leaves subsequent receive
handling to the UART interrupt.

Preserve the normal completion-path LSR read and gate DMA resubmission on
the receive interrupt enable, so stop_rx() prevents another transfer while
the status read retains its existing side effects.

Reject new flush work and PIO receive handling during shutdown, including
late Intel MID DMA timeouts. Serialize those timeout callers with the port
lock. Stop and drain retirement work before freeing the channels and
buffer. Once RX has stopped, allow the idle flush used by DesignWare LCR
recovery during shutdown. Clear the shutdown guard before startup
configures the UART and tests its interrupts.

Check pause failures before accessing the buffer. A successful pause is
the quiescence guarantee, even when a provider still reports IN_PROGRESS.
Also accept DMA_COMPLETE after a failed pause: completion can stop the
channel before its callback acquires the port lock, leaving nothing for
the provider to pause. Retire that completed transfer normally.
On pause, status or termination failure, mask receive interrupts and let
the worker stop DMA before handing the FIFO to PIO. Keep the requested
enables in the existing IER shadow and filter hardware writes throughout
recovery, including termios, RS485 and overrun-backoff changes. Apply the
current enables after recovery so stop_rx() and shutdown remain effective.
Hold a runtime PM reference around worker register accesses and keep RX
on PIO until reopen.

Abort the DesignWare idle sequence when RX cannot be stopped. Keep its
BUSY-safe divisor setter installed after fractional-divisor discovery, and
write both divisor fields only after confirming DLAB. This prevents a
failed LCR update from redirecting divisor writes into TX and IER. Allow
the empty-FIFO timeout workaround once DMA has released the FIFO, including
while callbacks retire. Exclude FIFO resets during RX DMA recovery. If the
provider still cannot terminate the channel in process context, retain
its buffer and leave receive interrupts masked.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  39 ++++++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 156 +++++++++++++++++++++++++++---------
 drivers/tty/serial/8250/8250_dw.c   |  34 +++++---
 drivers/tty/serial/8250/8250_mid.c  |   6 +-
 drivers/tty/serial/8250/8250_port.c |  31 ++++---
 6 files changed, 207 insertions(+), 61 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 9f01fa36fa3c..35a71d4780a5 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -23,6 +23,7 @@ struct uart_8250_dma {
 	/* Completion processing with the port lock held. */
 	void (*tx_complete)(struct uart_8250_port *p);
 	struct work_struct tx_flush_work;
+	struct work_struct rx_flush_work;
 	struct uart_8250_port *port;
 
 	/* Filter function */
@@ -55,11 +56,14 @@ struct uart_8250_dma {
 
 	unsigned char		tx_running;
 	unsigned char		tx_err;
+	/* RX DMA may access the FIFO; independent of callback retirement. */
 	unsigned char		rx_running;
 	/* Protected by the UART port lock. */
 	bool			shutting_down:1;
 	bool			tx_terminating:1;
 	bool			tx_flushed:1;
+	bool			rx_terminating:1;
+	bool			rx_err:1;
 };
 
 struct old_serial_port {
@@ -148,6 +152,28 @@ static inline void serial_out(struct uart_8250_port *up, int offset, int value)
 	up->port.serial_out(&up->port, offset, value);
 }
 
+static inline bool serial8250_rx_dma_running(struct uart_8250_port *up)
+{
+	return up->dma && up->dma->rx_running;
+}
+
+static inline bool serial8250_rx_dma_recovering(struct uart_8250_port *up)
+{
+	return up->dma && up->dma->rx_err && up->dma->rx_terminating;
+}
+
+/* Keep the desired enables in up->ier while RX DMA recovery masks hardware. */
+static inline void serial8250_out_IER(struct uart_8250_port *up, u8 ier)
+{
+	lockdep_assert_held_once(&up->port.lock);
+
+	if (up->dma && up->dma->shutting_down)
+		ier = 0;
+	else if (serial8250_rx_dma_recovering(up))
+		ier &= ~(UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE);
+	serial_out(up, UART_IER, ier);
+}
+
 /**
  *	serial_lsr_in - Read LSR register and preserve flags across reads
  *	@up:	uart 8250 port
@@ -221,7 +247,7 @@ static inline bool serial8250_set_THRI(struct uart_8250_port *up)
 	if (up->ier & UART_IER_THRI)
 		return false;
 	up->ier |= UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 	return true;
 }
 
@@ -233,7 +259,7 @@ static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
 	if (!(up->ier & UART_IER_THRI))
 		return false;
 	up->ier &= ~UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 	return true;
 }
 
@@ -417,7 +443,7 @@ extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
 				   struct scatterlist *sgl, unsigned int nents);
 extern int serial8250_rx_dma(struct uart_8250_port *);
-extern void serial8250_rx_dma_flush(struct uart_8250_port *);
+int serial8250_rx_dma_flush(struct uart_8250_port *p);
 extern int serial8250_request_dma(struct uart_8250_port *);
 extern void serial8250_release_dma(struct uart_8250_port *);
 
@@ -473,7 +499,12 @@ static inline int serial8250_rx_dma(struct uart_8250_port *p)
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
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 42319843cb5b..ca06288038ed 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -738,7 +738,7 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 
 	guard(uart_port_lock_irqsave)(&up->port);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static int __serial8250_register_8250_port(struct uart_8250_port *uart,
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index fef33615c879..6bf5765befba 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -86,53 +86,96 @@ void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
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
 
+static void serial8250_rx_dma_recover(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	/* Keep PIO and new descriptors out until the worker stops the channel. */
+	dma->rx_err = true;
+	dma->rx_terminating = true;
+	serial8250_out_IER(p, p->ier);
+	schedule_work(&dma->rx_flush_work);
+}
+
 static void dma_rx_complete(void *param)
 {
 	struct uart_8250_port *p = param;
 	struct uart_8250_dma *dma = p->dma;
-	unsigned long flags;
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	if (dma->shutting_down || dma->rx_terminating)
+		return;
+	if (dma->rx_running) {
+		status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+		if (status == DMA_ERROR) {
+			serial8250_rx_dma_recover(p);
+			return;
+		}
+		if (status != DMA_COMPLETE)
+			return;
+		serial8250_rx_dma_copy(p, &state);
+		dma->rx_running = 0;
+	}
+
+	/* Preserve LSR read side effects when stop_rx() has disabled resubmission. */
+	if ((serial_lsr_in(p) & UART_LSR_DR) && (p->ier & UART_IER_RDI))
+		dma->rx_dma(p);
+}
+
+static void serial8250_rx_dma_flush_work(struct work_struct *work)
+{
+	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, rx_flush_work);
+	struct uart_8250_port *p = dma->port;
+	bool recover;
+	int ret;
+
+	/* All packed flags share the port lock, including this worker snapshot. */
+	scoped_guard(uart_port_lock_irqsave, &p->port)
+		recover = dma->rx_err;
+
+	if (recover) {
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
 
-	uart_port_lock_irqsave(&p->port, &flags);
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	dma->rx_terminating = false;
+	dma->rx_running = 0;
 	if (dma->shutting_down)
-		goto out;
-	if (dma->rx_running)
-		__dma_rx_complete(p);
+		return;
 
-	/*
-	 * Cannot be combined with the previous check because __dma_rx_complete()
-	 * changes dma->rx_running.
-	 */
-	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
-		p->dma->rx_dma(p);
-out:
-	uart_port_unlock_irqrestore(&p->port, flags);
+	if (!recover)
+		return;
+
+	/* Apply the current enables, including any intervening stop_rx(). */
+	serial8250_out_IER(p, p->ier);
+	dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
 }
 
 int serial8250_tx_dma(struct uart_8250_port *p)
@@ -242,6 +285,9 @@ int serial8250_rx_dma(struct uart_8250_port *p)
 
 	if (dma->shutting_down || dma->rx_running)
 		return 0;
+	/* A retiring transfer has released the FIFO, but not its buffer. */
+	if (dma->rx_err || dma->rx_terminating)
+		return -EIO;
 
 	serial8250_do_prepare_rx_dma(p);
 
@@ -262,16 +308,47 @@ int serial8250_rx_dma(struct uart_8250_port *p)
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
+	if (!dma || !dma->rx_running)
+		return 0;
+	/* A late interrupt must not hand a still-active receiver to PIO. */
+	if (dma->shutting_down)
+		return -ESHUTDOWN;
+	if (dma->rx_terminating)
+		return -EIO;
+
+	ret = dmaengine_pause(dma->rxchan);
+	status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	/* A completed transfer may reject pause before its callback gets the lock. */
+	if (ret && status != DMA_COMPLETE)
+		goto recover;
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
+	/* DMA released the FIFO; retain the buffer until callbacks retire. */
+	dma->rx_running = 0;
+	schedule_work(&dma->rx_flush_work);
+	return 0;
+
+recover:
+	serial8250_rx_dma_recover(p);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
 
@@ -368,10 +445,13 @@ int serial8250_request_dma(struct uart_8250_port *p)
 
 	dma->port = p;
 	INIT_WORK(&dma->tx_flush_work, serial8250_tx_dma_flush_work);
+	INIT_WORK(&dma->rx_flush_work, serial8250_rx_dma_flush_work);
 
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->tx_terminating = false;
 		dma->tx_flushed = false;
+		dma->rx_terminating = false;
+		dma->rx_err = false;
 		dma->shutting_down = false;
 	}
 	dev_dbg_ratelimited(p->port.dev, "got both dma channels\n");
@@ -395,10 +475,14 @@ void serial8250_release_dma(struct uart_8250_port *p)
 		return;
 
 	cancel_work_sync(&dma->tx_flush_work);
+	cancel_work_sync(&dma->rx_flush_work);
 
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
-	dma->rx_running = 0;
+	scoped_guard(uart_port_lock_irqsave, &p->port) {
+		dma->rx_running = 0;
+		dma->rx_terminating = false;
+	}
 	dma_free_coherent(dmaengine_get_dma_device(dma->rxchan), dma->rx_size,
 			  dma->rx_buf, dma->rx_addr);
 	dma_release_channel(dma->rxchan);
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d1..0cd0ab048a8a 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -112,7 +112,7 @@ static void dw8250_idle_exit(struct uart_port *p)
 	if (up->capabilities & UART_CAP_FIFO)
 		serial_port_out(p, UART_FCR, up->fcr);
 	serial_port_out(p, UART_MCR, up->mcr);
-	serial_port_out(p, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 
 	/* DMA Rx is restarted by IRQ handler as needed. */
 	if (up->dma)
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
+			serial8250_out_IER(up, up->ier);
+			d->in_idle = 0;
+			return ret;
+		}
 		if (serial8250_tx_dma_running(up))
 			serial8250_tx_dma_pause(up);
 	}
@@ -190,6 +196,7 @@ static int dw8250_idle_enter(struct uart_port *p)
 static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 			       unsigned int quot, unsigned int quot_frac)
 {
+	struct dw8250_port_data *pd = p->private_data;
 	struct uart_8250_port *up = up_to_u8250p(p);
 	int ret;
 
@@ -201,6 +208,8 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
 		goto idle_failed;
 
+	if (pd->dlf_size)
+		dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
 	serial_dl_write(up, quot);
 	serial_port_out(p, UART_LCR, up->lcr);
 
@@ -389,9 +398,9 @@ static void dw8250_quirk_ier_kick(struct uart_port *p)
 	if (!(lsr & UART_LSR_THRE))
 		return;
 
-	serial_port_out(p, UART_IER, up->ier | UART_IER_THRI);
+	serial8250_out_IER(up, up->ier | UART_IER_THRI);
 	serial_port_in(p, UART_LCR);		/* safe, no side-effects */
-	serial_port_out(p, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static int dw8250_handle_irq(struct uart_port *p)
@@ -428,6 +437,9 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	d->no_int_count = 0;
 
+	if (up->dma && up->dma->shutting_down)
+		return 1;
+
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
 	 * they are asserting UART_IIR_RX_TIMEOUT but there is no actual
@@ -435,10 +447,11 @@ static int dw8250_handle_irq(struct uart_port *p)
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
+	    !serial8250_rx_dma_running(up) && rx_timeout) {
 		status = serial_lsr_in(up);
 
 		/*
@@ -453,7 +466,8 @@ static int dw8250_handle_irq(struct uart_port *p)
 	}
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
-	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
+	if (quirks & DW_UART_QUIRK_IS_DMA_FC && rx_timeout &&
+	    serial8250_rx_dma_running(up) && !up->dma->rx_terminating) {
 		status = serial_lsr_in(up);
 
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
@@ -651,7 +665,6 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
-	p->set_divisor	= dw8250_set_divisor;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -768,6 +781,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
 
+	/* Use the BUSY-safe sequence for both integer and fractional divisors. */
+	p->set_divisor = dw8250_set_divisor;
+
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
 		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
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
index f36f7e18ab95..24964acc87f8 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1306,7 +1306,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 /**
@@ -1332,7 +1332,8 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 	 * Enable previously disabled RX interrupts.
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
-		serial8250_clear_and_reinit_fifos(p);
+		if (!serial8250_rx_dma_recovering(p))
+			serial8250_clear_and_reinit_fifos(p);
 
 		if (toggle_ier) {
 			/*
@@ -1346,7 +1347,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 			lockdep_assert_held_once(&p->port.lock);
 
 			p->ier |= UART_IER_RLSI | UART_IER_RDI;
-			serial_port_out(&p->port, UART_IER, p->ier);
+			serial8250_out_IER(p, p->ier);
 		}
 	}
 }
@@ -1600,7 +1601,7 @@ static void serial8250_disable_ms(struct uart_port *port)
 	mctrl_gpio_disable_ms_no_sync(up->gpios);
 
 	up->ier &= ~UART_IER_MSI;
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static void serial8250_enable_ms(struct uart_port *port)
@@ -1619,7 +1620,7 @@ static void serial8250_enable_ms(struct uart_port *port)
 	up->ier |= UART_IER_MSI;
 
 	guard(serial8250_rpm)(up);
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr)
@@ -1816,8 +1817,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 		fallthrough;
 	case UART_IIR_RLSI:
 	case UART_IIR_RX_TIMEOUT:
-		serial8250_rx_dma_flush(up);
-		return true;
+		return !serial8250_rx_dma_flush(up);
 	}
 	return up->dma->rx_dma(up);
 }
@@ -1837,15 +1837,22 @@ void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 
 	lockdep_assert_held_once(&port->lock);
 
+	if (up->dma && up->dma->shutting_down)
+		return;
+
 	status = serial_lsr_in(up);
 
 	/*
 	 * Recover from no-data-ready and FIFO error condition to avoid getting
 	 * stuck in the ISR.
 	 */
-	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
+	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE) &&
+	    !serial8250_rx_dma_running(up))
 		serial8250_clear_and_reinit_fifos(up);
 
+	if (serial8250_rx_dma_recovering(up))
+		skip_rx = true;
+
 	/*
 	 * If port is stopped and there are no error conditions in the
 	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer
@@ -2345,6 +2352,12 @@ int serial8250_do_startup(struct uart_port *port)
 
 	guard(serial8250_rpm)(up);
 
+	/* The previous shutdown has drained DMA and its callbacks. */
+	scoped_guard(uart_port_lock_irqsave, port) {
+		if (up->dma)
+			up->dma->shutting_down = false;
+	}
+
 	serial8250_startup_special(port);
 
 	/*
@@ -2786,7 +2799,7 @@ static void serial8250_set_ier(struct uart_port *port, struct ktermios *termios)
 	if (up->capabilities & UART_CAP_RTOIE)
 		up->ier |= UART_IER_RTOIE;
 
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static void serial8250_set_efr(struct uart_port *port, struct ktermios *termios)

-- 
2.53.0

