Return-Path: <SRS0=yy8S=EB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB755C4363A
	for <linux-serial@archiver.kernel.org>; Mon, 26 Oct 2020 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC50206FB
	for <linux-serial@archiver.kernel.org>; Mon, 26 Oct 2020 16:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786121AbgJZQfL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:35:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52179 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1785993AbgJZQfL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Oct 2020 12:35:11 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kX5SZ-00075n-RG; Mon, 26 Oct 2020 17:35:03 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kX5SX-0001c1-Ec; Mon, 26 Oct 2020 17:35:01 +0100
Date:   Mon, 26 Oct 2020 17:34:59 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH -next] tty: serial: imx: remove unnecessary breaks
Message-ID: <20201026163459.bnoxhmncnnf7cwca@pengutronix.de>
References: <20201026125142.21105-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7xn7dhcerkqgjhew"
Content-Disposition: inline
In-Reply-To: <20201026125142.21105-1-zhangqilong3@huawei.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--7xn7dhcerkqgjhew
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello,

On Mon, Oct 26, 2020 at 08:51:42PM +0800, Zhang Qilong wrote:
> The 'break' is not possoble to be reached
s/possoble/possible/

> because of previous 'return', discard it.

Given that this such a patch was already sent a week ago[1], I wonder if
there is a tool that complains here? If so, mentioning it in the commit
log would be good.

Other than that I still think that there should be at least an empty
line instead of the break, as I already wrote in reply to the first
patch. And having said that I also don't think this is worth "fixing",
seeing the break in a switch statement is good for human readers.

Best regards
Uwe

[1] https://lore.kernel.org/r/20201019175915.3718-1-trix@redhat.com
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7xn7dhcerkqgjhew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+W+rAACgkQwfwUeK3K
7AlGbwf+NLS02idHbrREkEgDpqpRvYbQ5ZNFgFqwKh4mgVjvR1nP/L8m5CuWrb7n
uedCKpMWwpMjQxNdXm6YQ8eK9UWCTbbOggV0VCKQAz+yOSz048TCBuQvT0dhsP7s
dyEJ9wostTt6OK6bDQhw6yJ4PvaydiDp1xjjR3L6jN/BP7oEqZI3DUNzAh/AboRh
CxCk/gEu2pOmUHiJSJdnFjT7/PPnNK5m0YR7ChQ4K8oT/JWa1pdXGIxYWIPBvID9
FvJQLCbqgkIWM7SjAGxZ/vUAb3WuRT0ngvQpSRaOLdw/EhsPUzSaVU81gx2Z61U9
61YeuN+3r8IklvE7NWhR0Y9NicFG7g==
=Etz+
-----END PGP SIGNATURE-----

--7xn7dhcerkqgjhew--
