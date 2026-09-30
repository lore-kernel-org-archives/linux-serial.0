Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634584E36E1
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777261; cv=none; b=hHDLuFeVVKsNZF1fonZrY8CnqMCz3ydD3cQe1yXmu5Opoj888S7tVr7p03svzM7pQarXt1AgEQ9AiDnZbqmCepQ4Yg6PHy2K3E+kg7sL+0hhLw66lbM1a9beBLh2TeXzGkLybw6ZusR8ZAY4hWXDDUCXYlV0pK8N+QRnOZDEaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777261; c=relaxed/simple;
	bh=nJUmfPhvoaVq+tzus3KQrCsS5a68ZjcnCCB9ptoHFnk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WkQeRN6RFFkJluRbpvUyTj72Lupxhnj9McfYAQRwqJe+C+Kjw5QkOt3rUyNJMban9hUC6D/2tDQAsuXeL81w5p5JQy7wWbgcQaEW4F6Dpa7yM6JBm7MPB/RZbQXEQ4dcLjO5DsvJ488kXDSIAaQw+YT1lbdVSZWI2vQiFGx9lSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=CmyIu8ze; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="CmyIu8ze"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 7BAB2240104
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 16:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790777242;
	bh=IfIIsX3gg1lv/2HO6YvGlmYAAGS6W0Wyv8g6+LwIreM=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=CmyIu8zeKg4PJfOILEwm2TD8qOfYddBl6VZ/dsg2ccZcGJtF3o5aKkFuONDbPyTZF
	 gBUTzyIlR2AaymPB+9wYLt3bsJOO2PIZ/qneTYMwcMyvEuKuj/tU7KGuCQ6fk2X+U6
	 EhDtvPG+4wZ+4K3zT6vHPxWnABrB+pJTwXxLVtl3tOseJcZXdJG822N3sBA5+rCkfa
	 oFw9FTaDZ7zlQXp3OYBhs1F3q0OfisBcERp3NbfLFfLaw3ZFEc1SLDLI56RaSahBBS
	 l0/0k/Jg+r9gyOsVTU7e1o5G8vSejUHFmShrmaKIM0m/lCYlAFWIWuOjvgHz8Ou0FA
	 33Pr3On+G6bww==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hvxgr1L2Sz9rxN;
	Wed, 30 Sep 2026 16:07:20 +0200 (CEST)
Message-ID: <d2437243001e55ef6a845c88cfb19dc162a0c1b6.camel@posteo.de>
Subject: Re: [PATCH v1] rust: serdev: use Delta<Jiffy> for timeouts
From: Markus Probst <markus.probst@posteo.de>
To: Gary Guo <gary@garyguo.net>, FUJITA Tomonori <tomo@flapping.org>, 
	dakr@kernel.org, ojeda@kernel.org
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, daniel.almeida@collabora.com, 
	lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu,
 work@onurozkan.dev, 	linux-serial@vger.kernel.org,
 rust-for-linux@vger.kernel.org, FUJITA Tomonori	 <fujita.tomonori@gmail.com>
Date: Wed, 30 Sep 2026 14:07:21 +0000
In-Reply-To: <DLSP8RHJMYFZ.3II53ESHY15IL@garyguo.net>
References: <20260930041339.1551129-1-tomo@flapping.org>
	 <a8693eaa1f8eeb167ee334e7c35371832e43bb4f.camel@posteo.de>
	 <DLSP8RHJMYFZ.3II53ESHY15IL@garyguo.net>
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
	protocol="application/pgp-signature"; boundary="=-FnDL+AGGzBAQZyfZ98yo"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-FnDL+AGGzBAQZyfZ98yo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-30 at 14:52 +0100, Gary Guo wrote:
> On Wed Sep 30, 2026 at 1:59 PM BST, Markus Probst wrote:
> > On Wed, 2026-09-30 at 13:13 +0900, FUJITA Tomonori wrote:
> > > From: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > >=20
> > > write_all() and wait_until_sent() take the timeout as a raw Jiffies,
> > > which is a c_ulong alias. The type does not show the unit.
> > >=20
> > > Take the timeout as Delta<Jiffy> instead. Clamp a negative timeout to
> > > 0, as the current code does for a value larger than isize::MAX.
> > >=20
> > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > ---
> > >  rust/kernel/serdev.rs | 27 ++++++++++++---------------
> > >  1 file changed, 12 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> > > index 17ca504b7f8d..094503f059ff 100644
> > > --- a/rust/kernel/serdev.rs
> > > +++ b/rust/kernel/serdev.rs
> > > @@ -20,7 +20,10 @@
> > >          aref::AlwaysRefCounted,
> > >          Mutex, //
> > >      },
> > > -    time::Jiffies,
> > > +    time::{
> > > +        Delta,
> > > +        Jiffy, //
> > > +    },
> > >      types::{
> > >          Opaque,
> > >          ScopeGuard, //
> > > @@ -481,22 +484,19 @@ pub fn set_parity(&self, parity: Parity) -> Res=
ult {
> > >      /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code:=
:ERESTARTSYS`] if interrupted
> > >      /// before any bytes were written. [`kernel::error::code::EINVAL=
`] if `data.len() > i32::MAX`.
> > >      #[inline]
> > > -    pub fn write_all(&self, data: &[u8], timeout: Jiffies) -> Result=
<usize> {
> > > +    pub fn write_all(&self, data: &[u8], timeout: Delta<Jiffy>) -> R=
esult<usize> {
> > >          if data.len() > i32::MAX as usize {
> > >              return Err(EINVAL);
> > >          }
> > > =20
> > > +        let timeout =3D isize::max(timeout.as_jiffies(), 0);
> > > +
> > >          // SAFETY:
> > >          // - `self.as_raw()` is guaranteed to be a pointer to a vali=
d `serdev_device`.
> > >          // - `data.as_ptr()` is guaranteed to be a valid array point=
er with the size of
> > >          //   `data.len()`.
> > >          let ret =3D unsafe {
> > > -            bindings::serdev_device_write(
> > > -                self.as_raw(),
> > > -                data.as_ptr(),
> > > -                data.len(),
> > > -                isize::try_from(timeout).unwrap_or_default(),
> > > -            )
> > > +            bindings::serdev_device_write(self.as_raw(), data.as_ptr=
(), data.len(), timeout)
> > >          };
> > >          // CAST: negative return values are guaranteed to be between=
 `-MAX_ERRNO` and `-1`,
> > >          // which always fit into a `i32`.
> > > @@ -547,14 +547,11 @@ pub fn write_flush(&self) {
> > >      ///
> > >      /// Use a timeout of 0 to wait indefinitely.
> > >      #[inline]
> > > -    pub fn wait_until_sent(&self, timeout: Jiffies) {
> > > +    pub fn wait_until_sent(&self, timeout: Delta<Jiffy>) {
> > > +        let timeout =3D isize::max(timeout.as_jiffies(), 0);
> > > +
> > >          // SAFETY: `self.as_raw()` is guaranteed to be a pointer to =
a valid `serdev_device`.
> > > -        unsafe {
> > > -            bindings::serdev_device_wait_until_sent(
> > > -                self.as_raw(),
> > > -                isize::try_from(timeout).unwrap_or_default(),
> > > -            )
> > > -        };
> > > +        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw=
(), timeout) };
> > >      }
> > >  }
> > > =20
> > >=20
> > > base-commit: f1850e443b0e4f2429ddf42a8d5033ea54ae8a90
> >=20
> > Both functions have "Use a timeout of 0 to wait indefinitely." inside
> > the rustdoc.
> >=20
> > Make sure `Delta::ZERO` is also usable for `Delta<Jiffy>` and replace
> > the 0 in the rustdoc with "[`Delta::<Jiffy>::ZERO`]". You might also
> > remove the "timeout of" part, but I don't mind if it stays.
>=20
> I think the API should ideally use `Option<Delta<Jiffies>>` for this case=
, and
> use `None` to represent indefinite wait.
Yes, this would make it more explicit.
>=20
> We might need to round 0 jiffies to 1 to avoid C API change. But ideally =
the C
> API should be using MAX_JIFFY_OFFSET to mean indefinite..
In both cases MAX_SCHEDULE_TIMEOUT is also accepted (even if not
documented).

At least both pass through such call:

if (timeout =3D=3D 0)
        timeout =3D MAX_SCHEDULE_TIMEOUT;

Thanks
- Markus Probst

>=20
> Best,
> Gary


--=-FnDL+AGGzBAQZyfZ98yo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmq9F5AbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSaX8P/2x7DyQjhVEYVRTwPDUJ
vWubThxzkv9H7WiodY8kUZAYEBecUB28gXazUXbJ5xMjQ9MZeq3aJKTiml8vPykT
YjWSG3Pe3BMsxX5KKwmdFvt2NIg/DZE8AUCrd5OONH+PYbU8xCOQLTjHXZ141mog
lpAY1PO0NmfNLRTJzUx0dN6TcL4Ui/cm3C7C/4THi+SAaCRgTol57Tz3Hf6LGaXu
mErB+k7cEiIF2Q3/N5oD8+/eqJxT23jJ87wKG/yp4eg1PvAUB9sY27KAAVqpJjmd
QEKKIPN6owBzcYclDo5zkTiO5ZqZhbf1VkFFNr7FhCkIH0KBcLtHWDwohhfC3+O+
5GoLASVUR/onUTBNfiLL4qzNdJfKoC7oJj8clwoJibJ3v8Dx7uq9pNy3G5NQxXVq
NrAx3DS9EfPnxdiF8D2gTvqXiv7ttnl9aWZdVpnS0UhhQ0VGmCuYQ/u7cnEjb0j7
+eym2mydzwnVPJsUtglz18OANzbdu957/pxR5p/f6NXRJlCexrnP5yg/qBWxgjuw
kJh0M1hm9fl0zInCbJGkU9Gz6Edz3r/SiR/KM35fdf+MOKYy0Gy8Anc65IWHaSIL
rKqL5PL6hq6luPD5BCzpTZF30/rdOidbNkLNBiEq7lVRuFozv8+yOg7VLXHrdUER
akmTMSxJHNhrbfOMFOoa3zss
=Swrs
-----END PGP SIGNATURE-----

--=-FnDL+AGGzBAQZyfZ98yo--
