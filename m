Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53365C433C1
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0096192E
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 13:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCVNkp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhCVNki (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 09:40:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9BFC061574
        for <linux-serial@vger.kernel.org>; Mon, 22 Mar 2021 06:40:37 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOKnJ-00071n-Oh; Mon, 22 Mar 2021 14:40:33 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOKnJ-0003kT-2y; Mon, 22 Mar 2021 14:40:33 +0100
Date:   Mon, 22 Mar 2021 14:40:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Nobs <samuel.nobs@taitradio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <20210322134032.kmirudtnkd4akkgu@pengutronix.de>
References: <20210322111036.31966-1-johan@kernel.org>
 <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
 <20210322113918.ze52gq54cpsspgej@linutronix.de>
 <20210322115536.knkea7i6vrfpotol@pengutronix.de>
 <YFiZuXWYmxPIaQH9@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ud2wui3w4ufuwl33"
Content-Disposition: inline
In-Reply-To: <YFiZuXWYmxPIaQH9@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--ud2wui3w4ufuwl33
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Johan,

On Mon, Mar 22, 2021 at 02:20:57PM +0100, Johan Hovold wrote:
> On Mon, Mar 22, 2021 at 12:55:36PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 22, 2021 at 12:39:18PM +0100, Sebastian Andrzej Siewior wro=
te:
> > > On 2021-03-22 12:34:02 [+0100], Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Mar 22, 2021 at 12:10:36PM +0100, Johan Hovold wrote:
> > > > > Force-threaded interrupt handlers used to run with interrupts ena=
bled,
> > > > > something which could lead to deadlocks in case a threaded handler
> > > > > shared a lock with code running in hard interrupt context (e.g. t=
imer
> > > > > callbacks) and did not explicitly disable interrupts.
> > > > >=20
> > > > > This was specifically the case for serial drivers that take the p=
ort
> > > > > lock in their console write path as printk can be called from hard
> > > > > interrupt context also with forced threading ("threadirqs").
> > > > >=20
> > > > > Since commit 81e2073c175b ("genirq: Disable interrupts for force
> > > > > threaded handlers") interrupt handlers always run with interrupts
> > > > > disabled on non-RT so that drivers no longer need to do handle th=
is.
> > > >=20
> > > > So we're breaking RT knowingly here? If this is the case I'm not ha=
ppy
> > > > with your change. (And if RT is not affected a different wording wo=
uld
> > > > be good.)
> > >=20
> > > Which wording, could you be more specific? It looks good from here and
> > > no, RT is not affected.
> >=20
> > The commit log says essentially: "The change is fine on non-RT" which
> > suggests there is a problem on RT.
>=20
> I don't think you can read that into the commit message.

=46rom a strictly logically point of view you indeed cannot. But if you go
to the street and say to people there that they can park their car in
this street free of charge between Monday and Friday, I expect that most
of them will assume that they have to pay for parking on weekends.

So when you said that on on-RT the reason why it used to need a
workaround is gone made me wonder what that implies for RT.

> Why would I knowingly break RT?

No offence intended. Priorities are different for different maintainers
and I wouldn't bet that all maintainers care for RT.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ud2wui3w4ufuwl33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYnk4ACgkQwfwUeK3K
7AlkhAf8CqBtOciLp0BZ5h4FAQ4CDVASZmD7W/zaoUSaaOj2TXltXSWkLLF4Vuf1
aCeq8a2bE0xJdPqGvm1FafsJzdD9fkSB0aq1j8zhsaw48zjqmGoEKqZQu38x+rL4
HcLqv6ujBLxJwjFUUms0d3ENVcNpCchY8i8ydish2CJcmyhkyX1Trris8YbLPhAx
hieWbcjXcvw9pxF4vvho6blLuhwtJUaG+CUCe/xxnQpsOAFmByVgaQTrOgSfzn0z
FuguhWU/0wfJTIlmNJwz6pKePEehEuhmuhv11nqbG4ZF6AAtXwthnsRnp28nuP6x
ElCuEoX/OoKsVlqt7Iw5khbpSEQaKA==
=ANKP
-----END PGP SIGNATURE-----

--ud2wui3w4ufuwl33--
