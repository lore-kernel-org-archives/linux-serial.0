Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4190C38A2D
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 06:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiJZG4M (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 02:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJZG4L (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 02:56:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372E719AB
        for <linux-serial@vger.kernel.org>; Tue, 25 Oct 2022 23:56:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1onaKe-0001oe-1h; Wed, 26 Oct 2022 08:56:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onaKc-000SJL-KW; Wed, 26 Oct 2022 08:56:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onaKa-00Ajpw-VV; Wed, 26 Oct 2022 08:56:04 +0200
Date:   Wed, 26 Oct 2022 08:56:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     linux-serial@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Johan Hovold <johan@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: imx serial chars lost issue
Message-ID: <20221026065604.xp4lzysm2ag7bfmk@pengutronix.de>
References: <20221003110850.GA28338@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="krsfe6fysl3sdpfk"
Content-Disposition: inline
In-Reply-To: <20221003110850.GA28338@francesco-nb.int.toradex.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--krsfe6fysl3sdpfk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Francesco,

On Mon, Oct 03, 2022 at 01:08:50PM +0200, Francesco Dolcini wrote:
> recently I have been experiencing an issue with the imx uart on i.MX6ULL
> SoC, on the tty console (no flow control, 1152008n1), chars after the 32nd
> are lost when typing "fast" (copy/paste or writing to the uart using
> automated tools).
>=20
> This was tested on Linux 6.0, however it does not look like a brand new
> regression, kernel 5.4 was somehow subject to the same issue, although
> it was way more difficult to trigger it.
>=20
> While I do understand that without flow control this is something that
> cannot be prevented, it is pretty fishy that is always the chars after
> the 32nd.
>=20
> I guess that might be happening is that the FIFO is emptied only by a
> timer or when it is full, instead of emptying it when half-full, and the
> CPU might not be fast enough leading to an overflow and the chars lost.
>=20
> Any idea?

It's not unheared that there are bugs in the imx serial driver, but I'm
at least half confident that it's not a driver issue.

I guess commit 7a637784d517 ("serial: imx: reduce RX interrupt
frequency") is relevant, this was added in v5.18-rc1.

If this is really the commit that made the issue easier to reproduce,
then this is a hint that there is no functional problem and we're "just"
talking about irq latency issues. If enabling flow control solves the
issue, this is another hint in the same direction.

So I think this is what happens:

The other side starts sending chars at a high frequency. Once the RX
FIFO fill level reaches 8 an irq is triggered. Now if there are 25 more
characters received before the irq is serviced you get an overflow and
loose chars. Without 7a637784d517 there is a bit more time (i.e. 7
character times).

So either you use a very high baud rate that is hard to handle (compared
to the cpu frequency), or this is a side effect of increased irq
latency (which is likely a problem somewhere else).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--krsfe6fysl3sdpfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNY2gEACgkQwfwUeK3K
7AnhXAgAlXUHeJGjdP+YmpHFEQByWQWSJ4tpq3s6UROSwFxCB6Kgk7ZwAH4VrQLh
SbeTODn27kXFzvKg2PlIYAwqEuENym7wzcXT9JDlmHs3zMZnmCcRimBsK2483zOU
5zfE8abnRU0ivvVGdTI39XUbSDDZZlr4c8TDAhTlzsrPjzY4n1UpQ2gIukTUz3WO
R0NedSwYELOxS5SWuLkh+COjlXs6/CNEEnysmNXi1d2SE21WzgiCLwIMBxdsgG9+
yV7d232hNTFJDctSD0+iq3AFcPgtT5atdHMP0fb0FtiBAAdJXep4lExjsITo2oEd
7H9LknhRZQu7sZT/ST08YonRzRDFzg==
=6CVO
-----END PGP SIGNATURE-----

--krsfe6fysl3sdpfk--
