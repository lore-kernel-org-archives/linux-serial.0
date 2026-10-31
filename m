Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451192;
	b=ozT3MjBTyZRMlWgep17NE3nxi5/LfJKFOm3TgcJqiXgMOdVDBLgXQutFO2em0HlHpY9A
	 fxDcvTlaMm5r2v6t1Olh2obIPfrQiIv+Mx1ILjzWPTaCsubYilkKeNxeyMo1Rfg+bQOuM
	 YFr91h66lOv1kPmFyr9l+LnwYERtcQIJ2JM6yDWNqxgVtLAgKZQxB/ohfWxqLTS41KUgl
	 m7EVsw+I/wuVPYuB/LxL3BjM10Sg9dHPscgz8bABk5/ObZjSfGKFBUq9SOMom+ZQxqWwC
	 ksDqHn1nEi1XCMyUrYph7TRIdu0Y/FkukidLiE6nVsN/reUS4H30lJmZZ6+dYWfSccw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451192;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OcT1grN6MPPjT2fY0UWaly2GxOEld4jmpqMhv5j5CUI=;
	b=kMcbOsOcUYVkyYWQC55KfXl17jYNSOzhpbQH6G1k2TGPa2kVdPLrglWS4FfwFF/r3Xv7
	 hl0kMV+wfdmOvbpdgE8VunyLOzdS93XGnKxhnFZb3EHJGkiL5NPNxXmfZkSrSJ57k+G+H
	 du3DzNL3slc2+APMysd6JLPfHWZt9xkj4oWEizTLUVDZUdsGctg0k1Qf1DRUMOw8kDzQW
	 tMHMPjnx1r87xPXg5nExKUXfwyMInqe1y94KE02InG6+pKfxYanxfhtOHnD3rtytsG4u8
	 6EiPEjW80UDVs6aIborXPNPz59ZGCt/cYeOYUCC75JrZwdDdpCux3nvYnEB3cPKrKlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hw1mtu4K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87399606A31A;
	Sat, 31 Oct 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hw1mtu4K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE791F000C1;
	Sat, 31 Oct 2026 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793451192;
	bh=OcT1grN6MPPjT2fY0UWaly2GxOEld4jmpqMhv5j5CUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hw1mtu4KmPRASiY16N8m1jbHsvSyCUS7FsTD/dekKxHowcb4ESdLENB1QRORpCcUu
	 eyg0/AYzhsZMFyCrriRqleH6kj1yTn6TfT0lzRYvWgm+95ZrdZikPeH1HndkHVMiMA
	 TuQkEgFs9xIqohbxGPfjOQkT7Jcf5bvVal25MR5ICuLY5YorEakKPuWluzlEymK9yW
	 W1uq9bPvi8wO1vUayA0/xrf4wQJpkKL1e+ENkLZqsy7m327VyA3Cr4+sNZooqppFgW
	 n1jz1VcBAyR3is9bnIesWfBIG0UFDRtzwBymKMI9KiMLvIzemJW0V34okm+tH/T3kT
	 ZBdPdGeXT49UQ==
Message-ID: <sashiko-outbox-191947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: don't unmap TX buffer
 before DMA has stopped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samarth Narang" <samarth.colleges@gmail.com>
Cc: linux-serial@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261031123749.3783352-3-samarth.colleges@gmail.com>
References: <20261031005425.3351240-1-samarth.colleges@gmail.com>
 <20261031123749.3783352-1-samarth.colleges@gmail.com>
 <20261031123749.3783352-3-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 12:53:11 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] tty: serial: fsl_lpuart: race scheduling dma_tx_flush_work aft=
er flush_work()
- [High] tty: serial: fsl_lpuart: lpuart_dma_tx_flush_work() restarts DMA o=
n teardown
--

commit 45f7dcf3d930bb1e96c498ca260fc93b635e30f0
Author: Samarth Narang <samarth.colleges@gmail.com>

tty: serial: fsl_lpuart: don't unmap TX buffer before DMA has stopped

This commit defers TX DMA scatterlist unmapping from lpuart_flush_buffer() =
to
a work item that runs dmaengine_synchronize() before releasing the mapping,
and flushes that work item in lpuart_dma_shutdown() and lpuart_suspend().

> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c
> index c8575c9652035..8343351199eb5 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c

[ ... ]

> @@ -558,6 +561,36 @@ static void lpuart_dma_tx_complete(void *arg)
>  	uart_port_unlock_irqrestore(&sport->port, flags);
>  }
> =20
> +/*
> + * flush_buffer runs under the port lock and can only request terminatio=
n.
> + * Unmap the TX scatterlist here, once the terminated transfer and its
> + * completion callback are known to have finished.
> + */
> +static void lpuart_dma_tx_flush_work(struct work_struct *work)
> +{
> +	struct lpuart_port *sport =3D container_of(work, struct lpuart_port,
> +						 dma_tx_flush_work);
> +	struct dma_chan *chan =3D sport->dma_tx_chan;
> +	unsigned long flags;
> +
> +	dmaengine_synchronize(chan);
> +
> +	uart_port_lock_irqsave(&sport->port, &flags);
> +	if (sport->dma_tx_flushing) {
> +		dma_unmap_sg(dmaengine_get_dma_device(chan), &sport->tx_sgl[0],
> +			     sport->dma_tx_nents, DMA_TO_DEVICE);
> +		sport->dma_tx_flushing =3D false;
> +		sport->dma_tx_in_progress =3D false;
> +	}
> +	/* As in the TX callback: no restart while shutdown waits on dma_wait */
> +	if (!waitqueue_active(&sport->dma_wait) &&
> +	    !lpuart_stopped_or_empty(&sport->port))
> +		lpuart_dma_tx(sport);

[Severity: High]
Can lpuart_dma_tx_flush_work() still restart TX DMA and leak the scatterlist
mapping on sport->tx_sgl during shutdown or suspend?

In lpuart_dma_shutdown(), flush_work(&sport->dma_tx_flush_work) is called
before wait_event_interruptible_timeout() adds a waiter to sport->dma_wait:

	if (sport->lpuart_dma_tx_use) {
		flush_work(&sport->dma_tx_flush_work);
		if (wait_event_interruptible_timeout(sport->dma_wait,
			!sport->dma_tx_in_progress, msecs_to_jiffies(300)) <=3D 0) {
			sport->dma_tx_in_progress =3D false;
			dmaengine_terminate_sync(sport->dma_tx_chan);
		}
		sport->lpuart_dma_tx_use =3D false;
	}

In lpuart_suspend(), flush_work(&sport->dma_tx_flush_work) is also called
with no waiter on sport->dma_wait:

		if (sport->lpuart_dma_tx_use) {
			...
			uart_port_unlock_irqrestore(&sport->port, flags);
			flush_work(&sport->dma_tx_flush_work);
			sport->dma_tx_in_progress =3D false;
			dmaengine_terminate_sync(sport->dma_tx_chan);
		}

Because waitqueue_active(&sport->dma_wait) is false while flush_work() runs
in both paths, if xmit_fifo is non-empty (for example, if bytes were queued
after uart_flush_buffer() called tty_port_tty_wakeup() while
dma_tx_in_progress was held true by a pending flush, or when suspending an
active wakeup-enabled port where uart_suspend_port() returns early),
lpuart_dma_tx_flush_work() will call lpuart_dma_tx(sport) and map
sport->tx_sgl after the UART transmitter and TX DMA request bits have alrea=
dy
been disabled in hardware.

Since hardware TX DMA is already disabled, that newly submitted transfer
cannot complete: lpuart_dma_shutdown() will wait for the 300ms timeout (or
return immediately on a pending signal) and then call
dmaengine_terminate_sync(sport->dma_tx_chan) without unmapping sport->tx_sgl
before uart_shutdown() frees xmit_buf, and lpuart_suspend() will likewise
clear sport->dma_tx_in_progress and call dmaengine_terminate_sync() without
unmapping sport->tx_sgl.

> +	uart_port_unlock_irqrestore(&sport->port, flags);
> +
> +	wake_up(&sport->dma_wait);
> +}

[ ... ]

> @@ -1760,6 +1797,8 @@ static void lpuart_tx_dma_startup(struct lpuart_por=
t *sport)
>  		goto err;
> =20
>  	init_waitqueue_head(&sport->dma_wait);
> +	INIT_WORK(&sport->dma_tx_flush_work, lpuart_dma_tx_flush_work);
> +	sport->dma_tx_flushing =3D false;
>  	sport->lpuart_dma_tx_use =3D true;
>  	if (lpuart_is_32(sport)) {
>  		uartbaud =3D lpuart32_read(&sport->port, UARTBAUD);
> @@ -1926,6 +1965,7 @@ static void lpuart_dma_shutdown(struct lpuart_port =
*sport)
>  	}
> =20
>  	if (sport->lpuart_dma_tx_use) {
> +		flush_work(&sport->dma_tx_flush_work);
>  		if (wait_event_interruptible_timeout(sport->dma_wait,
>  			!sport->dma_tx_in_progress, msecs_to_jiffies(300)) <=3D 0) {
>  			sport->dma_tx_in_progress =3D false;
> @@ -3179,6 +3219,7 @@ static int lpuart_suspend(struct device *dev)
>  				writeb(temp, sport->port.membase + UARTCR5);
>  			}
>  			uart_port_unlock_irqrestore(&sport->port, flags);
> +			flush_work(&sport->dma_tx_flush_work);
>  			sport->dma_tx_in_progress =3D false;
>  			dmaengine_terminate_sync(sport->dma_tx_chan);
>  		}

[Severity: Critical]
What prevents lpuart_flush_buffer() from scheduling sport->dma_tx_flush_work
again after flush_work(&sport->dma_tx_flush_work) has already returned in
lpuart_dma_shutdown() or lpuart_suspend()?

uart_flush_buffer() only takes sport->port.lock and does not hold
state->port.mutex or check tty_port_initialized(), so it can run concurrent=
ly
via tty_ioctl(TCFLSH) -> tty_perform_flush() or line discipline signal
handling (isig() -> tty_driver_flush_buffer()):

	if (sport->lpuart_dma_tx_use) {
		dmaengine_terminate_async(chan);
		if (sport->dma_tx_in_progress && !sport->dma_tx_flushing) {
			sport->dma_tx_flushing =3D true;
			schedule_work(&sport->dma_tx_flush_work);
		}
	}

In lpuart_dma_shutdown(), after flush_work(&sport->dma_tx_flush_work)
returns, the task sleeps in wait_event_interruptible_timeout() without
holding sport->port.lock while sport->lpuart_dma_tx_use is still true and
(if an un-flushed TX DMA transfer was active when lpuart_shutdown() or
lpuart32_shutdown() disabled hardware TX) sport->dma_tx_in_progress is true
and sport->dma_tx_flushing is false.

If lpuart_flush_buffer() runs during that wait and schedules
sport->dma_tx_flush_work, and wait_event_interruptible_timeout() is
interrupted by a signal or times out before the work runs,
lpuart_dma_shutdown() proceeds to call
dma_release_channel(sport->dma_tx_chan) without flushing
sport->dma_tx_flush_work again, allowing lpuart_dma_tx_flush_work() to
dereference the released sport->dma_tx_chan.

Similarly, in lpuart_suspend() on an active wakeup-enabled port,
sport->lpuart_dma_tx_use remains true across suspend and
sport->dma_tx_in_progress is cleared outside sport->port.lock after
flush_work(). If sport->dma_tx_flush_work is queued after flush_work() in
either path, a subsequent open or resume calling lpuart_tx_dma_startup()
will also execute INIT_WORK(&sport->dma_tx_flush_work, ...) while the work
item is still pending or running.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031123749.3783=
352-1-samarth.colleges@gmail.com?part=3D2
