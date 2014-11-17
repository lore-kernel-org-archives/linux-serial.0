From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 2/5] i2c: pxa: prepare/unprepare clocks
Date: Mon, 17 Nov 2014 19:26:46 +0100
Message-ID: <20141117182646.GD12644@katana>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416236863-20898-2-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 06:07:40PM +0300, Dmitry Eremin-Solenikov wrote:
> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unprepare().

You describe what is done but we can see that from the patch. Please
describe here why the change is needed.

>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index be671f7..2e75375 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1297,7 +1297,7 @@ static int i2c_pxa_suspend_noirq(struct device *dev)
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct pxa_i2c *i2c =3D platform_get_drvdata(pdev);
> =20
> -	clk_disable(i2c->clk);
> +	clk_disable_unprepare(i2c->clk);
> =20
>  	return 0;
>  }
> @@ -1307,7 +1307,7 @@ static int i2c_pxa_resume_noirq(struct device *dev)
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct pxa_i2c *i2c =3D platform_get_drvdata(pdev);
> =20
> -	clk_enable(i2c->clk);
> +	clk_prepare_enable(i2c->clk);
>  	i2c_pxa_reset(i2c);
> =20
>  	return 0;
> --=20
> 2.1.1
>=20

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUaj3lAAoJEBQN5MwUoCm2voIP/3pBFRQGIKFtRkxJ+gELDXpC
B+R8bx9hVpfQZa3Nl5Qg/OiefymyNHHaebWkZYVTm7RB9pQjyWJN6sBpdBeFTFT+
mrExCAfyOgD4riqgvpAmGPEyjwqmf+AiU/HIfdAzvsSp80kmP7Zb9ondX0cJ1C9n
avpP1G0pqs//mdFPkRc4SYdlNVHwHWKTuW3Xtk1t1GDmnGOK2o8HJOSMV4vM7s1d
+rJSeUjmazasZnxd5PWAl6t7Uh929un+vp1eSGMwEfiFpMYbytc8xZuVMiWkzbA8
/aYgyhsXtb0SM2aWp59Z4NxhTRBQwSvQMKG2pHp9PaJOxv1iOWD+csMPraX3nbMR
HjjyFWIapu3q7Rfd43oA33NSP141l49jSjTiRZTSe45+UwKhp9MyoIEJlz4TvRFa
06q+7Q99LbndJMSSTXe1hSK7GgI3XQ2c06evvp8t44KWOi7s54FRoxFKIngMJs7N
zc2fMeFeMjDeDUWgDib48EdUx3oMQ07X3pL5YBqyITUB8j+ZjYnuOW4zFdAddpCO
3GiK2A1bakn5RXrWeZFE/O0IZqN94NlD+M6MKWciXh0wp/qksRF2SmCBLg6SfWLF
WWh+WFpDvW8tnBSV4Vn+5TgVBQZNxmTOeOx3NMvPvx9YGusWxcDiqbhA0J4n5L2F
Zpa9CdpDQ7YNfRBlHm3W
=dlj6
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
