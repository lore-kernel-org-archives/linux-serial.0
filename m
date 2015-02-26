From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: fsl_spdif: fix struct clk pointer comparing
Date: Thu, 26 Feb 2015 11:29:44 +0900
Message-ID: <20150226022944.GD6236@finisterre.sirena.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
 <20150226021250.GA6236@finisterre.sirena.org.uk>
 <20150226021958.GD20028@dragon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gKRDem1CvcWhBwrN"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226021958.GD20028@dragon>
Sender: linux-pwm-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--gKRDem1CvcWhBwrN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2015 at 10:20:00AM +0800, Shawn Guo wrote:

> Sorry that I did not make it clear in the cover-letter.  But the first
> patch introduces a helper function clk_is_match(), on which all the
> other patches in the series depend.  That said, the patch series should
> probably be handled by Mike as a whole.

Ugh, right.  I've dropped those patches then.

--gKRDem1CvcWhBwrN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oUXAAoJECTWi3JdVIfQ8iwH/jpV5BUwlyJEwV6ZVU/waIrm
SVM7B0KjsIKdaryFcz2eas1JRaODos4UJMdiietMtkR6bTd5hpoiBZKWFgVotAv0
us1g6nqrHbCS4xCbjfDVofEfv5jET9vA5ByHGgCHhyoKI/WvFRKAuTMJjTKzvBgb
HvFVOJ1a38vFj3pJLurFAhdKC8IJVPCo1DvxCcyJ/9jksG7Pgbxg23azAshSLvQR
bZc6i8woHggjbVfmIT9+gGFfP/Bgfx/k+pFw0tDE691cyxpHGPa0um8LrMVEDvms
axXwgJr0dMgHuOQHizu8Z/CGPHkr2SltwgsUt2UDK3AwghjCqSMyv3ix7B61odE=
=bwM8
-----END PGP SIGNATURE-----

--gKRDem1CvcWhBwrN--
