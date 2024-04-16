Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AA2907
	for <linux-serial@vger.kernel.org>; Tue, 16 Apr 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261146; cv=none; b=eYSGiMbYOldUPR8pu058vXCFxvPwMkRLS5TmdFLfhrEgwr7kC9MRT0ebodjDfd1hIZOdevwAuK1ikrR7vGvIMKtthddgjMYNeURDTNzpUKTxT1E9ILnGRtCdVtleJvk5+MakgpJrhGRRFCc/jAzghmtFyj7nbVYp0joA/sBZZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261146; c=relaxed/simple;
	bh=4L6qARZneapmN2Y/cVCt7GPhbe0aa+SjmMIrHGbax+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJDULdYRp+HxWAXY7jqbrPNvE4WauNGRD/3n0CQsR8qVRT0vWJgtOJnh6jwVbmIL0q/ggvPKaenL+b+9SqdRuqYAx5la/ShOTAOv1xEtWh2Lx4uy+xu3lDNFfSovDTDw18Tfsf4Ms//q1K44KFXAl9sc4w8XNCnOj6S5kDgaTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwfUC-0001WO-U1; Tue, 16 Apr 2024 11:52:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwfUB-00CaJw-Qz; Tue, 16 Apr 2024 11:52:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwfUB-0024cM-2R;
	Tue, 16 Apr 2024 11:52:19 +0200
Date: Tue, 16 Apr 2024 11:52:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: Re: NULL pointer dereference when closing a busy UART
Message-ID: <nhwtgw543mkannfwvtqi3oap3xrscs66gsg56cpojxnfhjbrv3@s5fqkhvyjrfh>
References: <luomji4bv5c54xq442csgd2ifdacjrme7bomnwbviw6pmalpgv@5uusgu3vgybm>
 <Zh2BzD3qW1j1GR_o@smile.fi.intel.com>
 <p5eesytdhdrqo5ep2nazsm4ft6oc2dw5wb3goqo5use75f6fsg@ivsxlgyyadot>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6w4mjjysdcfd4xi7"
Content-Disposition: inline
In-Reply-To: <p5eesytdhdrqo5ep2nazsm4ft6oc2dw5wb3goqo5use75f6fsg@ivsxlgyyadot>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org


--6w4mjjysdcfd4xi7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, Apr 15, 2024 at 10:04:39PM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Apr 15, 2024 at 10:36:44PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 15, 2024 at 07:15:54PM +0200, Uwe Kleine-K=F6nig wrote:
> >=20
> > ...
> >=20
> > > I didn't try to test if older kernel behave better, yet.
> > >=20
> > > Any ideas? Does this ring a bell?
> >=20
> > Does this
> >=20
> > 9cf7ea2eeb74 serial: core: Clearing the circular buffer before NULLifyi=
ng it
> >=20
> > fix it?
>=20
> It doesn't. I mentioned that in my report (though with the wrong commit
> hash, I used the commit hash of the cherry picked commit *sigh*)
> =20
> > You might need this
> >=20
> > 1aa4ad4eb695 serial: core: Fix missing shutdown and startup for serial =
base port
> >=20
> > on top btw.
>=20
> Ah, that looks exactly like my issue. Thanks, I will test that an report
> back.

It improves my situation for sure. I have yet another problem with the
stm32 UART that is driver specfic. I'm working on that one now ...

thanks again,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6w4mjjysdcfd4xi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYeSlIACgkQj4D7WH0S
/k7nYAf8DjvYAOri+wFZc81PgU2fVSiqvZYjImtzIAOyfzruqf4SS5NUqxQ6xoDt
9cn8LYl99OUl0+Egm2w1VVf39bJvgyAmrCXfdwA5LCqBqK8AGtQ5ZXP+ZMATmoxn
9Sc6tG8wHy/0kDF5oSAYDlRYKHf6sQAE2QWAAbs4KVPmnge6/UDcMYJ0nvoEf42J
FfPzFJ9qqfWg+VLEPNMVkIGeS9N/NPaVxjqyCAS/JCkgITEwZgRml12XeD1KtpQ6
Ly1V8vnBBGL5SvMIfJJeoYCkxgWcNGfjt2ro5lyH9FLn35FFrg9dbh4/ciM2430E
LBVhm/rNklXMKzvZaR1SnyxMXa+LEA==
=22jP
-----END PGP SIGNATURE-----

--6w4mjjysdcfd4xi7--
