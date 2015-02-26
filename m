From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: kirkwood: fix struct clk pointer comparing
Date: Thu, 26 Feb 2015 11:12:10 +0900
Message-ID: <20150226021210.GZ6236@finisterre.sirena.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-9-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2y/feSa6JmJqKeZ6"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424876018-17852-9-git-send-email-shawn.guo@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--2y/feSa6JmJqKeZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 10:53:38PM +0800, Shawn Guo wrote:
> Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> instances"), clk API users can no longer check if two struct clk
> pointers are pointing to the same hardware clock, i.e. struct clk_hw, by

Applied, thanks.

--2y/feSa6JmJqKeZ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oD5AAoJECTWi3JdVIfQFQ4H/0M4eiqeTojCqqaGjS2zVV5n
QdMeX4YdLBhl2oehBLDPYjhpJfzvivGBIjkQcXgNBy+Rw5J0Nw3MHrBy7EVVoocN
5kLFGSjrXrLiqBK+wOBMY2eVRzVBh3GOoSiIVuMaG8o70wTkbhz5Do9m3AqIngv4
elRHiFUZoaEdcxAay/jSJqVathaGCpZZUodcOLCLYVtvDKCeo4LEWnWpfUWEh9xd
XFtVecq9UaMrOxxACzadT3mBa/rdzcXJimNtk8/MQonrSqYYdO29lIi4JvBkfIxR
lEmrrllrCw/wBTK1XQvRVe472pko6L3tPwtEM1CmWD1UxA8xunhhXN4g0icUSrI=
=LTZZ
-----END PGP SIGNATURE-----

--2y/feSa6JmJqKeZ6--
