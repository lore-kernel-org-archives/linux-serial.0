Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792846747;
	b=QkZuaYAMmGnEnQ3Q7zpcpGKsp7eutbxYvW4kRYYfhr7smoDLNcNLZEIV7mAx45wHO/P+
	 9jgnknXo+EiQSUnmUNFJs0I7drnoJhkkdQ2fq3/e7J5Ttzsqb6hCKH4cbvUAqyaZGAQ+R
	 LmWMdFMEgN9Qxml4gZ4xAxs9y66UQVKYdtQbJqjv8Ai+U/W9LeBWmSJ/nzmiLhfAk8Vwx
	 IqCBK/XRj7p/CEs+fwUWDGfXVpZqBnSg58TPfe92OGN+shsd6n1dzoQUQAhRBx8YvLqlD
	 vl9zq/pAAb39P4q6wF4l5F7h9R0V55mhwIpKvADmC+Bl8VAF2zh3JoL1l2LFzr165nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792846747;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=LUvyJQ1zjyOa9Odd6dqvliPzy8Me0ScGpoMY+ONU08w=;
	b=EhqnzAnRuUvzkKS6rRZtw3CwiUoBxK3YaLe126qQrZEqfqEsvN8dc+OlFeq6r9w9hAG9
	 V/CJ2u6RutSss3hEwZFL9g6WNnhcmln9jSU5XzS5yWCoiMasoZlZEA2lQQxrZAEgHRaxl
	 82vmsZ4IUFWU8AIO73lqNpNS7DoRuanIwMdi7jWWNxW4HKXNa35phCijFrsIhzocsLWeU
	 2ceOxHL24vQSFLINnQnI3XtAc4sdxa72eSvSPwx61zIiMGNh/rRkg63DZBCLDh/OkFsR4
	 RW0x4Vfv65gSKuADCemoJnMW0tLqy9Ou3NhBJjbShrSjvk2DojL8fSVbOKbr6srViyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=jDiAiFCy;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42EB606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 12:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D42EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=jDiAiFCy
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1255324002B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 14:58:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792846738;
	bh=LUvyJQ1zjyOa9Odd6dqvliPzy8Me0ScGpoMY+ONU08w=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=jDiAiFCy+WdTVY3X7/ngZcwWiMzR5Ny7gK0gRMQPuHpazwGq5+8Zpzjkf6ybQnOgs
	 bo1lrZDf76uoAnXEtxjesBNOoO6I9RpkOUGvmh5vgtw/Didhbzo+Z+GnD2cbdeqs3u
	 FqFahEUVav80f3mCG6c8aR+u+vpsJ9zETPX+V4Yn0iqTH0aUBM6M9e7XWD3YovXi9M
	 Zuollomx3zzTtURUeZXYqr04clgQCSAp2ML74eCxXpj/xLbhO1MDrilkL/7kBenIMM
	 fed9K7HZInWAaMogInXlQH135L5MqdgorkkRoRrE+0Lqj3It7zXyyZ6vWhF9abDG8A
	 sUmaZewCS/Daw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jBg1r5T9Hz6tyK;
	Sat, 24 Oct 2026 14:58:56 +0200 (CEST)
Message-ID: <b66d47a456bddb23deaf1c4c625b0029dde0e9a5.camel@posteo.de>
Subject: Re: [PATCH v5 1/3] serdev: handle devices without an ACPI or device
 tree node
From: Markus Probst <markus.probst@posteo.de>
To: ChunAn Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com
Date: Sat, 24 Oct 2026 12:58:57 +0000
In-Reply-To: <f3ec60d4e68819c994a0d4c6d44eb5cf8d511ddb.1792831564.git.an.wu@canonical.com>
References: <cover.1792831564.git.an.wu@canonical.com>
	 <f3ec60d4e68819c994a0d4c6d44eb5cf8d511ddb.1792831564.git.an.wu@canonical.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-npcyj5MqnDOl+NF7wk6J"
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


--=-npcyj5MqnDOl+NF7wk6J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-10-24 at 20:04 +0800, ChunAn Wu wrote:
> Serdev clients instantiated by a driver have no ACPI companion and no
> device tree node. Their modalias read returns -ENODEV, their add uevent
> is suppressed, and they cannot be driver-matched, so creators force a
> bind with device_driver_attach().
>=20
> Resolve both TODOs in the serdev core by modelling matching on the SPI
> bus: let the creator pass a modalias to serdev_device_add() and give
> struct serdev_device_driver an id_table. ACPI and OF are still tried
> first; clients without their own modalias keep returning -ENODEV. The
> device name, derived from the controller, is unchanged.
>=20
> Split struct serdev_device_id and its defines into a new
> include/linux/device-id/serdev.h, following the pattern already used by
> the SPI and I2C buses.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> ---
>  MAINTAINERS                                   |  1 +
>  .../platform/x86/x86-android-tablets/core.c   |  2 +-
>  drivers/power/sequencing/pwrseq-pcie-m2.c     |  2 +-
>  drivers/tty/serdev/core.c                     | 62 ++++++++++++++++---
>  include/linux/device-id/serdev.h              | 19 ++++++
>  include/linux/serdev.h                        | 12 +++-
>  6 files changed, 86 insertions(+), 12 deletions(-)
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
> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/pl=
atform/x86/x86-android-tablets/core.c
> index cfff7f5eac5d..853aa6ff5d50 100644
> --- a/drivers/platform/x86/x86-android-tablets/core.c
> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> @@ -317,7 +317,7 @@ static __init int x86_instantiate_serdev(const struct=
 x86_dev_info *dev_info, in
>  	ACPI_COMPANION_SET(&serdev->dev, serdev_adev);
>  	acpi_device_set_enumerated(serdev_adev);
> =20
> -	ret =3D serdev_device_add(serdev);
> +	ret =3D serdev_device_add(serdev, NULL);
>  	if (ret) {
>  		dev_err(&serdev->dev, "error %d adding serdev\n", ret);
>  		serdev_device_put(serdev);
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index e42e85f47629..e0482f2ef39f 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -309,7 +309,7 @@ static int pwrseq_pcie_m2_create_serdev_one(struct pw=
rseq_pcie_m2_ctx *ctx,
>  	if (ret)
>  		goto err_free_serdev;
> =20
> -	ret =3D serdev_device_add(pci_dev->serdev);
> +	ret =3D serdev_device_add(pci_dev->serdev, NULL);
>  	if (ret) {
>  		dev_err(dev, "Failed to add serdev for PCI device (%s): %d\n",
>  			pci_name(pdev), ret);
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc21..e0517d5a48da 100644
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
> @@ -86,28 +101,57 @@ static const struct device_type serdev_ctrl_type =3D=
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
> +	const struct serdev_device_driver *sdrv;
> +
>  	if (!is_serdev_device(dev))
>  		return 0;
> =20
> -	/* TODO: platform matching */
> +	serdev =3D to_serdev_device(dev);
> +	sdrv =3D to_serdev_device_driver(drv);
> +
>  	if (acpi_driver_match_device(dev, drv))
>  		return 1;
> =20
> -	return of_driver_match_device(dev, drv);
> +	if (of_driver_match_device(dev, drv))
> +		return 1;
> +
> +	return !!serdev_match_id(sdrv->id_table, serdev->modalias);
>  }
> =20
>  /**
>   * serdev_device_add() - add a device previously constructed via serdev_=
device_alloc()
>   * @serdev:	serdev_device to be added
> + * @modalias:	Driver name or alias, used to match devices which have nei=
ther
> + *		an ACPI companion nor a device tree node. NULL for devices
> + *		enumerated from firmware.
>   */
> -int serdev_device_add(struct serdev_device *serdev)
> +int serdev_device_add(struct serdev_device *serdev, const char *modalias=
)
>  {
>  	struct serdev_controller *ctrl =3D serdev->ctrl;
>  	struct device *parent =3D serdev->dev.parent;
>  	int err;
> =20
> +	if (modalias)
> +		strscpy(serdev->modalias, modalias);
> +
>  	dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr);
> =20
>  	/* Only a single slave device is currently supported. */
> @@ -553,7 +597,7 @@ static int of_serdev_register_devices(struct serdev_c=
ontroller *ctrl)
> =20
>  		device_set_node(&serdev->dev, of_fwnode_handle(node));
> =20
> -		err =3D serdev_device_add(serdev);
> +		err =3D serdev_device_add(serdev, NULL);
>  		if (err) {
>  			dev_err(&serdev->dev,
>  				"failure adding device. status %pe\n",
> @@ -707,7 +751,7 @@ static acpi_status acpi_serdev_register_device(struct=
 serdev_controller *ctrl,
>  	ACPI_COMPANION_SET(&serdev->dev, adev);
>  	acpi_device_set_enumerated(adev);
> =20
> -	err =3D serdev_device_add(serdev);
> +	err =3D serdev_device_add(serdev, NULL);
>  	if (err) {
>  		dev_err(&serdev->dev,
>  			"failure adding ACPI serdev device. status %pe\n",
> diff --git a/include/linux/device-id/serdev.h b/include/linux/device-id/s=
erdev.h
> new file mode 100644
> index 000000000000..96644953cece
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
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index b6c3d957ec15..96a441abc1ac 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -7,7 +7,9 @@
> =20
>  #include <linux/types.h>
>  #include <linux/device.h>
> +#include <linux/device-id/serdev.h>
>  #include <linux/iopoll.h>
> +#include <linux/string.h>
Unused include.

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
> + *		tree node instead. See serdev_device_add().
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
> @@ -55,12 +62,15 @@ struct serdev_device {
>   * struct serdev_device_driver - serdev slave device driver
>   * @driver:	serdev device drivers should initialize name field of this
>   *		structure.
> + * @id_table:	List of serdev devices supported by this driver, used to
> + *		match devices which are not enumerated from firmware.
>   * @probe:	binds this driver to a serdev device.
>   * @remove:	unbinds this driver from the serdev device.
>   * @shutdown:	shut down this serdev device.
>   */
>  struct serdev_device_driver {
>  	struct device_driver driver;
> +	const struct serdev_device_id *id_table;
>  	int	(*probe)(struct serdev_device *);
>  	void	(*remove)(struct serdev_device *);
>  	void	(*shutdown)(struct serdev_device *);
> @@ -158,7 +168,7 @@ static inline void serdev_controller_put(struct serde=
v_controller *ctrl)
>  }
> =20
>  struct serdev_device *serdev_device_alloc(struct serdev_controller *);
> -int serdev_device_add(struct serdev_device *);
> +int serdev_device_add(struct serdev_device *serdev, const char *modalias=
);
>  void serdev_device_remove(struct serdev_device *);
> =20
>  struct serdev_controller *serdev_controller_alloc(struct device *host,

You will need to address the sashiko report (both are true positives).

In the scripts/mod/file2alias.c file, you can copy the spi entry.
scripts/mod/devicetable-offsets.{h,c,s} and
include/linux/mod_devicetable.h are also relevant for this.
(Didn't know myself those files existed, so thx Sashiko)

Also add serdev_device_id to scripts/coccinelle/misc/of_table.cocci .


With that fixed,

Reviewed-by: Markus Probst <markus.probst@posteo.de>


Thanks
- Markus Probst

--=-npcyj5MqnDOl+NF7wk6J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrcq4MbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSV/8P+QHxKkO3OWRO5ZTjlET0
ynDBkYi76/wwfHEvaZFP0ASnhtad9vK4Hi9rUGmz3A1D+ezyEbVmi92ZKSPCPscJ
5/zeF68FyyyCsZmgg/h9KgrRC/NTKtmrJE+Z4DXF3DRIf1LlrO+ITyiBnTe6bZoF
mrYOSLH2aAgYfNS+Z22rAI4AfFLefm9gS4xint/cknjyxHRub9bq0X5ku94t1adf
nDu8EDB6OQpBanktYsqgE6kzjzzif+zb67MvBzMq/CX4QLl1JfQXmzLeMruE4ifA
0NgvkO+CMpwUGGvfnu+WMvsbsyDAoEgYnORNmzaPC62zlMjH6BcgDqibspdlPFrm
rtSNWzx44gqal0Q2N++i+GAGgC99T6hSGJfEidgsdiaijYubW26aghHnIKdQlCm1
dCHB6cyyjMBV51j/y+KaDeCUY6V4EyWbbWDqQAWBRgbc9bNXjK0B+wkx2C8NXmtP
zzA0pcaun3nNwkLX8w/AustJcsgFEX2e3L2ES3PC2vGAdMHykUGumAjf31UENGrG
890E4d3yfajunawKBxcN3cn/lzJ95hrIFq49lWeIP+9lowRkI6xjQNVp1JX8/uC6
11Xo5VpHr7MFoJq5brFVDvcz/m583h5pzkFCvzLXQAnUC13L2xRDS3H7n5gxewm/
Kaea0ZW7Za+fjKZI2FUhKoSX
=sLdq
-----END PGP SIGNATURE-----

--=-npcyj5MqnDOl+NF7wk6J--
