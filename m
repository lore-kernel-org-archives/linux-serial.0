Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24504C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  4 Jan 2022 22:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiADWtJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Jan 2022 17:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiADWtJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jan 2022 17:49:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37109C061761
        for <linux-serial@vger.kernel.org>; Tue,  4 Jan 2022 14:49:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4sc6-0001DJ-80; Tue, 04 Jan 2022 23:49:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4sc4-008USw-Nk; Tue, 04 Jan 2022 23:49:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4sc3-0002T6-DO; Tue, 04 Jan 2022 23:49:03 +0100
Date:   Tue, 4 Jan 2022 23:49:00 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        k.drobinski@camlintechnologies.com
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
Message-ID: <20220104224900.u3omfbilejx2jawr@pengutronix.de>
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <YdQndwYc9xaauvpS@kroah.com>
 <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
 <YdQxmQ+OMCrabg2u@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wq2radgahf44n2rf"
Content-Disposition: inline
In-Reply-To: <YdQxmQ+OMCrabg2u@kroah.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--wq2radgahf44n2rf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 04, 2022 at 12:38:01PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 04, 2022 at 12:13:06PM +0100, Tomasz Mo=C5=84 wrote:
> > On 04.01.2022 11:54, Greg Kroah-Hartman wrote:
> > > Why can't you do this dynamically based on the baud rate so as to alw=
ays
> > > work properly for all speeds without increased delays for slower ones?
> >=20
> > Could you please advise on which baud rates to consider as slow? Does it
> > sound good to have the old trigger level for rates up to and including
> > 115200 and the new one for faster ones?
>=20
> You tell me, you are the one seeing this issue and are seeing delays on
> slower values with your change.  Do some testing to see where the curve
> is.

Maybe it's more sensible to make this even more dynamic: e.g. keep it at
1 as default and increase the water level when a certain irq frequency
is reached?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wq2radgahf44n2rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHUztgACgkQwfwUeK3K
7AmvTQf+OCFPxEFrhq7lj/tPZF/VNec0hPpsHzzvLlsJXgQf56TBTensWBvlYv/4
BUSVa8xuCMLvsunjKQ0foFXSOYikf8FkZn+3DCbqSwaUXtSqrJoAtXDueLbORfHJ
0oWCR9ixNlAfHyiIdFHrhumR7pOnh8s6uK5ML9TLQi73+l9fnMwX1JuR+SsfPaN6
zVIGthwSgwTdqUHPYIydRiAK1PEsK8WZZutYxiXyZNHE0eOriKpPUg13Vv06Z/JQ
sgg2fQ5z8t1F2RSibGqPdLjJZBVeqAQEb1qw7fVRxv89vSXd/QHRAo0wdksxe7Gl
duuuOW1wZLxiDgRnQNJJWH+G++sh2w==
=Z1wH
-----END PGP SIGNATURE-----

--wq2radgahf44n2rf--
