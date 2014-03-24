From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] serial: efm32: properly namespace location property
Date: Mon, 24 Mar 2014 14:42:22 +0100
Message-ID: <20140324134221.GC2631@katana>
References: <1394813009-22796-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58158 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882AbaCXNmZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Mar 2014 09:42:25 -0400
Content-Disposition: inline
In-Reply-To: <1394813009-22796-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-serial@vger.kernel.org, devicetree@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2014 at 05:03:29PM +0100, Uwe Kleine-K=F6nig wrote:
> While reviewing an i2c driver for efm32 that needs a similar property
> Wolfram Sang pointed out that "location" is a too generic name for someth=
ing
> that is efm32 specific. So add an appropriate namespace and fall back to =
the
> generic name in case of failure.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMDY9AAoJEBQN5MwUoCm2tgwP/1t3CAZBhpZVHMIvQcT00p6j
jvskZRLpyyi2qzgx/AWdI4p+j93gtmten81TtwyGc0CVPIPfbEke2lpJEPZJkwM0
Tt0nxBKPnzUL9ViLDqHf7bSchAM4I4Age8VRf1TBEeD0z/mdDagvSj73LEraiMxo
hyeiWk9u+HDaaKJc7JVzjMLhT4livSuGzsxkH7TnFA9N/U/oBxn8B2xQ0th07Bws
RHFzKtNx6wcYg02qcOnjrhDigXzM++1IJEyHbz3MGfJY4F+3ZSvWLtUBx/CH0TYK
TXTanm+tOQ0xegE9qZ0YUUM5oVN59e5JsUs1cHUCv5iRIuoeeJKRuEi69Lry8DK3
zRFN9fAgIaQqj2tJnTL5E6AG2+6fbucWa3cf7REDR3JjXahl0WhoyEw4nyrcEkQx
nwJiMqDWtPdes1tmXLsrHIzS1h0eMOcb9M8F1Gq927PuVoS15KDRGFMpTBJh+D2D
suBLY/fdk/bqHDyQgx9qSNc8MV3ruOqKde33hJhZUVAEOSl+N3GxCxZ5W401VPyX
LK3v1zFMlZK7RcPCkQ6P/bUUjuBYnAF6boIamwM5+qvdhfpdg0vcu4pfm4YjLswZ
q/5N8+aL7qZulpNa40EbfG7cT21NMn+zHAYwgv+s8SRV+gWRrbtupEsnsVgS/+5C
QhN+OsqNVl+ohNpwATD/
=8tfA
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
