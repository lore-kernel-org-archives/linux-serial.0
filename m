Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DF6C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 10:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjKMKDy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 05:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjKMKDx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 05:03:53 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E637135
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 02:03:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2TnE-00038W-PR; Mon, 13 Nov 2023 11:03:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2TnC-008hg3-MI; Mon, 13 Nov 2023 11:03:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2TnC-000eUa-Cz; Mon, 13 Nov 2023 11:03:42 +0100
Date:   Mon, 13 Nov 2023 11:03:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michal Simek <michal.simek@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
        linux-serial@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Julien Malik <julien.malik@unseenlabs.fr>,
        kernel@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 52/52] serial: xilinx_uartps: Convert to platform remove
 callback returning void
Message-ID: <20231113100342.sih3te7a7z5jeh4j@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-53-u.kleine-koenig@pengutronix.de>
 <15784357-6557-4431-a1dd-128152b48160@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kn3vxinwjwf66456"
Content-Disposition: inline
In-Reply-To: <15784357-6557-4431-a1dd-128152b48160@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--kn3vxinwjwf66456
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 10:41:17AM +0100, Michal Simek wrote:
>=20
>=20
> On 11/10/23 16:30, Uwe Kleine-K=F6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> >=20
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >   drivers/tty/serial/xilinx_uartps.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xi=
linx_uartps.c
> > index 66a45a634158..6decf2b13340 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -1666,7 +1666,7 @@ static int cdns_uart_probe(struct platform_device=
 *pdev)
> >    *
> >    * Return: 0 on success, negative errno otherwise
>=20
> this line should be also removed.

Good catch.

@gregkh: What is the preferred way to address that? I can follow up with
a patch on top of this one (and you squash it or not), I can send a
patch that gets that does the conversion and drops the comment (and you
skip this incomplete patch when applying this series) or I can resend
the whole series in a week or so.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kn3vxinwjwf66456
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVR9H0ACgkQj4D7WH0S
/k6V2AgAo6okl3s/uMvGH490XYGbx23UNsTIK8QHDdKEJuDpHIgAEfm4hZTaIK5c
AODy+0vA5dxnaphBc95zvC4axDBBnEPAh1AemXqM7U6y6bMM0BUsoK6cmFTfFuVG
M4LwLKuTYxBd4xb3HHBDnFYSNvchtvtTM0GXZwGpuMGAkqMosBDz1L3Wjk/tkh97
IgI+HIc7ubIT++zVpZ4v9wT//d9YFfornxX244Idfqw06X6AssuHcK5WCPOOGVxo
rNwm6ooGU9PknTE0jVLtrz9eewvH2bUTOOxVUW5iggKFlqLnFqOTXIZ5YJ08C4df
8I3JAJa0h44/AEgdJ/FOuKPRPMB6sw==
=6ACu
-----END PGP SIGNATURE-----

--kn3vxinwjwf66456--
