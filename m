Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AEEC77B73
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 17:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjEaRvk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjEaRvj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 13:51:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC2C126
        for <linux-serial@vger.kernel.org>; Wed, 31 May 2023 10:51:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4Pyq-0000D4-4B; Wed, 31 May 2023 19:51:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4Pyo-004AiG-UP; Wed, 31 May 2023 19:51:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4Pyo-009ueg-BW; Wed, 31 May 2023 19:51:26 +0200
Date:   Wed, 31 May 2023 19:51:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, kernel@pengutronix.de,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
Message-ID: <20230531175126.vqoqa2flhtbboy2t@pengutronix.de>
References: <20230531083230.2702181-1-u.kleine-koenig@pengutronix.de>
 <1bdec338-6954-7b2f-e8e3-f19f211c4ce3@linux.intel.com>
 <20230531100443.jeg4q73fz4yx4pi6@pengutronix.de>
 <9eab900-9387-4db2-3f24-29d4d1dcb411@linux.intel.com>
 <20230531104010.k2rgnicltwy6wive@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5tnogavxpbqx5ocu"
Content-Disposition: inline
In-Reply-To: <20230531104010.k2rgnicltwy6wive@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--5tnogavxpbqx5ocu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ilpo,

On Wed, May 31, 2023 at 12:40:10PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, May 31, 2023 at 01:09:01PM +0300, Ilpo J=E4rvinen wrote:
> > On Wed, 31 May 2023, Uwe Kleine-K=F6nig wrote:
> >=20
> > > On Wed, May 31, 2023 at 12:47:54PM +0300, Ilpo J=E4rvinen wrote:
> > > > On Wed, 31 May 2023, Uwe Kleine-K=F6nig wrote:
> > > >=20
> > > > > The need to handle the FSL variant of 8250 in a special way is al=
so
> > > > > present without console support. So soften the dependency for
> > > > > SERIAL_8250_FSL accordingly.
> > > > >=20
> > > > > This issue was identified by Dominik Andreas Schorpp.
> > > > >=20
> > > > > To cope for CONFIG_SERIAL_8250=3Dm + CONFIG_SERIAL_8250_FSL=3Dy, =
8250_fsl.o
> > > > > must be put in the same compilation unit as 8250_port.o because t=
he
> > > > > latter defines some functions needed in the former and so 8250_fs=
l.o
> > > > > must not be built-in if 8250_port.o is available in a module.
> > > > >=20
> > > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > > ---
> > > > > Hello,
> > > > >=20
> > > > > (implicit) v1 was already applied by Greg (a0807ca158e0 in tty-te=
sting)
> > > > > but that didn't handle CONFIG_SERIAL_8250=3Dm + CONFIG_SERIAL_825=
0_FSL=3Dy
> > > > > correctly which was pointed out by the 0-day bot. (Thanks!)
> > > >=20
> > > > That would warrant Reported-by (0-day's reports give you the tag).
> > >=20
> > > I'd add this tag if I created a commit that fixes the broken commit.
> > > However I understood that if a v2 patch fixes a v1 that was broken, t=
he
> > > tag is not to be added?! I don't feel strong here however, so if peop=
le
> > > agree that the tag should be there, I can add it.
> > >=20
> > > > > That wasn't a problem before because SERIAL_8250_CONSOLE depends =
on
> > > > > SERIAL_8250=3Dy.
> > > > >=20
> > > > > Having said that I wonder if there are a few more .o files that s=
hould
> > > > > better be used with 8250_base-$(CONFIG_SERIAL_8250_XXX) instead of
> > > > > obj-$(CONFIG_SERIAL_8250_XXX).
> > > > >=20
> > > > > Best regards
> > > > > Uwe
> > > > >=20
> > > > >  drivers/tty/serial/8250/Kconfig  | 2 +-
> > > > >  drivers/tty/serial/8250/Makefile | 2 +-
> > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial=
/8250/Kconfig
> > > > > index 5313aa31930f..10c09b19c871 100644
> > > > > --- a/drivers/tty/serial/8250/Kconfig
> > > > > +++ b/drivers/tty/serial/8250/Kconfig
> > > > > @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
> > > > > =20
> > > > >  config SERIAL_8250_FSL
> > > > >  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC ||=
 ARM || ARM64)
> > > > > -	depends on SERIAL_8250_CONSOLE
> > > > > +	depends on SERIAL_8250
> > > >=20
> > > > Why this cannot simply be:
> > > > 	depends on SERIAL_8250=3Dy
> > >=20
> > > This doesn't work, because then the FSL-workarounds are missing if the
> > > 8250 driver is compiled as a module.
> >=20
> > How can 8250 driver be a module and fsl still get enabled?
>=20
> It works. With my patch applied:
>=20
> 	$ make allmodconfig
> 	$ grep -E 'CONFIG_SERIAL_8250(_FSL)?\>' .config
> 	CONFIG_SERIAL_8250=3Dm
> 	CONFIG_SERIAL_8250_FSL=3Dy
>=20
> > What I think (not a Kconfig expert for sure) would happen is that 8250_=
fsl=20
> > won't be enabled at all if CONFIG_SERIAL_8250=3Dm because it depends on=
=20
> > SERIAL_8250=3Dy.
>=20
> That's not how it seems to be ...

If this convinces you that the patch is fine, an ack would be nice as
gregkh signaled that there is some pending discussion he is waiting to
end before applying this patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5tnogavxpbqx5ocu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR3iR0ACgkQj4D7WH0S
/k4l2AgAqJcuYjoUXeo88XHPOQ5nHwA0vLmOetERLG7sH72TQ8YpCblZRoilm7/v
FYzIu2ie4LgI2lvFjgcOMDLYaAPq5kIP9efv37fznnsgmjR14XsnNHXUBzB5ktjJ
JwrdkehpOoLUnNeGRCLXo3MhyAy97URbaHaTjJJEqCzMY8+75++OyQLwkicRqtw8
XxR/pc56/NRi4JJ8z8dmTZFV0MigqpqtOiuvov29m+sbIZv97VlD270T3bHd9ctk
pBJ8Iy+APNNMQZ4El+ge/74egYVq5qkM+MW4qy/usiSjs6VVQNzVioI2RLUs/JM1
0V5756VhKLyQeob9d9C+8sDU6S4hZQ==
=n5kF
-----END PGP SIGNATURE-----

--5tnogavxpbqx5ocu--
