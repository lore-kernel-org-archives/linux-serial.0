From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 8/9] ARM: sun8i: Add PRCM clock and reset
 controller nodes to the DTSI
Date: Mon, 7 Jul 2014 10:58:58 +0200
Message-ID: <20140707085858.GG16262@lukather>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-9-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBE6D5GOQKGQEWU6X3NY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404399349-20237-9-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chen-Yu,

It looks mostly fine but...

On Thu, Jul 03, 2014 at 10:55:48PM +0800, Chen-Yu Tsai wrote:
> With sun8i PRCM support available, we can add the PRCM clock and
> reset controller nodes to the DTSI. Also update R_UART's clock
> phandle and add it's reset control phandle.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun8i-a23.dtsi | 48 ++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a=
23.dtsi
> index 79c4083..e10c708 100644
> --- a/arch/arm/boot/dts/sun8i-a23.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23.dtsi
> @@ -262,13 +262,59 @@
>  			interrupts =3D <1 9 0xf04>;
>  		};
> =20
> +		prcm@01f01400 {
> +			compatible =3D "allwinner,sun8i-a23-prcm";
> +			reg =3D <0x01f01400 0x200>;
> +
> +			ar100: ar100_clk {
> +				compatible =3D "fixed-factor-clock";
> +				#clock-cells =3D <0>;
> +				clock-div =3D <1>;
> +				clock-mult =3D <1>;
> +				clocks =3D <&osc24M>;
> +				clock-output-names =3D "ar100";
> +			};
> +
> +			ahb0: ahb0_clk {
> +				compatible =3D "fixed-factor-clock";
> +				#clock-cells =3D <0>;
> +				clock-div =3D <1>;
> +				clock-mult =3D <1>;
> +				clocks =3D <&ar100>;
> +				clock-output-names =3D "ahb0";
> +			};
> +
> +			apb0: apb0_clk {
> +				compatible =3D "allwinner,sun8i-a23-apb0-clk";
> +				#clock-cells =3D <0>;
> +				clocks =3D <&ahb0>;
> +				clock-output-names =3D "apb0";
> +			};
> +
> +			apb0_gates: apb0_gates_clk {
> +				compatible =3D "allwinner,sun8i-a23-apb0-gates-clk";
> +				#clock-cells =3D <1>;
> +				clocks =3D <&apb0>;
> +				clock-indices =3D <0>, <2>, <3>, <4>, <6>;

I realise you're just using the A31 code, but it's actually the only
clock so far that uses clock-indices, while all the other clocks
relies on a bitmask.

I'd prefer to remain consistent and use a bitmask here as well (that
would also mean removing the clock-indices related code in the A31
driver)

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTumFSAAoJEBx+YmzsjxAgjG8P/1f/A6X3lVGbsRMbeS56jSm1
7Ba24Ww74v7w6sm891rf5jf+Va1cDr7MlD5i5xHk3JBTlYKMJLOZGdvnq6Im9uKN
pFsZLiEWNGFZzPudLaRUiqafbeAwl+e1B5ITej2i6SBfzzQhX3OKoRNdHkshuTEw
M8vAW87ymMxM0chEILG2QwK4dp6TbC6vbQtAf4t/97MmzE7x7m9S+yItWthvvbdU
aZqbMRoVqC8ZpilERNPxbFtRnvumic9uo6T4/N2PxuIBmG/fi7m6LPMf0fZHoz4x
6anSjfJj/Eg3ZYaMWQhMuX9xgOV/0mSkkGnRWThB5hvFgoCRpBYBe+AyNYbgS1PI
UT4ODIH1kla5ITZtoou2gy7eUdwVqkafeAfNwUo831/p6nYhhGy2lCukPvo78yVu
nyEyCe/XxbN3HfWANHmZ0C7GYJaozc+7gX9mu30/Um6KF1CdvpoPXbkWdBDnjnDe
GoPrLe41/g3k/laQaike66v3ioNIkX3y7Usw1QJ7JNj7e/lu15uRo4lkbmxWw5Pf
OXyj6wi9OlwmkjhilfVetMIOhilwGlVUFuCFcVwD0TsUnc9rqFNmlNfxXfWDcyoW
1nKnRgIzuc8euiGYVfqyOYg5OpboB42iTXCDeqfIjBeVpcl9c60iHP8xLmNJuk8b
2c8nMbgsVyUM60lcn7pF
=OlTd
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
