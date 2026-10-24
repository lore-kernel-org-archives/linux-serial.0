Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844293;
	b=nhS8cwrvdrMCiJ1rbFTuRRgfIhyTa4eOWkpHoJXmyencNqZXOIvU7gksyP1/zOPfSWml
	 QqKzht9xNQAHJ4PbjRAmxzC5S1sJZriCj7y1Gx//N/OmL7LB/VWW96r0zN4xQSUIVHPxJ
	 S+31jkeomgPGhIr2/w1SJuD4jyzHoHUGQ1yz9IS3rbecb/KcUeciXCqubXoeq1KTfMHAs
	 QHxo/tuLni+wU+UVcdo4gQnXHrASCRrV4uC734JuVINUG/23nPVj6V9NXWPZcZVlvc3j8
	 zri+6GIo8S3J3hkW6WIGb/yMNCPS39U+hEU6GdgqzxTiImen9iJc34M4+lnYhD7mj7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844293;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F36osSLs2gMWLGnc2I78fLhHpN7gySvODvms+8UEhNo=;
	b=y6HK6JyNU3mRNbmSim202RIB8dWNCKUIkUCQ7Qd7M1fkKfZ6KXkgL8U5xWFQJaBxDKLh
	 1/v6mzyZXo5G8RThqDQQguP3c0T4BegGa3HxlWmGPyLBvvjiJbtRR8MeYx9myly2I1z/0
	 dpLMBpQ/C8mTl/iRXXn+ZwSBWE9UMLQz7TRF4+H1WzZhkCu6MiqyISvnp9F5mCEVxFl34
	 fnj5AEATNXuzVsbQan41XoVyOlT6u+5x3RAfMVGYwPj++nlwhpzyLwIuDGIWkYjjNhe4A
	 G9lBYNr6omU1zo6JDDL7FBtyICK8TkeQtCzZ1SYXLNj+elfyczOuvQnnNUvy4/eY5vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e67SCSsY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F8606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e67SCSsY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750131F01825;
	Sat, 24 Oct 2026 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792844292;
	bh=F36osSLs2gMWLGnc2I78fLhHpN7gySvODvms+8UEhNo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=e67SCSsYxOWB1sIRpOW4j1hUd263b4b8pVDEXTqUw4lMOYDXKZolpexHvSNAuypRh
	 7kL50tFFHJL+lZ/Ju8Ff5qbMPzTUQ72YjWH85uAiR94srFTOLxOeZD9vm2txYrxj/X
	 8wkYzE7/ZyNWNYgDnOeTdfLgZgt6RFI66srD+8HUK82PgzTkjY/u7DMNXooYHEEiPo
	 G39sj3JT+Z0C9/H+TkEGPzeiEDmKyHa1H+jGqVbEk0x/U3YbDdHyvVziOx7VMhoqTG
	 uqqXj43J92fshUKJCTX7jxp1uHhpdB1P86tbcdHiRkNRJYfUPAvQm7gpKvWTVirtzI
	 zjVwD/pdcc1MA==
Message-ID: <sashiko-outbox-183707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] serdev: handle devices without an ACPI or device
 tree node
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <f3ec60d4e68819c994a0d4c6d44eb5cf8d511ddb.1792831564.git.an.wu@canonical.com>
References: <cover.1792831564.git.an.wu@canonical.com>
 <f3ec60d4e68819c994a0d4c6d44eb5cf8d511ddb.1792831564.git.an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 12:18:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] serdev: unupdated serdev_device_add() callers break build in bis=
ect
- [Medium] serdev: missing modpost wiring for struct serdev_device_id
--

commit 5b1ae2343b2c9133fe8d3921a65c4b7fe749f748
Author: ChunAn Wu <an.wu@canonical.com>

serdev: handle devices without an ACPI or device tree node

This commit adds modalias and id_table support to the serdev bus so that
serdev clients without an ACPI companion or device tree node can emit
modalias uevents and match against struct serdev_device_id tables. It also
introduces include/linux/device-id/serdev.h and updates serdev_device_add()
to accept a modalias string.

> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc218..e0517d5a48da2 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
[ ... ]
> @@ -86,28 +101,57 @@ static const struct device_type serdev_ctrl_type =3D=
 {
[ ... ]
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
> +int serdev_device_add(struct serdev_device *serdev, const char *modalias)
>  {
>  	struct serdev_controller *ctrl =3D serdev->ctrl;
>  	struct device *parent =3D serdev->dev.parent;
>  	int err;
> =20
> +	if (modalias)
> +		strscpy(serdev->modalias, modalias);

[Severity: Medium]
Does changing the signature of serdev_device_add() here without updating all
in-tree callers break compilation at this commit during a git bisect when
CONFIG_DELL_UART_BACKLIGHT or CONFIG_YT2_1380 is enabled?

While this commit updates the callers in drivers/tty/serdev/core.c,
drivers/platform/x86/x86-android-tablets/core.c, and
drivers/power/sequencing/pwrseq-pcie-m2.c to pass NULL, two callers are left
passing a single argument at this point in the series:

drivers/platform/x86/dell/dell-uart-backlight.c:
dell_uart_bl_pdev_probe()
	ret =3D serdev_device_add(serdev);

drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c:
yt2_1380_fc_pdev_probe()
	ret =3D serdev_device_add(serdev);

Although the subsequent commits in the series ("platform/x86:
dell-uart-backlight: Bind through normal serdev matching" and "platform/x86:
lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching")
update those two drivers to pass KBUILD_MODNAME, should both callers be
updated to pass NULL in this commit so that every patch in the series builds
cleanly?

[ ... ]
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
Should struct serdev_device_id also be wired into modpost so that
MODULE_DEVICE_TABLE(serdev, ...) generates serial:* module aliases?

In drivers/tty/serdev/core.c, serdev_device_uevent() emits
MODALIAS=3Dserial:<modalias> using SERDEV_MODULE_PREFIX:

	return add_uevent_var(env, "MODALIAS=3D%s%s", SERDEV_MODULE_PREFIX,
			      serdev->modalias);

However, include/linux/mod_devicetable.h does not include
device-id/serdev.h, scripts/mod/devicetable-offsets.c does not define
DEVID(serdev_device_id) and DEVID_FIELD(serdev_device_id, name), and
devtable[] in scripts/mod/file2alias.c has no "serdev" entry or handler. As
a result, handle_moddevtable() silently ignores MODULE_DEVICE_TABLE(serdev,
...) declarations, preventing uevent-based module autoloading for modular
serdev client drivers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792831564.gi=
t.an.wu@canonical.com?part=3D1
