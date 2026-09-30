Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0484FD286
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773165; cv=none; b=ro4h/y4dbh8gTQOs3ItXgJDMGIYBUO5yXmTfjR2ErXdnQQ5PUXYrOI7i7GQ2HLMJN8FEBX2bQUXdoOssOVa9+6OYEGlfdUsH0NQzJgS3g3ksFWZh8+e0nC/yHmx5LsKvXK6+mmS00R3zFjPwn/BIq2hv4+aV7HKONzY+5nL0Btk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773165; c=relaxed/simple;
	bh=i64pUxi3zpBLXWgDIKclkUs6JYXYTZeIxw+txTfxd8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCvaH7EudG3PagDK4S/n+2ViyRUZJZqQG2hWKT5HX+PSOLLbPyCH/Ha5NOlURu4hO+PnKVl2HdgiyY+jWQ0AKJzLOE4l3StkX6zAw5iTeQ3UFi3tXcgtoDhvvrLa/1eu7WxaPXTxGeN7mPgeU65GomAEYszYei5U+GznlP1q0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=DcCD8oY/; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="DcCD8oY/"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C42AB240108
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 14:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790773155;
	bh=H9IdDr7cQKYmTEbOZjvHS66nCR53cZdlHM63EBaiPA4=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=DcCD8oY/JB+8yA+glPD9b48NMoxk+k8pEfgbS9NfCju2Ix5sW/Vh3pw3TDjox1Cu8
	 YK/3aGLIz89wMVB9PMzMR4Fxb8V0gI47GAeGyfQcs2ui1TwRsBYrVGked7RQdwgn1a
	 SfmRzdQbp0TRL0WMmAOo1vDe4lrSSeUswYDHyZG8soEONneT7PRtHw7M2pci6VMvF9
	 svdnyYesemk//ufqzrhuiYDe38i0KgWCJy6Q85wntwrmwRe3XPOSvt/5wdJ559Mqsn
	 Wa/LfEGqICBJ0gEnXHJK8WmVXqMdI2EcoUS2WUNmxpA97MmE/BoTQYeZSk5P089ph/
	 w0ChdEVHHEsJg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hvw9F0YMzz9rxP;
	Wed, 30 Sep 2026 14:59:12 +0200 (CEST)
Message-ID: <a8693eaa1f8eeb167ee334e7c35371832e43bb4f.camel@posteo.de>
Subject: Re: [PATCH v1] rust: serdev: use Delta<Jiffy> for timeouts
From: Markus Probst <markus.probst@posteo.de>
To: FUJITA Tomonori <tomo@flapping.org>, dakr@kernel.org, ojeda@kernel.org
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, daniel.almeida@collabora.com, 
	gary@garyguo.net, lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu, 
	work@onurozkan.dev, linux-serial@vger.kernel.org,
 rust-for-linux@vger.kernel.org,  FUJITA Tomonori <fujita.tomonori@gmail.com>
Date: Wed, 30 Sep 2026 12:59:15 +0000
In-Reply-To: <20260930041339.1551129-1-tomo@flapping.org>
References: <20260930041339.1551129-1-tomo@flapping.org>
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
	protocol="application/pgp-signature"; boundary="=-VB3d5wXyxomhPlKLLb4P"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-VB3d5wXyxomhPlKLLb4P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-30 at 13:13 +0900, FUJITA Tomonori wrote:
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>=20
> write_all() and wait_until_sent() take the timeout as a raw Jiffies,
> which is a c_ulong alias. The type does not show the unit.
>=20
> Take the timeout as Delta<Jiffy> instead. Clamp a negative timeout to
> 0, as the current code does for a value larger than isize::MAX.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/serdev.rs | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d..094503f059ff 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -20,7 +20,10 @@
>          aref::AlwaysRefCounted,
>          Mutex, //
>      },
> -    time::Jiffies,
> +    time::{
> +        Delta,
> +        Jiffy, //
> +    },
>      types::{
>          Opaque,
>          ScopeGuard, //
> @@ -481,22 +484,19 @@ pub fn set_parity(&self, parity: Parity) -> Result =
{
>      /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERE=
STARTSYS`] if interrupted
>      /// before any bytes were written. [`kernel::error::code::EINVAL`] i=
f `data.len() > i32::MAX`.
>      #[inline]
> -    pub fn write_all(&self, data: &[u8], timeout: Jiffies) -> Result<usi=
ze> {
> +    pub fn write_all(&self, data: &[u8], timeout: Delta<Jiffy>) -> Resul=
t<usize> {
>          if data.len() > i32::MAX as usize {
>              return Err(EINVAL);
>          }
> =20
> +        let timeout =3D isize::max(timeout.as_jiffies(), 0);
> +
>          // SAFETY:
>          // - `self.as_raw()` is guaranteed to be a pointer to a valid `s=
erdev_device`.
>          // - `data.as_ptr()` is guaranteed to be a valid array pointer w=
ith the size of
>          //   `data.len()`.
>          let ret =3D unsafe {
> -            bindings::serdev_device_write(
> -                self.as_raw(),
> -                data.as_ptr(),
> -                data.len(),
> -                isize::try_from(timeout).unwrap_or_default(),
> -            )
> +            bindings::serdev_device_write(self.as_raw(), data.as_ptr(), =
data.len(), timeout)
>          };
>          // CAST: negative return values are guaranteed to be between `-M=
AX_ERRNO` and `-1`,
>          // which always fit into a `i32`.
> @@ -547,14 +547,11 @@ pub fn write_flush(&self) {
>      ///
>      /// Use a timeout of 0 to wait indefinitely.
>      #[inline]
> -    pub fn wait_until_sent(&self, timeout: Jiffies) {
> +    pub fn wait_until_sent(&self, timeout: Delta<Jiffy>) {
> +        let timeout =3D isize::max(timeout.as_jiffies(), 0);
> +
>          // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a va=
lid `serdev_device`.
> -        unsafe {
> -            bindings::serdev_device_wait_until_sent(
> -                self.as_raw(),
> -                isize::try_from(timeout).unwrap_or_default(),
> -            )
> -        };
> +        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(), =
timeout) };
>      }
>  }
> =20
>=20
> base-commit: f1850e443b0e4f2429ddf42a8d5033ea54ae8a90

Both functions have "Use a timeout of 0 to wait indefinitely." inside
the rustdoc.

Make sure `Delta::ZERO` is also usable for `Delta<Jiffy>` and replace
the 0 in the rustdoc with "[`Delta::<Jiffy>::ZERO`]". You might also
remove the "timeout of" part, but I don't mind if it stays.

With that fixed,

Reviewed-By: Markus Probst <markus.probst@posteo.de>

Thanks
- Markus Probst






--=-VB3d5wXyxomhPlKLLb4P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmq9B5sbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSWMMQAKqx7J6ZWj66x+WSYBmi
gapUSP9vsuZUsNtZI0B/pLneT//LOWqJ43O5G7VywevICOiTKSEYFTZB46w0NIUu
cExjaxJy28pwmYOvwI+m7cL8bSkcGHtL33YBUhuLG8Pdijq1eLLQi8V8L5Oc0OPj
gDN5A6boR4LVPTJm5tsmGLnEVa2zFT7qPLQVQ9aum+MS64ykJRNef01I//1rY3jb
e4Ad1jjKQ4URK5mSAk787kfdss/E4ArjsSD7UlJgap6NGN/j4vdcVuQpv+gtkY8Z
/yIPJA/gB/BVm1gDNAs+mPEae+PELEOQ7PYop2oMHgQ3LQ5DXuCEc+GcvCGXB4cz
GrszGNSlnHO16f5Z6LvociUuRP2Q+p/cy2SEv0d/Q5NPfM2gOUQgYjhfEVNLJIUS
KbQUIcksb1BoRogf5DTyWHyH1xbOm3CJr3AScNpkpjyi33Z3VFhRD21N3o45njeH
OlGo7P39UNjWxZ/hZ7jx8/P3Ojr5Fi2lmNoZdMB+ANx57FKDngqS2bU71d2BI7mp
D3BObLJ7L83/pJeCmCpJUItCdKRp55btllycR3LQyE7dWImnauNP8UVjzJUQRs6U
iTzOslEmCXJQM+Ryz2QiNJFdVlkZniv8Z+NJaIuSiA0Tk78U+TVUZxDIKruyQ1LV
vUI03IKnTmcju4pIan+bN/6m
=ru7s
-----END PGP SIGNATURE-----

--=-VB3d5wXyxomhPlKLLb4P--
