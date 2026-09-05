Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B43BD224
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788652748; cv=none; b=tU0nVkNeykCxYNfJ0SwgeKEyeAfmDRgxoVBZrTmNXou9tTrch7UWv0V/y6bVII5kJrCzwAzsrysg3/zYS1oDXGvG/UL7168K/UdNnWwKxF0xgKU4djcdr8304JrYO6SWZFJRXhPwz4ewBq+i5ezoa+LdDQBSkBcpjd5jeO5BMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788652748; c=relaxed/simple;
	bh=/aevbeRoIEZWFYh/V34VMBWutoQHjBrwm/glUNK1mBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gzjIMHwlVu51Mca33bdFEGiDd8ahk13gE/wnYjxoUgqFCjKuX2L5CD04FVWunNMapDSElQGlK0TTVo3G1mvSNyjamR9ZtAo9EZc6mclGbFz06MKpWgoKeMswANIvb+jLS5uROThNkniZuFjCA0hCYjV9z3AlJGdr98ct6PgZ90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=cMiLVQAm; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="cMiLVQAm"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 587AA240028
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 01:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788652741;
	bh=GbCFZY4yPxaaAdbAPgLgXk+ltlGkCO71dhWFIDtAGU8=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=cMiLVQAmEp7IaIbLYr9hzB/x3k9TMzgdbA2UYaB9uVlJ/o0EuP0DxJ+/s+dq3bUyZ
	 LvrkwXl2Ewq1CTV+UJWWaXtPxLTLjOaVs3ekY+aQ77xjF2QNZwIfRZV6cNWmDF2zf8
	 0q0JhfYCpsq6coqEwI+jGJkshEmP48QeYpAoyCMcYJIkOpLFZDyAyx6uqMDZG9sTA8
	 u33t/xHtGExAa3BW9V1g7aFHfBC80zcLWImyDmfzCYE63g9HEg1jGLyhHHa55X18z3
	 B8jKWGeC/AD4hPP5tRbQia+7sgktxXbC3Zbxb88CDsBISfvtZ8PUfoKVe+3f2RCp7T
	 fCKQC6e20cm1Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcr031fVvz6tsb;
	Sun,  6 Sep 2026 01:58:59 +0200 (CEST)
Message-ID: <bbf788a86a24b838792fc56aef29fea95d311283.camel@posteo.de>
Subject: Re: [PATCH v4] rust: serdev: Mitigate race conditions
From: Markus Probst <markus.probst@posteo.de>
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
	 <boqun@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>
Date: Sat, 05 Sep 2026 23:59:00 +0000
In-Reply-To: <DL7S2EDXP5IH.395Z0FSCRMNIF@garyguo.net>
References: <20260905-rust_serdev_fix-v4-1-31e1bbcc0c00@posteo.de>
	 <DL7S2EDXP5IH.395Z0FSCRMNIF@garyguo.net>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-AvUvLUrsSkHeAmTvTL2S"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-AvUvLUrsSkHeAmTvTL2S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-09-06 at 00:39 +0100, Gary Guo wrote:
> On Sat Sep 5, 2026 at 7:47 PM BST, Markus Probst wrote:
> > There are currently 2 race conditions:
> > - in probe if `Driver::probe` returns Err
> > - in unbind
> > . In those cases the driver data will be set to NULL before the serdev
> > device was closed. If data is received while the driver data is dropped=
,
> > the `receive_buf_callback` might try to access the `active` mutex on a
> > null pointer. The race conditions can only occur if `Driver::receive` i=
s
> > implemented.
> >=20
> > The issue cannot be cleanly fixed without rewriting some logic, which
> > might introduce new regressions.
> >=20
> > Temporarily disable the use of `Driver::receive`, until fixed in the
> > next release.
>=20
> Isn't this basically undoing all the usefulness of having the serdev abst=
raction
> in the first place?
It removes 50% of its functionality, so kinda. The initial
"synology_microp" driver [1] in the mailing list for instance currently
doesn't rely on it (it will need it later though).
>=20
> As this is for unbound only, I don't think we need to rush to fix this fo=
r rc
> anyway. Many C drivers don't get unbind correct (and our misc device). Th=
ere's
> no in-tree user that will hit this API anyway.
Also on probe failure (i.e. Driver returns an error on probe).
>=20
> I think we'd better just find a proper fix for the next cycle and leave t=
he
> current code as is.
Thats also an option I wouldn't mind.

The proper fix is almost ready.

Thanks
- Markus Probst

[1]
https://lore.kernel.org/rust-for-linux/20260724-synology_microp_initial-v18=
-0-fb2f49f10e77@posteo.de/

>=20
> Best,
> Gary
>=20
> >=20
> > Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
> > Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3=
D@smtp.kernel.org/
> > Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E=
9@smtp.kernel.org/
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> > I will submit a patch (for the next merge cycle) soon, which will
> > address this issue and make the probe and unbind code less convoluted.
> > ---
> > Changes in v4:
> > - remove comments
> > - Link to v3: https://patch.msgid.link/20260905-rust_serdev_fix-v3-1-b8=
6056c3f7a4@posteo.de
> >=20
> > Changes in v3:
> > - mitigate it
> > - Link to v2: https://patch.msgid.link/20260905-rust_serdev_fix-v2-0-35=
dfcd06ef2e@posteo.de
> >=20
> > Changes in v2:
> > - also fix race condition on unbind
> > - Link to v1: https://patch.msgid.link/20260905-rust_serdev_fix-v1-1-2e=
a92b154a6b@posteo.de
> > ---
> >  rust/kernel/serdev.rs              |  6 +++---
> >  samples/rust/rust_driver_serdev.rs | 13 +------------
> >  2 files changed, 4 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> > index 17ca504b7f8d..f4c0f43b5273 100644
> > --- a/rust/kernel/serdev.rs
> > +++ b/rust/kernel/serdev.rs
> > @@ -148,9 +148,8 @@ fn drop(self: Pin<&mut Self>) {
> > =20
> >  impl<T: Driver> Adapter<T> {
> >      const OPS: &'static bindings::serdev_device_ops =3D &bindings::ser=
dev_device_ops {
> > -        receive_buf: if T::HAS_RECEIVE {
> > -            Some(Self::receive_buf_callback)
> > -        } else {
> > +        receive_buf: {
> > +            const_assert!(!T::HAS_RECEIVE);
> >              None
> >          },
> >          write_wakeup: Some(bindings::serdev_device_write_wakeup),
> > @@ -233,6 +232,7 @@ extern "C" fn remove_callback(sdev: *mut bindings::=
serdev_device) {
> >          T::unbind(sdev, data_pinned);
> >      }
> > =20
> > +    #[expect(dead_code)]
> >      extern "C" fn receive_buf_callback(
> >          sdev: *mut bindings::serdev_device,
> >          buf: *const u8,
> > diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_dri=
ver_serdev.rs
> > index 51b4898cd855..3fd3eef15371 100644
> > --- a/samples/rust/rust_driver_serdev.rs
> > +++ b/samples/rust/rust_driver_serdev.rs
> > @@ -4,10 +4,7 @@
> > =20
> >  use kernel::{
> >      acpi,
> > -    device::{
> > -        Bound,
> > -        Core, //
> > -    },
> > +    device::Core,
> >      of,
> >      prelude::*,
> >      serdev,
> > @@ -60,14 +57,6 @@ fn probe<'bound>(
> > =20
> >          Ok(Self { sdev: sdev.into() })
> >      }
> > -
> > -    fn receive<'bound>(
> > -        sdev: &'bound serdev::Device<Bound>,
> > -        _this: Pin<&Self>,
> > -        data: &[u8],
> > -    ) -> usize {
> > -        sdev.write(data).unwrap_or_default() as usize
> > -    }
> >  }
> > =20
> >  impl Drop for SampleDriver {
> >=20
> > ---
> > base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
> > change-id: 20260904-rust_serdev_fix-be3ff9c8a5e8
>=20

--=-AvUvLUrsSkHeAmTvTL2S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqcrMIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSA5MQAJV8O1pYZJ7MdqoPhC0i
HCSFZCLqKeQIDnA8nMdtD4a48gfR5beNCNQwEokjTk1gkQWs69vY1rgS07b877dL
uzb3tQC8lnP/RnnbuqOAHgthvhqC8fw/L6ylt4gHrs59K7O73fyGeNXaOvKDEQBl
r5KLEJpL49RWQORhegrJpG72d//qDIYpZaF1Jx7zI0LHC0OfODLaB8TwlhbgOjS7
qxLVlB6T+oDgFzRUZksB/8/NRQiI/XR0YNNtXzSx9HeQY+VZzCMSgR2KxvEzojaG
eJkd2oigpWFbcY4aTWt1RLyg/dUMVAmt1SwS/DLeS3DS13FkVX5CWOi5QkKIyCh5
9fBjPldCng7jksj5mFTikYzxYcELaQ+IkxUsq44ggJb88V9B3DfzL2IpCeHEPRYM
ikQJFQ1FEbafRPOZcWcztIhmpnq/yNZbFD+OF0/brx1kYZ7meiONBWzJ93NL9qnJ
HGzg7PJxqCZQe4VUMcVbLmr/osQaPfKr8iU6t0/ku1XM263MlMIO1M+/pJQAKQlJ
DHiOnsu5ZIoAPbJfcUXbI3wxwzrCBIfQ0EVX3JdcA2R0FUYAagLeijN9bb0MRMEf
YNlI5gJPwcUcSX3VCYQPNTebetFxe8Ap7kdMYclJZTLIMEDI96HRT4kz3nyHq29y
LKkseoWVpjHQ9GpJZtcltE8l
=IxEx
-----END PGP SIGNATURE-----

--=-AvUvLUrsSkHeAmTvTL2S--
