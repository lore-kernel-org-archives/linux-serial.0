Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FB1C77B73
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 10:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjEaKkZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 06:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjEaKkU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 06:40:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D03BE
        for <linux-serial@vger.kernel.org>; Wed, 31 May 2023 03:40:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4JFV-0004xj-0j; Wed, 31 May 2023 12:40:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4JFT-0045Ni-9Y; Wed, 31 May 2023 12:40:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4JFS-009n6N-AU; Wed, 31 May 2023 12:40:10 +0200
Date:   Wed, 31 May 2023 12:40:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, kernel@pengutronix.de,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
Message-ID: <20230531104010.k2rgnicltwy6wive@pengutronix.de>
References: <20230531083230.2702181-1-u.kleine-koenig@pengutronix.de>
 <1bdec338-6954-7b2f-e8e3-f19f211c4ce3@linux.intel.com>
 <20230531100443.jeg4q73fz4yx4pi6@pengutronix.de>
 <9eab900-9387-4db2-3f24-29d4d1dcb411@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zmleg4tklagn56bm"
Content-Disposition: inline
In-Reply-To: <9eab900-9387-4db2-3f24-29d4d1dcb411@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--zmleg4tklagn56bm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 01:09:01PM +0300, Ilpo J=E4rvinen wrote:
> On Wed, 31 May 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > On Wed, May 31, 2023 at 12:47:54PM +0300, Ilpo J=E4rvinen wrote:
> > > On Wed, 31 May 2023, Uwe Kleine-K=F6nig wrote:
> > >=20
> > > > The need to handle the FSL variant of 8250 in a special way is also
> > > > present without console support. So soften the dependency for
> > > > SERIAL_8250_FSL accordingly.
> > > >=20
> > > > This issue was identified by Dominik Andreas Schorpp.
> > > >=20
> > > > To cope for CONFIG_SERIAL_8250=3Dm + CONFIG_SERIAL_8250_FSL=3Dy, 82=
50_fsl.o
> > > > must be put in the same compilation unit as 8250_port.o because the
> > > > latter defines some functions needed in the former and so 8250_fsl.o
> > > > must not be built-in if 8250_port.o is available in a module.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > > Hello,
> > > >=20
> > > > (implicit) v1 was already applied by Greg (a0807ca158e0 in tty-test=
ing)
> > > > but that didn't handle CONFIG_SERIAL_8250=3Dm + CONFIG_SERIAL_8250_=
FSL=3Dy
> > > > correctly which was pointed out by the 0-day bot. (Thanks!)
> > >=20
> > > That would warrant Reported-by (0-day's reports give you the tag).
> >=20
> > I'd add this tag if I created a commit that fixes the broken commit.
> > However I understood that if a v2 patch fixes a v1 that was broken, the
> > tag is not to be added?! I don't feel strong here however, so if people
> > agree that the tag should be there, I can add it.
> >=20
> > > > That wasn't a problem before because SERIAL_8250_CONSOLE depends on
> > > > SERIAL_8250=3Dy.
> > > >=20
> > > > Having said that I wonder if there are a few more .o files that sho=
uld
> > > > better be used with 8250_base-$(CONFIG_SERIAL_8250_XXX) instead of
> > > > obj-$(CONFIG_SERIAL_8250_XXX).
> > > >=20
> > > > Best regards
> > > > Uwe
> > > >=20
> > > >  drivers/tty/serial/8250/Kconfig  | 2 +-
> > > >  drivers/tty/serial/8250/Makefile | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8=
250/Kconfig
> > > > index 5313aa31930f..10c09b19c871 100644
> > > > --- a/drivers/tty/serial/8250/Kconfig
> > > > +++ b/drivers/tty/serial/8250/Kconfig
> > > > @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
> > > > =20
> > > >  config SERIAL_8250_FSL
> > > >  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || A=
RM || ARM64)
> > > > -	depends on SERIAL_8250_CONSOLE
> > > > +	depends on SERIAL_8250
> > >=20
> > > Why this cannot simply be:
> > > 	depends on SERIAL_8250=3Dy
> >=20
> > This doesn't work, because then the FSL-workarounds are missing if the
> > 8250 driver is compiled as a module.
>=20
> How can 8250 driver be a module and fsl still get enabled?

It works. With my patch applied:

	$ make allmodconfig
	$ grep -E 'CONFIG_SERIAL_8250(_FSL)?\>' .config
	CONFIG_SERIAL_8250=3Dm
	CONFIG_SERIAL_8250_FSL=3Dy

> What I think (not a Kconfig expert for sure) would happen is that 8250_fs=
l=20
> won't be enabled at all if CONFIG_SERIAL_8250=3Dm because it depends on=
=20
> SERIAL_8250=3Dy.

That's not how it seems to be ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zmleg4tklagn56bm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR3JAkACgkQj4D7WH0S
/k77PAf+LKjZkjJrOjNGu+YfUNOJUJzXq8gVg1ZRUZPDFnlAV3vUdphgMXSEYdGr
2XezBXHpenBhsowfauE23TwUXZwGiqfwha51MfK3panZ5ktpgpGTm3x03ef3B1fV
qn8Scr+DFjBZo8uevjDsuEL8bw3Q4IDrIVfL0BCB2cLwRj5sSLpPWNcLjrdbi7ol
R8s6eBq+Ho5zfhbHu8OmSPOS2Sori49kxtcpGJll+eLxWZ6hETYIUztTThhDi9aI
rygyu1SEYBdEGNoth43ij44g9oUzBuBtvrhkKg5YMyPVs7kuwg5eEsn3mt4FOrfl
RIKo8s3BJB9oC/7Ca9siJartIW8XiA==
=Dpcr
-----END PGP SIGNATURE-----

--zmleg4tklagn56bm--
