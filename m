Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED0C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 09:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjKMJ54 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 04:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjKMJ5z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 04:57:55 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AAF10DB
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 01:57:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2ThD-0002FP-LY; Mon, 13 Nov 2023 10:57:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2ThC-008her-Uf; Mon, 13 Nov 2023 10:57:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2ThC-000e8G-LG; Mon, 13 Nov 2023 10:57:30 +0100
Date:   Mon, 13 Nov 2023 10:57:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: hvc: Make hvc_remove() return no value
Message-ID: <20231113095730.uein5ix7eduqvboq@pengutronix.de>
References: <20231105214406.3765906-4-u.kleine-koenig@pengutronix.de>
 <20231105214406.3765906-5-u.kleine-koenig@pengutronix.de>
 <CWXL68T68A18.BZ8WHB15ZU2Y@wheely>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e57ttq5xm22amhut"
Content-Disposition: inline
In-Reply-To: <CWXL68T68A18.BZ8WHB15ZU2Y@wheely>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--e57ttq5xm22amhut
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 07:45:27PM +1000, Nicholas Piggin wrote:
> On Mon Nov 6, 2023 at 7:44 AM AEST, Uwe Kleine-K=F6nig wrote:
> > The function hvc_remove() returns zero unconditionally. Make it return
> > void instead to make it obvious that the caller doesn't need to do any
> > error handling. Accordingly drop the error handling from
> > hvc_opal_remove().
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> IIUC these are functionally no change, just tidying and removing
> dead code?

In case this isn't only a rethorical question: There is indeed no
change in behaviour. hvc_remove() returned always zero, so

	rc =3D hvc_remove(hp);
	if (rc =3D=3D 0) {
		... some code not changing rc ...
	}
	... some more code not changing rc ...
	return rc

can be simplified to

	hvc_remove(hp);
	... some code not changing rc ...
	... some more code not changing rc ...
	return 0;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e57ttq5xm22amhut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVR8wkACgkQj4D7WH0S
/k6j1AgAiALJm4H/iiU3yfW9SEfUmYZS+axaeMjy9V8y2YO/HhvKYOaoAHaAOv0p
8rbM2Dls5ordKi6T97/J1vsOayAFKcFO83pGG/kHUL2DBez1vWrN+Qx/v9FdPx5F
aEUjNvhVqV7ZLD9KzAMJ5j4378sdFkaeRpPdgrkJiWz3JOFbavSMb55DXX0XUWcU
cAz3aPrM/pbUzehaKzKGPyBwhwa4bvkYR77CVAAlmhCt682rftVYTZhKYGMyN9vX
iJVaXIK+lRW9F34zWi+OHBAtXknjAoOpCOKC7azxgpnwD52NI7AzxXNxcb+8vnoE
KduZ2Imc7+bzLOePlVNKIZGu+SoFeg==
=SkF9
-----END PGP SIGNATURE-----

--e57ttq5xm22amhut--
