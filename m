From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Date: Wed, 23 Jan 2019 10:58:21 +0000
Message-ID: <20190123105821.GA7503@sirena.org.uk>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
 <20190122202924.GL7579@sirena.org.uk>
 <775cdd29a7d536772330a15a7013f251@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <775cdd29a7d536772330a15a7013f251@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alokc@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, andy.gross@linaro.org, david.brown@linaro.org, georgi.djakov@linaro.org, dianders@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org, linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 23, 2019 at 12:45:30PM +0530, alokc@codeaurora.org wrote:
> On 2019-01-23 01:59, Mark Brown wrote:

> > Still not seeing anything except this patch here in my inbox - like I
> > said what's the story with dependencies?

> I've added linux-spi mailing list to all the patches sent as part of this
> series. Not sure why you didn't get other patches. Today I've explicitly
> added you in all the patches.

You really need to ensure that things end up in people's inboxes -
sending them to a mailing list usually means they'll go to a completely
different folder.

> This change series basically enabled interconnect (as per
> bindings/interconnect/interconnect.txt) support in GENI QUPs based drivers
> so appropriate BW request can be put based on SE usages.
> here is my complete change series: https://lore.kernel.org/lkml/1548069703-26595-1-git-send-email-alokc@codeaurora.org/
> I hope I answer to your question properly.

So it looks like there is a dependency on earlier patches in the series,
that's what I needed to know.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxISMwACgkQJNaLcl1U
h9CoTgf+PA29xBdCek5fu2oi7M3F4k1fLvkUkXx08R30Xh2AEVPfA9BZTIBp64Jd
6kpDFuGII2h38T7Y02pZhtZtT+36Q0YA6WD9H7AuzupmP7K0CsqOlysR06e43DwX
8d6tloJYmZlK6isHO+iHG9ID3McrL/9EBng8OCpnIAEAgqR/Dm07L4nAx10NeU4O
n8WzQJkhCmtvgnSt+ZvF/vVdxGUEKYVmdDsNPUyNmNmH+quhPk52qnVjjWXQIUog
pULdWHaJADV5o+ewWyAj/67QXWHiq52k63uG80u0/Kp+lstEDfhhL4NkGsixeEpH
g+6VqKfMx9hBGOpnbcVgX2QpBpvhxQ==
=ssTu
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
