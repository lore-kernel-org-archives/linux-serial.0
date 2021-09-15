Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7E7C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 08:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1752161157
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 08:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbhIOIHI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbhIOIHG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Sep 2021 04:07:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CCAC061574
        for <linux-serial@vger.kernel.org>; Wed, 15 Sep 2021 01:05:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mQPvI-0002tT-6R; Wed, 15 Sep 2021 10:05:40 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:8a97:9358:ae:5dc8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DA0B567E519;
        Wed, 15 Sep 2021 08:05:38 +0000 (UTC)
Date:   Wed, 15 Sep 2021 10:05:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 05/16] tty: remove file from tty_mode_ioctl
Message-ID: <20210915080537.mcndyf6oot4v6hew@pengutronix.de>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-5-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2wqqhlezubhyee7b"
Content-Disposition: inline
In-Reply-To: <20210914091134.17426-5-jslaby@suse.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--2wqqhlezubhyee7b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 14.09.2021 11:11:23, Jiri Slaby wrote:
> The only user of 'file' parameter in tty_mode_ioctl is a BUG_ON check.
> Provided it never crashed for anyone, it's an overkill to pass the
> parameter to tty_mode_ioctl only for this check.
>
> If we wanted to check 'file' there, we should handle it in more graceful
> way anyway. Not by a BUG == crash.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
>  drivers/net/can/slcan.c       | 2 +-

For the slcan.c:
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2wqqhlezubhyee7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmFBqU8ACgkQqclaivrt
76muZgf+MUl8Y9j/6pTFNjbSF5vBrZhE1PXzkvVTwWonq9eouUYLtNgMEIqh0IC7
NWPnQOZf916t2rb6OuQEQlgp/AV1MFmfeLoSK1LfLKDj+075eSu7CIn2MGeeoC/7
wllxFuOXkiJpMe0EXhzHsPj+yBXO3P0ZsZyfEsJ3eBMLu4kc7hu6LzbYCtVj50VS
biN+g7QUOgGBi5TI4+rA/LeRF4uzvAufuukV9vGEKLX5Y7dbyy2p/mtnNiCdNnZt
E/BZIuBTVTd5Unzk8K51oM9DFVSnbC3Q+wQhlKB21epWE03gUH/G4asomwbegWVq
3k9JL+FQW1trObJ2HblArdqZ7ZLcyw==
=kmTG
-----END PGP SIGNATURE-----

--2wqqhlezubhyee7b--
