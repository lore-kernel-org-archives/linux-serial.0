From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 12/20] clk: sunxi: Add A23 APB0 support
 to sun6i-a31-apb0-clk
Date: Thu, 19 Jun 2014 11:28:47 +0200
Message-ID: <20140619092847.GW19730@lukather>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-13-git-send-email-wens@csie.org>
 <20140618102623.GQ19730@lukather>
 <CAGb2v64D6qBtXGXzn25443s_oj_=Z-u_P6+-MX52Lz54+9bQyQ@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9I0HVnGRacHebCDW"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBHO3RKOQKGQEWZZBF5I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v64D6qBtXGXzn25443s_oj_=Z-u_P6+-MX52Lz54+9bQyQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--9I0HVnGRacHebCDW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2014 at 12:33:41PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jun 18, 2014 at 6:26 PM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > On Tue, Jun 17, 2014 at 10:52:49PM +0800, Chen-Yu Tsai wrote:
> >> The A23 has an almost identical PRCM clock tree. The difference in
> >> the APB0 clock is the smallest divisor is 1, instead of 2.
> >>
> >> This patch extends the sun6i-a31-apb0-clk driver to take divider
> >> tables associated to compatibles, and adds a compatible for the A23
> >> variant.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> >> ---
> >>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
> >>  drivers/clk/sunxi/clk-sun6i-apb0.c                | 28 ++++++++++++++=
++++-----
> >>  2 files changed, 23 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Docum=
entation/devicetree/bindings/clock/sunxi.txt
> >> index af9e47d..e3a47ec 100644
> >> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> >> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> @@ -28,6 +28,7 @@ Required properties:
> >>       "allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
> >>       "allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
> >>       "allwinner,sun6i-a31-apb0-clk" - for the APB0 clock on A31
> >> +     "allwinner,sun8i-a23-apb0-clk" - for the APB0 clock on A23
> >>       "allwinner,sun4i-a10-apb0-gates-clk" - for the APB0 gates on A10
> >>       "allwinner,sun5i-a13-apb0-gates-clk" - for the APB0 gates on A13
> >>       "allwinner,sun5i-a10s-apb0-gates-clk" - for the APB0 gates on A1=
0s
> >> diff --git a/drivers/clk/sunxi/clk-sun6i-apb0.c b/drivers/clk/sunxi/cl=
k-sun6i-apb0.c
> >> index 11f17c3..2197ac7 100644
> >> --- a/drivers/clk/sunxi/clk-sun6i-apb0.c
> >> +++ b/drivers/clk/sunxi/clk-sun6i-apb0.c
> >> @@ -11,6 +11,7 @@
> >>  #include <linux/clk-provider.h>
> >>  #include <linux/module.h>
> >>  #include <linux/of.h>
> >> +#include <linux/of_device.h>
> >>  #include <linux/platform_device.h>
> >>
> >>  /*
> >> @@ -28,6 +29,21 @@ static const struct clk_div_table sun6i_a31_apb0_di=
vs[] =3D {
>=20
> For reference:
>=20
> static const struct clk_div_table sun6i_a31_apb0_divs[] =3D {
>         { .val =3D 0, .div =3D 2, },
>         { .val =3D 1, .div =3D 2, },
>         { .val =3D 2, .div =3D 4, },
>         { .val =3D 3, .div =3D 8, },
>         { /* sentinel */ },
> };
>=20
>=20
> >>       { /* sentinel */ },
> >>  };
> >>
> >> +/* The A23 APB0 clock has a standard power of 2 divisor */
> >
> > Why not just pass CLK_DIVIDER_POWER_OF_TWO then, instead of a table?
>=20
> The A31 APB0 clock uses a table for the odd /2 divisor for value 0.
> The standard table I'm using for the A23 is just to keep it simple
> and alike.
>=20
> >> +static const struct clk_div_table sun8i_a23_apb0_divs[] =3D {
> >> +     { .val =3D 0, .div =3D 1, },
> >> +     { .val =3D 1, .div =3D 2, },
> >> +     { .val =3D 2, .div =3D 4, },
> >> +     { .val =3D 3, .div =3D 8, },
> >> +     { /* sentinel */ },
> >> +};
> >> +
> >> +const struct of_device_id sun6i_a31_apb0_clk_dt_ids[] =3D {
> >> +     { .compatible =3D "allwinner,sun6i-a31-apb0-clk", .data =3D &sun=
6i_a31_apb0_divs },
> >> +     { .compatible =3D "allwinner,sun8i-a23-apb0-clk", .data =3D &sun=
8i_a23_apb0_divs },
> >> +     { /* sentinel */ }
> >> +};
> >> +
> >>  static int sun6i_a31_apb0_clk_probe(struct platform_device *pdev)
> >>  {
> >>       struct device_node *np =3D pdev->dev.of_node;
> >> @@ -36,12 +52,17 @@ static int sun6i_a31_apb0_clk_probe(struct platfor=
m_device *pdev)
> >>       struct resource *r;
> >>       void __iomem *reg;
> >>       struct clk *clk;
> >> +     const struct of_device_id *device;
> >>
> >>       r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>       reg =3D devm_ioremap_resource(&pdev->dev, r);
> >>       if (IS_ERR(reg))
> >>               return PTR_ERR(reg);
> >>
> >> +     device =3D of_match_device(sun6i_a31_apb0_clk_dt_ids, &pdev->dev=
);
> >> +     if (!device)
> >> +             return -EINVAL;
> >> +
> >>       clk_parent =3D of_clk_get_parent_name(np, 0);
> >>       if (!clk_parent)
> >>               return -EINVAL;
> >> @@ -49,7 +70,7 @@ static int sun6i_a31_apb0_clk_probe(struct platform_=
device *pdev)
> >>       of_property_read_string(np, "clock-output-names", &clk_name);
> >>
> >>       clk =3D clk_register_divider_table(&pdev->dev, clk_name, clk_par=
ent,
> >> -                                      0, reg, 0, 2, 0, sun6i_a31_apb0=
_divs,
> >> +                                      0, reg, 0, 2, 0, device->data,
> >
> > I'm not sure that it will actually work for the A31, since it does
> > define some dividers anyway, and the divider table is !NULL, even
> > though there's actually no dividers defined.
>=20
> I'm not following. The A31 does have a table defined. It's just cut
> off in this patch. I asked Boris to add the table when he was working
> on the A31 PRCM clocks. See above.

Ah right. My bad.

If these two clocks are these different though, maybe it would just be
easier to add a new driver. These are trivial enough anyway.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--9I0HVnGRacHebCDW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToq1PAAoJEBx+YmzsjxAg5tUP/2stiaLgscHuFsIat0WDUwmt
5nhU0wKP5YyskkDpsLncJizyBggF9DS6/CopS6Lr76v2R9B4s4knGHtSOsQ8YNFR
/Ea1NNRd4zhwQSFX0MVH2JA/XcfQ0/54rXjEBqmoXTyH4IdJgkqrLyr98ayqBgtA
txE2rxpHTlns8H4LhqCDu/D+pcch45MCcn5UP8Irwu8wZPfhgxr3XXDqO6MDdenX
02m53fKzIKHUtZXt2TE2Dr65Rrz2hloCUEZ2sbey6s6D73CTNwK019Xkm/3IOeri
Mzg4Ielz14mKZf2UeLUzjBPllabdnk1QyE1wEBcDPqDF/ihtHASXEKmow2tydkt/
a3/gGQD26RgrhMEujW0xQCeS52l6lIAG8QQA7ExPKhOp4J+D43u53SPy8Sv8T00O
1JCawxb4lGHFTdZx4hCqazWZQFKFo2YV6KkJUzmjNeQzH1Ful1ljHYCcE11Zy6H/
loRC/irv+SOozuNosRo65/jU+XR9baLc+R9rz/jX6PWRPqXsJ3HirJBChIElOYGG
mZjeHmnpfhrj4hTku/Yxaz5R1dDpBcQnXIFPc/6RzW2t2sjtjdJaUE7F5p46rgBj
V+W5OSTdEyCJwda5ZVBYUXXQfkr+ahmCfEbzEf5XFPite1rr8LATA3zWUUyNx9EE
LUbrLpFI9jgRTybvZiq7
=01Zg
-----END PGP SIGNATURE-----

--9I0HVnGRacHebCDW--
