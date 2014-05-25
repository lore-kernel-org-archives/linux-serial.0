From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 09/22] clk: sunxi: Implement A31 PLL6 as a divs clock for
 2x output
Date: Sun, 25 May 2014 20:56:24 +0200
Message-ID: <20140525185624.GR10768@lukather>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-10-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8422521636243660653=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400831485-28576-10-git-send-email-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Emilio Lopez <emilio@elopez.com.ar>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Luc Verhaegen <libv@skynet.be>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============8422521636243660653==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OiITrshLgfui8fEl"
Content-Disposition: inline


--OiITrshLgfui8fEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2014 at 03:51:12PM +0800, Chen-Yu Tsai wrote:
> Some clock modules on the A31 use PLL6x2 as one of their inputs.
> This patch changes the PLL6 implementation for A31 to a divs clock,
> i.e. clock with multiple outputs that have different dividers.
>=20
> This behavior is consistent with previous SoC's by Allwinner.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi/clk-sunxi.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 6857c6e..339cabc 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -496,6 +496,7 @@ static const struct factors_data sun6i_a31_pll6_data =
__initconst =3D {
>  	.enable =3D 31,
>  	.table =3D &sun6i_a31_pll6_config,
>  	.getter =3D sun6i_a31_get_pll6_factors,
> +	.name =3D "pll6",
>  };
> =20
>  static const struct factors_data sun4i_apb1_data __initconst =3D {
> @@ -969,6 +970,14 @@ static const struct divs_data pll6_divs_data __initc=
onst =3D {
>  	}
>  };
> =20
> +static const struct divs_data sun6i_a31_pll6_divs_data __initconst =3D {
> +	.factors =3D &sun6i_a31_pll6_data,
> +	.ndivs =3D 1,
> +	.div =3D {
> +		{ .fixed =3D 2 }, /* P, other */
> +	}
> +};
> +
>  /**
>   * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
>   *
> @@ -1108,7 +1117,6 @@ static const struct of_device_id clk_factors_match[=
] __initconst =3D {
>  	{.compatible =3D "allwinner,sun4i-a10-pll1-clk", .data =3D &sun4i_pll1_=
data,},
>  	{.compatible =3D "allwinner,sun6i-a31-pll1-clk", .data =3D &sun6i_a31_p=
ll1_data,},
>  	{.compatible =3D "allwinner,sun7i-a20-pll4-clk", .data =3D &sun7i_a20_p=
ll4_data,},
> -	{.compatible =3D "allwinner,sun6i-a31-pll6-clk", .data =3D &sun6i_a31_p=
ll6_data,},
>  	{.compatible =3D "allwinner,sun4i-a10-apb1-clk", .data =3D &sun4i_apb1_=
data,},
>  	{.compatible =3D "allwinner,sun4i-a10-mod0-clk", .data =3D &sun4i_mod0_=
data,},
>  	{.compatible =3D "allwinner,sun7i-a20-out-clk", .data =3D &sun7i_a20_ou=
t_data,},
> @@ -1128,6 +1136,7 @@ static const struct of_device_id clk_div_match[] __=
initconst =3D {
>  static const struct of_device_id clk_divs_match[] __initconst =3D {
>  	{.compatible =3D "allwinner,sun4i-a10-pll5-clk", .data =3D &pll5_divs_d=
ata,},
>  	{.compatible =3D "allwinner,sun4i-a10-pll6-clk", .data =3D &pll6_divs_d=
ata,},
> +	{.compatible =3D "allwinner,sun6i-a31-pll6-clk", .data =3D &sun6i_a31_p=
ll6_divs_data,},

Can't the PLL6x2 clock just be a fixed-factor-clock? It would make the
change trivial, and better fit what it actually is.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--OiITrshLgfui8fEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTgjzYAAoJEBx+YmzsjxAgfsEP/2kzo+7UvYAbRIxrlU8C4yNx
MNaxZ1PQlqMZuPDP4SkkXBZxHnRgzxqiQVWkijRG26aYSMqIPQMsKNE3UZd1tYMt
MDWRR0F7CM1MYdrY02hFccaluWRzNwkRhBMIyBCeuG7v2s1IeiHT5vBeEOuPLB8q
d9/7YPR4w3WPTRh+jfO0vP+Y1yr+kokIp07p2qfyJWBAP3x2hBkFgwOYUQ+INE2n
Lf2mXrtlQxR9pYEb04SYt+AKzPa1RmNx3KYeCOxG/qSv12y+qqSOWxg7CcYY7QLc
WjZombICqXgQAkuKUhRozaE2TehuVUQlHYLA+XgA596GK/6mKsS3NpzarRmZQl3B
GbiO51QyLNKyhi4kcCtfW02+Atix3bKKrSStSH4efC2h/FF1UJUeCy6UFP/nitjR
pv95Yjq3uCSRdjw4dY8Rl4l4WTpT+bwJwdvoBY5MXmt7ZqfSfO2YlHR1swt7RXWy
WLftnev6HAzUj75S8WsOeHoa+6VeWV7Uc/N6fvwscKd5enW6hTL1OmZzyqRi1g5L
Rl9KmniBJ2J3UJtuLi4gY9q4f/cWf6q2ESUAevzAueDcll6HaMgRO+UOR0GMTOUV
8VItYysGTbefBG1uzKZSQmKinSB5sOa+Z/hBlxzk6GcXAVXAIAUezr2k5jXq9aco
hyoZqIePTJB/PokCIfMN
=TdTm
-----END PGP SIGNATURE-----

--OiITrshLgfui8fEl--


--===============8422521636243660653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8422521636243660653==--
