Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595306;
	b=V/d4KjzLWUxg6ZITzVgpaBe//Zshykdh/TZ6D68Dtcb35xoIcpHtxHIa4OP5A/t4jG6h
	 uEsu9WwoSkzdtTlMtJFwy6P+g+BUZtmowBq4zCb/x8Bes2W0CLm8i3S4vmxfd/r5DaGxh
	 Lb1HMK3uhTz3waQE0C7jM3EqhEj49aHLbjAGY+F1nh/F8BkPbAAoWLMdPA/h5kp0594KS
	 8QNHytnwRlBskw7/riG1XMhVXQCnYrFpHmxYtoT10cZK/MKwx3mmm4hqNhNeHbFrdPynw
	 htDs03OTr/9rrQ7EYGDcqYV9KPF+zIYjgXbJXS87AHHkumVZYGr3JbVAkFQKh6VCfLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595306;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=46SSFjO9++Th4oDkhERxc+DpVEEjVqxW9M18rMqhX+U=;
	b=TNTKL3i8Q7nmP5mZB8KpJ05KSVjqwmzB53ko6bgXC/gR3evRDTtPFN81jP6HHPDRRmmF
	 8cxG2ZXGbycI2iXDISMt2o9YjXMcQtSCzhRtoz5aSayFPwrz5X5n4e3W7fhd+ENM/JID1
	 snKx6DNWLSTg0IGvFbZHrwPRGSZO+8mVwQqzl6oMSgP7lUPSb0OiyW7GnnYQZSfT2jFJ6
	 KFxqaM2H4siw7D8wKxzDKlwsBIzv4JapPZlWmgwivsvh7oPEoMD9mUF6/btP+OpTIHUjf
	 sNHO0U3ZOlqbxGAUdWMpY/qnckjufOTo+Q5FHaULt/SmBGtIVZSYSW/NAeZycrLqRfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=jUq60387;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C7606A31D
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 15:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0C7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=jUq60387
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 76B37240108
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 17:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792595298;
	bh=46SSFjO9++Th4oDkhERxc+DpVEEjVqxW9M18rMqhX+U=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=jUq603871CtCWPPmBhCMG63PMYwAl8XnnCXZ9XephxkYG4QG6jdd6ILV9EbftVwGO
	 D08Tn6BNH9ZFMsfuaREQdSmIFv2Pin7z7NyfhQ/9tvVm88welHSlpEo7caAaXRNKRc
	 KQ15S6Ad/nT3rFehWIvnQbtfHgtmuOEDuwPZT/YnDsQ62TowsIeIvgPrlCfRsZZqDX
	 hnao7FXPsl6W/OutTsIvukSmx3gHLyVynAd6Q/KBA1klpiYrj5mfAqykPj1cMYFuuJ
	 zMy1pLtax1NIm9e64mVbNqUyzhXQpXFyqAhlCyQR0mvWUOzK4hd86WgRZ9vC8tNLdg
	 nKqsfWkBd1gEw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j8t2S4j3Yz9rxL;
	Wed, 21 Oct 2026 17:08:16 +0200 (CEST)
Message-ID: <59137675cf11f7b034220c3b71c5ababab48f8d0.camel@posteo.de>
Subject: Re: [PATCH v2 1/3] serdev: handle devices without an ACPI or device
 tree node
From: Markus Probst <markus.probst@posteo.de>
To: Hans de Goede <hansg@kernel.org>, ChunAn Wu <an.wu@canonical.com>, 
	linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
 mpearson-lenovo@squebb.ca, 	derekjohn.clark@gmail.com
Date: Wed, 21 Oct 2026 15:08:17 +0000
In-Reply-To: <250bded6-2a51-457d-9bf2-24c299dbd7a9@kernel.org>
References: <20261021092124.2306053-1-an.wu@canonical.com>
	 <250bded6-2a51-457d-9bf2-24c299dbd7a9@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-JnwgaKYa7ffI2Wuf5sIs"
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


--=-JnwgaKYa7ffI2Wuf5sIs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-21 at 16:32 +0200, Hans de Goede wrote:
> Hi,
>=20
> On 21-Oct-26 11:21, ChunAn Wu wrote:
> > Driver-created serdev clients may lack an ACPI companion or device tree
> > node.
> >=20
> > Add a creator-supplied name for these clients. Use it as a serial
> > modalias fallback and to match a serdev driver of the same name. Keep
> > returning -ENODEV for unnamed clients.
> >=20
> > Signed-off-by: ChunAn Wu <an.wu@canonical.com>
>=20
> For v3 of this series please include a cover-letter and explain
> why this series is an improvement over the` existing situation.
>=20
> The dell-uart-backlight and lenovo-yoga-tab2-pro-1380-fastcharger
> drivers are both pretty special cases and here you are adding
> a chunk of code to the serdev-core for those special cases,
> so I wonder: why?
>=20
> The current manual attach approach taking in these 2 special
> drivers works fine.
>=20
> What does this new approach gain us ?

That was my review comment [1] that resulted in this.

=46rom what I can tell from revision 1, ChunAn Wu is trying to fix that
accessing uevent and modalias of the device (via sysfs) results in a -
ENODEV error.

As mentioned in my review:

- "/* TODO: platform modalias */"
- "/* TODO: platform matching */"
still exist in the serdev codebase (drivers/tty/serdev/core.c) and are
unresolved. Resolving those also fixes the issue mentioned above.
Therefore I think this would be a better approach.

A cover letter is ofc still needed.

>=20
> Also if you are going to do this may I suggest looking at doing
> some sort of of-compatible matching based on a compatible string
> inside a swnode ? I do not know what that would look like but
> that is something which seems like it might be generally useful
> also outside these 2 special cases.

I haven't used them before, but I don't think of-compatible string
matching inside a swnode is done anywhere in the kernel (At least I
haven't found a case).

They can be added supplementary if needed.

Thanks
- Markus Probst

[1]
https://lore.kernel.org/linux-serial/8e4ca13d3e8acd5d649bd4c7357e5da0785ba6=
b3.camel@posteo.de/

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
> > ---
> >  drivers/tty/serdev/core.c | 36 ++++++++++++++++++++++++++++++------
> >  include/linux/serdev.h    | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 7500efcdfc21..8354a4688fd8 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -29,13 +29,21 @@ static DEFINE_IDA(ctrl_ida);
> >  static ssize_t modalias_show(struct device *dev,
> >  			     struct device_attribute *attr, char *buf)
> >  {
> > +	const struct serdev_device *serdev =3D to_serdev_device(dev);
> >  	int len;
> > =20
> >  	len =3D acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
> >  	if (len !=3D -ENODEV)
> >  		return len;
> > =20
> > -	return of_device_modalias(dev, buf, PAGE_SIZE);
> > +	len =3D of_device_modalias(dev, buf, PAGE_SIZE);
> > +	if (len !=3D -ENODEV)
> > +		return len;
> > +
> > +	if (!serdev->name[0])
> > +		return -ENODEV;
> > +
> > +	return sysfs_emit(buf, "%s%s\n", SERDEV_MODULE_PREFIX, serdev->name);
> >  }
> >  static DEVICE_ATTR_RO(modalias);
> > =20
> > @@ -47,15 +55,22 @@ ATTRIBUTE_GROUPS(serdev_device);
> > =20
> >  static int serdev_device_uevent(const struct device *dev, struct kobj_=
uevent_env *env)
> >  {
> > +	const struct serdev_device *serdev =3D to_serdev_device(dev);
> >  	int rc;
> > =20
> > -	/* TODO: platform modalias */
> > -
> >  	rc =3D acpi_device_uevent_modalias(dev, env);
> >  	if (rc !=3D -ENODEV)
> >  		return rc;
> > =20
> > -	return of_device_uevent_modalias(dev, env);
> > +	rc =3D of_device_uevent_modalias(dev, env);
> > +	if (rc !=3D -ENODEV)
> > +		return rc;
> > +
> > +	if (!serdev->name[0])
> > +		return -ENODEV;
> > +
> > +	add_uevent_var(env, "MODALIAS=3D%s%s", SERDEV_MODULE_PREFIX, serdev->=
name);
> > +	return 0;
> >  }
> > =20
> >  static void serdev_device_release(struct device *dev)
> > @@ -88,14 +103,23 @@ static const struct device_type serdev_ctrl_type =
=3D {
> > =20
> >  static int serdev_device_match(struct device *dev, const struct device=
_driver *drv)
> >  {
> > +	const struct serdev_device *serdev;
> > +
> >  	if (!is_serdev_device(dev))
> >  		return 0;
> > =20
> > -	/* TODO: platform matching */
> >  	if (acpi_driver_match_device(dev, drv))
> >  		return 1;
> > =20
> > -	return of_driver_match_device(dev, drv);
> > +	if (of_driver_match_device(dev, drv))
> > +		return 1;
> > +
> > +	/* Fall back to the name set by the creator of the device */
> > +	serdev =3D to_serdev_device(dev);
> > +	if (!serdev->name[0])
> > +		return 0;
> > +
> > +	return strcmp(serdev->name, drv->name) =3D=3D 0;
> >  }
> > =20
> >  /**
> > diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> > index b6c3d957ec15..26baa0321eef 100644
> > --- a/include/linux/serdev.h
> > +++ b/include/linux/serdev.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/types.h>
> >  #include <linux/device.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/string.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/termios.h>
> >  #include <linux/delay.h>
> > @@ -19,6 +20,10 @@ struct serdev_device;
> >   * serdev device structures
> >   */
> > =20
> > +/* Large enough to hold the KBUILD_MODNAME of any serdev client driver=
 */
> > +#define SERDEV_NAME_SIZE	40
> > +#define SERDEV_MODULE_PREFIX	"serial:"
> > +
> >  /**
> >   * struct serdev_device_ops - Callback operations for a serdev device
> >   * @receive_buf:	Function called with data received from device;
> > @@ -35,6 +40,9 @@ struct serdev_device_ops {
> >   * struct serdev_device - Basic representation of an serdev device
> >   * @dev:	Driver model representation of the device.
> >   * @nr:		Device number on serdev bus.
> > + * @name:	Name of the device, set by its creator, empty for devices
> > + *		which are enumerated from firmware, see
> > + *		serdev_device_set_name().
> >   * @ctrl:	serdev controller managing this device.
> >   * @ops:	Device operations.
> >   * @write_comp:	Completion used by serdev_device_write() internally
> > @@ -43,6 +51,7 @@ struct serdev_device_ops {
> >  struct serdev_device {
> >  	struct device dev;
> >  	int nr;
> > +	char name[SERDEV_NAME_SIZE];
> >  	struct serdev_controller *ctrl;
> >  	const struct serdev_device_ops *ops;
> >  	struct completion write_comp;
> > @@ -135,6 +144,28 @@ static inline void serdev_device_set_client_ops(st=
ruct serdev_device *serdev,
> >  	serdev->ops =3D ops;
> >  }
> > =20
> > +/**
> > + * serdev_device_set_name() - set the name of a serdev device
> > + * @serdev:	serdev device.
> > + * @name:	non-empty name to use, typically KBUILD_MODNAME of the clien=
t
> > + *		driver.
> > + *
> > + * A serdev device is identified by its ACPI companion, by its device =
tree
> > + * node, or by a name set by its creator. Serdev devices which are
> > + * instantiated by a driver rather than by firmware have neither of th=
e
> > + * former, so they must set a name before serdev_device_add() to be
> > + * identifiable. Doing so gives them a SERDEV_MODULE_PREFIX modalias a=
nd
> > + * makes them match a serdev device driver of the same name.
> > + *
> > + * Devices enumerated from firmware have no name and keep deriving the=
ir
> > + * modalias and their driver match from firmware only.
> > + */
> > +static inline void serdev_device_set_name(struct serdev_device *serdev=
,
> > +					  const char *name)
> > +{
> > +	strscpy(serdev->name, name);
> > +}
> > +
> >  static inline
> >  void *serdev_controller_get_drvdata(const struct serdev_controller *ct=
rl)
> >  {
> >=20
> > base-commit: 9e947d96915af63e28896caae85a81b74855621b

--=-JnwgaKYa7ffI2Wuf5sIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrY1UobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSav8QAKpH3BR9SxleiyWCmxKp
aaOdCQblx9BsYaVTJQ8QGWOOgs+t0iSwialbEwacztIDKNC83MJW8Z+mCx3yoyi8
fyVCx5ptA0Ov+M8RkD7RUZ57cAFyZLsG3hacKDM3k1UV7h0ACLQsI4/3OYfoyXol
6VNGag89E/TkEZFPW8FvhUewoRUajbxGhpXlTvAcbcsP3c8oomenFicfNE4u/iZc
AQTDQAbRyqipWQ2vrnPujS/qkwU0oXvubRhFRtqG/LZcrOl2lmSLGbhqxSAV0lGl
h1GsZW7tTKEmmen5BY669Y9olFa7OPnUsXBwoeJYDfSKFMwAgC1k4p0M68Dqlalo
n4W8/lwtQ0V6w8S6CUuR318sk5GcZUjuDkHXnHgSiAEOMZpyk96Vl0fHPBB+heVq
DwBO3FZgbgQEgfZ1CY9owNfc/NdsG/Z0xXC/vdg8rMaBwNk6Xq52QtTacmk2hCbS
1V9gcVek/D7oHzGk7SnbWyvlbVwh0fzK0rHxusLTAOw4OR+DZEk7rA6kDMSWZQm0
N4i2Yc9Pg4bP4fcnTDWEe2FTByX85uxR94nA0HraHw7mVJgGdKzPscG9XU+x54lh
zf7BD5YAXv6I5a/p4Elp7SnaLi+FDUec7oQnPBosbeN8d0gNN7k2KpRkgKhZKDjb
ot9xBKzY9nMMWmWzjae3A1Es
=sdsc
-----END PGP SIGNATURE-----

--=-JnwgaKYa7ffI2Wuf5sIs--
