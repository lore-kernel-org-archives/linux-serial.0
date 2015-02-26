From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: kirkwood: fix struct clk pointer comparing
Date: Thu, 26 Feb 2015 11:36:30 +0900
Message-ID: <20150226023630.GH6236@finisterre.sirena.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-9-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mShllLJ4nm1Yy4JU"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424876018-17852-9-git-send-email-shawn.guo@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--mShllLJ4nm1Yy4JU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 10:53:38PM +0800, Shawn Guo wrote:
> Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> instances"), clk API users can no longer check if two struct clk
> pointers are pointing to the same hardware clock, i.e. struct clk_hw, by

Acked-by: Mark Brown <broonie@kernel.org>

--mShllLJ4nm1Yy4JU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oauAAoJECTWi3JdVIfQrZEH/iA+1sSERqHl6RILi7FJV6dj
s+hF7UtVE3u5AkDJ/u1hQKB/9IcaKI7pFpG0DZmzshxNB/+uDAU4d6M1ySvQmPUQ
zFWq6DQCOrFpAVFUOfj0PmD/eY6Ib4ZZ7oDiW3eANRbmV7MnY+bF1kGlagAnCgwB
2K2dVXNtGEz7S3/H5dduCVbx3qvZpHkFq2uah64FkLW6XnQgEk8LZNgwok17v0XY
QAb9602Gvs9+YrB0Y7Eh2G/1KW4r+HaKlaUKhxG9mSqoElraKPCWfXd5RiCcDoKV
K6g4AKN5FjukNRmIf3voua5JFvzm8UMDXInhJBd43sXmXFxHhUW9x2IFMAWi7Fg=
=Atgh
-----END PGP SIGNATURE-----

--mShllLJ4nm1Yy4JU--
