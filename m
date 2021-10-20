Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47983C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 19:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DED760FED
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 19:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJTTlw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhJTTlw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Oct 2021 15:41:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9EEC06161C
        for <linux-serial@vger.kernel.org>; Wed, 20 Oct 2021 12:39:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mdHQq-0005D2-Bl; Wed, 20 Oct 2021 21:39:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mdHQo-0006ar-E2; Wed, 20 Oct 2021 21:39:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mdHQo-0005K5-Ci; Wed, 20 Oct 2021 21:39:22 +0200
Date:   Wed, 20 Oct 2021 21:39:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] serial: imx: fix detach/attach of serial console
Message-ID: <20211020193921.7fofxvnhgjjadt5u@pengutronix.de>
References: <20211020192643.476895-1-francesco.dolcini@toradex.com>
 <20211020192643.476895-2-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jgyp6rxza6t5nhtz"
Content-Disposition: inline
In-Reply-To: <20211020192643.476895-2-francesco.dolcini@toradex.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--jgyp6rxza6t5nhtz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 20, 2021 at 09:26:42PM +0200, Francesco Dolcini wrote:
> From: Stefan Agner <stefan@agner.ch>
>=20
> If the device used as a serial console gets detached/attached at runtime,
> register_console() will try to call imx_uart_setup_console(), but this
> is not possible since it is marked as __init.
>=20
> For instance
>=20
>   # cat /sys/devices/virtual/tty/console/active
>   tty1 ttymxc0
>   # echo -n N > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
>   # echo -n Y > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
>=20
> [   73.166649] 8<--- cut here ---
> [   73.167005] Unable to handle kernel paging request at virtual address =
c154d928
> [   73.167601] pgd =3D 55433e84
> [   73.167875] [c154d928] *pgd=3D8141941e(bad)
> [   73.168304] Internal error: Oops: 8000000d [#1] SMP ARM
> [   73.168429] Modules linked in:
> [   73.168522] CPU: 0 PID: 536 Comm: sh Not tainted 5.15.0-rc6-00056-g396=
8ddcf05fb #3
> [   73.168675] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> [   73.168791] PC is at imx_uart_console_setup+0x0/0x238
> [   73.168927] LR is at try_enable_new_console+0x98/0x124
> [   73.169056] pc : [<c154d928>]    lr : [<c0196f44>]    psr: a0000013
> [   73.169178] sp : c2ef5e70  ip : 00000000  fp : 00000000
> [   73.169281] r10: 00000000  r9 : c02cf970  r8 : 00000000
> [   73.169389] r7 : 00000001  r6 : 00000001  r5 : c1760164  r4 : c1e0fb08
> [   73.169512] r3 : c154d928  r2 : 00000000  r1 : efffcbd1  r0 : c1760164
> [   73.169641] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
> [   73.169782] Control: 10c5387d  Table: 8345406a  DAC: 00000051
> [   73.169895] Register r0 information: non-slab/vmalloc memory
> [   73.170032] Register r1 information: non-slab/vmalloc memory
> [   73.170158] Register r2 information: NULL pointer
> [   73.170273] Register r3 information: non-slab/vmalloc memory
> [   73.170397] Register r4 information: non-slab/vmalloc memory
> [   73.170521] Register r5 information: non-slab/vmalloc memory
> [   73.170647] Register r6 information: non-paged memory
> [   73.170771] Register r7 information: non-paged memory
> [   73.170892] Register r8 information: NULL pointer
> [   73.171009] Register r9 information: non-slab/vmalloc memory
> [   73.171142] Register r10 information: NULL pointer
> [   73.171259] Register r11 information: NULL pointer
> [   73.171375] Register r12 information: NULL pointer
> [   73.171494] Process sh (pid: 536, stack limit =3D 0xcd1ba82f)
> [   73.171621] Stack: (0xc2ef5e70 to 0xc2ef6000)
> [   73.171731] 5e60:                                     ???????? ???????=
? ???????? ????????
> [   73.171899] 5e80: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.172059] 5ea0: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.172217] 5ec0: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.172377] 5ee0: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.172537] 5f00: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.172698] 5f20: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.172856] 5f40: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.173016] 5f60: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.173177] 5f80: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.173336] 5fa0: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.173496] 5fc0: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.173654] 5fe0: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.173826] [<c0196f44>] (try_enable_new_console) from [<c01984a8>] (r=
egister_console+0x10c/0x2ec)
> [   73.174053] [<c01984a8>] (register_console) from [<c06e2c90>] (console=
_store+0x14c/0x168)
> [   73.174262] [<c06e2c90>] (console_store) from [<c0383718>] (kernfs_fop=
_write_iter+0x110/0x1cc)
> [   73.174470] [<c0383718>] (kernfs_fop_write_iter) from [<c02cf5f4>] (vf=
s_write+0x31c/0x548)
> [   73.174679] [<c02cf5f4>] (vfs_write) from [<c02cf970>] (ksys_write+0x6=
0/0xec)
> [   73.174863] [<c02cf970>] (ksys_write) from [<c0100080>] (ret_fast_sysc=
all+0x0/0x1c)
> [   73.175052] Exception stack(0xc2ef5fa8 to 0xc2ef5ff0)
> [   73.175167] 5fa0:                   ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.175327] 5fc0: ???????? ???????? ???????? ???????? ???????? ???????=
? ???????? ????????
> [   73.175486] 5fe0: ???????? ???????? ???????? ????????
> [   73.175608] Code: 00000000 00000000 00000000 00000000 (00000000)
> [   73.175744] ---[ end trace 9b75121265109bf1 ]---
>=20
> A similar issue could be triggered unbinding/binding the serial console
> device [*].
>=20
> Drop __init so that imx_uart_setup_console() can be safely called at
> runtime.
>=20
> [*] https://lore.kernel.org/all/20181114174940.7865-3-stefan@agner.ch/
>=20
> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device=
 for console")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jgyp6rxza6t5nhtz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFwcGUACgkQwfwUeK3K
7AlzsAgAj71QeD7ML3yoaettATnFzeluFWpv4tvf7/BicZhCTovrl/PZZ1p1L22/
Rlh8UFOkE4TMm+geNnH/U27BDvp8C+rIJSRDWNyxqtEQfa07nA+YIS/MahjA+DgF
PHpE1Y5vpZWnoojKCXn4RnTlhiCDiKP+9OUq/LGZGqnommjUgnxbM0wn6FeFOKiu
wEDrSzUd+ySSKBaWP/z0T5Z8RwJFUZTFx2V+4aPuu1Bg1bwOt1tOEIz7mUC4I+ap
3Ah0c8qNKdVEeLU8+NzzKbi5GPeXys9ngbUtrAY2/mUI97m/XnyA8Bm8yO4s8izp
7kT0wYUkH09lbyVPz+176wsJhdaa7w==
=zMJ1
-----END PGP SIGNATURE-----

--jgyp6rxza6t5nhtz--
