From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] serial: efm32: use $vendor,$device scheme for compatible
 string
Date: Tue, 25 Mar 2014 15:26:11 +0100
Message-ID: <20140325142610.GB2863@katana>
References: <1395755954-18988-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57435 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285AbaCYO0O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Mar 2014 10:26:14 -0400
Content-Disposition: inline
In-Reply-To: <1395755954-18988-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-serial@vger.kernel.org, devicetree@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 02:59:14PM +0100, Uwe Kleine-K=F6nig wrote:
> Wolfgang Sang pointed out that "efm32,$device" is non-standard. So use the
> common scheme and prefix device with "efm32-". The old compatible string
> is left in place until arch/arm/boot/dts/efm32* is fixed.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMZICAAoJEBQN5MwUoCm2ZPQP/0+hS4WnG8sXEvpRHSt2bQ8i
/fV4hatTM9NHoxgcw/ldMN5pRPuSLIZeviaecFUlxMOJEHhuCk4X9cEWH7Re2bfS
OhA7bsVa+lLyQ8em+B9mAvwm+J+Oewr1H3ldA78kzUU35f6inuNigL++HzAiXkJB
WG9G70V1HoLI1V+8Du4FPMiO5LBe3P5j6o3lIjmdknOqTPsoQYI7YVGdKrbE/4zC
dKaayxjr+Klg/0rR2wQ+5uV5Fcp2HQr5mfcdOCSk9tMyYKRrkPqNIes0WCYF+gY0
Mr4IDFBdN8NXI6aXlDAHDk1U2dnoSvYrPvUZ9I76y6iWT5pv53dSc+dAQiSwmgSL
R01/nPbueE/kyZYOlop6my9uV0FKLntK5+pGDKVVWfZiO4pxLGEsYeRHQxO1HAFj
37OvvF9IXAeOMCC3EaPPkV+5DzyglAV/j9w1mWYDpxIkZ93s/G+kUcChavNrvCe8
tFdfenK96TzPxOoFdh48JU35OmAzAbu/CBz+U2glUinKRFcSsmqbeM3UTPSr/Ej+
kaLMjos33DdFQdTJKr/vq86up+qFyIkAtdr7t5cLTtZOfyjujEE1qiRkMFUaJJGh
r/0hrVwXcDRWv5NTIuO6wdEWhtX6otKpi0O5CO9397PlcYyGh+U8BaJilSH3ZAl4
AbGwxkRPff1+15aVsHOf
=DSvS
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
