Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6079E3
	for <linux-serial@vger.kernel.org>; Sat, 23 Dec 2023 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGwud-0005Kp-E5; Sat, 23 Dec 2023 08:59:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGwuZ-000vxW-3R; Sat, 23 Dec 2023 08:59:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGwua-000Kut-0J;
	Sat, 23 Dec 2023 08:59:08 +0100
Date: Sat, 23 Dec 2023 08:59:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, Sergey Organov <sorganov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Tom Rix <trix@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] serial: imx: Correct clock error message in function
 probe()
Message-ID: <i3pzwocqgiqywcw2wj3q6oziofpivmmgsfqkaehsbt5ng2iehn@7zwfo7pke4wb>
References: <20231222220216.2188-1-cniedermaier@dh-electronics.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="obfaitnhbk2evnue"
Content-Disposition: inline
In-Reply-To: <20231222220216.2188-1-cniedermaier@dh-electronics.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org


--obfaitnhbk2evnue
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 22, 2023 at 11:02:16PM +0100, Christoph Niedermaier wrote:
> Correct the clock error message by changing the clock name.
>=20
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Fixes: 1e512d45332b ("serial: imx: add error messages when .probe fails")
Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--obfaitnhbk2evnue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWGk0sACgkQj4D7WH0S
/k74Swf/fUHtxQzsB4kVx98sjY0P5zstzKbUUtwi3oSnOXjgxTWMOqtbKxDjTu/g
yxOXI9cADKUEFqiTgjItxMumf7EaLi67bzbHgsw0/nT+ru2kIKc1XgkrYBdNjKA5
IjJVTGxztxLWIwIp0d8cjgIAG1XYuOjV2U8hQbWqOdidFpo5dshG6YEcRX+DQYnE
0/HOnn6VnUiEexT4ebCF7Snq7Btl/umLvmxz2G+y19BCd0iTkAS27MA+34jZyrH9
m1AYC3aCzrYpSG3XK28re8jiE5JTYBjxIFAlBYSqYwnRSxXbg/mhvB0OkqZg17eL
5NOTlXjqeKeoGPgtbmCMNkQUHLq/5g==
=72aG
-----END PGP SIGNATURE-----

--obfaitnhbk2evnue--
