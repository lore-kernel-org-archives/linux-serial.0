Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4B3E716F
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035670; cv=none; b=qeyDke0LIQ4jnbwkKlGx9Dl9cWGjEUIDHzBe4MyEgsf6js2HDiEs/9enyD1klh2bthy+Z4n0nZBhXaxXeYzcz8F6TFZDImiEVEukDmiVygrAiWDPvH7TuuwuXaBrpQL2YEu397KEn5Hgmu0UM8KCzfJj9S+IVWEhd2nqZ12jVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035670; c=relaxed/simple;
	bh=5KMq/Qi4ri/QizCnLx/Efwx6ALnG2ufPFvD/XiLskCY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gXt9Zhapp+ZfNf7pm4iFc+oQe8+kferp/qNIVFVdG1osM6wHmeU8EQ525X9fO3TaAW2xwNttnTcGVhSeNkldF/3esxGiwEi2WYQJRTSfSkm6OpcqaLhJkNXibrbsInSiaLkEfNNkmTOHMLZcL3uNy55znLwkIGeKWLP0wxVozj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovQ1eJ8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovQ1eJ8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16AA1F000C4;
	Thu, 15 Oct 2026 03:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035661;
	bh=6ntNcrsiaoE1wy/NXizsk8nGEgSpxyHKUKH/xmbwexM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ovQ1eJ8/hofCjjIHaD5U9Nm4LbY+Vr3VMeM/L/V5zJLYUySVM39BYwhc7XOYErfZR
	 LNElT3eHcGv47UkSE4QI+1gN/GAW4SLy7ED2F6YzXse2b5ZkjMKNjDO/al90FNBYyz
	 IHKho6Ra3SZXAHWSyi+cmU+saTtQBnQuv/SZhJfYgbXYCbxw0Iqtj8uM8SZQM1Kl/R
	 ltI0RsQOu9pN9LBARgKoHH9i9InfikIvg9j9DaJb69x65v0Pk04r4gQ420RBPe+Wkp
	 OSrWTgnqy48KCC5efM1aUzw5JEZUVmYTCSBcKBI2+vgLklP8a0k0IrptDu1GFSX0op
	 bE8kR3z1716Cg==
Message-ID: <sashiko-outbox-172211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] serial: tegra: fix TX DMA descriptor
 use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Austin Schlegel" <schlegelas@outlook.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261014-serial-tegra-dma-uaf-v2-2-b142b31b67e3@outlook.com>
References: <20261014-serial-tegra-dma-uaf-v2-0-b142b31b67e3@outlook.com>
 <20261014-serial-tegra-dma-uaf-v2-2-b142b31b67e3@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:41:01 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] serial: tegra: UAF and double xmit advance in tx_dma_complete
- [High] serial: tegra: UAF in tegra_uart_stop_tx() due to stale tx_in_prog=
ress after flush
--

commit 7f4e5d2d923132e41e93a227ae34dba2a8eda9f6
Author: Austin Schlegel <schlegelas@outlook.com>

serial: tegra: fix TX DMA descriptor use-after-free

This patch moves async_tx_ack() before dmaengine_terminate_all() in
tegra_uart_stop_tx() to prevent a use-after-free when the DMA descriptor is
immediately freed by the termination.

> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index a23a92cebe0df..306a38b2fb1e7 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -639,9 +639,9 @@ static void tegra_uart_stop_tx(struct uart_port *u)
> =20
>  	dmaengine_pause(tup->tx_dma_chan);
>  	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
> +	async_tx_ack(tup->tx_dma_desc);

[Severity: High]
Does this create a use-after-free if tegra_uart_flush_buffer() runs first?

If tegra_uart_flush_buffer() is called via the TCFLSH ioctl, it terminates
the DMA channel and frees the descriptor:

drivers/tty/serial/serial-tegra.c:tegra_uart_flush_buffer() {
	...
	if (tup->tx_dma_chan)
		dmaengine_terminate_all(tup->tx_dma_chan);
}

But it fails to clear tup->tx_in_progress. If tegra_uart_stop_tx() is then
called, it bypasses the tx_in_progress check and calls async_tx_ack() on
the freed tx_dma_desc.

>  	dmaengine_terminate_all(tup->tx_dma_chan);

[Severity: High]
Can this termination race with tegra_uart_tx_dma_complete() and cause a UAF
and double accounting?

tegra_uart_tx_dma_complete() runs asynchronously and accesses tup->tx_dma_d=
esc
outside of the UART port lock:

drivers/tty/serial/serial-tegra.c:tegra_uart_tx_dma_complete() {
	...
	async_tx_ack(tup->tx_dma_desc);
	uart_port_lock_irqsave(&tup->uport, &flags);
	uart_xmit_advance(&tup->uport, count);
	...
}

tegra_uart_stop_tx() runs under the port lock and terminates the DMA channe=
l,
which immediately frees the descriptor. If tegra_uart_stop_tx() runs
concurrently after tegra_uart_tx_dma_complete() starts but before it acquir=
es
the lock, the completion callback will trigger a use-after-free on the
descriptor.

Furthermore, both functions calculate count and advance the FIFO. If they
race, tegra_uart_tx_dma_complete() will blindly call uart_xmit_advance() a
second time inside the lock, skipping untransmitted characters and corrupti=
ng
the ring buffer state.

>  	count =3D tup->tx_bytes_requested - state.residue;
> -	async_tx_ack(tup->tx_dma_desc);
>  	uart_xmit_advance(&tup->uport, count);
>  	tup->tx_in_progress =3D 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-serial-teg=
ra-dma-uaf-v2-0-b142b31b67e3@outlook.com?part=3D2
