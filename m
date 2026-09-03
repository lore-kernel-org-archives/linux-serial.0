Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F189361979
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474699; cv=none; b=LMJNMUIrJjkNfm037DwzXatgi+NXpWUmtY41Dgp3FOejZvNsZUo5dVOrbDU/Dwa+CPaRFGbSKqr+XI0J7g4wvt8ishtpPiVhIqEzxsffGMR50/0s16h+EnIbyuQvSyL8OCm7NWIsA9YFwSXvzHtQFTyGZO1wFFQsBOpbU1vb1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474699; c=relaxed/simple;
	bh=SC8msKd4liq5RgprKW2P+oARDa4OohOlzj9gKvTIG4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jV+Ys9yYUhpyqiN/oVJA1RCzIepI3U16Sxs4UIRf0RttHQO5virlAhKpPZVkxqpgfemqAd0ENINcR/JqBF+B3ePdU6WlFRODehiVoLV0obxX2ajF4LZYawEj6vh9P87lczSHP3ZSZBnZD/3jToJrBbxlpaU8+blQ45JjWltZWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=hhnkgw+A; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="hhnkgw+A"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id F1950240028
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 00:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788474693;
	bh=ufFEH71c3NEpjig5lV8qtBIYSld2UH9x73t3GqVwzzs=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=hhnkgw+A2fgW0DKG8CbItTSSqPzcX9eD2uhpsqYoL2jhqrvMUFwPpP1HEVPRfSCOP
	 KWo5PdK7gj0B7sRfcCFz7MSOUGzZwkQcXCfk/s3GjK2VDmtY9h89qf1ZeuCY9UuibC
	 CzyQeTqfiE1nJabV4CY69hzgU0LR6asgCvz1NOSV6mZ4gHiNdkz+m6vzpDH4573xIW
	 AOWHQx6h9JlrhSofQ4t750Oy40mLuT+aqDxGkJzt4pNg5XM9oFYkc2dXnJyGlhWe5O
	 oplFzOOFbqzNcsl3+7ph91rP9H0je6NyWbSl6PMQ9DOuJhdYydmrjavjAdbV5rrERt
	 2qP5vhHd4zENg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hbZ853Jd9z9rxD;
	Fri,  4 Sep 2026 00:31:33 +0200 (CEST)
Message-ID: <c284466700477e9c69cd433db90baf273bef764b.camel@posteo.de>
Subject: Re: [PATCH] rust: serdev: Synchronize receive callback before
 calling unbind
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org
Date: Thu, 03 Sep 2026 22:31:33 +0000
In-Reply-To: <20260903222159.70A911F000E9@smtp.kernel.org>
References: <20260904-rust_serdev_ref_mut-v1-1-245db7eb09af@posteo.de>
	 <20260903222159.70A911F000E9@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-D4watG/QRT1xefvUmWai"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-D4watG/QRT1xefvUmWai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-09-03 at 22:21 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>=20
> New issues:
> - [High] Holding the `active` mutex during `T::unbind` causes an inescapa=
ble deadlock for drivers that synchronously communicate with the device.
> - [Low] Logically dead code inside the error-handling `ScopeGuard` in `pr=
obe_callback`.
>=20
> Pre-existing issues:
> - [High] Race condition between drvdata_obtain and receive_buf_callback c=
auses NULL pointer dereference or Use-After-Free.
> --
>=20
> commit 6f561db35778bb34c19e46b1a5df116263c0adbc
> Author: Markus Probst <markus.probst@posteo.de>
> Subject: rust: serdev: Synchronize receive callback before calling unbind
>=20
> The commit changes the receive and unbind callbacks to provide exclusive
> access to driver private data by handing out mutable references. It remov=
es
> the Sync requirement for Data and introduces locking for synchronization.
>=20
> > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> > index 17ca504b7f8d6..44f029ed93fd1 100644
> > --- a/rust/kernel/serdev.rs
> > +++ b/rust/kernel/serdev.rs
>=20
> [ ... ]
>=20
> > @@ -127,16 +127,6 @@ pub struct PrivateData<'bound, T: Driver> {
> >  #[pinned_drop]
> >  impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
> >      fn drop(self: Pin<&mut Self>) {
> > -        let mut active =3D self.active.lock();
> > -        if *active {
> > -            // SAFETY:
> > -            // - We have exclusive access to `self.driver`.
> > -            // - `self.driver` is guaranteed to be initialized.
> > -            unsafe { (*self.driver.get()).assume_init_drop() };
> > -            *active =3D false;
> > -        }
> > -        drop(active);
> > -
> >          // SAFETY: We have exclusive access to `self.open`.
> >          if unsafe { *self.open.get() } {
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but does the timing of closing=
 the
> device cause a use-after-free or NULL pointer dereference?
>=20
> If probe fails after the device is opened, or when the driver is unbound,
> drvdata_obtain() clears the underlying C driver_data pointer to NULL and
> drops the data. However, bindings::serdev_device_close(self.sdev.as_raw()=
)
> is only called later inside PrivateData::drop().
>=20
> Because the device is still open while the pointer is cleared, incoming
> serial data can trigger receive_buf_callback() in the TTY workqueue.
>=20
> receive_buf_callback() calls drvdata_borrow(), which reads the NULL point=
er
> and blindly dereferences it, or reads it right before it's cleared and
> accesses freed memory.
>=20
> Should the device be closed before clearing the drvdata pointer?
This definitely needs to be addressed, yes.
>=20
> [ ... ]
>=20
> > @@ -176,7 +166,20 @@ extern "C" fn probe_callback(sdev: *mut bindings::=
serdev_device) -> kernel::ffi:
> >              let private_data =3D unsafe { sdev.as_ref().drvdata_borrow=
::<PrivateData<'_, T>>() };
> >              let private_data =3D ScopeGuard::new_with_data(private_dat=
a, |_| {
> >                  // SAFETY: We just set drvdata to `PrivateData<'_, T>`=
.
> > -                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateDa=
ta<'_, T>>() });
> > +                let private_data =3D unsafe {
> > +                    sdev.as_ref()
> > +                        .drvdata_obtain::<PrivateData<'_, T>>()
> > +                        .unwrap_unchecked()
> > +                };
> > +
> > +                let mut active =3D private_data.active.lock();
> > +                if *active {
>=20
> [Severity: Low]
> Is this block of code logically dead?
>=20
> The ScopeGuard closure checks if *active is true to selectively call
> assume_init_drop(). However, *active is only set to true if the driver
> initialization succeeds.
>=20
> Immediately after setting *active =3D true, private_data.dismiss() is cal=
led,
> which consumes the guard and prevents this closure from running.
>=20
> Therefore, this closure only runs on the error path, where *active is
> strictly false, meaning the assume_init_drop() block will never execute.
True.

>=20
> > +                    // SAFETY:
> > +                    // - We have exclusive access to `private_data.dri=
ver`.
> > +                    // - `private_data.driver` is guaranteed to be ini=
tialized.
> > +                    unsafe { (*private_data.driver.get()).assume_init_=
drop() };
> > +                    *active =3D false;
> > +                }
> >              });
> >              let mut active =3D private_data.active.lock();
>=20
> [ ... ]
>=20
> > @@ -222,15 +225,21 @@ extern "C" fn remove_callback(sdev: *mut bindings=
::serdev_device) {
> >          // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> >          let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<P=
rivateData<'_, T>>() };
> > =20
> > -        // SAFETY: No one has exclusive access to `private_data.driver=
`.
> > -        let data =3D unsafe { &*private_data.driver.get() };
> > +        let mut active =3D private_data.active.lock();
> > +
> > +        // SAFETY: We have exclusive access to `private_data.driver`.
> > +        let data =3D unsafe { &mut *private_data.driver.get() };
> >          // SAFETY:
> >          // - `private_data.driver` is pinned.
> >          // - `remove_callback` is only ever called after a successful =
call to `probe_callback`,
> >          //   hence it's guaranteed that `private_data.driver` was init=
ialized.
> > -        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_in=
it_ref()) };
> > +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_in=
it_mut()) };
> > =20
> >          T::unbind(sdev, data_pinned);
>=20
> [Severity: High]
> Does holding the active mutex during T::unbind() cause a deadlock for
> drivers that synchronously communicate with the device?
>=20
> If the driver's unbind() callback sends a shutdown command to the device =
and
> synchronously waits for an acknowledgment, the incoming serial data for t=
he
> acknowledgment will be routed to receive_buf_callback().
>=20
> receive_buf_callback() attempts to acquire this same active mutex to proc=
ess
> the response, completing the deadlock because remove_callback() is blocke=
d
> waiting for the acknowledgment.
That would be a driver issue.

And there shouldn't be a reason for a driver to wait for an
acknowledgement.

>=20
> > +
> > +        // SAFETY: We already established that `data` is guaranteed to=
 be initialized.
> > +        unsafe { data.assume_init_drop() };
> > +        *active =3D false;
> >      }

--=-D4watG/QRT1xefvUmWai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqZ9T8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSxl0QAKNm7ejnfiPmNdldgH6P
HQubJwFCJnmJsyEqNxNcMq1mLCEeF76Qo/4B9WWoFnFlpTwq+Gfdlp5e7GmmJWQS
meBBbAp+NcKs8AhbeIMwhOiqJioxuqRfA1QL5x51xtWR6Wy6TV6O4tUrnvQTp2+a
fIsUFPOuzgSgkMthHkwnGN/Fuym4XhGJRwYGrZohG1aBZI6PGmxWp6S1ysj4XXhR
LcfoYSFIHxbrvoSuAMd/DaHX24tsRQknu1YfamGdahYYjWwx56x3y5QPCJ1VoYjS
dcezJbR2hat71SJY6y3u/oklEuRv7jIavb6S7olVcmZIyFt5H1yWkSzAlL1eyFLc
yq8c+wtI42QoPKZdZ0+MLVQnFRdf0yPsJyFAHcr8W4RlW5k0MGelANgt0t8KQPcA
SOzLGtItPEVI6mPv7KY3wMxhbv5UU0EvShKocNjdLtiEZNxrUbGi6jKYvPQK8cKw
B6mmsHeds8Iu+9qUyFT70MHBP3zPDGj12w8gCxPxk1E2g2cjm1ZJgwJ6xVgPv0sZ
3ALsSoThU/Mr1XxivyaziCeF2qtjUY65NyznjGLt+mVvqzBldWAsIvq4Q0ukTKtM
b6cs39xeXWtioQvYo+MIX1vppSPkttkX9gx2HWmrphNEwwQF4lqta+kEhSCjkZju
T2/sWpxbVjUitxdda81sBNxI
=ReEZ
-----END PGP SIGNATURE-----

--=-D4watG/QRT1xefvUmWai--
