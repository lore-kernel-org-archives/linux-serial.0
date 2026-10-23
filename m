Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743804;
	b=WuoHhpfVK/X9e/FvW0f9PrZ54RFPDjBCKt5Emgguq4W3W64mftf4siGXXtKS8a83m0DR
	 +BjHz5OSurld9fqsQ3T/4LOPlx9njcwMFl/kdcycyHvys5gxWiLRHIma0qU1gPMW5tOR/
	 97I7M+PqtY33GiGeDSyKPwNLNbthb6DPqYWKrbsAVk4b226Ry7YPCWvz6TvNRXBIdr4Lq
	 63W5jmgNxwjIqPyv/GNC5DUsslyfpFNbqJSgDzJFhJFysqNcFSCYzQaqxkE4shbsI6bCy
	 kuKKpeMR+AS49xW+WZFMDTJXjvXAdzPLNWXDuO4uHrrIn0a/gVL+spzsRm7dZQe+EsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0GfKVk/RJOC9pOzChhirBkeqLeJZ9TV7pnSiNJChoHo=;
	b=cnkxASVeFgY/eeFtg1AeBzmbISr0Jgcx417nPOK3wge/ylaAinWymYLPcTBt/AJE/ej8
	 1UcsWFnhSNjP2b+8c9xdAz+gWNvzvE0nwvKbOlhWiZ/rJfCBsXSUzwCkkpoOYbuiTHKJS
	 Otk5S9t8mJDVAhpG/QLKNEUO0QMn+IEi3GvTJAe6EBDYkUWStyVZkNvibavCDhe2BnGWW
	 uHD5hq6PRsmPdbvLoemioQ0Q+1wyEjcmu0fOIZypCTwrrtx5OmmXg3JZLoMiO0vNTEOID
	 FoSaNb45NV5IAjemAbeErKPtk098QuqONyqgJYOyKo69/U2ZczyPTX8Bqt5s8uOGFaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnlpa3rM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF4606A31D;
	Fri, 23 Oct 2026 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnlpa3rM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DEF1F01825;
	Fri, 23 Oct 2026 08:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743804;
	bh=0GfKVk/RJOC9pOzChhirBkeqLeJZ9TV7pnSiNJChoHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gnlpa3rMnlRXcaZ+hpAGQAgQAk3/GQV/xPsDRvSL3AZzTrwsTMjaYvjV3CHuLq/YF
	 8a4lFhW87yBYAIeQK+kU9XFC4WCUlDJFqeYywOetKDT3UBz4RbZAtf6TSSZZDOJQJd
	 8yV1lukXk/oOGim6nEkM1WKGoFRCLLx+siS2A4HIuUJk/sUonD97R6YV4eaDmHoocJ
	 uBownCZEtd5h9JybrMxYBgscEzNRWKGQIBA1taxLeU1XlSIMsDewqYRJYcq+b3sTjx
	 6yb6VhNu0WNQsOEdb/XEyWmjHi/UqLw8yxlwFHmqF7BIQQZ8LuCN58fv4OzeJ7/2ld
	 RoyaPK1Qaw+Fw==
Message-ID: <sashiko-outbox-182506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] serial: 8250_dw: configure the Allwinner H616 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261023-submit-h616-uart-fifo-v1-v1-2-e4a3bae2eba8@gmail.com>
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
 <20261023-submit-h616-uart-fifo-v1-v1-2-e4a3bae2eba8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:23:23 +0000
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
- [High] serial: 8250_dw: broken H616 RX DMA due to deferred sun6i_dma_issu=
e_pending()
- [High] serial: 8250_dw: missing UART_CAP_AFE in UART_PORT_DW_APB_256 brea=
ks CRTSCTS
--

commit 7b1955806965488d36d1ed6fbef81df345079c9d
Author: James Hilliard <james.hilliard1@gmail.com>

serial: 8250_dw: configure the Allwinner H616 UART

This patch adds a fixed 256-byte FIFO port configuration for the Allwinner
H616 UART, skips optional register probing, sets the SKIP_SET_RATE quirk, a=
nd
attaches 8250 DMA with single-byte burst sizes during probe.

> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index eca02e8bd6d13..f03051740be0a 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c

[ ... ]

> @@ -765,14 +780,21 @@ static int dw8250_probe(struct platform_device *pde=
v)
> =20
>  	dw8250_setup_dma_filter(p, data);
> =20
> -	if (!data->skip_autocfg)
> -		dw8250_setup_port(p);
> -
> -	/* If we have a valid fifosize, try hooking up DMA */
> -	if (p->fifosize) {
> -		data->data.dma.rxconf.src_maxburst =3D p->fifosize / 4;
> -		data->data.dma.txconf.dst_maxburst =3D p->fifosize / 4;
> +	if (data->pdata && data->pdata->type) {
> +		dw8250_setup_port_fixed(up, data->pdata->type);
> +		data->data.dma.rxconf.src_maxburst =3D data->pdata->dma_maxburst;
> +		data->data.dma.txconf.dst_maxburst =3D data->pdata->dma_maxburst;
>  		up->dma =3D &data->data.dma;

[Severity: High]
Will attaching the standard 8250 RX DMA path here work with the Allwinner
sun6i-dma controller, or does it cause RX DMA transfers to be immediately
aborted and leave RX DMA wedged?

When UART_IIR_RDI fires, serial8250_interrupt() loops in hardirq context:

drivers/tty/serial/8250/8250_core.c:serial8250_interrupt() {
	l =3D i->head;
	do {
		struct uart_8250_port *up =3D list_entry(l, struct uart_8250_port, list);
		struct uart_port *port =3D &up->port;

		if (port->handle_irq(port)) {
			handled =3D 1;
			end =3D NULL;
		} else if (end =3D=3D NULL)
			end =3D l;
		...
	} while (l !=3D end);
}

On the first pass, dw8250_handle_irq() -> serial8250_handle_irq_locked() ->
handle_rx_dma() sees !up->dma->rx_running and breaks out to call
serial8250_rx_dma(), which sets dma->rx_running =3D 1 and calls
dma_async_issue_pending(dma->rxchan) without masking UART_IER_RDI or draini=
ng
the RX FIFO:

drivers/tty/serial/8250/8250_port.c:handle_rx_dma() {
	switch (iir & 0x3f) {
	case UART_IIR_RDI:
		if (!up->dma->rx_running)
			break;
		fallthrough;
	case UART_IIR_RLSI:
	case UART_IIR_RX_TIMEOUT:
		serial8250_rx_dma_flush(up);
		return true;
	}
	return up->dma->rx_dma(up);
}

Unlike DMA controllers that start transfers synchronously in
device_issue_pending, sun6i_dma_issue_pending() defers physical channel
allocation and hardware transfer start to a softirq tasklet:

drivers/dma/sun6i-dma.c:sun6i_dma_issue_pending() {
	if (vchan_issue_pending(&vchan->vc)) {
		spin_lock(&sdev->lock);

		if (!vchan->phy && list_empty(&vchan->node)) {
			list_add_tail(&vchan->node, &sdev->pending);
			tasklet_schedule(&sdev->task);
			...
		}

		spin_unlock(&sdev->lock);
	}
}

Because serial8250_interrupt() is running in hardirq context, the tasklet
cannot run before serial8250_interrupt() immediately executes a second pass
on the port. Since no bytes have been read from the RX FIFO and UART_IER_RDI
is still enabled, UART_IIR still reports UART_IIR_RDI. On this second pass,
handle_rx_dma() sees up->dma->rx_running =3D=3D 1 and calls
serial8250_rx_dma_flush(up), which pauses and terminates the DMA transfer t=
hat
was just queued.

Furthermore, inside serial8250_rx_dma_flush() -> __dma_rx_complete(),
sun6i_dma_tx_status() returns DMA_IN_PROGRESS even after dmaengine_pause(),
causing __dma_rx_complete() to return early without clearing dma->rx_running
or copying any received bytes before dmaengine_terminate_async() discards t=
he
descriptor:

drivers/tty/serial/8250/8250_dma.c:__dma_rx_complete() {
	dma_status =3D dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
	if (dma_status =3D=3D DMA_IN_PROGRESS)
		return;
}

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index db066a42f61d2..e99d35880a689 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -335,6 +335,14 @@ static const struct serial8250_config uart_config[] =
=3D {
>  		.rxtrig_bytes	=3D {1, 4},
>  		.flags		=3D UART_CAP_FIFO,
>  	},
> +	[UART_PORT_DW_APB_256] =3D {
> +		.name		=3D "DW APB UART 256",
> +		.fifo_size	=3D 256,
> +		.tx_loadsz	=3D 256,
> +		.fcr		=3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
> +		.rxtrig_bytes	=3D {1, 64, 128, 254},
> +		.flags		=3D UART_CAP_FIFO | UART_CAP_NOTEMT,
> +	},

[Severity: High]
Should uart_config[UART_PORT_DW_APB_256].flags also include UART_CAP_AFE?

In dw8250_probe(), dw8250_quirks() sets p->set_termios =3D dw8250_do_set_te=
rmios.
When CRTSCTS is enabled, dw8250_do_set_termios() unconditionally sets
UPSTAT_AUTOCTS, which tells serial_core to disable software CTS flow contro=
l:

drivers/tty/serial/8250/8250_dwlib.c:dw8250_do_set_termios() {
	p->status &=3D ~UPSTAT_AUTOCTS;
	if (termios->c_cflag & CRTSCTS)
		p->status |=3D UPSTAT_AUTOCTS;

	serial8250_do_set_termios(p, termios, old);
}

However, serial8250_do_set_termios() -> serial8250_set_afe() only enables
hardware auto flow control (UART_MCR_AFE) if UART_CAP_AFE is set in
up->capabilities:

drivers/tty/serial/8250/8250_port.c:serial8250_set_afe() {
	if (!(up->capabilities & UART_CAP_AFE))
		return;

	up->mcr &=3D ~UART_MCR_AFE;
	if (termios->c_cflag & CRTSCTS)
		up->mcr |=3D UART_MCR_AFE;
}

Because dw8250_setup_port_fixed() bypasses dw8250_setup_port(),
up->capabilities is populated solely from
uart_config[UART_PORT_DW_APB_256].flags. Without UART_CAP_AFE, enabling
CRTSCTS on H616 UARTs (such as Bluetooth HCI UARTs using uart-has-rtscts)
disables software CTS flow control without enabling hardware auto flow cont=
rol
in UART_MCR.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-h61=
6-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com?part=3D2
