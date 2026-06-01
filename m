Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18AB640
	for <linux-serial@vger.kernel.org>; Mon,  1 Jun 2026 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272830; cv=none; b=mBgcEi54Kw881NJeV+U7jM6f5OqfpVMpQXjG2f2Yw0+2wjDicLQNlJdkrO/5uANjB9tkM/JAzQW9Tc56nKqJQR4n2Aa5dakgKgv7vJBoBnX/5EmNb/J3KGFXx4Kc6CsM2nA7NI1iPmxALYGCAJjuQ/SGNP35QsaBd3lqvIdPHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272830; c=relaxed/simple;
	bh=58DM2kFGXRR5SmndG7V65q0M9IaBZ64o8CgjV+M6VW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+TbR9Fx2ejjLIovIehznp8gxM6IEaLRGHX5c1c1vVtdonzd5lgbv0Ku8X0ro62Vd95ygfqjl6cSEpP+yRLd5mF5XL7kHOMrDTE439guJ816Orq/GL9ORRS3EeQpERziW3RuCpV1JOHwPOTXaX5PaRsXgch4SttBQRhEH9q5aW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=rGX3uobs; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="rGX3uobs"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B93FF240103
	for <linux-serial@vger.kernel.org>; Mon,  1 Jun 2026 02:13:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780272826; bh=58DM2kFGXRR5SmndG7V65q0M9IaBZ64o8CgjV+M6VW4=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=rGX3uobsJNPgjuOz2UMw14IrjFLfcBVZ5BqPQqTYw7daSKrrOx4cNGsZfO/Ip7yjq
	 VbNtvt4wXslom4Rw9FmdGt6xvXOhqAFtnxZk4YcPvoHBRGhm/r3d6V1MhyWtc+rGlO
	 oDOblvKAlza/5J2vLNJxQ6CeV6XhPHuvH7jGG5PwqBWzO9ZixEb4zVC3RDiKJcxz9b
	 j0+P1m2patrY2OtMmwLWo7YDMSXlrc3J/BtYRaI1fzBnNeqq3wZVIS/QbDyXFRHMp9
	 L7X2wAiIWGQV1nz4a99ORAF347NJCsF05d6BDdEyLU5N/3yc0doy3vtGMqk1LQtn8J
	 273iMW/a4l+SA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gTDvq6Y2sz6trs;
	Mon,  1 Jun 2026 02:13:43 +0200 (CEST)
Message-ID: <fda7602dc453231580be8fd7f8b56c7984b1efd1.camel@posteo.de>
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
Date: Mon, 01 Jun 2026 00:13:45 +0000
In-Reply-To: <DIX7W3C7F1UZ.3P1LHOQSD5VMR@kernel.org>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
	 <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de>
	 <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
	 <12fa6237168ecf6dc65ebf46118beeb5c51f3d1c.camel@posteo.de>
	 <DIX6YVWRDL67.3TXDMTAMASCVZ@kernel.org>
	 <7c30276759aaba8127275e602cb78783ec33bbe9.camel@posteo.de>
	 <DIX7W3C7F1UZ.3P1LHOQSD5VMR@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-bug7M99IW+HdQKCtqoS/"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-bug7M99IW+HdQKCtqoS/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 00:32 +0200, Danilo Krummrich wrote:
> On Mon Jun 1, 2026 at 12:00 AM CEST, Markus Probst wrote:
> > On Sun, 2026-05-31 at 23:49 +0200, Danilo Krummrich wrote:
> > > On Sun May 31, 2026 at 9:42 PM CEST, Markus Probst wrote:
> > > > I just noticed, is it even possible to use SRCU here? Currently the=
 mutex not
> > > > only ensures that no drvdata access happens after drvdata drop, but=
 also that
> > > > the receive_buf waits for the probe to complete, as the drvdata has=
n't been
> > > > initialized yet.
> > >=20
> > > Yeah, if you drop the completion, you need the mutex.
> > Is the performance impact on an mutex or on srcu + completion higher?
>=20
> Weighing in the completion, the mutex probably wins as it will always be
> uncontested under normal operation.
>=20
> > >=20
> > > (In case it wasn't discussed in previous versions already, there is a=
lso the
> > > option to just attach separate private data to the receive callback, =
which would
> > > avoid this synchonization problem in the first place.
> > >=20
> > > You could have serdev::Device<Core>::open(), which takes its own priv=
ate data
> > > and a corresponding close(), this way you'd allow drivers to control =
whether
> > > they want the serial line "open" or not. You just need to make sure i=
t is closed
> > > eventually.)
> > This would add complexity with types, as we need to ensure that write,
> > set_baudrate, set_parity etc. does not run when closed.
>=20
> Right, but looking at a few serdev drivers, there seem to be a few cases =
where
> drivers need to close and re-open.
That is something we could consider once there is a user.

I am certain it would make it more complex, not less.
>=20
> > > That said, I don't know what turns out to be the better approach. And=
 maybe it
> > > simply isn't something this initial series has to tackle? I think you=
r driver
> > > does not implement the receive callback?
> > The initial driver with only leds: no.
> >=20
> > That changes once the driver also takes care of hwmon (ADC sensor and
> > fan failure) and input (power button and possibly other buttons).
>=20
> Maybe drop it from this initial series then and revisit with the first us=
er?
I would prefer it with this series.

Except for probe and remove there should be no overhead if receive_buf
is not implemented.

As it will be needed eventually and it is basic serdev functionality, I
don't see a reason to not include it now.

Thanks
- Markus Probst


--=-bug7M99IW+HdQKCtqoS/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmoczq8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSZ+0P/2ylwrHvfHKKiTVBl/XF
UL+HU/pmQkc3qwxSFyW3P7DLtY10V0r8kzPH2o35AC24avXePqjgo8hW2A5zAGqO
u2gh9IV2XNBUKsF1CpV6bGaw/xCd3iUdmS8R8sIJfoNQJFj/EjDpL0SecHKz0iVd
ARYzYY+xPCHLPGz8dxtGLgHq1pU4kIafkJ0K2+TYmSDVA9PRPlqhKgxDsWtFWVMb
MnK6e+4HAqJaVNpITF7YmojKKIObqCmv8RnQWon6MaSQp1QK7F9b7Szyz1jN6435
iXMUcatC+McjLHNTvnRJgn0G50CNFX+/ETmnGHH6VVt/Mf4M+55B6HV9ziq72RD0
jnczWTHHTZwDgNjPgqQgRjeOOWHuKu4T9QKpJclOlcg6F3dmP7SYNTKX6iYYk1QQ
1cjwkUShY8HfcdcyWBf2ME3+D2fj73z/f59y/gFgIfKcMZGNuUHdbMTgGpUm9tcj
GDgupxz7qS+CKzEBHzySTp9gKg6xzvA4gTcvzjoAk+3RrLhtFL/kFa8jvB5pvwlh
CO1GwHsgiR6pPzqj4pAFI/JDF2/gcIMeOERTNAuAz1In8LpLCRzJuMFkmXXJ/XRy
NYZyHMUT0PzUmfA1869YY2zN+FIRV0ykMAp0aKV4HhWm5qQpb3HYmGRMOhOJriVI
sTK0zERHauHUMCm8i58Nnlf1
=TScp
-----END PGP SIGNATURE-----

--=-bug7M99IW+HdQKCtqoS/--
