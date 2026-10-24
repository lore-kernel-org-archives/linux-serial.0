Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809328;
	b=2BBoskWkmV32K7/X/QsGGTPjRMeVWvtVAF9efXfK73dh0d71CzN3ynIND/cIjZpbJ+Ke
	 z6wDZ+1lroNXIEMrkZe7i726t1e6ORPplQaTE2BVfIACbX9J43NioLJQb53/V3rzVjTOZ
	 dGjliv6PqYqr5OmBXd55L23j/2tr+BOsEbSTfyFb3hSnW1u2euBO53LipQUIOamcK/CJn
	 2pfvBFBf6BhU630gUTw0543dlltuI8r1XossMKRFJr+vsAPIivt7UBy1FU0HL25lI5T6j
	 yQfgEsWK803A2Fbnx6qsm6xvWLmUXTJmk0RaUJT1Ejv0ZcMy6D6tb8r2uKoLvAmJy2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809328;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JaitCAV0lTceVXy8QVF/ojLnrJm59JniQJ/z74uk984=;
	b=o7LyWrA4mgYuzwlWlht36wP5NwuGjvSePlXq6NK4wvSUQR0CepVNqBqdmzCDxtoSBs6J
	 Rn7YOZd9W6A5YyFBFEWVdYl0lgviJ78UbxmDHcdpHeHLeQ2+7OvJcL254kTA+8VWMHMTZ
	 7nuJv/htOjfy03/2X9vDDBrcEHAO89IvYNJdy+dDjG60KtbDaZXo7UNEAsKxvGUEvk88y
	 pgAnI0ab7RncG7pq7WGVY2nRiRYJPUOX3oIop58ubC7KIYAsMGfGLv+dN4h+sjo/H/AVR
	 H21PDwoVdM1sqNdDYW8AyLopoKov33T/GzXw4VkzgC31fcduJaXQsL1hcm+/nxFCcoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQCjC1RO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4141606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQCjC1RO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F5C1F01825;
	Sat, 24 Oct 2026 02:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792809327;
	bh=JaitCAV0lTceVXy8QVF/ojLnrJm59JniQJ/z74uk984=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dQCjC1ROCnMnlJd1tjaWKZr3ezHKpQ+HS97gO4phxv6abDw54UECCsq6aqvbiJB6w
	 87HyB6FiTEAPZLARjiiD6IkzcyjiBlCrvl4mK/Bc//lFfIsLBNF+3C1ZEnLrKClZ8w
	 QsQLX3SPE7BieSXoJo4emImmmOu8v+M2ICqUrHHbdGqDaV/fXPrTKXy8COyaE+JuVh
	 7nbhxeOUmzW8c4+lIi7UPi22qKt5BF2+yEISI84MS1Pb7St+uL7we3QkH8p50uwrbj
	 NJ3YnywoVaRU/MIptJcZ3QiIdCc1Ngt/eFjbhKbjyHLsGEoYtcIU0mQ1jc2pkTby7W
	 SxeUjG17ySHcA==
Message-ID: <sashiko-outbox-183517@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] platform/x86: dell-uart-backlight: Bind through
 normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <20261024022930.2704030-3-an.wu@canonical.com>
References: <20261024022930.2704030-1-an.wu@canonical.com>
 <20261024022930.2704030-3-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 02:35:26 +0000
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
- [High] platform/x86: dell-uart-backlight: use of nonexistent serdev modal=
ias API
--

commit 6fdb948003156a6919ba6eb5db62dfc9148ff2fc
Author: ChunAn Wu <an.wu@canonical.com>

platform/x86: dell-uart-backlight: Bind through normal serdev matching

This patch converts dell-uart-backlight from manual device_driver_attach()
binding to serdev id_table and modalias matching via serdev_device_add().

> diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/pl=
atform/x86/dell/dell-uart-backlight.c
> index f323a667dc2d2..9b8ef91bb0a20 100644
> --- a/drivers/platform/x86/dell/dell-uart-backlight.c
> +++ b/drivers/platform/x86/dell/dell-uart-backlight.c
> @@ -325,11 +325,17 @@ static int dell_uart_bl_serdev_probe(struct serdev_=
device *serdev)
>  	return PTR_ERR_OR_ZERO(dell_bl->bl);
>  }
> =20
> +static const struct serdev_device_id dell_uart_bl_serdev_id[] =3D {
> +	{ KBUILD_MODNAME },
> +	{ }
> +};
> +
>  static struct serdev_device_driver dell_uart_bl_serdev_driver =3D {
>  	.probe =3D dell_uart_bl_serdev_probe,
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
>  	},
> +	.id_table =3D dell_uart_bl_serdev_id,
>  };
> =20
>  static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
> @@ -354,7 +360,7 @@ static int dell_uart_bl_pdev_probe(struct platform_de=
vice *pdev)
>  	if (!serdev)
>  		return -ENOMEM;
> =20
> -	ret =3D serdev_device_add(serdev);
> +	ret =3D serdev_device_add(serdev, KBUILD_MODNAME);
>  	if (ret) {
>  		dev_err(&pdev->dev, "error %d adding serdev\n", ret);
>  		serdev_device_put(serdev);
> @@ -365,20 +371,10 @@ static int dell_uart_bl_pdev_probe(struct platform_=
device *pdev)
>  	if (ret)
>  		goto err_remove_serdev;
> =20
> -	/*
> -	 * serdev device <-> driver matching relies on OF or ACPI matches and
> -	 * neither is available here, manually bind the driver.
> -	 */
> -	ret =3D device_driver_attach(&dell_uart_bl_serdev_driver.driver, &serde=
v->dev);
> -	if (ret)
> -		goto err_unregister_serdev_driver;

[Severity: High]
Does this depend on a prerequisite patch adding modalias and id_table suppo=
rt
to the serdev core?

When building with CONFIG_DELL_UART_BACKLIGHT enabled, compilation fails in
drivers/platform/x86/dell/dell-uart-backlight.c because:

1. dell_uart_bl_serdev_id uses struct serdev_device_id, which is not defined
   in include/linux/serdev.h or include/linux/mod_devicetable.h.

2. dell_uart_bl_serdev_driver initializes .id_table, which does not exist in
   include/linux/serdev.h:

struct serdev_device_driver {
	struct device_driver driver;
	int	(*probe)(struct serdev_device *);
	void	(*remove)(struct serdev_device *);
	void	(*shutdown)(struct serdev_device *);
};

3. dell_uart_bl_pdev_probe() passes two arguments to serdev_device_add(),
   whereas drivers/tty/serdev/core.c defines it with a single parameter:

int serdev_device_add(struct serdev_device *serdev)

In addition, serdev_device_match() in drivers/tty/serdev/core.c only matches
via ACPI and OF:

static int serdev_device_match(struct device *dev, const struct device_driv=
er *drv)
{
	if (!is_serdev_device(dev))
		return 0;

	/* TODO: platform matching */
	if (acpi_driver_match_device(dev, drv))
		return 1;

	return of_driver_match_device(dev, drv);
}

Without serdev id_table matching in the core, removing device_driver_attach=
()
from dell_uart_bl_pdev_probe() also leaves dell_uart_bl_serdev_driver unable
to bind when probing Dell UART backlight systems.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024022930.2704=
030-3-an.wu@canonical.com?part=3D1
