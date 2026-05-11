Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1140149A
	for <linux-serial@vger.kernel.org>; Mon, 11 May 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511281; cv=none; b=HE8r4L2m9yJLgd78uZvcQwfTUSO9N8KldBZpyLvDVXU+L2TYbGR3ZvvRF8eyNvVDvHfEjrw6A6mhcYmbXm64haveMFnpRq7Uc8V8lVWg6FUmgF/ZvsCkReOfqCN1DbVlp7yBqHM57qtaC+gyLVdgp31SgJKiaQjsFXlkqZhB0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511281; c=relaxed/simple;
	bh=TpIGitQPS+l65xYL29D0NyyGS06BiAlFP4avKJ2ywDI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n07fUvMiXwt/pzfxSnujD9QF+htld1trqERZEUBXUbirzN9XNvK9Y/s2A4oXsxvLsgc5htbHiMNJFg+5jJEPlMUMmN+Mb90LoV2vaS/ly0WrVAYgTNgQ9qTCQwaHT39dC4YOcAWiHtKrYaYpqsPkzc+ckEdEHeRrlLD1janV6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=kWB32BFY; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="kWB32BFY"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 49E34240101
	for <linux-serial@vger.kernel.org>; Mon, 11 May 2026 16:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1778511266; bh=TpIGitQPS+l65xYL29D0NyyGS06BiAlFP4avKJ2ywDI=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=kWB32BFYEZB5xfowoDcFJ4+p6qFeUCM8ebf9+DchWTBMq9DTQNAZWEnfk7a8mIb5R
	 iCQJzcv/24M6C8ZcJhXwd/sDjBbdqnqucWJQ0Gbo/sUom2o4yLC+m8ZAPL7+/zkQKM
	 Ca60rMnHwtNr8upgrb6+BmTBb5UnOGuwQEnZ3bCbdSxI0KB+mHxpXnlx6sQnm1Buxq
	 VwApVz7zePq/y59H24i6Ixf2jwPYtgaOi0JItSUQvZPoN9agSnZWlQbrqubDOrYdh7
	 TuzYJuqZZKeELlck6F3Qii8lGN+S3T89XEQPDMyL7REEnQ+1VLFvYJ7hI91jj5yUAU
	 eTqRyUaMyS5Xw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gDjRf30nYz9rxF;
	Mon, 11 May 2026 16:54:22 +0200 (CEST)
Message-ID: <da85ceb81f51079d4a8248a1ffde6a27d2ef24ad.camel@posteo.de>
Subject: Re: [PATCH v7 0/4] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby	
 <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo	
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Kari
 Argillander	 <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng
 <boqun@kernel.org>, David Airlie <airlied@gmail.com>,  Simona Vetter
 <simona@ffwll.ch>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	rust-for-linux@vger.kernel.org,
 linux-pm@vger.kernel.org, 	driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Date: Mon, 11 May 2026 14:54:25 +0000
In-Reply-To: <20260430195858.GA1650658-robh@kernel.org>
References: <20260429-rust_serdev-v7-0-0d89c791b5c8@posteo.de>
	 <20260430195858.GA1650658-robh@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-hDVNd50c7cn2pQHHfTMl"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-hDVNd50c7cn2pQHHfTMl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-04-30 at 14:58 -0500, Rob Herring wrote:
> On Wed, Apr 29, 2026 at 08:21:30PM +0200, Markus Probst wrote:
> > This patch series adds the serdev device bus rust abstraction into the
> > kernel.
> >=20
> > This abstraction will be used by a driver,
> > which targets the MCU devices in Synology devices.
> >=20
> > Kari Argillander also messaged me, stating that he wants to write a
> > watchdog driver with this abstraction (needing initial device data).
> >=20
> > @Rob: Are you willing to maintain these rust abstractions yourself,
> > as you are the expert on this subsystem, otherwise I would take care of
> > it with a "SERIAL DEVICE BUS [RUST]" section in the MAINTAINERS file. I=
n
> > the second case, I assume you are going to pick those patches as-is int=
o
> > your tree, after they have been reviewed?
>=20
> Well I can ignore the Rust part as much as I ignore the C serdev part...=
=20
> Honestly, I need to find someone else to maintain all of it as I don't=
=20
> really have the bandwidth. I don't think we should split it though.
I could maintain both C and Rust.

However my knowledge regarding the tty subsystem is very limited, so I
would need to heavily rely on kernel documentation.

Thanks
- Markus Probst

>=20
> And I don't have a tree for serdev. Greg picks up the serdev patches. If=
=20
> the Rust folks are fine with them, then I am.


>=20
> Rob

--=-hDVNd50c7cn2pQHHfTMl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmoB7X0bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPST9IP/0MZdTYVvpOx0BsQaHF/
+frOQadjjWHu49gobdboY7cKhmmHlYUzlKDGDFSvsqHXbq5LUjYgierU42jMZ0wC
lMMApEvlGrMJstar62HcHgaA586CD2zxRMTrGfFu+1y93GlSYHU7KS9CuIy6BvK4
pmP3Q4LP2PGbG7TCd2hso5MIl351mMBkMKuaPICFxyfviQvVeYE5TVK7AL792VvV
FLnCv87PRvDZ/GRfZKyvx+E1KG7Yfu1XGoob1/1h6ifw7wNQ+bIjvx3+vtKNOjrF
pt/JYgijkOuJBsQDWnz5wI0Qv96YTBHgEt87BvnQjxthuur0b2oPQgeZ6fen4w3X
Z9DAIyNEpklHULovuoR0DOkJ5qRyrwGx7VjOBtPlq/yGTkQPPlZ2u8Q9zf6UicCM
Y5DXZQL4F/n6i6HmZmm9tcC3sW++HBkgDaETFz/XfWX+Yrk6aze4ChGklIZO96WW
a5UQiG0ytULXxAUzWAI4lcVArdZeJx7h1Iu4U5e1sgCezo5HBsC5gyk20L5hq1z1
K2pEJEiS7YREaFvjMP9K65CQT74f3nzfwFiCfn/1IuzMd/Pu8QOPaJjBFJahjjwJ
ljerP8O6cJkTFNw0fySmiaCPk9wSQBpOnG/gDiHfAHKbfpNwrRFHjwBe3767/dl/
p7Vjc23uIYaww2yo6lXSOos/
=AJzm
-----END PGP SIGNATURE-----

--=-hDVNd50c7cn2pQHHfTMl--
