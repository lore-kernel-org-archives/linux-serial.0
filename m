Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1759157
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRnE6JVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55496C433C9;
	Fri,  1 Dec 2023 21:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701466912;
	bh=TWbyrktty0aiio1Yz8/D+E9sSNPXFW7QN+9676S+CaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRnE6JVTBolPMsI2yYyuiCUti/OLVHuxJ0eItuVPz2Rtx+muYnS6qXES+7NKMc7bW
	 HZ171g5Zpnxu7HBdjUjw7jFEXq+VLR/g+CQAiO7345Wlq/7kCFkawjGCAQBy6q+6co
	 mlyxWm4ByTkp7E7LoHZp3/gex1wjZGJq082a/MyoDMhE80cbpvPi1SJIw69CFbJDKz
	 PAx3r6z1tCIgBJ93czwUCfruxcVqGP2kHs9dBS4XpvAI6phCBYbu399yX2/4D3uMVZ
	 bzNfHYMbudmCaZeTQNDGE9KsBIXl578OUWRB7RmpssX4TIIzMj4+m6bGpg8R1CkmJm
	 WoaZ5OL6v+JEA==
Date: Fri, 1 Dec 2023 21:41:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
 <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
 <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
 <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nOhcgoa1wYS3/ikS"
Content-Disposition: inline
In-Reply-To: <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
X-Cookie: The early worm gets the late bird.


--nOhcgoa1wYS3/ikS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 04:38:46PM -0500, Hugo Villeneuve wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > If you're working on that driver it'd also be good to update the current
> > use of cache bypass for the enhanced features/interrupt identification
> > register (and anything else in there, that did seem to be the only one)
> > to use regmap ranges instead - that'd remove the need for the efr_lock
> > and be a much more sensible/idiomatic use of the regmap APIs.

> I will also look to remove the efr_lock, altough it has more
> implications since this ship has some registers that share a common
> address, and selected by bits in other registers, and I think this
> is why there is this efr_lock.

Right, the registers sharing a common address with the register selected
by bits in another register is what regmap ranges support - the less
creative use of this is banked blocks of registers with a selector
register which picks which page bank is in use, that's moderately common
especially for TI.

--nOhcgoa1wYS3/ikS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqUxsACgkQJNaLcl1U
h9Br7Af/ZG85j1+00hl5mD/PF2YAu2qKynlERqrKBWec6mnSm0iequm+2ZfgTZ9E
qIdMdI5vVM1xPhl+r6uByEkDj5uBVvBonTM+diCzuT6NnXfcvVUfr5jGjJW5dDqp
wtUwTpLB4FRXlIyFYOpQztxyVGsbO8XTm8ASqe/zqccpG19nuajaOasqdTiGE0zQ
nJQzy3sqTV4cgxGXujZUuz5Dd1gWD07gqVmaK7C5QefWEdxyIvav/FRRJ/kLHQex
N03Rx4YdvzA8Ec6twRIkEzwVIrTndo4qZbYOAGCUibgVZdmanzKIngOhSIBqEiM1
BoZGJ+DqqBfpwu5ajmHRTLFmEFCOaA==
=4qvG
-----END PGP SIGNATURE-----

--nOhcgoa1wYS3/ikS--
