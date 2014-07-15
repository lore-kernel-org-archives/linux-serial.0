From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 1/6] clk: sunxi: sun6i-apb0-gates: use
 bitmaps for valid gate indicies
Date: Tue, 15 Jul 2014 08:53:08 +0200
Message-ID: <20140715065308.GB3745@lukather>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
 <1404892479-12222-2-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBSNASOPAKGQE7U6ZGAI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404892479-12222-2-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 09, 2014 at 03:54:34PM +0800, Chen-Yu Tsai wrote:
> sun6i-apb0-gates uses the "clock-indices" DT property to indicate
> valid gate bits or holes in between. However, the rest of sunxi
> clock drivers use bitmaps for this purpose.
>=20
> This patch modifies sun6i-apb0-gates to use bitmaps as well, to be
> consistent with the sunxi platform. Also add the missing call to
> clk_register_clkdev, so system clock lookups will work.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Applied, and fixed the typo in the title.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxM/UAAoJEBx+YmzsjxAg7FkP/i14S5yrPSNZMyCrQKZydavq
0HI8Xoa2f9yO00KFy01tYAIzx4N2+Q/iAKJG4gumgATIDQEg/uK0r4bGFG6kBCKd
h2UBU78KfKJKdKqlkQeF48cexOhCgYtMiuizSQUS6iBQ9koy/u9Q7QbzjEo1XwcD
fKs7bRomwFrf38DW1jqApcqBlOMDeR/ahNJO+Ra2CK6NY5qAFo/DKpaNCWscyHQU
tObgc+JLfDydWamiOZTezTWk1RPEc9at3I36PDFpKaKfn6qcrQ2AYtOw2ao981xk
E2I5GDhMIHZ/uxFXKsBQpnSxrBy9zOWPqJPl0NqKiEUZyfWjd/NkV3q4wo4dCrJp
uBGKvkwl8ZC7W0QFAeZVg6n4IjQQ8kHPC5vGqvosYWyjJ7n8jeq3clFkBlKxmtkK
2Kd2ZiaeINzbobfux6AAElGt4TdYXSFXbbN0S0O1ngWd6gwvhqFqpMnEDhTnd7Rc
P+sPiZbuI5hHtEGru0WB31vG5Azuz45TdSYr6xHr58HxMRC9VlqJuDTa9gdwaeOO
5JcQ9uaqu5yN2kstxgFuKrFLE72t76s2t2iyfJGswJmSMbeSjekPYmvEltq3UsM6
X/vN9B8n19Tl93gaaUIpg6X85xZl78Ic+7GqRjMAvwM9R5h06ptHf75ZzyLRpQHU
jgpiKBxYvBthhuXi8jpI
=vCMH
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
