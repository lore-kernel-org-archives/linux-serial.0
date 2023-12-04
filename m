Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DF30FA6
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw3MgP5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC636C433C8;
	Mon,  4 Dec 2023 19:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701719291;
	bh=K8gd8sR5wSRnwacYbXtWvMntXb/3YFJizDMKM6jHT3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aw3MgP5pSeesm1AoRaGcj2PzEjbUkUbRBuKJNt22jekJzYU4C26DP+uGu2/yWxpxv
	 Z7rDeKScboG9aXH+2KOJ2NaB95RXUmdUi7w6x/7ahkT6yrnIoNyTuB6GJMhK1DsiAs
	 q7STB+v8C3QQv5Rb+AfK13t2534jkX4vVGO4Gz63OY42uGFKP4a+x+qLgPPG1wokgr
	 HChj9nq39VbfhxIJaPKEDUXoIb3Un2crAxwnf7T41arYkpI1u9bNm8YGUXqGslDAbu
	 KkeKXD/LHF1hCg8XObbzQ2XoOY5oBRmIciSLHFDaERq5Vsk3wjw7ZYQPHv8hExnYnP
	 kClvcX4JbeUAA==
Date: Mon, 4 Dec 2023 19:48:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <f6e93e9c-1c7a-424e-afe0-425b24b99e5c@sirena.org.uk>
References: <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
 <f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
 <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
 <20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
 <06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
 <20231204120151.f0afbee2ebc69e93e7977547@hugovil.com>
 <50b24985-cb30-4a75-a15d-9c165a276f1d@sirena.org.uk>
 <20231204135922.0355f030945920086d21b8b6@hugovil.com>
 <66946666-eb33-431d-9870-7046c39ffb4e@sirena.org.uk>
 <20231204144136.89fec6da9be49e3db96994e0@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QS3X1NLUC5qN3c3M"
Content-Disposition: inline
In-Reply-To: <20231204144136.89fec6da9be49e3db96994e0@hugovil.com>
X-Cookie: For office use only.


--QS3X1NLUC5qN3c3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 02:41:36PM -0500, Hugo Villeneuve wrote:

> But that is not was my question was about. Here a pseudo code
> example to select "page" 1:

> 1. save original value of LCR register.
> 2. write 0xBF to LCR register
> 3. access desired register in page 1
> 4. restore original LCR value saved in step 1

> How do you do that with regmap range?

Are you saying that the selector has other, non-selector functions?
This is truly innovative hardware, generally the selector is just a
bitfield that you write paging values to.  You'd need to extend the core
so that it knows about this quirk, right now that's not possible and
we'll just leave the window pointing at whatever was last accessed.

--QS3X1NLUC5qN3c3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVuLPQACgkQJNaLcl1U
h9BiMAf/cUSea07IRTrXx2YLv880+v/DhtFEnQo1gFghqEy+XpaE6eb+azQ0dzns
RdstZZyfs184tE4BTJk25eeJMXphuJZ6wwknbbcnQ2S7DckGTakiDqND+GfEU16Z
Xljf3EaBUpdnpvoNdjUxLPV4oHndm7SAD3dVfXftr4tNSw2bvbe8APTDExOKUep5
sGrSNCWZ6iPUP3EHcyEbCoRYZQRIGmPGDhtCM9XynyOz63XV/aCcW2hico/4mNRm
6OZn5Mg5H8RFXALEopXH+CcCreIEvcIzhxzqQsMM5xlzYZfYURshmgBbEg1TAlZj
NAClgod70vJQc/fjvMYqM0hFSl3Zog==
=W2Cl
-----END PGP SIGNATURE-----

--QS3X1NLUC5qN3c3M--
