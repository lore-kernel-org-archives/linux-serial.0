Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C96154446
	for <linux-serial@vger.kernel.org>; Mon, 15 Apr 2024 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211485; cv=none; b=OCxXiv83bi5Se4g0NY6u5XGGNPlRCDW115PpSNVaW6TC4v+vzmRREZv3UOvzzRTSSI7b716N2gqHYYeUwFHwrgnJ7L3r8JgqXsnl5SsGo3jv+UHY+vXKh8H0mWMvyJzscv5ydDLQxRTccS84TN7F9Xgq02Spw5PIjvezpNWbC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211485; c=relaxed/simple;
	bh=FUvyAUTP6GC5X/RfNh707fyQNuadrWN8P49nP+xtWxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/OqfWVmhzGECjiUsMcgKmhSsdnSWueGZg7Lgm2C37bvuavAHqGpyyn1Lu2Dpx6oxdFFPt4szY0wJihu3gdVbzJGyzrlV+b8Fa04k7iA1UjmtL7dmNWDxBb5RYXF+8FlKOBCJyIAp+dxhtYTuvJ473jJvo4zysC8cibgywHIfk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwSZE-0007d0-SN; Mon, 15 Apr 2024 22:04:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwSZD-00CTxu-L7; Mon, 15 Apr 2024 22:04:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwSZD-001qIN-1q;
	Mon, 15 Apr 2024 22:04:39 +0200
Date: Mon, 15 Apr 2024 22:04:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: Re: NULL pointer dereference when closing a busy UART
Message-ID: <p5eesytdhdrqo5ep2nazsm4ft6oc2dw5wb3goqo5use75f6fsg@ivsxlgyyadot>
References: <luomji4bv5c54xq442csgd2ifdacjrme7bomnwbviw6pmalpgv@5uusgu3vgybm>
 <Zh2BzD3qW1j1GR_o@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ruypkfx3eeagmv5c"
Content-Disposition: inline
In-Reply-To: <Zh2BzD3qW1j1GR_o@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org


--ruypkfx3eeagmv5c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, Apr 15, 2024 at 10:36:44PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 15, 2024 at 07:15:54PM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> ...
>=20
> > I didn't try to test if older kernel behave better, yet.
> >=20
> > Any ideas? Does this ring a bell?
>=20
> Does this
>=20
> 9cf7ea2eeb74 serial: core: Clearing the circular buffer before NULLifying=
 it
>=20
> fix it?

It doesn't. I mentioned that in my report (though with the wrong commit
hash, I used the commit hash of the cherry picked commit *sigh*)
=20
> You might need this
>=20
> 1aa4ad4eb695 serial: core: Fix missing shutdown and startup for serial ba=
se port
>=20
> on top btw.

Ah, that looks exactly like my issue. Thanks, I will test that an report
back.

Thanks a ton,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ruypkfx3eeagmv5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYdiFYACgkQj4D7WH0S
/k5M3wf/XEN7HYREBZCLequ7N9jD7S/nouDxz+Ji8r8I1NGCGUWYdmv3gQJvdfxh
GG7+kVfbThY8Cy+BN7cD7Ieoghs6MGyOHgBDKEohFULR5yk6Q1Vkl7aeA8u7yvbh
hPN9fhLUFip1OlhplJKX7ThXvY9ABrTYI78DSe2bmuMJJ51CDULl7iZg1UmXssOB
/froaQkBbP4xqTX2GQAY1JeQzh/j81h1wAvRkNGduvtAEaDjd1bfs2ffdRbLfXHX
qiWPNTvQ5VRqp7VBbQPJmnrm1a751ZrltAl2JWO3J2wna+rl1X3rFQI6wkaz04Yu
VYfO+4JDX+APEiMcuif7MGX2OSy+KQ==
=crbs
-----END PGP SIGNATURE-----

--ruypkfx3eeagmv5c--
