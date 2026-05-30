Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FF30E85C
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780152674; cv=none; b=WNioj8PV/mYMxvtVcNzSnlJWw5Pa50Lv9pn4v/fTJKWZtECv23Iu0WnzO34WFGjs40c/Hh1s+2eEtVkqAogUHO66J2XSz5LKq4ws67Ur06FDctTcPcDVZPLYFTFk0/2xamCUczJsK0yX1bjSxtkrO+SO+JTqX0P4VVkmKaOxE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780152674; c=relaxed/simple;
	bh=c74Z1x043Et3TQX+MoViRwCZ4obG/OH1QunVOaMGM30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAt6vp+PdyUlNTOEO6GHRz93PLnBn5S6soB3Tyu8xKAaFMTcNpm9TIM7UCTDc7RNOQSoU6xu8GtqvpYeltFRxDOmi/gM86qODQ4nJHcMMsRFx6IH7b7j282rtqGAW/2RMQg6Vgk0cxDXvXvjroT66RDgYZVFGszDsC8nOuvIexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=BVwPrvPU; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="BVwPrvPU"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6ABBF24002B
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 16:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780152671; bh=c74Z1x043Et3TQX+MoViRwCZ4obG/OH1QunVOaMGM30=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=BVwPrvPUXK1tBj2AqSn8E/Xg+VRtaHaWGpyADSEWBSOgVeDdZxJ3lAvVPOqUtu86F
	 e9RTrwMpJFGT3kD1B5RfreZTWyPkBbKHE9L7nqC1o/R6PpH2XTC+nJxqCI1MQzTPqg
	 ZTSvzt306TswsW3yuLQFdjGftC61uiNdZ8aRIa2n74BFqQWtIeRcaWNbO7XLxOCMTN
	 +fJJrpcXsjVFXk1IIcw+562y9x0M/1QVcEnvH2AQtgZUkNIl85LZy8bG4O+Z/qbhc+
	 RN7JZvd79ULFpOdIZwbq14N9orGZn4tVjtIYALWzz7w4BAUBj52OlMlF0c1ApxtH/O
	 61A3MMDbyrDWA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gSNT90H1gz6tvm;
	Sat, 30 May 2026 16:51:09 +0200 (CEST)
Message-ID: <25dc9a4bbde0b542abf608be1b3305f1421a4502.camel@posteo.de>
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
Date: Sat, 30 May 2026 14:51:10 +0000
In-Reply-To: <DIW34DX6BSUS.ANXBOP9687B0@kernel.org>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
	 <20260530-rust_serdev-v8-3-2a95f1da22a7@posteo.de>
	 <DIW1B4FUIXO7.28GSUA0CEA4EV@kernel.org>
	 <4638946fc49a38797b716ea173c93327eb751479.camel@posteo.de>
	 <ad98dfb1d8469022519d37364e8a068bed3b5687.camel@posteo.de>
	 <888dc39c52bb6ddac1a1eed7876c4573bdbef002.camel@posteo.de>
	 <DIW2JUUL6A6J.96VI4IQN6HYU@kernel.org>
	 <55eae11ea68f129508d0f7e30ac457ba919812b2.camel@posteo.de>
	 <DIW34DX6BSUS.ANXBOP9687B0@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-RREjNt8d6m6oU7o3V6DC"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-RREjNt8d6m6oU7o3V6DC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 16:35 +0200, Danilo Krummrich wrote:
> On Sat May 30, 2026 at 4:27 PM CEST, Markus Probst wrote:
> > This would work, but I don't see how it would get rid of rust_private_d=
ata in
> > this way. The device private data will but the private bus abstraction =
data
> > needs to outlive the devres callbacks (which is done by rust_private_da=
ta).
>=20
> Why? You only ever use it in the receive callback, which won't be called =
after
> device unbind anymore.
Because the possibility exists that some classdev ops or Drop calls
e.g. sdev.set_baudrate. This is a null pointer dereference after
serdev_device_close has been called. I interpreted it to add a state to
the abstraction private data which would prevent those calls (early
return with error) after serdev_device_close has been called, but this
would only work if it outlives these calls.

But it seems you were refering to something else with the state?

Thanks
- Markus Probst

--=-RREjNt8d6m6oU7o3V6DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmoa+VQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSeZ4P+wRkq8a1IpMyeEEEvu7o
x/r5XDd8K2uCjyPkXw834aNdxCL4nbvqjmaLXVoL7mlJaKEaT5Kl1/HEItxx6IE0
QSODPfb9vh4RE/W810qD9INUEgQv6NDQJyIDDHFos2+FLM1Ntqbr3ruCdR4dvJbq
AWz//ZztPoWio4HT+MK5MckA9u5cctDN7Jr/lD7CHTlwPL2YIwPid2sONd+FqEG3
bikQTYJKLQmYhi3JMk8dAY9TjlhpFYnFKssAZMKrZmT/kEBXwqyTpFO8z8Z4heHv
9mttXOW1cd8H3YNQE3HbNH2NETTOhm8cvJTrs9UihlsysKtyFT6FUf5PdzrOTmrt
33Fk+kZGvxeQod7Y7PkQSFWnuqUk1bt5DOP49r4Jxr4PQopJ51BCnCnUNBBkcnvS
XJC7rkqUU4ysOGCJD17HkfxzhRzqluuWMQl7gLGJTVZ2srM1KjrJKIWzz+zpLYKO
CU+gkcWhDRwaok6RmWkigZmMxW9jEC7FQtGOhwiGIAeWESEAk69BDBwWjQHvN8I2
XOP+rxZ3cQdYxMPyAoeiHegXI3SlbKgA/1Yq0o8/oZeUYkpra4Su/U1yNxOJsWHz
QI2PtPTkzcg7LObB/NvFYh12cH2Wpn+TZ60X3e1XKqHrLYFeXYvilQDZQ66lXTZU
m1h6PAVxUq2Kt91/c+WFlVSv
=OFZm
-----END PGP SIGNATURE-----

--=-RREjNt8d6m6oU7o3V6DC--
