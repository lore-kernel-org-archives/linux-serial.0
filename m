Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3534B53F2
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788630292; cv=none; b=RO7zYLy7GEQkXqBbSOTVqh4bI9fIyvBGsT9T1/lrThKKaP4HPZ1x6k3W5GNHdBa4k7AZdx6juCwhKdwczWZqjJc8vO5A65zmoqNygmEOlOnmDmwAJMQ/H1IIQv1a3LANsT0rJT3yVfoliIp0ykh0lMiTptiDwKFiQUmZwcs9+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788630292; c=relaxed/simple;
	bh=SaLwmO+luWwbiiLzkb1B1Ad9MkWiYuGsCg2CNy2tBtE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U3VLyAQzEIh+GxMkG3IZPqkMdmSv28JDquNKK/wcCqvLyGCelBr6KE6uNy63UVCkGhEN30KCla0NYe1appFYmh3DdRLvCQ1xIexeuwwMg/87J8bXBggJku6w81PKWYvL3XN7SSHAV29PdbquFmYcuKYn4hCrlTL0h2PmlfJP4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=a1I0oamd; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="a1I0oamd"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 558B3240103
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 19:44:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788630288;
	bh=yBR8+5niRtrX5UqH9UPN0V91v64h25Y16qGA/opBUwY=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=a1I0oamd1/j+ZjhwfPzx2LX3C9q1hyc0IBFv/DhCT2DyY1Rx/O5pIxYxZqkx6JcHz
	 DV/8cHVOIbOWAVbwRgDQa4qT54KE6pNou9UhTk5SjzBrJeaqIvSkeGejNH5uhD+dCQ
	 OHvlapXB0JEZEhlRSUHfWiyHdaxtRw3IjQcYnHqai1Qe7oS73dQ5POGM0yhwLOc+GD
	 r2MEPcfo6bpXwQGyyABUqiRXR7TRoz/CEnXGufi3o74AexwLB96rIS7wRsupDdVpW9
	 dk6b1HNKDRu0PACH1Is3r/W9s/IGPHQ+09s58Bl+mdf6QceyRwTmV4t2DeNqZT5/s8
	 Rj5t7oQ4HUCpg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcghG17zQz6tw4;
	Sat,  5 Sep 2026 19:44:46 +0200 (CEST)
Message-ID: <807e4200759a58fb822db8e6a5a57f09e551ae73.camel@posteo.de>
Subject: Re: [PATCH v2 1/2] rust: serdev: Fix race condition on driver unbind
From: Markus Probst <markus.probst@posteo.de>
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
	 <boqun@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, Sashiko Bot
	 <sashiko-bot@kernel.org>
Date: Sat, 05 Sep 2026 17:44:47 +0000
In-Reply-To: <DL7G35VOSQ6H.V15LOQS4I2RJ@garyguo.net>
References: <20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de>
	 <20260905-rust_serdev_fix-v2-1-35dfcd06ef2e@posteo.de>
	 <DL7G35VOSQ6H.V15LOQS4I2RJ@garyguo.net>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-pZHKrurTBhyis2whvu8t"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-pZHKrurTBhyis2whvu8t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-09-05 at 15:16 +0100, Gary Guo wrote:
> On Sat Sep 5, 2026 at 2:30 PM BST, Markus Probst wrote:
> > On device unbind, the pointer to the driver data (`PrivateData`) will f=
irst
> > be set to NULL by `drvdata_obtain` and only after that the serdev devic=
e
> > will be closed by Drop. Thus there is a small window in which the serde=
v
> > device is still open, but the pointer to the driver data is NULL. There=
fore
> > it is possible that `receive_buf_callback` might try to access the `act=
ive`
> > mutex on a null pointer.
> >=20
> > Add function `drvdata_drop` that leaves the pointer to the driver data
> > valid until the Drop has completed. Use it in the post unbind callback.
> >=20
> > Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
> > Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3=
D@smtp.kernel.org/
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  rust/kernel/device.rs | 27 +++++++++++++++++++++++++++
> >  rust/kernel/driver.rs |  2 +-
> >  2 files changed, 28 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 2291d85b6849..3886cc713c28 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -219,6 +219,7 @@ pub fn set_drvdata<T>(&self, data: impl PinInit<T, =
Error>) -> Result {
> >      ///
> >      /// - The type `T` must match the type of the `ForeignOwnable` pre=
viously stored by
> >      ///   [`Device::set_drvdata`].
> > +    /// - Must only be called before the device is fully unbound.
> >      pub(crate) unsafe fn drvdata_obtain<T>(&self) -> Option<Pin<KBox<T=
>>> {
> >          // SAFETY: By the type invariants, `self.as_raw()` is a valid =
pointer to a `struct device`.
> >          let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) =
};
> > @@ -236,6 +237,32 @@ pub(crate) unsafe fn drvdata_obtain<T>(&self) -> O=
ption<Pin<KBox<T>>> {
> >          //   in `into_foreign()`.
> >          Some(unsafe { Pin::<KBox<T>>::from_foreign(ptr.cast()) })
> >      }
> > +
> > +    /// Drop the private data stored in this [`Device`].
> > +    ///
> > +    /// The pointer to the private data remains valid until the drop i=
s complete.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// - The type `T` must match the type of the `ForeignOwnable` pre=
viously stored by
> > +    ///   [`Device::set_drvdata`].
> > +    pub(crate) unsafe fn drvdata_drop<T>(&self) {
> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid =
pointer to a `struct device`.
> > +        let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) =
};
> > +
> > +        if ptr.is_null() {
> > +            return;
> > +        }
>=20
> How does this help the problem? While drop is running, other code should =
not
> attempt to obtain a reference to the data anymore. Otherwise this still h=
ave UB
> potential by accessing fields that are just destroyed (not to mention tha=
t Rust
> alias model also forbid it).
>=20
> I think the existing actually catches it better, because *if* NULL pointe=
r can
> be observed by callbacks, a synchronization is missing in the subsystem. =
The bus
> should first perform a synchronization to ensure callbacks are no longer =
fired,
> and then proceed to clean up resources.
The abstraction has been written, so the serdev device stays open until
the drivers private data has been dropped. Until then, the driver can
still have a reference to the device, which can access calls that are
only valid if open.

I don't think I am allowed to rewrite that logic in a rc period.

Thanks
- Markus Probst

>=20
> Best,
> Gary
>=20
> > +
> > +        // SAFETY:
> > +        // - If `ptr` is not NULL, it comes from a previous call to `i=
nto_foreign()`.
> > +        // - `dev_get_drvdata()` guarantees to return the same pointer=
 given to `dev_set_drvdata()`
> > +        //   in `into_foreign()`.
> > +        drop(unsafe { Pin::<KBox<T>>::from_foreign(ptr.cast()) });
> > +
> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid =
pointer to a `struct device`.
> > +        unsafe { bindings::dev_set_drvdata(self.as_raw(), core::ptr::n=
ull_mut()) };
> > +    }
> >  }
> > =20
> >  impl<Ctx: InternalBoundContext> Device<Ctx> {
> > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > index c9c74c4dde8f..83410141ef1c 100644
> > --- a/rust/kernel/driver.rs
> > +++ b/rust/kernel/driver.rs
> > @@ -204,7 +204,7 @@ extern "C" fn post_unbind_callback(dev: *mut bindin=
gs::device) {
> >          //
> >          // SAFETY: By the safety requirements of the `Driver` trait, `=
T::DriverData` is the
> >          // driver's bus device private data type.
> > -        drop(unsafe { dev.drvdata_obtain::<T::DriverData<'_>>() });
> > +        unsafe { dev.drvdata_drop::<T::DriverData<'_>>() };
> >      }
> > =20
> >      /// Attach generic `struct device_driver` callbacks.
>=20

--=-pZHKrurTBhyis2whvu8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqcVP8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSSYAP/jj0kHhzzq9C5jzFK72U
hsViRZcMOCSetYHIfX0Ww9eaLwG7shYasUgHTjEagku7V/LOty5rmWTHOzle9aa1
SdRVYzKQITVkK+qt4xcWPaMZ0rVaOtGE0U+cgYdMeDtJCKXD1+0hQFyeegvKiNxO
fmbz1rchWeRGQlXzfiBIszIb8nlbmi8PdK8AEpAYnLq6555hoDpymVRBuKr1lNSJ
3vTGBe7Ch3JUV7wUAeaKIbCu4AX+rC3nf0WqfFOUx8G3/tPDSLxCb/2oi8EfqT5g
36YsDG8AgAtMzOUT0yGAGxUDCUir1u9Gh32s0qkaPwAPJ/KQXn+BVfNbDx5AwPzO
pmCRxxkkCtyO2Kao4LTasYHZ7XYV3ysTnHKCNMmuSojOI4fnk+K6GJXapwKAgZJF
L7kBBfQcTqZjflNPPXRF9Sz6HwtPf/noTETO4TglUV3SMawYZ6gM2B5pjz5V2esy
1cF14nJSQ5bQPvDPCp5C1nCERcJipl45TdYMr4WcKR9aAcLmprx6JLZUdhUUzB62
Y5gJBUvfewDY95tnMydKOcV7TAemMQNQij1bOljjG933UrfNNdAmpJlN+7G8LaWs
DM+PYksTbNYDd1i5OAHba6WeJ0ZkypZMu2ezRGF404yfEVn2S6PqqL11XYHCJnTu
Rh6JrSHLSl34pXVXwtgubVZ3
=S6nE
-----END PGP SIGNATURE-----

--=-pZHKrurTBhyis2whvu8t--
