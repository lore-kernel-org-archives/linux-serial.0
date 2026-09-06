Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56F3672BD
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788735108; cv=none; b=Ek3LKpPrIdHECG+C40av3oRaGG35zwAg9zsMXuTO8BMuOAgcrGelBe0pkOyXOMVRKQQ5+XXX8N5HYpz/HQdPQOlFFD7NLAdc/rPFNNqi2zr9oYQXLHUaIjPWOPZ+8udFVY2GvT9lRDOlsyERXjC9dP8pIie9wQfjBVgon7fjN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788735108; c=relaxed/simple;
	bh=i4+pMq8RfkXacHmv7Svg+kGHmqAZnCrvK/VeI7b2oXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUIsnUDTmfXkUiUKohH7h+t754YRJO6XvJ/4XCHjAFl6cIx/m1BHDjVd1eH3BgnEdlwHGWqKKFyd3Y2yLjpc2BHoWzOE6gEHkCXDluVB1d519+CjnNlGV3TKHkUH32R5DQvhQROnFHLP2tHBAjIRdqe2zE5WufswaW1Xo+wvuuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=V1FMP3+C; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="V1FMP3+C"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CD12A240103
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 00:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788735102;
	bh=/Q56Wb1/9lKtdrTb6VR7lZsGxngRIpsDL8gGx9GD0jQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=V1FMP3+C/K7fvCMl7R0bdkuRqy9abAfT86sKSxy5o3a3OWtkQsaEs8LwFKgAQvIgq
	 L3ZlzsdIvYCnIJqu6bCBfFzYR83dz7di10iTQBe2QRFtpIKFckKjyGnQFYbCLm5+sl
	 QUkt3wVCpCGaQXaEn/e3gCGV1r7sR2n30e6BnzjovsFkTWnNgjuyUr2KvudKQhMVNk
	 tf89c9A5HRGGyn7ZDejXiW8Y/7RuPxEMJVCIrUsSUyHGjp8hWn5W4jbb6uL5pwfhhs
	 lrSjX2hiT772n1+wHh+0GX3npMaxBgL2r03RHqFoKJ7AG52OWRz7d3n7ly+N9AVB92
	 aB/GZSEGIxJWQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hdQRt3zrPz9rxD;
	Mon,  7 Sep 2026 00:51:38 +0200 (CEST)
Message-ID: <78d42a2753ae84e4983e9a7b118188f9cc8bdf3d.camel@posteo.de>
Subject: Re: [PATCH 5/5] rust: serdev: Pause receive callback before calling
 unbind
From: Markus Probst <markus.probst@posteo.de>
To: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>
Cc: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miguel Ojeda	 <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>, Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel	
 <ardb@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka	
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Uladzislau
 Rezki	 <urezki@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, "Rafael J.
 Wysocki"	 <rafael@kernel.org>, greybus-dev@lists.linaro.org,
 linux-serial@vger.kernel.org, 	rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	driver-core@lists.linux.dev
Date: Sun, 06 Sep 2026 22:51:41 +0000
In-Reply-To: <DL8IAYDEO7VG.1HPQR4U9S7H2Q@garyguo.net>
References: 
	<20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
	 <20260906-rust_serdev_probe_refactor-v1-5-69cdae0074ec@posteo.de>
	 <DL8DCNMSENDS.3T14U5W1Y32IX@kernel.org>
	 <DL8IAYDEO7VG.1HPQR4U9S7H2Q@garyguo.net>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-FffS2llmFmQCY0T8Gil3"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-FffS2llmFmQCY0T8Gil3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-09-06 at 21:13 +0100, Gary Guo wrote:
> On Sun Sep 6, 2026 at 5:20 PM BST, Danilo Krummrich wrote:
> > On Sun Sep 6, 2026 at 5:55 PM CEST, Markus Probst wrote:
> > > @@ -200,10 +203,14 @@ extern "C" fn receive_buf_callback(
> > >          // INVARIANT: `sdev` is valid for the duration of `receive_b=
uf_callback()`.
> > >          let sdev =3D unsafe { &*sdev.cast::<Device<device::BoundInte=
rnal>>() };
> > > =20
> > > -        // SAFETY: `receive_buf_callback` is only ever called after =
a successful call to
> > > -        // `probe_callback`, hence it's guaranteed that `Device::set=
_drvdata()` has been called
> > > -        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> > > -        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };
> > > +        // SAFETY:
> > > +        // - `receive_buf_callback` is only ever called after a succ=
essful call to `probe_callback`,
> > > +        //   hence it's guaranteed that `Device::set_drvdata()` has =
been called and stored a
> > > +        //   `Pin<KBox<PrivateData<'_, T>>>`.
> > > +        // - `unbind_callback` calls `serdev_device_pause_rx` before=
 accessing the driver data,
> > > +        //   which guarantees that this function will not overlap wi=
th it. Thus we have exclusive
> > > +        //   access.
> > > +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow_m=
ut::<PrivateData<'_, T>>() };
> >=20
> > This would break the driver core's lifetime design. Any kind of registr=
ation
> > (such as class device, auxiliary, IRQ, etc.) may borrow fields from the=
 bus
> > device private data. The whole design is based on the guarantee that we=
 never
> > construct a mutable reference of the bus device private data.
>=20
> Mutable references should be fine (of course, provided that the bus actua=
lly
> serialize callbacks).
The calls do not overlap.

>=20
> It's only problematic now because in absence of pin-init self-reference, =
the
> immutable borrow is the only mechanism that prevent user from having mult=
iple
> mutable borrow of the data fields.
Why is having multiple mutable borrows, assuming they are from
different fields, problematic?

>=20
> Say this code:
>=20
>     struct MyDeviceData<'a> {
>         foo: Resource<'a>,
>         bar: Resource<'foo>,
>         baz: Resource<'bar>,
>     }
>=20
> pin-init would make `foo` and `bar` be only visible immutably in the proj=
ection,
> even from `Pin<&mut MyDeviceData<'_>>`, so the design is still sound.
So its only problematic, if the driver data is not pinned?

Thanks
- Markus Probst

>=20
> Best,
> Gary

--=-FffS2llmFmQCY0T8Gil3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqd7mUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSZwAP/1P67ir/sS3FGiHIcjFE
8jCk3nCOtUt1Vt2YtW+8cpPPqEQNqzyW2VQhyQBTNQUzWJv1iVNT428F+2q2HnQb
jhpNwyXn6nprwmutCaXBDSqJ6MeR4bIXwRqYP6Xe12yiwIQ0cf3gL7VU2sQL9TOS
pO3ztzDKs7W8rT/CpmGWtuuo5qQfCg1R9rTeV+2PvoizLKovcjNePXIe09ZQtgze
GQO92mLk662dCuZK2e5UQ7+G9J+0J9jR95HFFFlwAc4WDk9LdFLy2mIiV1/MBmD3
dQvvHezx7IlesQ6cKAm8MNHN7jKUm07WfSEUtsVe/kirnB2mkbt1ptfUBFZg1oxj
zzvqj2d9h+9d0DJFYF9XY1M3qqOFryH3CcHRVg9kpmPivL+HzR1DzrZwcbRVBViA
IKn5HdFSivjovqmySGWSIeZT7P7b/0zMdFoQlKdcfYEwDNj6L3+ilhGnkuObbtR4
g1nHfz0MUxkAOCbOV95VjzP9ixuEirFbrTfUr6+ITpRN3H88IWcNi32CdmhDD2a+
g/09GpVaLZTxovh1QtDiNpiqtfEgvd81FnrsjUIp1EpUmzG+rLkpooP3FSStNnI6
g27gPUF+2mFCfzNwXeBI2yFxmR9+KzJGNRblTt9wECqFvsI2rR4Ed7B6/BhC8O8b
mn6vpw7pRQhiEXjW3eXp8Rrp
=xwaE
-----END PGP SIGNATURE-----

--=-FffS2llmFmQCY0T8Gil3--
