Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451506;
	b=MNTjMsRa8KsxPQuqid4RSE4uC0KniekWO4NKlxf7eJrBwUd3fOzHq8KAGUFnQmo9MCt0
	 x0g2a1B9KNVolK2/PjL3MzzVj9ShJ0jRic+n1Qa3/oayxlYd6r0zoWSVxpYtFSNl0dlqm
	 vsZkni9LK7rXmvrl5lWggvZ3xrGz/+P6zp/AHAjQROq8kLAyNd24+hKQb9LaJT2Dp/EsV
	 8Q5A+b/MCOFWXynzuWWUmsPhuYSefVKY2hA4Cy4HKsuK1NL/GcBtCz4/inh05/CEeFuWd
	 1TQGflHFxFv/kwKfsqvzBf/cKuZ3x40gaAjOQH2LuO/lQ0vSMVo79IMCBDVSpD3hdZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451506;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A/L80ksMhPc6C+nD+SSTMHCw9mCt16mAii3eaLYSyUU=;
	b=fYh7KaDEC2+/X85CmACTfvdNXmSzakw/Heiwes4u2FBwqj8gO3D4FTdw7rZoq0Dn+9cB
	 9vTrNpW/dRoBZvIMmCDGE4kbLxIbNrmOEjipLZHU5AUSs4TfoyWqyAhLhyb1vNQUjjy4k
	 awHiSLD5Z2KN846TqJ5QbBtUuV6nskQaJUXbKGoEj21a2spWobu5jFqFXWcetwf1gT/yW
	 Bnek6T6VJgiFlWs57s59/6w5TzK2PpIn1YtKwWN2KUbQEOOM1W+YAIHeGeLe+2ZsGVMsG
	 nDPnJptJ9VE7z8ds/vrktq4CfnmAeGehzN/p00kPrPOrEkTp1RlUCN6X7ifixpWmy5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C/fAo6E8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF0606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C/fAo6E8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44B51F000C1;
	Sat, 31 Oct 2026 12:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793451505;
	bh=A/L80ksMhPc6C+nD+SSTMHCw9mCt16mAii3eaLYSyUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/fAo6E8JGgo/NsFWJNmVUFjuOEQMXNyNkDC93MsnHh7BELu4VLaAnBFti3mGgNPh
	 yv0QWMobEgemh1iij0QoDUh5nOThCYlwva86R3AksEAB0RAB5ZHQMKXrlqG2Cu3l7i
	 METj5UUAPrOxLrUFBnwl3rzxkGsuQDCfcobWCGps04o2ut94ni5fPb6uF2riw/qeEU
	 7NK8HmOptK9Y7HbQTE1F+CKT8DlAe9nY0ghCw+bpx3MdSV0oa2g8lPRLxflLMh/gy2
	 D8PhY5cuI7VBeeY5o5dfarWmUvUczbcAwkde+hx11Aye1CiRCJ6SrD7vOIj7KBJFsN
	 QwVdgaHqGBKyg==
Message-ID: <sashiko-outbox-191951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] serial: sprd: fix TX kfifo underflow on flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samarth Narang" <samarth.colleges@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031123911.3784690-4-samarth.colleges@gmail.com>
References: <20261031004733.3345841-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-4-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 12:58:25 +0000
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
- [High] serial: sprd: TX DMA left running in sprd_flush_buffer() corrupts =
xmit_buf
- [High] serial: sprd: DMA mapping leak and TX wedge after sprd_flush_buffe=
r()
- [Medium] serial: sprd: race in sprd_stop_tx_dma() when TX DMA just comple=
ted
--

commit 8173f9afc9b36f262ce001244563fa23087de599
Author: Samarth Narang <samarth.colleges@gmail.com>

serial: sprd: fix TX kfifo underflow on flush

This commit adds a flush_buffer() hook to sprd_serial that marks an in-flig=
ht
TX DMA transfer with tx_flushed instead of terminating it under the port
lock, so that sprd_complete_tx_dma() and sprd_stop_tx_dma() skip calling
uart_xmit_advance() after the transmit kfifo has been reset.

> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_s=
erial.c
> index 3fdf5939a62c1..718732b683f1b 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -133,6 +133,7 @@ struct sprd_uart_port {
>  	struct clk *clk;
>  	struct sprd_uart_dma tx_dma;
>  	struct sprd_uart_dma rx_dma;
> +	bool tx_flushed;
>  	dma_addr_t pos;
>  	unsigned char *rx_buf_tail;
>  	const struct sprd_uart_data *pdata;
> @@ -236,13 +237,15 @@ static void sprd_stop_tx_dma(struct uart_port *port)
>  	dmaengine_tx_status(sp->tx_dma.chn, sp->tx_dma.cookie, &state);
>  	if (state.residue) {
>  		trans_len =3D state.residue - sp->tx_dma.phys_addr;
> -		uart_xmit_advance(port, trans_len);
> +		if (!sp->tx_flushed)
> +			uart_xmit_advance(port, trans_len);
>  		dma_unmap_single(port->dev, sp->tx_dma.phys_addr,
>  				 sp->tx_dma.trans_len, DMA_TO_DEVICE);
>  	}
> =20
>  	dmaengine_terminate_all(sp->tx_dma.chn);
>  	sp->tx_dma.trans_len =3D 0;
> +	sp->tx_flushed =3D false;
>  }

[Severity: Medium]
What happens if sprd_stop_tx_dma() runs just after the hardware finishes the
flushed DMA transfer, before the sprd_complete_tx_dma() tasklet runs?

After uart_flush_buffer() resets tport->xmit_fifo while leaving the TX DMA
transfer running, kfifo_is_empty(&tport->xmit_fifo) is true. Any subsequent
call to sprd_stop_tx() or to sprd_start_tx() -> sprd_start_tx_dma() while t=
he
kfifo is still empty (such as from uart_flush_chars() or uart_start()) will
enter sprd_stop_tx_dma():

drivers/tty/serial/sprd_serial.c:sprd_start_tx_dma() {
	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
		sprd_stop_tx_dma(port);
		return;
	}

In drivers/dma/sprd-dma.c, when the transfer completes in hardware,
dma_irq_handle() calls vchan_cookie_complete(), which marks sp->tx_dma.cook=
ie
as DMA_COMPLETE and schedules the vchan_complete tasklet to invoke
sprd_complete_tx_dma(). Once the cookie is marked complete,
sprd_dma_tx_status() returns with state.residue =3D=3D 0.

When sprd_stop_tx_dma() sees state.residue =3D=3D 0, it skips the dma_unmap=
_single()
block, calls dmaengine_terminate_all(sp->tx_dma.chn), and clears both
sp->tx_dma.trans_len =3D 0 and sp->tx_flushed =3D false.

If vchan_complete has not yet spliced vc->desc_completed,
sprd_dma_terminate_all() -> vchan_get_all_descriptors() frees the completed
descriptor without calling sprd_complete_tx_dma(), leaking the DMA mapping =
on
sp->tx_dma.phys_addr. If vchan_complete on another CPU has already spliced
vc->desc_completed and sprd_complete_tx_dma() is waiting on port->lock,
sprd_complete_tx_dma() will run after sp->tx_dma.trans_len and sp->tx_flush=
ed
have been cleared (or after a new TX DMA transfer has started), unmapping w=
ith
trans_len =3D=3D 0 or prematurely unmapping and advancing the kfifo for the=
 new
transfer.

> =20
>  static int sprd_tx_buf_remap(struct uart_port *port)
> @@ -273,7 +276,9 @@ static void sprd_complete_tx_dma(void *data)
>  	dma_unmap_single(port->dev, sp->tx_dma.phys_addr,
>  			 sp->tx_dma.trans_len, DMA_TO_DEVICE);
> =20
> -	uart_xmit_advance(port, sp->tx_dma.trans_len);
> +	if (!sp->tx_flushed)
> +		uart_xmit_advance(port, sp->tx_dma.trans_len);
> +	sp->tx_flushed =3D false;
> =20
>  	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
> @@ -555,6 +560,20 @@ static void sprd_stop_tx(struct uart_port *port)
>  	serial_out(port, SPRD_ICLR, iclr);
>  }
> =20
> +static void sprd_flush_buffer(struct uart_port *port)
> +{
> +	struct sprd_uart_port *sp =3D container_of(port, struct sprd_uart_port,
> +						 port);
> +
> +	/*
> +	 * The kfifo has been reset. Let the running transfer finish, so that
> +	 * its buffer is unmapped only once it has stopped, but do not advance
> +	 * the kfifo for it.
> +	 */
> +	if (sp->tx_dma.trans_len)
> +		sp->tx_flushed =3D true;
> +}

[Severity: High]
Can leaving the TX DMA transfer running in sprd_flush_buffer() cause subseq=
uent
writes to overwrite the active DMA buffer in place and transmit post-flush =
data
twice?

In sprd_tx_buf_remap(), TX DMA does not use a separate bounce buffer; it ma=
ps
the kfifo backing buffer (state->port.xmit_buf) directly in place:

drivers/tty/serial/sprd_serial.c:sprd_tx_buf_remap() {
	sp->tx_dma.trans_len =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
			UART_XMIT_SIZE);

	sp->tx_dma.phys_addr =3D dma_map_single(port->dev, tail,
					      sp->tx_dma.trans_len,
					      DMA_TO_DEVICE);

In uart_flush_buffer(), kfifo_reset(&state->port.xmit_fifo) resets both
xmit_fifo.in and xmit_fifo.out to 0 before calling port->ops->flush_buffer(=
),
and then wakes blocked writers via tty_port_tty_wakeup().

If a subsequent uart_write() or uart_put_char() runs while the flushed TX D=
MA
transfer is still in flight, kfifo_in() writes the new bytes into xmit_buf
starting at offset 0, overwriting the DMA_TO_DEVICE region while the DMA
controller is actively reading from it. In sprd_start_tx_dma(), the new wri=
te
then returns early because sp->tx_dma.trans_len is still non-zero:

drivers/tty/serial/sprd_serial.c:sprd_start_tx_dma() {
	if (sp->tx_dma.trans_len)
		return;

When the flushed DMA transfer later finishes, sprd_complete_tx_dma() sees
sp->tx_flushed =3D=3D true and skips uart_xmit_advance(), leaving the newly=
 written
bytes at xmit_fifo.out =3D=3D 0, and then starts a second DMA transfer for =
those
same bytes:

drivers/tty/serial/sprd_serial.c:sprd_complete_tx_dma() {
	if (!sp->tx_flushed)
		uart_xmit_advance(port, sp->tx_dma.trans_len);
	sp->tx_flushed =3D false;
	...
	if (kfifo_is_empty(&tport->xmit_fifo) || sprd_tx_buf_remap(port) ||
	    sprd_tx_dma_config(port))
		sp->tx_dma.trans_len =3D 0;

[Severity: High]
Also in sprd_flush_buffer(), what happens if the port is shut down after
uart_flush_buffer() before the in-flight TX DMA transfer completes (for exa=
mple
during uart_hangup() or close)?

When sprd_flush_buffer() sets sp->tx_flushed =3D true and leaves the transf=
er
running with sp->tx_dma.trans_len > 0, it relies on sprd_complete_tx_dma() =
(or
sprd_stop_tx_dma()) to unmap sp->tx_dma.phys_addr and reset
sp->tx_dma.trans_len and sp->tx_flushed.

However, uart_shutdown() -> uart_port_shutdown() invokes sprd_shutdown() ->
sprd_release_dma() and then frees state->port.xmit_buf in uart_free_xmit_bu=
f():

drivers/tty/serial/sprd_serial.c:sprd_release_dma() {
	sprd_uart_dma_enable(port, false);

	if (sp->rx_dma.enable)
		dma_release_channel(sp->rx_dma.chn);

	if (sp->tx_dma.enable)
		dma_release_channel(sp->tx_dma.chn);

	sp->tx_dma.enable =3D false;
	sp->rx_dma.enable =3D false;
}

In sprd_dma_free_chan_resources(), releasing sp->tx_dma.chn stops the chann=
el
and frees all descriptors without invoking the completion callback. Because
neither sprd_release_dma() nor sprd_startup() unmaps sp->tx_dma.phys_addr or
clears sp->tx_dma.trans_len and sp->tx_flushed, won't xmit_buf be freed whi=
le
still DMA-mapped, and won't stale non-zero sp->tx_dma.trans_len cause
sprd_start_tx_dma() to return early on every write when the port is reopene=
d?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031123911.3784=
690-1-samarth.colleges@gmail.com?part=3D3
