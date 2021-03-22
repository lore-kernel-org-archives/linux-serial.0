Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD1C433E2
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 13:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8AF61974
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 13:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhCVNXq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231558AbhCVNVg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 09:21:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63D5C61920;
        Mon, 22 Mar 2021 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616419240;
        bh=PylH9sPq+BiwMbT0thhLCmMC0c6t2G8e8YGKgsiPnLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYCLSONFzvNSVaw41M2y2xFnqh1hsZTFDEV8wMnbTQmfxFz4LrP31W/xxXehUsvf5
         iZCrF7ak/MBjQcYnZufREQREBuGHM/V2vQIrK0b17miNYzllzE4SoGVhpicSQC3YJn
         epK31IgEl5qlg0AbLGZ13GI2w3QYXgDLmTpZk3msNgf4Sc6uMxVhray7AdTudjPDRb
         2gfpsQrE1I2xlY6GWVCch+/wspNVOzuVufytf0V+Jt5ODv86PjpkeF/hCioR+C4D+O
         GnWnkTB9dPiTvsivmNv6hhaV6FQkrosGrgA9Hv0FJ7viact+ZAZXXdzoMWNzWq4nz/
         O+45P6mSKQf8g==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOKUL-0008Jm-Pp; Mon, 22 Mar 2021 14:20:57 +0100
Date:   Mon, 22 Mar 2021 14:20:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Nobs <samuel.nobs@taitradio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <YFiZuXWYmxPIaQH9@hovoldconsulting.com>
References: <20210322111036.31966-1-johan@kernel.org>
 <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
 <20210322113918.ze52gq54cpsspgej@linutronix.de>
 <20210322115536.knkea7i6vrfpotol@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0amXQDi444UcwEvd"
Content-Disposition: inline
In-Reply-To: <20210322115536.knkea7i6vrfpotol@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--0amXQDi444UcwEvd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 12:55:36PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hallo Sebastian,
>=20
> On Mon, Mar 22, 2021 at 12:39:18PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2021-03-22 12:34:02 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Mar 22, 2021 at 12:10:36PM +0100, Johan Hovold wrote:
> > > > Force-threaded interrupt handlers used to run with interrupts enabl=
ed,
> > > > something which could lead to deadlocks in case a threaded handler
> > > > shared a lock with code running in hard interrupt context (e.g. tim=
er
> > > > callbacks) and did not explicitly disable interrupts.
> > > >=20
> > > > This was specifically the case for serial drivers that take the port
> > > > lock in their console write path as printk can be called from hard
> > > > interrupt context also with forced threading ("threadirqs").
> > > >=20
> > > > Since commit 81e2073c175b ("genirq: Disable interrupts for force
> > > > threaded handlers") interrupt handlers always run with interrupts
> > > > disabled on non-RT so that drivers no longer need to do handle this.
> > >=20
> > > So we're breaking RT knowingly here? If this is the case I'm not happy
> > > with your change. (And if RT is not affected a different wording would
> > > be good.)
> >=20
> > Which wording, could you be more specific? It looks good from here and
> > no, RT is not affected.
>=20
> The commit log says essentially: "The change is fine on non-RT" which
> suggests there is a problem on RT.

I don't think you can read that into the commit message. Why would I
knowingly break RT? And why would RT depend on patching individual
serial drivers in the first place?

That interrupt handlers run with interrupts enabled in RT is kind of
given. The unfortunate (buggy) bit was that they weren't always disabled
for non-RT.

Johan

--0amXQDi444UcwEvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCYFiZtAAKCRALxc3C7H1l
CC3MAPsFP38oaSUs2lUB7Pb8F2VVx63qwxHSI2Aq5/pY1DMu5wEA/bbSGqHCYRo2
4iL/3EZSKQ61BpMwYxg1MbK0rCyPxAo=
=vSUx
-----END PGP SIGNATURE-----

--0amXQDi444UcwEvd--
