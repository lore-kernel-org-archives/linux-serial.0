Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B992874E6
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616045; cv=none; b=j5Gho/E8XWGR3SbB9jfgVMXC6wvhxIkFv6ugFvCN02/1UULMUCDerECTRhPQa8IOVv8BFZ7hZVFdG20EoBXQvpJR8o+pzS68vQm8BOrWtQWvMzRJzXRUbnvF+ZIcmosrGG/nNqPMsSf1mUPWveECk+ZegtKTK4HZKxtyTRM/Yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616045; c=relaxed/simple;
	bh=ZPuLICDZmdsDvmCRcVE9jq/kKd6RA2BedOnB1H7Fj6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OoLpHJbLKWWYq2hRZ/envUv1CoAAisi+DMBHBIMoiUF1jzfEnK7JyXzfj1lxgf6SyJxvawsGLFhx+D9RUhF/Hci14FBBW3rcRHaqSzbx6Xg+KbmGN6azjqvkC1No277NIitGUOrxoQlsLuqGefUxH3d0iwaXZ5Eve3lq28LM7PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=SCM8/co3; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="SCM8/co3"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 036B7240103
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 15:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788616041;
	bh=t9DbPY0CjN+dZVThR0j+X9ckPM0xaD48om4RgamGsc8=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=SCM8/co3l8x06IKibXNZM6o8lkxgbnwTDPk/O0Hz8r6TYH4eHID0iDfNXu2R8lCx5
	 17i8YqEkK5We3F/fLg96ecewp4D91x9p8qu3U2UYgqhXkYJpddDAnd59x/MIoB5NLu
	 Qy2+EXi4aY0Pme0OqU/0OR+VZ3/w2POIqR8Iiu1Ycjh19dSPXhEfJ5svqvoSJJvivg
	 U0sl64A5GmPEwvKh6uQ0G56LV4A399qoUSMVFYih75jWTfV8enbwMl5z74Gpia4MHe
	 Bvi7/NaYqQ0YvKv6ZhczjMyHBKgyUb4gBie/ODz31BbGSHRK8jwGX+lRXO7stJ/ZMC
	 rC5SwkxR9ipMw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcZQJ2Rhnz6tyw;
	Sat,  5 Sep 2026 15:47:20 +0200 (CEST)
Message-ID: <e627289dea7ba171f14bdd19e96ba9d8e490c8d5.camel@posteo.de>
Subject: Re: [PATCH v2 1/2] rust: serdev: Fix race condition on driver unbind
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org
Date: Sat, 05 Sep 2026 13:47:20 +0000
In-Reply-To: <20260905134458.85BDE1F00A3D@smtp.kernel.org>
References: <20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de>
	 <20260905-rust_serdev_fix-v2-1-35dfcd06ef2e@posteo.de>
	 <20260905134458.85BDE1F00A3D@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-f7QTXbD6Jjlhn83d5euP"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-f7QTXbD6Jjlhn83d5euP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-09-05 at 13:44 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] The function `drvdata_drop` introduces a Use-After-Free window a=
nd mutable aliasing vulnerability by dropping the driver data before cleari=
ng `dev->driver_data`.
> - [Low] The new helper function `drvdata_drop` is missing the `#[inline]`=
 attribute.
> --
>=20
> commit 26ab6ef2b4c35bdc9d899d45004d0c1a7f3fca80
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> rust: serdev: Fix race condition on driver unbind
>=20
> This commit attempts to fix a race condition where the driver data pointe=
r is
> NULL while the serdev device is still open. It does this by introducing a=
 new
> function drvdata_drop() that leaves the pointer valid until the memory dr=
op
> is complete.
>=20
> Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@=
smtp.kernel.org/
>=20
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 2291d85b6849e..3886cc713c28b 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
>=20
> [ ... ]
>=20
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
>=20
> [Severity: Low]
> This isn't a bug, but should this abstraction function be annotated with
> `#[inline]`?
>=20
> The Rust subsystem coding guidelines mandate that small functions forward=
ing
> to C bindings or performing small abstraction tasks should use `#[inline]=
`.
>=20
> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid =
pointer to a `struct device`.
> > +        let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) =
};
> > +
> > +        if ptr.is_null() {
> > +            return;
> > +        }
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

drvdata_obtain didn't have it.

>=20
> [Severity: High]
> Does this create a Use-After-Free window?
>=20
> By dropping the driver data before clearing `dev->driver_data`, the point=
er
> remains valid while and after the memory is freed.
>=20
> If a concurrent context, such as a hardware interrupt triggering
> receive_buf_callback() in rust/kernel/serdev.rs, runs at this exact
> moment, it will borrow a dangling pointer:
>=20
> rust/kernel/serdev.rs:receive_buf_callback() {
>     ...
>     let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<PrivateD=
ata<'_, T>>() };
>     ...
> }
>=20
> Could this lead to a memory corruption vulnerability during the unbind pa=
th?
Under a normal case, no one should access this pointer anymore. For
serdev, this isn't a normal case. Before it becomes a dangling pointer,
PinnedDrop ensures it won't be used afterwards.


>=20
> > +    }
> >  }

--=-f7QTXbD6Jjlhn83d5euP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqcHWcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSJ3AQAKbMytx5sShb1JLg5cGJ
X5EinwLILhtEvSF0Xh4qYQge57F1oc2wdWz3DsGuioop7/kpHoWN51GFkWgDUgDs
WNUTQcRMZfnX9aCl3MlVuu8C/bizPFCJj8Be9riDQrlGMUoogJQt8KndsQF21QxO
6Y2RsUduabpwNai5QxMbPNJcuZGMVlzvAj9R8KywjFkmkBZQ1Iu5QDebdlX9b385
LzxDvfZqtf5Fkrf9uaO58KoPO05upThquzxgj2tnxJPNF0G4mrdy3/QMPaW8mA3U
mKsKhujo9uqdaPhEmIqSo2xX6+YPhQ0QvrwyUaChv8jX/G96UyTXsI5YddLVk3bK
B5ovhsHEtmQ7gakyggjTxgjgE36cDt6DYyHZi+kx86JbLmE++76MieIGsgmyUEi7
viENjNxsnDIB4PJO/NS5ZD9pHcPa9KOcXK3UUivH1sOVnOMzazdqoz/ZK9U8K/0S
IYwp00TibYNnhXL+Rw2ZX8diLOclv0AdzJIYXW1jUZxNbX0aoASiYIEuywbQnu1q
13OpowcwSWSo4po8C5dA74rPyqUf/wfiARBcvF/pKkDP3vFj3ecxTEoR2a7BqWmR
8PVtToxtrwAEC5ES7R3S12VmWxK6qEaQf4Mefg0mDTNWOyGpTd6AEa5reJrWZPaA
RaUvTqZlCBpdoQKL0puCUzsJ
=XaCW
-----END PGP SIGNATURE-----

--=-f7QTXbD6Jjlhn83d5euP--
