From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 04/20] clk: sunxi: Fix gate indexing for sun6i-a31-apb0-gates
Date: Wed, 18 Jun 2014 11:38:50 +0200
Message-ID: <20140618093850.GJ19730@lukather>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-5-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKy6e3LXpfmanBFM"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB7V4QWOQKGQE5OFJBUA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403016777-15121-5-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--tKy6e3LXpfmanBFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 10:52:41PM +0800, Chen-Yu Tsai wrote:
> sun6i-a31-apb0-gates supports using clock-indices for holes between
> individual gates. However, the driver passes the number of gates
> registered in clk_data->clk_num, which of_clk_src_onecell_get uses
> to recognize the range of valid indices a consumer can use.
>=20
> This patch makes the driver pass the maximum gate index + 1, so
> of_clk_src_onecell_get does not complain about indices greater
> than gates registered.
>=20
> This was tested on the A23 SoC, which has a similar APB0 clock,
> but has holes for gates to removed IP blocks.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--tKy6e3LXpfmanBFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToV4qAAoJEBx+YmzsjxAgLb4P+wRQ/AAQw6rsywCFTZY8xj5Z
e9shBl7/VbZXetPPo40yuk9QS4H2Fy6iYyx9SBYM22ToQvtyXtIQXpoRgOQnY/2i
l2rf8C7II7qlSZklSQsYTEr+0WtPjQPp7i7t0i2mqp3xWII8wP66pLmKJ8RH3XU4
5hmkZZJ+1ViR1MPHbtA3RY6GlIZ43+tYFJiEvzyKVJ0WzpIEcSShyb6DWUxM8Y/6
GEIlFslFJds9oDRqy/paFsgW5EyfiPm4O4kgA/C2JV4KHB5Zs8hOnREE+3Bjw67m
exirHbAjUVaLda9bv/6JS6s8DrmjAlJYdAY/LnzUkea+sR2O61O8sN7+BNjaDXKN
zo65CDf3G/tdjF0c2sZ0SH0SO6MS+1LXmOB7fOQttEOnFzipVZtHYb5y84TLEi5k
SWaip6Csy2eRiTD/P6GAXDsLoQLVzelCXLJuOtowshD72uMuA6qGC8B8L+zv+CjQ
zX5T1SsNfXPEHCLyRoeUTsUYZPueR26BKstTVvfiaCqfETCCsHygNpTI4qI/wP+b
RxT7CT93QlU/S98lln/M23o6CTWbXMTu6ui2E1gehxBH+BxznZGd8Y8Ftc5a23Be
3f7soY8nmuaR3hcPE/onOq8iq/geJ5wuR5ffksemQRGNdIBWMDCMHormXLm5l+DP
rVKmBl8rdbYL8t6GkVYM
=SWQl
-----END PGP SIGNATURE-----

--tKy6e3LXpfmanBFM--
