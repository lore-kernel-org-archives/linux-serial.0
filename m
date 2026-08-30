Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76F1E22E9
	for <linux-serial@vger.kernel.org>; Sun, 30 Aug 2026 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076856; cv=none; b=f3CXqB65hSaDlt+meM6Bj0ijsGgUix0tOpkEUitVodatCsDZf93WRgaLpYiZx0WM3Avh/P8sDuJ3ZBipIKZwElsvy1Ljv2qrGbubcobsObsJEeRBHTRhaA+kmiC28HgDNAbGAvqTukJbzWla1lNaedGRYlVIQXW24WbDFNybtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076856; c=relaxed/simple;
	bh=UL2RW8yhq208zMvlX7n3NAjfI3LPltwUyY9cpZGCdSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NfxptZXcc0hgGm6P6+o/ulcq1JYgSZ8KLrJcWC4Mq/cper3VoW41tSMQXp99JaS796u0lenBdTBIzUgEpb4f0sOeRHqgJMcz1Fm+CzTLrCiQfUFBbukG7P5gYlhx8Xclg69kzb+4YHg1APv24p7Q/S7Rt6bybuAh54EYGBPd/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWhFW0oa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWhFW0oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDF41F000E9;
	Sun, 30 Aug 2026 08:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076855;
	bh=skLBMvfS/j4BelLi7EqMFYoHH0BXE9dQnGpuCMDz6J8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fWhFW0oa/O+Q0ByRqPsKQDh7zfeVvMvoM4YtaD5ok+MSyNGmpdXId0f9hGE0arc9a
	 zzliXAUhg+08eFRsoyhtNHw3I6xmo1Oa3HkPeADSll0ITo54d6kJK/HWhsFw0bGFRi
	 JRdnZNhVHRuglXczPka6sC53s6gu1tQyiy1E4sEi2M3W+jOPwbsMoVMsxkphmdXyzv
	 6CPQd+ru1gkbnDe+nVk87VB20Opa3aEGsegMuNJOmYdoX0m0GfUXoemClPmMJuKezB
	 +nI0NgP6Nex1CuUTcC7Mn7mBAt5E7K7kKzZpasDtEAUmKTN/yvsJd2RK5TDtoczQfj
	 mq8LVPUIb0Uew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] serial: core: replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260830-tty-v1-2-0cbe6170649b@kernel.org>
References: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
 <20260830-tty-v1-2-0cbe6170649b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 08:00:54 +0000
Message-Id: <20260830080055.1BDF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The transition from `get_zeroed_page(GFP_KERNEL)` to `kzalloc(=
PAGE_SIZE, GFP_KERNEL)` for allocating the serial port transmit buffer (`tp=
ort->xmit_buf`) breaks the strict page-alignment guarantee. Several serial =
drivers inherently rely on this buffer being page-aligned. `atmel_serial` e=
xplicitly panics via `BUG_ON(!PAGE_ALIGNED(tport->xmit_buf))`, and `pch_uar=
t` corrupts DMA scatterlist addresses by masking out the lower bits (`sg_dm=
a_address(sg) & ~(UART_XMIT_SIZE - 1)`) assuming the base address is page-a=
ligned. If `kzalloc` returns an unaligned address (e.g., when SLUB debuggin=
g adds redzones), this results in DMA reading adjacent out-of-bounds kernel=
 memory and transmitting it over the serial line.
--

commit 56b6291d1a96458932c4b0e5de37ae0df9e37c2d
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

serial: core: replace get_zeroed_page() with kzalloc()

This commit replaces the page allocator with kzalloc() for the serial port
transmit buffer. It aims to simplify the API and remove casts, noting that
performance differences are negligible.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 95774b0f1484b..f12ce7d190fe6 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -247,29 +247,29 @@ static int uart_alloc_xmit_buf(struct tty_port *por=
t)
>  	struct uart_state *state =3D container_of(port, struct uart_state, port=
);
>  	struct uart_port *uport;
>  	unsigned long flags;
> -	unsigned long page;
> +	unsigned char *buf;
> =20
>  	/*
>  	 * Initialise and allocate the transmit and temporary
>  	 * buffer.
>  	 */
> -	page =3D get_zeroed_page(GFP_KERNEL);
> -	if (!page)
> +	buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: Critical]
Does replacing get_zeroed_page() with kzalloc() break page alignment
requirements for the transmit buffer?

Several serial drivers appear to rely on the transmit buffer being strictly
page-aligned. For example, in drivers/tty/serial/atmel_serial.c,
atmel_prepare_tx_dma() explicitly checks for this:

    BUG_ON(!PAGE_ALIGNED(tport->xmit_buf));

Additionally, in drivers/tty/serial/pch_uart.c, dma_handle_tx() masks out
the lower bits of the DMA address, assuming the base is page-aligned:

    sg_dma_address(sg) =3D (sg_dma_address(sg) &
                        ~(UART_XMIT_SIZE - 1)) + sg->offset;

If kzalloc() returns an unaligned address (which can happen when SLUB
debugging adds redzones), could this result in a kernel panic in atmel_seri=
al
or corrupted DMA scatterlist addresses in pch_uart?

Could this DMA corruption lead to out-of-bounds kernel memory being read
and transmitted over the serial line?

> +	if (!buf)
>  		return -ENOMEM;
> =20
>  	uport =3D uart_port_ref_lock(state, &flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-tty-v1-0-0=
cbe6170649b@kernel.org?part=3D2
