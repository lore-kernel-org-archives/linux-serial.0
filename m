Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D80A34389F
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162669; cv=none; b=GAG3ZqhERqWmgqoMZDkED7e5uAfmJZ90JgJhLZhbUT9p39cZqQdcE81Rwrmj/7L8Iu92ZhZjFejuroZJ4icDasCI0mCUXKi3rOF1QQUSjnSQ+jzx6nnCPOeq3127LcZT/8uW+RhXXlhF3+2meYYHSuTTY7uGfq7bcthPJyMLSJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162669; c=relaxed/simple;
	bh=I9dHrQ7Rc3XErpRzI6Oi2nDfezCG3HUIDnem2tab4nA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGrj4qooQo8uNb16pdhZS+4xBqgfJNjwHkfEFGsJYCya1Ze5MrGxkib0SWFM/4rXTyedhRb0VJ5HH7NvSdfFEi5i8h52TYvlxMBapLsjVse13fgFfj1e9pblmIW3XNoVWl+HXS0AWk+RHOL1zHW/LtYm2iA0RJ2Gjb1ZFpfbVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=GTlXoWvN; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="GTlXoWvN"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id EF399240103
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 19:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780162663; bh=I9dHrQ7Rc3XErpRzI6Oi2nDfezCG3HUIDnem2tab4nA=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=GTlXoWvNminSy9Hx0l7m9kWX7/Pk0fob1ct9a5y8W6FtzrncJVfCQTtlLlOhQeUvn
	 KkH1oYIWTt+FRO3ZETYkoYA5jINUZrhB/1sTOOekbPYhJHsWW7iDYBT5X7HttKwhYm
	 Jiuxpw2jECtU/DwyQX6UQG7MiISqZ0UCvAt7SNCGzhzNsZ7KRNMDKgy8Gr0ZvVJY4F
	 YUJPIgPROL+RNGGG5TCBRGiAc731Lm6A/ZhdcVNubRxrCZrnBKrDeJEgEx9iyJui1r
	 EroHM0EpiORup3sV6bwz1PFw39Muib1M0f9oW1c4/Cuehkk6sz9KWc3CK0nRdbdhcX
	 T53749KyEwayQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gSS9K3rPrz6tsg;
	Sat, 30 May 2026 19:37:41 +0200 (CEST)
Message-ID: <471c6cc43213d47578a77e421f06648615ec8e9a.camel@posteo.de>
Subject: Re: [PATCH v8 1/5] rust: devres: return reference in
 `devres::register`
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>, Markus Probst via B4 Relay
	 <devnull+markus.probst.posteo.de@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel
 Ojeda	 <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Kari Argillander
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, 	linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, 	dri-devel@lists.freedesktop.org
Date: Sat, 30 May 2026 17:37:42 +0000
In-Reply-To: <DIVZPIJYZ244.26RVUD86YHX1N@kernel.org>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
	 <20260530-rust_serdev-v8-1-2a95f1da22a7@posteo.de>
	 <DIVZPIJYZ244.26RVUD86YHX1N@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-9OBkUSJ/Jd1TG2ob7uZa"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-9OBkUSJ/Jd1TG2ob7uZa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 13:54 +0200, Danilo Krummrich wrote:
> On Sat May 30, 2026 at 3:13 AM CEST, Markus Probst via B4 Relay wrote:
> > From: Markus Probst <markus.probst@posteo.de>
> >=20
> > Return the reference to the initialized data in the `devres::register`
> > function.
> >=20
> > This is needed in a following commit (rust: add basic serial device bus
> > abstractions).
> >=20
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
>=20
> For driver-core and DRM,
>=20
> Acked-by: Danilo Krummrich <dakr@kernel.org>
>=20
> This is useful in the context of the HRT work in general, should this ser=
ies not
> make it this cycle, please let me know, then I'm going to pick this throu=
gh the
> driver-core tree.
As discussed, rust_private_data is not needed anymore thus this patch
has been dropped. Feel free to pick it.

Thanks
- Markus Probst

--=-9OBkUSJ/Jd1TG2ob7uZa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmobIGUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSVI4P/jV1mRfcdTMEpRsvTDwa
B4eGd3WMfgHeIZ35HiBVWy/pMHBmW5dLcQwQ7nTvSH80dZOt9frHEAWIpDN2jcCM
PpxFI1cksJ+d3v6s6X3T7XchlTlSC/Rln/XGAOaENVoiPkQpiAJPl/uKJon9U8Px
SfO2+1ygqeyeXYQC4SSc0EeCI07tCHvEtYUJiO8zUcfvHAkzfbyevVdP/KCg93gx
Be044Awho+kOebnbfXXWAukDVXTbxpK5jQOCoVxyN5l5UZ0YUWJkThSlMQ8zAkbV
a7j+YW8AV3SCun4ufhMiIgq21q4BtGZx0VBZNGN1zNyX0XP7hDn3PC109Y06/LOx
7hq7ewLF/L6yFY3EnFVk7gHFdi/4iS0Gkord8lIx/AARy1MJhH2rMyqkpVa3M0CU
he/19ohfuQZ+D+XLydgNi61KFBlw2xoMt9fEUcAQChc2RtBF6YbahH2Ps7eHuO1p
Eyv3QaN56P3p5q1I9PNECDqI0REczp84qGnlwh1JRV1eD3w6VCBB+OQ9/7LNYI4W
S1woek9K8+bNWIE78N4QEFXv/piwxLClL2cH7/o0lhZM3IeEFzX6ZcOwq7EOJDxo
JMtrcy/usMRIRC5BRE7EY5pfaW+Ko0HnE+g/KCFwDgQHXZwjBykaCAaX5i3sVkmr
+GEyCPyXvpFS91VqloRYsd91
=PCBE
-----END PGP SIGNATURE-----

--=-9OBkUSJ/Jd1TG2ob7uZa--
