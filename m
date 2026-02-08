Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64331A3164
	for <linux-serial@vger.kernel.org>; Sun,  8 Feb 2026 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561063; cv=none; b=Vm3K2BuQ4GBjOmaDCDJAongCy7lT47cSw+gkYjsZeDqO7a+wkciFiVNDPQ4Aqhl9R8NmH4PtDB0Nvo5gr91ETdTt+paUmR6JX+NbGWZA1XFnN2D5+sAIeAklRxOUw27VKJvDMX4GbqGZ3AeteuePEJLkZmRC0NEK4/ypN8h0yW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561063; c=relaxed/simple;
	bh=pbCkEkWa1lWZlwrhkBS8CLXpb2GK6lzpuJAYBPRvdqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aSL/1u8mn9RhDwEXf7m5sFhd2wwYc57jSHrgYUbyXVncNB036oKVPaaLjmG0PJJNUurwCJIOZeaTukCeI331IwHGTaajKcK9w3HhgknOW1vbLe3Zorty2QvblIUoXm8wjrpZI9vtBme97fUz62Jon3GXEbnjsKXCH+oZsudXOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ixz2/6J+; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ixz2/6J+"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0AE2C240028
	for <linux-serial@vger.kernel.org>; Sun,  8 Feb 2026 15:30:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1770561055; bh=RtHV67lTv9EOToX4HKMd2z97lTyUYkFAyY7IYrI5Y8I=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=ixz2/6J+opwtpdjRkRz5oKIIM+IBRCAmu1EFG10PnAoSSEdSyQ5QlxZ9q748NVdFn
	 IWxzpCm6930sGIkZcEDuaxKnSGOrgSbLGwdShPROUOhx97ekz16KxzhOMXyWdw5m9u
	 FULVHDnbuHqz6WuEhd8UaJtDFrQUmvxxE6EBkVmeaRk3GAg1ug24oQcYdvtQTcBNa+
	 A1VRzTWjatwT7i1MJRcl8ZjHbBMA0IjX44XioU/rN0LPcTxQ9FyJmAe9X6zNiU68El
	 41YmyOQYgGmdCiLkXBUFxpJioYfPd9h2zVi+oqhBpNk/z+a0xniaEuZHjbx2gc9w8b
	 RbHDftWzguheQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4f89H04cDxz6tw2;
	Sun,  8 Feb 2026 15:30:52 +0100 (CET)
Message-ID: <40a161f055ad3410bba82c1a07fb3c674241c599.camel@posteo.de>
Subject: Re: [PATCH RFC 2/4] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Kari Argillander <kari.argillander@gmail.com>, Rob Herring
 <robh@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri
 Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Date: Sun, 08 Feb 2026 14:30:54 +0000
In-Reply-To: <DFNN75KWL8B9.1YHK1ZRV43W7O@kernel.org>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
	 <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
	 <CAC=eVgSmD+bYh48gZteAaqwSHvcHes3CFmbUUBu=6UQ6fKCUJg@mail.gmail.com>
	 <76491897ad6e0ff2749935c39702b93adc9951d6.camel@posteo.de>
	 <DFNN75KWL8B9.1YHK1ZRV43W7O@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-eJFpwtfDL2KVNYqwXGEV"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-eJFpwtfDL2KVNYqwXGEV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-13 at 18:37 +0100, Danilo Krummrich wrote:
> On Tue Jan 13, 2026 at 5:15 PM CET, Markus Probst wrote:
> > > > +impl<T: Driver + 'static> Adapter<T> {
> > > > +    const OPS: &'static bindings::serdev_device_ops =3D &bindings:=
:serdev_device_ops {
> > > > +        receive_buf: if T::HAS_RECEIVE {
> > > > +            Some(Self::receive_buf_callback)
> > > > +        } else {
> > > > +            None
> > > > +        },
> > > > +        write_wakeup: if T::HAS_WRITE_WAKEUP {
> > > > +            Some(Self::write_wakeup_callback)
> > > > +        } else {
> > > > +            Some(bindings::serdev_device_write_wakeup)
> > > > +        },
> > > > +    };
> > > > +    const INITIAL_OPS: &'static bindings::serdev_device_ops =3D &b=
indings::serdev_device_ops {
> > > > +        receive_buf: Some(Self::initial_receive_buf_callback),
> > > > +        write_wakeup: if T::HAS_WRITE_WAKEUP_INITIAL {
> > > > +            Some(Self::initial_write_wakeup_callback)
> > > > +        } else {
> > > > +            Some(bindings::serdev_device_write_wakeup)
> > > > +        },
> > > > +    };
> > > > +    const NO_OPS: &'static bindings::serdev_device_ops =3D &bindin=
gs::serdev_device_ops {
> > > > +        receive_buf: None,
> > > > +        write_wakeup: Some(bindings::serdev_device_write_wakeup),
> > > > +    };
> > > > +
> > > > +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_devic=
e) -> kernel::ffi::c_int {
> > > > +        // SAFETY: The serial device bus only ever calls the probe=
 callback with a valid pointer to
> > > > +        // a `struct serdev_device`.
> > > > +        //
> > > > +        // INVARIANT: `sdev` is valid for the duration of `probe_c=
allback()`.
> > > > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInt=
ernal>>() };
> > > > +        let info =3D <Self as driver::Adapter>::id_info(sdev.as_re=
f());
> > > > +
> > > > +        from_result(|| {
> > > > +            let data =3D try_pin_init!(Drvdata {
> > > > +                driver <- T::probe(sdev, info),
> > > > +                initial_data: Some(Default::default()).into(),
> > > > +                late_probe_data: None.into(),
> > > > +            });
> > > > +
> > > > +            sdev.as_ref().set_drvdata(data)?;
>=20
> This does not work, a driver can obtain its device private data with
> Device::<Bound>::drvdata() [1].
>=20
> For this the driver must assert the correct type, but since you use a pri=
vate
> type instead of the type given by the driver, i.e. T, Device::<Bound>::dr=
vdata()
> will always fail for the driver.
>=20
> [1] https://rust.docs.kernel.org/kernel/device/struct.Device.html#method.=
drvdata
>=20
What do you suggest as alternative? Besides from the "initial data"
debate, I still need to store at least one `Completion` to ensure
safety.

Thanks
- Markus Probst

--=-eJFpwtfDL2KVNYqwXGEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmmIng8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSzswP/ik5HY82phd018DfnX1G
dDFSTHX2EnWIE7yRL42WXt0dw5xSggMdJyYgurH96oew8etCbOezIgBUBoSZA5cP
JvKdKKljBmIaRmI/b+A2+oaWFAuYytlhjINTfGwkwZ2wN32il5L2dSK9EMO5MPFi
KoZfOpUCUG9jbN3iCW9+0CvwrZoOTrc+4As740hxTkKIFDpGNcJ3zM6upw8y0jNG
XQHVoZ+Mu14QEsCH8gZzG0d/aCgDkymkCCCtpToHhtEkIbzmrY61hZP4/FY+yNmi
gzeFonPcDoSdltvgb+uU89vcbeJq3whIzIkB4TlqB1iK8CwxUfEFJb7kCLXgqYoI
h7JbIOe5uvOCo0cljuOs+p46n3lqEOr77p1YMjCCNeyY/OIPotDn9jGVb/Xcujjy
GUN5RM8ImVLsKUL/F57+hvS25Uqc6uBZhqFqtadXlMNGsnXYh7DKOXLnR2qKKKwO
Tms1ZEjgtq7AOrLbWD3s92Y2jOhzMxiwnPe4WZvb7a4WaCtGy1X6MTzp3vYNy1WB
pzn0GJDKqkrLS+3/ZU4FCy7z8WbHMvyKXkeesH/7Fi07yvCgcA2s8vQyev9TmmUM
mruB6OirajYGsdT9i/AAs3JnISaveF736Tup5EtKK8JMl5ejtOVTGHXQBneGbRoD
Ri8nrvr4pIyt46SuB5ftiBfY
=iIVa
-----END PGP SIGNATURE-----

--=-eJFpwtfDL2KVNYqwXGEV--
