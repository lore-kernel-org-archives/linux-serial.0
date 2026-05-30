Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD034A3D9
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158611; cv=none; b=DLL2K9NlLcRToFcqQF3SO1ePv4+coTcRFPDu2lmUTM36YkF6MNYhEX0H45dDPurizdiqyXFljVJUqIhotaNbZVpsk3rNaetlJv/tIrk3fKUlKz7yLG7Hjs8VfyjFv/vdYsEGkeIf4165O5mVWX5OUArVDg0JK0wSbaskxgKJxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158611; c=relaxed/simple;
	bh=IzWwiXoNDJJYymeauA4VceeTQ7BsvJ5+IlCouBR83fs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XENNGE2tm8EIVtIphRUwCL9C8vMmDc28d8eWvKVzsLagxaYWuAXyc50VCZtYGkrq+EXcjoDveT+AEhJ3NTQqaGI1ZGYUqXykWoLZwWs6/u9tP4QOFQCKRheR6OMIB7z6rerGK0CYiNn+o579lly4KHXRWac0pW7GD1dPkErgI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=aFOrkf+6; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="aFOrkf+6"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B2006240028
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 18:30:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780158608; bh=IzWwiXoNDJJYymeauA4VceeTQ7BsvJ5+IlCouBR83fs=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=aFOrkf+6gVTszv4C85phxTXCt6KYLS5s6hYIUe3V4OFWYFygfLu8xrWbgMGDBg4JB
	 mGYk5vrYthqxIUCBsu0mE8MVYIvUqY42OUxz6pdzqZtPISKh1BvmokAy72h6PH2Jmq
	 Wb0GbGPGPZU9p/MCibM9ErBxYqHikey/f+V6iyKTiCtk7UcYlN6FfIh0ybTBXyiiZu
	 nfmjtMIpw2IbT/la7toVaOBTfHNDarJ22pKvhUEi45CqcttEt1QNseMN+Gf41OUKcR
	 /NBn25UIN8dOzNspF+UG0MtRASQ2qipuxlWgFJXmxUili3w5TG4BYD5lyAb90zemuh
	 0nUDbEXM3m6GA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gSQgJ6hFKz6tsb;
	Sat, 30 May 2026 18:30:04 +0200 (CEST)
Message-ID: <be835bce958c99e9623ea240b67282d3b429ae9f.camel@posteo.de>
Subject: Re: [PATCH v8 3/5] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>,
  Rob Herring <robh@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby	 <jirislaby@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo	 <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Kari
 Argillander <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng
 <boqun@kernel.org>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Date: Sat, 30 May 2026 16:30:07 +0000
In-Reply-To: <DIW5HXH3HYDB.17132XFBBDBJL@kernel.org>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
	 <20260530-rust_serdev-v8-3-2a95f1da22a7@posteo.de>
	 <DIW1B4FUIXO7.28GSUA0CEA4EV@kernel.org>
	 <4638946fc49a38797b716ea173c93327eb751479.camel@posteo.de>
	 <ad98dfb1d8469022519d37364e8a068bed3b5687.camel@posteo.de>
	 <888dc39c52bb6ddac1a1eed7876c4573bdbef002.camel@posteo.de>
	 <DIW2JUUL6A6J.96VI4IQN6HYU@kernel.org>
	 <55eae11ea68f129508d0f7e30ac457ba919812b2.camel@posteo.de>
	 <DIW34DX6BSUS.ANXBOP9687B0@kernel.org>
	 <25dc9a4bbde0b542abf608be1b3305f1421a4502.camel@posteo.de>
	 <DIW587AGXYCS.39MR1B4TVSO9@kernel.org>
	 <6e5fd4275c2bbaeeac95a0ad4fe15bb8237d6a22.camel@posteo.de>
	 <DIW5HXH3HYDB.17132XFBBDBJL@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-NdO1rLB0FIR+4lfpB0do"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-NdO1rLB0FIR+4lfpB0do
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 18:27 +0200, Danilo Krummrich wrote:
> On Sat May 30, 2026 at 6:23 PM CEST, Markus Probst wrote:
> > On Sat, 2026-05-30 at 18:14 +0200, Danilo Krummrich wrote:
> > > On Sat May 30, 2026 at 4:51 PM CEST, Markus Probst wrote:
> > > > On Sat, 2026-05-30 at 16:35 +0200, Danilo Krummrich wrote:
> > > > > On Sat May 30, 2026 at 4:27 PM CEST, Markus Probst wrote:
> > > > > > This would work, but I don't see how it would get rid of rust_p=
rivate_data in
> > > > > > this way. The device private data will but the private bus abst=
raction data
> > > > > > needs to outlive the devres callbacks (which is done by rust_pr=
ivate_data).
> > > > >=20
> > > > > Why? You only ever use it in the receive callback, which won't be=
 called after
> > > > > device unbind anymore.
> > > > Because the possibility exists that some classdev ops or Drop calls
> > > > e.g. sdev.set_baudrate. This is a null pointer dereference after
> > > > serdev_device_close has been called. I interpreted it to add a stat=
e to
> > > > the abstraction private data which would prevent those calls (early
> > > > return with error) after serdev_device_close has been called, but t=
his
> > > > would only work if it outlives these calls.
> > > >=20
> > > > But it seems you were refering to something else with the state?
> > >=20
> > > Yes, but I just notice that I'm a step ahead. With the lifetime model=
 class
> > > device registrations shouldn't be guarded with Devres anymore, but wi=
th a
> > > lifetime.
> > >=20
> > > (This also entirely eliminates the need for having different devres s=
tages to
> > > prevent drivers from smuggling a newly created Devres object into an =
existing
> > > Devres<Registration<T>>'s data, which would be unsound for obvious re=
asons.)
> > >=20
> > > With this there is no way there are still class device callbacks afte=
r the bus
> > > device private data has been dropped in the first place.
> > There would still be Drop, which can access the device.
> > Drop happens after remove_callback.
>=20
> But you control drop(), so can order it such that first the driver's bus =
device
> private data drops and after this the private data of the bus wrapping it=
 (which
> will also call serdev_device_close()).
Yes.

It seems I also have to rebase led then, as it currently uses Devres.

Thanks
- Markus Probst

>=20
> > Might be simpler for now: I can use a mutex to prevent calls in
> > receive_buf after remove_callback has been called.
> >=20
> > Thanks
> > - Markus Probst

--=-NdO1rLB0FIR+4lfpB0do
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmobEIsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSwTUP/RtLybkJjeY75/6rR1z6
v8gVJLIWXafyklqhLr59QOolNHCHs91NmxiU2mFhpPG8XoanZWH623iTArP0Aq+c
OXSbuZHZRVMW+5G0Sb9cVKllMFiR25QYcxhqGTkzE7jTThhwssN/8/3YrinlxBEm
Tk54A1tEfW2SCB1yrAEKiPojAsdfw0IAdQJZTV80wzbaTl7LSIKobuH4bNrqIt0k
fZ58XkOJMmeVzWPuRlh54kDfT9F8tuZkotA3GoaN/4nJDd6JuIZfhk6RFx+EnmAa
DduvV1uNgUdQfAcrcdHkFbGUzkgLsecY4WHdC9+ZgZgdKUSbI/m4D+c8W/9vhtQ4
29AckBCjrtU03XNym2UhFbvnv6aMoRyWzeb1gz6Kw7zYgHOBrn5lQlxDjG/MV5Ux
+OD8hgQLxNau/BZLgzGjuTaUTqeYUMiulI/MV/mcpotOxBYFR/zkfw3KunPIEKGN
cY5kSG5406v7HomI6Pua/UwzzHS4i8tv9Tu9eWD6q49NAwLL/mI4vI5VHiZVWXK8
1DYwCuHIAB0KQRv9xjAi4f49ZOtUTOrQ0mg0lphFMipxfDQN8l9WG15J6tV35VH2
pipnKvEhDaAQzyVjlIfQU8g1N/PFS3HFnE/+NgBd4a23dK1svUYp5aiOeY5X7mru
ZsERn7N+Q0bzGCMGor5YEpmQ
=XatZ
-----END PGP SIGNATURE-----

--=-NdO1rLB0FIR+4lfpB0do--
