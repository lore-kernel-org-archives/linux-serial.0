From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: fsl_spdif: fix struct clk pointer comparing
Date: Thu, 26 Feb 2015 11:12:50 +0900
Message-ID: <20150226021250.GA6236@finisterre.sirena.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hVUY+LYn0LT07sdA"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--hVUY+LYn0LT07sdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 10:53:37PM +0800, Shawn Guo wrote:
> Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> instances"), clk API users can no longer check if two struct clk
> pointers are pointing to the same hardware clock, i.e. struct clk_hw, by

Applied, thanks.

--hVUY+LYn0LT07sdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oEhAAoJECTWi3JdVIfQcSsH/2PBb/PXUvx4tKnbbzF01rsQ
DHfpyCJvC+M2pOryHtz1Nu1dtSOcteOTHNyWsgMTNDHUAdeU6CKeCK71kk45/ssF
calwy9BiN1HQG/bp2ujfTUG7wCIUvgJ/0ZoMS4Id/ED5RjGAnWm28n6QBc3zgMnm
ZSoDwVXb2xW4EwDQzJ50FR4lH/YytQdhrGFtZYZP83FUHhxoqj/wimbVGPdBzLhZ
VlfIfu2FnnbEA8FyzmWsARr603JaMHhbFFkE2hY9lFeFHhLrrj//6OwQjvw9TpDJ
rYNE93e5A70wJA6C+62Ft08De3OhARAEP9evR9FltWdC2VhmGI+maL/EsS29ojQ=
=0Gpk
-----END PGP SIGNATURE-----

--hVUY+LYn0LT07sdA--
