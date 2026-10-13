Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD34D8DB8;
	Tue, 13 Oct 2026 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888875; cv=none; b=nGEdPClajEaQQc5cBeR5H2JYnpzXu1otMcg/dB/adB79lzpxezduQkWm3B0Ug54tnQ2CJwC5w6r7ihkZFN5v/+F+SvAsQzNAiQZ6cnIy8v5tHQcu2EC8LdxM3T2cA847pse7TQsTIdjUXUK84j8uRv85HPXSmcam7/ML0ZrTaOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888875; c=relaxed/simple;
	bh=ptn2HPoSj13nIsTf8UUFzq+NgWhMvbEtaIopCk8T8J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPn0qRB7cOSgcKOeMR8UpiGEULPXpVt9DDt/uPuYF25Y4qDAKvUzlRvuoSgEB6Wv5Pw5naKKRkEsN1UD5vermUttgHrSYPTvMAfelZWhaKqh1Wx2JbWTtObep/1aUb0zV+/DCWGJ2lnCKfIHoHTaW3VHynvtTgV/EXMssSgZsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1kYgaAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1kYgaAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEDF1F00899;
	Tue, 13 Oct 2026 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791888873;
	bh=xFMEj1cnRPQeYv12SK/a3UGK7lh2zV52Je/Sq5SGy/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d1kYgaAgRb52bF+yK1n5b3RoclPkPNrkWQUqQjBZYvsD9kSQgaAeoS6nUxlEsEhwC
	 A+TJbYjJgr2aYN4d4y8Qwm7qVSeYbIGdbWUxLzKgIGQwzAixriQQsp0d23rN96oZb3
	 R0a/F1j3NDaUAc5/KMoym5jAoiDmuzfC5wTSlcCprXq1eVIBzGXi4ymGNt80iH9nMM
	 7/E2hlvRl04iG9GyTFjwI7D1RIHjMl7ycGY69OKMrmaWkS14o7pzUhx1tPpE7GuEO8
	 zmQxQH0ClNDcUbCbu8HzWeRzLlXDkX9z2gpzNbW6B2+c4tytCL3pTQk1M9yJp+5Vxr
	 AQ48SqUsfwwZA==
Date: Tue, 13 Oct 2026 12:54:17 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
	Paul Cercueil <paul@crapouillou.net>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-parisc@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
Message-ID: <as4NlWQ0JUC5WgIg@debian>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
 <as3etnbZatn4sbfx@ashevche-desk.local>
 <c6b08f53-b5ee-44c8-93d1-54fdf5994ed2@kernel.org>
 <as31PsESOgLUhMB6@ashevche-desk.local>
 <b404f3d7-1b2d-418a-8634-72c61ce33f8b@kernel.org>
 <as4BML-VUC9xUgOf@ashevche-desk.local>
 <cc5463cf-1e31-4a5f-9341-22769a7b0af5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="chf2qusy2een43rb"
Content-Disposition: inline
In-Reply-To: <cc5463cf-1e31-4a5f-9341-22769a7b0af5@kernel.org>


--chf2qusy2een43rb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
	Paul Cercueil <paul@crapouillou.net>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-parisc@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
Message-ID: <as4NlWQ0JUC5WgIg@debian>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
 <as3etnbZatn4sbfx@ashevche-desk.local>
 <c6b08f53-b5ee-44c8-93d1-54fdf5994ed2@kernel.org>
 <as31PsESOgLUhMB6@ashevche-desk.local>
 <b404f3d7-1b2d-418a-8634-72c61ce33f8b@kernel.org>
 <as4BML-VUC9xUgOf@ashevche-desk.local>
 <cc5463cf-1e31-4a5f-9341-22769a7b0af5@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cc5463cf-1e31-4a5f-9341-22769a7b0af5@kernel.org>

Hi Jiri,

> Date: 2026-10-13 12:15:35+0200
> From: Jiri Slaby <jirislaby@kernel.org>
>
> On 13. 10. 26, 12:00, Andy Shevchenko wrote:
> > > > > First, it is used in the kernel quite a few times already
> > > > > [1]. Second, while it is sort of c++ism (and I like to use modern=
 c++), it
> > > > > makes the life of the variable a lot more obvious.
> > > > >=20
> > > > > [1] eg. see output of: rg -U -C 5 '}\n+\s+struct .*\*.*=3D' drive=
rs/
> > > >=20
> > > > (you made me to install something I haven't heard about, it's bette=
r to use
> > > >    `git grep` though)
> > >=20
> > > rg is order of magnitude faster (searches in parallel). More importan=
tly in
> > > this case, supports multiline matches. (And respects .git ignores.)
> >=20
> > Isn't `git grep` fast enough due to looking into index and not into the=
 files?
> > `rg` may not look at the Git index, right? So I may not to use an arbit=
rary
> > hash without checking it out first.
>=20
> Of course rg is not git grep.
>=20
> > > > Note excluded __free() if I get regexp correctly
> > > >=20
> > > > $ rg -U -l '}\n+\s+struct .*\*[^)]*=3D' drivers/ | less
> > > > drivers/ufs/host/ufs-qcom.c
> > > ...
> > > > drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > >=20
> > > > So, less than dozen of drivers doing wrong is not an argument, try =
something
> > > > better. But thanks, I will check and address this in some of the ab=
ove.
> > >=20
> > > Well, it's only an example of a declaration after a previous opening =
brace
> > > "{" -- this one turned out to be easy to search for. There is a lot o=
f more,
> > > of course. kernel/ included.
> >=20
> > Please, provide a better search line, I will look at that. For now it's=
 just
> > a hypothetical assumption, I am afraid.
>=20
> I am not much into writing a semi-parser at this point :D. This'd be a ta=
sk
> eg. for clang's ASTMatcher.

You may check grepc(1) --provided in man-pages.git--, which does have
some code for searching different kinds of code.  You may need to tweak
some regex produced by the backend grepc_c(1), but it should be
possible.


Cheers,
Alex

>=20
> thanks,
> --=20
> js
> suse labs
>=20

--=20
<https://www.alejandro-colomar.es>

--chf2qusy2een43rb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrODdkACgkQ64mZXMKQ
wqnsDA/+PoSRMrpPgQYZ1YngQ85h3wrKX56Mpt0JThWxcWVMcDod7LTn6C9sgMhA
Wo1S5+HyNOIPVdYqTmZgRx+vE+IGp0f8Wx/JlYmH4yjAaGjssW2gfe7xb7mYXc03
MWZXbFWxrICpzgjc+yokDM0JEgDKxh/B1MqAZjghXJjG4lN3v6Sgm2Efft6zj9TB
2H+k1+cBwpe6ubcTTlRvKtWPAzC2XwriuVGFh+73xLlb2gqJgiWJVCH3rOCb8hx2
SkNIlnC5gb/7hBhNfMsjBY4oJnPy8iL7XnsbQkV2a+rEW4aAqY8RNInIe/FhMeHV
bEPRyLyoLNAcwwp7pdQly/4z59E6ZzxsCsroRh0rnPD771n7HEZcFYTlZ5E+tV9+
YsnZyJ7E1ILMJEjiTZw1e0pU2ggebT/UZoHjKmarda/9n4WVp0PGH9f5nMp4v4rW
Eg0DGoTcW6Bx/wUTYKYXdNR1zI6fysEMpdaq0smU6OHTZRh8zGR99HY7YXbwEc26
6zWxAT7BHiIK5WTdNXmmSn8IZp+DBU607Y7twXzn3K8UxEFFvPJtRbCItLUd2eOD
b/W7hsy+m7qEirdcflQn22V++r9savPpaF0c5+Uq/hZRwm3yrPhY5Q6DdWqLitJR
SPLZuBKFjV63DBYf30LFWP4537QSkXu/eOY+Y9g/PopcTCBwlbU=
=m8NY
-----END PGP SIGNATURE-----

--chf2qusy2een43rb--
