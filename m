From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/9] clk: sunxi: Add A23 APB0 divider
 clock support
Date: Mon, 7 Jul 2014 10:47:00 +0200
Message-ID: <20140707084700.GD16262@lukather>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-2-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBPV65GOQKGQEOUTC76Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404399349-20237-2-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 10:55:41PM +0800, Chen-Yu Tsai wrote:
> The A23 has an almost identical PRCM clock tree. The difference in
> the APB0 clock is the smallest divisor is 1, instead of 2.
>=20
> This patch adds a separate sun8i-a23-apb0-clk driver to support it.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Just applied, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTul6EAAoJEBx+YmzsjxAg7BkP/Ryw4VVKsXOnPCEuo2gN5ux/
Glp3BY3abD7KQRSbSQZnZF1UwcAbnwWtopM/54G2xuTD1xuczitgHPppwKATsZV6
XNksLoWtAdWsv6QZHMJuKV13kCy+3FtqHJs24pmt3mNAa863j06bBd0oCmbUGu7M
oAjGWvqiR+/SPnCs4D9R0odoNPepsnFO4sVDxvNnXHOwIP0ubp5HjHC2EKFSGDKm
7EtDjU2AB56VLerwfpJc0KDWP0P/vEtFmc7jBgOatkVArgWhQxjzt2v2Mb/Gy3ra
wxKlh08ghmBE70HMoSp7sh9OE4B/qwFHonDOcwn3iy4TebIWjU0mxWnaazWqtn9n
bqT9cX2LFm3L77Rx6JrmSzlJehyAe3ir0ovup+fY9M0MPWPM/IVDGrgbouM07C0L
YbjcQ7IW5sB1VFVZ7MN2GrMnJwGDLHl5dW5Gb3fs+kD5V1lyx5TJ80ILlwOZyKAj
60OEahyJqdQ2yv4wpUGEOkBpBsYV5IJpanzxyVqxpXBfpUxRfx/+6DJpb+ns5aE2
dl9VBmg/4S/WmBxVisAaN9tw/Z9VprxVnEL9nFLdBXKj8LgSqrnH+920ZYXjSIdW
TVBWUcDMgd6J2/Bn6O6iJlHAs3ugmQh2N3S81CbyAPY9YTCZNM9utOXCPRBUbFF6
HEaZXk9GGc1pKG9o0kB5
=s84I
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
