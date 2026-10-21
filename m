Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623909;
	b=vu9mnChsdnvf7xCWRgJYupIWF2LuGBd5UaMV2ZyGRP2VzKqmoC4McTMZxj1H+VJ4jad5
	 n6U4HBQ7EYivqG++hj8f5F/G6t/8qyxugEGXePK45GlmZ1YKL3NS59wPFyR6QPXGGyT87
	 V0C08IE13bKGyUuSzJBM0glxIgXOL8rU5Z6Xx6JUe5ThjkkbDPySP0ugnoXWcLO4CelQT
	 uhyrVX4WYhw5C0h37A4hUl/m4M/jx4yXFGm8QboxVsuqqgECF1nrjkE6vT+0b3/bKLc+I
	 6jYOap+IGVzGzXU4mw5AjaSWFq3J1xX2wuWw64zHk8ulvbc3x8fUOtf03lboBcdIKtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623909;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DgRy/Icd3Vvn+nxJhmZXtt7Lbz/zBCWpXcXmTxA2Ymw=;
	b=T2gGcq3/PVTU3GqucIkmpNPZpvwg7f1MlajZSIgwIX690Nr0EAKtAad0DrKDoMj7hLkH
	 keBAixnwDh3bhpa2716YnuHNk5Nwk+TGpT+keubknbnm9An44JO0oQGwzH96/Ya3l62hF
	 q3RbDH+twhGFRhhj6FjlgdvzkUCUAous/+ZJEmXq602KGwOxPhXB8/cCRuShd0HywrGWZ
	 qyueAITEkBYiDirW2BInMVytVt0tG73iF5RY6Hr7WnPb/+X3pIx7/XCW1tUM04tx94Z1z
	 5w7olN7YlRBLMCdDEZss2ncJz09uROvy4zMigAYTLK4frG0o2pfGue46h/q37s6JGmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjltUHp1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16B606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjltUHp1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7431F000C1;
	Wed, 21 Oct 2026 23:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623909;
	bh=DgRy/Icd3Vvn+nxJhmZXtt7Lbz/zBCWpXcXmTxA2Ymw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MjltUHp19drvw5SJT9u6xrPpyYw8gAYroJ8/T3T5Xux6DxaEssI2pvPdmv+RNGjBf
	 cYIpX8yucuAQA6uq8V79M08pH5sjMQ7Pk5QLnxooAAx8W0ljS9fhHk6Bn+ujmKnVwB
	 tUqaC+/HCd3BS9pz2FKDq45tcLFclnXgBIjphs44Uy2GYLEaoQAyMoYSFHfHHb5Oro
	 aqwHqCek3ws7QHxjCkGWptS1iQ5R+hvctKFGldn6nGp1BSDl8JF4o8ny5FKJBgfL+D
	 MeUPQSAzWGvcG1kEQDj+yBXrJfW41P9J5GvA70eNI7Ram0ReM8t4yZMmdkRLMW6rMA
	 O+3zLXRo3jqAA==
Message-ID: <sashiko-outbox-180762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: retire canceled RX DMA before reusing
 the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-submit-serial-8250-dma-cancel-v1-v1-2-efe2b89f2303@gmail.com>
References: <20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com>
 <20261021-submit-serial-8250-dma-cancel-v1-v1-2-efe2b89f2303@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 23:05:08 +0000
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
- [High] serial: 8250: missing shutting_down check in serial8250_rx_dma_flu=
sh()
- [High] serial: 8250: rx dma flush fails on paused DMA_IN_PROGRESS and DMA=
_ERROR
--

commit d4e9133dca0ba3f456e79c0c4b6fad29f9996583
Author: James Hilliard <james.hilliard1@gmail.com>

serial: 8250: retire canceled RX DMA before reusing the receive buffer

This commit reserves the RX DMA buffer across asynchronous termination and
synchronizes in-flight completion callbacks in a workqueue worker before
allowing a new RX DMA transfer to reuse the buffer. It also checks pause and
status results during RX DMA flushes and serializes Intel MID timeout calle=
rs
with the UART port lock.

> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250=
/8250_dma.c
> index d4b1e2a059eb1..821ccc7a3a54d 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -77,31 +77,29 @@ void serial8250_tx_dma_prepare_buffer(struct uart_825=
0_port *p,
>  }
>  EXPORT_SYMBOL_GPL(serial8250_tx_dma_prepare_buffer);
> =20
> -static void __dma_rx_complete(struct uart_8250_port *p)
> +static enum dma_status serial8250_rx_dma_complete(struct uart_8250_port =
*p)
>  {
>  	struct uart_8250_dma	*dma =3D p->dma;
>  	struct tty_port		*tty_port =3D &p->port.state->port;
>  	struct dma_tx_state	state;
>  	enum dma_status		dma_status;
> -	int			count;
> +	size_t			count;
> =20
> -	/*
> -	 * New DMA Rx can be started during the completion handler before it
> -	 * could acquire port's lock and it might still be ongoing. Don't to
> -	 * anything in such case.
> -	 */
> +	/* Only inspect the buffer after completion or a successful pause. */
>  	dma_status =3D dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> -	if (dma_status =3D=3D DMA_IN_PROGRESS)
> -		return;
> +	if (dma_status !=3D DMA_COMPLETE && dma_status !=3D DMA_PAUSED)
> +		return dma_status;

[ ... ]

> +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> +{
> +	struct uart_8250_dma *dma =3D container_of(work, struct uart_8250_dma,
> +					       rx_flush_work);
> +	struct uart_8250_port *p =3D dma->port;
> +
> +	dmaengine_synchronize(dma->rxchan);
> +
> +	guard(uart_port_lock_irqsave)(&p->port);
> +	dma->rx_terminating =3D false;
> +	dma->rx_running =3D 0;
> +	if (!dma->shutting_down && (p->ier & UART_IER_RDI) &&
> +	    (serial_lsr_in(p) & UART_LSR_DR))
> +		dma->rx_dma(p);
> +}

[ ... ]

> -void serial8250_rx_dma_flush(struct uart_8250_port *p)
> +int serial8250_rx_dma_flush(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma *dma =3D p->dma;
> +	enum dma_status status;
> +	int ret;
> =20
> -	if (!dma || !dma->rxchan || !dma->rx_running)
> -		return;
> +	lockdep_assert_held_once(&p->port.lock);
> +
> +	if (!dma || !dma->rxchan || !dma->rx_running || dma->rx_terminating)
> +		return 0;

[Severity: High]
Should serial8250_rx_dma_flush() also check dma->shutting_down before
proceeding, similar to serial8250_tx_dma_flush(), dma_rx_complete(), and
serial8250_rx_dma()?

During shutdown, serial8250_do_shutdown() in
drivers/tty/serial/8250/8250_port.c sets up->dma->shutting_down =3D true and
clears UART_IER under port->lock, calls synchronize_irq(port->irq), and then
calls serial8250_release_dma(up) while port->irq is still registered.

In drivers/tty/serial/8250/8250_dma.c, serial8250_release_dma() cancels
rx_flush_work before terminating dma->rxchan and clearing dma->rx_running:

drivers/tty/serial/8250/8250_dma.c:serial8250_release_dma() {
	...
	cancel_work_sync(&dma->tx_flush_work);
	cancel_work_sync(&dma->rx_flush_work);

	/* Release RX resources */
	dmaengine_terminate_sync(dma->rxchan);
	dma->rx_running =3D 0;
	dma_free_coherent(dmaengine_get_dma_device(dma->rxchan), dma->rx_size,
			  dma->rx_buf, dma->rx_addr);
	dma_release_channel(dma->rxchan);
	dma->rxchan =3D NULL;
	...
}

On Intel MID platforms, tng_handle_irq() and dnv_handle_irq() in
drivers/tty/serial/8250/8250_mid.c handle HSU DMA channel timeout interrupts
on shared port->irq, which are not masked by clearing UART_IER. While the RX
DMA transfer is still active prior to dmaengine_terminate_sync(dma->rxchan)
(or if a concurrent IRQ handler read UART_IIR just before
serial8250_do_shutdown() took port->lock), the handler can acquire port->lo=
ck
and call serial8250_rx_dma_flush(up) after cancel_work_sync(&dma->rx_flush_=
work)
has already returned.

Without a dma->shutting_down check, serial8250_rx_dma_flush() will push flip
buffer data after shutdown has started and call
schedule_work(&dma->rx_flush_work). When serial8250_rx_dma_flush_work()
subsequently runs, serial8250_release_dma() may have already released
dma->rxchan and set dma->rxchan =3D NULL, causing
dmaengine_synchronize(dma->rxchan) to dereference dma->rxchan =3D=3D NULL o=
r a
freed channel.

> +
> +	ret =3D dmaengine_pause(dma->rxchan);
> +	if (ret)
> +		return ret;
> +
> +	status =3D serial8250_rx_dma_complete(p);
> +	if (status !=3D DMA_PAUSED && status !=3D DMA_COMPLETE) {
> +		dmaengine_resume(dma->rxchan);
> +		return -EIO;
> +	}

[Severity: High]
Could rejecting statuses other than DMA_PAUSED and DMA_COMPLETE here and in
serial8250_rx_dma_complete() wedge RX DMA or cause an unhandled interrupt
storm on RX timeout?

First, several dmaengine providers that pass the capability checks in
serial8250_request_dma() (such as sun6i-dma in drivers/dma/sun6i-dma.c and
dw-axi-dmac in drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c, used with
8250_dw) pause the hardware channel in .device_pause and return 0, but their
.device_tx_status callbacks still return dma_cookie_status() (DMA_IN_PROGRE=
SS)
rather than DMA_PAUSED. With this check, serial8250_rx_dma_flush() resumes
the channel and fails with -EIO on every RX timeout flush and in
dw8250_idle_enter().

Second, if an RX DMA transfer encounters a channel error (DMA_ERROR, for
example in drivers/dma/hsu/hsu.c or drivers/dma/idma64.c where .device_pause
only sets DMA_PAUSED when the descriptor is DMA_IN_PROGRESS), neither
dma_rx_complete() nor serial8250_rx_dma_flush() terminates the transfer or
clears dma->rx_running, leaving RX DMA permanently stuck.

Third, when serial8250_rx_dma_flush() returns an error on UART_IIR_RX_TIMEO=
UT,
UART_IIR_RDI, or UART_IIR_RLSI, handle_rx_dma() in
drivers/tty/serial/8250/8250_port.c now returns false, causing
serial8250_handle_irq_locked() to skip serial8250_rx_chars():

drivers/tty/serial/8250/8250_port.c:handle_rx_dma() {
	...
	case UART_IIR_RLSI:
	case UART_IIR_RX_TIMEOUT:
		return !serial8250_rx_dma_flush(up);
}

drivers/tty/serial/8250/8250_port.c:serial8250_handle_irq_locked() {
	...
	if (!up->dma || handle_rx_dma(up, iir))
		status =3D serial8250_rx_chars(up, status);
}

Because UART_IIR_RX_TIMEOUT is only cleared by reading UART_RX and the FIFO
level on a timeout is below the DMA burst watermark (and in
dw8250_handle_irq() in drivers/tty/serial/8250/8250_dw.c with
DW_UART_QUIRK_IS_DMA_FC, RZN1_UART_RDMACR has already been cleared to 0
before serial8250_handle_irq_locked() is called), returning from the ISR
without reading UART_RX via PIO leaves the level-triggered UART interrupt
asserted.

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-submit-ser=
ial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com?part=3D2
