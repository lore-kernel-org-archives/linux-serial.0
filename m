Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6E8C433DB
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 11:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07ED619D5
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 11:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhCXL1L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Mar 2021 07:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhCXL0h (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Mar 2021 07:26:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B5FC0613E0
        for <linux-serial@vger.kernel.org>; Wed, 24 Mar 2021 04:26:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP1ef-0000BZ-4o; Wed, 24 Mar 2021 12:26:29 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP1ee-0001xW-Ih; Wed, 24 Mar 2021 12:26:28 +0100
Date:   Wed, 24 Mar 2021 12:26:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Nobs <samuel.nobs@taitradio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <20210324112626.iqteqgfbkci3xmvh@pengutronix.de>
References: <20210322111036.31966-1-johan@kernel.org>
 <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
 <20210322113918.ze52gq54cpsspgej@linutronix.de>
 <20210322115536.knkea7i6vrfpotol@pengutronix.de>
 <YFiZuXWYmxPIaQH9@hovoldconsulting.com>
 <20210322134032.kmirudtnkd4akkgu@pengutronix.de>
 <YFn9KenzUQl4KPRt@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zi5o6fqsy3kf62o4"
Content-Disposition: inline
In-Reply-To: <YFn9KenzUQl4KPRt@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--zi5o6fqsy3kf62o4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Johan,

On Tue, Mar 23, 2021 at 03:37:29PM +0100, Johan Hovold wrote:
> On Mon, Mar 22, 2021 at 02:40:32PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 22, 2021 at 02:20:57PM +0100, Johan Hovold wrote:
> > > On Mon, Mar 22, 2021 at 12:55:36PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Mar 22, 2021 at 12:39:18PM +0100, Sebastian Andrzej Siewior=
 wrote:
> > > > > On 2021-03-22 12:34:02 [+0100], Uwe Kleine-K=F6nig wrote:
> > > > > > On Mon, Mar 22, 2021 at 12:10:36PM +0100, Johan Hovold wrote:
> > > > > > > Force-threaded interrupt handlers used to run with interrupts=
 enabled,
> > > > > > > something which could lead to deadlocks in case a threaded ha=
ndler
> > > > > > > shared a lock with code running in hard interrupt context (e.=
g. timer
> > > > > > > callbacks) and did not explicitly disable interrupts.
> > > > > > >=20
> > > > > > > This was specifically the case for serial drivers that take t=
he port
> > > > > > > lock in their console write path as printk can be called from=
 hard
> > > > > > > interrupt context also with forced threading ("threadirqs").
> > > > > > >=20
> > > > > > > Since commit 81e2073c175b ("genirq: Disable interrupts for fo=
rce
> > > > > > > threaded handlers") interrupt handlers always run with interr=
upts
> > > > > > > disabled on non-RT so that drivers no longer need to do handl=
e this.
> > > > > >=20
> > > > > > So we're breaking RT knowingly here? If this is the case I'm no=
t happy
> > > > > > with your change. (And if RT is not affected a different wordin=
g would
> > > > > > be good.)
> > > > >=20
> > > > > Which wording, could you be more specific? It looks good from her=
e and
> > > > > no, RT is not affected.
> > > >=20
> > > > The commit log says essentially: "The change is fine on non-RT" whi=
ch
> > > > suggests there is a problem on RT.
> > >=20
> > > I don't think you can read that into the commit message.
> >=20
> > From a strictly logically point of view you indeed cannot. But if you go
> > to the street and say to people there that they can park their car in
> > this street free of charge between Monday and Friday, I expect that most
> > of them will assume that they have to pay for parking on weekends.
>=20
> That analogy would almost seem to suggest bad intent on my side.

That analogy's purpose was to put over my point that writing
(paraphrased) "Since non-RT changed, this workaround isn't necessary any
more" suggests to me that the change might be bad for RT. So again,
there was no harm intended, this is just a call for clearing up either
the commit log to make it obvious the change is right or to fix the
problem on RT if there is any.

> To say that this workaround is no longer needed on !RT does not imply
> that it is needed on RT. If anything it suggests I have considered RT,
> I'd say.

The code in question was used for both RT and non-RT. You drop it for
both cases and only justify one of them. OK, fine, you considered both
cases. Just from reading the commit log I considered you didn't. It's
completely ok for me to be wrong here, but I still think the chosen
words are not optimal and stumbling as I did is easy. So I still see a
potential to improve the wording.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zi5o6fqsy3kf62o4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBbId8ACgkQwfwUeK3K
7AmrPQf/ddQwQ54O9l7xV1/XHw8vOIwucKKyjYQahAx40PXG3l82aSNYFbEm2naq
Skuiv/ZUYkuFgJplG45b5lSQCplanZ29bpfJJA6umGqNLU26U77BbscwG6Rw6DC0
uJ6764kmQcQXgp9gn8+IAZUlmVw4FReNdvJcLqKgsU2Q1XUyoUAbLW8cF5Ijqliq
5KvWHZcVw6srh3zGo1YYDqIWEfnyB/y18tcSrD5ywaGS6heFxJXNOeucvm2IxDZQ
0dNLzqJuruItdbPN1foj3zaZwSQozrqhXkn81z0XG4H02ub7lkYPNjG9PE3095EI
hkuQ8I5b5VWjg5BwyMY5QjbhtjSeOA==
=Tj6B
-----END PGP SIGNATURE-----

--zi5o6fqsy3kf62o4--
