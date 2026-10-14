Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572674734FC
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960567; cv=none; b=AFEjJG+Mz1UXcd/DcJFjxjMZilTn/pByzcBOWUM/cDtH/cqNGOtObGqVl+miMjQiY4kqsddslAQkTcVJLJSqakhMBz/VrbTtHWOsbv825sv7sIDXPysaKVnWjK2OikGkb9XvKvmGdgga9yAc3mtNFCZNa8uQw+7fjuQyMUDF1iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960567; c=relaxed/simple;
	bh=1n1H851Evj/EejC3g5DqdR3t+veFOFS3RLQJIi/zq7Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FDMBnND3JpGa+vTWYO/mS8s5XDPjrOQgQ/phvrNaeljE3zFAi5a0tp3R1c+BpDswej6ofRP/fWXstKB9VHiRFvQsOblextL/+z4v/AX/EwhvEqt2UO7sT+hTv0PbsyM21kIgLe0TAQFZq2WmGMcDS2QqLSrgEy4CiL/0SdP1qyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8YXIB6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8YXIB6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6941F000FF;
	Wed, 14 Oct 2026 06:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791960564;
	bh=m8YiwlF4wZMcuO4DpNrwdRbjTznFZLtv94bDnZfQny4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U8YXIB6UG1Q7sh8h1E032Nz5YjaIy7fVuGMlCiLQwnRe8Y0cUg1PL8QtTLXYZfFXG
	 +QdbRhG2/4QwjP2KG/d9o9mXOXCSsWxQnmx7zgMen/HCzm6UDXPKodHYjnXJlL4Bd4
	 quKKFln92z6RsaFEmY2IZ39yMbpb4xUoAErBXskAvBx1Sf+iTzD4XPFhjPXuIU67w/
	 BBFaW/oNLUT5rovQPCKIEiu1BgJ4anvcFbsFkTi95FTJuzx8R1txZHs9AKc4HHx8n0
	 dT4ZNQMs4c7EkYzoy505lW457XuFL87IMYwiYO/zDbx6GRxEq0pzMevwhcOd2e+FeI
	 xTYH44TBLsnjQ==
Message-ID: <sashiko-outbox-170897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on
 struct uart_8250_port
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 06:49:24 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: serial: 8250_hp300: NULL pointer dereference on hpdca device =
removal
--

commit f913317bfee3afed5e144530ca60f25858464754
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Date:   Tue Oct 13 06:48:51 2026 +0000

    serial: 8250: make port operations work on struct uart_8250_port
   =20
    This commit switches the interface of port operations to use
    struct uart_8250_port instead of the line number, returning the registe=
red
    port or an ERR_PTR() on failure. It updates all drivers to store the po=
rt
    pointer instead of the line number.

> diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/82=
50/8250_hp300.c
> index 59ec0c7377a1c..e9599c5c2fead 100644
> --- a/drivers/tty/serial/8250/8250_hp300.c
> +++ b/drivers/tty/serial/8250/8250_hp300.c
[ ... ]
> @@ -177,9 +177,8 @@ static int hpdca_init_one(struct dio_dev *d,
>  	uart.port.membase =3D (char *)(uart.port.mapbase + DIO_VIRADDRBASE);
>  	uart.port.regshift =3D 1;
>  	uart.port.dev =3D &d->dev;
> -	line =3D serial8250_register_8250_port(&uart);
> -
> -	if (line < 0) {
> +	uport =3D serial8250_register_8250_port(&uart);
> +	if (IS_ERR(uport)) {
>  		dev_notice(&d->dev,
>  			  "8250_hp300: register_serial() DCA scode %d irq %d failed\n",
>  			  d->scode, uart.port.irq);
>  		return 0;
>  	}
> =20
>  	/* Enable board-interrupts */
>  	out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, DCA_IC_IE);
> -	dio_set_drvdata(d, (void *)line);
> +	dio_set_drvdata(d, uport);
> =20
>  	/* Reset the DCA */
>  	out_8(d->resource.start + DIO_VIRADDRBASE + DCA_ID, 0xff);

[Severity: High]
If serial8250_register_8250_port() fails here and returns an ERR_PTR, this
function logs a warning and returns 0 (success). In this failure path,
dio_set_drvdata() is skipped, leaving the device's driver data as NULL.

Because the driver returns 0, the device is considered successfully bound.
When the device is later removed, hpdca_remove_one() is called:

> @@ -287,14 +283,13 @@ static int __init hp300_8250_init(void)
>  #ifdef CONFIG_HPDCA
>  static void hpdca_remove_one(struct dio_dev *d)
>  {
> -	int line;
> +	struct uart_8250_port *uport =3D dio_get_drvdata(d);
> =20
> -	line =3D (int) dio_get_drvdata(d);
>  	if (d->resource.start) {
>  		/* Disable board-interrupts */
>  		out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, 0);
>  	}
> -	serial8250_unregister_port(line);
> +	serial8250_unregister_port(uport);
>  }
>  #endif

Will this lead to a NULL pointer dereference?

If the registration failed during probe, uport will be NULL here. Since
serial8250_unregister_port() unconditionally dereferences the pointer (e.g.,
checking uart->em485), passing NULL will cause a kernel panic.=20

Should the failure path in hpdca_init_one() return an error code instead of
0, or should hpdca_remove_one() check for a valid uport before
unregistering?

Note: This replaces a prior bug where passing an uninitialized 0 line number
caused the driver to erroneously unregister ttyS0 instead of crashing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791873876.gi=
t.jirislaby@kernel.org?part=3D6
