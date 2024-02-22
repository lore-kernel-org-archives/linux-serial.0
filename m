Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4514B80D
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627035; cv=none; b=n/uaBbh8zekEiMe8IG5G+JWnjNxaQh/UL0pEGLlD0J3nV06ri0ijhLiOCiBPDEEidJUy5swDACB6XvwKA0PeHCDGdJq+v4mgyAeOp+AfQX7gbAG2HhP/0Vzja99NftkkA+iERyE7FKxvau8SYXLwpgo6Jscsi1c7YKAxL9o2Xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627035; c=relaxed/simple;
	bh=x1pzPtFxpdN3CdTEJMgcRG857wg44+RmaVPVmCImQZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv82VUo74niGmJhZ5BfqSF+QjgL6oxRbdeplz2oxMKm1RnPwW0STyRubIv3c/dMMAMY3suEjMeKQeb5nKUCHH1Fag20RNWn4+Hd2WbFe/rD1KCgubDxEI7LUMslG7ql8Wr0pCVec/yFiDpqC+IaSAPtnXAdYeCzAHU5CfKZ0TPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdDwO-0000u3-I2; Thu, 22 Feb 2024 19:37:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdDwN-002HXL-Rf; Thu, 22 Feb 2024 19:37:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdDwN-009cqW-2V;
	Thu, 22 Feb 2024 19:37:03 +0100
Date: Thu, 22 Feb 2024 19:37:03 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
Message-ID: <vzg2a2mo32ydgp3kfzkzywkbopzmkrkmp2vp4ufqxnrq4gq2mf@m4nwxl5edqgt>
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
 <ZddkMsRt1D0nTnj8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54rzcqnftudjxycy"
Content-Disposition: inline
In-Reply-To: <ZddkMsRt1D0nTnj8@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org


--54rzcqnftudjxycy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Thu, Feb 22, 2024 at 05:11:46PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 22, 2024 at 12:19:23PM +0100, Uwe Kleine-K=F6nig wrote:
> > Instead of silently giving up, at least tell what the problem is.
>=20
> ...
>=20
> > -		return PTR_ERR(data->clk);
> > +		return dev_err_probe(dev, PTR_ERR(data->clk),
> > +				     "failed to get baudclk\n");
>=20
> Why not on a single line? We are fine with relaxed limits.

At least around my change I didn't spot a line that makes use of the
relaxed limits, so I sticked to the overall style.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--54rzcqnftudjxycy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXXlE4ACgkQj4D7WH0S
/k6ZmAf/ZaQbThm91GrYSh/4IJWKOwXbvDRHYUu+uv7LRlLexNex1FimDf9W8Be1
9OR6zYKVUlhLbSSDbDgr5an8X6ucqLtcYv65a2EMt93FE937ATvlI0pkNtdTypsi
urITUH0b3/yNhUVo4pRLGzHE7e9BeMXoSlPVgX8NrYOqAxSoEztWym+yTtpcURUf
4tEXoib+JXdFPS299bv3oHJNn5n2TtTDjvZ/GRQ9X9wXxdhKtrskoDT8KJAC80q4
uSFfAzsYlTh317d3Q+gaZIxJicF6RbmisqyQOk4SLDFE/Qee/u74BN2R+nE2yFyr
VKF7pomgfjKtTsm+qxVsVB2pF9POOA==
=NMdq
-----END PGP SIGNATURE-----

--54rzcqnftudjxycy--
