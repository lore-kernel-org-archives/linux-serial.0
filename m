Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D6FC4167B
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 08:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjKMI6T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 03:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjKMI6E (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 03:58:04 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED86B4C0B
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 00:57:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2Skp-0003x4-Am; Mon, 13 Nov 2023 09:57:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2Skm-008gzA-Uc; Mon, 13 Nov 2023 09:57:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2Skm-000aw6-LI; Mon, 13 Nov 2023 09:57:08 +0100
Date:   Mon, 13 Nov 2023 09:57:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Shiyan <shc_work@mail.ru>
Cc:     kernel@pengutronix.de, Yangtao Li <frank.li@vivo.com>,
        Richard GENOUD <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 02/52] serial: sccnxp: Improve error message if
 regulator_disable() fails
Message-ID: <20231113085708.pwlplxpkvdvtbagh@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-3-u.kleine-koenig@pengutronix.de>
 <1699851843.639333963@f702.i.mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ujx23tlyjshira4q"
Content-Disposition: inline
In-Reply-To: <1699851843.639333963@f702.i.mail.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--ujx23tlyjshira4q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 08:04:03AM +0300, Alexander Shiyan wrote:
>=20
> Hello.
> =A0
> > Returning an error code from .remove() makes the driver core emit the
> > little helpful error message:
> > > remove callback returned a non-zero value. This will be ignored.
> > > and then remove the device anyhow.
> >
> > So replace the error return (and with it the little helpful error
> > message) by a more useful error message.
> ...
> > - if (!IS_ERR(s->regulator))
> > - return regulator_disable(s->regulator);
> > + if (!IS_ERR(s->regulator)) {
> > + int ret =3D regulator_disable(s->regulator);
> > + if (ret)
> > + dev_err(&pdev->dev, "Failed to disable regulator\n");
> > + }
> > =A0
> > =A0 return 0;
> =A0
> return ret ? =A0

No, return 0 is right. Please look at platform_remove() in
drivers/base/platform.c and optionally reread the commit log to convince
yourself about that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ujx23tlyjshira4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVR5OMACgkQj4D7WH0S
/k6BNgf/W5rGUa3px4R1Vnn1dvHL7TlotyAoWRDK5cli3X3ink7aUULrfI7Xmt3M
8ofMQ0FgayxS5x8osbPh+nMpA3L4i0NrV3y76fS1sF1+dy1iY40jRMVy3MZBmMxX
Bl1UGlIyOxBMnvOXLw34BDVNlpO0SGb7WFuwcHHZ1Vj0/KTnqnvoT5jUJAhAbucW
PeOiTHAhNnceSMjTDlmiOMOixKRA6QkotiKHqtxolhru2rkzXDMpoSBKX564KDjc
aqaleibuMERGWBJ8jELYe2XiZv4kLR18fFtZiUiBW+4uHKdyo/r01whp4J00vz3j
DzZ0ajYBvLldrH/JoX3V52upqx1izA==
=1tYs
-----END PGP SIGNATURE-----

--ujx23tlyjshira4q--
