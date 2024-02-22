Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7012FF73
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608994; cv=none; b=U5TDbq3ACAQeKOeBjYq18e5Q39HYdb0e9kd+kQqoA/Q6+1sd9zOU6QH0sajYcDwXdEOORvg4UZShlg8+XPkmURSZB3z64ttN6Su8h3bsh2uwZRR3UwaTzjRA5rof418GFp5wJvSEKFrbL3ZH696iXBPvSoX2HcFtfFHRJh1eyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608994; c=relaxed/simple;
	bh=irxjJD3PiynDP0wfUrxD1irszzq83N2k/2Mbrj2bvRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2hfLfRFaZ1e0i2S0W1Q6k4ZNbz08mH6y9X+SQEw4ASZeEjv+fja0cp7YZaMiHL1RZuFbkDbNQUGA8q+amA2tIPa7R85H0fwT+bIbtFPjN6dEDZdP5RU3m8Gm31L56//NeGNw5ltlK2VQpgwTsXUEMiMoTWOZgjrqHvrvugmxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rd9FP-0005EE-Sf; Thu, 22 Feb 2024 14:36:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rd9FP-002F3W-2Y; Thu, 22 Feb 2024 14:36:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rd9FO-009RoR-3C;
	Thu, 22 Feb 2024 14:36:23 +0100
Date: Thu, 22 Feb 2024 14:36:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-serial <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
Message-ID: <rxbnydqttxdduseprrnugirdvndznbfpi3q2nxctxdelhoc6t6@7aj4jmzvorv4>
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
 <786cecc3-4723-4b96-679e-1ea9736d3f6b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pqsfx2obw3z65pwc"
Content-Disposition: inline
In-Reply-To: <786cecc3-4723-4b96-679e-1ea9736d3f6b@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org


--pqsfx2obw3z65pwc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ilpo,

On Thu, Feb 22, 2024 at 01:50:40PM +0200, Ilpo J=E4rvinen wrote:
> On Thu, 22 Feb 2024, Uwe Kleine-K=F6nig wrote:
>=20
> > Instead of silently giving up, at least tell what the problem is.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index 2d1f350a4bea..94aa3dddb71e 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -597,7 +597,8 @@ static int dw8250_probe(struct platform_device *pde=
v)
> >  	if (data->clk =3D=3D NULL)
> >  		data->clk =3D devm_clk_get_optional_enabled(dev, NULL);
> >  	if (IS_ERR(data->clk))
> > -		return PTR_ERR(data->clk);
> > +		return dev_err_probe(dev, PTR_ERR(data->clk),
> > +				     "failed to get baudclk\n");
>=20
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Thanks. Is the expectation now with your tag that Greg (added to Cc:)
picks up this patch?=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pqsfx2obw3z65pwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXXTcoACgkQj4D7WH0S
/k5Aywf+Lqow6tzHRgitfvEXVhTH6mXofzh9JtYRp+VSEZ0mf85SsOR4RpkANj7V
VlZ42VQoKBpudJ1u+1AGqSUUW07T6x6iM+VDAP/rMu8t0vEWD1zPd/Et3yBNDFeH
EIHIrle47bFwFU9Gc8ysPOgzn7lDZVVoZWieWPACZgXNc1ny9HxnpsKsulMozxpH
CRYDx2mRfvlbbwAitTNi4YsixHdO0LmAwtvKMP1EfGZ+ueScz9RUHFAYG+HWZfzm
zFbeq8e54j6Qh36GljBL5/NmFi/1BgQSxTKbYFfu6jdtDnIHS0XDL3I4sMY3P+V5
xjaN4I0SZh0RUqv/mNwTdikldyoJaw==
=SMa7
-----END PGP SIGNATURE-----

--pqsfx2obw3z65pwc--
