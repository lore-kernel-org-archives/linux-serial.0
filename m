Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793461738;
	b=tmIQ+SuRPYnTgFIkIoXDRB/wtjSFobXQ4opvXopE0DIfM1gZ+LHzDZk0JUaEdfUr06Ys
	 R/0xUNPNj/cqC2hUZbn15Bz8o2twh+ZGQs6YqSfiSlR74YEEbd1BOt9XKUFuiGI4iQ8l6
	 9l7Gq/mN9bfwUNMGlFWrvojYbfDKDlPpTA0+BDdB8i76/EiXSPro6AmsTFuLq3vveTabc
	 554nV4fhLwe5tLDzw1RnlyJYU3Y/p1Gq6v4ZEZSKhGRnmTp9D1crlFRMUDSoT4B3p8jzi
	 t04HRYrg6DyWsd1hyT5G9QX719VvSh+DNzxtMzTd3WJXdX5FZx1QCK+9Z93zsidTxMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793461738;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A7eq/T91iNZYPj2jyZ9LyaqzAS/xjo0loSg5osj+oS0=;
	b=nRx1FRjImZ5ZdQrjxNdQYB8L8J6vOatBL7miijaHsztGofR6p6kIA5SVGO2/taD58S0c
	 8/Hl6/Nl4czQJM7bGFc1hfUoNVpbF6BHiYWFRmkINMORdKsU91u6xKYuzV6CGxor0MfU8
	 vZPozmeSR49GUzeKjH6WMjbk1vQ6pjLB85qbM9CqS+DTopmIMZoRTmKgHMeib6/TEI9pt
	 fCbC2wv2hzb3+HAjOfF2lXnIfyZv+51Jk1bvB6Ruap90w1pL+SySzG4Bp3KJaEDfolIUo
	 ULk0aflq7cOkVprVwMw44eGXPY3qwiatVJCp3oGWq7e4KU4hfF2iWQY1XNfQtHasNNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JvNTn7KS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308E606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JvNTn7KS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341961F000C1;
	Sat, 31 Oct 2026 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793461737;
	bh=A7eq/T91iNZYPj2jyZ9LyaqzAS/xjo0loSg5osj+oS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JvNTn7KSWaB83HPa5GmXbYBvhQ/+QP6NA6RqRkY/U55dM8rxpD32y/2iiBtQ4aYK0
	 mk8AbbhmXELQnr6hZGDGp9G4w3JViej7jiEUcHz4hdPH1/lqavYBZxMex9fmaZtsF7
	 cNIHodYnXwcCYXCOT72KkJj3/2yKRZJ1jtz0y7RstQRs7FIhlzMNqvPneh2pTsfAoX
	 GRLZdDnwiGd0TbfqpIlDf9R1T3KYKNYTELsewN0jraoWWAFI06D3YfqPV6CcmqjZ4+
	 Bc0LP0PJufd91Y0GhCPR6mvSsgAUT3OAebSgBLtj89mfDdsbkdoYBU/lOjNbJd3o18
	 gq/u+bUvU0eJQ==
Message-ID: <sashiko-outbox-192028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: samsung: fix TX fifo underflow on flush
 race
Reply-To: sashiko-reviews@lists.linux.dev
To: "tianci xie" <xiex16070@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031152656.1422-2-xiex16070@gmail.com>
References: <2026103122-repurpose-cost-2da7@gregkh>
 <20261031152656.1422-1-xiex16070@gmail.com>
 <20261031152656.1422-2-xiex16070@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 15:48:56 +0000
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
- [High] tty: serial: samsung: race in s3c24xx_serial_flush_buffer() underf=
lows TX fifo
--

commit f08a63c8494169298262a17372c5a89a1b95c795
Author: tianci xie <xiex16070@gmail.com>

tty: serial: samsung: fix TX fifo underflow on flush race

This commit adds a flush_buffer callback to s3c64xx_serial_ops and
apple_s5l_serial_ops to terminate active TX DMA transfers and clear
tx_bytes_requested when the transmit buffer is flushed, while moving the
tx_bytes_requested check in s3c24xx_serial_tx_dma_complete() under the port
lock.

Link: https://lore.kernel.org/all/20261031004733.3345841-1-samarth.colleges=
@gmail.com/

> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 640f85e2d636b..e955b7eab5f27 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -330,7 +330,6 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
>  	int count;
> =20
>  	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
> -	count =3D dma->tx_bytes_requested - state.residue;
>  	async_tx_ack(dma->tx_desc);
> =20
>  	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->tx_chan),
> @@ -339,6 +338,17 @@ static void s3c24xx_serial_tx_dma_complete(void *arg=
s)
> =20
>  	uart_port_lock_irqsave(port, &flags);
> =20
> +	/*
> +	 * uart_flush_buffer() resets the xmit fifo and then calls
> +	 * ->flush_buffer(), which clears tx_bytes_requested.  Sample the byte
> +	 * count under the port lock so that a completion which raced with a
> +	 * flush cannot advance the already reset fifo past its write index.
> +	 */
> +	if (dma->tx_bytes_requested)
> +		count =3D dma->tx_bytes_requested - state.residue;
> +	else
> +		count =3D 0;
> +
>  	uart_xmit_advance(port, count);
>  	ourport->tx_in_progress =3D 0;
> =20
> @@ -1162,6 +1172,32 @@ static void s3c24xx_serial_release_dma(struct s3c2=
4xx_uart_port *p)
>  	}
>  }
> =20
> +/*
> + * Called from uart_flush_buffer() with the port lock held, after the xm=
it fifo
> + * has already been reset.  A TX DMA transfer still in flight carries da=
ta that
> + * no longer exists, so drop its byte count before terminating it: the
> + * completion callback may still run and must not advance the reset fifo.
> + */
> +static void s3c24xx_serial_flush_buffer(struct uart_port *port)
> +{
> +	struct s3c24xx_uart_port *ourport =3D to_ourport(port);
> +	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> +
> +	if (!dma || !dma->tx_chan || ourport->tx_in_progress !=3D S3C24XX_TX_DM=
A)
> +		return;
> +
> +	dma->tx_bytes_requested =3D 0;
> +
> +	/*
> +	 * dmaengine_terminate_sync() cannot be used here because the port
> +	 * lock is held.  The callback may or may not run afterwards; either
> +	 * way it is a no-op for the fifo because tx_bytes_requested is zero.
> +	 */
> +	dmaengine_terminate_async(dma->tx_chan);
> +
> +	ourport->tx_in_progress =3D 0;
> +}

[Severity: High]
Can clearing ourport->tx_in_progress =3D 0 in s3c24xx_serial_flush_buffer()
allow a subsequent write to start a new transfer before an already-dispatch=
ed
s3c24xx_serial_tx_dma_complete() callback from the flushed transfer acquires
port->lock?

When a DMA transfer completes just as uart_flush_buffer() runs, the DMA
engine tasklet (such as pl330_tasklet()) can invoke
s3c24xx_serial_tx_dma_complete() on CPU 0 while CPU 1 holds port->lock in
uart_flush_buffer():

CPU 0                                   CPU 1
s3c24xx_serial_tx_dma_complete()        uart_flush_buffer()
  dmaengine_tx_status(...)                uart_port_lock_irqsave()
  async_tx_ack(...)                       kfifo_reset(&tport->xmit_fifo)
  dma_sync_single_for_cpu(...)            s3c24xx_serial_flush_buffer()
                                            dma->tx_bytes_requested =3D 0;
                                            dmaengine_terminate_async();
                                            ourport->tx_in_progress =3D 0;
                                          uart_port_unlock_irqrestore()

Because ourport->tx_in_progress is now 0, a new write via
uart_write() -> s3c24xx_serial_start_tx() -> s3c24xx_serial_start_next_tx()
can acquire port->lock before CPU 0's s3c24xx_serial_tx_dma_complete() does:

drivers/tty/serial/samsung_tty.c:s3c24xx_serial_start_tx() {
	...
	if (ourport->dma && ourport->dma->tx_chan) {
		if (!kfifo_is_empty(&tport->xmit_fifo) &&
				!ourport->tx_in_progress)
			s3c24xx_serial_start_next_tx(ourport);
	}
}

If the new write starts a second DMA transfer via
s3c24xx_serial_start_tx_dma(), it overwrites dma->tx_size,
dma->tx_transfer_addr, dma->tx_desc, and dma->tx_cookie (which also races
with the unlocked reads at the top of s3c24xx_serial_tx_dma_complete() if
CPU 0 has not passed them yet), sets dma->tx_bytes_requested to the new
transfer's size, and sets ourport->tx_in_progress =3D S3C24XX_TX_DMA.

When CPU 0's stale callback from the first transfer then acquires port->loc=
k,
wouldn't it observe the second transfer's non-zero dma->tx_bytes_requested,
advance xmit_fifo prematurely, clear ourport->tx_in_progress =3D 0 while the
second DMA transfer is still in flight, and then underflow xmit_fifo when t=
he
second transfer's callback later runs and advances xmit_fifo again?

Similarly, if the new write is smaller than ourport->min_dma_size and starts
a PIO transfer via s3c24xx_serial_start_tx_pio() -> enable_tx_pio(), setting
ourport->tx_in_progress =3D S3C24XX_TX_PIO and ourport->tx_mode =3D
S3C24XX_TX_PIO, wouldn't the stale DMA callback subsequently clear
ourport->tx_in_progress =3D 0 and call s3c24xx_serial_start_next_tx() ->
s3c24xx_serial_start_tx_pio(), which skips enable_tx_pio() because
ourport->tx_mode is already S3C24XX_TX_PIO, leaving ourport->tx_in_progress
as 0 while PIO is active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031152656.1422=
-1-xiex16070@gmail.com?part=3D1
