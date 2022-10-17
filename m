Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF42C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 17 Oct 2022 09:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJQJpP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Oct 2022 05:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJQJpL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Oct 2022 05:45:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8890831FA9
        for <linux-serial@vger.kernel.org>; Mon, 17 Oct 2022 02:45:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1okMgD-0006ce-TH; Mon, 17 Oct 2022 11:45:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1okMgB-00232a-0Q; Mon, 17 Oct 2022 11:45:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1okMgA-008Whv-AG; Mon, 17 Oct 2022 11:45:02 +0200
Date:   Mon, 17 Oct 2022 11:45:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: UART on MPC83xx in irq loop
Message-ID: <20221017094500.3wwd2njnao7rru4n@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7b5g45ydynxhqvqr"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--7b5g45ydynxhqvqr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have a system based on MPC8313ERDB here that in some situations gets
stuck in an irq loop. I have a reproducer here that works reliably. A
workaround is:

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index 45b8a59d937c..5ab32b6ba701 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2009,6 +2009,14 @@ int serial8250_handle_irq(struct uart_port *port, un=
signed int iir)
=20
 	status =3D serial_port_in(port, UART_LSR);
=20
+	/*
+	 * Sometimes a "Character time-out" (IID3:0 =3D=3D 0xc) happens on MPC831=
3,
+	 * but LSR doesn't report "Data ready". To clear the former the receive
+	 * buffer must be read. It's unclear if the char read is valid or not.
+	 */
+	if ((iir & UART_IIR_ID) =3D=3D UART_IIR_RX_TIMEOUT)
+		status |=3D UART_LSR_DR;
+
 	/*
 	 * If port is stopped and there are no error conditions in the
 	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer

I havn't debugged that further than written in the comment but I wonder
if this is a known issue (didn't find it in the errata though) and/or if
someone with hardware knowledge could confirm this to be a hardware
fault.

Without feedback from NXP I'd look in more detail into that to for
example find out the timing and so maybe more hints about the hardware
and a better SW workaround/fix.

Any input is very welcome.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7b5g45ydynxhqvqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNNJBoACgkQwfwUeK3K
7AmWywf/XrIf4XHYAD5ADsHKiyhBOcT462A7xg9SyDdTXKIQzRTfzwXKxP1qQd5S
g/C3AWm6bWrXY/yYkXJJsLzXjvtmCXjy9ZG/HrTFBpermiDxKuWvUgkgY9A2NmA+
SCNirAxNuZ7LN6GzRWBgB1zhek6pBaBhGfKbk5d/hdjOeD7LBkcXHtRnjhdS29QX
vf3eoQCA6jPRCRqY6Bohuu9yTs38YMC8r8V8YUdTkB3KH+DTxjE5W7ZmoX1Wc/ty
5ahtRSQlviHMmH1QhWHtfeddwSPJHUUewcnTocYaE+DvHh7MzswuBThPL5YeL7oa
yJ3+YMw9cwC/ZwXkTtqDvr8yF3n1Ag==
=QIHE
-----END PGP SIGNATURE-----

--7b5g45ydynxhqvqr--
