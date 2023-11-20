Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D75AC54FB9
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 07:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjKTHvR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 02:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHvQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 02:51:16 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A2EB9
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 23:51:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r4z3l-0000XT-FS; Mon, 20 Nov 2023 08:51:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r4z3k-00AIfC-Pq; Mon, 20 Nov 2023 08:51:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r4z3k-004A3n-GZ; Mon, 20 Nov 2023 08:51:08 +0100
Date:   Mon, 20 Nov 2023 08:51:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@amd.com>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] serial: xilinx_uartps: Fix kernel doc about .remove()'s
 return code
Message-ID: <20231120075108.jvrabyv7a6izgbgd@pengutronix.de>
References: <20231117101236.878008-1-u.kleine-koenig@pengutronix.de>
 <dfc69d21-1c09-4cff-ac11-21857278f6e0@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="agr2mntupn2nnz73"
Content-Disposition: inline
In-Reply-To: <dfc69d21-1c09-4cff-ac11-21857278f6e0@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--agr2mntupn2nnz73
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jiri,

On Mon, Nov 20, 2023 at 08:27:12AM +0100, Jiri Slaby wrote:
> On 17. 11. 23, 11:12, Uwe Kleine-K=F6nig wrote:
> > Since the driver was converted to use .remove_new() the return function
> > doesn't return a value any more. So remove the obsolete documentation
> > about the return value.
> >=20
> > Reported-by: Michal Simek <michal.simek@amd.com>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > the patch converting to .remove_new is not yet applied, so I didn't
> > reference its commit id. It's available at
> >=20
> > 	https://lore.kernel.org/linux-serial/20231110152927.70601-53-u.kleine-=
koenig@pengutronix.de
> >=20
> > and obviously this patch dropping the comment should get applied after
> > the conversion to void.
>=20
> So perhaps you squash and resend :)?

Sending an follow-up patch was what Greg requested in
https://lore.kernel.org/linux-serial/2023111330-tigress-suffering-e329@greg=
kh/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--agr2mntupn2nnz73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVbD+sACgkQj4D7WH0S
/k4M/Qf/dfAUC9yPH7gGW18tXzxngnAj2z3nfmiXCogkUj6hv4iAQA3Z5vZ1HnuP
Bz2Vk7uBC1BXA6hQgxqvkkk2XYpWB3j5hY83HvmGBSUDqe7AgPxHsg4mCK2OMikb
fLNHm5khlE+xi+8bFanR3Jzu3gvTYPG2MMOY3yeU7A22+ZQAnvfKBTd4Sepo51oL
VN0g/2ZLeXfUUDjQckaoNsOqi9Dnm2RNAQUtki+MNjwWpU0YHykcLLEndpqE6pLs
+XRAncn0I1PBEP9EQ3dONyHd2dcP8enqoDNQEYHa/vIgioNRUCkOE4Jj/9KuLICp
AlUpJYPNyUdu8LC2iQF3yMOecgWI/w==
=fJuk
-----END PGP SIGNATURE-----

--agr2mntupn2nnz73--
