Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF142D94B0
	for <linux-serial@vger.kernel.org>; Sun, 31 May 2026 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780245439; cv=none; b=dwNVCfcehfHqemNazFvI2ifRtyI2g4YI5ifFOTF/IFUrj+wsM95pf6JWe7wSmpS2ZXTg+NaYsG1rdGpdsND4WPKrV3w05BQFgdt3cmRWimCz++d++h6OQy95xZxcQyvS2oyhKTu828lTQmMjDVeQr9Ion2UXUYa5iexPAjpP2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780245439; c=relaxed/simple;
	bh=c0z+C/zo3URoME42Op2914ywVokUV7mXxkV5sADlrv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NgUkjNJmJfBKrOEKw3qb2bW3Qpma/R+W0j+31FnilRk6iJ3OKCV3QtRw0uvNL7O1BCtlVzaKqi6yBolwtwLFa84ckL9HiA2aE49a1dilwtcdwGpr30FRGMHeWOwa220JJN2kj0xJMRGj0XGZXbZsIIlTmaN44yEbJzF5aPEhZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=cLfNa5gT; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="cLfNa5gT"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 17B04240108
	for <linux-serial@vger.kernel.org>; Sun, 31 May 2026 18:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780245436; bh=PvIIedI+sF/BmDwoMDDUihwNZtD52Ld7yDrZZaLcGCU=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=cLfNa5gTrjNrT60JAeMF7p8L3DUVqh2+vqhN1SOes94yvxemGWpOBYdthvYBOXWz7
	 N8UrnWzOOLDXFyP/HdIiQFM7q+z9MrfNhPiotT9yuskidKZmdD14aPUSuQfq+XvlMq
	 tSLL41gZKJ7+QUHLQ5ipUY8dCSEZdihHd9RfvbZ3HpOmBvGbzaki+qT43sb/dO7JYV
	 8AC3ID2ZUsT2nea03GzgIOQrNDoSSPiz+Gewsl7OAXTFJX6QprigjrpZeVFjvWNBwt
	 Ce1hhYR8caeCIg5p4sgJ44rvbaQMHaL+mrG9AMDV7wWfuALzUEs+z0hW55iNUxWNFS
	 qgyjUxqBsbw4Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gT2n46HjZz6tvk;
	Sun, 31 May 2026 18:37:12 +0200 (CEST)
Message-ID: <b6191edf3dc052fa86fae12fa5746d0c1c9c45ed.camel@posteo.de>
Subject: Re: [PATCH v11 1/3] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Danilo Krummrich
	 <dakr@kernel.org>
Cc: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>,
  Rob Herring <robh@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby	 <jirislaby@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo	 <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Kari
 Argillander <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng
 <boqun@kernel.org>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Date: Sun, 31 May 2026 16:37:15 +0000
In-Reply-To: <20260531065838.7352-1-work@onurozkan.dev>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
	 <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de>
	 <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
	 <20260531065838.7352-1-work@onurozkan.dev>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-7NhA1itbyMFsOO2Uwj5e"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-7NhA1itbyMFsOO2Uwj5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-05-31 at 09:58 +0300, Onur =C3=96zkan wrote:
> On Sun, 31 May 2026 01:51:08 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> > On Sun May 31, 2026 at 12:51 AM CEST, Markus Probst via B4 Relay wrote:
> > > +#[pinned_drop]
> > > +impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
> > > +    fn drop(self: Pin<&mut Self>) {
> > > +        let mut active =3D self.active.lock();
> > > +        if *active {
> > > +            // SAFETY:
> > > +            // - We have exclusive access to `self.driver`.
> > > +            // - `self.driver` is guaranteed to be initialized.
> > > +            unsafe { (*self.driver.get()).assume_init_drop() };
> > > +            *active =3D false;
> > > +        }
> > > +
> > > +        // SAFETY: We have exclusive access to `self.open`.
> > > +        if unsafe { *self.open.get() } {
> > > +            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a po=
inter to a valid
> > > +            // `struct serdev_device`.
> > > +            unsafe { bindings::serdev_device_close(self.sdev.as_raw(=
)) };
> > > +        }
> > > +    }
> > > +}
> >=20
> > Just in case it came across otherwise, I did not mean to push for you t=
o go for
> > this approach. We just kept discussing it because it let to the (to me =
more
> > interesting) discussion around the LED class device abstraction.
> >=20
> > While this approach gets us rid of an extra allocation and the rust_pri=
vate_data
> > pointer in struct serdev_device it also turns out a bit more convoluted=
.
> >=20
> > That said, both are correct, and I won't object either one; up to you a=
nd the
> > serdev / tty maintainers.
> >=20
> > Please wait a bit before resending, so other people can comment on this=
 as well.
> >=20
> > > +    extern "C" fn receive_buf_callback(
> > > +        sdev: *mut bindings::serdev_device,
> > > +        buf: *const u8,
> > > +        length: usize,
> > > +    ) -> usize {
> > > +        // SAFETY: The serial device bus only ever calls the receive=
 buf callback with a valid
> > > +        // pointer to a `struct serdev_device`.
> > > +        //
> > > +        // INVARIANT: `sdev` is valid for the duration of `receive_b=
uf_callback()`.
> > > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInter=
nal<'_>>>() };
> >=20
> > CoreInternal snuck back in, should be BoundInternal.
> >=20
> > > +
> > > +        // SAFETY: `receive_buf_callback` is only ever called after =
a successful call to
> > > +        // `probe_callback`, hence it's guaranteed that `Device::set=
_drvdata()` has been called
> > > +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> > > +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };
> > > +        let active =3D private_data.active.lock();
> >=20
> > I think SRCU would be a much better fit, but the code didn't land yet, =
so the
> > mutex seems fine for now. But I'd probably add a TODO.
> >=20
>=20
> Jfyi v9 is on the list [1] and I would say we are pretty close on taking =
that.
How close? Should I rebase this patch on top of the srcu patch series?

Thanks
- Markus Probst

>=20
> Thanks,
> Onur
>=20
> [1]: https://lore.kernel.org/rust-for-linux/DIWEXUCNLURG.136XXDBHSBNVR@ke=
rnel.org
>=20
> > > +
> > > +        if !*active {
> > > +            return length;
> > > +        }
> > > +
> > > +        // SAFETY: No one has exclusive access to `private_data.driv=
er`.
> > > +        let data =3D unsafe { &*private_data.driver.get() };
> > > +        // SAFETY:
> > > +        // - `private_data.driver` is pinned.
> > > +        // - `receive_buf_callback` is only ever called after a succ=
essful call to `probe_callback`,
> > > +        //   hence it's guaranteed that `private_data.driver` was in=
itialized.
> > > +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_=
init_ref()) };
> > > +
> > > +        // SAFETY: `buf` is guaranteed to be non-null and has the si=
ze of `length`.
> > > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length=
) };
> > > +
> > > +        T::receive(sdev, data_pinned, buf)
> > > +    }
> > > +}

--=-7NhA1itbyMFsOO2Uwj5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmocY7gbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSNGQP/RiMGi2eCcOVVmDXOKWb
xa1FSUfdFH6GxQQnd/DC5TqwfiUbCA9HaVDlNrdOgKiSEE07LgsDtiyP2mw0R0l/
5DCZIzdf8fOAcDwugS0edKew8wGE2yEN0bGtCn2m9u7NVLVR8fu7ZLHVmN5d6Taj
Vfuu4px2WLnj8M2wzVm29DMP3ACOT/bJdnf+Edqe+9MJF/Ra7JKe03u21tV+586o
9Fuu1b/RyOlB+GeJ2hMUrne7Y3QWe17ShwE4TchJUg/EqgZMeYNPYN/MvpTnyGFb
zREm5mkQxu+kY4CtKeeYPWeKz7n2O+x/iubzZdrZUpF++8rgwFBxiaPk1v2+OCKY
Ab+QeoZYpFebOIbVRdtkKXPfnw7xHBpZwIMTxJyEXQslulmdkElxyGjJgrmLEQD6
CfDZSL9o2xOrMvLljpzOCNZknRM0Jxnfh85xx3kvvubTGIeZV5H57RiVj2JsaGua
D6odDao90J1e73L87oH3sn3d5eN1wXpoqE0re9f5fv90YOYAqib1wtvrfpHwuAWP
JNFCiABvMrCNXMlozj1/PWjGeKV7r2Pd8SmZy+xUzY1vX3qpTeO1qEmmT7qqpcqw
RCGlisGSD+Rf2sED4kRDNOK0cuN/OaJqh/ZC80BDYBsZpRYSyYzS0dToXHq+zVFO
l9CSGPAFtkE+sN9Qa2cgjO2l
=5J8d
-----END PGP SIGNATURE-----

--=-7NhA1itbyMFsOO2Uwj5e--
