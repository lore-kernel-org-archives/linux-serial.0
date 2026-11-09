Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198154;
	b=AULGRE4Qe7RvzJVVRoxpsm2cl5BbA9/AinrWT11ybDXse2yspJ5Y/R0+lO1geIZSCq2L
	 10jvIHCnJ2G4MB4IToT+p660dfanQLQj7+vnsWU47Gm1uVs0krR4ccTxpOizTYLAbSHt4
	 mgF8W4xGMTVUqIqnxKzGI1LYrqhAWP787yazeHi7FhXvlExs9Tw+of9ysIoz/ALtxfP8y
	 wL5oNRoFxdCgERZhJhQbpN6PzdXUy9MNZrzgXqu6+Vq+Ukz56JwpV47G+YH705oi728YM
	 7k4LqTf+vVVhSzCdVC1fYW39q1L5TBEWwnmEBYlwgHCoPHS+aZYw3CHy56PqTWtxMWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198154;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s3A1JJTBzb6Sq/eGcNwFYBzXadSGZeqXhTCf8IODYaA=;
	b=K+BUk5pxqonToACHc45iEDcWZ3Zek+N9duGKSd4WbnDMa4RlOnx/YAiDUq/kSH04bbTN
	 7PjWhE0uCb5qT6fV8ITWfpTVu5hLZyzHqrvB8JHSlvYolzoqNIIHzDQ/+5wOJ+acfA2n0
	 wINJ7lJ+rnqJcBMmJfKvyzfiT3MChhcPWNsNUpuSwKfJyAxlzO6WlXPO9UuyvkRaOB7Dc
	 01vo6cRMhJXQD9mW8eGpMRKR7VcXrKkaAIL0p4To+2WKfb0zgcTHAXoijxDe9kT1ABgVy
	 I+u1kWQom/AwbHIRj86ZLhVYKxE1OmfxuQ7SjFE+ugWr814/sm3UBM/VUpD9NLOhL8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mivVR/Hk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC5606A31C;
	Mon,  9 Nov 2026 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mivVR/Hk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E031F0089F;
	Mon,  9 Nov 2026 04:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198153;
	bh=s3A1JJTBzb6Sq/eGcNwFYBzXadSGZeqXhTCf8IODYaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mivVR/HkR7ovdacg/P8CM70YeCmM1pBhio0vgOCG/252yc9Asd8SBGfYAg7/BOS3b
	 0dVSQIb8BwOyFkW9GWhQwnvFX2AvpVZfR0Es/65HOL6+fBCoh0RluIhOYf569CQT8j
	 uGGKj0FQ6xtTHNH1hCLFyfWzgZRmG78mSJF3tB4aizcqGjSYif26D9z0tXhuPM3iIR
	 3/2RVKB4rHTdgwqQ7QjKkvGoTmn7vYpztE/ju5G7jJVAqFtDQr9IB6NQr0Us4wHY2b
	 u+YUEuD4yQb87umw9dDvg15uiF2HA3dJM9h3luAXLdWhv6+rBeDLDtXKeybWdsn7u8
	 5W1v7ND3GCjqg==
Message-ID: <sashiko-outbox-204402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-7-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
 <20261108-submit-serial-8250-dma-cancel-v1-v10-7-e6227ddb95b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:22:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] serial: 8250: unbounded pause retry loop in
  serial8250_rx_dma_flush_work()
--

commit 818afe206e7bf388666735a110a648d91146a4e7
Author: James Hilliard <james.hilliard1@gmail.com>

serial: 8250: retire canceled RX DMA before reusing the receive buffer

This commit defers reuse of a canceled RX DMA buffer until a worker has
drained pending DMA callbacks, and retries failed pause attempts from
process context before copying or recovering the channel.

> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250=
/8250_dma.c
> index 739a8238e4dec..1ea22954150ca 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
[ ... ]
> +/* Try to obtain a stable residue before retiring the current descriptor=
. */
> +static int serial8250_rx_dma_try_flush(struct uart_8250_port *p)
> +{
> +	struct uart_8250_dma *dma =3D p->dma;
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +	int ret;
> +
> +	lockdep_assert_held_once(&p->port.lock);
> +
> +	ret =3D dmaengine_pause(dma->rxchan);
> +	status =3D dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> +	if (status =3D=3D DMA_ERROR) {
> +		ret =3D -EIO;
> +		goto recover;
> +	}
> +	if (ret && status !=3D DMA_COMPLETE) {
> +		/*
> +		 * Hardware may be idle before the provider publishes completion.
> +		 * Leave the descriptor alive and retry outside interrupt context;
> +		 * neither copying its buffer nor canceling it is safe yet.
> +		 */
> +		dma->rx_pause_pending =3D true;
> +		serial8250_out_IER(p, p->ier);
> +		return ret;
> +	}
[ ... ]
> +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> +{
> +	struct uart_8250_dma *dma =3D container_of(work, struct uart_8250_dma, =
rx_flush_work);
> +	struct uart_8250_port *p =3D dma->port;
> +	unsigned int delay_us =3D 1 * USEC_PER_MSEC;
> +	ktime_t start =3D ktime_get();
> +	bool recover, retry, restore_rx;
> +	bool warned =3D false;
> +	int ret;
> +
> +	guard(serial8250_rpm)(p);
> +
> +	for (;;) {
> +		scoped_guard(uart_port_lock_irqsave, &p->port) {
> +			/* Shutdown cancels this work and drains both DMA channels. */
> +			if (dma->shutting_down)
> +				return;
> +			/* Serialize reset with completion and shutdown notifications. */
> +			WRITE_ONCE(dma->rx_pause_wakeup, false);
> +			retry =3D dma->rx_pause_pending && !dma->rx_terminating;
> +			if (retry) {
> +				ret =3D serial8250_rx_dma_try_flush(p);
> +				retry =3D dma->rx_pause_pending && !dma->rx_terminating;
> +			}
> +			recover =3D dma->rx_err;
> +		}
> +		if (!retry)
> +			break;
> +		if (!warned && ktime_ms_delta(ktime_get(), start) >=3D 1 * MSEC_PER_SE=
C) {
> +			dev_warn(p->port.dev,
> +				 "RX DMA pause stalled: %d; retaining transfer and retrying\n",
> +				 ret);
> +			warned =3D true;
> +		}
> +		/* Notifications also cover completion or shutdown before sleeping. */
> +		wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dma->rx_pause_wakeu=
p),
> +				     ns_to_ktime(delay_us * NSEC_PER_USEC));
> +		delay_us =3D min(delay_us * 2, 1 * USEC_PER_SEC);
> +	}

[Severity: High]
As reported by Raul E Rangel on v8 [1], can serial8250_rx_dma_flush_work()
spin in its retry loop until the port is closed when dmaengine_pause() fails
persistently on a partial transfer?

Once p->port.lock and local IRQs have been released across a few sleeps, any
pending completion hardirq for a finished transfer has already run. On a
partial transfer that has not reached dma->rx_size, an in-tree provider such
as dw-axi-dmac can time out waiting for DWAXIDMAC_IRQ_SUSPENDED in
dma_chan_pause(), clear that status bit while leaving the hardware channel
suspended, and return -EAGAIN on every subsequent retry:

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:dma_chan_pause() {
	...
	do {
		if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED)
			break;

		udelay(2);
	} while (--timeout);

	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);

	chan->is_paused =3D true;

	return timeout ? 0 : -EAGAIN;
}

Because the channel is suspended in hardware, it never receives more bytes =
to
reach DMA_COMPLETE, and every retry in serial8250_rx_dma_try_flush() keeps
dma->rx_pause_pending set. That wedges RX on the port (with UART_IER_RDI,
UART_IER_RLSI, and UART_IER_RTOIE masked and skip_rx forced in
serial8250_handle_irq_locked()), holds the runtime PM reference in
serial8250_rx_dma_flush_work(), and causes dw8250_idle_enter() to fail with
-EAGAIN until shutdown(), which then discards dma->rx_buf without delivering
the partial data anyway.

Escalating to serial8250_rx_dma_recover(p) after a bounded retry budget (or
immediately on -ENOSYS / -EOPNOTSUPP) would let dmaengine_terminate_sync()
stop the channel and fall back to PIO.

[1] https://lore.kernel.org/r/20261029222734.3086943-1-rrangel@chromium.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-submit-ser=
ial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com?part=3D7
