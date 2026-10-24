Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814850;
	b=UNXvwsixLyPlo3PizeN4yn1F1NS6q9XPNcd0gycNX5t+Fmj/+nQTaqYKYdEQMrng6Wg5
	 +1J2ijDbuMltX12U/vM4mo0tIGRFtw6BPz/LPGOKA7AE3gKEA5/jMq1Au0CzHmCMpw7YI
	 fQwkUr5/OGKIlp3aV13UprlWRS2M+eKI2kfh2ksJgsOmEizuSCo3GWB0mrM7yHV1h1UId
	 dWB7uej5jx4q6wj0TMgd8YpzK21AogxNgrJieUXaR7e1ueeJOWHaqGm4M2hHjxAUwpJvM
	 iHDMi5NKU2Yln/4FxdJLi1701YbihdjrHzJgxNFG9rm68MzfUMPxrkG3AAXbw92kl/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814850;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lJ+gXVjAjTUc7MW4E9DYp68frI0wTGEvsWclZZGaF7c=;
	b=PZfdHN/TkOOl7NqTNe4qU+q2NH4Sv/3bnvRC/G+q+1UCnjwymN9ArTuKhhmGRUZ38Z+l
	 mnOgANtMD6zWXR2RfqVEOCoPKrnHSe+JQ6dzU1NJEdU9AJxpXH3rwuwaajKfWuIUVaDFj
	 JPi2Fb3NeImIUu1EwTxCBRSdcM5FVkwkY5p5wsh7SB1sABpdXg6g3QiRDv1Avzugbw4rM
	 S/kUbuAsUi4puHR8yizKDeNQyZT8C4j3d/HnIjn2EgRoaVZpKqlmEGY1wpdNG3x/MoQBT
	 mbdRkDHDL4HEOcX1U/KaqL05Qmad+RV0qnDTj4l0wrj5cBPSCG9aKJ6dD4n7g5nnw9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMwBT6DX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A489606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 04:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMwBT6DX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BC91F01825;
	Sat, 24 Oct 2026 04:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814850;
	bh=lJ+gXVjAjTUc7MW4E9DYp68frI0wTGEvsWclZZGaF7c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PMwBT6DXMUIvSTWFDxAX4TIqd8IaEfIa1HMlJ43gkEWSh4g96IM7wzJQvWIcE3tua
	 50QECk7X3NRhUaPWrtED5sOILI9W6Bw1gK47usCzGiSHX5rbIkisLSZOgmXx3Y+POD
	 lswPz3VKa3ZT6cX59G5fpekaw4AcoHaJlPcHoBQjtHIYMdCwQilV/rF4PauJ+Emi0C
	 YtS90RhycQ1btHVgOqhZiWxSwv76AOk9KHfilm+/z0qHUIJAZ2dY9W9UOTvt1tzNRl
	 C6M5HiEueYsyIM9YKX2uFa1aPBxBB3PU4DK3CEubbDYSEO/YB6ZQB72H8/GNezMnrd
	 jq+hx5zUH78Yw==
Message-ID: <sashiko-outbox-183538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] platform/x86:
 lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <20261024022930.2704030-4-an.wu@canonical.com>
References: <20261024022930.2704030-1-an.wu@canonical.com>
 <20261024022930.2704030-4-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 04:07:29 +0000
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
- [High] serdev: type confusion in serdev_device_match() via driver id_table
--

commit bc4039918b4164f5e3178978c756b91d89a4bde7
Author: ChunAn Wu <an.wu@canonical.com>

platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal se=
rdev matching

This commit switches the Lenovo Yoga Tab 2 Pro 1380 fastcharger driver from
manual driver attachment via device_driver_attach() to standard serdev moda=
lias
matching by passing KBUILD_MODNAME to serdev_device_add() and adding an
id_table to yt2_1380_fc_serdev_driver.

> diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c=
 b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> index 8551ab4d2c7db..d0bd9d4e3137c 100644
> --- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> +++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> @@ -219,11 +219,17 @@ static int yt2_1380_fc_serdev_probe(struct serdev_d=
evice *serdev)
>  	return 0;
>  }
> =20
> +static const struct serdev_device_id yt2_1380_fc_serdev_id[] =3D {
> +	{ KBUILD_MODNAME },
> +	{ }
> +};
> +
>  static struct serdev_device_driver yt2_1380_fc_serdev_driver =3D {
>  	.probe =3D yt2_1380_fc_serdev_probe,
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
>  	},
> +	.id_table =3D yt2_1380_fc_serdev_id,
>  };

[Severity: High]
Does adding id_table to yt2_1380_fc_serdev_driver trigger a type confusion =
and
out-of-bounds read in serdev_device_match() when matching against
serdev_controller devices on serdev_bus_type?

In drivers/tty/serdev/core.c, serdev_controller_alloc() places controller
devices on serdev_bus_type:

    device_initialize(&ctrl->dev);
    ctrl->dev.type =3D &serdev_ctrl_type;
    ctrl->dev.bus =3D &serdev_bus_type;

When yt2_1380_fc_module_init() calls serdev_device_driver_register() for
yt2_1380_fc_serdev_driver (or when a new serdev_controller is added), the
driver core runs serdev_device_match() against every device on
serdev_bus_type, including struct serdev_controller instances:

static int serdev_device_match(struct device *dev, const struct device_driv=
er *drv)
{
	const struct serdev_device *serdev =3D to_serdev_device(dev);
	const struct serdev_device_driver *sdrv =3D to_serdev_device_driver(drv);

	if (acpi_driver_match_device(dev, drv))
		return 1;

	if (of_driver_match_device(dev, drv))
		return 1;

	return !!serdev_match_id(sdrv->id_table, serdev->modalias);
}

Because serdev_device_match() does not check is_serdev_device(dev) before
casting dev with to_serdev_device(dev), and yt2_1380_fc_serdev_driver has no
ACPI or OF match table, serdev_device_match() falls through to
serdev_match_id(sdrv->id_table, serdev->modalias) on struct serdev_controll=
er
devices.

In struct serdev_device, modalias[SERDEV_NAME_SIZE] starts at offset
sizeof(struct device) + 4, which in struct serdev_controller overlaps the
struct device *host pointer, ctrl->nr, ctrl->serdev, ctrl->ops, and extends=
 12
bytes past sizeof(struct serdev_controller). When the overlapping byte at
modalias[0] is non-zero, serdev_match_id() passes that non-string memory and
trailing out-of-bounds bytes to strcmp().

Should serdev_device_match() verify is_serdev_device(dev) before casting dev
to struct serdev_device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024022930.2704=
030-1-an.wu@canonical.com?part=3D3
