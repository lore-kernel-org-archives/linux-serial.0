Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DED60B82
	for <linux-serial@vger.kernel.org>; Tue,  5 Dec 2023 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulVhU/9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F83C433C7;
	Tue,  5 Dec 2023 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701792011;
	bh=kI1bEHAXdFXKf87FBcJ74Jf1vavpx37Cc9XIkiHEP9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulVhU/9MchpQORyRiVvbLnQDmvxyfH56LbUL36dYvVxn5mIABX1YCg8mB17vDqs/l
	 oa5K7sqGfVwZjazeVMsvPudvDoRl3zzDLHk4dDClUfYHf7Nb3lQt2bDFogW5Iz00AA
	 uC7ph3H5opZzMzrYs/a+j4F10efqCCEA5A3EmpVlhLx13ilsu7+BaIsWmd93hkkF9K
	 2mM72WIW0HMkaCz1qUzR0oaGwGuaW9z8/+Z9efK85co2l1cvDu3Xs9s7ExECfN9Mbd
	 R8A1ra2ld7sZkHeMaxllBza+wIgR5kXp6RYiHJSkx6p9GAmR64ntnRUu0d4HRVrg69
	 YuE+E1uqZkmGQ==
Date: Tue, 5 Dec 2023 16:00:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <9d3bdd33-cc23-4c80-a120-68898ba0c572@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
 <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
 <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
 <20231205105246.a0864cd10ff0252dec9ffabc@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JI9VIstDJQZBToA8"
Content-Disposition: inline
In-Reply-To: <20231205105246.a0864cd10ff0252dec9ffabc@hugovil.com>
X-Cookie: I've Been Moved!


--JI9VIstDJQZBToA8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 10:52:46AM -0500, Hugo Villeneuve wrote:

> after our discussion about regmap range, it seems that the
> efr_lock will need to stay.

OK.

> In fact, all of this helped me to uncover another case where an
> additional lock would be needed.

Some progress at least!

--JI9VIstDJQZBToA8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvSQYACgkQJNaLcl1U
h9DHvAgAhZlTxMcszRkCry0LDAA0dP9cZcvYJOumjy7Ptr6AQgWDy8IWNTFUffCC
tiFwXlTcRu25amPCa2j2UKZrAXtrvrp9DLSNVaA5TiTlko9ANHJ3QGRqFmDREw7z
4wKGIx3HCSgrwl5+7DckDHmc1ol61cJ3QfThvFT96F8C0pEVew4DWdMwjBS/mes9
xuzly2qP048donet3BQ9fiO4rV45daoOERayGX2NPuimLFWNyhZ9pCWdlIZNpzK/
cDFZkm9OmCNxr/f0c9fXuU//t7F7jmOxXjv2cL4HfgM0QQJ2S1IBjlZg4ZYP/CKJ
5mQ091vJy0ak6GYvUZjagtEbU9knxQ==
=tuud
-----END PGP SIGNATURE-----

--JI9VIstDJQZBToA8--
