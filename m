Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF63016F1
	for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766334501; cv=none; b=baZ3raJvNhGkZM5/d6SbYY+qzdtez+5tRQNCF6jUGRjEaxzFR0sbevMDKKWLoaRF33W85WopX7JsWjAzXoK1+o7x5IarbMzru8MR0cxe6DNV66fvFvJ5MS1BUCe6jO1M/lVw7nsD4tItWaEuNexz/cqehr+qG29RgmRVCba81lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766334501; c=relaxed/simple;
	bh=jaxJJlMUxlb7zkwYnER72vo6g0NjPi9r0zxdT1k8B7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vo2g9l9oCIwUxePbh0hgAHGUelP0LW2swpQcKX0laoRs7rV0Da8KyrQ6NnVsB1iR9McR/cvFKaBX02lio41q0EP1xism+IHGD0lR2rgnD2HEfl2GShL6QKnpxq1XOeO4r3ZYA1No3Ol+G6P8gcPSjoFY224rftzWHc22CI6UjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gUkOSVzG; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gUkOSVzG"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D3D73240105
	for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 17:28:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1766334491; bh=KSBZG3aCk3iKW2RACGge8JSEllNpFt79wXFY4DPunNc=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=gUkOSVzGmWErs58XRXdmdWjZ+c4kmFf6SrNbJYV0R6IoQQJoQPusa4lkSMQXAbzTG
	 ZHkXW0ZaUXxsLJ9fvEx6eAlih1LUSzlUhDO3AuxR1sF9kevyFELSM8DwOiYnYut930
	 JxKuk5H2ED/1SEzoU7JPzRr7voACPD+9xO2tj7qNNp4leQFb21F0i4J6R0mf0GxFXu
	 NxtVsrEZRmQoXCOWiVai8hA1shuEG2FP3cId9pgiPvgDcFyoSW+MSS+16zhwU4FyfW
	 UNwAlBLE0rmDQztjnHpSEBQLCrkQj1w12O94FRLs6xJECm8WrBfrY9e/ksrkh73bEg
	 +1ez/yUHP9iFg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dZ6By0bGRz9rwn;
	Sun, 21 Dec 2025 17:28:10 +0100 (CET)
Message-ID: <4b55501e500edb8416ed690757f72752f1c49517.camel@posteo.de>
Subject: Re: [PATCH RFC 1/4] serdev: Export internal is_serdev_device() for
 drivers
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Kari
 Argillander	 <kari.argillander@gmail.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Sun, 21 Dec 2025 16:28:11 +0000
In-Reply-To: <2025122138-saucy-unexpired-0b98@gregkh>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
	 <20251220-rust_serdev-v1-1-e44645767621@posteo.de>
	 <2025122138-saucy-unexpired-0b98@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 66sLA9g==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-8wUYIeHj/nRVOf9CAnMD"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-8wUYIeHj/nRVOf9CAnMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-12-21 at 17:10 +0100, Greg Kroah-Hartman wrote:
> On Sat, Dec 20, 2025 at 06:44:05PM +0000, Markus Probst wrote:
> > From: Kari Argillander <kari.argillander@gmail.com>
> >=20
> > The serdev core has an internal is_serdev_device() helper, but it was
> > not accessible to drivers. Make it public by declaring it in serdev.h
> > and exporting the symbol so that modular serdev drivers can rely on it
> > instead of duplicating type checks.
> >=20
> > This allows example future Rust serdev abstraction to have
> >=20
> >     TryFrom<&device::Device<Ctx>> for &serdev::Device<Ctx>
>=20
> But why is that going to be needed?
>=20
> > That way using bus is easy for other substystems. Also some other
> > subsystems expose similar function:
> >=20
> >   - bool is_usb_device(const struct device *dev)
> >   - bool dev_is_pci(const struct device *dev)
>=20
> Yes, and usually that's not a good idea, unless you have a bus with
> multiple types of devices on it.  I don't think serdev has that, does
> it?
>=20
> Only under special circumstances should this be required, so I'm curious
> as to why you would ever have a pointer to a struct device and not
> "know" that it is of this type?  Who is passing that to you?
For example, the pwm rust abstraction currently only provides a
`device::Device<device::Bound>` reference in callbacks [1]. If we want
to write data to the serial device in one of the pwm callbacks, we need
to convert the `device::Device<device::Bound>` reference to
`serdev::Device<device::Bound>`. The TryFrom implementation provides a
*safe* abstraction.

At least in the pwm example, this could/should be circumvented with the
`AsBusDevice` trait [2].

But this technically also applies to all other bus device abstractions
and they also have a `TryFrom<&device::Device<Ctx>>` implementation, so
with this it would be consistent across all rust bus device
abstractions.

Thanks
- Markus Probst

[1] https://rust.docs.kernel.org/kernel/pwm/trait.PwmOps.html

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/r=
ust/kernel/device.rs?id=3De4addc7cc2dfcc19f1c8c8e47f3834b22cb21559

>=20
> thanks,
>=20
> greg k-h

--=-8wUYIeHj/nRVOf9CAnMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmlIIBEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSs5MQAKVKI/dhoBIA0RVMM6nk
2hUgtZ4qeLm7mSwlNkaiAWwDvTXHuspbnmVtfMaZNTD6TfS0cnjlj4VMzOBgcIte
KmfuuCEeRZHBlp6CfgohL65q/yo1yto0+/SwI3+HCl36VekOhlKxkaIAea39QFXA
MICf/aT8CSVWXutsfocbO2vCj/+xEAymMeWUlO3au6hDdfMz6lAeA/ehzor9qhKg
PXSiQAHysAol0Q+wBQKHHsImaHm9HWp+cgtZMlpiKLah+yUqbbEpvGbPI+baW9Ni
FtUBveW5xC+cjkbSZohjWpUFX1dYNrPUiM6jYL+cB7cm5z7arfoQcB/hcu4UD39G
Tn457ZaiYScZXH5FJAZDhrtymFewD4yGUydc1oWmtpCwVfK8DpD5eu7PVjJWqEAX
mt2Sr3NvHEh5yD5n+s8ILn25DenO7C/RCpVHXN9+6GSnd3NOLey330+2L5jyrK/w
eZlvTDHIzMzim/eOdGcB+MF0lJOK4gkEqxrDxCRNnhwRlpe/65gW4QQwQzIJwrkM
dA6np/kFZxkPR3y+xdv9ysk999eZbOmidezd3NzmqqvPJnOI20Ca1macm6md0ciJ
ZO1WSQjQcbUBVEfoEXnOyRVIiBew+DOd0Ye/jGVdHVANuNtbi2olhaKnbcFDbm2t
3iIJ8nkF5djbAPex8sYgN8/s
=zmgk
-----END PGP SIGNATURE-----

--=-8wUYIeHj/nRVOf9CAnMD--
