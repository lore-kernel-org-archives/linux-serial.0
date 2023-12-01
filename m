Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750651006
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOhhNVOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7A9C433C8;
	Fri,  1 Dec 2023 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701455683;
	bh=lYdOkcbomoCo/nDtxoX8etSmCoMmoEHguT3Ti1W4duA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOhhNVOSw3fCPve8hlbeOyjnlL/v6IMxAd+k0rooLnXPrHQgk7tlahDTnB97llX5G
	 62nda7t9cMp0s4sGUckPKPGjYw/QadaFD2kItLLWZ4MsNLIcvVZ+5chTMsdZE5Q8Ej
	 YPBZ0r84e/W5xc+Ln3K8K0cPaDBkQJKtabtrqvNkAijylqEsATBznw3BCJ+OAOIeze
	 bjKxqioabN/eGCf3/8QgZMHq0PCxnEsbJjv3YGJUmwCzY4bCGBqPsrR2T69ZgzqXTR
	 zgu4SV++amgJvCp7oiTViI3d7rZsFVAVogEv6k8wu7YTF0AtPHQYn+2TRxbMWFLzev
	 3xI3tdib1faMw==
Date: Fri, 1 Dec 2023 18:34:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
 <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gAP8eIWqXiRQDLma"
Content-Disposition: inline
In-Reply-To: <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
X-Cookie: The early worm gets the late bird.


--gAP8eIWqXiRQDLma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 01:27:36PM -0500, Hugo Villeneuve wrote:

> it is funny, as I am preparing to send a patch for the sc16is7xx driver
> to convert FIFO R/W to use the _noinc_ versions of regmap functions,
> inspired by your patch 3f42b142ea11 ("serial: max310x: fix IO data
> corruption in batched operations").

If you're working on that driver it'd also be good to update the current
use of cache bypass for the enhanced features/interrupt identification
register (and anything else in there, that did seem to be the only one)
to use regmap ranges instead - that'd remove the need for the efr_lock
and be a much more sensible/idiomatic use of the regmap APIs.

--gAP8eIWqXiRQDLma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqJz4ACgkQJNaLcl1U
h9ChbAf9GpZIS6eBd6Ine2BXBOp73JNB258Km8SfUElURLlKyXyp+U7Zx0fVC9kr
/QTWjWU6knqGimoKpz6qSMpHEgzLvsTtDHd0ZqSdqnJasG7b0nGnnU9RYuPlknP/
W2/+GFsWXp7MIDrDLw64stkvW+XAUj/DPtVSbC2cptRQg58u+0OdFBdh1jREUpBk
AQlUWPzRK/sNyQ+z7I7+28yRd9hsrNAr4B8wcyZY371boAdyJLGnuCop0KiyhXjc
8w6K90XP0sfYWjebkRMTy0pMWpwUecVYGNJUyEgsSTN4l9C/y+kyWEPpwmij5Fin
tE+vh22LAogp64YZbvuwKX5vo2b60Q==
=I0gd
-----END PGP SIGNATURE-----

--gAP8eIWqXiRQDLma--
