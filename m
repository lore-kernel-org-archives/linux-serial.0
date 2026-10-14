Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1F43D4EC
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960565; cv=none; b=pgeL5jnKC7locA1b4Db5zE1tWLbqdJNZx3LPCqwvx2IJD0nvqKn/9Bj1FhL/6CUcTPhirLiE2Ub0ACqmUuLUdt5kXTg07b2dKZ24WYR9VIofbfZNmK3pBNhT5f34w5jfXhKbqxLV5gQaEShaCc+HBEJ9pQlqkKZrqboWg6uQPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960565; c=relaxed/simple;
	bh=/udwGGA2zCuBLucxRF5oi+eLCJ+CyPApjVsQjzen/OA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f2ynriPxIR//WsnTQbCEpzO81/n+7E8Sdp0HChLrkLvWB9C6+nUJFECyBsxv8n1zOMncqnSdYSUFEwpfq0TXpxiyqrbM0WSBglgT8SAxzZIa697SLW20nNHl41e4xYoZ2nTOZNSGKD3FmE9VoyEkwepi5CZntO21FKpAdWALzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2J0ekxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2J0ekxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D24F1F0089E;
	Wed, 14 Oct 2026 06:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791960562;
	bh=/JBhrR+8RF8UX3NdeXUxQoTiDXS55cq4bLf2XiKvLvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2J0ekxmzcrJ3CiuSYf1h5mm9nnaGxxUG+gyFpjrzRMVStxC7Czsj9C5XyLtPNVaP
	 FSbNMUsYq4tip86uHv7CmTCeYC0yZmOhZY/cebpuxi7wzYJbJdpBjpGPmmY9KW16H9
	 2ZvYXVyqIq2l6uKDnaDZX8qqeemMflkPbOOVfmMEoYhni9ktTwHmQuJML4YW04lw/Y
	 PG6uac7ewRW7Gkyed9thRrPglBeX/G5KDtO+zIHyZ3RnXlXL8dSqj9JF4vu3qiZ+Wo
	 nVhuZ/cUYLyhrm2fY3trOR+XAXJd1es6wM/Jn+LjCsG2Uxf5TbNZkquizlRL7S2clC
	 LukXW2gFzq74g==
Message-ID: <sashiko-outbox-170894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] serial: 8250_omap: set priv->line before
 enabling the IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <3b3a642f7df2285f49a7bbbe5d1c23fa442c7d94.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <3b3a642f7df2285f49a7bbbe5d1c23fa442c7d94.1791873876.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 06:49:22 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] serial: 8250_omap: data race on priv->line assignment
--

commit 5147cae847c38d599a30c92bc983c41140a1abad
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>

serial: 8250_omap: set priv->line before enabling the IRQ

This commit fixes an issue where the IRQ handler could dereference an unset
priv->line if an interrupt occurs before omap8250_probe() stores it. It
stores port->line into priv->line in omap_8250_startup() before enabling
the IRQ to ensure the handler always sees a valid line number.

Cc: stable@vger.kernel.org

> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> index 3a1473bf54d0f..137175aa4183a 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -711,6 +711,9 @@ static int omap_8250_startup(struct uart_port *port)
>  	struct uart_8250_dma *dma =3D &priv->omap8250_dma;
>  	int ret;
> =20
> +	/* ISR and runtime PM need the line; probe sets it only after registrat=
ion */
> +	priv->line =3D port->line;
> +

[Severity: Low]
Does this new assignment introduce a data race regression on the unannotated
priv->line variable?

In omap8250_probe(), serial8250_register_8250_port() is called, which
exposes the TTY device to userspace. A concurrent userspace open() can then
immediately trigger omap_8250_startup() on another CPU, which executes this
new assignment:

    priv->line =3D port->line;

Meanwhile, the original omap8250_probe() execution resumes and writes to the
same variable:

    priv->line =3D ret;

This can result in a write-write data race between omap_8250_startup() and
omap8250_probe(). Furthermore, since omap_8250_startup() also enables the I=
RQ,
omap8250_irq() can fire and perform an unannotated read:

    struct uart_8250_port *up =3D serial8250_get_port(priv->line);

While functionally benign since both paths write the same aligned value, th=
is
creates unannotated read-write and write-write races that constitute
undefined behavior under C11/LKMM and will trigger KCSAN warnings.

Could WRITE_ONCE() and READ_ONCE() be used to safely handle these concurrent
accesses?

>  #ifdef CONFIG_PM
>  	up->capabilities |=3D UART_CAP_RPM;
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791873876.gi=
t.jirislaby@kernel.org?part=3D5
