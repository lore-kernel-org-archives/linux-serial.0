Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB100C433DB
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F97C6199F
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhCVLz4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhCVLzk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 07:55:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0504C061574
        for <linux-serial@vger.kernel.org>; Mon, 22 Mar 2021 04:55:39 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOJ9l-0001wO-R7; Mon, 22 Mar 2021 12:55:37 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOJ9k-0002yG-AV; Mon, 22 Mar 2021 12:55:36 +0100
Date:   Mon, 22 Mar 2021 12:55:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Nobs <samuel.nobs@taitradio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <20210322115536.knkea7i6vrfpotol@pengutronix.de>
References: <20210322111036.31966-1-johan@kernel.org>
 <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
 <20210322113918.ze52gq54cpsspgej@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7izeeft7juynhm6v"
Content-Disposition: inline
In-Reply-To: <20210322113918.ze52gq54cpsspgej@linutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--7izeeft7juynhm6v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Sebastian,

On Mon, Mar 22, 2021 at 12:39:18PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-03-22 12:34:02 [+0100], Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 22, 2021 at 12:10:36PM +0100, Johan Hovold wrote:
> > > Force-threaded interrupt handlers used to run with interrupts enabled,
> > > something which could lead to deadlocks in case a threaded handler
> > > shared a lock with code running in hard interrupt context (e.g. timer
> > > callbacks) and did not explicitly disable interrupts.
> > >=20
> > > This was specifically the case for serial drivers that take the port
> > > lock in their console write path as printk can be called from hard
> > > interrupt context also with forced threading ("threadirqs").
> > >=20
> > > Since commit 81e2073c175b ("genirq: Disable interrupts for force
> > > threaded handlers") interrupt handlers always run with interrupts
> > > disabled on non-RT so that drivers no longer need to do handle this.
> >=20
> > So we're breaking RT knowingly here? If this is the case I'm not happy
> > with your change. (And if RT is not affected a different wording would
> > be good.)
>=20
> Which wording, could you be more specific? It looks good from here and
> no, RT is not affected.

The commit log says essentially: "The change is fine on non-RT" which
suggests there is a problem on RT. So something like:

	On non-RT interrupts are disabled also for force threaded handlers
	(since commit 81e2073c175b ...). On RT there is no problem either
	because ... So we don't need to handle this case in the driver any more.

would be preferable.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7izeeft7juynhm6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYhbUACgkQwfwUeK3K
7AkgqAgAgTgdaglMq9hbZzRXzVYb3dpQz/Wevwb7A3UCS5godfj5mzrFMKzUWz16
MkcP7qv5pbyj5xvK4HgZWhE06mPXkR3k/H3B8yeCNG00TUe5SDM1sPbKPZLc2SzI
uRzU0ImeVHodghGBuYKRUqEiSliwCGJzUBZFZc5Ij5tfNgXvk0kXNdxnWX7d3NzQ
i23EdTPCDBAxSl1CmkjocnP8o9lEbBIOSVtXE8PBWKmiqqOM03xn8NsJcuTTuTji
CkNlkvpU/QgA+/Un0fSq/gflti8zkVFz0GJFqcR5OFysAcfsIu8uc2zpcoP8aXvZ
mERj0gQCekf6AzoeYALL2uOWeDbyRA==
=ZyzD
-----END PGP SIGNATURE-----

--7izeeft7juynhm6v--
