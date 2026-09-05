Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B52D0614
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567738; cv=none; b=E064AaSPa/zg8F8SE5SE1AvJXfI0u5eUV3XnF1lc3ym7s2VFuKLfhnKopEPrIhhC7IyMaPvfxY0O7Kcc+hx+JTa0NAU3mqR57r9e2R3EkH6oyecuvGTY2o4N80pQwASzGR7EDbhkNgsxtD4C8WYZkFYyu1h+SE1OLhe3Yv8HFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567738; c=relaxed/simple;
	bh=rPtvF+oy++bWBsxAvnCpkzx8qpDyld6WLHwbjhnN0WE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpJScoCBG+43tEyaCLFdVVbgtKbQuN1oixQ/XKkCn74Ek9Pn4G9ZtyT+UGOKsCAGgw8XHwLo9gciOE5hxMOK2SevQCZe/HeQFHMn590HcapLul/RngN55L6TSf+uLbMYiYo8w3+SQ76KrU+R7S2w45GGH9LSP31pCWYqi/4gQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Aqh/ROIe; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Aqh/ROIe"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9CCD224002A
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 02:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788567733;
	bh=kQ9wATxRdfmb8dy5zEGoqKhMK7g0F67e/+Nr8jovqQA=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=Aqh/ROIemX5w0HLLzgPQVCnPMQ1OqndRb/UCZwQ3wtbzRvsWZPk7Baojxq1RGj0Hd
	 dFhw0UOrAKbzPbxXAtRYAlDMVGxtU//JMv+u39Q/gXdb4fdUyQpTLcO+ans/0VIxld
	 3CYrcCLX6kUHFXpCQhGdAkypmY98TZCyzSd8UsqhL3PI62mcH5sDrIUvNGfkM5hFNY
	 BSXn6pnog8h8qmsllSelt9rLgWObah4uGI8UBFs7qSKDG1gE1+eRL2H1ctmzStzr8r
	 SR6457DrungLxTiTTNlcJ9kyrsLERdBQTi43GNEQaZCzVu1hJl8joobcqFR8adTCtc
	 SJpzF6EllJtQw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcDYH5tCpz6tsg;
	Sat,  5 Sep 2026 02:22:11 +0200 (CEST)
Message-ID: <1b247f730001ea39b6e4044f5673e1a01e187362.camel@posteo.de>
Subject: Re: [PATCH] rust: serdev: Fix race condition on driver probe fail
From: Markus Probst <markus.probst@posteo.de>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>
Date: Sat, 05 Sep 2026 00:22:12 +0000
In-Reply-To: <20260905-rust_serdev_fix-v1-1-2ea92b154a6b@posteo.de>
References: <20260905-rust_serdev_fix-v1-1-2ea92b154a6b@posteo.de>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-ba5r6Ds701NYq8n4AnLV"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-ba5r6Ds701NYq8n4AnLV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-09-04 at 23:54 +0000, Markus Probst wrote:
> If `Driver::probe` fails, the pointer to the driver data (`PrivateData`)
> will first be set to NULL by `drvdata_obtain` and only after that the
> serdev device will be closed by Drop. Thus there is a small window in
> which the serdev device is still open, but the pointer to the driver data
> is NULL. Therefore it is possible that `receive_buf_callback` might try t=
o
> access the `active` mutex on a null pointer.
It seems, Sashiko found the same issue in a different unrelated place
too (while reviewing this patch):

https://sashiko.dev/#/patchset/20260905-rust_serdev_fix-v1-1-2ea92b154a6b%4=
0posteo.de

Unfortunately, I cannot fix this one so easily, because the serdev
device needs to be open for the entire lifetime of the "real" driver
data (Driver::Data).

Thanks
- Markus Probst

>=20
> Add a separate `ScopeGuard` that will close the device before the driver
> data will be set to NULL on probe failure.
>=20
> Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@=
smtp.kernel.org/
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
> Unfortunately, this also makes the code in probe even more convoluted
> than it already is. I will submit a patch (for the next merge cycle)
> soon, which will address this concern.
> ---
>  rust/kernel/serdev.rs | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d..4f57f4c45329 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -190,6 +190,16 @@ extern "C" fn probe_callback(sdev: *mut bindings::se=
rdev_device) -> kernel::ffi:
>              // SAFETY: We have exclusive access to `private_data.open`.
>              unsafe { *private_data.open.get() =3D true };
> =20
> +            let open_guard =3D ScopeGuard::new(|| {
> +                // SAFETY:
> +                // - `private_data.sdev.as_raw()` is guaranteed to be a =
pointer to a valid
> +                //   `struct serdev_device`.
> +                // - We just opened the device, thus it is guaranteed to=
 be open.
> +                unsafe { bindings::serdev_device_close(private_data.sdev=
.as_raw()) };
> +                // SAFETY: We have exclusive access to `private_data.ope=
n`.
> +                unsafe { *private_data.open.get() =3D false };
> +            });
> +
>              let data =3D T::probe(sdev, info);
> =20
>              // SAFETY: We have exclusive access to `private_data.driver`=
.
> @@ -203,10 +213,12 @@ extern "C" fn probe_callback(sdev: *mut bindings::s=
erdev_device) -> kernel::ffi:
> =20
>              drop(active);
> =20
> -            result.map(|()| {
> -                private_data.dismiss();
> -                0
> -            })
> +            result?;
> +
> +            open_guard.dismiss();
> +            private_data.dismiss();
> +
> +            Ok(0)
>          })
>      }
> =20
>=20
> ---
> base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
> change-id: 20260904-rust_serdev_fix-be3ff9c8a5e8

--=-ba5r6Ds701NYq8n4AnLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqbYLMbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSfgEP/i6+AVvUF3DqH4KPzANY
lQxCfnQ6YihdUcZqxdMK6q7060z/70SLiAeo74SDBOmywI8lpZf7SjZr6y7FHLl7
1FvGiHYtX2WoNzVJdDn0NfEq8z/MZlEvY22eRVnlF0EXLSBxcxpUVhl26A0EFsBz
khMHRTRKaEj15m+Fuoxuy5TeEKLDE/H9zRvM1FfkGsTskuFUbCjdaelnX8O1ddHE
Vg1p1dO7n93Rma7hM0a0IGVAJiaoNIO6aIofkMmrCsb3tH1JHwzMR0MhN1R6Nrhu
lZ7KGy0NeVkIqynw907VxwB/8j3G2BuWnfP372OCTXWTQVdRL4+k+cc+dwcWoclm
cTbeTCZIs+bX4LJ4lBuo1IV9+d/0ZroWGJHMMZwTD4iAWgTPCBy2tdr2IMah/3Uj
YBg067irDbs04bvuEK006NAtZnZsSfc3ucblOndhTi9yMFL2cY4LkdVULOVQn/Qk
DbDRz1LYf0rxTbnpVBuAvcQIGu97d7fUZMayxBfcpfGVDxWJdJWl3XU4qsqHRQfx
XT58FmhwPIjYekUcAZ76spYDQPnjPLBvl3j2AnJTav4p6RY91rqNBOa7EPQiZEF2
EBtM20N9sH6NBMsiKKv+2+b/L4nZHt77qpiXbkZULqNBAI7cX38S7n6O8FT3uqri
zetB5vh5bJfhDNmdV1gEo9pP
=hU1N
-----END PGP SIGNATURE-----

--=-ba5r6Ds701NYq8n4AnLV--
