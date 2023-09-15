Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558CEC46CA1
	for <linux-serial@archiver.kernel.org>; Fri, 15 Sep 2023 20:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjIOUWF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbjIOUVq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Sep 2023 16:21:46 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E12D42
        for <linux-serial@vger.kernel.org>; Fri, 15 Sep 2023 13:21:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhFJd-0000uN-SV; Fri, 15 Sep 2023 22:21:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhFJb-006c1g-Bq; Fri, 15 Sep 2023 22:21:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhFJb-001wEt-20; Fri, 15 Sep 2023 22:21:23 +0200
Date:   Fri, 15 Sep 2023 22:21:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marex@denx.de>, Petr Mladek <pmladek@suse.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty v1 29/74] serial: imx: Use port lock wrappers
Message-ID: <20230915202122.ulgy4fdxpsxmecbo@pengutronix.de>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-30-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5yzbhcwwpzzpyz5h"
Content-Disposition: inline
In-Reply-To: <20230914183831.587273-30-john.ogness@linutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--5yzbhcwwpzzpyz5h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 08:43:46PM +0206, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> When a serial port is used for kernel console output, then all
> modifications to the UART registers which are done from other contexts,
> e.g. getty, termios, are interference points for the kernel console.
>=20
> So far this has been ignored and the printk output is based on the
> principle of hope. The rework of the console infrastructure which aims to
> support threaded and atomic consoles, requires to mark sections which
> modify the UART registers as unsafe. This allows the atomic write function
> to make informed decisions and eventually to restore operational state. It
> also allows to prevent the regular UART code from modifying UART registers
> while printk output is in progress.
>=20
> All modifications of UART registers are guarded by the UART port lock,
> which provides an obvious synchronization point with the console
> infrastructure.
>=20
> To avoid adding this functionality to all UART drivers, wrap the
> spin_[un]lock*() invocations for uart_port::lock into helper functions
> which just contain the spin_[un]lock*() invocations for now. In a
> subsequent step these helpers will gain the console synchronization
> mechanisms.
>=20
> Converted with coccinelle. No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This lacks a Signed-off line by John.

Otherwise looks fine to me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5yzbhcwwpzzpyz5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUEvMIACgkQj4D7WH0S
/k7d1QgAtSZFhSbWNZ3DNrbQiS234baMNReoa4Svy8smEtmkIR5Filgu/8LwyMhK
EtNa38WuRaTN4vxC99fmBA2cWQzcJoORHde74SANgvcLjGaYPa9uQ0jktk1edo+t
dH7OzPbZ+jnq9zhcUJMVg/oK1m583S4wmp7gLPFcQx89R9rfFBEzVoRNPxDE+zIz
2Gu57tE3A9wDk1gtXUCkOV/BbSJhdeAjBtiMf6nrtWKfsCX7H7pvY7V+iMIL1d/r
dQ5/QidndBY24Fl5MA8FXao36BMjRsaOvRGNVFENheADGzyf0LinHtcjJ2pL/uLn
LQwSsb6nVBp/HjDJosyQbW8Kt2vpEg==
=J06s
-----END PGP SIGNATURE-----

--5yzbhcwwpzzpyz5h--
