Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C449EC6FD20
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 13:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjCXNhv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 09:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCXNhu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 09:37:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C42D234D6
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 06:37:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfhc0-0006nv-LM; Fri, 24 Mar 2023 14:37:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfhbx-006Ofq-Ij; Fri, 24 Mar 2023 14:37:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfhbw-007cjT-T4; Fri, 24 Mar 2023 14:37:40 +0100
Date:   Fri, 24 Mar 2023 14:37:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Message-ID: <20230324133739.rwo6yr75vrwatbhb@pengutronix.de>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ajcfz6iofc4rq7cg"
Content-Disposition: inline
In-Reply-To: <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--ajcfz6iofc4rq7cg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 09:57:39AM -0300, Fabio Estevam wrote:
> Hi Stefan,
>=20
> On Fri, Mar 24, 2023 at 8:48=E2=80=AFAM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > This has come up earlier, see e.g.:
> >
> > https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-n=
b.int.toradex.com/
> >
> > My somewhat uninformed suggestion: if the overrun problems mostly show =
up
> > with console ports, maybe the trigger level could depend on the port
> > being a console or not?
>=20
> Does the change below help? Taking Ilpo's suggestion into account:

I wonder if it's a red herring that having the console on that port
makes a difference. If I understand correctly the problem is pasting
bigger amounts of data on a ttymxc after having logged in via a getty?

@Stefan: Can you try to reproduce with the port being also a console?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ajcfz6iofc4rq7cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQdp6IACgkQj4D7WH0S
/k4QHgf7BDP9Z00eSfZMkUyYoL5y8AAFFlHONWrqpmC/7+8VdSfz89qpaNQVvDCy
8Jt6/fRGlgchKbALkQQutgMzIhjDleY6gh7Wv8xCFMt0Nr/5UNZbHvj7nKECdAfH
asKyJDJc7RUyWdueDH/wY/P8UrkeOL1BuPzv5R1gP/vBX57q2zMpx+BO+4zUYK28
Zg1voQ2Rz8aJLSjDBlG/4wxn+Bn2XHCswSFO7nahKb3XAH57RJbiehdnonrojKGt
cJZ8zfoqD4cXrXWJrBhR7bc01tYI/wzqTOF6CBZfc9aFZHMfT7dEIyNMlHa8nv4p
1LluomMOLPiBgYVdRrtZxQojl53Bow==
=i7ip
-----END PGP SIGNATURE-----

--ajcfz6iofc4rq7cg--
