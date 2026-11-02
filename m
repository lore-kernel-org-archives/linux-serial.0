Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630497;
	b=yv6CW9WiTwgCiCoF3k0vEqYPn+Ca/Xtj0LBobqdZC1ipQkp+j4WD7ETrNR63h9DajlVQ
	 MBgr1+cQm/jt4hwSvw6tvnsQpyLEhrtEl+pHcMi/A/yx74Sr69WYBcj/8f8qTh0UomBqL
	 piJUNTnEeDTWAxDqa1T+4GBFnhpiiMLR9tL0ahVvKkbcDW9ABVP+L/I3afO/H1nlWydYA
	 9ETn97vaew7gKXXs3T9RZ6zE22JiunS5e+4uBrc91YpRrZU5/6sPGheaHA5EfWpDmRYkq
	 uZ3mr9zCN8RXdhU4k+feLaXMYidZJLnz3tUcqtmJIQ9w1mmG0o1dkYqQCnpIfaPvgxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630497;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=q4BbyPlA55uLGnnEP+ZkozszDrg8T06NCY0tEGU3zIg=;
	b=AlUB2NBWVLOWO3nYYj33KRJdvbpuNikHscOlvlgZMm7fO8zlCrzDOmyqrbhwxau4RBWs
	 J4yTmBnT2C8u4CfX7A4JYCnHAZkOD/StpF3UAx36ierhkT4A/hHvIxWXxzbLm907P2C7e
	 jOyfFp3cSjVbWzWwzgg3PnJ+iXDPGseeGSniRoj9J28VpFeJdT0E/m5OQpDdI9vteBiZq
	 93eB4syMrtJzipNUEaPgGN+b5UgICIpB0CpoF2DR1BceD7M+LWyg7wfWoXy94Qu5MvrEQ
	 JrEtGsxfO+alumsQDDHMKJo6FyQHaWwytwUjfQqCXhvFn7C6EbK9LSN6N+LhFZuqJ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=AwkrSabK;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224A606F21E
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 14:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7224A606F21E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=AwkrSabK
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CC1E9240105
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 15:41:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1793630488;
	bh=q4BbyPlA55uLGnnEP+ZkozszDrg8T06NCY0tEGU3zIg=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=AwkrSabKQuUSkna6dwyQaLrGtGXERdyICgo/2n/zLu3Jych1/MZ7U3VRsX0WyhJSa
	 /xgBXFm/8cDAiMVp9YEtBDlOrXxOubLegoOkyOCBNWr/UMHF4TsWoGhjy28jR3/2jF
	 bIBR8VUcivi2mZYQdFyy6DJ2/Mtu+2ZnIA68hdH/qXfUDlX+belscUGTCnntuMk0C8
	 w38+B3/niM6pV1m6bt0LCSLJ97BBakCnlic5pb/03DyE1P6x5xENCu/XoBLTKWX1wO
	 gz5wA13sXttJkchOxjFbslr3F3Fx3r67cRcNR7pPFf7yO5jBxg1eMXMr4egjm+9QBn
	 t3ScTD+jYDaFw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jJDsx5RLjz9rxQ;
	Mon,  2 Nov 2026 15:41:25 +0100 (CET)
Message-ID: <30511bdb7f197c632ee9baa7e8c5d730faad3b1f.camel@posteo.de>
Subject: Re: [PATCH v2] rust: serdev: use Delta<Jiffy> for timeouts
From: Markus Probst <markus.probst@posteo.de>
To: FUJITA Tomonori <tomo@flapping.org>, dakr@kernel.org, ojeda@kernel.org
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, daniel.almeida@collabora.com, 
	gary@garyguo.net, lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu, 
	work@onurozkan.dev, linux-serial@vger.kernel.org,
 rust-for-linux@vger.kernel.org,  FUJITA Tomonori <fujita.tomonori@gmail.com>
Date: Mon, 02 Nov 2026 14:41:27 +0000
In-Reply-To: <20261102005125.626125-1-tomo@flapping.org>
References: <20261102005125.626125-1-tomo@flapping.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-VItmpj0V2gWLosbtRcYy"
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


--=-VItmpj0V2gWLosbtRcYy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-11-02 at 09:51 +0900, FUJITA Tomonori wrote:
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>=20
> write_all() and wait_until_sent() take the timeout as a raw Jiffies,
> which is a c_ulong alias. The type does not show the unit.
>=20
> Take the timeout as Delta<Jiffy> instead.
>=20
> The C side treats a timeout of 0 as "wait indefinitely". The Rust API
> does not keep that meaning. A timeout of 0 or negative is rounded up
> to one jiffy. A caller that wants to wait indefinitely passes
> Delta::from_jiffies(isize::MAX). That value is MAX_SCHEDULE_TIMEOUT.
> The C side replaces 0 with MAX_SCHEDULE_TIMEOUT before it waits, so
> this gives the same wait as a timeout of 0 did before.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
> v2:
> - Round a timeout of 0 or negative up to one jiffy instead of passing 0,
>   which the C side treats as "wait indefinitely" (Gary)
> - Document Delta::from_jiffies(isize::MAX) for an indefinite wait
> v1: https://lore.kernel.org/rust-for-linux/20260930041339.1551129-1-tomo@=
flapping.org/
> ---
>  rust/kernel/serdev.rs | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>=20
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d..656598602d7a 100644
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
> @@ -433,6 +436,16 @@ fn as_raw(&self) -> *mut bindings::serdev_device {
>      }
>  }
> =20
> +/// Convert a timeout to the `long` the C side takes.
> +///
> +/// The C side treats a timeout of 0 as "wait indefinitely", so a timeou=
t of 0 or negative is
> +/// rounded up to one jiffy. `isize::MAX` is `MAX_SCHEDULE_TIMEOUT`, so =
it is passed through
> +/// unchanged and the C side waits indefinitely.
> +#[inline]
> +fn timeout_jiffies(timeout: Delta<Jiffy>) -> isize {
> +    isize::max(timeout.as_jiffies(), 1)
> +}
> +
>  impl Device<device::Bound> {
>      /// Set the baudrate in bits per second.
>      ///
> @@ -475,28 +488,26 @@ pub fn set_parity(&self, parity: Parity) -> Result =
{
>      /// [`Device::wait_until_sent`] to make sure the controller write bu=
ffer has actually been
>      /// emptied.
>      ///
> -    /// Use a timeout of 0 to wait indefinitely.
> +    /// A `timeout` of 0 or negative is rounded up to one jiffy. Pass
> +    /// `Delta::from_jiffies(isize::MAX)` to wait indefinitely.
>      ///
>      /// Returns the number of bytes written (less than `data.len()` if i=
nterrupted).
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
> +        let timeout =3D timeout_jiffies(timeout);
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
> @@ -545,16 +556,14 @@ pub fn write_flush(&self) {
>      /// After this function, the write buffer of the controller should b=
e empty or the timeout
>      /// elapsed.
>      ///
> -    /// Use a timeout of 0 to wait indefinitely.
> +    /// A `timeout` of 0 or negative is rounded up to one jiffy. Pass
> +    /// `Delta::from_jiffies(isize::MAX)` to wait indefinitely.
>      #[inline]
> -    pub fn wait_until_sent(&self, timeout: Jiffies) {
> +    pub fn wait_until_sent(&self, timeout: Delta<Jiffy>) {
> +        let timeout =3D timeout_jiffies(timeout);
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
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

I would have preferred something like `Delta::MAX_TIMEOUT`, but thats
outside the scope of serdev.

The rustdoc example above `serdev::Driver` needs to be fixed.

With that resolved,

Reviewed-by: Markus Probst <markus.probst@posteo.de>

Thanks
- Markus Probst

--=-VItmpj0V2gWLosbtRcYy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrooRUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS5fgP/jd/ISeiVOjQsWXLBo3E
jCKQl/TL+zem3Zfmu69+fCiuNbLqsYhhywvcBcYRyoWem839Sma3i4qI/YcxdFCc
pIaiqSbXWHnMPZJ+T0cmswwsuoWrzJ7MG5YfcMO0pDxcX2oV2w0auIB5DoeS7lQa
BMz9A+nIOjZGyHmoeJS/xGzIWTEuciU23NTkpPuD3H7KKHK1CRuRZaeCTMza36fn
gBaF7S06jWSWeKG5NGmmyUtyOukcLkvoWaTLgpKtGsHpZ7ta7mdehBw8qz/UtSqx
bpdKU5bxhPqYu2ATu31q60kAg9CeItWLSqod8EcG8xpmQanJK5I/VuCmL/SWgfSg
CKkc/PeYaYLNA8G3MKl1PSBhGgTv6K4wwWOK+F8Gd6q/4Dpje/1UVoN8rpIzJr7b
jkisPNUcUjn8HGmRU/WKpWOyMH/EuPY70B0EN4G4IukIeds0444nlkpthcjHwMcX
2FxAwnKuJAetu/+9FlTuVWkgRd2mV2mQLpXTKAl9tmmj1CleKyTsuB++VSePHz1W
XsrECQhmHiyXzAr2IabNjRl59ABSHrKLX1xRhO90apkdjBWZ9mXxpLe5FDrRJQrM
lC5M7GSgMWPTeGYIg54W2igvUk5t0l/AOGMQXv2TxoTB99c9ulug0Fuodn7G4Kgd
CGsQxKTsrJmv5L/lmxRVbjvC
=ysKJ
-----END PGP SIGNATURE-----

--=-VItmpj0V2gWLosbtRcYy--
