Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C2C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 07:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D2F619BC
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 07:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCWHe7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 03:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCWHey (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 03:34:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C170DC061574
        for <linux-serial@vger.kernel.org>; Tue, 23 Mar 2021 00:34:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lObYx-0006Iu-LX; Tue, 23 Mar 2021 08:34:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lObYw-0002Sx-NO; Tue, 23 Mar 2021 08:34:50 +0100
Date:   Tue, 23 Mar 2021 08:34:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Nobs <samuel.nobs@taitradio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel@pengutronix.de
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <20210323073447.r3utxintt5c3blb4@pengutronix.de>
References: <20210322111036.31966-1-johan@kernel.org>
 <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
 <20210322113918.ze52gq54cpsspgej@linutronix.de>
 <20210322115536.knkea7i6vrfpotol@pengutronix.de>
 <YFiZuXWYmxPIaQH9@hovoldconsulting.com>
 <20210322134032.kmirudtnkd4akkgu@pengutronix.de>
 <20210322204836.i4ksobvp6hxl5owh@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rq5nwb5cqbbuxlll"
Content-Disposition: inline
In-Reply-To: <20210322204836.i4ksobvp6hxl5owh@linutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--rq5nwb5cqbbuxlll
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sebastian,

On Mon, Mar 22, 2021 at 09:48:36PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-03-22 14:40:32 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> > From a strictly logically point of view you indeed cannot. But if you go
> > to the street and say to people there that they can park their car in
> > this street free of charge between Monday and Friday, I expect that most
> > of them will assume that they have to pay for parking on weekends.
>=20
> If I hear that parking is free on weekdays and on paid on weekends, I
> expect it to be a scam.

I don't feel taken seriously with this reply.

> Uwe, the patch reverts a change which was needed for !RT + threadirqs.

This would be a useful information for the commit log.

> The commit message claims that since the referenced commit "=E2=80=A6 int=
errupt
> handlers always run with interrupts disabled on non-RT=E2=80=A6 ". This h=
as
> nothing to do with _this_ change. It argues why the workaround is not
> needed.

It argues why the work around is not needed on non-RT. It might be
obvious for someone who is firm in the RT concepts, but IMHO commit logs
should be understandable by and make sense for a wider audience than the
deep experts. From what I know about RT "Force-threaded interrupt
handlers used to run with interrupts enabled" still applies there.

> If the referenced commit breaks RT then this is another story.

I'm surprised to hear that from you. With the goal to get RT into
mainline I would expect you to be happy if people consider the effects
on RT in their reviews.

> > So when you said that on on-RT the reason why it used to need a
> > workaround is gone made me wonder what that implies for RT.
>=20
> There was never reason (or a lockdep splat) for it on RT. If so you
> should have seen it, right?

No, I don't consider myself to be an RT expert who is aware of all the
problems. So I admit that for me the effect on RT of the patch under
discussion isn't obvious. I just wonder that the change is justified
with being OK on non-RT. So it's either bad that it breaks RT *or*
improving the commit log would be great.

And even if I had reason to believe that there is no problem with the
commit on RT, I'd still wish that the commit log wouldn't suggest to the
casual reader that there might be a problem.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rq5nwb5cqbbuxlll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBZmhQACgkQwfwUeK3K
7Amm+wf/au1Z6kNU1D+zrVdm5KAv72xZKa5+FRGc5E8eVVhmHY03AGtMtw4xLpzD
8DBcJaCEY/K4U9UAENORJXU2u1C3jq6t9uim09oFI+CAU1BGpgX3l34pMGEeqQc4
8QFSQu4MYSwLPGE1ecSrpmAURl0xeknT+vudFbwrOMMynFbGwlC8M3nQSq9A3HfK
jwivSjorqA15QW8gBx6jOQvMctKG2kXvXcjmTDq+61p7hwkEgGDty4NgPEGye4g5
b4fE35/A2THaChliX7HgbCDtynvdHKHA7GQ3awpRMZ7Kx2tFsecoefkDHRKJHse9
AarPIaHLfeko5L1l9uDCAkA0X6wCbg==
=OhvM
-----END PGP SIGNATURE-----

--rq5nwb5cqbbuxlll--
