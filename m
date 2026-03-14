Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926B288D6
	for <linux-serial@vger.kernel.org>; Sat, 14 Mar 2026 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773488526; cv=none; b=q8zuMuRHwV6rq1d8ISCgx3jENZQnHiU4JupX0iYY5t5MHB8KPZbp/v50cPMFACjr2rT+EPbOvOWeJHqOV6fDYy9pNm+nioPrlx/WxChVDqdO+SOVcjT/XFzh1Ev1LdBZza5l5i+dXzQUvTcrhlfa1dqVHLg70zq6phSYUWDJZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773488526; c=relaxed/simple;
	bh=4km8dCKXBGzirqg1GhM7rfpMT9QUazVAipZnrBjHiBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PguDfS9tpakvryqYkiyjO0DTD2wXt2eKuhra0LXeg/gC5nqQBAvu1ZP5tsUQxTUWL12F3Kli5QCGQHwFqwOVRZR0B4VQaMl89hycVCYnhQZadCJMVDt8c7764ol5rEdZi8BFpjVfRalVQkT8M3SwhkgEJbiZCkcLuuhxrhokTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=eVny/CGI; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="eVny/CGI"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 39704240028
	for <linux-serial@vger.kernel.org>; Sat, 14 Mar 2026 12:42:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1773488523; bh=wuP7aGFXaCoi0Qj9e0TOENROxQfNcb8qbW4/sLW+2MA=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=eVny/CGIImF8jH8O0FIZKcN4zAb274dFEU7yPs677sQjMepqSt/RUW83YjX+qB7Qr
	 H5/XMYTx9dp1t51PclxmWw1tn/Tr3yV1pJX/AJC4G32q5/iqEthVYjiIvB3SfEzlhG
	 6Fl4NNkKQqC6w8NEpVTB/N+x7TNODppf+nzOreinRB+JvxSLIxxYbVjsUhq5+jIdeV
	 ADYAPMYTRKaPT9fXDbIntJXEUTsStWos57nrbS+VayXpXM+sdJjuZ+cnL8lvlKPYl9
	 FLhxEx3aH5ty0NZ3c6nNLtplG1VRKHQzKwzzPYPgnwKJONXgYX8LxhsaEaarRHCcxE
	 wbQOvj4X8CBFg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fXzwR5X5Nz6tvm;
	Sat, 14 Mar 2026 12:41:59 +0100 (CET)
Message-ID: <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
Subject: Re: [PATCH v3 2/4] serdev: add rust private data to serdev_device
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Kari Argillander	
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>,
 David Airlie <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Date: Sat, 14 Mar 2026 11:42:02 +0000
In-Reply-To: <2026031402-absence-graph-af5d@gregkh>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
	 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
	 <2026031402-absence-graph-af5d@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-I1iRCfX0MpbeR/VGtPiF"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-I1iRCfX0MpbeR/VGtPiF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-03-14 at 09:07 +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 13, 2026 at 06:12:31PM +0000, Markus Probst wrote:
> > Add rust private data to `struct serdev_device`, as it is required by t=
he
> > rust abstraction added in the following commit
> > (rust: add basic serial device bus abstractions).
>=20
> why is rust "special" here?  What's wrong with the existing private
> pointer in this structure?  Why must we add another one?
Because in rust, the device drvdata will be set after probe has run. In
serdev, once the device has been opened, it can receive data. It must
be opened either inside probe or before probe, because it can only be
configured (baudrate, flow control etc.) and data written to after it
has been opened. Because it can receive data before drvdata has been
set yet, we need to ensure it waits on data receival for the probe to
be finished. Otherwise this would be a null pointer dereference. To do
this, we need to store a `Completion` for it to wait and a `bool` in
case the probe exits with an error. We cannot store this data in the
device drvdata, because this is where the drivers drvdata goes. We also
cannot create a wrapper of the drivers drvdata, because
`Device::drvdata::<T>()` would always fail in that case. That is why we
need a "rust_private_data" for this abstraction to store the
`Completion` and `bool`.

Thanks
- Markus Probst

>=20
> thanks,
>=20
> greg k-h

--=-I1iRCfX0MpbeR/VGtPiF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmm1SXgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPS9jAP/3JGU2gk+hFkYnBUk8UU
iP1lJJDruz2fV0dXxGHCh3svfkHvcKFTtozb6FSQ7hZ9wNU8tsxTfnqMhycvmf6S
J3NpCtL/ifnjtIWpy6qq0xk89BLrEU0EglsQ5tLN+BAY0Nkxsa1e7bvw461ZFEPF
xzVwh8hAucFdEZuVt7O6ouZ0CIryYmM6MK2BSnjA5yo+vMlS560JtDh2rQFuilrd
zzbOBhpbxlIxRGVHg5WdiTT07kgm6zr+uHehF4GQmyYH6Z7KvNOHRRFA8FUYUes0
cRZjsxmeMzE/7EU4lshWDN6AYprhE8CHDNxEJd05aFMATuWpOKB82SCyC1qKQdE+
EGdLS2lcUUl5yRXXRFl6+VjfrvaZo7IrwhE8i1Akbp2kXqZbn5R2kADaQ1RIDt/Z
AvDz9Af8HhqJF3wwUrtlameo6UyKl/AOAWK6QQzjTyk9/8LXmA1lfHiSZr7waTxf
6zE39ALkP5vaBNjDbljj01OkoPR9NNjbaZZ3O2WKy9656HWDVofGnISWq9L++lXO
FtGVAQGxPETFtqjA81aFVchaYtskooLtA2VuAnnuoEJok6hqYTUCgSdijOi/rEJW
k6THWQDqZ9kM5F/oxvn1a3h2jAosCbISp/lXkKGlUiOcGrlc0D3UjVC641JaOHYD
9U2DU5EH/6+xscOpnN2O1gvc
=2BtH
-----END PGP SIGNATURE-----

--=-I1iRCfX0MpbeR/VGtPiF--
