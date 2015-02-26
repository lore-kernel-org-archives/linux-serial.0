From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: fsl_spdif: fix struct clk pointer comparing
Date: Thu, 26 Feb 2015 11:36:17 +0900
Message-ID: <20150226023617.GG6236@finisterre.sirena.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X9VBeeayN7LKkngA"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--X9VBeeayN7LKkngA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 10:53:37PM +0800, Shawn Guo wrote:
> Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> instances"), clk API users can no longer check if two struct clk
> pointers are pointing to the same hardware clock, i.e. struct clk_hw, by

Acked-by: Mark Brown <broonie@kernel.org>

--X9VBeeayN7LKkngA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJU7oagAAoJECTWi3JdVIfQ0+sH9iUfBDscZ0KacpG90lRvHz5+
NoIJ30s4/xNA/gyVDZ86hFTkQZUbrZL+A4Pr/XvHDGxolKPyGin5B/ArEJC4sosx
vZa33nl2QO17VgJY6J83gp0iQ0yjMi9OM99j3kF+sn2nA+fBP+bwWODtIpSY41Ow
ATSPyVnWE55i7qScCT/PxcHEeElgZ0Aua4Zmclzh4nK5160ImoTC7zBC59XPEebc
p1G4j9t6vbBrce6eBcaVZO3hzsWrrBf2a/8kJW6dokbCdce97OhxTe7SbQYvTe8h
KdEu30Jwhpw2UlS8I473txeCBMgS4K7EO/nv5bimUCq80m/TBalriKFEdM5IAw==
=cBEK
-----END PGP SIGNATURE-----

--X9VBeeayN7LKkngA--
