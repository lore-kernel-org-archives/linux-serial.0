Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE98DC61DA4
	for <linux-serial@archiver.kernel.org>; Thu,  2 Feb 2023 13:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjBBNlW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBBNlR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 08:41:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB708B7D3
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 05:41:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNZpl-0004iH-Vh; Thu, 02 Feb 2023 14:41:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNZpj-002BXc-KB; Thu, 02 Feb 2023 14:41:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNZpk-000Hi5-3f; Thu, 02 Feb 2023 14:41:00 +0100
Date:   Thu, 2 Feb 2023 14:40:57 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] serial: 8250: Fix mismerge regarding serial_lsr_in()
Message-ID: <20230202134057.v6mjwvbrxdvfackb@pengutronix.de>
References: <20230202104501.264686-1-u.kleine-koenig@pengutronix.de>
 <f157ed1b-3856-7ac9-f054-265536ba3b3@linux.intel.com>
 <20230202120428.fo5fswdwki46vnjz@pengutronix.de>
 <af49e8f-6c1b-39fa-923e-f0a99edab17c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpcmb53nu7twtc5m"
Content-Disposition: inline
In-Reply-To: <af49e8f-6c1b-39fa-923e-f0a99edab17c@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--cpcmb53nu7twtc5m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ilpo,

On Thu, Feb 02, 2023 at 02:09:38PM +0200, Ilpo J=E4rvinen wrote:
> On Thu, 2 Feb 2023, Uwe Kleine-K=F6nig wrote:
> > On Thu, Feb 02, 2023 at 01:26:08PM +0200, Ilpo J=E4rvinen wrote:
> > > I don't know if Fixes tag is appropriate here. This fixes the mismerg=
e=20
> > > yes, however, the removed line itself seems harmless so there's no re=
al=20
> > > problem to fix.
> >=20
> > It might make a difference if LSR_SAVE_FLAGS !=3D p->lsr_save_mask.
>=20
> But currently lsr_save_mask always has at least LSR_SAVE_FLAGS bits so=20
> that OR is no-op.

Oh indeed. So it's even more harmless than I thought. Thanks.

@gregkh: I don't feel strong about the Fixes line, drop it if you prefer
to not have it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cpcmb53nu7twtc5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPbvWYACgkQwfwUeK3K
7Amzzgf+JWB14gTjRvIfE6ena+G9FIAKLwk29SHxap5BJ124KxwLjNwz5OdgVKds
TyyjyUek5WdPrcFNU82ITEpZTH5j/6O1my9oHyikr8R9faAAon5LKZjs0sPvMN+o
utUOhbRaom0g3BbwpSYj5Ykrny6ZRKn7RSpT8a8VeMGh22UxGJVHxeT86AsNHOwa
Bvu+W0nSXxlTG7j0XvYFyf+2Fe4lXyntzRBZhN2N5FW8O99bA1cgoWPCI7a7s6vP
eoiRSwINyLWLSGLpkqXK84ZGxg/xlLgD2Jt9X3k9bEjpUjVb2iXEjcXJklWgiJUQ
QFJZ0letL2NZ9+jMZI3cYPqgPjrLlg==
=sTY7
-----END PGP SIGNATURE-----

--cpcmb53nu7twtc5m--
