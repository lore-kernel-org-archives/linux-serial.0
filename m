Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E7213E9C
	for <linux-serial@vger.kernel.org>; Sun, 31 May 2026 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780256545; cv=none; b=Juz+/PwWxIQFZkePV0Ab2ylLp2uNfmiM5+dTyivo+x/h7L7DNhi+z5XR/Efi9E5N7nyok1QmMlCKcVS222U7tHqVQqzG0hq6CoEL25nBmj/5smz6xaPp7kPtkbvmPYehhVY7PoaEfBfKoltTU9M7FLOCsYYa6P8k/Of1OG3gF4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780256545; c=relaxed/simple;
	bh=YBFhw99VSvWxAjZ4DkTKQ7yaDKMKFaq9Ed6jBIkTrco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGRiHn/fDcDmExVZa9hFmM7BRHl0j/p+NyL/HJEr9jWnmz+dBQudLPSdwBaX3NIQcuI5P/rdHJW0YdW9SI/qqxnZb9pqo4fylg5NHtprZissGxiLKXbM/SfTd2ltcSt5ItJ/HAMqn8M+ChBfP3BK6MSTRAotSdfskeZHTd5LyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=owDtBQDL; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="owDtBQDL"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6CAAE240028
	for <linux-serial@vger.kernel.org>; Sun, 31 May 2026 21:42:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780256542; bh=hUSWLp5mi7L5MOKZrN3iLNpIOwJb8J5/4ZNT2N3R2ww=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=owDtBQDLgsKiOMwEXQi/IAIQCjwA+Mqa/23jbm94R7/6pOWMci10NYImeUg9+ZqOh
	 hSTeeMChegEgibluJl0M5AYfLA03DvUI4zALnx++jSJpn/0n+w7nyOTJOvbgHBmu3w
	 /g2MllJ4PJ3DVODZbQNDq8FVdFD7B/lAqrfZuC/bUsvez23YPKBR6llHk8FLFWrrlt
	 5mw9Y+msoVUySj1+r0yIPFFeDWNJuGKlRIjbWSSKpsJOK9m6SzWSSnFf2EHb1BVhZU
	 +OnxNhzKryONTUSNs2j7CTYDMXVkAz5sqCtaGQe/ZSM4jKM4SuDYgdnE8MASFrz8Cd
	 AhGQCHXHyYjSw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gT6tg2ngKz6tyt;
	Sun, 31 May 2026 21:42:19 +0200 (CEST)
Message-ID: <12fa6237168ecf6dc65ebf46118beeb5c51f3d1c.camel@posteo.de>
Subject: Re: [PATCH v11 1/3] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>, Markus Probst via B4 Relay
	 <devnull+markus.probst.posteo.de@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel
 Ojeda	 <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Kari Argillander
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, 	linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, 	dri-devel@lists.freedesktop.org
Date: Sun, 31 May 2026 19:42:21 +0000
In-Reply-To: <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
	 <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de>
	 <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-i+uPwUkDiLZ5y8MtsrTf"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-i+uPwUkDiLZ5y8MtsrTf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-05-31 at 01:51 +0200, Danilo Krummrich wrote:
> On Sun May 31, 2026 at 12:51 AM CEST, Markus Probst via B4 Relay wrote:
> > +#[pinned_drop]
> > +impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        let mut active =3D self.active.lock();
> > +        if *active {
> > +            // SAFETY:
> > +            // - We have exclusive access to `self.driver`.
> > +            // - `self.driver` is guaranteed to be initialized.
> > +            unsafe { (*self.driver.get()).assume_init_drop() };
> > +            *active =3D false;
> > +        }
> > +
> > +        // SAFETY: We have exclusive access to `self.open`.
> > +        if unsafe { *self.open.get() } {
> > +            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a poin=
ter to a valid
> > +            // `struct serdev_device`.
> > +            unsafe { bindings::serdev_device_close(self.sdev.as_raw())=
 };
> > +        }
> > +    }
> > +}
>=20
> Just in case it came across otherwise, I did not mean to push for you to =
go for
> this approach. We just kept discussing it because it let to the (to me mo=
re
> interesting) discussion around the LED class device abstraction.
>=20
> While this approach gets us rid of an extra allocation and the rust_priva=
te_data
> pointer in struct serdev_device it also turns out a bit more convoluted.
>=20
> That said, both are correct, and I won't object either one; up to you and=
 the
> serdev / tty maintainers.
>=20
> Please wait a bit before resending, so other people can comment on this a=
s well.
>=20
> > +    extern "C" fn receive_buf_callback(
> > +        sdev: *mut bindings::serdev_device,
> > +        buf: *const u8,
> > +        length: usize,
> > +    ) -> usize {
> > +        // SAFETY: The serial device bus only ever calls the receive b=
uf callback with a valid
> > +        // pointer to a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `receive_buf=
_callback()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l<'_>>>() };
>=20
> CoreInternal snuck back in, should be BoundInternal.
>=20
> > +
> > +        // SAFETY: `receive_buf_callback` is only ever called after a =
successful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> > +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<P=
rivateData<'_, T>>() };
> > +        let active =3D private_data.active.lock();
>=20
> I think SRCU would be a much better fit, but the code didn't land yet, so=
 the
> mutex seems fine for now. But I'd probably add a TODO.
I just noticed, is it even possible to use SRCU here? Currently the
mutex not only ensures that no drvdata access happens after drvdata
drop, but also that the receive_buf waits for the probe to complete, as
the drvdata hasn't been initialized yet.

(drvdata refers to PrivateData.driver in this context, not the whole
PrivateData)

Thanks
- Markus Probst

>=20
> > +
> > +        if !*active {
> > +            return length;
> > +        }
> > +
> > +        // SAFETY: No one has exclusive access to `private_data.driver=
`.
> > +        let data =3D unsafe { &*private_data.driver.get() };
> > +        // SAFETY:
> > +        // - `private_data.driver` is pinned.
> > +        // - `receive_buf_callback` is only ever called after a succes=
sful call to `probe_callback`,
> > +        //   hence it's guaranteed that `private_data.driver` was init=
ialized.
> > +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_in=
it_ref()) };
> > +
> > +        // SAFETY: `buf` is guaranteed to be non-null and has the size=
 of `length`.
> > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) =
};
> > +
> > +        T::receive(sdev, data_pinned, buf)
> > +    }
> > +}

--=-i+uPwUkDiLZ5y8MtsrTf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmocjxobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSpGMQALexWGRaLmUISqGonZYw
CeOMrMEudQuPoIAC1NbyIgnpT3ir0TLAP0G5nEwbQDKSeB3syHQqjEB8wMYaYjHX
RUFlkm1ITINn5Yc3Pj0gL6FI3RC96G/1NZjtDhLxct+qeYzovYfe5ECfU6Cch65c
H2LCNtBQdLOWc//PCXrz7gX6HYZnv4pGVlZrWxxvDLt21MFCAKJEpt+xDvIkU+BK
KX40c+lHqUNNlafCLiZnKTGw6XusWT6ziCN8OaQcCLkbhXKIoka1rSQh6e40HNRG
S7Cjj4o/8ix5JLmURMpNXtxUV2G51F9St9oG/iGYIuwMxwRA5HdRFoats9NwdSa9
GLrhaCdaqJ3awv57Bp+k/HVCG6pta0KkNs/BPbHQ2dtkHNCn5d7QZk3IZ2ilU/pY
qrAqDMylJc2gCRoQqhQKZRk9XMZ1iubnHUEojgEJGH1Eo0zf72R6IIVvAN5/3gZI
RaAbCMzYr7Fnt0eQf0I8VIpkSf6EcfOeD0IVkGiEsqA64h0fM/XFeuXMa7i7Mwhv
LDvHWpQWpknQ3SpwuMkgpMOUkqmpmrCjJ8PEtofApBxCigw0jyzVfR783WE3Xvhg
r+f+Lvm5kiBMp9Whdqg74ybQ/w4MRjC42y8bQ9bOdfinP5+7mTOimsDvMADhcLbM
rchoKeYTBB0SYYICElpnVTmL
=ADNr
-----END PGP SIGNATURE-----

--=-i+uPwUkDiLZ5y8MtsrTf--
