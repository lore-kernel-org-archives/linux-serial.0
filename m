Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792842547;
	b=H936lIVqk38KAn17HTBTqXYK32dQ6KNUQeba/BzSztqKPgffluK+PKwqBSzhXRkYPQhI
	 2oIknR3dWcw6EJM6One64RX2wV7CVsqP5eAQPsVrpNROaeoaJVCBFeEX/fZ9/MxD4TIN9
	 /9P9OPIYxPk948A9j1eI5HG0UqHJoC7NqDll2PlMxxwiezYAD7XohXb+C9jqH69MBT0nw
	 NfdD8zoh++ncP4kj8MJCmn21ajhJEjpd9Ngvw3tVcZKxEYarD40v/wBGiSKvLHJpcnR7n
	 Hv95dIQxvoIaHh+WmJt5J5n0l6j9wWoGt2bAuoJX8+yf4IzRfti4HGAUuUKPjdT7ghQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792842547;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=hw1QPi56uJSIctdQv2Rn0y0FV97X9PM8hnq3yT9WocI=;
	b=MTC9vaf0aLEWCw8dawiesru2A//NIG9zxTx3e7SvAll3tNbL6SNAQddvnT7TMaJH2DGe
	 PkU7Yvunxy8TSk+3Q3ocpT4axs/vcCQdtblAI+NVhr+0mJSDZ1miUMbE8FI1Mi8HIR+h+
	 liVfohLKu8h2V+GIxgL0fq8Usx/lEyRWO7pqKC61NrWbBxVX8++rK78lL95tErfhw7LZ4
	 HuEwBkq3i+oh1//kV23P5/PRPvjuWu9sHQTtJhP+xewO4q7hvjNnijLmu68sSKnK/nIQs
	 xmy8v+JSQWWCS2P3P9WEU17c+5jb+Dm9xzpsQ3VasIv1kvjmYrXAKA5KW+Ay/DCYTJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=UZW7L1L5;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7B606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 11:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA7B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=UZW7L1L5
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 5DA6E240107
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792842531;
	bh=hw1QPi56uJSIctdQv2Rn0y0FV97X9PM8hnq3yT9WocI=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=UZW7L1L5k/I/gKsJZGr4Be7HgXhSb/FGk08xxttX6zbMW6RfcGm4Dsem43hNIqT1H
	 ESFCO6lHYLqjQPN37RdSW197IwrOplYKNRzkrZ2xUa7NCruzBrAtfkfYTElcRfFQNP
	 yV5M2KFFmJARaDpaG03ZIHfsV7XTZhtX462MaIQ95zQ9qAzrqI/25Djj0kIU7tD7J0
	 PBX72AiCTN1Zo6EyodHtIJxp/JsNBrlknMgtOtnTs3+GNIz6xBrsGkVGZpQohbiK3B
	 xk5lbnZ2rE6cKzjRE90LitUuxUuxv1soqr2LfNzc2PgLKHBo5T7DmQmC8etPOYZjhT
	 zsCeW2aq8DCjA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jBdSx5jsSz9rxL;
	Sat, 24 Oct 2026 13:48:49 +0200 (CEST)
Message-ID: <3874eaebc908def9dfa7bf817a726025a06f5b88.camel@posteo.de>
Subject: Re: [PATCH v4 0/3] serdev: handle devices without an ACPI or device
 tree node
From: Markus Probst <markus.probst@posteo.de>
To: An Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com
Date: Sat, 24 Oct 2026 11:48:50 +0000
In-Reply-To: <CAO4Mv0bkBSHHXo=_0SyCAN54Jb76fy34ba1hFVPVkFfs6ufoqA@mail.gmail.com>
References: <20261024022930.2704030-1-an.wu@canonical.com>
	 <CAO4Mv0bkBSHHXo=_0SyCAN54Jb76fy34ba1hFVPVkFfs6ufoqA@mail.gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-SG13v7S5Ehmb8Q9m+2CQ"
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


--=-SG13v7S5Ehmb8Q9m+2CQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-10-24 at 16:40 +0800, An Wu wrote:
> Hi Makus
>     According to sashiko:
> '''
> In drivers/tty/serdev/core.c, serdev_controller_alloc() places controller
> devices on serdev_bus_type:
>=20
>     device_initialize(&ctrl->dev);
>     ctrl->dev.type =3D &serdev_ctrl_type;
>     ctrl->dev.bus =3D &serdev_bus_type;
>=20
> When yt2_1380_fc_module_init() calls serdev_device_driver_register() for
> yt2_1380_fc_serdev_driver (or when a new serdev_controller is added), the
> driver core runs serdev_device_match() against every device on
> serdev_bus_type, including struct serdev_controller instances:
>=20
> static int serdev_device_match(struct device *dev, const struct
> device_driver *drv)
> {
>         const struct serdev_device *serdev =3D to_serdev_device(dev);
>         const struct serdev_device_driver *sdrv =3D to_serdev_device_driv=
er(drv);
>=20
>         if (acpi_driver_match_device(dev, drv))
>                 return 1;
>=20
>         if (of_driver_match_device(dev, drv))
>                 return 1;
>=20
>         return !!serdev_match_id(sdrv->id_table, serdev->modalias);
> }
>=20
> Because serdev_device_match() does not check is_serdev_device(dev) before
> casting dev with to_serdev_device(dev), and yt2_1380_fc_serdev_driver has=
 no
> ACPI or OF match table, serdev_device_match() falls through to
> serdev_match_id(sdrv->id_table, serdev->modalias) on struct serdev_contro=
ller
> devices.
>=20
> In struct serdev_device, modalias[SERDEV_NAME_SIZE] starts at offset
> sizeof(struct device) + 4, which in struct serdev_controller overlaps the
> struct device *host pointer, ctrl->nr, ctrl->serdev, ctrl->ops, and exten=
ds 12
> bytes past sizeof(struct serdev_controller). When the overlapping byte at
> modalias[0] is non-zero, serdev_match_id() passes that non-string memory =
and
> trailing out-of-bounds bytes to strcmp().
>=20
> Should serdev_device_match() verify is_serdev_device(dev) before casting =
dev
> to struct serdev_device?
> '''
>=20
> If we remove is_serdev_device could cause some problem due to the
> serdev_controller could also
> run into this function and "serdev_match_id(sdrv->id_table,
> serdev->modalias);" can be a potential risk.
>=20
> I will add the "is_serdev_device" back and send v5 out.
Your right, I missed that.

Thanks
- Markus Probst

>=20
> BR
>     An
>=20
>=20
> On Sat, Oct 24, 2026 at 10:29=E2=80=AFAM ChunAn Wu <an.wu@canonical.com> =
wrote:
> >=20
> > Driver-created serdev clients without an ACPI companion or device tree
> > node currently have no modalias and cannot be matched to a driver:
> > their modalias sysfs read returns -ENODEV and their creators force a
> > bind with device_driver_attach().
> >=20
> > Backlight function on dell-uart-backlight is not affected: that class
> > device is registered independently and gets its own add uevent. The
> > user-visible breakage is the failing modalias read on an existing
> > serdev child -- Checkbox dkms_info_attachment aborts with
> > "OSError: [Errno 19] No such device".
> >=20
> > Resolve the two long-standing serdev-core TODOs by letting the creator
> > pass a modalias to serdev_device_add() and giving the serdev driver an
> > id_table, modelled on the SPI bus. ACPI and OF match first and are
> > unchanged. Convert dell-uart-backlight and the Lenovo Yoga Tab 2 Pro
> > fastcharger to this path and drop their force-attach workarounds.
> >=20
> > Changes in v4:
> > - Patch 1: drop the dead is_serdev_device() guard from the match
> >   callback, and dereference serdev once at the top
> > - Patch 1: drop the "large enough" comment on SERDEV_NAME_SIZE
> > - Patch 1: in struct serdev_device_driver, place id_table right under
> >   driver, next to driver->of_match_table and driver->acpi_match_table
> > - Patch 1: merge serdev_device_set_modalias() into serdev_device_add()
> >   so the modalias is set at the only point where forgetting it would
> >   matter; internal firmware callers pass NULL
> > - All three patches: tightened commit messages and moved the v2/v3
> >   changelog narrative out of Patch 1 into this cover letter
> >=20
> > Changes in v3:
> > - Rename struct serdev_device::name to ::modalias; dev_name() is
> >   unchanged
> > - Model matching on the SPI bus: add struct serdev_device_id and
> >   id_table; drop driver->name matching
> > - Add serdev_device_set_modalias() helper and SERDEV_MODULE_PREFIX
> > - No MODULE_DEVICE_TABLE(serdev, ...) support: both in-tree
> >   firmware-less clients are created by the same module that provides
> >   their driver, so udev has nothing to autoload
> >=20
> > Changes in v2:
> > - Instead of silently returning success with no modalias, use a
> >   creator-supplied name as a "serial:<name>" modalias fallback and as
> >   the matching key, so clients can bind through normal serdev matching
> >=20
> > v3: https://lore.kernel.org/lkml/20261023052717.2577234-1-an.wu@canonic=
al.com/
> > v2: https://lore.kernel.org/lkml/20261022032842.2492572-1-an.wu@canonic=
al.com/
> > v1: https://lore.kernel.org/lkml/20261021092124.2306053-1-an.wu@canonic=
al.com/
> >=20
> > ChunAn Wu (3):
> >   serdev: handle devices without an ACPI or device tree node
> >   platform/x86: dell-uart-backlight: Bind through normal serdev matchin=
g
> >   platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through
> >     normal serdev matching
> >=20
> >  MAINTAINERS                                   |  1 +
> >  .../platform/x86/dell/dell-uart-backlight.c   | 33 ++++------
> >  .../lenovo/yoga-tab2-pro-1380-fastcharger.c   | 25 +++----
> >  .../platform/x86/x86-android-tablets/core.c   |  2 +-
> >  drivers/power/sequencing/pwrseq-pcie-m2.c     |  2 +-
> >  drivers/tty/serdev/core.c                     | 65 ++++++++++++++-----
> >  include/linux/device-id/serdev.h              | 19 ++++++
> >  include/linux/serdev.h                        | 12 +++-
> >  8 files changed, 105 insertions(+), 54 deletions(-)
> >  create mode 100644 include/linux/device-id/serdev.h
> >=20
> >=20
> > base-commit: 9e947d96915af63e28896caae85a81b74855621b
> > --
> > 2.34.1
> >=20

--=-SG13v7S5Ehmb8Q9m+2CQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrcmxwbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSVY4P/0xzs5nL7i1tTqdbwO0P
GqR+O55MGJSmGhSoHK5eEa708+ux2lQ7AAFbNoPPSXuJCz8TIvWtNpjr2JwegeK6
3STQvzfOe8TDjZxpwALYlNmVxCJR3586aCJbtrVaXbojI+xY8jYZbUEKUnkbpKXw
ZvvFr/GZ+J8JBulWNUChzMCde+reZgRJzn6e6GMC1FFOkKuVPeIRdE7oKxlJPsdS
h+bt4wozGWoXTFKuYx+flHDoAmco+fOgb5UfDcXMHyT6GqK+9ZJB6jR2Yzi1099p
roaAoXWNh4jFpKFEos2Aapi1l+vEOXWs2UonoCfL+FnrXWQt6AZ9XY1thCUkvkQu
Q5yCeTG08TG/iMARYBW20pnXyMClYsSBASXKacPhKHoNsoOLEQ2v/vH+fR+rbIfA
+YfoIUCPmacvVv23mWZSkT6IdWqlaRVvVx8bC5Z/T4SEjtBIOP8QWRfPZO2mJxbY
PKcrx9Pc2frANJe9fr0OlbNRvkPvrpm8df99SE2WoNS3KrEU/aVs+AwaHPCa7rRS
kt8bQOFDWpPW8GDx0jaz0bXHEb2aNJmmSylFO8uWBFimDEHBqL8ZycN34bHvcuay
McZpIBcZrFOBQH9U6sQlf5Di/U80LDFs2Pf/8JrAuZbgCIs3t/wducloZTjRLEXR
mrpZctbaXDdFgSgbnkZdQfPW
=U9eF
-----END PGP SIGNATURE-----

--=-SG13v7S5Ehmb8Q9m+2CQ--
