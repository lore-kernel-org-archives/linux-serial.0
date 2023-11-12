Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E528BC4167D
	for <linux-serial@archiver.kernel.org>; Sun, 12 Nov 2023 09:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjKLJJl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 12 Nov 2023 04:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLJJk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 12 Nov 2023 04:09:40 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77A030C2
        for <linux-serial@vger.kernel.org>; Sun, 12 Nov 2023 01:09:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r26T3-0001Or-2H; Sun, 12 Nov 2023 10:09:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r26Sx-008S8H-Tl; Sun, 12 Nov 2023 10:09:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r26Sx-000BbE-KI; Sun, 12 Nov 2023 10:09:15 +0100
Date:   Sun, 12 Nov 2023 10:09:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel@pengutronix.de,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 34/52] serial: samsung: Convert to platform remove
 callback returning void
Message-ID: <20231112090915.3hnetkpfknaktfvk@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-35-u.kleine-koenig@pengutronix.de>
 <c09a6894-8408-47a7-a8d1-a46a08fc9d2e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sa6rcnsxkbnfkmq7"
Content-Disposition: inline
In-Reply-To: <c09a6894-8408-47a7-a8d1-a46a08fc9d2e@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--sa6rcnsxkbnfkmq7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 08:48:49AM +0100, Krzysztof Kozlowski wrote:
> On 10/11/2023 16:30, Uwe Kleine-K=F6nig wrote:
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
>=20
> Maybe let's trim the commit msg? Or convert all drivers at once if you
> want to drop long explanation...

I like the verbosity of the commit log. This way you have a chance to
understand its motivation by only looking at that single commit.

IMHO doing one commit per driver is also right: It simplifies review,
allows me to send patches to only the respective maintainers and so
annoy less, the people reviewing the changes can send a tag for the
driver change they look at only.

But I'm not religious about that and if Greg wants to squash the patches
together that's ok for me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sa6rcnsxkbnfkmq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVQljoACgkQj4D7WH0S
/k6TywgAiTEx/nbuhVrTZz6yhSc6Ncgy9jaiRl4HnLSeI5WpStxZtmmB+CujR0xI
kNq5KEGoOYqKhVnysuNbXyiyBwkmhwnXR+lZSGPDdkVP7U3LOv9Yvz5+sGpA3KQv
AZ1t0EHQZtIR4+t5mX5b0cdJhBQPA2f61/R9Dt1AZ5QkiuBk02/HN0s7lnlSaFFU
d1SZfLltuGBYBZ4sVSYaKw6LhsKvrrqUSrRsiZmc43n2e4JKbp4sC3JtZET2nAho
ofgFrEqcg7FFIR4klCydUrz1zlm4e+IpsDr+o+u89DXOlHljSIut4KJEnjH3Chq1
AIKtsA5iJ2/v29Wp3AucBNrPtn/jcA==
=GXBn
-----END PGP SIGNATURE-----

--sa6rcnsxkbnfkmq7--
