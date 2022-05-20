Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B912C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 20 May 2022 13:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbiETNDK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 May 2022 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349687AbiETNDI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 May 2022 09:03:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980BB1053C9
        for <linux-serial@vger.kernel.org>; Fri, 20 May 2022 06:03:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ns2HZ-0006al-1Q; Fri, 20 May 2022 15:03:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ns2HZ-003UHr-DK; Fri, 20 May 2022 15:03:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ns2HX-00AyFz-AH; Fri, 20 May 2022 15:03:03 +0200
Date:   Fri, 20 May 2022 15:02:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: 8250: Store to lsr_save_flags after lsr read
Message-ID: <20220520130259.svpf3rei7jx6bsji@pengutronix.de>
References: <f4d774be-1437-a550-8334-19d8722ab98c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yiyq6vqla2ixgn4a"
Content-Disposition: inline
In-Reply-To: <f4d774be-1437-a550-8334-19d8722ab98c@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--yiyq6vqla2ixgn4a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 20, 2022 at 01:35:41PM +0300, Ilpo J=E4rvinen wrote:
> Not all LSR register flags are preserved across reads. Therefore, LSR
> readers must store the non-preserved bits into lsr_save_flags.
>=20
> This fix was initially mixed into feature commit f6f586102add ("serial:
> 8250: Handle UART without interrupt on TEMT using em485"). However,
> that feature change had a flaw and it was reverted to make room for
> simpler approach providing the same feature. The embedded fix got
> reverted with the feature change.
>=20
> Re-add the lsr_save_flags fix and properly mark it's a fix.
>=20
> Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
> Link: https://lore.kernel.org/all/1d6c31d-d194-9e6a-ddf9-5f29af829f3@linu=
x.intel.com/T/#m1737eef986bd20cf19593e344cebd7b0244945fc
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> ---
> Since Uwe didn't follow up with this fix in an isolated patch, I'm sendin=
g=20
> it now so that it doesn't end up falling through cracks.

Great, thanks. I completely obliterate that one.

Maybe it would be sensible to wrap reading + updating saved_flags in an
inline helper?

Other than that:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@penugtronix.de>

> tg: (4419da5d5d4b..) fix/lsr-save-flags (depends on: tty-next)

Oh wow, you're using topgit? I would be interested in your pain points
and what made you choose topgit anyhow. Since a longer time I have a few
ideas for a git helper that uses the good ideas in topgit, but never
came around to implement it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yiyq6vqla2ixgn4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKHkYAACgkQwfwUeK3K
7AkbgQf/dxmd0q+8XMzBbVvEUQcoJUZAml2byXzvf3ZDmhXXUJdRK7AtgVTtK+C5
ESRU9WqLCsxQ4ZkMExDv3CoJSN7mvuk0noFChp4UmR7+1CDXnEINP4G6Muof5Ese
RPqFIRENnRaRAMhkrqUTrCMyFqvHKv0DOKvn8rNYEzuqkZeoaLnX7ALK9URMmzSQ
vcXyCfJy+asKhhrZC41m3MmIO9regYsYW5ZeOEKOTA4Na4FwrQlWTAUqqeRXRDv9
vOKVakCGByloU8UK13qTs6sHgWv/GcrZ84MAtZZKdyQxmPE0auTdkdQgP2x1pvc6
cPFxfOBn6U480Z/nVGJurI29eb4ywA==
=YYzw
-----END PGP SIGNATURE-----

--yiyq6vqla2ixgn4a--
