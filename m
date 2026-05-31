Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58741D54FA
	for <linux-serial@vger.kernel.org>; Sun, 31 May 2026 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780264866; cv=none; b=OG/In5iANcNwi1Cto+cphh96tAB9BrHc3VdxMj80Dv4U6zAnJx1HskZcxTeBCFvO4M/eAlC68V2iPtk1Em5AUjcW0Lvf2zj8M40jYD/94D7Hkz75GA5NlNglXEMwYbsN/BtjgEYBVj2PqVFsSvGiC05Z/amDzRNT7BO+IRs0JZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780264866; c=relaxed/simple;
	bh=cw7SuGmUUtz7Kl1motq+vhpCvWeJlxpaavxYphPtzDU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pAxAlcAe3CzRgEyszDIOY0XfT1hXHu6MAJi5Aw6bTl3jKMZp15OxUZ9Np7AU21Msf2D9sQKRcVBOKUcTw8dZbVTKr0FHXj+UZOMNEyLDsbidkbrf1O5icn5HjfpEAsBqZ66ZUB2Nn+eczP3oFYWLnoBPV9tCIT2CzSY7OX9NhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ZzwRrKD4; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ZzwRrKD4"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 78FBF240028
	for <linux-serial@vger.kernel.org>; Mon,  1 Jun 2026 00:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780264863; bh=cw7SuGmUUtz7Kl1motq+vhpCvWeJlxpaavxYphPtzDU=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=ZzwRrKD4jwvjM/v1LGBou9hGgXq2kU5EOGaBJYDsDPWJsulGnVEbSu26Cqtg7CYyM
	 cNMF838tlmZ4Vg6qP0SP1eXjvwaDnUVixLGllb+Xuqkc3uffXUWO/S1phQmwyeLrEx
	 wfKtSH6omIXIdECG6jDPC2Ur1n1lgOWHTU8cijQD+p9FsEKFIdhzHXZj5qAXbjDQeJ
	 5KIT0IF+Is18aCKNTySS6pGgLNLah8mW45lKC9Mr468zCUb0nUkiKv1fIpnvBJewX7
	 BPHcpRz9G6j4+oMfQ1u6dpRqm+VKGKlj0SATSK2a7KXkdJx8q8yX4LpElecAD5BPhx
	 Tt3/Dz0NgYdIw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gT9yX2DYLz6v3p;
	Mon,  1 Jun 2026 00:00:52 +0200 (CEST)
Message-ID: <7c30276759aaba8127275e602cb78783ec33bbe9.camel@posteo.de>
Subject: Re: [PATCH v11 1/3] rust: add basic serial device bus abstractions
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
Date: Sun, 31 May 2026 22:00:54 +0000
In-Reply-To: <DIX6YVWRDL67.3TXDMTAMASCVZ@kernel.org>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
	 <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de>
	 <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
	 <12fa6237168ecf6dc65ebf46118beeb5c51f3d1c.camel@posteo.de>
	 <DIX6YVWRDL67.3TXDMTAMASCVZ@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-uBVcWHTLCDJlFvAW7yIN"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-uBVcWHTLCDJlFvAW7yIN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-05-31 at 23:49 +0200, Danilo Krummrich wrote:
> On Sun May 31, 2026 at 9:42 PM CEST, Markus Probst wrote:
> > I just noticed, is it even possible to use SRCU here? Currently the mut=
ex not
> > only ensures that no drvdata access happens after drvdata drop, but als=
o that
> > the receive_buf waits for the probe to complete, as the drvdata hasn't =
been
> > initialized yet.
>=20
> Yeah, if you drop the completion, you need the mutex.
Is the performance impact on an mutex or on srcu + completion higher?

>=20
> (In case it wasn't discussed in previous versions already, there is also =
the
> option to just attach separate private data to the receive callback, whic=
h would
> avoid this synchonization problem in the first place.
>=20
> You could have serdev::Device<Core>::open(), which takes its own private =
data
> and a corresponding close(), this way you'd allow drivers to control whet=
her
> they want the serial line "open" or not. You just need to make sure it is=
 closed
> eventually.)
This would add complexity with types, as we need to ensure that write,
set_baudrate, set_parity etc. does not run when closed.
>=20
> That said, I don't know what turns out to be the better approach. And may=
be it
> simply isn't something this initial series has to tackle? I think your dr=
iver
> does not implement the receive callback?
The initial driver with only leds: no.

That changes once the driver also takes care of hwmon (ADC sensor and
fan failure) and input (power button and possibly other buttons).

Thanks
- Markus Probst

--=-uBVcWHTLCDJlFvAW7yIN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmocr4wbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSDloP/i5cj/y4hJYdAj3PLaRA
SO2PB7uyThh7YoEfyWXRIR/2qrAF1eZwc/1nHpEnwvFBH2VB3lF4imS/YIWkQRg9
86hBFLnuQhYWKzN25Pt8PHNduUT6oysTeGmu8gW7E6pOEvFeP7r51y5l/D4fE0tX
ieEnqWfOVAqKHmngIEwCBWvzNTuZwjFVmhysLS7QtnYdfqtjVOseE8560qnpq5nU
jJhjlNK9SAEvkrEulEV016PfFhyvy7LxvfOTF1K39/gc0jwPB7fVTPyNkVa0UYJH
bHqQaT7w+nixNiuW90IzkuAeN8djGroE7F6jwFG25xHqaXhpb7ll2t4cZHvePNA1
XaotnSTCIc4Jwrtfxz5UVzuBheEQcZoop2pFRQTD0saOEIxJzaBy3aSXZ9fpc2RZ
hkzkqeSoUxiR81n3iZ0iUnZBF/XxOOaj6uoVxt/4V9xCeBV6qa36KXhVjiyajQRM
Ro11UsVVJ5X3QgihOIWozryynhJWwPTkEwSEy/SXfWABGI958fwlXql/OLfn5ANM
Fn8opkwAXNlmrukYXcVi2RJtU7zcVpcVsCbq1koweJm3KWIUSY4+XNaHUkxPVAmW
E8k+aINXLowfEw6Q3uJFvwZGLJIi3BZMXwk6wYiLNOzZgOYlIvJfPT/Y3PetNOUE
5XkrbC/VmOIPOTxhILwLlB3+
=Q0na
-----END PGP SIGNATURE-----

--=-uBVcWHTLCDJlFvAW7yIN--
