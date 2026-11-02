Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663362;
	b=eYfQyHFwIbff4eN7eUP92sFU4Do8NFrlZclf50bFDQRCi3ou67ZMTTQLdi6ZhkvrRkmo
	 6bGesEdOz3dBNsZ2pbTRy4zvU+7ZdyUmmjBD/A1v2jPsCHHTPiNITBfJoX620mxgtscfL
	 oLtXaz2W+D5Snd1kRq45DwPmtZ9vf82jPeX1VKFpxe2oowxRF82ATQo0Txd9XxpioKWsz
	 B+TaahyTd0MeOOqJWQ0I6UPd6bTX/GEgYt1g3kY2wNjWDsiPEyFShycDwVbjJCUj7Zmjb
	 jyWgHKfQvOdKLqPYWd0KumBIOEe3kfieh1hFLNrIhrSERz3mzO71zZ6eBTxv7GsW6vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+AHA3sYXM9FIcGIEmGW6I4KR8agLQV0FGqAG5hk7wig=;
	b=wF161hJd9oPNjU3mzKjNBw3HpsXyOZaKv5BxloaIgccgp743b/kNB2zB7RABmbrlpO6S
	 /IoJt5s8+xQoLBbHh2XC5lY7RoLo+sOOLtAnuYOS2hPgcIG/PljOJLp7oww4ZEjc2kknY
	 1tGGF2OEh5GRpEkPMQKnSNUVMnzJFF8vMSko6N7/ydLejS/eO7M5VZGG9lya5IaCMrRYX
	 +4iLVQDURc64ixOLfMvoymRMXo3L1AUdr5UfBB1fJ/yAvrVtX9R1iQLT13lDQFgRCgvQL
	 cDjFZlsa4xxU9kaOZFfLWVAzX+da80150X1wTdSz8DuHLOCD5OaqLSl3AyJQxnbVfLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4olQB2k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB0606A326;
	Mon,  2 Nov 2026 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4olQB2k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ED51F00A16;
	Mon,  2 Nov 2026 23:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663361;
	bh=+AHA3sYXM9FIcGIEmGW6I4KR8agLQV0FGqAG5hk7wig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A4olQB2k3oW44VsbXTcgvOYRofRIbECGjIoT8U84ZplKFIHTh246hxLEyR8yDRVEQ
	 LeMICqnj4WTic59Lf5DK4GRNo7PmGqdzNYns3kEBe+WRnp+GMIv6ndo5hf9uG9PNR0
	 3yTt/6uwzA/epFTzD7KP9pKrcyvZRjhk8gMzTmrehvLry5xvS0fNGBzsKF7cQCThPu
	 xXJxjGOCRplqds4Dl72Gxn7lNqc2wL8qx5mC8z+HowOchzEX72cvm7Pw+lfHKF6q49
	 RL3ZrNGyvnV90vDvGKZa+A0mQX4fb+cDfPyR+dax4KmIoaWJO1wvToaOZJVNjaEtW0
	 VjvqHN2FIVxxA==
Message-ID: <sashiko-outbox-194343@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:49:21 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: 8250: unbounded pause retry loop in serial8250_rx_dma_flus=
h_work()
--

commit 7216db0ad0fa3a64d9a52f2eff54fb53c9c43c75
Author: James Hilliard <james.hilliard1@gmail.com>

serial: 8250: retire canceled RX DMA before reusing the receive buffer

This commit reserves the RX DMA receive buffer until a worker has drained
canceled callbacks and adds retry and recovery logic for RX DMA pause and
termination failures.

> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250=
/8250_dma.c
> index 344f0dd24b416..fd2a0ed211657 100644
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
> +	unsigned int delay_us =3D USEC_PER_MSEC;
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
> +		if (!warned && ktime_ms_delta(ktime_get(), start) >=3D MSEC_PER_SEC) {
> +			dev_warn_ratelimited(p->port.dev,
> +					     "RX DMA pause stalled: %d; retaining transfer and retrying\n",
> +					     ret);
> +			warned =3D true;
> +		}
> +		/* Notifications also cover completion or shutdown before sleeping. */
> +		wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dma->rx_pause_wakeu=
p),
> +				     ns_to_ktime(delay_us * NSEC_PER_USEC));
> +		delay_us =3D min(delay_us * 2, USEC_PER_SEC);
> +	}

[Severity: High]
As reported by Raul E Rangel on v8 [1], when dmaengine_pause(dma->rxchan)
persistently returns an error during a partial RX DMA transfer (where fewer
than dma->rx_size bytes have arrived and dmaengine_tx_status() remains
DMA_IN_PROGRESS), serial8250_rx_dma_try_flush() sets dma->rx_pause_pending =
=3D
true and masks RX interrupts via serial8250_out_IER().

In serial8250_rx_dma_flush_work(), this causes the for (;;) loop to retry
serial8250_rx_dma_try_flush() indefinitely until port shutdown instead of
escalating to serial8250_rx_dma_recover() after a bounded retry budget.

While a brief retry outside p->port.lock allows an already-completed transf=
er
whose DMA interrupt was masked by p->port.lock to publish DMA_COMPLETE, once
p->port.lock and local IRQs have been released across a few sleeps, any
pending completion interrupt has already run. If dmaengine_pause() continues
to fail while the remote peer is idle (for example, if dw-axi-dmac times out
waiting for DWAXIDMAC_IRQ_SUSPENDED and leaves the channel hardware-suspend=
ed
while returning -EAGAIN, or if tegra186-gpc-dma returns -ENOSYS when
!hw_support_pause), dmaengine_tx_status() will never reach DMA_COMPLETE.

While dma->rx_pause_pending remains stuck:
- UART reception is permanently wedged until the port is closed because RX
  interrupts stay masked in UART_IER and serial8250_rx_dma_recovering()
  forces skip_rx =3D true in serial8250_handle_irq_locked(), preventing PIO
  fallback.
- serial8250_rx_dma_flush_work() holds a runtime PM reference via
  guard(serial8250_rpm)(p) for the lifetime of the open port.
- serial8250_rx_dma_flush() returns -EAGAIN, which causes dw8250_idle_enter=
()
  in drivers/tty/serial/8250/8250_dw.c to abort divisor and LCR updates:

drivers/tty/serial/8250/8250_dw.c:dw8250_idle_enter() {
	...
	if (up->dma) {
		ret =3D serial8250_rx_dma_flush(up);
		if (ret) {
			serial8250_out_IER(up, up->ier);
			d->in_idle =3D 0;
			return ret;
		}
	...
}

Since the recover path right after the loop in serial8250_rx_dma_flush_work=
()
already calls dmaengine_terminate_sync(dma->rxchan) and retains the buffer
with RX masked if synchronous termination fails, can this loop bound the
number of pause retries and escalate to serial8250_rx_dma_recover(p) so the
port can terminate the transfer and fall back to PIO?

[1] https://lore.kernel.org/r/20261029222734.3086943-1-rrangel@chromium.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-ser=
ial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com?part=3D7
