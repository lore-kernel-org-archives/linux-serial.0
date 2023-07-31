Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA527C001DF
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jul 2023 08:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjGaISj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jul 2023 04:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGaISY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jul 2023 04:18:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824F02128
        for <linux-serial@vger.kernel.org>; Mon, 31 Jul 2023 01:15:45 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qQO44-00077N-Jg; Mon, 31 Jul 2023 10:15:40 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0B19C1FEAFE;
        Mon, 31 Jul 2023 08:15:40 +0000 (UTC)
Date:   Mon, 31 Jul 2023 10:15:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] tty: minor cleanups
Message-ID: <20230731-dimple-creed-192b053bc4a9-mkl@pengutronix.de>
References: <20230731080244.2698-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tnmz4di7ko5tzk4a"
Content-Disposition: inline
In-Reply-To: <20230731080244.2698-1-jirislaby@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--tnmz4di7ko5tzk4a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.07.2023 10:02:34, Jiri Slaby (SUSE) wrote:
>   can: slcan: remove casts from tty->disc_data

You can do the same for drivers/net/can/can327.c

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tnmz4di7ko5tzk4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTHbacACgkQvlAcSiqK
BOh9Twf+MwcLq1PGx04bVgqylGJcwapLieA97zO08nTQsIzCO13QqybFfUgcoeRA
YyCwyPKH91RLWVYKPASQiNEp9Nl9s19LtFix/UDjLNBWHXLa7wZ8M4LsHTLOt61J
0f5gAYl+/shHT3x8/iJdqijgNlWAilSJxWEyEqMtX9tfz7WEfAXZLilOgGuOdyEk
nIPCVMherA3r6aVRMHdJyjHiMmO/DKBKh1BDED6tKeKKsSTHF/nFeVYkmFGpCDPp
EIIEFNwLS4bXMGvXocw/pnni+u161GXYCbI59HtRxbwgAKCsXk0vprqBidGc8VW5
pATvlfuoLqBex0RF0e0aD+UxqlSBfA==
=l/kL
-----END PGP SIGNATURE-----

--tnmz4di7ko5tzk4a--
