Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459D4C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 08:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CD46109F
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 08:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJNIMo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Oct 2021 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhJNIMn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Oct 2021 04:12:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D461DC061570
        for <linux-serial@vger.kernel.org>; Thu, 14 Oct 2021 01:10:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mavov-0004Tx-Nz; Thu, 14 Oct 2021 10:10:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mavou-000666-3g; Thu, 14 Oct 2021 10:10:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mavou-0002HU-2L; Thu, 14 Oct 2021 10:10:32 +0200
Date:   Thu, 14 Oct 2021 10:10:28 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] serial: imx: fix crash when un/re-binding console
Message-ID: <20211014081028.xafpuzrxk3jvv5qn@pengutronix.de>
References: <20211014071053.568598-1-francesco.dolcini@toradex.com>
 <20211014071053.568598-2-francesco.dolcini@toradex.com>
 <YWfdY/ws353nJEiE@kroah.com>
 <20211014080153.GA554920@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iz57hkn4h56mzq3"
Content-Disposition: inline
In-Reply-To: <20211014080153.GA554920@francesco-nb.int.toradex.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--7iz57hkn4h56mzq3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 14, 2021 at 10:01:53AM +0200, Francesco Dolcini wrote:
> Hello Greg,
>=20
> On Thu, Oct 14, 2021 at 09:33:55AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 14, 2021 at 09:10:52AM +0200, Francesco Dolcini wrote:
> > > From: Stefan Agner <stefan@agner.ch>
> > >=20
> > > If the device used as a serial console gets un/re-binded, then
> > > register_console() will call imx_uart_setup_console() again.
> > > Drop __init so that imx_uart_setup_console() can be safely called
> > > at runtime.
> > >=20
> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  drivers/tty/serial/imx.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > What commit does this "fix"?
>=20
> root@colibri-imx6ull-06746657:~# cat /sys/devices/virtual/tty/console/act=
ive=20
> tty1 ttymxc0
> root@colibri-imx6ull-06746657:~# echo -n N > /sys/devices/virtual/tty/con=
sole/subsystem/ttymxc0/console
> root@colibri-imx6ull-06746657:~# echo -n Y > /sys/devices/virtual/tty/con=
sole/subsystem/ttymxc0/console
>=20
> struct console ->setup is called at that time, but imx_uart_console_setup=
() is gone ...
>=20
> According to the original report from Stefan the issue is the same with u=
nbind/bind of the console,
> see https://marc.info/?l=3Dlinux-serial&m=3D154221779312036&w=3D2.
>=20
>=20
> > Should this go to stable kernels?  If so, how far back?
> This is present also in 4.19 kernel, I feel like the issue is there since=
 it is possible to unbind
> a console driver (since ever considering the current LTS releases?). I co=
uld
> investigate this a little bit more.
>=20
> We have this patch in our kernel branch since 3 years but for some reason=
 we never managed to upstream it.

I think this is a bigger problem not only affecting imx.c. Just look at
the output of:

	git grep -E '__init.*setup' drivers/tty/serial/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7iz57hkn4h56mzq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFn5fIACgkQwfwUeK3K
7AnK/gf+LS9s+Y0iy7CYtbYGTeIDtdh+c4q/+6bqNI5p/eGXkA3WVtLuaHZJpF3L
R/NM0vLyHpXH9lM9W3MjMp78HSklH1fAw7/kWu166ilgEduvNMQCQ8U/rYX431Zm
7MikNsPcBx9ogsiPTntleUI3MYj/wh1LqfY9HS1RNtUrGRnZsifeTa7ygdEGTAz4
C+e0x9haYGePqv56Bxl4gM7xkV9LMKJLJn1/Yvlas0yTNGNWAmzJMPTZ7rijXoSx
rcYUE8aP7NbtF+oIhjCoSkkf6/YxZwdE4Qg56Ynud4l/UH6keUCUGtnLUEvTUghO
D+2mc6wKGqRD/jiJnuNYFkJlUmzwtg==
=Jz2F
-----END PGP SIGNATURE-----

--7iz57hkn4h56mzq3--
