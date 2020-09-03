Return-Path: <SRS0=JhiI=CM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28A9C433E2
	for <linux-serial@archiver.kernel.org>; Thu,  3 Sep 2020 07:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D240206EB
	for <linux-serial@archiver.kernel.org>; Thu,  3 Sep 2020 07:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgICHfz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgICHfy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Sep 2020 03:35:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D1C061244
        for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2020 00:35:54 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDjmb-000426-E5; Thu, 03 Sep 2020 09:35:45 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDjmY-0000rM-0W; Thu, 03 Sep 2020 09:35:42 +0200
Date:   Thu, 3 Sep 2020 09:35:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ye Bin <yebin10@huawei.com>
Cc:     chris.ruehl@gtsys.com.hk, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: imx: Delete duplicated argument to '|' in
 imx_uart_probe
Message-ID: <20200903073541.g57uoipyolsixfjn@pengutronix.de>
References: <20200903062401.692442-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nnrdg6goa47dnlzw"
Content-Disposition: inline
In-Reply-To: <20200903062401.692442-1-yebin10@huawei.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--nnrdg6goa47dnlzw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 03, 2020 at 02:24:01PM +0800, Ye Bin wrote:
> When calculate "ucr1" UCR1_TRDYEN is duplicate.
>=20
> Fixes: c514a6f848b5b ("serial: imx: use Tx ready rather than Tx empty irq=
")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Not sure I'd use Fixes: to reference the commit that introduced this
duplication, as this fix is not critical at all.

Other than that:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nnrdg6goa47dnlzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9QnMoACgkQwfwUeK3K
7Am2wwgAifd8zzXw+F9NuODuDO+UUHNYPexV+RTSoB773dMoNRctkRog2CXPqler
8LqpWHDC/qyShoLXgFlRXZX58+PJhaycf5R58llwN2m6JDtTwGGqP65XHBSdBzM9
wq/+JL37lsZ7ESwqbuxAP04D69sEEe8S1Pwgp0tR8yefSRuI7qDvLWRnRWnxML3l
ATVtke4CAfwm7xTkIADvnb+otxxjR78AAEc5YtauTNjKh7UopKr65MvzaMs5NTxm
PMp8+PsK3i+80CPCxSb8HxyAQgjldZVPnoiFI2tpBgDffFc0UbNNHbLOJUTOOvdw
bByqc2o3SguW9gAYTsBZMEG4EylTLw==
=JrB6
-----END PGP SIGNATURE-----

--nnrdg6goa47dnlzw--
