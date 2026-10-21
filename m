Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589954;
	b=UXuhAQdJwnozrsYEXqeDLdd+/bi+TQ/l30vIdN+x/mNRarzBs+HyhZXNdSWN7ZdiD2lm
	 +HMDBOsjqB8YT+dwKLrOk9o9N2q26QcVIBLuN+zNOV9cJ1u3j0SkHvuUZ7ePLvEFIyEzp
	 6Q0DnBWwPFutt/eDc1tQzKpvRYZKibnH8+gmHyZF0I6CmqTkgPRohvkXPF1AB9S/8MlF8
	 cGQ4kyHwvACZ3hpmeJ4rscareMjF2OcWciEp1pehWBgq6vJgUXu1Yhj0Pelqxkyb0eyIZ
	 9skZVUyaPSisJXGffA3QYuJ+2LpNkZo3HI6dQtxUGA1FN8fBYMNVJeEWl/oap8zrt8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589954;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=8xqwOwW4tnu2Hh5iatDFQpq5avqjzl6UVLeiZ8m5Ir8=;
	b=1OclcibqRmAM2JSTGyX82ZENCUllGepDTMYZ83FPwPHqCiN2WwhSU6tNBdB1SyXzGXM8
	 WCX5GqhFdzixmflgGKvMfzBN8of7Dm2fsnr1G20FhLxHLVHp0go7Tqi5nI+di9iWSKonf
	 wJ0MiTETErI0ObzyaLCH2/Wx8Zxw9aO8GSGJ5IxD7EM/a8g6fy+8z5tuEHeKv/e38r59H
	 jA1KTFdFNKOIT/G7C/83pkkpGX9OlcrEFIf/PsL1T8acn2SyeHnuT9sV8AhXmIasjq4ih
	 M242ZjLVkfr4znXZS7+40wjlgYxqQdjvvP6iy6ndawtVtSyPfq/O9mbSPnZ0kfrRWWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=b14DOBKM;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD819606A31B
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 13:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD819606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=b14DOBKM
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4FF3A240107
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 15:39:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792589945;
	bh=8xqwOwW4tnu2Hh5iatDFQpq5avqjzl6UVLeiZ8m5Ir8=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=b14DOBKMQG5ll034i7gPx857so2Kb1Qotn8fqIwEB6KNZntI+J4IdHjHuu2ptZU21
	 eaHDucZnpiACh3mwa1F0gV8SsMb1Fk9AXM63yDOywfQTvYTxpapz8VAExJt1BCEAkd
	 xPdNKP565Ce52BsLhp7MpJn4UEJo8gPKOCmSM9zBjCOykm6J49Qss+AVoAjWhzNDgq
	 CzQCcniLTAOfj0WKIo4QhYfOB01eLvO1iHxs/G11tNAPXotGFjghQg6xpUTIOAk3Qw
	 Q4vwZhltccr6VW6t49uVJird6jrSA+FiWwxleO44qM5yVAGCEJ5R6ykOIqtau97xAX
	 TqsWo8s3exkRA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j8r3V1Xn9z9rxF;
	Wed, 21 Oct 2026 15:39:02 +0200 (CEST)
Message-ID: <0be5624e3778c3426f88daf2d67376435f474497.camel@posteo.de>
Subject: Re: [PATCH v2 1/3] serdev: handle devices without an ACPI or device
 tree node
From: Markus Probst <markus.probst@posteo.de>
To: ChunAn Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com
Date: Wed, 21 Oct 2026 13:39:04 +0000
In-Reply-To: <20261021092124.2306053-1-an.wu@canonical.com>
References: <20261021092124.2306053-1-an.wu@canonical.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-GE1p2TeaP8kkYjvMcrqu"
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-GE1p2TeaP8kkYjvMcrqu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-21 at 17:21 +0800, ChunAn Wu wrote:
> Driver-created serdev clients may lack an ACPI companion or device tree
> node.
>=20
> Add a creator-supplied name for these clients. Use it as a serial
> modalias fallback and to match a serdev driver of the same name. Keep
> returning -ENODEV for unnamed clients.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> ---
>  drivers/tty/serdev/core.c | 36 ++++++++++++++++++++++++++++++------
>  include/linux/serdev.h    | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc21..8354a4688fd8 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -29,13 +29,21 @@ static DEFINE_IDA(ctrl_ida);
>  static ssize_t modalias_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> +	const struct serdev_device *serdev =3D to_serdev_device(dev);
>  	int len;
> =20
>  	len =3D acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
>  	if (len !=3D -ENODEV)
>  		return len;
> =20
> -	return of_device_modalias(dev, buf, PAGE_SIZE);
> +	len =3D of_device_modalias(dev, buf, PAGE_SIZE);
> +	if (len !=3D -ENODEV)
> +		return len;
> +
> +	if (!serdev->name[0])
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%s%s\n", SERDEV_MODULE_PREFIX, serdev->name);
>  }
>  static DEVICE_ATTR_RO(modalias);
> =20
> @@ -47,15 +55,22 @@ ATTRIBUTE_GROUPS(serdev_device);
> =20
>  static int serdev_device_uevent(const struct device *dev, struct kobj_ue=
vent_env *env)
>  {
> +	const struct serdev_device *serdev =3D to_serdev_device(dev);
>  	int rc;
> =20
> -	/* TODO: platform modalias */
> -
>  	rc =3D acpi_device_uevent_modalias(dev, env);
>  	if (rc !=3D -ENODEV)
>  		return rc;
> =20
> -	return of_device_uevent_modalias(dev, env);
> +	rc =3D of_device_uevent_modalias(dev, env);
> +	if (rc !=3D -ENODEV)
> +		return rc;
> +
> +	if (!serdev->name[0])
> +		return -ENODEV;
> +
> +	add_uevent_var(env, "MODALIAS=3D%s%s", SERDEV_MODULE_PREFIX, serdev->na=
me);
> +	return 0;
>  }
> =20
>  static void serdev_device_release(struct device *dev)
> @@ -88,14 +103,23 @@ static const struct device_type serdev_ctrl_type =3D=
 {
> =20
>  static int serdev_device_match(struct device *dev, const struct device_d=
river *drv)
>  {
> +	const struct serdev_device *serdev;
> +
>  	if (!is_serdev_device(dev))
>  		return 0;
> =20
> -	/* TODO: platform matching */
>  	if (acpi_driver_match_device(dev, drv))
>  		return 1;
> =20
> -	return of_driver_match_device(dev, drv);
> +	if (of_driver_match_device(dev, drv))
> +		return 1;
> +
> +	/* Fall back to the name set by the creator of the device */
> +	serdev =3D to_serdev_device(dev);
> +	if (!serdev->name[0])
> +		return 0;
> +
> +	return strcmp(serdev->name, drv->name) =3D=3D 0;
>  }
> =20
>  /**
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index b6c3d957ec15..26baa0321eef 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -8,6 +8,7 @@
>  #include <linux/types.h>
>  #include <linux/device.h>
>  #include <linux/iopoll.h>
> +#include <linux/string.h>
>  #include <linux/uaccess.h>
>  #include <linux/termios.h>
>  #include <linux/delay.h>
> @@ -19,6 +20,10 @@ struct serdev_device;
>   * serdev device structures
>   */
> =20
> +/* Large enough to hold the KBUILD_MODNAME of any serdev client driver *=
/
> +#define SERDEV_NAME_SIZE	40
> +#define SERDEV_MODULE_PREFIX	"serial:"
Move into include/linux/device-id/, see below first.

> +
>  /**
>   * struct serdev_device_ops - Callback operations for a serdev device
>   * @receive_buf:	Function called with data received from device;
> @@ -35,6 +40,9 @@ struct serdev_device_ops {
>   * struct serdev_device - Basic representation of an serdev device
>   * @dev:	Driver model representation of the device.
>   * @nr:		Device number on serdev bus.
> + * @name:	Name of the device, set by its creator, empty for devices
> + *		which are enumerated from firmware, see
> + *		serdev_device_set_name().
>   * @ctrl:	serdev controller managing this device.
>   * @ops:	Device operations.
>   * @write_comp:	Completion used by serdev_device_write() internally
> @@ -43,6 +51,7 @@ struct serdev_device_ops {
>  struct serdev_device {
>  	struct device dev;
>  	int nr;
> +	char name[SERDEV_NAME_SIZE];
>  	struct serdev_controller *ctrl;
>  	const struct serdev_device_ops *ops;
>  	struct completion write_comp;
> @@ -135,6 +144,28 @@ static inline void serdev_device_set_client_ops(stru=
ct serdev_device *serdev,
>  	serdev->ops =3D ops;
>  }
> =20
> +/**
> + * serdev_device_set_name() - set the name of a serdev device
> + * @serdev:	serdev device.
> + * @name:	non-empty name to use, typically KBUILD_MODNAME of the client
> + *		driver.
> + *
> + * A serdev device is identified by its ACPI companion, by its device tr=
ee
> + * node, or by a name set by its creator. Serdev devices which are
> + * instantiated by a driver rather than by firmware have neither of the
> + * former, so they must set a name before serdev_device_add() to be
> + * identifiable. Doing so gives them a SERDEV_MODULE_PREFIX modalias and
> + * makes them match a serdev device driver of the same name.
> + *
> + * Devices enumerated from firmware have no name and keep deriving their
> + * modalias and their driver match from firmware only.
> + */
> +static inline void serdev_device_set_name(struct serdev_device *serdev,
> +					  const char *name)
> +{
> +	strscpy(serdev->name, name);
> +}
> +
If you set a name via `serdev_device_set_name()`, the actual device
name will still be "serial0-0" or similar.

I don't think we should change the actual device name though, as it is
a potentially breaking change.

Instead we should name the field "modalias" like in the spi bus. So its
clear it doesn't represent the device name.


Also add

`const struct serdev_device_id *id_table;`

to `struct serdev_device_driver`.
This makes it more consistent with other bus devices. It makes it also
possible to handle multiple serial devices (without fwnode), including
storing different private data.

You will have to define serdev_device_id first inside
`include/linux/device-id/`.

Thanks
- Markus Probst


>  static inline
>  void *serdev_controller_get_drvdata(const struct serdev_controller *ctrl=
)
>  {
>=20
> base-commit: 9e947d96915af63e28896caae85a81b74855621b

--=-GE1p2TeaP8kkYjvMcrqu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrYwGgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSWKwQAJp9Uc5NOiveSjZseSnQ
21s2zT2RQWawJhdkCwnIywYfmBrEPOryhvDwyCY5StmRL7A1DC3Yb+KWR+gGa3GB
8CpI+DDeZ8U+G8Ws5hH4Pj4qzRsqvuVpV/yUaS7xb1T/2Hvjgqu6/1aaVO+aZIyL
0udltcVz1GFdshGqx39oej9zASKroOQ7ElpEW3+Av9x48ryyAFaJHqUeBGdmkJKf
OVuloCMRyY/cz7J8+ZoMV17MA0kuoDUypMJbbR3amnUEgeCBWLwDFfWsL/XC9Z1u
T1PXUy8ScXRdBlJLJIutzNy+V3ihzWb8nE6Hrw6LRpu/St84Hlf69u/sBC1WKjim
CxEEwBw1iYNfCVZGAMtcmmKboZmEQ0+a58aik75LsyPFbBNcxhKmVw+459G2GwKV
UUsEf9Wsa6Q5qfNGnfmW/ke9tCilBDB4DPMA1ocslNUEyV7ItQRn/R0Hf1Q43eYT
/DG3ctXr8HnCx7VuQQP7LtO2Y08jMZVc1XlKso3xw835d/eU+PNNZ7QE29txm0e4
b94Oo8DBy4/uAMyaROY8vjSXGNDKcz1/HMl/Sjm2ZeVnuM8F76pueda/b5xj6CJ9
WijCjR+n/62QDF7wF5M+M+XO49wpLEAKxpLYQ0Q+QqtptdEl0Y2P7mZYlYj/p6NU
Dx147tFhKJWRZshey/k15GxF
=jKaf
-----END PGP SIGNATURE-----

--=-GE1p2TeaP8kkYjvMcrqu--
