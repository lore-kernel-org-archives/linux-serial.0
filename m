Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42872C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 10 Jan 2022 08:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbiAJIdu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Jan 2022 03:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240921AbiAJIcA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jan 2022 03:32:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4668C06173F
        for <linux-serial@vger.kernel.org>; Mon, 10 Jan 2022 00:31:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n6q5r-0004oU-J8; Mon, 10 Jan 2022 09:31:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n6q5q-009UQt-BF; Mon, 10 Jan 2022 09:31:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n6q5p-0003jm-52; Mon, 10 Jan 2022 09:31:53 +0100
Date:   Mon, 10 Jan 2022 09:31:52 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        k.drobinski@camlintechnologies.com
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
Message-ID: <20220110083152.sluto2jw4awuopc3@pengutronix.de>
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <YdQndwYc9xaauvpS@kroah.com>
 <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
 <YdQxmQ+OMCrabg2u@kroah.com>
 <20220104224900.u3omfbilejx2jawr@pengutronix.de>
 <87tuei4882.fsf@osv.gnss.ru>
 <20220106150552.vdt5qabe2xj4kasg@pengutronix.de>
 <a6f0b0dc-da67-2488-16b2-40f5ad049fde@camlingroup.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7jehinsyegtgpqj5"
Content-Disposition: inline
In-Reply-To: <a6f0b0dc-da67-2488-16b2-40f5ad049fde@camlingroup.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--7jehinsyegtgpqj5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 10, 2022 at 07:14:58AM +0100, Tomasz Mo=C5=84 wrote:
> On 06.01.2022 16:05, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Jan 05, 2022 at 04:34:21PM +0300, Sergey Organov wrote:
> >> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
> >>> Maybe it's more sensible to make this even more dynamic: e.g. keep it=
 at
> >>> 1 as default and increase the water level when a certain irq frequency
> >>> is reached?
> >>
> >> Too complex, and too many questions, I'm afraid. What is "irq
> >> frequency", exactly? For this particular driver, or overall system?
> >> Measured on what time interval? What is the threshold? Do we drop the
> >> water level back to 1 when "irq frequency" is down again? Will we just
> >> create re-configure storm at some conditions? Etc.....
> >=20
> > It could be as easy as increasing the waterlevel by one if an RX irq
> > happens with USR1.AGTIM =3D 0 and reset to 1 if USR1.AGTIM =3D 1.
>=20
> This is indeed simple, but I fail to see the actual benefit of doing so.
>=20
> > This makes sure that receiving at a low frequency makes the hardware
> > interrupt the CPU early, and a burst doesn't starve the CPU.
>=20
> If the communication involves multiple characters sent in burst (frame),
> and includes some sort of CRC check (so only complete frames are useful,
> as no partial processing can be done because checksum has to be checked
> first), then it is the latency after the last character (not the first)
> that matters.

Agreed, and if the setup is different it might be better if the
configured waterlevel is lower.

> RXTL upper value has to be capped. If RXTL goes above CTSTL then it
> would limit throughput if hardware flow control is enabled. If hardware
> flow control is not enabled, then the higher RXTL gets, the higher is
> the risk of not reading RxFIFO in time. Setting RXTL to quarter of the
> RxFIFO (8) seems to leave enough time for RX interrupt and at the same
> time noticeably lowers the interrupt rate.

I thought a bit about different usecases and the latency penalty for
increasing RXTL from 1 to 8 is at most 8 character frames (i.e. the time
until the aging irq triggers) which happens with a probability of 7/8.
For fast transfers it's a bit less. For a smaller RXTL the penalty is
still 8 character frames but the probablity is a bit lower.
(RXTL - 1 / RXTL, i.e. 0 in the status quo with RXTL =3D 1)

So the dynamic approach is only a tad better on avarage and the worst
case latency is the same. (Assuming a random message length.)

The worst case is always: There are between 1 and RXTL - 1 chars sitting
in the FIFO and waiting for 8 character frames until they are received.

So I agree to just increasing the RXTL value to 8, and if there is a
problem with that, we can still consider the dynamic approach then.

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7jehinsyegtgpqj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHb7vUACgkQwfwUeK3K
7Albcgf/a3n6AspctxJ5GVx9fI3VnQQ2WJryRSyBtasDSbNGoOYmYNb42csnfXTC
/b49g0ec/oJwbIBSGR4kjoJr4SUXOn9N86LMRlTfy9LJZC/RyfhvhgwWC3WLwDtF
4149koVs8aTwVy2RBXH81f1gTkhgBmxAoSbcB5KUes+ZH4wAKoWOjheBgpgfj/91
iP5nsLcZdi0y0JbG7VGYPon5ILXGVnIOH2jcuTXoVM81N3RZSnl/BxYL6bp7Yxs0
n8/XTGOYr5ckVWAcaWGq1hMlGFXCm23wevkhqgxKTuVpRnipm/PT5nr8xJ+avvzv
PIqjkKf5oyP553fwTxUPy3gVH29jsA==
=SX8b
-----END PGP SIGNATURE-----

--7jehinsyegtgpqj5--
