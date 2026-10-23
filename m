Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744364;
	b=FSVf/s6cV/3sQ3fgC8DXmxr3AYBIPvObFpgwo1uaxFtdv9kMI59xsOLZKHA3+62vK812
	 Ku7IGtlcGYN1w3ZJSZk1Nv/7FRAFF/ts8fMLYImYsVf9voFMmLcTQlqy909O3ElkZDRQG
	 tz5jqaVQZynFVkwuQ1wyGuvGZ/8zUc5yT/h4jM1xfV4ArzggEAknMfg4dWyOl/F/PGP5d
	 BQb6qS6YFu1dfAQC2nFjgKB/KfCaSviCBuM6Zp8VElHabYux8ls351PUUdrrv4kwMzRRC
	 laSavalVy7rjcE05Cs/GCP/hvbHsJfduhVG3eaxjymwh0pzmAO7k96j49+5akYWnFLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744364;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5urQ3KExm5E/94pME9nAFkLY0Lo7S5FkMJrAZSkEYVo=;
	b=yc4iTMRmRUjwR0QIsqPeXhssPYe36PLr+0bD/4/haxiv0wCSYsCiBnZ2hfFZ5tmspFy2
	 Is4QkIg0TsV1BoNABQFujAcctq1FX7JNakH6Y0XqQ9wZexHvs5T9F4lgbn2Xfq6tFxFDA
	 aKdhvrAiJrmuJmpFvFcoNLiYmIgcrhoy9zsMmlgVctI/WlvOO1mJ/cZsnbNapZg7s29nl
	 gxbNHa7CmM2j9WT00+noVj/smDvWT9OZCfpHGG+cdSNJV17rlHNYqDjYE5my8KKph8qcb
	 kP9YKsFjGrc5sQsv7AptNFXCuvunw9iRh/+t16/VY6PUZYJMivl0B+C8uoSG1Yg9gLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVzPeORZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F834606A31B;
	Fri, 23 Oct 2026 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVzPeORZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0721F01825;
	Fri, 23 Oct 2026 08:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792744363;
	bh=5urQ3KExm5E/94pME9nAFkLY0Lo7S5FkMJrAZSkEYVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nVzPeORZ00tviU8Uh5SfYG36gHStp+6AMxNFQRgDIRAJs2jWmdXhMejhzay0A6EjE
	 8OC7nrdaY5DbrQRlfauU+Pl5zgJLUqEXc/3HSl0VzDOKnfD9gvYF7SCio4fA6TFTpz
	 XTZbKTh9Z32+rAPcNagywm37arYdsEv6NTzTXck4arqf0/eYCHKOqTZvacbxJXE4N+
	 ceQtCPrqehvW/R+i6YzFxD3U2CBZjmrmmeBiN/7hAvsPn+GYRmkEOzOvQlrLhRxB5i
	 suSz9xLZnwXPYGHA0+vVTYZfgrGOZSHbvcuUCKQRd/0UDJ5KJzJCrWJplhNXng5SyM
	 7tNsv8w1YrnLQ==
Message-ID: <sashiko-outbox-182520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: h616: identify the UART
 integration
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261023-submit-h616-uart-fifo-v1-v1-3-e4a3bae2eba8@gmail.com>
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
 <20261023-submit-h616-uart-fifo-v1-v1-3-e4a3bae2eba8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:32:42 +0000
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
- [High] arm64: dts: allwinner: h616: enabling UART RX DMA on sun6i-dma los=
es RX data
--

commit 3bfb41f1bb740f4fc20f5b9cb7ef6f35cf6c4504
Author: James Hilliard <james.hilliard1@gmail.com>

arm64: dts: allwinner: h616: identify the UART integration

This commit updates the UART0 through UART5 nodes in sun50i-h616.dtsi to
use the "allwinner,sun50i-h616-uart" compatible string with
"snps,dw-apb-uart" as a fallback so the driver selects the H616 256-byte
FIFO configuration and register layout.

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h616.dtsi
> index 1598e86259ab5..6905c9eaa2493 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -538,7 +538,7 @@ mmc2: mmc@4022000 {
>  		};
> =20
>  		uart0: serial@5000000 {
> -			compatible =3D "snps,dw-apb-uart";
> +			compatible =3D "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";

[Severity: High]
Could switching uart0 through uart5 to "allwinner,sun50i-h616-uart" cause RX
data loss and wedge RX DMA on non-console H616 UART ports when paired with
their existing dmas properties referencing sun6i-dma?

Previously, matching "snps,dw-apb-uart" caused dw8250_setup_port() to read
DW_UART_CPR as 0, leaving p->fifosize =3D=3D 0 and up->dma =3D=3D NULL. Mat=
ching
"allwinner,sun50i-h616-uart" selects dw8250_h616_data in dw8250_probe(),
which attaches 8250 DMA to the port:

drivers/tty/serial/8250/8250_dw.c:dw8250_probe() {
	...
	if (data->pdata && data->pdata->type) {
		dw8250_setup_port_fixed(up, data->pdata->type);
		data->data.dma.rxconf.src_maxburst =3D data->pdata->dma_maxburst;
		data->data.dma.txconf.dst_maxburst =3D data->pdata->dma_maxburst;
		up->dma =3D &data->data.dma;
	}
	...
}

Because uart0 through uart5 in arch/arm64/boot/dts/allwinner/sun50i-h616.dt=
si
already specify dmas =3D <&dma ...> and dma-names =3D "tx", "rx" pointing to
"allwinner,sun50i-h616-dma" (handled by drivers/dma/sun6i-dma.c), opening a=
ny
non-console UART calls serial8250_request_dma() and enables 8250 RX DMA.

First, when serial8250_rx_dma_flush() runs (for example on
UART_IIR_RX_TIMEOUT, UART_IIR_RDI, UART_IIR_RLSI, or dw8250_idle_enter()), =
it
pauses the channel, calls __dma_rx_complete(), and then terminates the
channel:

drivers/tty/serial/8250/8250_dma.c:serial8250_rx_dma_flush() {
	...
	dmaengine_pause(dma->rxchan);
	__dma_rx_complete(p);
	dmaengine_terminate_async(dma->rxchan);
}

In __dma_rx_complete(), dmaengine_tx_status() is checked and returns early =
if
the status is DMA_IN_PROGRESS:

drivers/tty/serial/8250/8250_dma.c:__dma_rx_complete() {
	...
	dma_status =3D dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
	if (dma_status =3D=3D DMA_IN_PROGRESS)
		return;

	count =3D dma->rx_size - state.residue;

	tty_insert_flip_string(tty_port, dma->rx_buf, count);
	p->port.icount.rx +=3D count;
	dma->rx_running =3D 0;
}

However, in drivers/dma/sun6i-dma.c, sun6i_dma_tx_status() returns the value
of dma_cookie_status() (DMA_IN_PROGRESS) directly and never returns
DMA_PAUSED even after sun6i_dma_pause() has paused the channel:

drivers/dma/sun6i-dma.c:sun6i_dma_tx_status() {
	...
	ret =3D dma_cookie_status(chan, cookie, state);
	if (ret =3D=3D DMA_COMPLETE || !state)
		return ret;
	...
	dma_set_residue(state, bytes);

	return ret;
}

As a result, __dma_rx_complete() returns early without pushing the
transferred bytes (dma->rx_size - state.residue) to the TTY flip buffer and
without clearing dma->rx_running =3D 0. Then dmaengine_terminate_async() fr=
ees
the descriptor via sun6i_dma_terminate_all() so the completion callback
dma_rx_complete() never runs, discarding the received bytes and leaving
dma->rx_running stuck at 1.

Second, when UART_IIR_RDI triggers handle_rx_dma() -> serial8250_rx_dma() in
hardirq context, sun6i_dma_issue_pending() does not start a physical DMA
channel immediately; it only queues the virtual channel on sdev->pending and
schedules sdev->task:

drivers/dma/sun6i-dma.c:sun6i_dma_issue_pending() {
	...
	if (vchan_issue_pending(&vchan->vc)) {
		spin_lock(&sdev->lock);

		if (!vchan->phy && list_empty(&vchan->node)) {
			list_add_tail(&vchan->node, &sdev->pending);
			tasklet_schedule(&sdev->task);
	...
}

Since serial8250_rx_dma() neither masks UART_IER_RDI nor drains UART_RX, wo=
n't
the level-high UART interrupt (IRQ_TYPE_LEVEL_HIGH) remain asserted and
immediately re-enter handle_rx_dma() with UART_IIR_RDI and
up->dma->rx_running =3D=3D 1 before sun6i_dma_tasklet() can run, flushing a=
nd
terminating the newly queued RX DMA transfer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-h61=
6-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com?part=3D3
