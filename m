Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801992EAF9
	for <linux-serial@vger.kernel.org>; Tue, 16 Apr 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287271; cv=none; b=noPnvmMTWmkWCYl1XtaJeMIkHvrAykk1tE5Rd8kpy7dB2SjxUKr9umStsIRnpxIRK/1ZXCjEVviSoouGVtNwihxWCMvQXzAy/hL7aY/PndGfWw75L1+CRsilNTimGZG4BN09XZoqsb0A+04WghWz4zvmNfREQobqYv/PbRL8WlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287271; c=relaxed/simple;
	bh=hKg0B5/9OaomVzzS1VVVNqsMSaLEq5o/v/48CvT880E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYqv11RbxpoH0iNLXh9/JuE9FBPr8lNltw1zbCqCoxIwKHW5cWqzWPzcTJQzP9R229mxZMm73xRhCUtwtt8GMXVADqN72lQpii8+OB2Y17U078ZtyNRUZRFl60DX5phSFt00E/sUp4sFwUrjyaQkdNBEF7nhqcC7hmjU9YDc6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwmHT-000385-C0; Tue, 16 Apr 2024 19:07:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwmHS-00CeGj-Jz; Tue, 16 Apr 2024 19:07:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwmHS-002I2k-1i;
	Tue, 16 Apr 2024 19:07:38 +0200
Date: Tue, 16 Apr 2024 19:07:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: Re: NULL pointer dereference when closing a busy UART
Message-ID: <wmfb6m7gz5ym2exep4pgmtwqonxi5eqryif4herfkc5rbxxvre@eqnzhic3umux>
References: <luomji4bv5c54xq442csgd2ifdacjrme7bomnwbviw6pmalpgv@5uusgu3vgybm>
 <Zh2BzD3qW1j1GR_o@smile.fi.intel.com>
 <p5eesytdhdrqo5ep2nazsm4ft6oc2dw5wb3goqo5use75f6fsg@ivsxlgyyadot>
 <nhwtgw543mkannfwvtqi3oap3xrscs66gsg56cpojxnfhjbrv3@s5fqkhvyjrfh>
 <Zh6Sb-Gk_RIdHkZi@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lhitrku3ojgb23v2"
Content-Disposition: inline
In-Reply-To: <Zh6Sb-Gk_RIdHkZi@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org


--lhitrku3ojgb23v2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Tue, Apr 16, 2024 at 05:59:59PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 16, 2024 at 11:52:19AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Apr 15, 2024 at 10:04:39PM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Mon, Apr 15, 2024 at 10:36:44PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Apr 15, 2024 at 07:15:54PM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> ...
>=20
> > > > You might need this
> > > >=20
> > > > 1aa4ad4eb695 serial: core: Fix missing shutdown and startup for ser=
ial base port
> > > >=20
> > > > on top btw.
> > >=20
> > > Ah, that looks exactly like my issue. Thanks, I will test that an rep=
ort
> > > back.
> >=20
> > It improves my situation for sure. I have yet another problem with the
> > stm32 UART that is driver specfic. I'm working on that one now ...
>=20
> Please, Cc me on that when publishing, I'm curious.

I don't have a fix yet, but the problem reproduces as follows:

I have a bridge between TX and RX; and also between RTS and CTS; there
is no DMA involved. I send a big amount of data and so receive that all.
This puts pressure on the receiving line discipline and so ->throttle()
is called.

->throttle() sets stm32_port->throttled =3D true; which makes the ISR (=3D
stm32_usart_interrupt()) stop handle USART_SR_RXNE (=3D RXFIFO not empty).
So the ISR is called in a tight loop. Stuck irq detection doesn't step
in because the ISR returns IRQ_HANDLED unconditionally. (For the latter
I already have a prototype patch.)

It's unclear to me yet, what to do. Some further things that are (maybe)
relevant are:

 - Without a rts-gpio the driver cannot toggle RTS. (Hardware
   limitation)
 - The driver makes no effort evaluating CTS.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lhitrku3ojgb23v2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYesFkACgkQj4D7WH0S
/k408AgAp8UfNuSQthzioY1PMOyLG2LpW+rqv0+iYoaVAbhSFN6SEH611cipyBZB
XRMthGysxo9x2YU6nmWaL+6Zxq83oQ3mj+6rRGENrLLMa13RjJDSL5+WzBYZ4U+w
MgroAR81bHpFVrCDSL9Hxwcq/ooKiTU+2MpyMUzo11PvAglQrKtA3TdgVx208mDf
zbAnviT1YgTw/7YkbVCfV7D5sjoBbgvwVJ6n0ib+NwgmFjjNfMtgTQl++LoFc7Ig
pK8oxVyxPrWreq0JPEepT4/xhfQyFaulcGhtLZdw/KGlSDCIXR7IXldeRCnQt6D0
JgzD5vBg5cPOTZmS/jF9lekHS6B3UA==
=8028
-----END PGP SIGNATURE-----

--lhitrku3ojgb23v2--
