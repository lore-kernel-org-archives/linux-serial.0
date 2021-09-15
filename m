Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A87C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 08:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EA961157
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 08:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhIOIGp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbhIOIGn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Sep 2021 04:06:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F6C061574
        for <linux-serial@vger.kernel.org>; Wed, 15 Sep 2021 01:05:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mQPun-0002mv-1O; Wed, 15 Sep 2021 10:05:09 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:8a97:9358:ae:5dc8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6389867E518;
        Wed, 15 Sep 2021 08:05:06 +0000 (UTC)
Date:   Wed, 15 Sep 2021 10:05:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 04/16] tty: make tty_ldisc_ops::hangup return void
Message-ID: <20210915080505.rq2gj4e3ltfzinbm@pengutronix.de>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iopoaeuqhybpk76v"
Content-Disposition: inline
In-Reply-To: <20210914091134.17426-4-jslaby@suse.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--iopoaeuqhybpk76v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.09.2021 11:11:22, Jiri Slaby wrote:
> The documentation says that the return value of tty_ldisc_ops::hangup
> hook is ignored. And it really is, so there is no point for its return
> type to be int. Switch it to void and all the hooks too.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> ---
>  Documentation/driver-api/serial/tty.rst | 2 +-
>  drivers/input/serio/serport.c           | 3 +--
>  drivers/net/can/slcan.c                 | 3 +--

For the slcan.c:
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--iopoaeuqhybpk76v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmFBqS4ACgkQqclaivrt
76khdgf/X14fNFG2Wsnq+ToDU18WpqftWFAPePHwvLjLnzpK8zeLdyW8zCQWTWPH
q+B9F6gKwLMUefIXBFwlqTANCa/YNUdfA0EgTBU4M2m5J4VTMNso+ysHCdj07b3T
4v3dMBevFhWlyRgmUczwGMjCG1TGghaIvhOqv2VQiJBrD51sXIoGcAIToMiUCZaX
xx1Uxh5UBQb59OtRTmJPiMieQToImQrUUYDRMUMJP4ObGWUOS1Bjo5xlMxLl8yot
CC1nGYy5R2BwKSJ56LFHuYQn8HWRYBjV09oxqB5k9MF3B4g6xYSJjItQ5N76zeXy
5s5+s9JQpy/y3/C+14KLSoEV2Mg6jA==
=ADnc
-----END PGP SIGNATURE-----

--iopoaeuqhybpk76v--
