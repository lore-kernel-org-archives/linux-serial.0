Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27760873
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611956; cv=none; b=tg7ZUm6YCLpCgMQIxFMMYD2csJPcaNGxGc10uOxWfwhGRZzx+/iyBEQod5TCEeQYnBBWEOAwkgeQqy/22N3Yv6NZ+9Yi8wbmmSjYO7ek5ltFP6feImJCdwxD5m6xiqT5Zd/0i+GHjRLeXBELuZtuszvIjAsytmse00yqrvUnWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611956; c=relaxed/simple;
	bh=Gu3qoE0LKg1NeLvl/FhgL1yHAZRpFB74K5aTVZvcbC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2NHDA65Xo3iOrmZsLEm5zTEEcucY9vNyQcGjN3BZynQ8noXV+hWtb1la/RvG4mSmsfHsJRR2LQKCckAeI7MwRc/IpjqoSHKA0cRPNMm6CuVmifzW89wff7/a75ddHHsERcobH6GgW10ZRsCxT7UUkBni8JvKA9NCv9TzYTPwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdA1B-0004EF-Kr; Thu, 22 Feb 2024 15:25:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdA1A-002FWm-RG; Thu, 22 Feb 2024 15:25:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdA1A-009UCH-2T;
	Thu, 22 Feb 2024 15:25:44 +0100
Date: Thu, 22 Feb 2024 15:24:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-serial <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
Message-ID: <weizcvfyvimmwzem2huhtrtd77twp4x2vwblnamqcmuchjzqyn@xizla7laqmew>
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
 <786cecc3-4723-4b96-679e-1ea9736d3f6b@linux.intel.com>
 <rxbnydqttxdduseprrnugirdvndznbfpi3q2nxctxdelhoc6t6@7aj4jmzvorv4>
 <3dca13d5-6ee4-e417-577f-79a5b16eb469@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z4if6sljxn6gtfze"
Content-Disposition: inline
In-Reply-To: <3dca13d5-6ee4-e417-577f-79a5b16eb469@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org


--z4if6sljxn6gtfze
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Feb 22, 2024 at 03:48:48PM +0200, Ilpo J=E4rvinen wrote:
> On Thu, 22 Feb 2024, Uwe Kleine-K=F6nig wrote:
> > On Thu, Feb 22, 2024 at 01:50:40PM +0200, Ilpo J=E4rvinen wrote:
> > > On Thu, 22 Feb 2024, Uwe Kleine-K=F6nig wrote:
> > >=20
> > > > Instead of silently giving up, at least tell what the problem is.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_dw.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial=
/8250/8250_dw.c
> > > > index 2d1f350a4bea..94aa3dddb71e 100644
> > > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > > @@ -597,7 +597,8 @@ static int dw8250_probe(struct platform_device =
*pdev)
> > > >  	if (data->clk =3D=3D NULL)
> > > >  		data->clk =3D devm_clk_get_optional_enabled(dev, NULL);
> > > >  	if (IS_ERR(data->clk))
> > > > -		return PTR_ERR(data->clk);
> > > > +		return dev_err_probe(dev, PTR_ERR(data->clk),
> > > > +				     "failed to get baudclk\n");
> > >=20
> > > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
> > Thanks. Is the expectation now with your tag that Greg (added to Cc:)
> > picks up this patch?=20
>=20
> Yes, Greg handles applying serial patches. There's just too low volume of=
=20
> patches for it be useful for me to setup some an intermediate tree for=20
> 8250_dw/lpss only.

Yeah, I thought so, I just wondered if that also works if Greg isn't in
the list of recipents. But that should be fixed now, too.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--z4if6sljxn6gtfze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXXWRwACgkQj4D7WH0S
/k5Tiwf+MSX0/BKPBkD+GtUph0RT7BelumqitVcNB/IGRvNPfdGCMIOD+mWR853S
ofmntMM7ZlrBJ0r/p8qwYoeNhmMdFalqfmkEwOmacWLNrCva3ABPP6pKhYNhKKU0
k2KWvLP3FkO6ezxvZCLoX43LDm2DN5X95O8CbqrABvAOug/deyoLqwi4D1qDbNYe
QiZhRY4wuWqXSglbtEk6QCaR4o1ETkNLUGCDfiHuBnPQcl285yhNShhK8IG71jPp
QqBinfkuDbs4NBB2f00oQ6Lwlu/NtFewy6PHFfAWT1EXRArCM3GwYcyF1Z0wenRX
rJ5WsegpqDIZtDNuYgCsjtosiKQy3w==
=k8vF
-----END PGP SIGNATURE-----

--z4if6sljxn6gtfze--
