Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD0BEB64D7
	for <linux-serial@archiver.kernel.org>; Tue, 20 Jun 2023 19:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjFTT2M (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjFTT2J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Jun 2023 15:28:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D96170A
        for <linux-serial@vger.kernel.org>; Tue, 20 Jun 2023 12:28:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qBh16-0007iO-Ts; Tue, 20 Jun 2023 21:27:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qBh13-008rwD-Jh; Tue, 20 Jun 2023 21:27:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qBh12-00G0aA-Ph; Tue, 20 Jun 2023 21:27:48 +0200
Date:   Tue, 20 Jun 2023 21:27:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Message-ID: <20230620192748.ey4oah22resbblej@pengutronix.de>
References: <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com>
 <87mt3ynsa7.fsf@osv.gnss.ru>
 <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com>
 <87sfcy8ncu.fsf@osv.gnss.ru>
 <534ac8db-ae8f-1ea3-9aa9-2105db7f7a52@i2se.com>
 <203ce87f-2898-eb10-2f8c-f237859d75e6@leemhuis.info>
 <87ttw2vnn0.fsf@osv.gnss.ru>
 <d1b6209d-a174-406a-cc81-86b391940c0c@i2se.com>
 <3853881c-976f-dadc-b64b-4ffd8cc88cf0@leemhuis.info>
 <2023062046-jersey-facecloth-7a5d@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7ndb543epv2snzz"
Content-Disposition: inline
In-Reply-To: <2023062046-jersey-facecloth-7a5d@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--p7ndb543epv2snzz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Tue, Jun 20, 2023 at 04:59:18PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 20, 2023 at 04:47:10PM +0200, Linux regression tracking (Thor=
sten Leemhuis) wrote:
> > On 24.05.23 15:07, Stefan Wahren wrote:
> > >=20
> > > Am 23.05.23 um 21:44 schrieb Sergey Organov:
> > >> "Linux regression tracking (Thorsten Leemhuis)"
> > >> <regressions@leemhuis.info> writes:
> > >>
> > >> Solving this would need to identify the cause of interrupts being
> > >> disabled for prolonged times, and nobody volunteered to investigate =
this
> > >> further. One suspect, the Linux serial console, has been likely excl=
uded
> > >> already though, as not actually being in use for printk() output.
> > >>
> > >=20
> > > I don't think that we can exclude the serial console as a whole, i ne=
ver
> > > made such a observation. But at least we can exclude kernel logging on
> > > the debug UART.
> >=20
> > Stefan, just wondering: was this ever addressed upstream? I assume it's
> > not, just wanted to be sure.
> >=20
> > I'm a bit unsure what to do with this and consider asking Greg for
> > advice, as he applied the patch. On one hand it's *IMHO* clearly a
> > regression (but for the record,  some people involved in the discussion
> > claim it's not). OTOH the culprit was applied more than a year ago now,
> > so reverting it might cause more trouble than it's worth at this point,
> > as that could lead to regressions for other users.
>=20
> I'll be glad to revert this, but for some reason I thought that someone
> was working on a "real fix" here.  Stefan, is that not the case?

Sergey Organov already said something similar, but not very explicit:
With the current understanding reverting said commit is wrong. It is
expected that the commit increases irq latency for imx-serial a bit for
the benefit of less interrupts and so serves the overall system
performance. That this poses a problem only means that on the reporter's
machine there is already an issue that results in a longer period with
disabled irqs. While reverting the imx-serial commit would (maybe) solve
that, the actual problem is the other issue that disables preemption for
a longer timespan.

So TL;DR: Please don't revert the imx-serial patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p7ndb543epv2snzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSR/bMACgkQj4D7WH0S
/k5YIwgAuQA48Ld7vFvNx3Y1GDSgESgTnPmvaZi1JR7BZ8ABuUwK862AXXl6v8oL
fBAmnSy4V4s6xDmhZunaHbZND79F5CiVKi8p4iDtcGco1xp1YBuC+4J5TtwBapM1
Jk1KCuUdn8fg/BMSosFX4PDbDfAU4vv8JgCZ+BoBBi4nJO6U8uE4xFg76KrksOQP
UexDt0jDTUcUpb+/klifoa/Q+vTqUjy9T53tCuuaqEjtBOooIdtuaRdfk11oF4vF
7LANlcuZXbxxMA+njP+RK+wc9x7751v6OuJa8Ahtnf7xCyZZXfeSq/FRGcjE0BMV
3RnXcUlgK7tL+A1NRee7sHxATHIMuA==
=xnrl
-----END PGP SIGNATURE-----

--p7ndb543epv2snzz--
