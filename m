Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451313;
	b=vEvIdug2BoJ4UvAqWmn3s+skz0NPofTlMI+qG5p2kJ2EUP1SGrZLBAcsUEkbMyrxdFtX
	 V7Hj/TEQ1xxPHeJcYY/z9t72kZspkCFEI7v0LZusAgPpE6h3Vlil3drkj7WwIczFTkjtL
	 /bJ24lQE2AIxiTk4VXmKZlWeHq+xgpc8ZgvlBLNDoDZetcRdItsJxTVCsY70a8AP0wNxJ
	 uGXZGalFc50j2cROcfTU/BeDN9y1nYjSCV780bhWwJfqxvcvBSgSjYwfphdoByvVoZFiw
	 QVTt7Tw+teqHVfwZe7Qa2il9fQbkyCYxk4dKUreIX1aheXJA6Fad+RmInfbXvK5CS/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451313;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4X/JayQXFDajtZWoFXQPHkzngzGnHN5JocGWfUBB6U0=;
	b=hQSFuP/VZe5pva/jjV149P6a8ZhI5h9IkYYausZ5gAmH+nBfXXcjCqyZ/Pya/44F+aBe
	 jPYH/7OtndeFwg+dNcEnH2PWIn4S6r7scnIvIEtMh9tj/5C3Y5Q4KYMI4sT6onUSxBk9l
	 k9m5buhbfd95UXczM/H3UMO9X8h5IWqI77aBLMVmz8HRMtLvhc0uSQSp/OOOi23DrTOpx
	 WRIhSz0d4Zg5WUgw0vIN5IpBmDrt6MHsWNvTk+pFoGN17wo/xyag0k0EvKZAczvLTYrnf
	 1KUmF5iZg6kBQPCVIcPdPNk3J1itRx8pa04WV99+LKW48KDwyMU2zaUzmeLtCEp2EQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j99uCFQq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54547606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j99uCFQq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32EB1F000C1;
	Sat, 31 Oct 2026 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793451313;
	bh=4X/JayQXFDajtZWoFXQPHkzngzGnHN5JocGWfUBB6U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j99uCFQqIJHkqFrdUhZS9D3QQ+P981NkEV2mSp0EEJeQtVTHc2ZCvam4BCUhYQu7X
	 7tXfX/tW3ODMcTymszgR3MbHbPL4p2dR0Sz0+mUyUppFoS4kCa0X4dISkCXYJuUX7y
	 lwUQbFS/3gEuP3JijC34AskDeP1xW4UqWCKEdnK+F+ZbjP/6TvHOMU5MkxY0ZBO2Gz
	 SyBHsaIa3RhJKmbIn9rI6Y2lUSXz4afANGOUguEpw3aEsX5ucDLTyUGPaf9FV8yv07
	 jmjPpsPG2gRMX95DN/seuWRaF4Q8nec4nU0cpCaMhBp8GcrNzzXfmxLTy35ww+7LWG
	 sNfxmdRW2JeHQ==
Message-ID: <sashiko-outbox-191948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] serial: tegra: don't advance the TX kfifo for a
 flushed transfer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samarth Narang" <samarth.colleges@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031123911.3784690-3-samarth.colleges@gmail.com>
References: <20261031004733.3345841-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-3-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 12:55:12 +0000
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
- [High] serial: tegra: tx_in_progress ABA race in tegra_uart_tx_dma_comple=
te()
- [Medium] serial: tegra: missing async_tx_ack() in tegra_uart_flush_buffer=
()
--

commit 1c08600f3e0cb4a1f9dcd1d5048434c3f968101c
Author: Samarth Narang <samarth.colleges@gmail.com>

serial: tegra: don't advance the TX kfifo for a flushed transfer

This commit clears tx_in_progress in tegra_uart_flush_buffer() and checks
whether tx_in_progress is still TEGRA_UART_TX_DMA in
tegra_uart_tx_dma_complete() before advancing the transmit kfifo. This aims
to prevent an in-flight DMA completion callback from advancing a reset
kfifo after a flush or stop_tx.

> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index b0fc4ae3686f8..8b712a9bc293e 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -537,6 +537,11 @@ static void tegra_uart_tx_dma_complete(void *args)
>  	count =3D tup->tx_bytes_requested - state.residue;
>  	async_tx_ack(tup->tx_dma_desc);
>  	uart_port_lock_irqsave(&tup->uport, &flags);
> +	/* Already retired by stop_tx or flush_buffer */
> +	if (tup->tx_in_progress !=3D TEGRA_UART_TX_DMA) {
> +		uart_port_unlock_irqrestore(&tup->uport, flags);
> +		return;
> +	}

[Severity: High]
Can this still race if a new TX DMA transfer is started before
tegra_uart_tx_dma_complete() acquires tup->uport.lock?

In tegra_uart_tx_dma_complete(), dmaengine_tx_status(), count, and
async_tx_ack() run before uart_port_lock_irqsave():

drivers/tty/serial/serial-tegra.c:tegra_uart_tx_dma_complete() {
	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
	count =3D tup->tx_bytes_requested - state.residue;
	async_tx_ack(tup->tx_dma_desc);
	uart_port_lock_irqsave(&tup->uport, &flags);
	/* Already retired by stop_tx or flush_buffer */
	if (tup->tx_in_progress !=3D TEGRA_UART_TX_DMA) {
		uart_port_unlock_irqrestore(&tup->uport, flags);
		return;
	}
	uart_xmit_advance(&tup->uport, count);
	tup->tx_in_progress =3D 0;

If tegra_uart_flush_buffer() or tegra_uart_stop_tx() runs while
tegra_uart_tx_dma_complete() for a first transfer is already executing or
waiting on tup->uport.lock, it clears tup->tx_in_progress =3D 0 and releases
the port lock. Because tup->tx_in_progress is now 0 (and kfifo_reset() in
uart_flush_buffer() resets the kfifo tail to 0, which is aligned), a
subsequent uart_write() -> tegra_uart_start_tx() ->
tegra_uart_start_next_tx() -> tegra_uart_start_tx_dma() can acquire
tup->uport.lock first, start a second DMA transfer, overwrite
tup->tx_dma_desc, tup->tx_bytes_requested, and tup->tx_cookie, and set
tup->tx_in_progress back to TEGRA_UART_TX_DMA.

When the first transfer's tegra_uart_tx_dma_complete() then takes
tup->uport.lock, tup->tx_in_progress =3D=3D TEGRA_UART_TX_DMA is true again:

1. If the callback computed count from the first transfer before the second
transfer started, it calls uart_xmit_advance() with the first transfer's
count on the second transfer's kfifo (which can still underflow xmit_fifo
if the first transfer was larger than the newly queued data), clears
tup->tx_in_progress =3D 0 while the second transfer is active in hardware,
and calls tegra_uart_start_next_tx().

2. If the unlocked preamble in tegra_uart_tx_dma_complete() runs
concurrently with or after tegra_uart_start_tx_dma(), it reads the second
transfer's tup->tx_cookie, tup->tx_bytes_requested, and tup->tx_dma_desc
(or a torn mix of both transfers), acknowledging and retiring the second
transfer while it is still DMA_IN_PROGRESS.

By comparison, tegra_uart_rx_dma_complete() acquires tup->uport.lock before
calling dmaengine_tx_status() and bails out when status =3D=3D DMA_IN_PROGR=
ESS:

drivers/tty/serial/serial-tegra.c:tegra_uart_rx_dma_complete() {
	uart_port_lock_irqsave(u, &flags);

	status =3D dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);

	if (status =3D=3D DMA_IN_PROGRESS) {
		dev_dbg(tup->uport.dev, "RX DMA is in progress\n");
		goto done;
	}

Should tegra_uart_tx_dma_complete() similarly take tup->uport.lock before
querying dmaengine_tx_status() and accessing tup->tx_cookie,
tup->tx_bytes_requested, and tup->tx_dma_desc, and check for
DMA_IN_PROGRESS?

> @@ -1276,6 +1281,9 @@ static void tegra_uart_flush_buffer(struct uart_por=
t *u)
>  	tup->tx_bytes =3D 0;
>  	if (tup->tx_dma_chan)
>  		dmaengine_terminate_all(tup->tx_dma_chan);
> +	/* The kfifo has been reset: the completion must not advance it */
> +	if (tup->tx_in_progress =3D=3D TEGRA_UART_TX_DMA)
> +		tup->tx_in_progress =3D 0;

[Severity: Medium]
Does clearing tup->tx_in_progress in tegra_uart_flush_buffer() without
calling async_tx_ack(tup->tx_dma_desc) leave the aborted TX DMA descriptor
unacknowledged on tegra20-apb-dma?

In tegra_uart_start_tx_dma(), tup->tx_dma_desc is prepared with
DMA_PREP_INTERRUPT and without DMA_CTRL_ACK:

	tup->tx_dma_desc =3D dmaengine_prep_slave_single(tup->tx_dma_chan,
				tx_phys_addr, tup->tx_bytes, DMA_MEM_TO_DEV,
				DMA_PREP_INTERRUPT);

When tegra_uart_flush_buffer() calls dmaengine_terminate_all(),
tegra_dma_terminate_all() in drivers/dma/tegra20-apb-dma.c moves the
descriptor to tdc->free_dma_desc without invoking the completion callback.
Previously, a subsequent tegra_uart_stop_tx() saw tup->tx_in_progress =3D=3D
TEGRA_UART_TX_DMA and called async_tx_ack(tup->tx_dma_desc), but with
tegra_uart_flush_buffer() setting tup->tx_in_progress =3D 0, neither
tegra_uart_stop_tx() nor tegra_uart_tx_dma_complete() will acknowledge it.

Because tegra_dma_desc_get() only reuses descriptors on tdc->free_dma_desc
when async_tx_test_ack(&dma_desc->txd) is true:

drivers/dma/tegra20-apb-dma.c:tegra_dma_desc_get() {
	/* Do not allocate if desc are waiting for ack */
	list_for_each_entry(dma_desc, &tdc->free_dma_desc, node) {
		if (async_tx_test_ack(&dma_desc->txd) && !dma_desc->cb_count) {
			list_del(&dma_desc->node);
			spin_unlock_irqrestore(&tdc->lock, flags);
			dma_desc->txd.flags =3D 0;
			return dma_desc;
		}
	}

won't each flushed TX DMA transfer leave an unacknowledged tegra_dma_desc
stranded on tdc->free_dma_desc until the port is shut down? Also, since
tegra186-gpc-dma frees the descriptor inside dmaengine_terminate_all(),
should async_tx_ack(tup->tx_dma_desc) be called before
dmaengine_terminate_all(tup->tx_dma_chan) when tup->tx_in_progress =3D=3D
TEGRA_UART_TX_DMA?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031123911.3784=
690-1-samarth.colleges@gmail.com?part=3D2
