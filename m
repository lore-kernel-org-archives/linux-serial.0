Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451325;
	b=QID1wXD3Tjsij8AmsE34K4ak6aL2418k//n2j36BdgpB2awtv8etMiF4Tk3K9dnbmwW+
	 3j16RtiY319TSLuwP8fnd3+vGUrrlc+RA4rmY+UK59BOH1koM2hwZHbfqJHcBTq2834+E
	 vc08yb++ZZYlZd/rq5WYIE15VdaONmzPbL7JECUqMquM5nMVWoQLsr/dA7kOV/68kHER1
	 RNb2vlsXi2b0wDMGtrAuQJgYOUGXNV0RQRjkQ7AMVrDEBpp2DPOlQntbQFOEG5vk1wP3L
	 9CZksf9nK6RDN/DMcg+nviZOMXzqOYN3Z7j8dtZlUVqYdE3dATjOKVe8SZCt6fQlYdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451325;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/oGaVFbYrk27Z6SQz2H7K7s7cOPw1XnZqEdq8H/khec=;
	b=umnk/cc0L4mBqzifAWbvKfR/F2SncuFGj7+FavR2uKj+gii5/qQrTcrmF/qHLvhN91m0
	 RDLy/niVyYMe7OpQ6hib1mQFLezlXn86TWev2vtEe0JItjfQf3DrYM+2i/SYN1BwElVC5
	 SKNgWNrW7ISLeRE++7Xj/KuK0a0IacDWXvrOi+GoidGgEDZfz4bitbKzNY80X6nEuLt+b
	 XFLQw0YpIaF5vSGvfnZx0ryG8JfoPJkEYnf3II2QuWUPlj9Ki4wwJhx3rr7uedMtCXkO2
	 fTNYPnFLR/pUhF0v9OY9TuyQJYFLhhLLFjLgzrPSxzOfS9POfFlf0/9LWomKZl8zF5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSQiSFIX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24E606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSQiSFIX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA791F0093A;
	Sat, 31 Oct 2026 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793451324;
	bh=/oGaVFbYrk27Z6SQz2H7K7s7cOPw1XnZqEdq8H/khec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSQiSFIXxOeE7dEBL0qoA9HhqrQ8LxNsGdIl3oLzntCWQe1gP6BI86/WEm+GbQdFi
	 b7Y9Q5ljzyIPVbRh6/joVBQ0GAWa5PZpzkrgJXD2jcqRWqLEwb1B+QyKxZWZM+75Vh
	 SS1Fhd/wOv7dT32da1FdT0aL0p85m0ZKX89NR3Kl+FS8QZSq0lfmvpesOUcrv4xqvn
	 pqV1AzZ5Zn2Ed/f+xUHpIQTob7fVD1aahfVQdV/3z4LuAjrF9ojEPwzCAbLf/RN0BL
	 exhQnfohr8qi2RO9OJbHZiOYfAbAkaA2gu8+g7NUkoeytxIt5epoEG3HzfHEX9AhT+
	 k5q8f6r4uDQQA==
Message-ID: <sashiko-outbox-191950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] serial: pch_uart: fix TX kfifo underflow on flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samarth Narang" <samarth.colleges@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031123911.3784690-6-samarth.colleges@gmail.com>
References: <20261031004733.3345841-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-6-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 12:55:24 +0000
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
- [Critical] serial: pch_uart: unlocked sg_tx_p read and TX DMA state overw=
rite after stop_tx
- [High] serial: pch_uart: lock inversion and self-deadlock in pch_dma_tx_c=
omplete()
- [High] serial: pch_uart: active DMA buffer overwrite and duplicate TX aft=
er flush
--

commit 41c9c81259479647a63a193b50f8884cd2a2a063
Author: Samarth Narang <samarth.colleges@gmail.com>

serial: pch_uart: fix TX kfifo underflow on flush

This commit adds a flush_buffer() callback to mark in-flight TX DMA
transfers as flushed and takes the port lock in pch_dma_tx_complete() so
completed flushed transfers do not advance the transmit kfifo.

> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index 9505d255f09c5..122025c4a0a66 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c

[ ... ]

> @@ -750,18 +751,23 @@ static void pch_dma_tx_complete(void *arg)
>  	struct eg20t_port *priv =3D arg;
>  	struct uart_port *port =3D &priv->port;
>  	struct scatterlist *sg =3D priv->sg_tx_p;
> +	unsigned long flags;
>  	int i;
> =20
> -	for (i =3D 0; i < priv->nent; i++, sg++)
> -		uart_xmit_advance(port, sg_dma_len(sg));
> +	uart_port_lock_irqsave(port, &flags);

[Severity: High]
Can taking port->lock in pch_dma_tx_complete() cause a lock inversion with
pd_chan->lock as well as a single-CPU recursive deadlock on port->lock?

In pch_uart_interrupt(), the interrupt handler holds priv->port.lock while
calling dma_handle_tx(), which calls into drivers/dma/pch_dma.c:

  pch_uart_interrupt()
    uart_port_lock(&priv->port)
    dma_handle_tx()
      dmaengine_prep_slave_sg() -> pd_prep_slave_sg() -> pdc_desc_get()
        spin_lock(&pd_chan->lock)
      dmaengine_submit() -> pd_tx_submit()
        spin_lock(&pd_chan->lock)
      dma_async_issue_pending() -> pd_issue_pending()
        spin_lock(&pd_chan->lock)

This establishes the lock order priv->port.lock -> pd_chan->lock.

In drivers/dma/pch_dma.c, every path that invokes the descriptor callback
pch_dma_tx_complete() holds pd_chan->lock:

  pdc_tasklet() / pd_issue_pending() / pd_device_terminate_all()
    spin_lock(&pd_chan->lock)
    pdc_advance_work() / pdc_complete_all() / pdc_handle_error()
      pdc_chain_complete()
        dmaengine_desc_callback_invoke()
          pch_dma_tx_complete()
            uart_port_lock_irqsave(port, &flags)

On SMP, if one CPU enters pch_uart_interrupt() -> dma_handle_tx() while
another CPU runs pdc_tasklet() -> pch_dma_tx_complete(), can this deadlock
between priv->port.lock and pd_chan->lock?

In addition, in pd_tx_submit(), when pd_chan->active_list is empty,
pdc_dostart() starts the hardware DMA transfer immediately. Two lines later
in dma_handle_tx() (still holding priv->port.lock),
dma_async_issue_pending() calls pd_issue_pending():

  if (pdc_is_idle(pd_chan)) {
          spin_lock(&pd_chan->lock);
          pdc_advance_work(pd_chan);
          spin_unlock(&pd_chan->lock);
  }

If a short transfer into the UART TX FIFO has already finished by the time
pdc_is_idle() is checked, pdc_advance_work() will invoke
pch_dma_tx_complete() synchronously on the same CPU while
pch_uart_interrupt() already holds priv->port.lock.

> +	if (!priv->tx_dma_flushed)
> +		for (i =3D 0; i < priv->nent; i++, sg++)
> +			uart_xmit_advance(port, sg_dma_len(sg));
> =20
>  	async_tx_ack(priv->desc_tx);
>  	dma_unmap_sg(port->dev, priv->sg_tx_p, priv->orig_nent, DMA_TO_DEVICE);
>  	priv->tx_dma_use =3D 0;
> +	priv->tx_dma_flushed =3D false;
>  	priv->nent =3D 0;
>  	priv->orig_nent =3D 0;
>  	kfree(priv->sg_tx_p);
>  	pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_TX_INT);
> +	uart_port_unlock_irqrestore(port, flags);
>  }
> =20
>  static int handle_rx_to(struct eg20t_port *priv)
> @@ -947,6 +953,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *=
priv)
>  	}
>  	priv->orig_nent =3D num;
>  	priv->nent =3D nent;
> +	priv->tx_dma_flushed =3D false;

[Severity: Critical]
What happens if pch_uart_stop_tx() is called while a TX DMA transfer is in
flight, followed by a flush and a subsequent TX restart before that first
transfer completes?

In pch_dma_tx_complete(), sg is initialized from priv->sg_tx_p before
uart_port_lock_irqsave() is called:

  struct scatterlist *sg =3D priv->sg_tx_p;
  ...
  uart_port_lock_irqsave(port, &flags);
  if (!priv->tx_dma_flushed)
          for (i =3D 0; i < priv->nent; i++, sg++)
                  uart_xmit_advance(port, sg_dma_len(sg));

Meanwhile, pch_uart_stop_tx() clears priv->tx_dma_use =3D 0 without stopping
the in-flight DMA transfer. If TX is restarted via pch_uart_start_tx(),
dma_handle_tx() sees priv->tx_dma_use =3D=3D 0 and starts a second TX DMA
transfer while the first transfer is still running:

  priv->sg_tx_p =3D kmalloc_objs(struct scatterlist, num, GFP_ATOMIC);
  ...
  priv->orig_nent =3D num;
  priv->nent =3D nent;
  priv->tx_dma_flushed =3D false;

When the first transfer's pch_dma_tx_complete() runs:

1. Because dma_handle_tx() reset priv->tx_dma_flushed to false, the flushed
first transfer still calls uart_xmit_advance() and underflows the kfifo.

2. If pch_dma_tx_complete() read sg =3D priv->sg_tx_p before dma_handle_tx()
replaced priv->sg_tx_p under port->lock, and the second transfer has a
larger priv->nent than the first, the loop over priv->nent reads past the
end of the first scatterlist allocation.

3. dma_unmap_sg() and kfree(priv->sg_tx_p) in the first completion will
unmap and free the second transfer's active scatterlist while the first
scatterlist is leaked, and the second completion will then unmap and kfree()
priv->sg_tx_p a second time.

> =20
>  	for (i =3D 0; i < nent; i++, sg++) {
>  		sg->offset =3D tail + fifo_size * i;
> @@ -1150,6 +1157,21 @@ static void pch_uart_stop_tx(struct uart_port *por=
t)
>  	priv->tx_dma_use =3D 0;
>  }
> =20
> +static void pch_uart_flush_buffer(struct uart_port *port)
> +{
> +	struct eg20t_port *priv;
> +
> +	priv =3D container_of(port, struct eg20t_port, port);
> +
> +	/*
> +	 * The kfifo has been reset. Let the running transfer finish, so that
> +	 * its buffer is unmapped only once it has stopped, but do not advance
> +	 * the kfifo for it.
> +	 */
> +	if (priv->nent)
> +		priv->tx_dma_flushed =3D true;
> +}

[Severity: High]
Could leaving the TX DMA transfer running after uart_flush_buffer() resets
the kfifo cause post-flush writes to overwrite the active DMA buffer and be
transmitted twice?

When uart_flush_buffer() runs during an active TX DMA transfer:

  uart_flush_buffer()
    uart_port_lock_irqsave()
    kfifo_reset(&state->port.xmit_fifo)
    pch_uart_flush_buffer()
      priv->tx_dma_flushed =3D true
    uart_port_unlock_irqrestore()
    tty_port_tty_wakeup(&state->port)

Because kfifo_reset() resets xmit_fifo.in and xmit_fifo.out to offset 0 of
state->port.xmit_buf while the in-flight DMA transfer still has
state->port.xmit_buf mapped DMA_TO_DEVICE via priv->sg_tx_p, any new data
written through uart_write() or uart_put_char() before the DMA transfer
completes will write into state->port.xmit_buf starting at offset 0 while
DMA is actively reading from that buffer.

Then, if the in-flight DMA transfer reads those newly written bytes from
offset 0 and finishes, pch_dma_tx_complete() skips uart_xmit_advance()
because priv->tx_dma_flushed is set and enables PCH_UART_HAL_TX_INT, causing
dma_handle_tx() to transmit the same post-flush bytes from xmit_fifo a
second time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031123911.3784=
690-1-samarth.colleges@gmail.com?part=3D5
