Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64BD3B42EB
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165649; cv=none; b=hxYrUzISDm2lPxWyuoI3F7REtekYyWPjyGK0+3HKaYv5yph2hwyfIvf9wBtPNuUB9PDnLkzwCzGhqx+/gLMKxf6tmmj1hg9kM+ld5wleLPWz6aaLB1/Ym989VN1+qbcdWy1LNof+qay01+5sgsTyfIYLsv99itvDPBwZdUNPFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165649; c=relaxed/simple;
	bh=uQNylpfckg98WsIrE5gf1EnFqGBO95QesgEqqvUWTb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uVKfBT+mwpUoymAbZ27opFY4Z5yUJ9efziOQIxE99cu9/qrc3Cwg3yQmhd7JeR91H9CaZQ3DjSidouNdjZzvaRsrriLAELIX6OTMly4AKG/LRAc5jH9Y7OyrxcT8NUXBGNbMKru0KCR/q64Crazb8S7BP2VOK2mfJKa+uTbivYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1/rTIDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1/rTIDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451A81F000E9;
	Mon, 31 Aug 2026 08:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788165647;
	bh=/2yvQKvGtnPcE6yHFMzenj1A8Jjkpw7vGvWG9c0mB/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d1/rTIDtGTnvmPNQo045lqcT+ClimYq+mAx7qzCFJ/eSfCnFB7wgcPawDUUW4NvGl
	 wqs1ZQZiQklhlw4JqxmrsQjjlwbUwx6HzHl+pGeNbR2OIxXvbCRRnJooHeQZQASLXL
	 BxPC7taVEUxy6lZ0HF2NtjLx/HbKE0iMzFWlmikHu2hYGrIvGpRentHKIpPMdMtNdM
	 2cusgbO/XRzQATclb6jaVCtwoWOo0F/VWdztHiA3YsY7pr47EyQhSNG5QBRx4kqL1P
	 /6tNGjjZH0XFyEFQ/RwXtGtBCqKKmxT3OnP3OuxQiNww3qgCsvhIZX2wcNxBH3HlST
	 +0d4Jb+BfGKCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] serial: core: replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260831-tty-v2-2-88cd58c3c640@kernel.org>
References: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
 <20260831-tty-v2-2-88cd58c3c640@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:40:46 +0000
Message-Id: <20260831084047.451A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Replacing get_zeroed_page() with kzalloc(PAGE_SIZE) drops the =
page-alignment guarantee, breaking UART drivers that map xmit_buf for DMA.
--

commit 1bc591e29475edce55380edd521d83cecd0b99ca
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

serial: core: replace get_zeroed_page() with kzalloc()

This commit replaces the buddy allocator get_zeroed_page() with
kzalloc(PAGE_SIZE) for allocating the serial port transmit buffer. It also
updates the variable type from unsigned long to a pointer to avoid casts.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 95774b0f1484b..a72fe14f76771 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
[ ... ]
> @@ -247,29 +247,29 @@ static int uart_alloc_xmit_buf(struct tty_port *por=
t)
>  	struct uart_state *state =3D container_of(port, struct uart_state, port=
);
>  	struct uart_port *uport;
>  	unsigned long flags;
> -	unsigned long page;
> +	u8 *buf;
> =20
>  	/*
>  	 * Initialise and allocate the transmit and temporary
>  	 * buffer.
>  	 */
> -	page =3D get_zeroed_page(GFP_KERNEL);
> -	if (!page)
> +	buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: Critical]
Will this alignment change break UART drivers that map xmit_buf for DMA?

When SLUB debugging (redzoning) or KASAN is enabled, kzalloc(PAGE_SIZE)
returns a buffer that is offset by metadata and no longer page-aligned.
Several drivers appear to rely on the page alignment guarantee of
get_zeroed_page().

For example, atmel_prepare_tx_dma() explicitly asserts page alignment and
will panic:

drivers/tty/serial/atmel_serial.c:atmel_prepare_tx_dma() {
        ...
        BUG_ON(!PAGE_ALIGNED(tport->xmit_buf));
        ...
}

Additionally, dma_handle_tx() in pch_uart.c assumes page alignment during
the DMA scatterlist mapping and address calculation:

drivers/tty/serial/pch_uart.c:dma_handle_tx() {
        ...
        sg_set_page(sg, virt_to_page(tport->xmit_buf),
                    rem, fifo_size * i);
        ...
        sg_dma_address(sg) =3D (sg_dma_address(sg) & ~(UART_XMIT_SIZE - 1))=
 +
                             sg->offset;
        ...
}

Because the sub-page offset of an unaligned xmit_buf is not provided to
sg_set_page(), does this cause the DMA controller to read from the page
boundary instead of the actual buffer? This could result in transmitting
SLUB metadata or adjacent kernel objects over the serial port instead of
the intended data.

> +	if (!buf)
>  		return -ENOMEM;
> =20
>  	uport =3D uart_port_ref_lock(state, &flags);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-tty-v2-0-8=
8cd58c3c640@kernel.org?part=3D2
