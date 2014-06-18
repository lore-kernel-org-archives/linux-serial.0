From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 17/20] ARM: sunxi: Introduce Allwinner
 A23 support
Date: Wed, 18 Jun 2014 14:26:46 +0200
Message-ID: <20140618122646.GS19730@lukather>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-18-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y51z1SGMnxVzkhDv"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBSUMQ2OQKGQEBGOQKMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403016777-15121-18-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--Y51z1SGMnxVzkhDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 10:52:54PM +0800, Chen-Yu Tsai wrote:
> The Allwinner A23 is a dual-core Cortex-A7-based SoC. It re-uses most of
> the IPs found in previous SoCs, notably the A31.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
>  arch/arm/mach-sunxi/Kconfig |  8 ++++++++
>  arch/arm/mach-sunxi/sunxi.c | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 0fbd4f1..6434e3b 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -35,4 +35,12 @@ config MACH_SUN7I
>  	select HAVE_ARM_ARCH_TIMER
>  	select SUN5I_HSTIMER
> =20
> +config MACH_SUN8I
> +	bool "Allwinner A23 (sun8i) SoCs support"
> +	default ARCH_SUNXI
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select ARM_GIC
> +	select MFD_SUN6I_PRCM
> +	select RESET_CONTROLLER
> +
>  endif
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 3f9587b..962ff30 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -53,3 +53,13 @@ static const char * const sun7i_board_dt_compat[] =3D {
>  DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
>  	.dt_compat	=3D sun7i_board_dt_compat,
>  MACHINE_END
> +
> +static const char * const sun8i_board_dt_compat[] =3D {
> +	"allwinner,sun8i-a23",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i (A23) Family")
> +	.init_time	=3D sun6i_timer_init,

I haven't seen anything in your code that needed to use this
function. Am I missing something?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Y51z1SGMnxVzkhDv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToYWGAAoJEBx+YmzsjxAgobgQAKMw+nCDAaYxh7n3MOhPBq8X
0+G5Tmb4zRRiUogrc9qha8UMUHc+8GfSV0+HgHJvUqdDtz2c9PdDASLuVIHh0eDZ
wyf1XUQABEOPNuyEAJHexHAOuvT1UQ6VvOZA3s9fF24NkM8XIuIiwZ1UhxoYjKYi
vdkNlMjUo8oxEcaxQ13Cu7ZMuNz6f70XbgZ6ak5rkQdhnI4PTeVvT59KFJfZg9Id
VcK9hBwzv/pfrkOd1C3aLVR9LiPiibkedXgbuQ+gg+pUy5paQfwJjpCV+sVvqzd0
Dfy9I8VY0OMgGHyHw2AI4aU8M6tNZgAta5EWdXS7qIyVhEZuob3+iXxRFOe/1VkY
p6lRkPMgKX4OgG8+UbFQghtmMbJUbDfc9u09rtA3FmdZe5cPo4M6iBvUqa3+BvRg
99JS6mCbSYorUqMqFleUrvdPYLXjmfrQEKvsGRRcAmfH253qJVWk/rDt3+RuevVd
x7YxtbYgrh+06bLyNWsFN58/oSoJeiVd1WxNF8o8+Mv4UJkjN0Fb8fxiNR2SOQm1
xV7+Im9l650z7sRPceIGn4FkCjlGdLgF94HInusMBKMOUTOWEjzHK3dvif06tP//
a98OuTUd+Q/HGPo0ttTwk94j4asAsRY/WAru13ffnBa1/wzHH6GyLEs/tGR+zjZ+
VVxTQaaWwwWYFv8BR09d
=i25f
-----END PGP SIGNATURE-----

--Y51z1SGMnxVzkhDv--
