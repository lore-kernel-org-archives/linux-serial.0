Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C737C77B73
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 12:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjEXMmT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 08:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjEXMmS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 08:42:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89575B6
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 05:42:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1noZ-0000WJ-2t; Wed, 24 May 2023 14:42:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1noW-002URv-AR; Wed, 24 May 2023 14:42:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1noV-007Yip-L5; Wed, 24 May 2023 14:41:59 +0200
Date:   Wed, 24 May 2023 14:41:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Message-ID: <20230524124156.2slamfnkvwsgxdvx@pengutronix.de>
References: <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
 <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
 <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com>
 <87mt3ynsa7.fsf@osv.gnss.ru>
 <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com>
 <87sfcy8ncu.fsf@osv.gnss.ru>
 <534ac8db-ae8f-1ea3-9aa9-2105db7f7a52@i2se.com>
 <203ce87f-2898-eb10-2f8c-f237859d75e6@leemhuis.info>
 <87ttw2vnn0.fsf@osv.gnss.ru>
 <80207a43-6047-4493-da5d-8bd87ef74551@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bnfkfw26ufr65s4f"
Content-Disposition: inline
In-Reply-To: <80207a43-6047-4493-da5d-8bd87ef74551@leemhuis.info>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--bnfkfw26ufr65s4f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 12:48:51PM +0200, Thorsten Leemhuis wrote:
> On 23.05.23 21:44, Sergey Organov wrote:
> > "Linux regression tracking (Thorsten Leemhuis)"
> > <regressions@leemhuis.info> writes:
> >=20
> >> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> >> for once, to make this easily accessible to everyone.
> >>
> >> Stefan, was this regression ever solved? It doesn't look like it, but
> >> maybe I'm missing something.
> >>
> >> If it wasn't solved: what needs to be done to get this rolling again?
> >=20
> > Not Stefan,
>=20
> Thx to both you and Stefan for the update.
>=20
> > but as far as I can tell, the problem is that on Stefan's
> > build the kernel has rather large periods of interrupts being disabled,
> > so any attempt to decrease IRQs frequency from UART by raising FIFO IRQ
> > threshold causes "regression" that manifests itself as missing
> > characters on receive. I'm not sure if it's tuning FIFO level that is in
> > fact a regression in this case.
>=20
> Not totally sure, but I guess Linus stance in this case would be along
> the lines of "commit 7a637784d517 made an existing issue worse; either
> the people involved in it fix it, or we revert that commit[1], as it's
> causing a regression". At least we *iirc* had situations he handled like
> that.
>=20
> [1] of course unless a revert would cause regressions for others --
> which i guess might be the case here, as that was added in 5.18 already.
> So let's not bring Linus in.

Well in my eyes this regression is in the same league as: That patch
over made a driver use some more memory and on my (memory limited)
machine this makes the difference to trigger an OOM. You could apply
this to pretty much any patch that increases the memory foot print /
latency / cpu usage.
(TL;DR: I agree to not revert the patch under discussion for this
reason.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bnfkfw26ufr65s4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRuBhQACgkQj4D7WH0S
/k6/WggAh4Ur/F5Mc1EVHDFSZT5n1xyX9GqM+K24Revr2cn4A02F4PGAREZzXxod
1bcZEsEG4iWJkIRKZuHHqpM4iRZXUEupGqrNRawDz40ipvu++v1m5JsMci/XXC9v
ACxzFvw77nj4WyKjUeTC8mGQh6zJTlXDMMk3co7OjlJR1n2ZZFocbeXmQkZv36Zz
sur8VFQk63ryARDdemAFQ1Q2pd/4kStM3P12xAE2i7GfyjEwyNP9Fs+Lp961/yKg
1KHlud8zJbKaKwifm+LV5qygl+aXJZQzWf0uHLZSmSczsonyluWlCUDDtIIbJvEz
B1vXCeOYRzBnXVR5uO48GkFIFgVd4w==
=VpgB
-----END PGP SIGNATURE-----

--bnfkfw26ufr65s4f--
