From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/3] can: simplify LED trigger handling
Date: Tue, 8 May 2018 13:04:01 +0200
Message-ID: <7135a44f-85db-758b-cf51-1a924e114e9b@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-3-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gYZvSXtRcjeVT1CDJqBXsIpJ6D8Hcz2nk"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508100543.12559-3-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, linux-serial@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Robin Murphy <robin.murphy@arm.com>, linux-leds@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gYZvSXtRcjeVT1CDJqBXsIpJ6D8Hcz2nk
Content-Type: multipart/mixed; boundary="0ICkFqecWJdx7A8SxnvOHdXHqUwrKryoo";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Florian Fainelli <f.fainelli@gmail.com>, linux-serial@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de, Robin Murphy <robin.murphy@arm.com>,
 linux-leds@vger.kernel.org
Message-ID: <7135a44f-85db-758b-cf51-1a924e114e9b@pengutronix.de>
Subject: Re: [PATCH v3 2/3] can: simplify LED trigger handling
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20180508100543.12559-3-u.kleine-koenig@pengutronix.de>

--0ICkFqecWJdx7A8SxnvOHdXHqUwrKryoo
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 05/08/2018 12:05 PM, Uwe Kleine-K=C3=B6nig wrote:
> The new function led_trigger_register_format allows one to simplify LED=

> trigger handling considerably.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0ICkFqecWJdx7A8SxnvOHdXHqUwrKryoo--

--gYZvSXtRcjeVT1CDJqBXsIpJ6D8Hcz2nk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlrxhCQACgkQk9IU1zQo
ZfFpIggAio5/LgOFMhPfvaQGn/D3Xx2ZmwOT3sK4d70czLJhGXVBr1gRgxsJ7Afg
Y9dHffyMcs4Eb9Rc+ziO7XzUPd7bWf1AgXOmE61Q9NbuQrwNMlNBRaNo6Eo1Watp
Q/QcHRmIEwjUsFz18nesRMhiPGCEvvwaflA+iKApp1zSVmxPoGqBo23YS2gNdwmt
ZeaIHuNJWfFlnLxAsqhHM3H1NLvUyQNvwqzhLyqtL5/l/sup9Yxe4SmBdXP8iKhx
2ikoINhAS4E3PI/GGeW5plwlk8O8VmThnPaSCJkQCmPg9ipg1HYVKvWToLsdUopf
Ount8LLdEnaWb+4pv51phN34736+dQ==
=osvr
-----END PGP SIGNATURE-----

--gYZvSXtRcjeVT1CDJqBXsIpJ6D8Hcz2nk--
