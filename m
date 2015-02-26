From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: fsl_esai: fix struct clk pointer comparing
Date: Thu, 26 Feb 2015 11:36:41 +0900
Message-ID: <20150226023641.GI6236@finisterre.sirena.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-7-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5/gejftf0Hzkayd1"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424876018-17852-7-git-send-email-shawn.guo@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--5/gejftf0Hzkayd1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 10:53:36PM +0800, Shawn Guo wrote:
> Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> instances"), clk API users can no longer check if two struct clk
> pointers are pointing to the same hardware clock, i.e. struct clk_hw, by

Acked-by: Mark Brown <broonie@kernel.org>

--5/gejftf0Hzkayd1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oa4AAoJECTWi3JdVIfQLVMH/jt28RRduIQD9/S7ZS2bBxQb
iv7Sz3k6f4fZFhsOYif5BkvptIhQnZWmjLjUGTio9LbC/aOpDzD30wOLR+6KrwLG
fwxi3fvPhEcRN0YyAR/+QlnsPqqrmpYKq+4+JoSz2dQxi8duGLzBIrx81/6gwi+e
TzYaYgUuSnZisoKLusAeIN31Ql9L0LrT+jtprY0Hdm0XQwOZ+okcvwjoaQLLhobv
Ho1yEFFkqjH6L223445QNQ6Nm7r8FO0lJYJmNSEhtf0HNpHWZzSHrxOGwnrVsaHI
BwMaC44DnhCtLm+jVjcbc8q4ydg2xUbnO7SoPJnF3G85iTMCUbAIw7oxn758J+k=
=GPOW
-----END PGP SIGNATURE-----

--5/gejftf0Hzkayd1--
