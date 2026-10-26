Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023203;
	b=j+Rj17iyUSt5UJOOOUn02bOYMlM1PKGYwq0WfvztnRzhMOiO1Emy4Wxre6PKVemU0whN
	 jPLvUWnLy2Zo70N8EnOKvyYvMTsHJCr3ZNyS9vawi7tAZxEkccGweBZZ8Ml4qW7dZvtw7
	 5GmrwI8QEa5hjp2rw8NOTcSF7EEiNzaUEvvgTmqO9cB0X+a5jk5LlUz9415yHCDcywNZa
	 TTUh82x20di+4nAuOdIWjZiDTYbg7SVva8Oq6I6DDOUj0j5/7mwN1UkVQrpuvtsD1P7IB
	 rUKg20kqS6JIk+PrIi9Mn+OhqSuX4EeDFRRKSy+X530R/46fW+DR9nLaBbNGGxQjEvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023203;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=SniqDdNsHkFLgiC5gBtrMn/jZm/7wtXRwdvj7tv4wDk=;
	b=N8Jp5LZN4cn15I9J86+yGum20vDHfrIVrR2midWIeZSohZiGlDWOOG4/JwTlARzt+M0o
	 2Y3GMtnEqJ3Utnf7zb1zs+TMf0SGmy0/1mOXcGcAwjRH7IbPu9w3EyzotUPnWWnhR57uj
	 UxZ49TPHlcpRuIwWBGD/nzdYzOO1QagZWTsnSwQVkfEh4YsDrRnGpZgKqsF7rgiT81i6p
	 xO9BvXUEuMiX0lphcapO3QNj506e4yPBR3cvaQckKxnBvZjPQpq6mNTWokndZymjWsSnu
	 Mpa9dzbw+i0k7+Hff6SOomQNUrdl+i7jbVUZMEGEKvwyvCXdvB/tUkcBdduwRnuGZAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=fxk7NGws;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA42606A31A
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 13:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA42606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=fxk7NGws
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3BA98240106
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 14:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1793023192;
	bh=SniqDdNsHkFLgiC5gBtrMn/jZm/7wtXRwdvj7tv4wDk=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=fxk7NGws3mAdScMcRT+y2pC4jpu+eoO+rAaCpu6O2jdS3hoNJNzm5hlI+N8cbCnt9
	 GgRrb/ikfYC/n9tLkV25eEgtyi8uISpdb3M07yWbUdQ1c1YYVc4ZMGSaoQgoDyJTrt
	 IitlF0H8xhI61jB/9M2Z3lnyo5naqZkMDO8ESk6K/XR13CbY4jzHFS6QHQcKDEMwOe
	 tiOJbz8utzhc3HaWnm59iL94UlyhMP4vxdn77BmwDu2d1TXsCcB7gXaJw7sDkLX8TM
	 0+kYmQjIEvJXu1vEpEssktJH7coMTLj8IDxVn9/7vwufFdJXek7ewPURdxlgiqtgFK
	 AwRRq37l3jcUQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jCwHB3938z9rxQ;
	Mon, 26 Oct 2026 14:59:50 +0100 (CET)
Message-ID: <75e6d86340073638d966acb85465c28e6a08ceda.camel@posteo.de>
Subject: Re: [PATCH v6 1/3] serdev: handle devices without an ACPI or device
 tree node
From: Markus Probst <markus.probst@posteo.de>
To: ChunAn Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com
Date: Mon, 26 Oct 2026 13:59:51 +0000
In-Reply-To: <263a607c3602f31a3f6fdd245e3c2008cdf97abd.1792856688.git.an.wu@canonical.com>
References: <cover.1792856688.git.an.wu@canonical.com>
	 <263a607c3602f31a3f6fdd245e3c2008cdf97abd.1792856688.git.an.wu@canonical.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-bCRNCTcGwwWunRlL32Dh"
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


--=-bCRNCTcGwwWunRlL32Dh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-10-25 at 10:03 +0800, ChunAn Wu wrote:
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
> the SPI and I2C buses, and wire the new ID struct up in file2alias and
> the of_table coccinelle check.
>=20
> Update the existing serdev_device_add() callers to pass NULL. The two
> in-tree firmware-less clients (dell-uart-backlight, yoga-tab2-pro-1380
> fastcharger) also pass NULL here so the tree keeps building across the
> series; the two following patches switch them to a real modalias and
> drop their force_attach workarounds.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> ---
>  MAINTAINERS                                   |  1 +
>  .../platform/x86/dell/dell-uart-backlight.c   |  2 +-
>  .../lenovo/yoga-tab2-pro-1380-fastcharger.c   |  2 +-
>  .../platform/x86/x86-android-tablets/core.c   |  2 +-
>  drivers/power/sequencing/pwrseq-pcie-m2.c     |  2 +-
>  drivers/tty/serdev/core.c                     | 62 ++++++++++++++++---
>  include/linux/device-id/serdev.h              | 19 ++++++
>  include/linux/mod_devicetable.h               |  1 +
>  include/linux/serdev.h                        | 11 +++-
>  scripts/coccinelle/misc/of_table.cocci        | 16 ++---
>  scripts/mod/devicetable-offsets.c             |  3 +
>  scripts/mod/file2alias.c                      |  9 +++
>  12 files changed, 108 insertions(+), 22 deletions(-)
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
> diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/pl=
atform/x86/dell/dell-uart-backlight.c
> index f323a667dc2d..f076cfac2bc5 100644
> --- a/drivers/platform/x86/dell/dell-uart-backlight.c
> +++ b/drivers/platform/x86/dell/dell-uart-backlight.c
> @@ -354,7 +354,7 @@ static int dell_uart_bl_pdev_probe(struct platform_de=
vice *pdev)
>  	if (!serdev)
>  		return -ENOMEM;
> =20
> -	ret =3D serdev_device_add(serdev);
> +	ret =3D serdev_device_add(serdev, NULL);
>  	if (ret) {
>  		dev_err(&pdev->dev, "error %d adding serdev\n", ret);
>  		serdev_device_put(serdev);
> diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c=
 b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> index 8551ab4d2c7d..5e568fe1162d 100644
> --- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> +++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> @@ -260,7 +260,7 @@ static int yt2_1380_fc_pdev_probe(struct platform_dev=
ice *pdev)
>  	/* The fwnode is a managed node, so it will be auto-put on serdev_devic=
e_put() */
>  	fwnode_handle_get(dev_fwnode(&serdev->dev));
> =20
> -	ret =3D serdev_device_add(serdev);
> +	ret =3D serdev_device_add(serdev, NULL);
>  	if (ret) {
>  		serdev_device_put(serdev);
>  		return dev_err_probe(&pdev->dev, ret, "adding serdev\n");
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
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_deviceta=
ble.h
> index 318c4b5c3451..4cb18c41254a 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -52,6 +52,7 @@
>  #include "device-id/rpmsg.h"
>  #include "device-id/sdio.h"
>  #include "device-id/sdw.h"
> +#include "device-id/serdev.h"
>  #include "device-id/serio.h"
>  #include "device-id/slim.h"
>  #include "device-id/spi.h"
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index b6c3d957ec15..81528c69456a 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/types.h>
>  #include <linux/device.h>
> +#include <linux/device-id/serdev.h>
>  #include <linux/iopoll.h>
>  #include <linux/uaccess.h>
>  #include <linux/termios.h>
> @@ -35,6 +36,10 @@ struct serdev_device_ops {
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
> @@ -43,6 +48,7 @@ struct serdev_device_ops {
>  struct serdev_device {
>  	struct device dev;
>  	int nr;
> +	char modalias[SERDEV_NAME_SIZE];
>  	struct serdev_controller *ctrl;
>  	const struct serdev_device_ops *ops;
>  	struct completion write_comp;
> @@ -55,12 +61,15 @@ struct serdev_device {
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
> @@ -158,7 +167,7 @@ static inline void serdev_controller_put(struct serde=
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
> diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/=
misc/of_table.cocci
> index 17881cb0884b..3b6dc2c13703 100644
> --- a/scripts/coccinelle/misc/of_table.cocci
> +++ b/scripts/coccinelle/misc/of_table.cocci
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/// Make sure (of/i2c/platform/spi)_device_id tables are NULL terminated
> +/// Make sure (of/i2c/platform/serdev/spi)_device_id tables are NULL ter=
minated
>  //
> -// Keywords: of_table i2c_table platform_table
> +// Keywords: of_table i2c_table platform_table serdev_table
>  // Confidence: Medium
>  // Options: --include-headers
> =20
> @@ -15,14 +15,14 @@ identifier var, arr;
>  expression E;
>  @@
>  (
> -struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_devi=
ce_id\) arr[] =3D {
> +struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_d=
evice_id \| spi_device_id\) arr[] =3D {
>  	...,
>  	{
>  	.var =3D E,
>  *	}
>  };
>  |
> -struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_devi=
ce_id\) arr[] =3D {
> +struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_d=
evice_id \| spi_device_id\) arr[] =3D {
>  	...,
>  *	{ ..., E, ... },
>  };
> @@ -33,7 +33,7 @@ identifier var, arr;
>  expression E;
>  @@
>  (
> -struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_devi=
ce_id\) arr[] =3D {
> +struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_d=
evice_id \| spi_device_id\) arr[] =3D {
>  	...,
>  	{
>  	.var =3D E,
> @@ -42,7 +42,7 @@ struct \(of_device_id \| i2c_device_id \| platform_devi=
ce_id \| spi_device_id\)
>  +	{ }
>  };
>  |
> -struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_devi=
ce_id\) arr[] =3D {
> +struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_d=
evice_id \| spi_device_id\) arr[] =3D {
>  	...,
>  	{ ..., E, ... },
>  +	{ },
> @@ -55,7 +55,7 @@ identifier var, arr;
>  expression E;
>  @@
>  (
> -struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_devi=
ce_id\) arr[] =3D {
> +struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_d=
evice_id \| spi_device_id\) arr[] =3D {
>  	...,
>  	{
>  	.var =3D E,
> @@ -63,7 +63,7 @@ struct \(of_device_id \| i2c_device_id \| platform_devi=
ce_id \| spi_device_id\)
>  	@p1
>  };
>  |
> -struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_devi=
ce_id\) arr[] =3D {
> +struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_d=
evice_id \| spi_device_id\) arr[] =3D {
>  	...,
>  	{ ..., E, ... }
>  	@p1
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-=
offsets.c
> index 1492e9fdc7cb..522bea285c7a 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -158,6 +158,9 @@ int main(void)
>  	DEVID_FIELD(slim_device_id, manf_id);
>  	DEVID_FIELD(slim_device_id, prod_code);
> =20
> +	DEVID(serdev_device_id);
> +	DEVID_FIELD(serdev_device_id, name);
> +
>  	DEVID(spi_device_id);
>  	DEVID_FIELD(spi_device_id, name);
> =20
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 980d7da456bb..552847deab94 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -886,6 +886,14 @@ static void do_slim_entry(struct module *mod, void *=
symval)
>  	module_alias_printf(mod, false, "slim:%x:%x:*", manf_id, prod_code);
>  }
> =20
> +/* Looks like: serial:S */
> +static void do_serdev_entry(struct module *mod, void *symval)
> +{
> +	DEF_FIELD_ADDR(symval, serdev_device_id, name);
> +
> +	module_alias_printf(mod, false, SERDEV_MODULE_PREFIX "%s", *name);
> +}
> +
>  /* Looks like: spi:S */
>  static void do_spi_entry(struct module *mod, void *symval)
>  {
> @@ -1500,6 +1508,7 @@ static const struct devtable devtable[] =3D {
>  	{"rpmsg", SIZE_rpmsg_device_id, do_rpmsg_entry},
>  	{"i2c", SIZE_i2c_device_id, do_i2c_entry},
>  	{"i3c", SIZE_i3c_device_id, do_i3c_entry},
> +	{"serdev", SIZE_serdev_device_id, do_serdev_entry},
>  	{"slim", SIZE_slim_device_id, do_slim_entry},
>  	{"spi", SIZE_spi_device_id, do_spi_entry},
>  	{"dmi", SIZE_dmi_system_id, do_dmi_entry},

Reviewed-by: Markus Probst <markus.probst@posteo.de>


You should add the maintainers for the modpost scripts to To/Cc.

$ ./scripts/get_maintainer.pl scripts/coccinelle/misc/of_table.cocci
scripts/mod/file2alias.c scripts/mod/devicetable-offsets.c
include/linux/mod_devicetable.h

Thanks
- Markus Probst


--=-bCRNCTcGwwWunRlL32Dh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrfXNUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS21oQAJUKOvsjUsn6LZouNoU4
j8Wfui07ukXo0NfimGc0fUSe2c6ByJC8M5hjhuXGUvtY7TdhnVawNO1PjxjTHpW6
nL+iAbscvMWaSIr8KDbv7vlg9UT/PlKiWpAMv1Kf2DnqZjUaM8sANol4mivTMkmd
xCuAILHOtLBws0qL+YiTuyXeYQihLAnZn5cWKZUnde7Q+faulDtw7Z8rMWdp5Dbn
q9ZDts6+6NupEZQ/56uTFGL7s5oYcnbU3xJ3ZPKfDxCRqQ3Ale7aWwcFKuZtRiGG
6R6j0bZhb5+InDbsCn2PEGkmTCYB6WiYq74YiHgJ1Yyfnv3p3O5dd0N+5G53Ct74
TlZ9es+a6Q4+I7kPE9tRk2oCYz0vIGDBm6TCK9vJ3/9hP1yd7zL3IgmEDf7qGLbx
Ql/a6g5vpdRv2SAINvGD3h/nnjCJHqC5ZPkyg4xRQkyNbs2KezlLMlQWhiwbgqZf
EHvPJ6LR7ygVdlwr8ZmpIAPbmasGwdTjxBeX9ZG9FREu64dujizvNShfdS1G3nPL
Rs2eFxB69iHqwKl7QpH7ZQm3yc42QZfbg7QE7Wetjhv7fsXd7iYMlmwZKCKjPh4r
vVhOtDPLTSVn3FSob3jId92z3MzIOJKkJmqsNcroGp2UBpkdKbJspzmy/Ph+WBBA
FpLDe7JmtOSvKsIGsz0xfY7U
=BEN+
-----END PGP SIGNATURE-----

--=-bCRNCTcGwwWunRlL32Dh--
