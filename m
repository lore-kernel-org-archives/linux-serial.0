Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539F2BCF4C
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474856; cv=none; b=f6zOiUw0rWUymzE5oT8FGG6S1o681jiV+NI7pBh3IeHaO1sUGmzZWtAENr1K9/vtA4qXytV5qbOjSC7tYj6jihyB0SpBQA4pvAaAWVmKqC50cPqTmQ9OGw8Yqd7C3Bt6ui8aj5YiV8J+9yz+Gx15SfemQG40Ka0cmqiz9WGQaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474856; c=relaxed/simple;
	bh=T25BvcwQgp9xIF/ywH9sty8BOaJDRCkGcQKJHEgOJQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZQeCPgZ+g1U8batSGV02yFzt1OFae6x2UVV3viO3BcPrMANE9Gm600361UlZS/GMMgKKyUtzQZW1um6+EPKssdAWOfqif6GhOXsnYqreqOovJp3MoOwtT+0c34n8NTY+cIbAUsy+Xc43XNUumlx0OKPRSx6vtUANaZtQaVUPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ebPD6yT8; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ebPD6yT8"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4EC91240101
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 00:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788474851;
	bh=Di5kF6S0l8VOWHjG3nIbsxirTkFuc5tW9Z+rLRfx0Fg=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=ebPD6yT8+ZQvhYalq0UmxJeblpoJ6HM/+/i8EUvUYZlyOQ45JgBg3THO7lVyydmXY
	 Q/WEGTcjSsLhn4icdn65zg1D+UinTC35hey2LiVor0sFLRNFTmd94MxZZx6gDsFsEG
	 SNZSLPV0f7RJxtz+2m0mVSzzU+PbVt/ngcsKp+/7sRZUEd1ck69sLDRuPe6bzatVwG
	 CMbk2K5gaSQEhZugVs8bquRc1CwkSqg4bmKN10bZsPlck4CsnW0R7kjs1rpOFtdr4H
	 9CZ/SjmSdb1UCoXS8ZN9esZ3Wth2Q0traOoTZGZqnjgblkfjtkTP0OYD3y4eVK6efB
	 WuIqe5b7N7cSQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hbZC40shSz6tyt;
	Fri,  4 Sep 2026 00:34:08 +0200 (CEST)
Message-ID: <fe6a21fa8604bb35e32971b80cd75efb8ee3d202.camel@posteo.de>
Subject: Re: [PATCH] rust: serdev: Synchronize receive callback before
 calling unbind
From: Markus Probst <markus.probst@posteo.de>
To: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miguel Ojeda	 <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Eric Biggers	
 <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Lorenzo Stoakes	
 <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"	
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>
Cc: greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 22:34:10 +0000
In-Reply-To: <20260904-rust_serdev_ref_mut-v1-1-245db7eb09af@posteo.de>
References: <20260904-rust_serdev_ref_mut-v1-1-245db7eb09af@posteo.de>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-FS/3GLhe6q/gMLSfCvSg"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-FS/3GLhe6q/gMLSfCvSg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-09-03 at 22:03 +0000, Markus Probst wrote:
> The receive callback and unbind callback now have exclusive access to
> the drivers private data. Provide mutable references in callbacks to
> avoid the need for locks in the private data. Remove the Sync
> requirement.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
> This patch avoids the need for a SpinLock in the patch series
> https://lore.kernel.org/rust-for-linux/20260827-gb-uart-transport-v2-7-a0=
3bb1f5fbd1@beagleboard.org/
> .
> ---
>  rust/kernel/serdev.rs              | 51 ++++++++++++++++++++++----------=
------
>  samples/rust/rust_driver_serdev.rs |  2 +-
>  2 files changed, 31 insertions(+), 22 deletions(-)
>=20
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d..44f029ed93fd 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -106,7 +106,7 @@ pub struct PrivateData<'bound, T: Driver> {
>      /// Whether `receive_buf_callback` is allowed to call `Driver::recei=
ve`.
>      ///
>      /// If locked, the receive_buf_callback will be blocked on data rece=
ption.
> -    /// This is the case while the driver is being probed or while [`Pri=
vateData`] is being dropped.
> +    /// This is the case while the driver is being probed or removed.
>      /// This is necessary, because we need to open the serdev device bef=
ore the driver has been
>      /// probed in order to allow it to be configured, which allows `rece=
ive_buf_callback` to be
>      /// called. Thus we need to block data until probe completes and the=
 driver data becomes
> @@ -127,16 +127,6 @@ pub struct PrivateData<'bound, T: Driver> {
>  #[pinned_drop]
>  impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
>      fn drop(self: Pin<&mut Self>) {
> -        let mut active =3D self.active.lock();
> -        if *active {
> -            // SAFETY:
> -            // - We have exclusive access to `self.driver`.
> -            // - `self.driver` is guaranteed to be initialized.
> -            unsafe { (*self.driver.get()).assume_init_drop() };
> -            *active =3D false;
> -        }
> -        drop(active);
> -
>          // SAFETY: We have exclusive access to `self.open`.
>          if unsafe { *self.open.get() } {
>              // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointe=
r to a valid
> @@ -176,7 +166,20 @@ extern "C" fn probe_callback(sdev: *mut bindings::se=
rdev_device) -> kernel::ffi:
>              let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };
>              let private_data =3D ScopeGuard::new_with_data(private_data,=
 |_| {
>                  // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> -                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData=
<'_, T>>() });
> +                let private_data =3D unsafe {
> +                    sdev.as_ref()
> +                        .drvdata_obtain::<PrivateData<'_, T>>()
> +                        .unwrap_unchecked()
> +                };
> +
> +                let mut active =3D private_data.active.lock();
> +                if *active {
> +                    // SAFETY:
> +                    // - We have exclusive access to `private_data.drive=
r`.
> +                    // - `private_data.driver` is guaranteed to be initi=
alized.
> +                    unsafe { (*private_data.driver.get()).assume_init_dr=
op() };
> +                    *active =3D false;
> +                }
Ignore this hunk.

As Sashiko correctly noticed, this introduces dead code.

Thanks
- Markus Probst

>              });
>              let mut active =3D private_data.active.lock();
> =20
> @@ -222,15 +225,21 @@ extern "C" fn remove_callback(sdev: *mut bindings::=
serdev_device) {
>          // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
>          let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };
> =20
> -        // SAFETY: No one has exclusive access to `private_data.driver`.
> -        let data =3D unsafe { &*private_data.driver.get() };
> +        let mut active =3D private_data.active.lock();
> +
> +        // SAFETY: We have exclusive access to `private_data.driver`.
> +        let data =3D unsafe { &mut *private_data.driver.get() };
>          // SAFETY:
>          // - `private_data.driver` is pinned.
>          // - `remove_callback` is only ever called after a successful ca=
ll to `probe_callback`,
>          //   hence it's guaranteed that `private_data.driver` was initia=
lized.
> -        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_mut()) };
> =20
>          T::unbind(sdev, data_pinned);
> +
> +        // SAFETY: We already established that `data` is guaranteed to b=
e initialized.
> +        unsafe { data.assume_init_drop() };
> +        *active =3D false;
>      }
> =20
>      extern "C" fn receive_buf_callback(
> @@ -254,13 +263,13 @@ extern "C" fn receive_buf_callback(
>              return length;
>          }
> =20
> -        // SAFETY: No one has exclusive access to `private_data.driver`.
> -        let data =3D unsafe { &*private_data.driver.get() };
> +        // SAFETY: We have exclusive access to `private_data.driver`.
> +        let data =3D unsafe { &mut *private_data.driver.get() };
>          // SAFETY:
>          // - `private_data.driver` is pinned.
>          // - `receive_buf_callback` is only ever called after a successf=
ul call to `probe_callback`,
>          //   hence it's guaranteed that `private_data.driver` was initia=
lized.
> -        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_mut()) };
> =20
>          // SAFETY: `buf` is guaranteed to be non-null and has the size o=
f `length`.
>          let buf =3D unsafe { core::slice::from_raw_parts(buf, length) };
> @@ -365,7 +374,7 @@ pub trait Driver {
>      type IdInfo: 'static;
> =20
>      /// The type of the driver's bus device private data.
> -    type Data<'bound>: Send + Sync + 'bound;
> +    type Data<'bound>: Send + 'bound;
> =20
>      /// The table of OF device ids supported by the driver.
>      const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D None;
> @@ -391,7 +400,7 @@ fn probe<'bound>(
>      /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
>      ///
>      /// Otherwise, release operations for driver resources should be per=
formed in `Drop`.
> -    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<=
&Self::Data<'bound>>) {
> +    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<=
&mut Self::Data<'bound>>) {
>          let _ =3D (sdev, this);
>      }
> =20
> @@ -402,7 +411,7 @@ fn unbind<'bound>(sdev: &'bound Device<device::Core<'=
_>>, this: Pin<&Self::Data<
>      /// Returns the number of bytes accepted.
>      fn receive<'bound>(
>          sdev: &'bound Device<device::Bound>,
> -        this: Pin<&Self::Data<'bound>>,
> +        this: Pin<&mut Self::Data<'bound>>,
>          data: &[u8],
>      ) -> usize {
>          let _ =3D (sdev, this, data);
> diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_drive=
r_serdev.rs
> index 51b4898cd855..d00d547234c8 100644
> --- a/samples/rust/rust_driver_serdev.rs
> +++ b/samples/rust/rust_driver_serdev.rs
> @@ -63,7 +63,7 @@ fn probe<'bound>(
> =20
>      fn receive<'bound>(
>          sdev: &'bound serdev::Device<Bound>,
> -        _this: Pin<&Self>,
> +        _this: Pin<&mut Self>,
>          data: &[u8],
>      ) -> usize {
>          sdev.write(data).unwrap_or_default() as usize
>=20
> ---
> base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
> change-id: 20260903-rust_serdev_ref_mut-4d2285776ae1

--=-FS/3GLhe6q/gMLSfCvSg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqZ9d8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSYSgP/2UkgIMMzkvLESAYbDcV
70cc4YuTsftW708Z8oepiNqRp56i2o77Xwbg68aC3gS9glv0phbbJyg8hqDcj4dc
jVBMTO2PYg5SiVJJkeYnQydo4oPoPAkQRYfb8GSGyORX+EbOquo86okj3gsiA3+Y
ZK2XLF0rkKfVqhSuNWhxz/DXRPLyPdoGpxLnob55Mq59kR1GzHDHYxGz4NTpOXiH
dWFSmB2pwuAj1pzfloSKxHZQfiUtMfgb08g7r2nToZQpqCa8zJKd3VqXsfBYnh3u
nJ8Tsyrw+OJSF7KCYBfIT1lyW8qEg1+10QJtDxjUEdjeP6oeb+HezcWVFbbTSsGN
USSvfTcY/s7Mpj5Zk/0Bd79dRAVCmnlKLZYtdJt5uhfOXXYCxmwjDwKJOfNQu72l
53NRRlKzxlEY9nzim8uMR09Y5fLsKE5G7O59Dof/QfbHsMHRzuTMGlvnIc4XI8AY
FFUcmhU6TgzT19mabNC4kfR9kZw41NEIRpJFp6m0TgiDE3DuhurSxvMqi3Ae4kUG
IQWU1pYPnihFKkEsSlKpt4uuZwQ4pJnlrsCBsdKhVqw5z5InJ+AQyRCIVm74dqiK
5hWwTx9o8+hjPhJGaYHc9rkZ1pAtnRHMZB7CvPlu1AbIsXq4JAeS4jgJoGWxd6Tm
cRlDtvvdZmqKMnpcy/PKKOhy
=4wM2
-----END PGP SIGNATURE-----

--=-FS/3GLhe6q/gMLSfCvSg--
