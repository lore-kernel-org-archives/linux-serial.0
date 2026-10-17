Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424A4825C1
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792234157; cv=none; b=IVNGejYay6aIpGWbeSvpWxkP1D+Os90xQPI0i32bwYCvl0pXWVx7kRCTzRaQVid/57PKEUmpAh9zsSgSsctyYkKi5J59hoITkcVAy4isacozK5KuLhtscXxkgyFNfKJqpYr68wG5K+dLwwpzMKi7sqJd+pZ0SU+bPdDPXu+eZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792234157; c=relaxed/simple;
	bh=4IkWz0fAt6tzb2IiRdYaJ3TQcYsDJV9O+l1t72HHZak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+qsd+WIDBfvKzRz/OzSiRtm3VvpQ7oI1SSTn8+BwxWnct4Xw5gV8vUqdF3arkxYJWL2/iBzTppq9hQ/Q34BcR3GjIHNmV4Vz+Biz5k6EUAJtHEKExdsOtLmwgtTZ/yzCPexd5Wv6CXTSkHdhXIXOAqRUDWGvexwOhne/ukuAAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gD1GBkys; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gD1GBkys"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 9244B240103
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 12:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792234152;
	bh=cBuCgVM7uR5aFGMoFHO8vtXxdVtJzmrd41G9Rr1lQr0=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=gD1GBkysfEsRAdZf68J0vVZYOV0SpepJ7hogOp0Yx21MdeIM0Z9bXMcs9bsLJA0bR
	 i9jCROvYXZATOBxWP5zrjvZe5/uellsnHbeNsJ4zLmE7GeMYLaokCkxil+MM1iy2Jt
	 bTSn/eloKCQ3CvEAKDtdLgovgpLB9BXMFTigdgWsjk3yaZ6dORiXa81PS+rFW8vQK7
	 rkGzSBAF7LvOJ3OwzxtnuUfClcAcACwzsjEgVavpXsfiEEuDIbgaUbaiTBlr3au0qC
	 YCeskHl00KAyhbwB0qUqLpIQ4YsFqK0v7dXfowA3NXA1FSl2Ao3kE2k3N3FTTDm9v4
	 3Hgd+doReZp4w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j6JTJ4nXwz9rxN;
	Sat, 17 Oct 2026 12:49:08 +0200 (CEST)
Message-ID: <533e035ab0e390cd053513437ba3b49bcc52e226.camel@posteo.de>
Subject: Re: [PATCH v4 1/4] tty: serdev: Add mutex lock
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
Date: Sat, 17 Oct 2026 10:49:11 +0000
In-Reply-To: <2026101715-penny-headfirst-1644@gregkh>
References: 
	<20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de>
	 <20261016-rust_serdev_probe_refactor-v4-1-46832e034757@posteo.de>
	 <2026101715-penny-headfirst-1644@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Y9yB0ABxg49Dk+BLAnmv"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-Y9yB0ABxg49Dk+BLAnmv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-10-17 at 09:55 +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 16, 2026 at 06:00:32PM +0000, Markus Probst wrote:
> > Besides more predictable behaviour, this allows for several hardened
> > behaviour changes:
> >=20
> > Return -EALREADY in `serdev_device_open` if the device is already open
> > instead of causing undefined behaviour.
> >=20
> > Allow calling `serdev_device_close`, even if the device is already
> > closed instead of causing a null pointer dereference.
> >=20
> > If the device is left open by the driver after remove, close it and war=
n
> > instead of leaving it in a invalid state.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  drivers/tty/serdev/core.c           | 10 +++++---
> >  drivers/tty/serdev/serdev-ttyport.c | 46 +++++++++++++++++++++++++++++=
++------
> >  include/linux/serdev.h              |  2 +-
> >  3 files changed, 47 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 7500efcdfc21..77e8e1d4d2a6 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -142,6 +142,11 @@ void serdev_device_remove(struct serdev_device *se=
rdev)
> >  	struct serdev_controller *ctrl =3D serdev->ctrl;
> > =20
> >  	device_unregister(&serdev->dev);
> > +
> > +	/* Warn if driver did not close the serial device. */
> > +	if (ctrl->ops->close && WARN_ON(ctrl->ops->close(ctrl)))
> > +		pm_runtime_put(&ctrl->dev);
>=20
> Wait, how can close() ever fail?  That should be something that just
> can't happen right?
It can't fail and its not a fail. It returns true if the device was
closed, false if already closed. Currently the driver is responsible
for closing the device, so this should always be false.

The WARN_ON was intended if the driver did not close the device and
close it.

Thats the "If the device is left open by the driver after remove, close
it and warn instead of leaving it in a invalid state." part of the
commit msg.

But I see that a panic (panic-on-warn) is definitely not appropriate
here.

Thanks
- Markus Probst

>=20
> thanks,
>=20
> greg k-h

--=-Y9yB0ABxg49Dk+BLAnmv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrTUqMbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSCz4P/jRlhrCJdQeoI7xX7Np8
TT+7GJbEprIvoS8Y5TIj6iRJbhoGKs77+A88ISBtQ12wogSlSDhzhna9puQSdScz
wj2l9lCCt+wLVYMKgX2cJHU/aWgy+R4MXnpoAthywtTQcx7QLPexEacPSHBdDCW5
S5HGG94BZq51gE1iHqMslfnGpDg2ZtvvMLNuwhDNCR5nVGDBiGpzZWFbkocWGMrJ
2IcleyqDFE8piCYBureIo2zR9v4hDWVK8ahhI8QDqXH5Q0xT7yVsxsc4Frf5m32m
AD9CyOsG+WFCkULp+j1ACaDTgBO+m/Tw1tAfCpk3KlLSVDd3S5wbH0KWU/rhfhXN
awJc7QhdF0ZQj6+VN/CudzIu57c9SUdWENY9oRq2n3cNyGSjqCtA9UvYdRCcQVNj
ykQ4tBl5+zkgPLWCuPPhKydpeSrhriSQQGiBLp0KHUygLGKrsFGALfjsRG5dTfWN
MnM+2iv+YWlAjKXjggK6zYsztZ45p/5bvBOIgkRT8konIQEqQO9zVSGqzkjtyAFr
DmevEsxqo8KaMBaZJARFfpaSsjHNRHszE3HTliOXCIZaUjEJ+k0IQMd/eYkUpi5u
88nf2fO6k/mutO6Zcwu3LssnQliLlbHQc4Rz3nJr0XWKvoGbXtkhA0c5Pm6bYFFd
P88B0xHjYM6WsAb1+dszSrBl
=Bgx2
-----END PGP SIGNATURE-----

--=-Y9yB0ABxg49Dk+BLAnmv--
