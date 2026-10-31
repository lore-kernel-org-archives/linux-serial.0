Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451167;
	b=Ey+u08v5bNHYZRm1B5wA4WBceKthFFxab80V51WARe3UZOIFRYC5Qag92tDloD1TsDj6
	 xg01q65nXx0r5yb1Ykw09N3LS35rSS9lMNQ6e5lsd9BwzVO9rplqvn1rGTBASbeZp2SSS
	 FSIW2MVq1ZJRmAbgGisCJRRV/qXbivcFxKisNjyDjJ30FN0iZ1KDcqDidjRDzEWY6LG81
	 icm4JS0+BocbS/dv9QMr91CTHDygIW5zemXgoWOi1EnHfFHTfEl1zk8qQYA2/DPBSVskx
	 jEluNUbeNVJTNcvGkYa8cEPk5jYG56Bjr94X7G2LbmDnZ1OeWf8mggSfMVlm2CNLNvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ef5Oa3VZ/itcQdeoCMh/rBhxuBUEhpvE45t5B+2SzD0=;
	b=fMLtJDAWaAChd9vlvXZstewL4GGo4dE1IuHVrGqd8xkJn1AzulG4U7BQvJkSA/Q/RSrp
	 h5yNGjKMJqk74AgEdTkoS4BkQdtpkUa/skyvr2x36zXp1tzbw/EIQ5CiQNxU9zUtMqZCm
	 1scA4aX2adzQH11kUmh6SgreNjAR8nz6A/VUSD4lp7tpVL1aO+rS5O9kCNpSRU5uEKsNc
	 wZmUN8LDkEUu7dnLGE47vH5z+G3viuW/FyzESNuuVfqGH0lbCG6vhFJT3f5x0fnaLO3sV
	 U7ODoQEhEZ4huxHj7HYXu2KsnOkpOveQQt4vRfj+0SdVD4sMXDO8cFs/CXr0GWz1yfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIXbW4XL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0AB606A31A;
	Sat, 31 Oct 2026 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIXbW4XL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382A61F000C1;
	Sat, 31 Oct 2026 12:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793451166;
	bh=Ef5Oa3VZ/itcQdeoCMh/rBhxuBUEhpvE45t5B+2SzD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OIXbW4XLLzu0zUQW/vFxRZwQoGsJWtUPLu4aFA5oyuCxVql6GgkuosMuY6Ezwnixt
	 xgANnhICOpl6vx+BMT0gXu1JXnt1G13cLfd34k1GepK3LBAsIutSaIr/rpZYVfPNLs
	 3iUoP4zLq2nk2eZKWfzOKk7n7qX8v/N5kMpTlNmgXywbWDmmFEkDrW0dYrtjxw0bRP
	 IqdKCkd+UiQYsTmPeuwhM0grHYEiMQXdCcjLPbR6d2SegeNCR2G03IxamktETKjJOK
	 jg3fShw24MQNWZgz+boKJUo6QNB4/LX2gxfrqv2BaYSEbuRlvASO21wpCndTIIslpZ
	 l2nvtF8SPFJBg==
Message-ID: <sashiko-outbox-191946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: amba-pl011: keep the flushed TX buffer
 mapped until DMA stops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samarth Narang" <samarth.colleges@gmail.com>
Cc: linux-serial@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261031123749.3783352-2-samarth.colleges@gmail.com>
References: <20261031005425.3351240-1-samarth.colleges@gmail.com>
 <20261031123749.3783352-1-samarth.colleges@gmail.com>
 <20261031123749.3783352-2-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 12:52:45 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] serial: amba-pl011: race and TX restart in pl011_dma_shutdown()
- [High] serial: amba-pl011: TX DMA re-enabled while dmatx.flushing is true
- [Medium] serial: amba-pl011: pl011_dma_tx_flush_work() bypasses pl011_sta=
rt_tx()
--

commit fb5633a8b4f6925fce77e6c969ed222b6e66d5c1
Author: Samarth Narang <samarth.colleges@gmail.com>

serial: amba-pl011: keep the flushed TX buffer mapped until DMA stops

This commit defers unmapping a flushed TX DMA buffer from
pl011_dma_flush_buffer() to a work item that calls dmaengine_synchronize()
before releasing the mapping and restarting transmission. It keeps
dmatx.queued set while dmatx.flushing is active and flushes the work item in
pl011_dma_shutdown().

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index e6f652905ca6f..863a050cf654e 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c

[ ... ]

> @@ -867,13 +876,47 @@ __acquires(&uap->port.lock)
> =20
>  	dmaengine_terminate_async(uap->dmatx.chan);
> =20
> -	if (uap->dmatx.queued) {
> -		dma_unmap_single(dmaengine_get_dma_device(uap->dmatx.chan), uap->dmatx=
.dma,
> -				 uap->dmatx.len, DMA_TO_DEVICE);
> +	/*
> +	 * The terminated transfer may still be reading dmatx.buf: keep it
> +	 * mapped, and queued set so that nothing refills it, until
> +	 * pl011_dma_tx_flush_work() has synchronized the channel.
> +	 */
> +	if (uap->dmatx.queued && !uap->dmatx.flushing) {
> +		uap->dmatx.flushing =3D true;
> +		uap->dmacr &=3D ~UART011_TXDMAE;
> +		pl011_write(uap->dmacr, uap, REG_DMACR);
> +		schedule_work(&uap->dmatx.flush_work);
> +	}
> +}

[Severity: High]
Can UART011_TXDMAE be re-enabled in REG_DMACR while uap->dmatx.flushing is
still true and before pl011_dma_tx_flush_work() finishes
dmaengine_synchronize()?

When uart_flush_buffer() calls pl011_dma_flush_buffer(), uap->dmatx.queued =
is
kept true while UART011_TXDMAE is cleared. Immediately after
pl011_dma_flush_buffer() returns, uart_flush_buffer() drops uap->port.lock =
and
calls tty_port_tty_wakeup(). If a subsequent write or wakeup calls
pl011_start_tx() -> pl011_dma_tx_start() before pl011_dma_tx_flush_work()
runs, pl011_dma_tx_start() sees uap->dmatx.queued set and UART011_TXDMAE cl=
ear:

drivers/tty/serial/amba-pl011.c:pl011_dma_tx_start() {
	...
		if (!uap->dmatx.queued) {
			...
		} else if (!(uap->dmacr & UART011_TXDMAE)) {
			uap->dmacr |=3D UART011_TXDMAE;
			pl011_write(uap->dmacr, uap, REG_DMACR);
		}
		return ret;
}

Similarly, if a TX interrupt fires (for example after sending an x_char) and
calls pl011_dma_tx_irq(), it also checks uap->dmatx.queued without checking
uap->dmatx.flushing:

drivers/tty/serial/amba-pl011.c:pl011_dma_tx_irq() {
	...
	if (uap->dmatx.queued) {
		uap->dmacr |=3D UART011_TXDMAE;
		pl011_write(uap->dmacr, uap, REG_DMACR);
		uap->im &=3D ~UART011_TXIM;
		pl011_write(uap->im, uap, REG_IMSC);
		return true;
	}
}

In both cases, re-enabling UART011_TXDMAE causes the UART to assert TX DMA
requests to the DMA controller for the terminated transfer and pull stale
flushed bytes from dmatx.buf into the TX FIFO, and a second call to
pl011_dma_flush_buffer() while uap->dmatx.flushing is already set will not
clear UART011_TXDMAE again. Should pl011_dma_tx_start() and
pl011_dma_tx_irq() check uap->dmatx.flushing before setting UART011_TXDMAE?

> +
> +/*
> + * flush_buffer runs under the port lock and can only request terminatio=
n.
> + * Unmap the flushed TX buffer here, once the terminated transfer and its
> + * completion callback are known to have finished, then restart TX.
> + */
> +static void pl011_dma_tx_flush_work(struct work_struct *work)
> +{
> +	struct uart_amba_port *uap =3D
> +	    container_of(work, struct uart_amba_port, dmatx.flush_work);
> +	struct tty_port *tport =3D &uap->port.state->port;
> +	unsigned long flags;
> +
> +	dmaengine_synchronize(uap->dmatx.chan);
> +
> +	uart_port_lock_irqsave(&uap->port, &flags);
> +	if (uap->dmatx.flushing) {
> +		dma_unmap_single(dmaengine_get_dma_device(uap->dmatx.chan),
> +				 uap->dmatx.dma, uap->dmatx.len, DMA_TO_DEVICE);
> +		uap->dmatx.flushing =3D false;
>  		uap->dmatx.queued =3D false;
>  		uap->dmacr &=3D ~UART011_TXDMAE;
>  		pl011_write(uap->dmacr, uap, REG_DMACR);
> +		if (!uart_tx_stopped(&uap->port) &&
> +		    !kfifo_is_empty(&tport->xmit_fifo) &&
> +		    pl011_dma_tx_refill(uap) <=3D 0)
> +			pl011_start_tx_pio(uap);
>  	}
> +	uart_port_unlock_irqrestore(&uap->port, flags);
>  }

[Severity: Medium]
Does calling pl011_dma_tx_refill() and pl011_start_tx_pio() directly in
pl011_dma_tx_flush_work() bypass the RS485 state machine and UART011_TXIM
masking normally handled by pl011_start_tx()?

In pl011_start_tx(), when SER_RS485_ENABLED is set and uap->rs485_tx_state =
is
not SEND, the driver calls pl011_rs485_tx_start() and waits for
WAIT_AFTER_RTS before starting DMA or PIO:

drivers/tty/serial/amba-pl011.c:pl011_start_tx() {
	if ((uap->port.rs485.flags & SER_RS485_ENABLED) &&
	    uap->rs485_tx_state !=3D SEND) {
		/* trigger_start_tx starts TX once delay_rts_before_send passed */
		if (uap->rs485_tx_state =3D=3D WAIT_AFTER_RTS)
			return;

		pl011_rs485_tx_start(uap);
		if (uap->rs485_tx_state =3D=3D WAIT_AFTER_RTS)
			return;
	}

	if (!pl011_dma_tx_start(uap))
		pl011_start_tx_pio(uap);
}

In addition, when pl011_dma_tx_refill() > 0 succeeds in pl011_dma_tx_start(=
),
it clears UART011_TXIM in uap->im and writes REG_IMSC, which is skipped when
pl011_dma_tx_flush_work() calls pl011_dma_tx_refill() directly. Should
pl011_dma_tx_flush_work() call pl011_start_tx(&uap->port) instead?

[ ... ]

> @@ -1236,6 +1281,9 @@ static void pl011_dma_shutdown(struct uart_amba_por=
t *uap)
>  	if (!(uap->using_tx_dma || uap->using_rx_dma))
>  		return;
> =20
> +	if (uap->using_tx_dma)
> +		flush_work(&uap->dmatx.flush_work);
> +
>  	/* Disable RX and TX DMA */
>  	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
>  		cpu_relax();

[Severity: Critical]
Can flushing dmatx.flush_work at the start of pl011_dma_shutdown() allow TX
to restart during shutdown or race with a concurrent uart_flush_buffer()?

First, pl011_shutdown() calls pl011_disable_interrupts(uap) before calling
pl011_dma_shutdown(uap). When flush_work(&uap->dmatx.flush_work) runs at the
start of pl011_dma_shutdown() while tport->xmit_fifo is non-empty and
!uart_tx_stopped(&uap->port) (such as during uart_suspend_port()),
pl011_dma_tx_flush_work() will either start a new DMA transfer via
pl011_dma_tx_refill() and advance xmit_fifo right before
dmaengine_terminate_sync() discards it, or call pl011_start_tx_pio() and
re-enable UART011_TXIM in REG_IMSC after pl011_disable_interrupts() masked
all interrupts.

Second, after flush_work(&uap->dmatx.flush_work) returns,
pl011_dma_shutdown() spins on REG_FR and calls dmaengine_terminate_sync()
without holding uap->port.lock while uap->using_tx_dma and uap->dmatx.queued
are still true:

drivers/tty/serial/amba-pl011.c:pl011_dma_shutdown() {
	...
	if (uap->using_tx_dma) {
		/* In theory, this should already be done by pl011_dma_flush_buffer */
		dmaengine_terminate_sync(uap->dmatx.chan);
		if (uap->dmatx.queued) {
			dma_unmap_single(dmaengine_get_dma_device(uap->dmatx.chan),
					 uap->dmatx.dma, uap->dmatx.len,
					 DMA_TO_DEVICE);
			uap->dmatx.queued =3D false;
		}

		kfree(uap->dmatx.buf);
		uap->using_tx_dma =3D false;
	}
}

Because uart_flush_buffer() only takes uap->port.lock, a concurrent
uart_flush_buffer() -> pl011_dma_flush_buffer() after flush_work() returns
can see uap->using_tx_dma and uap->dmatx.queued still set, mark
uap->dmatx.flushing =3D true, and schedule uap->dmatx.flush_work again. Once
pl011_dma_shutdown() unmaps uap->dmatx.dma, frees uap->dmatx.buf, and
pl011_shutdown() disables the UART clock, the newly scheduled
pl011_dma_tx_flush_work() can unmap uap->dmatx.dma a second time, write
REG_DMACR with the clock disabled, and access the freed uap->dmatx.buf.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031123749.3783=
352-1-samarth.colleges@gmail.com?part=3D1
