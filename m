From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 13/20] clk: sunxi: Add A23 specific
 compatible to sun6i-a31-apb0-gates-clk
Date: Wed, 18 Jun 2014 12:17:34 +0200
Message-ID: <20140618101734.GP19730@lukather>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-14-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WOTjKnJ88wpJKlWH"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB5WPQWOQKGQEWSTCH4I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403016777-15121-14-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--WOTjKnJ88wpJKlWH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 10:52:50PM +0800, Chen-Yu Tsai wrote:
> The sun6i-a31-apb0-gates-clk driver is generic in that it supports
> the "clock-indicies" DT property with "clock-output-names" to list
> the valid clock gate bits.
>=20
> However this might lead one to assume that the clock in the A23 is
> the same as the A31. To make it clear, we add a new compatible for
> the A23, "allwinner,sun8i-a23-apb0-gates-clk".
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--WOTjKnJ88wpJKlWH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToWc9AAoJEBx+YmzsjxAg4qoP/0LXx/5xHrGu58BuZOO6+WEE
WQoJSNad4abLWVgDv8aKSfln6FdW2l6gMQjPg6MVKMJQN12qTTizs2Vg2q3KQkCE
S0GM9YFDBruW0t9r1LFazxeSCpEyh7DHLRsOCr64+ggIImTCAML1n5FNZMx2PCi1
5pHisu0IFfUNyY0TXULMmlzPqU+/nURdQkTZPlhg3E8orC+TjhTpB3IPoF7PYqo1
BJ663fCv5OzoFFH0uBxQee6euWWGMtCDQ31E+muLjnH4xYOsTM9QwXP7rZF7RRSd
hz8TXUpoWgzJ2olAFWcNBa6pmV+feQuna+hKGdtx1PTl+ogHvTtYVcLLIoiRiQeZ
h1CBeAE3eNQpg3f1+Hp2l0eJeZ9BGdXHwiSrVin6X/6zWSX7te2a0BfDGBOjSY9W
3pX/Wa95ULJsaE99ap5c67n86O1GTdI/zwT508QOZyF3U2cfBFeiIzcdF4I5Vs9Y
FAnP/UGc1Cb7HUGuXhJVSMZ3P4Hh3s5J0sq3MndaD2a0g2aAa+piFRsYydxcfLW5
OkM0y6Ip/8Tv2UaYiMwlOY1Eauv2I0ZQii+A5UhDs8o/wf6kqw816fvBi5PrNFJM
Jit/kiSVURr9m0ZNkmLJjemPq7BmENLAygXFLcQ3xbZe4WdcCSWAoKQPL31falfh
6twjHi4whER3ESLOmmj7
=Rzly
-----END PGP SIGNATURE-----

--WOTjKnJ88wpJKlWH--
