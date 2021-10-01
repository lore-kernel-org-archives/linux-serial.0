Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5236C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 12:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FD061A8B
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 12:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353655AbhJAMck (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 08:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhJAMcg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 08:32:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF49C061775
        for <linux-serial@vger.kernel.org>; Fri,  1 Oct 2021 05:30:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mWHgV-00065L-Oj; Fri, 01 Oct 2021 14:30:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mWHgQ-0001DT-4A; Fri, 01 Oct 2021 14:30:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mWHgQ-0002ZN-2n; Fri, 01 Oct 2021 14:30:34 +0200
Date:   Fri, 1 Oct 2021 14:30:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Eric Tremblay <etremblay@distech-controls.com>
Cc:     kernel test robot <lkp@intel.com>, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de
Subject: Re: [PATCH v2 1/3] serial: 8250: Handle UART without interrupt on
 TEMT using em485
Message-ID: <20211001123033.l7ivfm35knnp3j5s@pengutronix.de>
References: <20210204161158.643-2-etremblay@distech-controls.com>
 <202102050539.ILyUUHHw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qrt5arkzevvzhv5i"
Content-Disposition: inline
In-Reply-To: <202102050539.ILyUUHHw-lkp@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--qrt5arkzevvzhv5i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Feb 05, 2021 at 05:36:44AM +0800, kernel test robot wrote:
> Hi Eric,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on tty/tty-testing]
> [also build test ERROR on usb/usb-testing v5.11-rc6 next-20210125]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Eric-Tremblay/Handle-UAR=
T-without-interrupt-on-TEMT-using-em485/20210205-002255
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tt=
y-testing
> config: ia64-randconfig-r032-20210204 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/070c956e2d260c56b13f43b=
7d092b4a20664248c
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Eric-Tremblay/Handle-UART-withou=
t-interrupt-on-TEMT-using-em485/20210205-002255
>         git checkout 070c956e2d260c56b13f43b7d092b4a20664248c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cros=
s ARCH=3Dia64=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> >> ERROR: modpost: "uart_get_byte_size" [drivers/tty/serial/8250/8250_bas=
e.ko] undefined!

FTR: This is a missing EXPORT_SYMBOL_GPL for uart_get_byte_size().

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qrt5arkzevvzhv5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFW/2cACgkQwfwUeK3K
7AnNHgf+NctiIL+EfYSw911JkshMGJK6JfE1mHbsGchqkgItoTCvsEFHXS1+3H02
aXSlUL+JecBnnV/TXsvHC3nFIqAOer89aNYdwW8m2plJgEaWFg63UDlGvG3tpe+e
ZJxSMch9jwhnBjCaZQKAWF7dUfuCPfzG7TCk99vsWtgVqBWDrSaK9+UcvfA6zmcT
blMV61ooL2zP0zHymb5etdtSRf5+ukQkq9dfmprI34yZm12WvfVIu2fDW3JuVH0L
31RQnJEKYptsFc9VTbYJ7BTy8fCqSyiUWH5bw0G7S2FFydEGNbJkT2IA+Q3vl3EA
QT7wmTR9gcUYX3DTWzJ+7A/M/AaD3A==
=tU0w
-----END PGP SIGNATURE-----

--qrt5arkzevvzhv5i--
