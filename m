Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451754;
	b=0hgj6WUwbL7LVhUW6rgYJ2K06TtVqucriX2FZLGSdh0yehPyeBYS81kEdcvJnJLrfDKx
	 R+daW+HGsZM1EQZ8SEe3p3MADWNnU+NPAwocekZAesG8urDz+IUpp2ieQB+/Zn0eWGKt8
	 zqAAqBV1oEpSNS3RgxsSnGxQerFM1Z1KEz1qltWr3G2jnJQZa4EpqAGu+Qoh/fA4kY5X2
	 +so/Bp8uYY8yX99Dr20s+PeH5wxIRpW2qM9A+cv00sQh9TLjnLd9YsnCQdka7XDX7WeEM
	 svkOz182X3Pss/U5CgbwYYWW8K1NcsZVhOV5us8Dzewm0bcMCsWFutuvVO1nDFMHGFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451754;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sjUOSbJdtIo7WAdD8iGewc4bvguM+aOq8DtVT4VK1K8=;
	b=ZXjj/Bu/3p1bjiDGOmexGAyMGMIJDUkq5h8cL+gSCHcYo3/5h1COb6mR4EubGqcH/Ub2
	 Vt4f+q265OiRgx9RzJD4OWzL2jWGty3EJpaBWW/QxnqQ/AfuXJLdhs/NBwV+dt5rUtR43
	 shjqptVEW9pq/f6NyWlWouN3MFsjLKMBnGHxs/PG6oU+zNt22LqwGPhIoyE4TqqcpA/ii
	 bE07v6Ao/fctq2tJXcPxS5RTkYGqMazJ4qNxUg3CDDEtps9Yga+Qm4uiEtzhQpXk05lqn
	 Y67zlvzzhrFzAFP9aWWMi2GNqmsq1f3+hun6iS7aY6Ew/857xAEPi2JDowLWPXnPBpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqJvbd4X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F3E606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqJvbd4X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D691C1F000C1;
	Sat, 31 Oct 2026 13:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793451754;
	bh=sjUOSbJdtIo7WAdD8iGewc4bvguM+aOq8DtVT4VK1K8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fqJvbd4Xn0yOv6PsgOnEG3I1JYKi4PIHT+2BPnMXLKwoOw4jRGO0GUH0W5zsifyj8
	 hpf+ltzytrK/tHdRu5a3L0j8PhQeYIOWG+BMCayMXA3TzOds40nmCW/80lj/uaTELW
	 nuyliFnUAfnmxfV4redbqKa2LP+hadq9yI9jnocSlphjhTtPigcbc6p/R/7xAK4ROz
	 o1Wm65P8WB0RBuiVfeFCzuiNPY3sP1N4I46yRnSvuv3g1F0H40EAlB2jnpvQCEpyIL
	 G5zs4FTli3+WI0UHlI4yzjzZTi3jsIzmESVv9GT/lg/7iu3KeWFOM47xV5V19rnVEp
	 uwJdZMhRAvMDA==
Message-ID: <sashiko-outbox-191954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] tty: serial: samsung: fix TX kfifo underflow on
 flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samarth Narang" <samarth.colleges@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031123911.3784690-2-samarth.colleges@gmail.com>
References: <20261031004733.3345841-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-2-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 13:02:33 +0000
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
- [High] serial: samsung: use-after-free on tx_desc in s3c24xx_serial_flush=
_buffer()
- [High] tty: serial: samsung: ABA race on tx_in_progress in s3c24xx_serial=
_tx_dma_complete()
--

commit 73ae60b92dcc88f73c03b4939f2ea2f4d964ab3a
Author: Samarth Narang <samarth.colleges@gmail.com>

tty: serial: samsung: fix TX kfifo underflow on flush

This commit adds a flush_buffer() hook to samsung_tty to terminate any acti=
ve
TX DMA transfer when the transmit buffer is flushed, and updates
s3c24xx_serial_tx_dma_complete() to skip advancing the kfifo if the transfer
was already retired.

> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 640f85e2d636b..2bea7ef078d2d 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -317,6 +317,20 @@ static void s3c24xx_serial_stop_tx(struct uart_port =
*port)
>  	ourport->tx_mode =3D 0;
>  }
> =20
> +static void s3c24xx_serial_flush_buffer(struct uart_port *port)
> +{
> +	struct s3c24xx_uart_port *ourport =3D to_ourport(port);
> +	struct s3c24xx_uart_dma *dma =3D ourport->dma;
> +
> +	if (!dma || !dma->tx_chan || ourport->tx_in_progress !=3D S3C24XX_TX_DM=
A)
> +		return;
> +
> +	/* The kfifo has been reset: the completion must not advance it */
> +	dmaengine_terminate_async(dma->tx_chan);
> +	async_tx_ack(dma->tx_desc);

[Severity: High]
Can calling async_tx_ack(dma->tx_desc) after dmaengine_terminate_async() in
drivers/tty/serial/samsung_tty.c:s3c24xx_serial_flush_buffer() cause a
use-after-free write on dma->tx_desc when flushing the TTY transmit buffer
while a TX DMA transfer is active (ourport->tx_in_progress =3D=3D S3C24XX_T=
X_DMA)?

dmaengine_terminate_async(dma->tx_chan) invokes the DMA controller's
device_terminate_all() callback synchronously before returning. On Samsung
platforms using PL330, drivers/dma/pl330.c:pl330_terminate_all() returns all
channel descriptors back to the controller-wide descriptor pool:

	list_splice_tail_init(&pch->submitted_list, &pl330->desc_pool);
	list_splice_tail_init(&pch->work_list, &pl330->desc_pool);
	list_splice_tail_init(&pch->completed_list, &pl330->desc_pool);

where another channel can immediately reallocate the descriptor via
pl330_get_desc(). Similarly, on platforms using AMBA PL08x,
drivers/dma/amba-pl08x.c:pl08x_terminate_all() frees queued descriptors via
pl08x_free_txd_list() -> vchan_dma_desc_free_list() -> kfree(txd) before
dmaengine_terminate_async() returns.

When s3c24xx_serial_flush_buffer() then calls async_tx_ack(dma->tx_desc), it
writes DMA_CTRL_ACK to dma->tx_desc->flags on a descriptor that has already
been recycled or freed. In addition, if s3c24xx_serial_tx_dma_complete() is
running concurrently on another CPU, it also calls async_tx_ack(dma->tx_des=
c)
before acquiring port->lock, racing with s3c24xx_serial_flush_buffer()
terminating and freeing dma->tx_desc under port->lock.

> +	ourport->tx_in_progress =3D 0;
> +}
> +
>  static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourpo=
rt);
> =20
>  static void s3c24xx_serial_tx_dma_complete(void *args)
> @@ -339,6 +353,12 @@ static void s3c24xx_serial_tx_dma_complete(void *arg=
s)
> =20
>  	uart_port_lock_irqsave(port, &flags);
> =20
> +	/* Already retired by stop_tx or flush_buffer */
> +	if (ourport->tx_in_progress !=3D S3C24XX_TX_DMA) {
> +		uart_port_unlock_irqrestore(port, flags);
> +		return;
> +	}

[Severity: High]
What happens if a new TX DMA transfer starts after
drivers/tty/serial/samsung_tty.c:s3c24xx_serial_flush_buffer() clears
ourport->tx_in_progress, but before an already-running
s3c24xx_serial_tx_dma_complete() acquires port->lock?

In drivers/tty/serial/samsung_tty.c:s3c24xx_serial_tx_dma_complete(), the
completion callback computes count from dma->tx_bytes_requested and
state.residue before taking port->lock:

	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
	count =3D dma->tx_bytes_requested - state.residue;
	async_tx_ack(dma->tx_desc);

	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->tx_chan),
				dma->tx_transfer_addr, dma->tx_size,
				DMA_TO_DEVICE);

	uart_port_lock_irqsave(port, &flags);

Because s3c24xx_serial_flush_buffer() uses dmaengine_terminate_async(), it
does not wait for an in-flight completion callback to finish before clearing
ourport->tx_in_progress =3D 0 and releasing port->lock in uart_flush_buffer=
().

If a subsequent or woken uart_write() of at least ourport->min_dma_size byt=
es
acquires port->lock before the stale s3c24xx_serial_tx_dma_complete() does,
__uart_start() -> s3c24xx_serial_start_tx() -> s3c24xx_serial_start_next_tx=
()
-> s3c24xx_serial_start_tx_dma() will see ourport->tx_in_progress =3D=3D 0 =
and the
reset kfifo tail aligned to a cache line, overwrite the dma->tx_* fields, a=
nd
set ourport->tx_in_progress =3D S3C24XX_TX_DMA for the new transfer:

	dma->tx_bytes_requested =3D dma->tx_size;

	ourport->tx_in_progress =3D S3C24XX_TX_DMA;
	dma->tx_cookie =3D dmaengine_submit(dma->tx_desc);
	dma_async_issue_pending(dma->tx_chan);

When the first transfer's s3c24xx_serial_tx_dma_complete() then acquires
port->lock, ourport->tx_in_progress is S3C24XX_TX_DMA again. Wouldn't it
bypass the ourport->tx_in_progress !=3D S3C24XX_TX_DMA check, call
uart_xmit_advance(port, count) with the first transfer's byte count on the
newly written kfifo (underflowing xmit_fifo if the new write is smaller than
count), and clear ourport->tx_in_progress =3D 0 while the second DMA transf=
er is
still active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031123911.3784=
690-1-samarth.colleges@gmail.com?part=3D1
