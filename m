Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7E470EA7
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960565; cv=none; b=gWeTIOYVmz81Ky4EwnZtaqA9qclKx8UUNfgiAanuDSYnMNiNcquo/s7deuQRYjx5DqpnVDc0bsbWzDEuClagBYNkP05jf1C6XcZLU/7A8XV+HoEGhe8RLviYP4wfliMlMjpe6nlQaN2Us4tplE0qVFer2Eu3v8+rh6Ei7sfus2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960565; c=relaxed/simple;
	bh=hJbWsG0qApCKIPlDLZDrMfga4spN3bsv9xfpQ8WEsHg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dXw4UOTjBY7cnnS6P3bomv16/1FBfDAkg1I7JYOsahIlxcNNZJnZbFAPZ9bfB/2SUKF7JX2lwePyh3YTEmoGtgOW4Q+r5oVIx9mEaRUORD3VOdAXvuVgi/mHCpqyBw1nSylSaLwwJnJHGEI+ShDEt14Y2caRVpmYgz45maBdOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozvzvGJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozvzvGJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2EF1F0089A;
	Wed, 14 Oct 2026 06:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791960563;
	bh=R5a+WsEzOn1pNL41/f3VB+es1+dUXol5JcjZ5ImkGqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ozvzvGJW1n7cu90ycEYEJjTSNPqMyorU8fAsLk/+EBAJvj0yexr2oeCGW3rQc4FdI
	 PqlE37xJ7AUO5QZJcP1R/BlrwucZobr68iZwaly/H+cx0HTy8a82CVu2EzlDDYg6z3
	 qNnn7RNeUJKCkLpRmPK522jXJZm2VuPVPwwh9bNuzqricKiZOSS59ZZan5md10ZN09
	 qPexwiztBcQOFuLIYHMNjmeFxdvAVW41EXCtA2tgO3bJPqyY/e17dRTtVc71MSG/so
	 BWxgLHcgDC070cMetW5MSSgzZ1rr13aCnHARD3urGq0dSJS35WSUhWPcvblwtBMJjz
	 FS2HN4ah6ZaJg==
Message-ID: <sashiko-outbox-170895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] serial: 8250_exar: store the GPIO platform
 device in struct exar8250
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <03a8b5c71614fc672fef1e55c083bda6c73b5bf3.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <03a8b5c71614fc672fef1e55c083bda6c73b5bf3.1791873876.git.jirislaby@kernel.org>
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
- [High] tty: 8250_exar: missing IS_ERR check causes invalid pointer deref
--

commit 6cdc2bc96a13008a8cfba8cca844ee2bb25786e6
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>

serial: 8250_exar: store the GPIO platform device in struct exar8250

The GPIO platform device is now stored in struct exar8250::gpio instead of
port->port.private_data to fix an issue where port 0 might not exist on
unbind. The platform->register_gpio() and platform->unregister_gpio()
callbacks are updated to take priv as an argument.

Link: https://lore.kernel.org/all/sashiko-outbox-166269@kernel.org/

> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/825=
0/8250_exar.c
> index ad2e5841fbf69..29b2a29ab6f37 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
[ ... ]
> @@ -1167,22 +1169,21 @@ static const struct software_node exar_gpio_node =
=3D {
>  	.properties =3D exar_gpio_properties,
>  };
> =20
> -static int xr17v35x_register_gpio(struct pci_dev *pcidev, struct uart_82=
50_port *port)
> +static int xr17v35x_register_gpio(struct exar8250 *priv, struct pci_dev =
*pcidev,
> +				  struct uart_8250_port *port)
>  {
>  	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR)
> -		port->port.private_data =3D
> -			__xr17v35x_register_gpio(pcidev, &exar_gpio_node);
> +		priv->gpio =3D __xr17v35x_register_gpio(pcidev, &exar_gpio_node);

[Severity: High]
Does __xr17v35x_register_gpio() return an ERR_PTR if
platform_device_register_full() fails?

If it does, we might be storing an error pointer directly into priv->gpio in
xr17v35x_register_gpio() without validating it with IS_ERR(). Because the
error is ignored, the device probe successfully continues.

> =20
>  	return 0;
>  }
> =20
> -static void xr17v35x_unregister_gpio(struct uart_8250_port *port)
> +static void xr17v35x_unregister_gpio(struct exar8250 *priv)
>  {
> -	if (!port->port.private_data)
> -		return;
> -
> -	__xr17v35x_unregister_gpio(port->port.private_data);
> -	port->port.private_data =3D NULL;
> +	if (priv->gpio) {

[Severity: High]
Later, during module unload or device unbind, we evaluate if (priv->gpio)
here in xr17v35x_unregister_gpio().

Since an ERR_PTR is not NULL, the condition passes and the error pointer is
passed to __xr17v35x_unregister_gpio().

Inside, device_remove_software_node(&pdev->dev) attempts to dereference the
invalid pointer, resulting in a crash. Could we add an IS_ERR check when
assigning priv->gpio, or check for it here?

> +		__xr17v35x_unregister_gpio(priv->gpio);
> +		priv->gpio =3D NULL;
> +	}
>  }
[ ... ]
> @@ -1289,8 +1291,7 @@ static int iot2040_register_gpio(struct pci_dev *pc=
idev,
>  	writeb(IOT2040_UARTS_ENABLE, p + UART_EXAR_MPIOLVL_15_8);
>  	writeb(IOT2040_UARTS_GPIO_HI_MODE, p + UART_EXAR_MPIOSEL_15_8);
> =20
> -	port->port.private_data =3D
> -		__xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);
> +	priv->gpio =3D __xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);

[Severity: High]
This looks like the same concern as above in xr17v35x_register_gpio(). If
__xr17v35x_register_gpio() fails and returns an error pointer, we'll store
it here in iot2040_register_gpio() unchecked.

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791873876.gi=
t.jirislaby@kernel.org?part=3D3
