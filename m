Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FBE344DBD
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173099; cv=none; b=pkXOiM5Yf9nxOx50SoCi6ARfyqWrHuUG/c6gvuxM7tJ+9KPEwjIZXcRwb5RqZrCWfBJkQlV/wV3cgsME6svWNTcgTjhxC63Lh69j4YIM7rWs2YZ8b9Tjz/cxey1UIIelRgnLnyyPHrA/eJVO2h9VaLUsGQDlTJmRHs9CcginFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173099; c=relaxed/simple;
	bh=AG9aR9Ik9FEYjKL2E/CM0XsegQw4UuybAOzFvpg+07Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7eTt0rIzRFWvoE0XfHfG/ZpZzmWn0FZAcmH2jWACepOHg0RHHfb21Nbb3uqQNAlJQS/Gx63ZzEefQQMjt8fNUiihTwGh+NXAjFXPAm/Si6WV0gVhdwI6TWODOSrwZOfoy2iQSQeKiA8iVb0HwYgyNwFpDLuTLHaRse5IUjCVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gl2ZZlrX; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gl2ZZlrX"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id EBADB240103
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 22:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780173093; bh=AG9aR9Ik9FEYjKL2E/CM0XsegQw4UuybAOzFvpg+07Y=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=gl2ZZlrXxWUFFLC62LJzlD+PtJ7IHTynsmdTgIVkaBwVHPNa2abvP66WT/kiO5nbH
	 TTJqgoAlWiIk928rjgVK8gwpq0eRaAF9m290ggzwcmDcBZhBMebSyE6ZN1zAl28maX
	 aL/3h+zytvo8ft5mFCQJMm4/CcLkA3emL0bTUEZhuZKWV9DLXlAdVyMHiXAmY5ceTN
	 mrBpHVI+f+4WpJ/zmknYMF/J8S7K/aChg6+Zopq1DP1Ru20i2v27Y++QQp9c7iWiRO
	 +NDVmHerKJwTP7/cx8nkxSq5552n9A93T/G/bEDO5kFHxUp26Iq/OEcCP7QMllO+2F
	 9tlXHudTN0OMQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gSX1t5TSCz9rxD;
	Sat, 30 May 2026 22:31:30 +0200 (CEST)
Message-ID: <aaf88d7fc2168c3ef893713b0643c4132bec1da3.camel@posteo.de>
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
Date: Sat, 30 May 2026 20:31:33 +0000
In-Reply-To: <DIW9Q5GVC0H2.2BEOWKL02AMWA@kernel.org>
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
	 <01e20401845ce5eab5731698ca8a0f8f44ed3eb9.camel@posteo.de>
	 <DIW9Q5GVC0H2.2BEOWKL02AMWA@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-J3TBuACv418SR6WDzXVz"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-J3TBuACv418SR6WDzXVz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 21:45 +0200, Danilo Krummrich wrote:
> On Sat May 30, 2026 at 8:55 PM CEST, Markus Probst wrote:
> > pin-init doesn't have enum support yet, so at least in my driver devres=
 is
> > still required for now.
>=20
> Hm...how is this related to having a registration type that takes a lifet=
ime
> rather than a registration type being wrapped in Devres?
In order to register "optional" devices, the driver currently uses
devres::register.

I just released I could use KBox for this.

Thanks
- Markus Probst

--=-J3TBuACv418SR6WDzXVz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmobSSIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSt5UP/2PmXPIgSpVqQB/no6Fz
p/Iagp0FLXfZ3ySm55ul1b0mbJ2APGd1BpYmFesZ15UNxcRT1qxPN0S/FIbcA7l1
antRg1GsUDGhZq10vZHGu0WzkSSsarXDPPSMTuUyNRDKW5QpeHPFaW8tnh00YLWE
lyHc2I2zufDaUYgasDzGGYkdoLJju2CUvxveor53NRadOR0oeucWJBdbYbaoLu/8
0712ydGGYVhYm59oDy/PDSj5+z4u32x6ZWzlE1mNn+i2hlbbqilv/2NgjSRpOWpG
trYW5Xx/QLwRTti0vq6yOQL+EUJoPrSLpuYWYR+0F07cgwHvPYXZ7UqRXO7loCF+
IdF+4cD2UlVA/9disdoaHJHo1OD7mB4mWSh9gj0FXU3CBZqOnyD5jfrsPdA6mg8q
Zd993cDLWgfb6Q5q2cm5lPvDFhDfFabUbNX84e9n+jLztu64U863ulywOENyFEWK
OssV59alQL+Lp9/gZetN/uUzSfN3ygJnm89uDICvDNkHaOTihjBTzUnRWqjzpf1Y
O2aAQceHHp6doheK4/k2/aLvxNDLNVgfi1kK4dVHRc5lENC3RABpGibCGHkYZ211
OxzpKve03QPyXtZK8PRy5tYK7vytMQ35BmOUa70rb4CsJkoWdSrL8o7ekO53Z3Z3
IxTXi+fNX+zoYVu3VUSczwAE
=Ev/m
-----END PGP SIGNATURE-----

--=-J3TBuACv418SR6WDzXVz--
