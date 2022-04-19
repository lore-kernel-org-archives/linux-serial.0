Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFFEC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 19 Apr 2022 14:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347442AbiDSO1J (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Apr 2022 10:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiDSO1I (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 10:27:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFC2366A1
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 07:24:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ngomG-0000FA-LN; Tue, 19 Apr 2022 16:24:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ngomD-003zLY-8J; Tue, 19 Apr 2022 16:24:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ngomB-004HcX-05; Tue, 19 Apr 2022 16:24:19 +0200
Date:   Tue, 19 Apr 2022 16:24:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Lukas Wunner <lukas.wunner@intel.com>, kernel@pengutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/1] serial: 8250: revert UART_CAP_NOTEMT changes
Message-ID: <20220419142405.xpwzvgnmh3oyoxge@pengutronix.de>
References: <db15ba9d-d914-53fa-23b8-870df7bb13@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7bvuicodhiptnqn6"
Content-Disposition: inline
In-Reply-To: <db15ba9d-d914-53fa-23b8-870df7bb13@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--7bvuicodhiptnqn6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 19, 2022 at 04:39:49PM +0300, Ilpo J=C3=A4rvinen wrote:
>=20
> This reverts UART_CAP_NOTEMT commit and driver changes depending
> on it:
>   f6f586102ad1 (serial: 8250: Handle UART without interrupt on TEMT
>                 using em485)
>   296385fe1275 (serial: 8250: Add UART_CAP_NOTEMT on PORT_16550A_FSL64)
>   bec1f1b66a6a (serial: 8250: add compatible for fsl,16550-FIFO64)
>=20
> The UART_CAP_NOTEMT code added in f6f586102add1 (serial: 8250:
> Handle UART without interrupt on TEMT using em485) containts math
> overflow for 32-bit archs. In addition, the approach used in it
> is unnecessarily complicated requiring a dedicated timer just for
> notemt. A simpler approach for providing UART_CAP_NOTEMT already
> exists (patches 1-2):
>   https://lore.kernel.org/linux-serial/20220411083321.9131-3-ilpo.jarvine=
n@linux.intel.com/T/#u
> Thus, simply revert the UART_CAP_NOTEMT changes for now.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Oh I wasn't aware that Greg picked that up. OK for me to revert.

I wonder however if it's nice to revert three patches in one commit. I
would have just reverted f6f586102ad1 and kept the define
UART_CAP_NOTEMT such that the other two patches are noops until your
fixed series comes in. Just my 0.02=E2=82=AC.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7bvuicodhiptnqn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJexgIACgkQwfwUeK3K
7AmpPQf9EesTRGgfz4XOYf+v/xD0gLqNrg3oVmPjgpXE8RCJpucdUUCaZy6Ea7u1
KEHqqJXk9B1DkQESpA5eOijd/7ehq3rqU0pILxlc3l/6hXuvU8mYjNKSqI4+E9n1
wh7cHNNIRlRIvn4e3fmT2e3FbkNoXgG70enadz8Hv3ZjPYSEspRs7DbyWUapam4u
bQZqWXgwC/6XxU2Ig8OJwr4BGciwX7khgaFPEPXNmJZU7d2n5IdaUPVbGo7AkuK2
FXmSrt5cbWOSAz2hqURn/GOihbbBVFKxDb2eXKLyaStynjtmTl8l51WOAYBaPnYq
P4tA3v6lpSkqPsXinlfgzszWxocIzQ==
=cyO+
-----END PGP SIGNATURE-----

--7bvuicodhiptnqn6--
