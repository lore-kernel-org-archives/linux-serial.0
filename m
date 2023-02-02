Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DD6C05027
	for <linux-serial@archiver.kernel.org>; Thu,  2 Feb 2023 12:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBBMEl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Feb 2023 07:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBBMEl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 07:04:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A576234F1
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 04:04:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNYKP-0006cj-PY; Thu, 02 Feb 2023 13:04:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNYKN-002A4g-Fu; Thu, 02 Feb 2023 13:04:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNYKO-000GYQ-1G; Thu, 02 Feb 2023 13:04:32 +0100
Date:   Thu, 2 Feb 2023 13:04:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel@pengutronix.de, linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix mismerge regarding serial_lsr_in()
Message-ID: <20230202120428.fo5fswdwki46vnjz@pengutronix.de>
References: <20230202104501.264686-1-u.kleine-koenig@pengutronix.de>
 <f157ed1b-3856-7ac9-f054-265536ba3b3@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tdxfxtm72gz22nqk"
Content-Disposition: inline
In-Reply-To: <f157ed1b-3856-7ac9-f054-265536ba3b3@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--tdxfxtm72gz22nqk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2023 at 01:26:08PM +0200, Ilpo J=E4rvinen wrote:
> On Thu, 2 Feb 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > The relevant history introducing serial_lsr_in() looks as follows:
> >=20
> > 	$ git log --graph --oneline --boundary 9fafe733514b..df36f3e3fbb7 -- d=
rivers/tty/serial/8250/8250_port.c
> > 	*   df36f3e3fbb7 Merge tag 'v5.19-rc3' into tty-next
> > 	|\
> > 	| * be03b0651ffd serial: 8250: Store to lsr_save_flags after lsr read
> > 	* | ...
> > 	* | bdb70c424df1 serial: 8250: Create serial_lsr_in()
> > 	* | ce338e4477cf serial: 8250: Store to lsr_save_flags after lsr read
> > 	* | ...
> > 	|/
> > 	o 9fafe733514b tty: remove CMSPAR ifdefs
> >=20
> > So the patch "serial: 8250: Store to lsr_save_flags after lsr read" was
> > introduced twice and in one branch it was followed up by commit
> > bdb70c424df1 ("serial: 8250: Create serial_lsr_in()") which moved
> > explicit lsr_saved_flags handling into a new function serial_lsr_in().
> > When the two branches were merged in commit df36f3e3fbb7, we got both,
> > serial_lsr_in() and the explicit lsr_saved_flags handling.
> >=20
> > So drop the explicit lsr_saved_flags handling.
> >=20
> > Fixes: df36f3e3fbb7 ("Merge tag 'v5.19-rc3' into tty-next")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 2 --
> >  1 file changed, 2 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 33be7aad11ef..e61753c295d5 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1512,8 +1512,6 @@ static inline void __stop_tx(struct uart_8250_por=
t *p)
> >  		u16 lsr =3D serial_lsr_in(p);
> >  		u64 stop_delay =3D 0;
> > =20
> > -		p->lsr_saved_flags |=3D lsr & LSR_SAVE_FLAGS;
> > -
> >  		if (!(lsr & UART_LSR_THRE))
> >  			return;
> >  		/*
>=20
> I don't know if Fixes tag is appropriate here. This fixes the mismerge=20
> yes, however, the removed line itself seems harmless so there's no real=
=20
> problem to fix.

It might make a difference if LSR_SAVE_FLAGS !=3D p->lsr_save_mask.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tdxfxtm72gz22nqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPbpskACgkQwfwUeK3K
7Ak7bwgAjqb7MuyJ6qZII6BYUEdVBbSVDFxZ0bjWQ1c2R6nQTqhJ+ND74mVftCkK
8HM1quRiFz+vkMfGzP5+ShGyG22jW3pFbTIDJOYTYTNT3BVcJ/n04t8O8PTNLKqK
TjeOUaInyf44HKLdhxljzfIk7n86kqZlF48eB5aLLYFYkeLenfY2i3utTQsI74aO
lucmXjGs2KhzGl+syAvX4psPv5tEEIWTZNDx52VTjSPVudTmAltxQxpvyDBPAaBW
hAOjYik4Ctsq8VbtT7g1q/W8qjl20AGX3FLv/EPbeWuEhCM8r27KIvK/v0Mbh1d2
7yf3hSAH8DVWSfZlGYGI0IYzH+x5EQ==
=4lW9
-----END PGP SIGNATURE-----

--tdxfxtm72gz22nqk--
