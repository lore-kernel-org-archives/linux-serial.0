Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2123BC6FD20
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 14:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjCXOj4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCXOjz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 10:39:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17AED7
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 07:39:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfia6-0007aU-GM; Fri, 24 Mar 2023 15:39:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfia3-006PJd-QS; Fri, 24 Mar 2023 15:39:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfia2-007dwO-Ju; Fri, 24 Mar 2023 15:39:46 +0100
Date:   Fri, 24 Mar 2023 15:39:45 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Message-ID: <20230324143945.x56mxrzw3k2i4z7n@pengutronix.de>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <20230324133739.rwo6yr75vrwatbhb@pengutronix.de>
 <547ab600-3630-4645-75c4-ff29610c9437@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umwcintol67jnugz"
Content-Disposition: inline
In-Reply-To: <547ab600-3630-4645-75c4-ff29610c9437@i2se.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--umwcintol67jnugz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 03:19:46PM +0100, Stefan Wahren wrote:
> Hi,
>=20
> Am 24.03.23 um 14:37 schrieb Uwe Kleine-K=C3=B6nig:
> > On Fri, Mar 24, 2023 at 09:57:39AM -0300, Fabio Estevam wrote:
> > > Hi Stefan,
> > >=20
> > > On Fri, Mar 24, 2023 at 8:48=E2=80=AFAM Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > >=20
> > > > This has come up earlier, see e.g.:
> > > >=20
> > > > https://lore.kernel.org/linux-serial/20221003110850.GA28338@frances=
co-nb.int.toradex.com/
> > > >=20
> > > > My somewhat uninformed suggestion: if the overrun problems mostly s=
how up
> > > > with console ports, maybe the trigger level could depend on the port
> > > > being a console or not?
> > > Does the change below help? Taking Ilpo's suggestion into account:
> > I wonder if it's a red herring that having the console on that port
> > makes a difference. If I understand correctly the problem is pasting
> > bigger amounts of data on a ttymxc after having logged in via a getty?
> >=20
> > @Stefan: Can you try to reproduce with the port being also a console?
>=20
> Sorry, for the confusion. Maybe i should have mentioned that the debug UA=
RT
> was configured as a console. Here is the output to be more specific (ttym=
xc0
> and 4 are RS485, ttymxc3 is the debug console):
>=20
> # cat /proc/tty/driver/IMX-uart
>=20
> serinfo:1.0 driver revision:
> 0: uart:IMX mmio:0x02020000 irq:192 tx:285207 rx:2633621 fe:2 DSR|CD
> 3: uart:IMX mmio:0x021F0000 irq:193 tx:70502 rx:69 RTS|DTR|DSR
> 4: uart:IMX mmio:0x021F4000 irq:194 tx:300988 rx:677223 DSR|CD
> 5: uart:IMX mmio:0x021FC000 irq:195 tx:0 rx:0 DSR|CD
> 6: uart:IMX mmio:0x02018000 irq:191 tx:0 rx:0 DSR|CD
>=20
> Just for clarification the Tarragon board is build in a charging station.=
 So
> hardware access is limited.
>=20
> @Uwe which port should be configured as a console?

I don't care as long as it's not hte port that you do your test on. None
is fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--umwcintol67jnugz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQdtjAACgkQj4D7WH0S
/k7GuAgAgK8kjIUSQ8wdcJfMUcnQTaFK6M/8X6A6Ecyeig7o0eiuPn/d6pt+R8RH
TTucUIoJm5dWBSFPl682Kl0Kae+yBK54Y9n/TLhAh6VVomQGg5lY9pUJN7W5dPXF
7oG0aL/yKmh8lucto6lqcibwmw7LXk+f+AkItTXS+gnazMOanninvn+AXENiTbP2
nnieWN3CP27xpiUxbyzw2kSZSYeghJGZC+PzMXUg6h0tbO4X981mKJ3RW0PwFf7m
xGhW1DXMhfo2o8ch09Vvvv2UKkou3jj8Ldq2BJTr6NMGF/SCDw1BMJIV7UUz+QsD
8Kdo2i5a0fmrdDPWHyEO48Zx0Qxw0A==
=5zN2
-----END PGP SIGNATURE-----

--umwcintol67jnugz--
