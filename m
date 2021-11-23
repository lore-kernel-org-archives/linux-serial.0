Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702AFC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 09:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhKWJyW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 04:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhKWJyW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 04:54:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1937DC061574
        for <linux-serial@vger.kernel.org>; Tue, 23 Nov 2021 01:51:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpSSF-000874-UK; Tue, 23 Nov 2021 10:51:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpSSF-000aeC-3T; Tue, 23 Nov 2021 10:51:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpSSE-0005hS-1T; Tue, 23 Nov 2021 10:51:10 +0100
Date:   Tue, 23 Nov 2021 10:51:06 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] tty: serial: imx: clear RTSD status before suspend
Message-ID: <20211123095106.dobqw2wfz2o2ofwc@pengutronix.de>
References: <20211123070349.20099-1-sherry.sun@nxp.com>
 <20211123074219.wn5jfjr6ph7uutyo@pengutronix.de>
 <AS8PR04MB84047408AEC087EB16B6981F92609@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i3pqdc4chxqu3hq2"
Content-Disposition: inline
In-Reply-To: <AS8PR04MB84047408AEC087EB16B6981F92609@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--i3pqdc4chxqu3hq2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2021 at 08:41:18AM +0000, Sherry Sun wrote:
> Hi Uwe,
>=20
> > -----Original Message-----
> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Sent: 2021=E5=B9=B411=E6=9C=8823=E6=97=A5 15:42
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org; linux-
> > serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx <lin=
ux-
> > imx@nxp.com>
> > Subject: Re: [PATCH] tty: serial: imx: clear RTSD status before suspend
> >=20
> > On Tue, Nov 23, 2021 at 03:03:49PM +0800, Sherry Sun wrote:
> > > From: Fugang Duan <fugang.duan@nxp.com>
> > >
> > > Clear RTSD status before suspend due to the port also use RTS pin as
> > > wakeup source, need to clear the flag first.
> >=20
> > I'd write:
> >=20
> > 	Clear RTSD status before enabling the irq event for RTSD.
>=20
> Thanks for the suggestion, I will reorganize the commit message and send =
V2.
>=20
> >=20
> > That this happens in the context of suspend isn't that important.
>=20
> Sorry I didn't get the point here, can you please explain more?
> Per my understanding, the wakeup source interrupt is handled in the
> suspend context, so clear the flag in the suspend context is also
> necessary.

But the actual problem is that RTSD is enabled without first clearing it
and not that RTSD isn't cleared in suspend.

So my initial reaction after reading the commit log header "clear RTSD
status before suspend" was: WTH, why do we need clearing RTSD before
suspend. Shouldn't the RTSD state kept over suspend?

In contrast clearing an event before the respecive irq is enabled is
more obviously correct. And if the irq source is enabled as part of
suspend or open isn't that relevant for the subject line.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--i3pqdc4chxqu3hq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGcuYcACgkQwfwUeK3K
7AnmTAf/b6TPbm5kcRz4ofO0PVdeihImAUpfwnyxbtieM8iZRz133N/r/on9F306
5EtrIerz+iv1i9bRExFBcPvl5jMnWO7rJ1UO9fj43bMq9jRxSPxGj9vlpZKPFycc
BWePdCtq1pdLOF3mad9TN4a4+NRzfEj9Q9VFmi1g154xIxCMTSFqr/qjyGTO09fE
Yt6Uffz3UDl8diCDcr9XtamiaxkDlR/h/iUzDEObIHOtoauWfVnWJ08/zdST2mRc
wVU8a+gtGrzSIqwDE6YFy7MBLZ9Ae1XliKwM3mOB7OrxxgDSrkvKp2/y0GiR115L
O7AEMKY500kRNgFXu/TUnIJSAhpOmA==
=0a4M
-----END PGP SIGNATURE-----

--i3pqdc4chxqu3hq2--
