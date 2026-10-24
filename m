Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814952;
	b=jNqBlxTHNunBJWxWKa2Qdd+02fIfpnVZoOQjBGJb7ziwYLXhY0oCqbpcFs+TzM+v/12+
	 mjYQgvLeOMqx/mqzmRGbeUcsSSl9//Sp8OB66Zvr8lL+qiv2LWZRl5BlYPsf+ECp++Jnw
	 mpPr+gI01Egv6wavk4XIxCceF9DlKvX/p/xMlrb+MK9mAvEoNmeKsoFcHKTgp6AyMSF3y
	 XjqJK7h7Th7chOI2KX/RXOJ5H9ZRvUeZVhmQOuwFbpcpnLZYAvX/w50NABASVRvmlIgTE
	 2qxZwQRqWSC3fMx70NGUW0mfMp+FJauYzhG0/8J8Quf/KL+IDw0wXMIlswEwl4NOhXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814952;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kT7BgyL0KLHW/KUtoyc14qlEBQAVp14d3YqMhm7i2YA=;
	b=PyotoGqx28D1Icg+BiCGT2w7uAYzuIX353f9H7pk6sGE93mRV397BjebS1KgAx32wzAi
	 0N6+rYo3g9Kq77/alSsaKETzG7hYl0GWpk84TIYsWl16PJzfnQg9NLxlODzKm7hxko/pm
	 Hh4vuRron9iSpHjd1xa+ki3Hla1KpQHd0ETf8lYUl/MT4dGT9KfqE6ZvvKLxttS6TFqxv
	 dYnir/ZAIT84h4SS4rcFWsvsByRVpOR6Qu03Qmf78dUOrgCKKXwSZrV5SMyW2Wb/BLJgI
	 nObidHkNFc0eLL2OwChr1Y43lwG9NuSgpP358Ret772uxmWPafOUrgeT/YoPMOlhLsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rk/oyIg6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1409606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rk/oyIg6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE271F01825;
	Sat, 24 Oct 2026 04:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814951;
	bh=kT7BgyL0KLHW/KUtoyc14qlEBQAVp14d3YqMhm7i2YA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Rk/oyIg6pnFUDOhUW5mkqSKVSKifUppH2FSoGIlMrwMqFoy+ScVFqGC/XNwHd8v6X
	 D2YzseWMSv/BvddL5OS3TDa3TEzPL510r0hNuG19v+VNxmsRQtMWhP0pCrQ/U5Jw04
	 yOWTzFsQn3iCjfaHoslrF2soxn7get1OgH7pprRv/P/9aSIgF+ICiT9CVl9CTNbm/8
	 rbRSz5ny9pNlVF1z96XXn2JDO+1Olpr55PpspNfz8ZH/MxEtiNRuYo2KaQs1nTAi49
	 Wq9fnq2aOsGbA22J1SQmYoOjd5xFdPdwCnO+0xGVPLVSIORbPIMit6tttPPCT892+V
	 s5jI79U7sQOnA==
Message-ID: <sashiko-outbox-183539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] serdev: handle devices without an ACPI or device
 tree node
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <20261024022930.2704030-2-an.wu@canonical.com>
References: <20261024022930.2704030-1-an.wu@canonical.com>
 <20261024022930.2704030-2-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 04:09:11 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] serdev: type confusion and OOB read in serdev_device_match() for c=
ontrollers
- [Medium] serdev: missing mod_devicetable and file2alias wiring for serdev=
_device_id
- [Low] serdev: unupdated serdev_device_add() callers break build at this c=
ommit
--

commit 1b3d9973e0d0ff0b39b8ad4f9814e44ecd6e06a9
Author: ChunAn Wu <an.wu@canonical.com>

serdev: handle devices without an ACPI or device tree node

This commit adds modalias and id_table support to the serdev bus so that
serdev client devices instantiated without an ACPI companion or device tree
node can emit uevents and match against serdev device drivers. It also moves
struct serdev_device_id into include/linux/device-id/serdev.h.

> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc218..45175403bd551 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c

[ ... ]

> @@ -70,11 +85,6 @@ static const struct device_type serdev_device_type =3D=
 {
>  	.release	=3D serdev_device_release,
>  };
> =20
> -static bool is_serdev_device(const struct device *dev)
> -{
> -	return dev->type =3D=3D &serdev_device_type;
> -}
> -
>  static void serdev_ctrl_release(struct device *dev)
>  {
>  	struct serdev_controller *ctrl =3D to_serdev_controller(dev);
> @@ -86,28 +96,51 @@ static const struct device_type serdev_ctrl_type =3D {
>  	.release	=3D serdev_ctrl_release,
>  };
> =20
> +static const struct serdev_device_id *serdev_match_id(const struct serde=
v_device_id *id,
> +						      const char *modalias)
> +{
> +	if (!id || !modalias[0])
> +		return NULL;
> +
> +	while (id->name[0]) {
> +		if (!strcmp(modalias, id->name))
> +			return id;
> +		id++;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int serdev_device_match(struct device *dev, const struct device_d=
river *drv)
>  {
> -	if (!is_serdev_device(dev))
> -		return 0;
> +	const struct serdev_device *serdev =3D to_serdev_device(dev);
> +	const struct serdev_device_driver *sdrv =3D to_serdev_device_driver(drv=
);
> =20
> -	/* TODO: platform matching */
>  	if (acpi_driver_match_device(dev, drv))
>  		return 1;
> =20
> -	return of_driver_match_device(dev, drv);
> +	if (of_driver_match_device(dev, drv))
> +		return 1;
> +
> +	return !!serdev_match_id(sdrv->id_table, serdev->modalias);
>  }

[Severity: High]
Is it safe to remove the is_serdev_device(dev) check from
serdev_device_match()?

Unlike the SPI bus where controllers are registered on a class rather than
spi_bus_type, serdev registers both struct serdev_controller and struct
serdev_device onto serdev_bus_type:

drivers/tty/serdev/core.c:serdev_controller_alloc() {
	device_initialize(&ctrl->dev);
	ctrl->dev.type =3D &serdev_ctrl_type;
	ctrl->dev.bus =3D &serdev_bus_type;
	ctrl->dev.parent =3D parent;
	ctrl->host =3D host;
	device_set_node(&ctrl->dev, dev_fwnode(host));
}

Commit 7ee69102dbc4ee ("serdev: only match serdev devices") added the
is_serdev_device(dev) check so controller devices on serdev_bus_type are
ignored during driver matching.

Without that check, when serdev_device_match() is called with dev pointing =
to
&ctrl->dev, it first evaluates acpi_driver_match_device() and
of_driver_match_device() against the controller's fwnode, which could match
and probe a struct serdev_controller as a struct serdev_device.

If neither firmware match succeeds, serdev_device_match() casts &ctrl->dev =
via
to_serdev_device(dev) and passes serdev->modalias to serdev_match_id(). In
struct serdev_device, modalias[SERDEV_NAME_SIZE] starts at offset
sizeof(struct device) + sizeof(int), which in struct serdev_controller alia=
ses
the upper bytes of ctrl->host, followed by ctrl->nr, ctrl->serdev, ctrl->op=
s,
and extends 12 bytes past the end of struct serdev_controller on 64-bit
platforms. Because the upper bytes of the kernel pointer ctrl->host are
non-zero, modalias[0] is non-zero and strcmp(modalias, id->name) will read =
out
of bounds past struct serdev_controller when sdrv->id_table is set.

> diff --git a/include/linux/device-id/serdev.h b/include/linux/device-id/s=
erdev.h
> new file mode 100644
> index 0000000000000..96644953ceced
> --- /dev/null
> +++ b/include/linux/device-id/serdev.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef LINUX_DEVICE_ID_SERDEV_H
> +#define LINUX_DEVICE_ID_SERDEV_H
> +
> +#ifdef __KERNEL__
> +typedef unsigned long kernel_ulong_t;
> +#endif
> +
> +/* serdev */
> +
> +#define SERDEV_NAME_SIZE	40
> +#define SERDEV_MODULE_PREFIX	"serial:"
> +
> +struct serdev_device_id {
> +	char name[SERDEV_NAME_SIZE];
> +	kernel_ulong_t driver_data;	/* Data private to the driver */
> +};
> +
> +#endif /* ifndef LINUX_DEVICE_ID_SERDEV_H */

[Severity: Medium]
Should struct serdev_device_id also be wired up in
include/linux/mod_devicetable.h, scripts/mod/devicetable-offsets.c, and
scripts/mod/file2alias.c?

serdev_device_uevent() emits MODALIAS=3Dserial:<modalias> to userspace, and=
 this
header follows the include/linux/device-id/ pattern used by modpost. Howeve=
r,
without including device-id/serdev.h in include/linux/mod_devicetable.h and
adding the corresponding DEVID(serdev_device_id) and devtable[] entries in
scripts/mod/, MODULE_DEVICE_TABLE(serdev, ...) is silently ignored by
handle_moddevtable() and no serial:<name> aliases are generated for module
autoloading.

> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index b6c3d957ec155..96a441abc1ace 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h

[ ... ]

> @@ -158,7 +168,7 @@ static inline void serdev_controller_put(struct serde=
v_controller *ctrl)
>  }
> =20
>  struct serdev_device *serdev_device_alloc(struct serdev_controller *);
> -int serdev_device_add(struct serdev_device *);
> +int serdev_device_add(struct serdev_device *serdev, const char *modalias=
);
>  void serdev_device_remove(struct serdev_device *);

[Severity: Low]
Does changing the signature of serdev_device_add() here break the build for
bisecting before the follow-up patches in the series?

Two callers in drivers/platform/x86/ still pass a single argument at this
commit:

drivers/platform/x86/dell/dell-uart-backlight.c:dell_uart_bl_pdev_probe() {
	...
	ret =3D serdev_device_add(serdev);
}

drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c:yt2_1380_fc_pd=
ev_probe() {
	...
	ret =3D serdev_device_add(serdev);
}

Those two callers are updated to pass KBUILD_MODNAME in the subsequent comm=
its
"platform/x86: dell-uart-backlight: Bind through normal serdev matching" and
"platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal
serdev matching", but at this commit (and the next commit for
yoga-tab2-pro-1380-fastcharger.c) building with CONFIG_DELL_UART_BACKLIGHT =
or
CONFIG_YOGA_TAB2_PRO_1380_FASTCHARGER enabled fails with too few arguments =
to
serdev_device_add(). Could those callers be updated to pass NULL in this
commit so every patch in the series builds cleanly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024022930.2704=
030-1-an.wu@canonical.com?part=3D1
