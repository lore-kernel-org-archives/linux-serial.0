Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8BA48F825
	for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2026 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636801; cv=none; b=D+j3GbwyQBeW0v3CkaTMlMtJuFr6Lsl4gdM0FxmoG7PEOVo9Q8wSaV6WPNdrv0N6glSr0yGlX5OPKFqAAmnCvJvU3fVmFBVHQqA31GGlPuEfS4tEjFyulyTnR1R6miH8qLZDhd61TnV3gZ0ZVA1Dhq/SiSX7bt97duG/m5dMGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636801; c=relaxed/simple;
	bh=f8KLxPea0HyLvrqB38DTE1u6UglsgVGCoX3XG9VCthc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bfyGapzioiMaZKqiquXU6pktVgnEvqwb14R21H8oullD67m1/q4T1Q7lvQfDdA7t/y4J3AB8pA1USR7bC7iHPOFP1C7WyU8lOo4qsnR/BGr/44Odq4an1LRrwLJYecv4ceAkkylRhtAR/zpAOxm1P5+d89wcGfJCTw6cXbmeULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=hxhNg6gR; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="hxhNg6gR"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 8C56124023A
	for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2026 17:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1786636407;
	bh=QwT6TkRAv37uRauiX1wqqPxk8t+HhE99L8r/BMq1PXk=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=hxhNg6gRlK+ctUJOoN3wXxgnx8xY92+sW+h4mshklDcg/HqvS3abtceHeMN6lXkPP
	 uzKSFtiYv1vgJ+utVqa554OsDfZ7rI8FAJFpV7gVbsYK9qXgkyFe6t1GrIHOFEHprA
	 2xMPOhjbQk1sebvexLCGeQc/1SWNJKS+qYb1d4N85jFVywJUFQvmVRk+bmx5QWFTep
	 xVw360/S3mIIV2iTIS4zw36mzz+t69UQVOj4le240qVl1RBRkil0wJYfYeFHmBifJ6
	 wGg03SA8LcUzeUSSB4ZiiYXWx++h60qAHrbEzib8zLup16d23Nqcq1Ql8jRRqWzocT
	 RdaQiNeiugFyA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hLVJN5Hmvz9rxV;
	Thu, 13 Aug 2026 17:53:24 +0200 (CEST)
Message-ID: <8e716c8ed7172fa28b569bf59a146c262a29e0c2.camel@posteo.de>
Subject: Re: [PATCH] rust: serdev: use ThisModule::as_ptr() instead of field
 access
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev
Cc: driver-core@lists.linux.dev, linux-serial@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 13 Aug 2026 15:53:26 +0000
In-Reply-To: <20260813152444.514580-1-dakr@kernel.org>
References: <20260813152444.514580-1-dakr@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-1f4/B0mYCg1+BVpkpAsU"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-1f4/B0mYCg1+BVpkpAsU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-13 at 17:24 +0200, Danilo Krummrich wrote:
> The THIS_MODULE series [1] applied to rust-next moved ThisModule from
> lib.rs into a module.rs submodule, making the tuple struct field private
> outside the module. This breaks the module.0 field access in serdev in
> driver-core-next.
>=20
> Update the call to __serdev_device_driver_register() to use the public
> module.as_ptr() accessor to fix the build.
I encounter 2 errors when building with both driver-core-next and rust-
next

error[E0616]: field `0` of struct `module::ThisModule` is private
  --> rust/kernel/serdev.rs:90:89
   |
90 |         to_result(unsafe {
bindings::__serdev_device_driver_register(sdrv.get(), module.0) })
   |                                                                 =20
^ private field

error[E0599]: no method named `__pinned_init` found for associated type
`impl pin_init::PinInit<<T as serdev::Driver>::Data<'_>, error::Error>
+ '_` in the current scope
   --> rust/kernel/serdev.rs:200:40
    |
200 |             let result =3D unsafe {
data.__pinned_init(driver.as_mut_ptr()) };
    |                                        ^^^^^^^^^^^^^ method not
found in `impl pin_init::PinInit<<T as serdev::Driver>::Data<'_>,
error::Error> + '_`

error: aborting due to 2 previous errors


>=20
> Link: https://lore.kernel.org/all/20260811-fix-fops-owner-v10-0-7e71776f9=
dbe@linux.dev/ [1]
> Closes: https://lore.kernel.org/all/DKNAS52KYWLD.M15VEC6U0F6R@kernel.org/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/serdev.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index c0cd24481ee3..eecb1117095c 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -87,7 +87,7 @@ unsafe fn register(
>          }
> =20
>          // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
> -        to_result(unsafe { bindings::__serdev_device_driver_register(sdr=
v.get(), module.0) })
> +        to_result(unsafe { bindings::__serdev_device_driver_register(sdr=
v.get(), module.as_ptr()) })
>      }
> =20
>      unsafe fn unregister(sdrv: &Opaque<Self::DriverType>) {
>=20
> base-commit: 8364d0e36cbbdfe9adb65a170a70cbe3cdb02ff9

The first error disappears with this patch.

Reviewed-by: Markus Probst <markus.probst@posteo.de>


Should I send a patch regarding the 2. error?

It seems the `PinInit::__pinned_init` function is not only deprecated,
but also behind the `#[cfg(not(kernel))]` flag, which causes the error.

Thanks
- Markus Probst

--=-1f4/B0mYCg1+BVpkpAsU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmp96G4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSksMP/3SvodzkQyosoXvZaADn
boKoGg+8er8fdb/5T1cUJ/xD5/V/yKJBHmPxawTisVdXyNO3HF31tPysrI7lKr9u
GYN6tGW8BmVSNeNs155ULMnf6HbZeQ7wNCZAghu5MAO5+b02L6r0u4MS0PAehc2a
oObpt60cWMrUh9Q1DNjNrDYXHJ6sEcVYtvMUVSNU98qBRuwczPdoQRpLsurapFl3
kDh4PsH4Kvv284hs9OsS87DAj9r0atlJRwcOMUR72biYkuNMRuzjxc40efI5dLxi
/znjB2LlQdwWOm8WplHl6csVYRKb5pBDcWrQ2xLHho16MupI98J6YQoMmISFsFqK
IK08CyuaahhHYUSmIAjKxMUCk2IJYvJoeLGfNRvXR9nWomKySvs8nVpDUtvAAj0I
eKqO5IgDwy8CuejeMREWi5jp4y5P7WhUFOZO0L2mGkVPUIyk8LnXKsQ3eQIySks6
meEMCPZzj3knjzfNutk5Kf2inHlpxsCFefTHehXIxWZ/PUaP+0JoX+CyB40UgqDl
p5WBI64ahByqsIMaXus0vX6uQnUnz3YI8sQ+NX4NSCIhtvfXg3klv+Z4eFKE5fVi
Zk6Uq6Q9LAMxWsNT30CYsb4dbv8aGE/H1v6dCQRVKa134Nlx3cSR97bLu3Bwr7hg
NCZmkfPj+MjZ1KZ+8e1gI+T1
=sx6c
-----END PGP SIGNATURE-----

--=-1f4/B0mYCg1+BVpkpAsU--
