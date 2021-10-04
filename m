Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE85EC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  4 Oct 2021 09:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25616124D
	for <linux-serial@archiver.kernel.org>; Mon,  4 Oct 2021 09:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhJDJr7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Oct 2021 05:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhJDJr7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Oct 2021 05:47:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8740AC061745
        for <linux-serial@vger.kernel.org>; Mon,  4 Oct 2021 02:46:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXKXn-0005Lx-Cy; Mon, 04 Oct 2021 11:45:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXKXk-00087w-4v; Mon, 04 Oct 2021 11:45:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXKXk-00081G-2w; Mon, 04 Oct 2021 11:45:56 +0200
Date:   Mon, 4 Oct 2021 11:45:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Eric Tremblay <etremblay@distech-controls.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, heiko.stuebner@theobroma-systems.com
Subject: Re: [PATCH v2 1/3] serial: 8250: Handle UART without interrupt on
 TEMT using em485
Message-ID: <20211004094555.26azbbzhzdzavjpf@pengutronix.de>
References: <20210204161158.643-1-etremblay@distech-controls.com>
 <20210204161158.643-2-etremblay@distech-controls.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pylzd3ugdvivstpl"
Content-Disposition: inline
In-Reply-To: <20210204161158.643-2-etremblay@distech-controls.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--pylzd3ugdvivstpl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped christoph.muellner@theobroma-systems.com from Cc: as the
address doesn't seem to work any more]

On Thu, Feb 04, 2021 at 11:11:56AM -0500, Eric Tremblay wrote:
> The patch introduce the UART_CAP_NOTEMT capability. The capability
> indicate that the UART doesn't have an interrupt available on TEMT.
>=20
> In the case where the device does not support it, we calculate the
> maximum time it could take for the transmitter to empty the
> shift register. When we get in the situation where we get the
> THRE interrupt, we check if the TEMT bit is set. If it's not, we start
> the a timer and recall __stop_tx() after the delay.
>=20
> The transmit sequence is a bit modified when the capability is set. The
> new timer is used between the last interrupt(THRE) and a potential
> stop_tx timer.

I wonder if the required change can be simplified by just increasing the
stop_tx_timer timeout as there is nothing that has to happen when the
shifter is empty apart from starting the stop_tx timer.

This would require a good documentation because the semantic of the stop
timer would change.

@Eric: Do you plan to address the feedback comments here? I'd volunteer
as a tester if yes. Otherwise there might be some incentive to work on
this series myself.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pylzd3ugdvivstpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFazUsACgkQwfwUeK3K
7AmPowf+JkeIVicDG9Nv39f6Knk/CnoLyUdHesOXFHtpNs5rbnl3dyhTKAdNW2jf
8te6Q/6dkT8PmVB2aMUmQKTWZxmTxRjbRWiLY1NAiSK07WF576rm9O9B6/V9Tnwf
N1N0y8QYqKMOxGQ+4azCnPyzXinirhlJ8vddrv5FTKHMCTJhwuvthFdSywbc3k0J
pLa5BHjkpFjdp0imSjOvDnFPE19XzCCGW+jina7nLfa/R5rHtNHQAnVE4el0xYiA
zugLEhGjoDi7sbPicJd3y/lAVYJ2GqEffz521gg4CbdZ/vBnlmDfwwZ7Ix4l7rSK
YcZPfcFOgS6RAq2VUamtu0J9jvyFrQ==
=grO0
-----END PGP SIGNATURE-----

--pylzd3ugdvivstpl--
