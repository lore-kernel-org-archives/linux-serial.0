Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814532;
	b=gS0JOIlCGooSOhKHDj+pXirHsWWIIbWsExB6qVKt8o0ImCXCWF4HitPNbG5aRLVI12HD
	 Msybo+06ja5sscT/sqR2rViuYHuSkhoSxE0/cOdDEhafgsgLknRR3T0e1L71B8/LT+IeU
	 zH+AipeLbUC56HTPSD16cVEl0ecv4pNZX4NopJV493eI260ZjWWhKolqDTK4fwyhcStsZ
	 lX3CvyazyFpxwyYWiENpkp9GM8vR+4TY5gm5YjB8c1C8kf7iuWc9xNU5dnytzZBwM/cXZ
	 PLOUIU0qQ5dSyBb+wJONZejxbxjMHxBBWpTBUWnIbWR67achr9Qr0ttsFA16apPdziA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814532;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bAW9h2tUGtY/enb1ivgZUDTyE7K/Pw7kZvjPEYa+cQU=;
	b=ZvKaCp5FawduhuoPWYLMWJnbEzlqpBBOvThx5kZtN2CPCo7P7iXldPUd7WRKs1kd/R87
	 nxxDfGF5AOp2ats0D04VZzEyOjGiCZzwag+/5QLyDO1kJf+W6hleaDjPg4tQpqL+9J0xm
	 t/lSuDHyokrPqpWotd5C2SMewhMHifIFSiGyOHTJCvDyXvoBQ9pUvRLgV8LWActHup290
	 wf+5EqmbvdSaZm8zqPsGOjHPb+2asT441hQFPo7sfBb3/ozFaHUPHSLYSv9aoM2Nr92pw
	 OxW6DblYGOmSu5/SIeMKdZ9jvDjdoCaO3mKvKXu97wG9304td9Wx0wPH8qoKA2zbM9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D/J7dXk7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E7606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D/J7dXk7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49021F01828;
	Sat, 24 Oct 2026 04:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814532;
	bh=bAW9h2tUGtY/enb1ivgZUDTyE7K/Pw7kZvjPEYa+cQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D/J7dXk7QngzmKA7F0x8z9oMlpvFKbfd1ClmMAkrz41fQTdZ5tdS9lpNL/J/maLF2
	 UxmaYvr76m2u6R2XdRX5bLq2gYXUqbT5chVhgx5wlMUQDahVnDKOPtHcUI2zbO8139
	 BKaLl+gy90AH2hORfLFeVikPxfj+ZBuLENCGW13ODJ81D183+Fdkh9mrYgjziFypjA
	 A7oLSW65B/qNDlh8eJPEVh4h2qCqzxP+jsXCUcOAVoayn/44V7As+kQCfcf/SvQXHX
	 9CQC1fBZqlSbdt0dqlM2I/1jmjRnSm0PkHRUIFGj7gMTK8hYeVmQAssdkK853NDiOb
	 pYCIKh+NJzTcg==
Message-ID: <sashiko-outbox-183537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] platform/x86: dell-uart-backlight: Bind through
 normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024035011.2712103-1-an.wu@canonical.com>
References: <20261024022930.2704030-1-an.wu@canonical.com>
 <20261024035011.2712103-1-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 04:02:11 +0000
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
- [High] platform/x86: dell-uart-backlight: type confusion in serdev_device=
_match()
--

commit 845cea88ea8fd97f6d009ac4a558f36871acb863
Author: ChunAn Wu <an.wu@canonical.com>

platform/x86: dell-uart-backlight: Bind through normal serdev matching

This commit switches the dell-uart-backlight driver from manually binding
its serdev client via device_driver_attach() to passing a modalias to
serdev_device_add() and matching via a serdev_device_id table.

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

[Severity: High]
Does adding id_table to dell_uart_bl_serdev_driver trigger a type confusion
and out-of-bounds read in serdev_device_match() when
dell_uart_bl_pdev_probe() calls serdev_device_driver_register()?

Both struct serdev_controller and struct serdev_device are registered on
serdev_bus_type:

drivers/tty/serdev/core.c:serdev_controller_alloc() {
	...
	device_initialize(&ctrl->dev);
	ctrl->dev.type =3D &serdev_ctrl_type;
	ctrl->dev.bus =3D &serdev_bus_type;
	ctrl->dev.parent =3D parent;
	ctrl->host =3D host;
	device_set_node(&ctrl->dev, dev_fwnode(host));
	...
}

Earlier in the series, commit 1b3d9973e0d0 ("serdev: handle devices without
an ACPI or device tree node") removed the is_serdev_device(dev) check from
serdev_device_match(), leaving an unconditional cast via to_serdev_device():

drivers/tty/serdev/core.c:serdev_device_match() {
	const struct serdev_device *serdev =3D to_serdev_device(dev);
	const struct serdev_device_driver *sdrv =3D to_serdev_device_driver(drv);

	if (acpi_driver_match_device(dev, drv))
		return 1;

	if (of_driver_match_device(dev, drv))
		return 1;

	return !!serdev_match_id(sdrv->id_table, serdev->modalias);
}

When dell_uart_bl_pdev_probe() calls:

  serdev_device_driver_register(&dell_uart_bl_serdev_driver)
    -> driver_register()
      -> bus_add_driver()
        -> driver_attach()
          -> serdev_device_match()

the driver core iterates over every device on serdev_bus_type, including
the struct serdev_controller instance ("serial0").

Because dell_uart_bl_serdev_driver has no ACPI or OF match table and sets a
non-NULL id_table, serdev_device_match() reaches
serdev_match_id(sdrv->id_table, serdev->modalias) with serdev pointing to a
struct serdev_controller.

In struct serdev_device, modalias is at offset sizeof(struct device) + 4
and is 40 bytes long. In struct serdev_controller, that offset overlaps
struct device *host, unsigned int nr, struct serdev_device *serdev,
const struct serdev_controller_ops *ops, and extends 12 bytes past the end
of struct serdev_controller, passing those bytes into strcmp(modalias,
id->name) in serdev_match_id().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024022930.2704=
030-1-an.wu@canonical.com?part=3D2
