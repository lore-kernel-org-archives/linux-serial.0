Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D187C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FA561990
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCVLeX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCVLeF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 07:34:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F80C061574
        for <linux-serial@vger.kernel.org>; Mon, 22 Mar 2021 04:34:05 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOIot-0007Tu-H6; Mon, 22 Mar 2021 12:34:03 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOIos-000101-Qy; Mon, 22 Mar 2021 12:34:02 +0100
Date:   Mon, 22 Mar 2021 12:34:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Nobs <samuel.nobs@taitradio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
References: <20210322111036.31966-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wf6me76eh66ksbak"
Content-Disposition: inline
In-Reply-To: <20210322111036.31966-1-johan@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--wf6me76eh66ksbak
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 12:10:36PM +0100, Johan Hovold wrote:
> Force-threaded interrupt handlers used to run with interrupts enabled,
> something which could lead to deadlocks in case a threaded handler
> shared a lock with code running in hard interrupt context (e.g. timer
> callbacks) and did not explicitly disable interrupts.
>=20
> This was specifically the case for serial drivers that take the port
> lock in their console write path as printk can be called from hard
> interrupt context also with forced threading ("threadirqs").
>=20
> Since commit 81e2073c175b ("genirq: Disable interrupts for force
> threaded handlers") interrupt handlers always run with interrupts
> disabled on non-RT so that drivers no longer need to do handle this.

So we're breaking RT knowingly here? If this is the case I'm not happy
with your change. (And if RT is not affected a different wording would
be good.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wf6me76eh66ksbak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYgKcACgkQwfwUeK3K
7AmnFAf/UTf0HIa8YjVOJLVTqlkCdbExe8cENZWveMj7/3CZDflNU9S+cayKynL1
nDnyZOhtIer1yGqpmWURc7dNuyuIPRUbt3hLlDDjqXwTVHYQ+UokZrceSRw0HFJg
IGpTVsGhJFZ5eNP8VfL4dCpaJ3Ztw/j/xJZecZAuvzrsdMsYKcDFPtTtCahy05nK
Z0mnTqFcJ5uyclx/djBPWwIAOPVTWKq3O7Adarq7O+kooBQ9364v5VFusumHnKlo
rIdK516Zb1HJWTds/wpggmceBbuPUNbsbqAV6+VKufxWnOkjuHn7jCP/C/HCXain
yBxZHl/ID0hqYBR6iYi102kA+sb7GA==
=4pb6
-----END PGP SIGNATURE-----

--wf6me76eh66ksbak--
