Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758383;
	b=zGTmu7V+OlOcnMbvFdFje9GF8WFFrp9baXSeQcSXYFI5tZC+qb7nv3uMdyWN5Z8npQRw
	 2eywDpyuGL+FgM1qI/R9gCfJQIbO1AnESFXDJ2dfJy4vBZDLMFrUTGlM55bgW0ZcDObCa
	 J96RHHjwzepuu43Z2zWdnqv6yS+R/fV1aP6yxihVpMIS5EkstRLZbBS3LhBTFRhVeJ/6i
	 M+zEHNIGEjw8LJF471NMnyVxVJTiZ+rJlSR0fUpEWpPdQwl3Q6N46y14xUmvrCncUs0Nx
	 +66ltRmzvtLUpC48vI+1oMJj8RhpLtHzYxsIsBq5gcFRhFRFbAmnFLbxdDmmZTHhNHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758383;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=nf0GoBf+zbmYMrZwgUpiveOul1P2ZEzoj2Ob2eGnicM=;
	b=S7kMyx1UzTWNXoqFzrNZubkNVhk/ccmlz07D5uhUFjjc10Etsvfbgw1nTpjJ/xT45FH3
	 tp6fk0PYebL3/cIcM/vtcQAXWCMeJG1a+HGV76cfB4gaf6W+8SIXyPFmV/H5J5eXWGWAP
	 weQFyWgw8kc3/ESBLgZ7VzZvyiThF2XV7wR4T5vkuwOuevyHOA4juKE8woGDocndpvpVD
	 l9P++rNPwU558r0ZRkVR0cViy/Ul0t0C8azKUnQV/4+9t9KIzLK4War9XpiGRM/Gvmqqa
	 KydsXXSa4gvq+UNdUbx78tebOVknjnn5SyQATPxa27wbz8nzYuui3HJklpbD4yOZ7ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=NlXdBRNV;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DBD606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 12:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53DBD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=NlXdBRNV
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6B86B240028
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 14:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792758370;
	bh=nf0GoBf+zbmYMrZwgUpiveOul1P2ZEzoj2Ob2eGnicM=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=NlXdBRNV3+jweIooxOEEg/wL18v5j3BtF7TTaxRwlH1hI7oZbdBwHbQI8Z9Nxs/yc
	 ERtGs5hHGiPH9iWeYXtMMUk7cdeB8Y1lcy0pUYzzfp0SS3rz5iF7g2ElKDvl+oF2b7
	 tQFPOJaa0hG+lui7hLDWGJ5M4uKmkPx8xlgaXtDxxSoDAri6RvGM3NyF+bZDNNf4Q2
	 XijePhS0hfE/sVs3cItA1DtaXs4iV26sGz+xErvPyElKHwfL/3LOQirJGohaFiOx/2
	 9nsdxN9V6WuhVmr+D/XE6Okpn4NloWJjwyUA11aoYqfWTkZ8tEtdP72bIEXdThKwFi
	 cJmwt1HjJTN0A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jB2LS5sMJz6v18;
	Fri, 23 Oct 2026 14:26:08 +0200 (CEST)
Message-ID: <f985179ec5ffd2bd558f394c9af9070e8c1e2f75.camel@posteo.de>
Subject: Re: [PATCH v3 1/3] serdev: handle devices without an ACPI or device
 tree node
From: Markus Probst <markus.probst@posteo.de>
To: ChunAn Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com
Date: Fri, 23 Oct 2026 12:26:10 +0000
In-Reply-To: <20261023052717.2577234-2-an.wu@canonical.com>
References: <20261023052717.2577234-1-an.wu@canonical.com>
	 <20261023052717.2577234-2-an.wu@canonical.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-qLuwnwlvdYMO1v3bj2wV"
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


--=-qLuwnwlvdYMO1v3bj2wV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-10-23 at 13:27 +0800, ChunAn Wu wrote:
> Serdev clients instantiated by a driver have no ACPI companion and no
> device tree node. Their modalias read returns -ENODEV, their add uevent
> is suppressed, and they cannot be driver-matched, so creators force a
> bind with device_driver_attach().
>=20
> Resolve both TODOs in the serdev core by modelling matching on the SPI
> bus: add a creator-set modalias to struct serdev_device and an id_table
> to struct serdev_device_driver. ACPI and OF are still tried first;
> clients without their own modalias keep returning -ENODEV. The device
> name, derived from the controller, is unchanged.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> ---
> Changes in v3:
> - Rename struct serdev_device::name to ::modalias; dev_name() is unchange=
d
> - Model matching on the SPI bus: add struct serdev_device_id and
>   id_table; drop driver->name matching
> - Add serdev_device_set_modalias() helper and SERDEV_MODULE_PREFIX
> - No MODULE_DEVICE_TABLE(serdev, ...) support: both in-tree firmware-less
>   clients are created by the same module that provides their driver, so
>   udev has nothing to autoload
>=20
> Changes in v2:
> - Instead of silently returning success with no modalias, use a
>   creator-supplied name as a "serial:<name>" modalias fallback and as
>   the matching key, so clients can bind through normal serdev matching
>=20
Thats something I would expect on the cover letter.
>  MAINTAINERS                      |  1 +
>  drivers/tty/serdev/core.c        | 54 ++++++++++++++++++++++++++++----
>  include/linux/device-id/serdev.h | 16 ++++++++++
>  include/linux/serdev.h           | 34 ++++++++++++++++++++
>  4 files changed, 99 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/device-id/serdev.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 917f3f72e31b..06e67aa5d9b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24905,6 +24905,7 @@ L:	linux-serial@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/serial/serial.yaml
>  F:	drivers/tty/serdev/
> +F:	include/linux/device-id/serdev.h
>  F:	include/linux/serdev.h
>  F:	rust/helpers/serdev.c
>  F:	rust/kernel/serdev.rs
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc21..e178dc57d31b 100644
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
> +	if (!serdev->modalias[0])
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%s%s\n", SERDEV_MODULE_PREFIX, serdev->modalias=
);
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
> +	if (!serdev->modalias[0])
> +		return -ENODEV;
> +
> +	return add_uevent_var(env, "MODALIAS=3D%s%s", SERDEV_MODULE_PREFIX,
> +			      serdev->modalias);
>  }
> =20
>  static void serdev_device_release(struct device *dev)
> @@ -86,16 +101,43 @@ static const struct device_type serdev_ctrl_type =3D=
 {
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
> +	/*
> +	 * Devices which are instantiated by a driver instead of by firmware
> +	 * have no ACPI companion and no device tree node, match them by the
> +	 * modalias their creator gave them.
> +	 */
Drop comment.

> +	serdev =3D to_serdev_device(dev);
> +
> +	return !!serdev_match_id(to_serdev_device_driver(drv)->id_table,
> +				 serdev->modalias);
I think you can drop the `is_serdev_device` check and use

```
const struct serdev_device *serdev =3D to_serdev_device(dev);
const struct serdev_device_driver *sdrv =3D to_serdev_device_driver(drv);
```

in the top.

The function `serdev_device_match` is only used inside the match
callback on the bus type definition. Other bus devices also do not have
this check. It should be safe.

Alternatively `to_serdev_device` in the same expression as the function
call (like with `to_serdev_device_driver`). It should be consistent
(either both as variables or none).

>  }
> =20
>  /**
> diff --git a/include/linux/device-id/serdev.h b/include/linux/device-id/s=
erdev.h
> new file mode 100644
> index 000000000000..1c3b03b7d501
> --- /dev/null
> +++ b/include/linux/device-id/serdev.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef LINUX_DEVICE_ID_SERDEV_H
> +#define LINUX_DEVICE_ID_SERDEV_H
> +
> +/* serdev */
> +
> +/* Large enough to hold the KBUILD_MODNAME of any serdev client driver *=
/
Is this relevant for anyone reading the code? If not, drop the comment.

> +#define SERDEV_NAME_SIZE	40
> +#define SERDEV_MODULE_PREFIX	"serial:"
> +
> +struct serdev_device_id {
> +	char name[SERDEV_NAME_SIZE];
> +	unsigned long driver_data;	/* Data private to the driver */
> +};
In almost any other include/linux/device-id/*.h file, there is a

```
#ifdef __KERNEL__
#include <linux/types.h>
typedef unsigned long kernel_ulong_t;
#endif
```

statement and `kernel_ulong_t` is used.

I don't know why, but there is likely a reason for it. Thus do it the
same way, unless you can explain why this isn't needed here.

> +
> +#endif /* ifndef LINUX_DEVICE_ID_SERDEV_H */
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index b6c3d957ec15..9f91aa3e875d 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -7,7 +7,9 @@
> =20
>  #include <linux/types.h>
>  #include <linux/device.h>
> +#include <linux/device-id/serdev.h>
>  #include <linux/iopoll.h>
> +#include <linux/string.h>
>  #include <linux/uaccess.h>
>  #include <linux/termios.h>
>  #include <linux/delay.h>
> @@ -35,6 +37,10 @@ struct serdev_device_ops {
>   * struct serdev_device - Basic representation of an serdev device
>   * @dev:	Driver model representation of the device.
>   * @nr:		Device number on serdev bus.
> + * @modalias:	Name of the driver to use with this device, or the alias
> + *		for it. Empty for devices enumerated from firmware, which
> + *		are identified through their ACPI companion or their device
> + *		tree node instead. See serdev_device_set_modalias().
>   * @ctrl:	serdev controller managing this device.
>   * @ops:	Device operations.
>   * @write_comp:	Completion used by serdev_device_write() internally
> @@ -43,6 +49,7 @@ struct serdev_device_ops {
>  struct serdev_device {
>  	struct device dev;
>  	int nr;
> +	char modalias[SERDEV_NAME_SIZE];
>  	struct serdev_controller *ctrl;
>  	const struct serdev_device_ops *ops;
>  	struct completion write_comp;
> @@ -58,12 +65,15 @@ struct serdev_device {
>   * @probe:	binds this driver to a serdev device.
>   * @remove:	unbinds this driver from the serdev device.
>   * @shutdown:	shut down this serdev device.
> + * @id_table:	List of serdev devices supported by this driver, used to
> + *		match devices which are not enumerated from firmware.
>   */
>  struct serdev_device_driver {
>  	struct device_driver driver;
>  	int	(*probe)(struct serdev_device *);
>  	void	(*remove)(struct serdev_device *);
>  	void	(*shutdown)(struct serdev_device *);
> +	const struct serdev_device_id *id_table;
Just a suggestion:
Move it directly under driver, so the fields (driver->of_match_table,
driver->acpi_match_table, id_table) are next to each other. It has no
real runtime difference, so I won't complain if you leave it there.

>  };
> =20
>  #define to_serdev_device_driver(d) container_of_const(d, struct serdev_d=
evice_driver, driver)
> @@ -135,6 +145,30 @@ static inline void serdev_device_set_client_ops(stru=
ct serdev_device *serdev,
>  	serdev->ops =3D ops;
>  }
> =20
> +/**
> + * serdev_device_set_modalias() - set the modalias of a serdev device
> + * @serdev:	serdev device.
> + * @modalias:	non-empty modalias to use, typically KBUILD_MODNAME of the
> + *		client driver.
> + *
> + * A serdev device is identified by its ACPI companion, by its device tr=
ee
> + * node, or by a modalias set by its creator. Serdev devices which are
> + * instantiated by a driver rather than by firmware have neither of the
> + * former, so they must set a modalias before serdev_device_add() to be
> + * identifiable. Doing so reports a SERDEV_MODULE_PREFIX modalias to
> + * userspace and makes the device match an id_table entry of a serdev
> + * device driver.
> + *
> + * Devices enumerated from firmware have no modalias of their own and ke=
ep
> + * deriving their modalias and their driver match from firmware only. Th=
e
> + * device name is not affected either way.
> + */
> +static inline void serdev_device_set_modalias(struct serdev_device *serd=
ev,
> +					      const char *modalias)
> +{
> +	strscpy(serdev->modalias, modalias);
> +}
Drop the function.
Add `const char *modalias` as parameter to `serdev_device_add`. It
should be clear that any driver calling this function manually should
provide a modalias. Also, keep documentation simple (unless there is
need).

Either you add `__serdev_device_add` for internal use (of or acpi), or
it will use NULL. Your choice.


Overall, looks pretty good so far.

Thanks
- Markus Probst

> +
>  static inline
>  void *serdev_controller_get_drvdata(const struct serdev_controller *ctrl=
)
>  {

--=-qLuwnwlvdYMO1v3bj2wV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrbUlYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS7I0P/2lAE9rQImaoRku/0PFZ
9UxnSYkMg1SC5CraK0CBZozxuNhJknPxqtgbhthbHPdfBjnhMWCkf1o5Zm5MMmRm
U++vGF+/IndtcQ/c76aYBeOZV3asyTj5J4x5BR3EO2myOka27ownk7x0KxnWrwtr
ZBdrDeY5Vej8mF213KfNvtOh9wYU1HT5wahV8YuoGIoSSuVFBNSzjODXEUqhc3qe
mZfC6yCjin4mgFUvhJU3pKs3rMzY/RLM3S0COSsfBXoRDb97cL2/oD6Q8FC45dEf
jNiHCn0XGLMzRx+lbRCySSi+o2Nm3gw3LgCGpmd05lLWcMF8EfQgqljVY2tJvDmR
BG+PvgZ31fD/N/qAVOGQxdczJ5QjWlm6ekJYCVoUELJEVRJ3/lis93rtgUyi3qwo
kyCfeJf1TJzj5bSADlDIzxA5NzMJ1i6G1Ri0Yd7dvJYqBG4yrBmSMBKNQ3HH5KnH
Dy0DqPpJsQGbpTSjaZytT+CsT8PHRO3x2pXL3qQgh3Q2EKjjV6ytxcdqXK5ZGX+9
Z4nk686YHPfuPBdoKPNz7os4aCv5YBlRR9WBRPonB0SkrH/OliDGa1PrpUqrVdCM
+kVjPEMDOFajpxQSuy6VeaSvJq52rvlQ/CgW5NfdZg/g7K01Zv4cLXtbTsf2NJP0
puM+sDrFLAU1vlYGyM0C/A2D
=h8tr
-----END PGP SIGNATURE-----

--=-qLuwnwlvdYMO1v3bj2wV--
