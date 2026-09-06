Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DB3BFAD9
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716217; cv=none; b=g+TazfffJjieAt32kBR60TvilcYpE/YyFwrWyQZ0OT16I4m9gUcTGwgrXMtN4+S5Y2r9NdbwSLY3U+41V0hcYKykR//8EBWhDHKCWfDades4YBZi74BCYEZADx44obty1YzkVHUe57A3blAVMbYO5bJLmvHIGrqg2vLQLe+YiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716217; c=relaxed/simple;
	bh=fYQ56hs4JZbOPzI9GDapvEN/e9D4SZhXgTO/mzH3DAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/AdnjI2f5LsaVRfRMCGojCGDUDFoWWa/OTikT3KHIbjhcl2+JUGLWRemgdFE8KYJJ+Je2h4ftGSHiwYx9AprdfiXDRN66AxD9bbrTGmmSDj1L93cZs8z9TL3obcwqOXp1q68e8jTezLEvars48TM63/bo8WtRxtZjAsaB96jhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=BUESNfXR; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="BUESNfXR"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1AC0F240104
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 19:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788716211;
	bh=DOeFnrNegKPZyHyOuDBcouHZPqHJUHfv+oiAMmLgHoY=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=BUESNfXR+UKLw1tFQelyLqKXqpf3Krmb1Hui7V+kwm4SrEL1hOahhW/7pY3mjql0Y
	 kD9QnAyN7ihfAzGIj4bCKihGjpGLXpWl+CR9DqCUI7dBk2w4vMLTX+O7g+XGLcuduj
	 c7busNO5Of5ZuVrXmuI6grrfnYiFfhfW7xZdqmrxPLAG9d5pOcCiq/DmstzbLQNnZN
	 ZYYpoTqphUmBQNgThwpoQSTo0W/IpjMRbh8x8WMMTBzelTZHxf85T3o/5K0igBSBky
	 uw6zbmKnciuMBjufgjSpl+1XO9/uQk5UqLav/NmAV5YUz0A5+KOGoE5wbTRdDm79R1
	 YmbO4zvEvBHTg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hdHSb1mS9z9rxN;
	Sun,  6 Sep 2026 19:36:47 +0200 (CEST)
Message-ID: <af5938831d18728e484753a787400a404eb81e55.camel@posteo.de>
Subject: Re: [PATCH 5/5] rust: serdev: Pause receive callback before calling
 unbind
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miguel Ojeda	 <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>, Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel	
 <ardb@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka	
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Uladzislau
 Rezki	 <urezki@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, "Rafael J.
 Wysocki"	 <rafael@kernel.org>, greybus-dev@lists.linaro.org,
 linux-serial@vger.kernel.org, 	rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	driver-core@lists.linux.dev
Date: Sun, 06 Sep 2026 17:36:49 +0000
In-Reply-To: <DL8DCNMSENDS.3T14U5W1Y32IX@kernel.org>
References: 
	<20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
	 <20260906-rust_serdev_probe_refactor-v1-5-69cdae0074ec@posteo.de>
	 <DL8DCNMSENDS.3T14U5W1Y32IX@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-rnTpNxyRN/xwpGJ+AFb3"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-rnTpNxyRN/xwpGJ+AFb3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-09-06 at 18:20 +0200, Danilo Krummrich wrote:
> On Sun Sep 6, 2026 at 5:55 PM CEST, Markus Probst wrote:
> > @@ -200,10 +203,14 @@ extern "C" fn receive_buf_callback(
> >          // INVARIANT: `sdev` is valid for the duration of `receive_buf=
_callback()`.
> >          let sdev =3D unsafe { &*sdev.cast::<Device<device::BoundIntern=
al>>() };
> > =20
> > -        // SAFETY: `receive_buf_callback` is only ever called after a =
successful call to
> > -        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > -        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> > -        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<P=
rivateData<'_, T>>() };
> > +        // SAFETY:
> > +        // - `receive_buf_callback` is only ever called after a succes=
sful call to `probe_callback`,
> > +        //   hence it's guaranteed that `Device::set_drvdata()` has be=
en called and stored a
> > +        //   `Pin<KBox<PrivateData<'_, T>>>`.
> > +        // - `unbind_callback` calls `serdev_device_pause_rx` before a=
ccessing the driver data,
> > +        //   which guarantees that this function will not overlap with=
 it. Thus we have exclusive
> > +        //   access.
> > +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow_mut=
::<PrivateData<'_, T>>() };
>=20
> This would break the driver core's lifetime design. Any kind of registrat=
ion
> (such as class device, auxiliary, IRQ, etc.) may borrow fields from the b=
us
> device private data. The whole design is based on the guarantee that we n=
ever
> construct a mutable reference of the bus device private data.
Thanks for the info.

That explains why unbind doesn't provide a mutable reference on
platform drivers either.

I will drop the 2 patches in the next revision.

Thanks
- Markus Probst

--=-rnTpNxyRN/xwpGJ+AFb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqdpKkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS0FMP+wetPILltgePj1usw34G
G1LpNzCmHz5Zf9lWEu7r/zcmkY97jmpnWr8KzoZARisOm+eiJxkAi9FUkQe6s5B5
fnBQNDLyrLsqRj0a3z3pXhDzyKTXIaoMgSQ2m2f7yYpHS0yRfxWJGjdRd1PBNWyq
gwy1XrPXJDoRWtG9unaBoF83qGdm9AfCJxGv3gRzVTdB7Dqu0EIKLyBkuRwYh6gK
6kmA5/ZCLSnLTFCP10fCb/FBRy2kcvNM7QZZlXpyilOUpIO1IOMyTWibPWumF/pg
l31COrAHGxD2xZCM+z8b1ROwhgsz4UsVMHi8JYxS9/kHVDKq/L+rJn5oGte+X9CL
F7kBU2UB9AcOFW/+GdHzw4UfRnd+18cqWTUvEISbkbhKLgzik5ie4RZN/KgQIIGy
ousGkCFf0TT5N7HQf6R2/dvUernOBcMCBykpPo6udngT7ez7fmwA1lrm4Gh3BIQH
nRaxJ4b47/Z4ymjYy32LstfJqJYFX2vLsHVZUzqWz4RV372FUipSIL+/cTsc9hRU
n1sRWZnNrQ+psZVJTBj00b0R9dMSJEXa4s7fe9LMlFloUAeEN73yeC45U4J7b7LB
wViW2m9sJrYFArAQw0tQLLCSPAkJq5fQi5aYMFSifh1xS3PFYMMMP+QNghkhLSZw
15QMwoNXu0oqGSmxCo0mvrj0
=iM0o
-----END PGP SIGNATURE-----

--=-rnTpNxyRN/xwpGJ+AFb3--
