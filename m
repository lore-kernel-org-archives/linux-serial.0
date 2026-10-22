Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673142;
	b=VZmnkmF47CbTyJvMosuI7gygsquAxly4ZwAN5i7dmXKid9BJAaF5AAcamJoYPst7mr9q
	 OaQVZHVlScvdWq7+S1b158fFgHQbO1yGZHZT/A0T4PsAIQqI7xhrHBRFam1N4c5AnunVH
	 1pX/FgVq8sLxIpwpVSpkcUS36X+breEc0beZ9G3Ku3nJO7r7qzNKMLXoNbyl0zUGIQ48C
	 SQaZxd/tMqJAlBELZb7qNlS4inYBT/rRc5xaM8IIEou1jA3DNWYGEsCn/izIcCAXkbSx4
	 bbb3WCaBjfC1+dlVZsdFFMuD4J2hl/MdwB0UVtsBh6Esj4WM60oESO2fnE5MLcAy/zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673142;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=XGF7pRFJchGOCc/iFyNZJkOvNkfIZAEVyF0cd97Z9Lg=;
	b=cnyYUwoFcZFQyR7qWugCXdAKJvC2H4xfL8VYBD4Y5JUaNUYAQHdaEC7EGshVYXYc6NS/
	 MNPWiuREFT1CyU/dgcWBl8YV8Gf0SziUogxlrcS1UBfpzg1BG9uJ7pFLWzI5+fM9o+ZjP
	 IHliEll9Okx73RsdDiBqpxvjANiPswkbGyELkMVmVh5d73NL4vV0gRR38DPHlVaQ1qiP9
	 tzP5PTDnxONqUIQvzLNCgZ9ie1f8kQog8qQpPAI2LdXpGPd7zHpDUF7pCKubtinszGVqs
	 tSIm+o9wFSWeCc5gf+j91Hn8EFDf51ytYFchrlMZj17s8z5K1Vc0O/kNsYWegqePJbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=ZhNnmXrm;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC4606A31A
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EAC4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=ZhNnmXrm
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BC910240107
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 14:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792673138;
	bh=XGF7pRFJchGOCc/iFyNZJkOvNkfIZAEVyF0cd97Z9Lg=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=ZhNnmXrmIaw5JPd9E3pb2QsRiVGPq0W+llx7xHu7LIlwJiidSjj1ZJVEotdl0qREV
	 8AQdQT4YXqysxLVzRyIFef3bgcfGZtCd26GxAX3g9TUVL5M2f+piHLYm/1Xee/YUtJ
	 gTidHlFKF1fM1rGePQ+4moylDP0lgZzpRencFj7o89QV9mV4nf9FneZatDE/WXJA8A
	 1+5woHq8EbowAm8jeGc9iQvkHbNUC1SI7CF97oZXwwUJWBDg5lR86P15TPBSQsJFxf
	 sLd6hg+PeFmv+cgir4dLpXCTtqq/fMIhlDc6p62MsmEZsmGsItaRKCjRLUzjXAsZxk
	 QVQXsdwCzp1LA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j9QqL4Rj5z9rxG;
	Thu, 22 Oct 2026 14:45:34 +0200 (CEST)
Message-ID: <c7b9e8ccbf41410a5ac13fc4d78104e595a5fbbd.camel@posteo.de>
Subject: Re: [PATCH v4 1/4] tty: serdev: Add mutex lock
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo	 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Eric Biggers	
 <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Lorenzo Stoakes	
 <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"	
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Jiri Slaby	
 <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev
Date: Thu, 22 Oct 2026 12:45:37 +0000
In-Reply-To: <2026101758-confidant-comprised-e1c0@gregkh>
References: 
	<20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de>
	 <20261016-rust_serdev_probe_refactor-v4-1-46832e034757@posteo.de>
	 <2026101758-confidant-comprised-e1c0@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-SSwWWVnFuWrg0GMbs44o"
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


--=-SSwWWVnFuWrg0GMbs44o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-10-17 at 09:53 +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 16, 2026 at 06:00:32PM +0000, Markus Probst wrote:
> > Besides more predictable behaviour, this allows for several hardened
> > behaviour changes:
> >=20
> > Return -EALREADY in `serdev_device_open` if the device is already open
> > instead of causing undefined behaviour.
> >=20
> > Allow calling `serdev_device_close`, even if the device is already
> > closed instead of causing a null pointer dereference.
> >=20
> > If the device is left open by the driver after remove, close it and war=
n
> > instead of leaving it in a invalid state.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  drivers/tty/serdev/core.c           | 10 +++++---
> >  drivers/tty/serdev/serdev-ttyport.c | 46 +++++++++++++++++++++++++++++=
++------
> >  include/linux/serdev.h              |  2 +-
> >  3 files changed, 47 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 7500efcdfc21..77e8e1d4d2a6 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -142,6 +142,11 @@ void serdev_device_remove(struct serdev_device *se=
rdev)
> >  	struct serdev_controller *ctrl =3D serdev->ctrl;
> > =20
> >  	device_unregister(&serdev->dev);
> > +
> > +	/* Warn if driver did not close the serial device. */
> > +	if (ctrl->ops->close && WARN_ON(ctrl->ops->close(ctrl)))
>=20
> I understand the want to give a big "splat" if this happens, but if it
> does somehow, you just crashed the box due to panic-on-warn, which will
> result in a CVE being given :)
>=20
> So, if this ever can happen, we should recover like you do:
>=20
> > +		pm_runtime_put(&ctrl->dev);
>=20
> And you can warn about it in the kernel log, but just not with WARN_ON()
> please.
To be honest, I forgot about this review and sent v5 without taking it
into account.


Anyway, I looked into documentation.

"WARN*() is intended for unexpected, this-should-never-happen
situations. [...] However, the existence of panic_on_warn users is not
a valid reason to avoid the judicious use WARN*()." [1]

I think this is a valid case.

It is an event that should never happen, and it might cause a use-
after-free vulnerability on data reception.

Thanks
- Markus Probst

[1] https://docs.kernel.org/process/coding-style.html


>=20
> thanks,
>=20
> greg k-h

--=-SSwWWVnFuWrg0GMbs44o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmraBW4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSwncP/iqL6bpaPmb2KVjSz1X8
p358eOolNLI70BYGrtESeG/h0huOgPn5p8TuhIP5tBKy5n69GkmlbEiF5yKhc8YE
2GRpyGQ+w8ZjlWrM40hxB+HHTrlduJmUJDSJJgm7c18H/hsqkslQz4348XpyBAjj
Lg0OBumSzX7CMqwRlfbxzFC3ec/owCuavuNfj246WBij1yUlR7TPAsZOoovEvx27
aWN+tiQQODux5Fzgi9c2l+FHVJTipUJms1HS1z2Vs4oY6TN85fazkxUHqdvYoj/4
19+cmqeBcyrNqVk03YKDieYfR55eMpJsOuW+b+Y7aIBhhqJDVwQsCSGjGOBtFJGe
nycaPLRb1Ex46Lm/1Fydpk042CcLuDwY5AqbP2N6f33cNtIZjmlTDLAG5nXZbqDh
ulff8KixN4ODX65YGTWVdaT9SvM7UA49fq/Zt9o8ZU6HSHzZF5eWl1CV5yf9Lqm6
QfbUdNFoClwH6ctJ2w/gU+uwaYvWPLpc5ynUJZA56Y7RpkyMfbn00qLnhf35RkzF
S7swLkYBcKB9oIe4RjSaJdXkvEDjbGPNXb2Q/kMdq9qM14ZYFtXzJEOU9v8ZYlsz
NL/GpKAhFFPlpyXuT7z41ae27X06Vjl5VWhjK9Nn/F/Q+VgHQT/rSrXeJVkz6HPF
W0Zp6OLY3R0kDvrRE457NGNW
=LcdA
-----END PGP SIGNATURE-----

--=-SSwWWVnFuWrg0GMbs44o--
