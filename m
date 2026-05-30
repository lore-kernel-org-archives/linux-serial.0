Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D193BA24F
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780148255; cv=none; b=kuLubGnl3UveJbzy9N8ASAYP4EgRv+JCahg3YhKACXQUR+YQFdkZXh3jAS8gfZAGeZWa8buTUvqqE/ZAq+wPNTInk0wloDChpLJ0F95hCjDPAXphgyufC3nNiV3ELWGiBhNWPBJgHEU7N1fldv6dYQo4abi8Q4x+9O8GphkJIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780148255; c=relaxed/simple;
	bh=UQyQwhm0sitWzlG+jw1sCm7qxZToPW/u9crXx99HCL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UD7Lz+5c8MyCBrnIFm40B2eA7N2b8QSOn9mcY/GfWgq3eHD0VVPCyvGEM8c9frCS3Z2SydbKBEW/QNQdQIorXKGdvORUwsBzZqaAU1etJnA5MPnzCjxFycJ5SfTWNCCD/KX3euHWjmq/Pv65JmnigKBRhapg7YAe/Ji95qRAQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=m8gxBl+B; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="m8gxBl+B"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1887D240028
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 15:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780148251; bh=SXr32rjKJbNyYUQ0Dql4qeVjTj4pPxg4GyHhz4KKolU=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=m8gxBl+BWE0qHH83tACyQYvfQvrOaS7nzUtcq/ltl1iTS6nJytvObcvQdzS5MAxfy
	 ye3OOKI/Jx5m4sMiK0yOQjPdq9s5E65o+RH3s2P9XpWUCfJKtztB1ROsq8AQTan1zW
	 2PDTzlg+rzsFjAiCcBPu8UH9yd+tJaKRzAWL04oZdH+B2zKyFvJJKllHEMGQZMMvV3
	 X6kG9moabZ02CSYLWzWOTJ2/bwHTVyvRpiuhjIq0hlEeKOSmwvjjZ61+YE5jq3Gkqd
	 5Vyw5z6RUruL6Frq10YDKVqD3/BxK0MXqS1T68YXfVfHG79nFKQv9AM0nLDILV4Bkz
	 EmM2IAnTJylXw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gSLr75bylz9rxF;
	Sat, 30 May 2026 15:37:27 +0200 (CEST)
Message-ID: <4638946fc49a38797b716ea173c93327eb751479.camel@posteo.de>
Subject: Re: [PATCH v8 3/5] rust: add basic serial device bus abstractions
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
Date: Sat, 30 May 2026 13:37:30 +0000
In-Reply-To: <DIW1B4FUIXO7.28GSUA0CEA4EV@kernel.org>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
	 <20260530-rust_serdev-v8-3-2a95f1da22a7@posteo.de>
	 <DIW1B4FUIXO7.28GSUA0CEA4EV@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=mQINBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93
 qReNLkOWguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVA
 m76Ww+/pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt
 9k5JARhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbm
 fAjaoT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwT
 jRQxBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1
 J+FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN
 6OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
 8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJCX
 CeMe4BO4iaxUQARAQABtCdNYXJrdXMgUHJvYnN0IDxtYXJrdXMucHJvYnN0QHBvc3Rlby5kZT6JAl
 QEEwEIAD4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQSCdBjE9KxY53IwxHM0dh/4561
 D0gUCaIZ9HQIZAQAKCRA0dh/4561D0pKmD/92zsCfbD+SrvBpNWtbit7J9wFBNr9qSFFm2n/65qen
 NNWKDrCzDsjRbALMHSO8nigMWzjofbVjj8Nf7SDcdapRjrMCnidS0DuW3pZBo6W0sZqV/fLx+AzgQ
 7PAr6jtBbUoKW/GCGHLLtb6Hv+zjL17KGVO0DdQeoHEXMa48mJh8rS7VlUzVtpbxsWbb1wRZJTD88
 ALDOLTWGqMbCTFDKFfGcqBLdUT13vx706Q29wrDiogmQhLGYKc6fQzpHhCLNhHTl8ZVLuKVY3wTT+
 f9TzW1BDzFTAe3ZXsKhrzF+ud7vr6ff9p1Zl+Nujz94EDYHi/5Yrtp//+N/ZjDGDmqZOEA86/Gybu
 6XE/v4S85ls0cAe37WTqsMCJjVRMP52r7Y1AuOONJDe3sIsDge++XFhwfGPbZwBnwd4gEVcdrKhnO
 ntuP9TvBMFWeTvtLqlWJUt7n8f/ELCcGoO5acai1iZ59GC81GLl2izObOLNjyv3G6hia/w50Mw9MU
 dAdZQ2MxM6k+x4L5XeysdcR/2AydVLtu2LGFOrKyEe0M9XmlE6OvziWXvVVwomvTN3LaNUmaINhr7
 pHTFwDiZCSWKnwnvD2+jA1trKq1xKUQY1uGW9XgSj98pKyixHWoeEpydr+alSTB43c3m0351/9rYT
 TTi4KSk73wtapPKtaoIR3rOFHLQXbWFya3VzLnByb2JzdEBwb3N0ZW8uZGWJAlEEEwEIADsWIQSCd
 BjE9KxY53IwxHM0dh/4561D0gUCaIO9eAIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCR
 A0dh/4561D0oHZEACEmk5Ng9+OXoVxJJ+c9slBI2lYxyBO84qkWjoJ/0GpwoHk1IpyL+i+kF1Bb7y
 Hx9Tiz8ENYX7xIPTZzS8hXs1ksuo76FQUyD6onA/69xZIrYZ0NSA5HUo62qzzMSZL7od5e12R6OPR
 lR0PIuc4ecOGCEq3BLRPfZSYrL54tiase8HubXsvb6EBQ8jPI8ZUlr96ZqFEwrQZF/3ihyV6LILLk
 geExgwlTzo5Wv3piOXPTITBuzuFhBJqEnT25q2j8OumGQ+ri8oVeAzx24g1kc11pwpR0sowfa5MvZ
 WrrBcaIL7uJfR/ig7FyGnTQ1nS3btf3p0v8A3fc4eUu/K2No3l2huJp3+LHhCmpmeykOhSB63Mj3s
 3Q87LD0HE0HBkTEMwp+sD97ZRpO67H5shzJRanUaDTb/mREfzpJmRT1uuec0X2zItL7a6itgMJvYI
 KG29aJLX3fTzzVzFGPgzVZYEdhu4y53p0qEGrrC1JtKR6DRPE1hb/OdWOkjmJ75+PPLD9U5IuRd6y
 sHJWsEBR1F0wkMPkEofWsvMYJzWXx/rvTWO8N4D6HigTgBXAXNgbc3IHpHlkvKoBJptv6DRVRtIrz
 0G0cfBY0Sm7he4N2IYDWWdGnPBZ3rlLSdj5EiBU2YWgIgtLrb8ZNJ3ZlhYluGnBJDGRqy2jC9s1jY
 66sLA9rQZMHhJTzMyIDwweGlvMzJAcG9zdGVvLmV1PokCbQQTAQgAVxYhBIJ0GMT0rFjncjDEczR2
 H/jnrUPSBQJpa71VGxSAAAAAAAQADm1hbnUyLDIuNSsxLjExLDIsMgIbAwULCQgHAgIiAgYVCgkIC
 wIEFgIDAQIeBwIXgAAKCRA0dh/4561D0gKJD/9uOQKYlsDoQX65Gd0LiMT0C+5vXgr3VI0PHDOwcv
 51fJ3A1vNyPZRFPGrz8+mDEXUQOF/INfnz5Tu1QHwf+iYcWcTGAN/FHgVR6ET6VBNU2hJaKhu+Ggo
 kjYyJTOvyX+3yNRUfSny0GjTjIPuPTErjqmHF+BtjXslpgwqnNMznf3lRIuUjRORupos6p3k1DndE
 5vzUTmXSvMyXyOD2KhBl/kL76k0bHYyAQytZPag12pltrtFbA/r2phDGN2si8PooDT99bSTJjaM45
 MTAAHbHKJfvgfK41bNFD5mMtpWpL195XRtS0Nrxdg3PaYBxN5gtTG0RyZfpYRlkdEhm+jj/8RxuSG
 i/qdhRdbiI7K2IELWeQVHSNDi9JabR/UzlR4NSnhfAjRIVlRM+eFbUl8XwxwVrAkojF5IraH2qRvg
 VCmuFsHUW07FUlrDrzpjXsD73cKppoFGDCdDR0BHJepXbFLS9+AqkT+guRJlnCTg2p+TQtnbwPgKp
 Vj98JixovCl99zRYTsL2bRNU5+q8iET65VMJ1ydyNanvLd5vI/NqDkXhlXLsGmdaDTtu4R21PkToX
 dQNGrZ91M9nlIBKw8Y7c7xZ4098qX2b8JX/CxD+gC1r4C8vuA3GkhFLx+KlkON7LyiJPkrePp6Qky
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-mbJrtKM2BegUzHyWsn7m"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-mbJrtKM2BegUzHyWsn7m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 15:10 +0200, Danilo Krummrich wrote:
> On Sat May 30, 2026 at 3:13 AM CEST, Markus Probst via B4 Relay wrote:
> > +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -=
> kernel::ffi::c_int {
> > +        // SAFETY: The serial device bus only ever calls the probe cal=
lback with a valid pointer to
> > +        // a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `probe_callb=
ack()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l<'_>>>() };
> > +        let info =3D <Self as driver::Adapter>::id_info(sdev.as_ref())=
;
> > +
> > +        from_result(|| {
> > +            let private_data =3D devres::register(
> > +                sdev.as_ref(),
> > +                try_pin_init!(PrivateData {
> > +                    probe_complete <- Completion::new(),
> > +                    error: false.into(),
> > +                }),
> > +                GFP_KERNEL,
> > +            )?;
> > +
> > +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid poi=
nter to `serdev_device`.
> > +            unsafe {
> > +                (*sdev.as_raw()).rust_private_data =3D
> > +                    (&raw const *private_data).cast::<c_void>().cast_m=
ut()
> > +            };
> > +
> > +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid poi=
nter to `serdev_device`.
> > +            unsafe { bindings::serdev_device_set_client_ops(sdev.as_ra=
w(), Self::OPS) };
> > +
> > +            // SAFETY: The serial device bus only ever calls the probe=
 callback with a valid pointer
> > +            // to a `serdev_device`.
> > +            to_result(unsafe {
> > +                bindings::devm_serdev_device_open(sdev.as_ref().as_raw=
(), sdev.as_raw())
> > +            })?;
>=20
> The bus device private data drops before devres callbacks run, thus you c=
an't
> use the devm helper here. I suggest to use serdev_device_open() and call
> serdev_device_close() from remove_callback() instead.
>=20
> You may also want to consider whether you potentially want T::unbind() to=
 allow
> to have concurrent transmits in flight regardless. IOW, you may want to c=
all
> serdev_device_close() before T::unbind() anyway.
`serdev::Device<Core>` will be passed as argument to unbind, i.e.
set_baudrate, set_flow_control etc. calls are possible. If we close the
serdev device before unbind, calling those would result in a null
pointer dereference. Maybe a driver even wants to send a message here,
so it should stay open.

If I think about it, I can't even close it inside remove_callback after
`T::unbind`. With the driver lifetimes, the driver could store the
`serdev::Device<Bound>` pointer in its DriverData and could still make
calls to the device.

Any suggestions?

>=20
> > +
> > +            let data =3D T::probe(sdev, info);
> > +            let result =3D sdev.as_ref().set_drvdata(data);
> > +
> > +            // SAFETY: We have exclusive access to `private_data.error=
`.
> > +            unsafe { *private_data.error.get() =3D result.is_err() };
> > +
> > +            private_data.probe_complete.complete_all();
> > +
> > +            result.map(|()| 0)
> > +        })
> > +    }
> > +
> > +    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) =
{
> > +        // SAFETY: The serial device bus only ever calls the remove ca=
llback with a valid pointer
> > +        // to a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `remove_call=
back()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l<'_>>>() };
> > +
> > +        // SAFETY: `remove_callback` is only ever called after a succe=
ssful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<T::Data<'_>>>`.
> > +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<T::Data<'=
_>>() };
> > +
> > +        T::unbind(sdev, data);
> > +    }
> > +
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
> CoreInternal dereferences to Core, which is technically unsound within th=
is
> callback.
>=20
> I think you want CoreInternal for drvdata_borrow(), so we should add a
> BoundInternal type state for this; I will send a patch for this.
>=20
> With this and the above fixed,
>=20
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>=20
> from the driver-core side of things.
>=20
> > +        // SAFETY:
> > +        // - The serial device bus only ever calls the receive buf cal=
lback with a valid pointer to
> > +        //   a `struct serdev_device`.
> > +        // - `receive_buf_callback` is only ever called after a succes=
sful call to
> > +        //   `probe_callback`, hence it's guaranteed that `sdev.privat=
e_data` is a pointer
> > +        //   to a valid `PrivateData`.
> > +        let private_data =3D unsafe { &*(*sdev.as_raw()).rust_private_=
data.cast::<PrivateData>() };
> > +
> > +        private_data.probe_complete.wait_for_completion();
> > +
> > +        // SAFETY: No one has exclusive access to `private_data.error`=
.
> > +        if unsafe { *private_data.error.get() } {
> > +            return length;
> > +        }
> > +
> > +        // SAFETY: `receive_buf_callback` is only ever called after a =
successful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<T::Data<'_>>>`.
> > +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<T::Data<'=
_>>() };
> > +
> > +        // SAFETY: `buf` is guaranteed to be non-null and has the size=
 of `length`.
> > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) =
};
> > +
> > +        T::receive(sdev, data, buf)
> > +    }
> > +}

Thanks
- Markus Probst


--=-mbJrtKM2BegUzHyWsn7m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmoa6BYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS+LUP/0Jxc80EuLpjY2G+uAqc
WpowXEcHOtta/A+Qn721xtuJ+vxEGhbtXU9YmjzX4op7muKMFC8puoYIVZLKpfxq
ndGzvOeZaFJacPKbKREvYpY26uMxxF1+TZ51MzYH9/Hetc2eKTBDWis7vBjPvaXu
uNyb5CbX6BJu0N+JFYv6u4jxb5frq/0RDVVqeutapi/srSX/p+S7R2WMdO8y9flr
H7Vt3+YZUcWKBAZpY6wTQz2XTU5lGMNEcj5HM7g4/ghcBkW8LJUVGXKI1miZPVGg
uFzFtfIOZnTd99XtpAmep7SoJTN97KqRG2AYSuFDLuBjDXPPsz+Ubx+W7Q3Piu5f
agzQzS1nBNNNEFOex0TyER+eVS728c/3LVAKbPJWKG4FiBs6eeDaoerJVdmLx/DR
4+ifHvfCWPa5rDwfHfINeYzqGDTyGKUgCcKCTESv1gTlAl/QmSOR7MEc5u4b5x+9
7ebt8+ueewqPTWu6+oYu68mmzysJX63wwgNDjhPKUxxwMfhcTyFciVSsJCffYE8X
RYrwlKK+0TPhzW1qKYFqVkNlFfaFu4JA13KcwIpfCt/sVdaYPNT0APCbfktyPN7c
yHqb1e6AiPWc+C+tHqz0cFVeN6I3FL8LMENOJ0Bq+Tog6282EFgiDZpz7dDDmizi
X9ylbe+R2PRnxVTjAv0ITPBS
=Bo67
-----END PGP SIGNATURE-----

--=-mbJrtKM2BegUzHyWsn7m--
