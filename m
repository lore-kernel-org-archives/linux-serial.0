Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63784EB862
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894248; cv=none; b=KwT0oE4CY1r67FKojVMgR1dr7LMzjaeKQ22opPP1YrEgo+TQB9bH9Q+k33CFKOzAdUzGr15yY5ucfc22ZbPv3py0i5gUIA8sOv3rcvpcHcw/fUzeZUqk67BoAfoY5Dve5H1kTKMikHB8CchAH0zOp2orSc42Cx8s4AuiL3aPxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894248; c=relaxed/simple;
	bh=h1G8TEzlLiCSHn8XiE6GcB5ADaBAkUoj76uFqn3NzGc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=NJD2LR2+t+gzuGCCYKPuDOZfbczxho5AWcX0uT1n2qIBwyjLIdTtBNHpnnwjIQzk6+xI3Uig0NyKCWwK9myVP5HZ5epKUrw34On7mJL4r74qg0xwylak6yCn9wAQti1jiaN6pQ6EbEFGEEy5dhZ/ShdqcWQVoce91pZ9oBPopz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGF7r7va; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGF7r7va"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721F51F000FF;
	Tue, 13 Oct 2026 12:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791894247;
	bh=XTLGC7kFXwLiNZsCG7mC4+FpdOw5pJzjnDm6S57VQLg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZGF7r7vaj+kZKGYMxoEeEgZJYLdo+W9gQ/NMhJxbN+7dD8/PBk+B2uO+80mXCuenW
	 WgR0F5aiN6H+oJJPtzLz1Zziw5kBRVtzlYNK4M4ZPOLQq5/SSCohTtGzWW0fruqQXk
	 75whCOiGttD7HgU6ts1+SVLXUQwyv5SGPEJETyqdRFmOvnLCgycB4e6hYtjO/gaOuF
	 BX+xFgiEXYaXEaJ/INU/WQ2WM2CGMrcGfhiX1HB3OJ+wQ33GGRYMwTKyBJtBdjBZsQ
	 gSftCOnM/A1bWScqTOtOTv/Hkc02TI1k35vFeTRd5f8I9wGk6paelGNlos5Co7SV9m
	 wd7nRDlGgafPA==
Message-ID: <sashiko-outbox-169702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] serial: mcf: convert to use proper platform
 resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Ungerer" <gerg@linux-m68k.org>, linux-serial@vger.kernel.org
In-Reply-To: <20261013120831.1046590-3-gerg@linux-m68k.org>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-3-gerg@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:24:06 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tty: mcf: unconditional removal of all UART ports in mcf_remove()
- [High] tty: mcf: ERR_PTR stored in membase bypasses uninitialized check
- [Medium] tty: mcf: tautological error check on platform_get_irq()
--

commit c5cb7916e270b19e0758d11e193eb23c71763eca
Author: Greg Ungerer <gerg@linux-m68k.org>

serial: mcf: convert to use proper platform resources

The ColdFire SoC device setup code supplies a non-standard array of
hardware address information (memory address and IRQ) for initializing
the UARTS - which it does as a single blob. The mcf serial probe
function processes the whole set in one go from a single platform entry.

[ ... ]
> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
> index 2b862dfe39ab3..3651910dff99e 100644
> --- a/drivers/tty/serial/mcf.c
> +++ b/drivers/tty/serial/mcf.c
[ ... ]
> @@ -570,31 +570,34 @@ static struct uart_driver mcf_driver =3D {
> =20
>  static int mcf_probe(struct platform_device *pdev)
>  {
> -	struct mcf_platform_uart *platp =3D dev_get_platdata(&pdev->dev);
>  	struct uart_port *port;
> -	int i;
> +	struct resource *res;
> =20
> -	for (i =3D 0; ((i < MCF_MAXPORTS) && (platp[i].mapbase)); i++) {
> -		port =3D &mcf_ports[i].port;
> +	if (pdev->id >=3D MCF_MAXPORTS)
> +		return -ENODEV;
> +	port =3D &mcf_ports[pdev->id].port;
> =20
> -		port->line =3D i;
> -		port->type =3D PORT_MCF;
> -		port->mapbase =3D platp[i].mapbase;
> -		port->membase =3D (platp[i].membase) ? platp[i].membase :
> -			(unsigned char __iomem *) platp[i].mapbase;
> -		port->dev =3D &pdev->dev;
> -		port->iotype =3D SERIAL_IO_MEM;
> -		port->irq =3D platp[i].irq;
> -		port->uartclk =3D MCF_BUSCLK;
> -		port->ops =3D &mcf_uart_ops;
> -		port->flags =3D UPF_BOOT_AUTOCONF;
> -		port->rs485_config =3D mcf_config_rs485;
> -		port->rs485_supported =3D mcf_rs485_supported;
> -		port->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
> -
> -		uart_add_one_port(&mcf_driver, port);
> -	}
> +	port->membase =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(port->membase))
> +		return PTR_ERR(port->membase);

[Severity: High]
Since port is a pointer to the global mcf_ports array, assigning an ERR_PTR
to port->membase leaves the error pointer in the global state if
devm_platform_get_and_ioremap_resource() fails.

Later, when the early console is initialized, mcf_console_setup() checks if
membase is valid using:

    if (port->membase =3D=3D 0)
        return -ENODEV;

Since an ERR_PTR is not zero, this check will pass, which could cause a
kernel panic when mcf_console_write() dereferences the ERR_PTR during a
printk.

Could we store the mapped address in a local variable and only assign it to
port->membase on success?

> +	port->mapbase =3D res->start;
> +
> +	port->irq =3D platform_get_irq(pdev, 0);
> +	if (port->irq < 0)
> +		return port->irq;

[Severity: Medium]
In struct uart_port, irq is defined as an unsigned int. Does the check
(port->irq < 0) undergo unsigned comparison and become tautologically false?

If platform_get_irq() fails and returns a negative error code like -ENXIO,
it seems this error would be swallowed, and the port would be registered
with a bogus, very large IRQ number.

> +	port->line =3D pdev->id;
> +	port->type =3D PORT_MCF;
> +	port->dev =3D &pdev->dev;
> +	port->iotype =3D SERIAL_IO_MEM;
> +	port->uartclk =3D MCF_BUSCLK;
> +	port->ops =3D &mcf_uart_ops;
> +	port->flags =3D UPF_BOOT_AUTOCONF;
> +	port->rs485_config =3D mcf_config_rs485;
> +	port->rs485_supported =3D mcf_rs485_supported;
> +	port->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
> +
> +	uart_add_one_port(&mcf_driver, port);
>  	return 0;
>  }

[Severity: High]
With the conversion of mcf_probe() to process a single platform device per
call instead of a single blob, does mcf_remove() also need to be updated?

Looking at mcf_remove() in drivers/tty/serial/mcf.c:

static void mcf_remove(struct platform_device *pdev)
{
	struct uart_port *port;
	int i;

	for (i =3D 0; (i < MCF_MAXPORTS); i++) {
		port =3D &mcf_ports[i].port;
		if (port)
			uart_remove_one_port(&mcf_driver, port);
	}
}

It appears this loop still unconditionally unregisters all 10 ports,
regardless of which pdev is being removed. If a single device is unbound
via sysfs, will this disrupt other devices or lead to list corruption by
calling uart_remove_one_port() on uninitialized structs or multiple times
on the same port?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013120831.1046=
590-1-gerg@linux-m68k.org?part=3D2
