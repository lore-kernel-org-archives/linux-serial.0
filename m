Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7F34A77D
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387565; cv=none; b=AkwhIntB7pPXjlDCoKyGS8kMI1TwKj7aNqetsWf7I+a+1p5PZDByM5kXJpbKgvP4fQzxDZWiC7wyOZuqbWNdb1y0tmbhQe2rL0Fcg5wAU8hWRPRfo8REpG0rj0GXZDu/MlLlOc1Kl5bEsvCkvbhyB412H+gT31Vme01j4Md+7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387565; c=relaxed/simple;
	bh=gUJPOZmVJqkVByGf7bHunCrf9zfgWAJOjbhVn8PwtSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCx8AiKsXppY+JIKda87j2drjGrKSxcCflfObpX2JA2YMS3X4bLp7efFHAp+N91Mq1I1uN+oHkoxI9QsAtxp9Qfa4+97pE7r7J/FpZ1hRy3GRys+uBcF5A+DnxRxiToqw5tgFLBkqoHXCeCkXIGu3+dlh22aQpvE/j6O+ln+uEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=KQu0WksW; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="KQu0WksW"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 74B9E240106
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 17:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784387560;
	bh=4kzLe+wtVJyH+y9LVuVLGN4Wjww7mf1StIOqkMQG76U=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=KQu0WksWQne1NC2VaQt2Sf/i50jZN4sXCuyQK90ST+HqBtohqMXDzDLZsK3mcV+V1
	 MHrYxyevEJaf4Fa15HWWHr+uHPaGK8rL3G+ZrdbDd2ZgEoi+wsQYnOTaKq9zasKGFF
	 yBxsylJqHTAdB/F+S2AkyqdYDIZDtFDBZOQUPNTLQ2wo/rCSAgPX3voM7yoeTwFJGj
	 TQF7iW2fHvzNHYeICmqY9uUgYF+v6sr4tasiKHBMUbFcxlx7PANZJoLXe0uvGQ0XtF
	 X8mYuNlK43NSdoypLJuXQpxrkbg4SNrtisZC9J0mU0mtHrcFirujkKyCYGYQVku5c9
	 0F8HEAOQKrkQQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2VdL1wbLz9rxF;
	Sat, 18 Jul 2026 17:12:38 +0200 (CEST)
Message-ID: <dd8cc1a98c48338bd8b29168d312b7a1f466c8f3.camel@posteo.de>
Subject: Re: [PATCH v2 4/4] rust: serdev: remove `serdev::Timeout`
From: Markus Probst <markus.probst@posteo.de>
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 18 Jul 2026 15:12:39 +0000
In-Reply-To: <DK1SDT57QY13.3ZXZYQGOTK2P@garyguo.net>
References: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>
	 <20260718-rust_serdev_fixes-v2-4-e5214e03de13@posteo.de>
	 <DK1SDT57QY13.3ZXZYQGOTK2P@garyguo.net>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-TYJacBHMQ87hTAgcI4oo"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-TYJacBHMQ87hTAgcI4oo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-07-18 at 16:02 +0100, Gary Guo wrote:
> On Sat Jul 18, 2026 at 1:47 PM BST, Markus Probst wrote:
> > Instead of relying on its own timeout types, the abstraction should mak=
e
> > use of `impl Into<Jiffies>`.
> >=20
> > Suggested-by: Gary Guo <gary@garyguo.net>
> > Link: https://lore.kernel.org/rust-for-linux/DK0SX3P5K1J6.1OV4ETJMXW83R=
@garyguo.net/
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  rust/kernel/serdev.rs | 55 +++++++++++++++++--------------------------=
--------
> >  1 file changed, 18 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> > index a78dfa6e2c27..0fdb37cff15d 100644
> > --- a/rust/kernel/serdev.rs
> > +++ b/rust/kernel/serdev.rs
> > @@ -20,11 +20,7 @@
> >          aref::AlwaysRefCounted,
> >          Mutex, //
> >      },
> > -    time::{
> > -        msecs_to_jiffies,
> > -        Jiffies,
> > -        Msecs, //
> > -    },
> > +    time::Jiffies,
> >      types::{
> >          Opaque,
> >          ScopeGuard, //
> > @@ -35,7 +31,6 @@
> >      cell::UnsafeCell,
> >      marker::PhantomData,
> >      mem::{offset_of, MaybeUninit},
> > -    num::NonZero,
> >      ptr::NonNull, //
> >  };
> > =20
> > @@ -50,30 +45,6 @@ pub enum Parity {
> >      Odd =3D bindings::serdev_parity_SERDEV_PARITY_ODD,
> >  }
> > =20
> > -/// Timeout in Jiffies.
> > -pub enum Timeout {
> > -    /// Wait for a specific amount of [`Jiffies`].
> > -    Jiffies(NonZero<Jiffies>),
> > -    /// Wait for a specific amount of [`Msecs`].
> > -    Milliseconds(NonZero<Msecs>),
> > -    /// Wait as long as possible.
> > -    ///
> > -    /// This is equivalent to [`kernel::task::MAX_SCHEDULE_TIMEOUT`].
> > -    Max,
> > -}
> > -
> > -impl Timeout {
> > -    fn into_jiffies(self) -> isize {
> > -        match self {
> > -            Self::Jiffies(value) =3D> value.get().try_into().unwrap_or=
_default(),
> > -            Self::Milliseconds(value) =3D> {
> > -                msecs_to_jiffies(value.get()).try_into().unwrap_or_def=
ault()
> > -            }
> > -            Self::Max =3D> 0,
> > -        }
> > -    }
> > -}
> > -
> >  /// An adapter for the registration of serial device bus device driver=
s.
> >  pub struct Adapter<T: Driver>(T);
> > =20
> > @@ -379,7 +350,7 @@ macro_rules! module_serdev_device_driver {
> >  ///         _id_info: Option<&'bound Self::IdInfo>,
> >  ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> >  ///         sdev.set_baudrate(115200);
> > -///         sdev.write_all(b"Hello\n", serdev::Timeout::Max)?;
> > +///         sdev.write_all(b"Hello\n", 0usize)?;
>=20
> Note that the jiffies type is being converted to a new type (in fact,
> `Into<Jiffies>` only make sense with it being a new type.
I assume it won't take long for the patch series for the new type to be
merged. Currently there is no user for any other timeout than 0 (which
corrosponds to MAX_SCHEDULE_TIMEOUT in serdev).

Or should I revert to `serdev::Timeout` until then?

Thanks
- Markus Probst

>=20
> Best,
> Gary
>=20
> >  ///         Ok(MyDriver)
> >  ///     }
> >  /// }
> > @@ -505,11 +476,13 @@ pub fn set_parity(&self, parity: Parity) -> Resul=
t {
> >      /// [`Device::wait_until_sent`] to make sure the controller write =
buffer has actually been
> >      /// emptied.
> >      ///
> > +    /// Use a timeout of 0 to wait indefinitely.
> > +    ///
> >      /// Returns the number of bytes written (less than `data.len()` if=
 interrupted).
> >      /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::E=
RESTARTSYS`] if interrupted
> > -    /// before any bytes were written.
> > +    /// before any bytes were written. [`kernel::error::code::EINVAL`]=
 if `data.len() > i32::MAX`.
> >      #[inline]
> > -    pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<u=
size> {
> > +    pub fn write_all(&self, data: &[u8], timeout: impl Into<Jiffies>) =
-> Result<usize> {
> >          if data.len() > i32::MAX as usize {
> >              return Err(EINVAL);
> >          }
> > @@ -523,7 +496,7 @@ pub fn write_all(&self, data: &[u8], timeout: Timeo=
ut) -> Result<usize> {
> >                  self.as_raw(),
> >                  data.as_ptr(),
> >                  data.len(),
> > -                timeout.into_jiffies(),
> > +                isize::try_from(timeout.into()).unwrap_or_default(),
> >              )
> >          };
> >          // CAST: negative return values are guaranteed to be between `=
-MAX_ERRNO` and `-1`,
> > @@ -570,11 +543,19 @@ pub fn write_flush(&self) {
> > =20
> >      /// Wait for the data to be sent.
> >      ///
> > -    /// After this function, the write buffer of the controller should=
 be empty.
> > +    /// After this function, the write buffer of the controller should=
 be empty or the timeout
> > +    /// elapsed.
> > +    ///
> > +    /// Use a timeout of 0 to wait indefinitely.
> >      #[inline]
> > -    pub fn wait_until_sent(&self, timeout: Timeout) {
> > +    pub fn wait_until_sent(&self, timeout: impl Into<Jiffies>) {
> >          // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a =
valid `serdev_device`.
> > -        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw()=
, timeout.into_jiffies()) };
> > +        unsafe {
> > +            bindings::serdev_device_wait_until_sent(
> > +                self.as_raw(),
> > +                isize::try_from(timeout.into()).unwrap_or_default(),
> > +            )
> > +        };
> >      }
> >  }
> > =20
>=20

--=-TYJacBHMQ87hTAgcI4oo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpbl+AbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSRroP/05MQCTUhUfN25zOYKvo
FAPnib29fPa/SFQYTmCwiHIjOWkfHFCvlDLdbNeeEnEAaj+ubjtEoky5ybzOAGPs
8dSrdTK019v/dridzoRRnE0YkdKzCAgX+4H54fEl/I2liA0E0eETlVC9kfzO3Fi6
p1kFL9QZUAX9asvigiRpjVqSJZdZZBg1FRaplUr7JHxq8q7Huk9vT2uo5k/PdK2j
42hp+UL2uzz1tW/+opkOjZade2SpbmT8CvNq/WsM24eGCnA6l1Lm8eHrQiCedS/2
ur5F8fLpiazg8fomyWa1j04VcgFcJc33ygLIWjJP8x2uJElx8uBRIs+kn1DvG3Nv
697Am/lOu/+79G0HQjDygGUpXbWyZ3vws6Fu2tfK+p5oYovP5m4e74qfJolYgETe
AoGF14r1WOapQ/QHLVn9uZzrwG1kEZfaQR8vuNqcpf++bJwQl7naku+PKBxvsPag
CUZxbiqWsKHJ1VYeaf/lisQOzcuoCs0o4k+wP4eoxaySV2Gor6Adll3WdE2Xr01N
aGGWOw+1uTCjCi4nn6WJYhEbkOa12Aj4DbDrm4zyKU2gCrumEmAYR5eEEHlVQZkX
D8asdGiLUgrCDDESKmI5KRvz9c7bn/b5UQmZDmYUk7aGXkvFsxYH+OVw9VeJauKI
cGh6mS94LIx/3eDrYunHaXU+
=QYPI
-----END PGP SIGNATURE-----

--=-TYJacBHMQ87hTAgcI4oo--
