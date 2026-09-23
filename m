Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A5377A89
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170317; cv=none; b=X4Cjv+/D+SaTPgX8kHYjIloxO4Tz0PUAcH9DVzZOSr2pFBxCypGCq50kfvvrDXZfTESq8JMiJaulYJJe3GSootpTcmkAPNxXxwUMBtfI10k2CKcydi9cp/D5hHPLmYEIL96riEjswc/kiQWYbnjPB7US1VpNGJpm/sQvO89tdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170317; c=relaxed/simple;
	bh=5nxX6dp8DDtAiiY/fJP0IjGNNSnwnrx/4A5bdqLvMKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIoQiKjrrtBeOG/RH8BZ92IrQcExGYPnOBgyMqY1KJzxCk6mzWc4SQ6FDrWEgZMGQpeCQnLtrKc3u3OIZJKL8P5S1VoYBbubEhJuX4Bdwn5TH3hy5YcYx+K/4WdsUP7aELSaeYZku7M9uQqe9JCOJi/CP6NlWasRIEoF51WwpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=fk0kbuHx; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="fk0kbuHx"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 19D99240027
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 15:31:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790170312;
	bh=wGCiWecGOgpeuSnRUc7veF+BLjBlyufTqs69WvVzBNY=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=fk0kbuHx4c80OFyvNdH5fpoP2yjU5/cwOhR415HHLT0/p0+Hhr8Zcl71vONKBor+Y
	 y0nHlSsELsckfrdEMxgsZTHrphi6JrqFBQc73xnY5Frar6Ahw0xWes+yKGaqA+f6c2
	 XZ2JGV0CzN47d4w3gBo1JFTODzMfJGEBkHNtD90qlEQK1fKBFSycwrvguCRU06+tQH
	 2QTHUt0aZhbrpDEsKWizXB05/qFWQuDh9HzNv9GQfw84PSDdnglptMwnCCRBmmIUmu
	 n27NhAONnYvgra8SF46Nmwt5IO89rMzAPmDFQPXLQMla+UqH3YDOwZKj/07OcIeVGM
	 CtFr80STSrsXw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hqdD20PYvz6tsb;
	Wed, 23 Sep 2026 15:31:46 +0200 (CEST)
Message-ID: <2fcec4f3cd70a41e282505ff5c99b19e5809aead.camel@posteo.de>
Subject: Re: [PATCH v2 1/3] tty: serdev: Export functions to pause
 receive_buf callback calls
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo	 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Eric Biggers	
 <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Lorenzo Stoakes	
 <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"	
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Jiri Slaby	
 <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev
Date: Wed, 23 Sep 2026 13:31:49 +0000
In-Reply-To: <2026092356-chatting-dust-3de9@gregkh>
References: 
	<20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
	 <20260920-rust_serdev_probe_refactor-v2-1-43b855162f5d@posteo.de>
	 <2026092356-chatting-dust-3de9@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-69hyOdobKMKNJBb5gHBc"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-69hyOdobKMKNJBb5gHBc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-23 at 12:35 +0200, Greg Kroah-Hartman wrote:
> On Sun, Sep 20, 2026 at 02:29:58PM +0000, Markus Probst wrote:
> > These functions will be used to simply the serdev rust abstraction. It
> > also contributes to the fixing of 2 race conditions in the serdev rust
> > abstraction.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  drivers/tty/serdev/core.c           | 50 +++++++++++++++++++++++++++++=
+++++++-
> >  drivers/tty/serdev/serdev-ttyport.c | 38 ++++++++++++++++++++++++++++
> >  include/linux/serdev.h              |  6 +++++
> >  3 files changed, 93 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 7500efcdfc21..7d24f16710cb 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -187,6 +187,51 @@ void serdev_device_close(struct serdev_device *ser=
dev)
> >  }
> >  EXPORT_SYMBOL_GPL(serdev_device_close);
> > =20
> > +/**
> > + * serdev_device_pause_rx() - pause data receive
> > + * @serdev:	serdev device
> > + *
> > + * Pause calls to receive_buf.
> > + *
> > + * The caller must guarantee that this does not run concurrently with
> > + * `serdev_device_open` or `serdev_device_close`.
> > + *
> > + * Note that if a call to receive_buf is currently executed, the funct=
ion will
> > + * sleep until it has finished.
> > + */
> > +void serdev_device_pause_rx(struct serdev_device *serdev)
> > +{
> > +	struct serdev_controller *ctrl =3D serdev->ctrl;
> > +
> > +	if (!ctrl || !ctrl->ops->pause_rx)
> > +		return;
> > +
> > +	ctrl->ops->pause_rx(ctrl);
> > +}
> > +EXPORT_SYMBOL_GPL(serdev_device_pause_rx);
> > +
> > +/**
> > + * serdev_device_resume_rx() - resume data receive
> > + * @serdev:	serdev device
> > + *
> > + * Resume calls to receive_buf.
> > + *
> > + * The caller must guarantee that this does not run concurrently with
> > + * `serdev_device_open` or `serdev_device_close`.
> > + *
> > + * This can be called even if not paused to ensure data receive is act=
ive.
> > + */
> > +void serdev_device_resume_rx(struct serdev_device *serdev)
> > +{
> > +	struct serdev_controller *ctrl =3D serdev->ctrl;
> > +
> > +	if (!ctrl || !ctrl->ops->resume_rx)
> > +		return;
> > +
> > +	ctrl->ops->resume_rx(ctrl);
> > +}
> > +EXPORT_SYMBOL_GPL(serdev_device_resume_rx);
> > +
> >  static void devm_serdev_device_close(void *serdev)
> >  {
> >  	serdev_device_close(serdev);
> > @@ -398,6 +443,7 @@ EXPORT_SYMBOL_GPL(serdev_device_break_ctl);
> >  static int serdev_drv_probe(struct device *dev)
> >  {
> >  	const struct serdev_device_driver *sdrv =3D to_serdev_device_driver(d=
ev->driver);
> > +	struct serdev_device *sdev =3D to_serdev_device(dev);
> >  	int ret;
> > =20
> >  	ret =3D dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> > @@ -405,7 +451,9 @@ static int serdev_drv_probe(struct device *dev)
> >  	if (ret)
> >  		return ret;
> > =20
> > -	return sdrv->probe(to_serdev_device(dev));
> > +	serdev_device_resume_rx(sdev);
> > +
> > +	return sdrv->probe(sdev);
> >  }
> > =20
> >  static void serdev_drv_remove(struct device *dev)
> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/s=
erdev-ttyport.c
> > index bab1b143b8a6..e8aa89e733bd 100644
> > --- a/drivers/tty/serdev/serdev-ttyport.c
> > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > @@ -7,8 +7,10 @@
> >  #include <linux/tty.h>
> >  #include <linux/tty_driver.h>
> >  #include <linux/poll.h>
> > +#include "../tty.h"
> > =20
> >  #define SERPORT_ACTIVE		1
> > +#define SERPORT_PAUSE_RX	2
> > =20
> >  struct serport {
> >  	struct tty_port *port;
> > @@ -32,6 +34,14 @@ static size_t ttyport_receive_buf(struct tty_port *p=
ort, const u8 *cp,
> >  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> >  		return 0;
> > =20
> > +	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
> > +		return 0;
> > +
> > +	/*
> > +	 * Ensure writes by the driver are visible before allowing traffic to=
 resume.
> > +	 */
> > +	smp_mb__after_atomic();
>=20
> This scares me.  Why not use a real lock?=C2=A0
>=20
I can use locks to make it less "fragile". But I don't I think I need
them.

> WHat's the issue here, you
> need this to be "flushed" before this call:
>=20
> > +
> >  	ret =3D serdev_controller_receive_buf(ctrl, cp, count);
>=20
> here?
>=20
> And you just tested a bit, you didn't set a bit, so what are you trying
> to ensure is written exactly?
This should be an acquire load operation (paired with the release store
operation in `ttyport_resume_rx`).

It ensures that any writes before calling `ttyport_resume_rx` are
visible in the `serdev_controller_receive_buf` invocation.


For instance, in the Rust abstraction the following will be called in
order in probe (with the following patches):

- serdev_device_pause_rx
- serdev_device_open
- dev_set_drvdata
- serdev_device_resume_rx

This atomic lock effectively ensures in this example that the set
device driver data is visible to `ttyport_receive_buf` before
`SERPORT_PAUSE_RX` is unset in `ttyport_resume_rx`.

>=20
>=20
> > =20
> >  	dev_WARN_ONCE(&ctrl->dev, ret > count,
> > @@ -156,6 +166,32 @@ static void ttyport_close(struct serdev_controller=
 *ctrl)
> >  	tty_release_struct(tty, serport->tty_idx);
> >  }
> > =20
> > +static void ttyport_pause_rx(struct serdev_controller *ctrl)
> > +{
> > +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> > +	struct tty_struct *tty =3D serport->tty;
> > +
> > +	set_bit(SERPORT_PAUSE_RX, &serport->flags);
> > +
> > +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
>=20
> What keeps this bit from being set right after you test it?
The statement "The caller must guarantee that this does not run
concurrently with `serdev_device_open` or `serdev_device_close`." in
the kdoc of `serdev_device_pause_rx` does.
>=20
>=20
>=20
> > +		tty_buffer_flush_work(tty->port);
> > +}
> > +
> > +static void ttyport_resume_rx(struct serdev_controller *ctrl)
> > +{
> > +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> > +	struct tty_struct *tty =3D serport->tty;
> > +
> > +	/*
> > +	 * Ensure writes by the driver are visible before allowing traffic to=
 resume.
> > +	 */
> > +	smp_mb__before_atomic();
> > +	clear_bit(SERPORT_PAUSE_RX, &serport->flags);
> > +
> > +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
>=20
> Same here.  Are you sure you don't need locks?  This feels wrong.
Same as above.

Thanks
- Markus Probst

>=20
> thanks,
>=20
> greg k-h

--=-69hyOdobKMKNJBb5gHBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqz1MEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSdo4QAKqh+41BIzuT07DLtuHX
qipyb598cM9aO5TTZR/y4p41aobSRfaDFJmG8hXktXo53cpp20XKt6SslxlBefGi
mvrrPbBlM2tZHw8Z0sASMBGSN8eQCoUgbAnOT6KM27aTDs0itD/OjY/GmUTlQVdr
C/qV28ISajCrRIorI/CB8M9iGxJaD88SsDJoU7dnnaRJgkoADGxbiTweltUxUdhb
Vs+hJURxIy6MS3f0mrs4kS1GXJo2gnSpRKT8akqdZqEkr1oSI33Fi1eHs/JE2LN+
AyGeqxg7F5BIoZdd3GTNXtA+Ykr5si82Oy/dyphLxmrfWQHvZ0vmCfOpyJaehc1W
JQaOKzmKtZfkctpNUqcmgbYS3pjGv2KfvYiWbT5z/I5vCog5GMiidwn/cD++QCUD
2ek2Oxk+B1XloPEPeHg+Dj2R2+osuMCA+NROEBxtjaEk7LvLZxrlWOm9udhZtG/S
Ro+EE6VB9O3MfuJOkYNgETbNdzMyTtMGj1zXBiY8N9JapxfKB6ZnGbvZUncjTjzh
r5yuO3Bp3jOuax0uZyunuPbEeux7qrC4KkBDr8WTwtnv/2jCpw8wqT14H4rR903f
WO3XTuUXarprGS2pWZp0xD0K4S5Vw1ua8+IWwl81IH73/TeXwLFfvTCKTSScfj3d
WyavN7LBbOeLFcSPyKDPyACr
=kPQr
-----END PGP SIGNATURE-----

--=-69hyOdobKMKNJBb5gHBc--
