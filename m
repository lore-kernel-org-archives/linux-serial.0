Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747EFC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 11:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DF3619F3
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 11:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCXLaW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Mar 2021 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhCXLaO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Mar 2021 07:30:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD8C0613DE
        for <linux-serial@vger.kernel.org>; Wed, 24 Mar 2021 04:30:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP1iD-0000Qo-QT; Wed, 24 Mar 2021 12:30:09 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP1iD-00024C-G0; Wed, 24 Mar 2021 12:30:09 +0100
Date:   Wed, 24 Mar 2021 12:30:06 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@pengutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Sam Nobs <samuel.nobs@taitradio.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <20210324113006.3zerxrp73fkzvakf@pengutronix.de>
References: <20210322111036.31966-1-johan@kernel.org>
 <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
 <20210322113918.ze52gq54cpsspgej@linutronix.de>
 <20210322115536.knkea7i6vrfpotol@pengutronix.de>
 <YFiZuXWYmxPIaQH9@hovoldconsulting.com>
 <20210322134032.kmirudtnkd4akkgu@pengutronix.de>
 <20210322204836.i4ksobvp6hxl5owh@linutronix.de>
 <20210323073447.r3utxintt5c3blb4@pengutronix.de>
 <20210323090413.ogeweygw3iejtbsv@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gvqvn6hs6msar5bv"
Content-Disposition: inline
In-Reply-To: <20210323090413.ogeweygw3iejtbsv@linutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--gvqvn6hs6msar5bv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sebastian,

On Tue, Mar 23, 2021 at 10:04:13AM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-03-23 08:34:47 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> > On Mon, Mar 22, 2021 at 09:48:36PM +0100, Sebastian Andrzej Siewior wro=
te:
> > > On 2021-03-22 14:40:32 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> > > > From a strictly logically point of view you indeed cannot. But if y=
ou go
> > > > to the street and say to people there that they can park their car =
in
> > > > this street free of charge between Monday and Friday, I expect that=
 most
> > > > of them will assume that they have to pay for parking on weekends.
> > >=20
> > > Uwe, the patch reverts a change which was needed for !RT + threadirqs.
> >=20
> > This would be a useful information for the commit log.
> >=20
> > > The commit message claims that since the referenced commit "=E2=80=A6=
 interrupt
> > > handlers always run with interrupts disabled on non-RT=E2=80=A6 ". Th=
is has
> > > nothing to do with _this_ change. It argues why the workaround is not
> > > needed.
> >=20
> > It argues why the work around is not needed on non-RT. It might be
> > obvious for someone who is firm in the RT concepts, but IMHO commit logs
> > should be understandable by and make sense for a wider audience than the
> > deep experts. From what I know about RT "Force-threaded interrupt
> > handlers used to run with interrupts enabled" still applies there.
>=20
> Yes. The commit Johan referenced explains it in more detail.

In my book the commit log should be understandable without reading the
referenced commits.

> > > If the referenced commit breaks RT then this is another story.
> >=20
> > I'm surprised to hear that from you. With the goal to get RT into
> > mainline I would expect you to be happy if people consider the effects
> > on RT in their reviews.
>=20
> Correct, I do and I am glad if people consider other aspects of the
> kernel in their review including RT.
>=20
> > > > So when you said that on on-RT the reason why it used to need a
> > > > workaround is gone made me wonder what that implies for RT.
> > >=20
> > > There was never reason (or a lockdep splat) for it on RT. If so you
> > > should have seen it, right?
> >=20
> > No, I don't consider myself to be an RT expert who is aware of all the
> > problems. So I admit that for me the effect on RT of the patch under
> > discussion isn't obvious. I just wonder that the change is justified
> > with being OK on non-RT. So it's either bad that it breaks RT *or*
> > improving the commit log would be great.
> >=20
> > And even if I had reason to believe that there is no problem with the
> > commit on RT, I'd still wish that the commit log wouldn't suggest to the
> > casual reader that there might be a problem.
>=20
> Okay. I added a sentence. What about this rewording:
>=20
>   Force-threaded interrupt handlers used to run with interrupts enabled,
>   something which could lead to deadlocks in case a threaded handler
>   shared a lock with code running in hard interrupt context (e.g. timer
>   callbacks) and did not explicitly disable interrupts. =20
>  =20
>   This was specifically the case for serial drivers that take the port
>   lock in their console write path as printk can be called from hard
>   interrupt context also with forced threading ("threadirqs").
>  =20
>   Since commit 81e2073c175b ("genirq: Disable interrupts for force
>   threaded handlers") interrupt handlers always run with interrupts
>   disabled on non-RT so that drivers no longer need to do handle this.
>   RT is not affected by the referenced commit and the workaround, that is
>   reverted, was not required because spinlock_t must not be acquired on
>   RT in hardirq context.
>  =20
>   Drop the now obsolete workaround added by commit 33f16855dcb9 ("tty:
>   serial: imx: fix potential deadlock").

This resolves my concerns. Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gvqvn6hs6msar5bv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBbIrsACgkQwfwUeK3K
7AnmRwf/fhrKa9qA0/qKMWdyyCUDqoV8EraIoueqQCqWElB20L0rcTS7n3VHD5xr
r19DzPNa9j1u8gJIaxsXhcKCYClAbmjT7nb03rnMkDT+jy4OHro7kiToCrWLKU9A
/0qqNLHeWltpb0AA38tpnkx1MYVirb0ky5eM1w9Y+B3cXYcBgsZUTszfmRfrmd7L
BehGLiJqUqk4adtshACMF0WLBXw04Q6uqTEq54Mz5o9t94YZhj3aYWbmroZbJbH/
7BhHcEZeJ3j5cHk6hcdoFQc090elG+buZ/a/FdWTZX0U1hsbDMZ4zEHFc1w+neeY
5BpDWK/JTZu7yOvMqRGTg9DQc7iWdg==
=hJOT
-----END PGP SIGNATURE-----

--gvqvn6hs6msar5bv--
