From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 08/20] ARM: sun6i: DT: Rename PLL6 to
 PLL6x2 and add fixed-factor-clock for PLL6
Date: Wed, 18 Jun 2014 11:57:59 +0200
Message-ID: <20140618095759.GL19730@lukather>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-9-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pFej7zHSL6C5fFIz"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBLGGQWOQKGQEWFPBKBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403016777-15121-9-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--pFej7zHSL6C5fFIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 10:52:45PM +0800, Chen-Yu Tsai wrote:
> The PLL6 clock driver actually manages the PLL6x2 output of PLL6, so
> rename the node accordingly, and add a halved fixed-factor-clock for
> normal PLL6 output used by most modules.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a=
31.dtsi
> index a9dfa12..12d558b 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -94,11 +94,20 @@
>  			clock-output-names =3D "pll1";
>  		};
> =20
> -		pll6: clk@01c20028 {
> +		pll6x2: clk@01c20028 {
>  			#clock-cells =3D <0>;
>  			compatible =3D "allwinner,sun6i-a31-pll6-clk";
>  			reg =3D <0x01c20028 0x4>;
>  			clocks =3D <&osc24M>;
> +			clock-output-names =3D "pll6x2";
> +		};
> +
> +		pll6: pll6_clk {
> +			#clock-cells =3D <0>;
> +			compatible =3D "fixed-factor-clock";
> +			clock-div =3D <2>;
> +			clock-mult =3D <1>;
> +			clocks =3D <&pll6x2>;
>  			clock-output-names =3D "pll6";
>  		};

Hmm, nope. The output of PLL6 is 24M * N * K / 2, and this is what we
support in the driver.

This change is backward, and should be the other way around. Have PLL6
running at it's usual speed, and then have PLL62X be a fixed-factor.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--pFej7zHSL6C5fFIz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToWKmAAoJEBx+YmzsjxAgkckP+wer6Qink/KWyr0pU+No7aAg
fLWZ4xU7VVMWcrUHgj7Iv2L2Yb8kPlhv24+YtlNsBG0RnTUijtYfRL6YT7T/EE/U
jRoq2oCPM+zFl4h1JQ5PAITIqMkCpHP5Oa1Vo5drFRZZc57I19ugKZxgZQe8rif6
Jrp1uhGZuZ4IpelSpgfCqnqdXiiuj73Unn1hl4x5Fxthq1LjOm6+rywai+9ex5Z1
CBrCRpEAfffV94ewAQsj2/Wa/APChkW1RLhnKxG7jFG0GMu/dscKy/p9ppEld3gb
+j2Q/V1j6o6KAJkKidWckC1ok/NHmzlTO8cDSYQGAZ3D+ZSiZnutODQluP63zCwr
ydYWJqnACiwZh6EkolAsf5zZlLhIf33nehdlSd24GDdYfeMLoTC0kY5VWIvIi3Uz
WsIPdlA81c6Zc244JC7Tww24fVygx7oVT0uDUhLMqKzApiNimA6RSAoQYfsTSbcH
9e66R+qlpndn4TJg5BSQS7ASSBEA4+VI4JJ/Mz6KZwgJ2MJF+CzXP1BfKhjWlZfJ
EAc+7aps+yqPVd+XR/3DXjdlUrjsjyZ1+jTK/F5gCpI2H19WM+xBwOFTD/1yIEER
frGvpvoHOR1ttzWeby/QTIao3H6SqOADDKZ8/lss784PMEfNFk+DKH50bST7DQmd
WKEDWrdNMDye25i5BV3z
=TEtl
-----END PGP SIGNATURE-----

--pFej7zHSL6C5fFIz--
