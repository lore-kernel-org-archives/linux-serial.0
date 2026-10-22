Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671299;
	b=o0/Ty1H/sV1CzK9BniKv0FeTVRy1AG4c0Q3WpxYGkvp6eOtopsmd09is6wT2FCghSH6x
	 vClDgGRWgEA/IE7OUtS88g2sZrjb8Kl/cldLDu/sSEyec1f8SNRj+eZQVxeApjsJeKW23
	 iBHLuLgBL+1b6evC9M8knmYHkCVUiIP7+avM/L7s7Ni4R3sIyaI4zCZX5pquMrVXEjeYI
	 vhnwyNpdnOjFcBffc1Mulu+xoUchsxFbvtEw4xDzeboLsVTSkzKOO2x9Q4New/lDPCjaS
	 vqovMbDchiKdthCm8/SSJwaciJ+jwm8oFg3TQ33ZhHUuGkH7lzd4fSNO+EHrfpSe9cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671299;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=wFRuVw4Ng1K10XTymm8SnahC9MBBUnCc5kdSoMm+6AI=;
	b=nQIqJfD43RA24VCtuZx1/WHbGxmngr1mlH5sCrDH5bHpbapnKawgy+2tbxEXVJxaYZPb
	 kS1I4PMYUyQZPSzZsxqYVLUMqppH9nHbFe/HdYz7TtORrtOJOpbmUXRlC1C680YuWbZSQ
	 dnh+EZRicVd9Nl7GKd0BKrYuq0AufM0fVAVhK9WqVxLM5vOEnvPtv55xHx40D6ozYJGzk
	 8aZG3CM7m+jkXcnZlNEXQr0exB5AM5nmXguFHb+XZb7Ky/hPxnNhuveYnlhYnc1rYdSuJ
	 I883FcAL+/7FZTGW4JjXjWlMs+rX3YkWuvuEJykZxNtwdiPPvJxngrzJJKSfCIG04PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b="PGZ/lKkf";
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2B606A319
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8F2B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=PGZ/lKkf
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8E1CB240027
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 14:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792671290;
	bh=wFRuVw4Ng1K10XTymm8SnahC9MBBUnCc5kdSoMm+6AI=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=PGZ/lKkfeV+yXU4qoVLg03+1fGLNZz4otQyp4SNi6H7cbOeIEeGL1fkeVusJQZafi
	 A6UPuiZhY3pM/RgN/o6KZ+J0meNxWPb847zteBexcuzWv3q7C27SW3LXYL6RriiOg7
	 2KZ5koObsTDoTK5BVFdSX7QCD/TWaipXHs8h8Trw7YWx3ZBT/apWzen8kreTSBF/ar
	 +znGUxdG+FX5knvRc6AKkf4AGyyafujF5jahQ5j2VBMjpHiNs4zu6gKOqneyDdHhrs
	 C0G8YVKpKjdLMVE2tv5SQ+QkTZUMQCv2lLrtJ0NB/HQuiNVl7epNKYA7nYSbqAgmrX
	 cz76xCB/FpV+g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j9Q7s6JsLz6txm;
	Thu, 22 Oct 2026 14:14:49 +0200 (CEST)
Message-ID: <b645a10a615430fa43ff79091cfb9dd1df944695.camel@posteo.de>
Subject: Re: [PATCH v5 3/4] rust: serdev: Replace `active` mutex with
 receive pause
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
Date: Thu, 22 Oct 2026 12:14:50 +0000
In-Reply-To: <sashiko-outbox-181411@kernel.org>
References: 
	<20261022-rust_serdev_probe_refactor-v5-0-a27d862a415a@posteo.de>
	 <20261022-rust_serdev_probe_refactor-v5-3-a27d862a415a@posteo.de>
	 <sashiko-outbox-181411@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-oCjhZOCA51w+IqGmpzV8"
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


--=-oCjhZOCA51w+IqGmpzV8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-22 at 12:04 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] rust: serdev: mutable borrow of shared ref in remove_callback(=
)
> --
>=20
> commit 7873e32e25475629867563ba84c28fd279d7f25d
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> rust: serdev: Replace active mutex with receive pause
>=20
> This commit replaces the active mutex in the Rust serdev abstraction with
> serdev_device_pause_rx() and serdev_device_resume_rx() to fix race
> conditions during probe failure and driver unbind.
>=20
> > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> > index 17ca504b7f8d6..c16d6593a8d2d 100644
> > --- a/rust/kernel/serdev.rs
> > +++ b/rust/kernel/serdev.rs
> [ ... ]
> > @@ -231,6 +198,12 @@ extern "C" fn remove_callback(sdev: *mut bindings:=
:serdev_device) {
> >          let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_in=
it_ref()) };
> > =20
> >          T::unbind(sdev, data_pinned);
> > +
> > +        // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer=
 to `serdev_device`.
> > +        unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
> > +
> > +        // SAFETY: We already established that `data` is guaranteed to=
 be initialized.
> > +        unsafe { data.assume_init_drop() };
> >      }
>=20
> [Severity: Medium]
> Does Adapter::remove_callback() in rust/kernel/serdev.rs fail to compile
> when building this commit with CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS=3D=
y?
>=20
> Earlier in Adapter::remove_callback(), data is bound as an immutable
> shared reference of type &MaybeUninit<T::Data<'_>>:
>=20
>     let data =3D unsafe { &*private_data.driver.get() };
>     let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init_ref(=
)) };
>=20
>     T::unbind(sdev, data_pinned);
>=20
> Because MaybeUninit::assume_init_drop(&mut self) requires a mutable
> reference, calling data.assume_init_drop() fails with rustc error E0596
> (cannot borrow *data as mutable, as it is behind a & reference).
>=20
> Since receive_buf_callback() can still run concurrently during T::unbind(=
)
> and create a shared reference to *private_data.driver.get() before
> serdev_device_pause_rx() is called, data cannot be changed to a mutable
> reference at the start of remove_callback().
>=20
> Although a later commit in this series ("rust: serdev: Simplify callbacks=
")
> refactors PrivateData to store T::Data directly and removes the
> assume_init_drop() call, should this commit dereference the UnsafeCell
> pointer directly after serdev_device_pause_rx() establishes exclusive
> access:
>=20
>     unsafe { (*private_data.driver.get()).assume_init_drop() };
>=20
> so that git bisection and standalone backporting remain unbroken?
Thats true.

```
// SAFETY: We have exclusive access to `private_data.driver`.
let data =3D unsafe { &mut *private_data.driver.get() };
```
needs to be added after `serdev_device_pause_rx`.

Thanks
- Markus Probst


>=20
> [ ... ]

--=-oCjhZOCA51w+IqGmpzV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrZ/jkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSKTsP/j6x/sPJ/DlS+DXMpdhN
n9uuB25r6bXrHTaRuWBVr2lgwDPRf1P5zeIKjZmMXEZSv0l4PFLhsiVexAcgqcQV
zMrHAX4JcceX8+XyH5oM5C8lKzUnDKJ6eWMij5gE0gxsmtNimJ0Zyj/82aVqy2cy
m3r6vlX1znUoNF9YMuNoy5vI28PDk/5lvQ1nm8fTCp4x/CtU23L3DluooiylMXeq
DW5/Xf4LzY7RGbolFwyfZ+tXPj0jaWYQet2CuIo5Y1j4nQSvD6rujm1yJeG/m1TK
UqOOFgj4lEuS9A3YGFhBsjHrUZOtbvzv3k/B4M51TVvEE+XPvyvKbnbKJJ7AyEvM
ZkVPaexOeLa+5u0gkGdIypZfLJ44BhnZEWlVeAi8I6QvyxV04eudq+96erfwM+pF
t1uFTjfRgXhFrKQkSS1/HAQjOaUIRZ+lU09fERkkMT5XdpcgoDqqLxb6+qbPqQ2L
a5rhmOvIwfNM1ReZ75AQUagJSUQrI3zJkKH7BVlo9wqxkQi9gpvJ/GZdS0xgIdlr
j+FV3rq8o02hnwm14fSOE3cznXbHcbwUFielh1iSzXIuIxqmIM/8UIvn8wTnVytt
WTLdcdZWLHDCrOrCCKl8vfBFPXzxIZNSxyJd1HUt8AV6prJCyAS7WMqYA3azmCEQ
egy9Y1DfG6rvBfQCcRBBabOb
=ptDe
-----END PGP SIGNATURE-----

--=-oCjhZOCA51w+IqGmpzV8--
