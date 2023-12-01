Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957E4AF62
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDXJugR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80714C433C7;
	Fri,  1 Dec 2023 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701447706;
	bh=OxaoKaXIZz97QSlVLuylRvJDT+kPyPJndjvasxIdAOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDXJugR2UvAVEwMYL/EPAs2rufs3M/7pGlG8EQSqI6FAMEcAIv0Wt6nAJOO6ZugUG
	 nJ4cyQhFMkZpc85ygbt+1eGdiJN0M41Qww1VuD3X+o6mIH6KfxwX2X2Wd2Q3Zni86q
	 /BKZDvlXPEwabj30PiI/oV/WMgpGUsGtH/tsOxL4KtcntPjpYnc45hcmq7uZTSVDUw
	 btH/KJ1xqiFfS+PzLMQRXHbqDtvna/8HrxgDqnzOFozmyLVZn9sgly7F99tJkUhRJ+
	 wFt9K/FEF97FJL2fk2E/6x2zx5OKULAQcbpdjKp3Ed/Fa2w82MbMQ9nsLiCqdhLnjZ
	 8WyoXFGg5Mpwg==
Date: Fri, 1 Dec 2023 16:21:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <f66cf0a3-4d63-4548-8648-e93a1ef995e2@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S1ok82JjTyGj+vog"
Content-Disposition: inline
In-Reply-To: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
X-Cookie: The early worm gets the late bird.


--S1ok82JjTyGj+vog
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 03:51:51PM +0100, Jan Kundr=E1t wrote:

> The TL;DR summary is that the regmap_noinc_write spills over the data
> that are correctly written to the HW also to the following registers in
> the regcache. As a result, regcache then contains user-controlled
> garbage which will be used later for bit updates on unrelated registers.

> I was investigating a regression that happened somewhere between 5.12.4
> (plus 14 of our patches) and v6.5.9 (plus 7 of our patches). Our

Can you reproduce this with current kernels?  That's not even an up to
date v6.5 - we're up to v6.5.13 now from the looks of things including
one upstream fix that looks potentially relevant.  The most direct thing
would be to write a kunit test demonstrating the issue with current
mainline.

If things are already fine with mainline then you'd need to talk to the
stable maintainers about what they've chosen to backport. =20

--S1ok82JjTyGj+vog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqCBUACgkQJNaLcl1U
h9DTMgf/Ymn+p9dkuv6cArGpPGkvboMvHFC62w1huJaKWI3nH93Z9cDd+E123d3o
/fM635v3qV5OyCkBS5z78OPA0rZC8hG4Ka5pFPngedNCZ7L7SLi21I9gb3403XQ6
7sCqIyTNVol59GEvalXc5bq6w585qESs2yWZmUKdLQHlUm+JfoGL4EbD85PpMrS9
xcaAUuH5LvnD4i+s4azhDbs5nOaentmWUFXZN5i/AcMOGCZyZESlJ4NOStVzgt6h
Q8jMV43gEu4POF1IpCuHUKzi7YJcyn+5+c8kkPXiaSMa2je6SRbymhbdISorfKFh
PrU+aJEMDjL2HN8reaaaZaXrAqfcNA==
=pihy
-----END PGP SIGNATURE-----

--S1ok82JjTyGj+vog--
