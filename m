Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795203605;
	b=TGUTVxSP2xgo6gEGrsjrPHxVF9kdK8IEdlKD0vJtAbY3MeAk2J+ShIuohK90qar3g60L
	 4pKrPz0HzI841T9AYzJW74d90DGhNggUg5euCh1RLvAIQGtpDOfuQZBiMuMGCuTUXW17+
	 UWkBbnGOPgMrKyfSvuUwXoNZDwan8aD+ZjelUV8KRZ+JstFJeGfBSMDGtLajQgoQ7LrAZ
	 OXPmATggPDoyJ8KK64Y5arSWHcdIH77sKnKzrPOIeIRqebFu+Zlgk44pJ2MkEoqMsdDyj
	 mQVpW7b7i8zIskLFzaKL0Osx5VJyd6yQRZgIfSchocO0tFnyYtqgk3vksCe8an9HjSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203605;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2Y2Mt673Jc37reDou0yhIpSlNyLfdRhY2EonmhZ9FEs=;
	b=ntLuiC3yeqi2+HE0iw89HLIYUvBKFKZVKq5ONEgsTctlLlnp5MEYQUdhn0thNfjZlQTC
	 I1YxB4IuMzFGGFYLGhJzi5DTWl30Ew/cvSHzoX2FQDuPOtw8ObjYP7kokTsNPzo6VQP4R
	 PCU0F/TsGTylGf/LC7lBgfnhujv1kZfnP0u7eoX6EiKa1riigg01n53/BMDMlaXSHwUAa
	 kwUnGictv0I52MHsPVs+ubkC3g6Ay7TxgX3ha1MizfKV8BEAMxnVW16j6etBVpkAJHOfm
	 TZSVyJMSMpyXBcAOaiomchkOoWGp4w1/hSGXmFAJfoo8z/LZEqjbJVMft0mMrwDEkKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fc/PMLRs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C683606A6CB
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fc/PMLRs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A392B1F000CA;
	Fri, 20 Nov 2026 19:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795203604;
	bh=2Y2Mt673Jc37reDou0yhIpSlNyLfdRhY2EonmhZ9FEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fc/PMLRsQHO3Lw3gtxUA/b8dMD6nXBkgX7NO1n9myxluftJxyhAL5F5DOa4DjRw8Z
	 RKHdH4JpTHGLVFGuF9dR8TFjBtmwlxvHW95mrTO00piwXfSZLz4C7Ut0EwQvLqWbBT
	 g1TOAAeb5X3hoSTD4lji+ORrOfS0hszkwaax8BDev0Cg7B5/q3T1U0TaP27GVhc92v
	 EP8dr0il1nCLHB9w56pS8U1EbAnR7/27y3YYgkw6QVkMsGkw8PVk+rXs6rP1kTWBPx
	 zsTELzTwwD+ilG54Py4woeAIE9nu081282A0/g40BHIgBGo/ColutOJBkAuFJUa2xc
	 rxCytnDeKKHrA==
Message-ID: <sashiko-outbox-225939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_exar: check IS_ERR() on
 __xr17v35x_register_gpio()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Elkin Cruz" <elkin@google.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261120192147.2869595-1-elkin@google.com>
References: <20261120192147.2869595-1-elkin@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:40:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] serial: 8250_exar: redundant fix aborts all UART ports in
  exar_pci_probe()
--

commit b311185ae98aa3c07a0e01dce285dd1024817852
Author: Elkin Cruz <elkin@google.com>

serial: 8250_exar: check IS_ERR() on __xr17v35x_register_gpio()

This commit checks IS_ERR() on the platform_device pointer returned by
__xr17v35x_register_gpio() in xr17v35x_register_gpio() and
iot2040_register_gpio(), propagating PTR_ERR(pdev) on failure.

> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/825=
0/8250_exar.c
> index 42e55a8f8c69b..66858e383afcd 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -1173,8 +1173,14 @@ static const struct software_node exar_gpio_node =
=3D {
>  static int xr17v35x_register_gpio(struct exar8250 *priv, struct pci_dev =
*pcidev,
>  				  struct uart_8250_port *port)
>  {
> -	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR)
> -		priv->gpio =3D __xr17v35x_register_gpio(pcidev, &exar_gpio_node);
> +	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR) {
> +		struct platform_device *pdev;
> +
> +		pdev =3D __xr17v35x_register_gpio(pcidev, &exar_gpio_node);
> +		if (IS_ERR(pdev))
> +			return PTR_ERR(pdev);
> +		priv->gpio =3D pdev;
> +	}
> =20
>  	return 0;
>  }
> @@ -1286,13 +1292,17 @@ static int iot2040_register_gpio(struct exar8250 =
*priv,
>  				 struct uart_8250_port *port)
>  {
>  	u8 __iomem *p =3D port->port.membase;
> +	struct platform_device *pdev;
> =20
>  	writeb(IOT2040_UARTS_DEFAULT_MODE, p + UART_EXAR_MPIOLVL_7_0);
>  	writeb(IOT2040_UARTS_GPIO_LO_MODE, p + UART_EXAR_MPIOSEL_7_0);
>  	writeb(IOT2040_UARTS_ENABLE, p + UART_EXAR_MPIOLVL_15_8);
>  	writeb(IOT2040_UARTS_GPIO_HI_MODE, p + UART_EXAR_MPIOSEL_15_8);
> =20
> -	priv->gpio =3D __xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);
> +	pdev =3D __xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +	priv->gpio =3D pdev;
> =20
>  	return 0;
>  }

[Severity: Medium]
Should a failure in __xr17v35x_register_gpio() abort UART port registration
in exar_pci_probe()?

The error-pointer dereference in xr17v35x_unregister_gpio() mentioned in
the commit message was already fixed by 0353b5196588 ("serial: 8250_exar:
check priv->gpio properly"), which checks !IS_ERR_OR_NULL(priv->gpio).

Previously, GPIO platform-device registration failure was non-fatal so the
card's UART ports would still be registered.  Propagating PTR_ERR(pdev) from
xr17v35x_register_gpio() and iot2040_register_gpio() causes
pci_xr17v35x_setup() to fail on port 0, which breaks out of the port setup
loop in exar_pci_probe() at i =3D=3D 0 and leaves the card with zero UART p=
orts
registered while exar_pci_probe() still returns 0:

drivers/tty/serial/8250/8250_exar.c:exar_pci_probe() {
    ...
	for (i =3D 0; i < nr_ports && i < maxnr; i++) {
		rc =3D board->setup(priv, pcidev, &uart, i);
		if (rc) {
			dev_err_probe(&pcidev->dev, rc, "Failed to setup port %u\n", i);
			break;
		}
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120192147.2869=
595-1-elkin@google.com?part=3D1
