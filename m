Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548C8C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 12 May 2022 06:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350219AbiELGRl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 May 2022 02:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiELGRk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 May 2022 02:17:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A886773065
        for <linux-serial@vger.kernel.org>; Wed, 11 May 2022 23:17:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1np28k-0004Q8-Sm; Thu, 12 May 2022 08:17:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1np28f-001paM-Jn; Thu, 12 May 2022 08:17:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1np28d-009BXr-Ai; Thu, 12 May 2022 08:17:27 +0200
Date:   Thu, 12 May 2022 08:17:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        linux-imx@nxp.com
Subject: Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice
Message-ID: <20220512061724.4guiyqa6vcdru4iw@pengutronix.de>
References: <20220511093247.91788-1-u.kleine-koenig@pengutronix.de>
 <20220512012910.GB37988@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ome74vnpv3pyyryr"
Content-Disposition: inline
In-Reply-To: <20220512012910.GB37988@windriver.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--ome74vnpv3pyyryr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Paul,

first of all thanks for your cooperation on this ancient topic. It's
very appreciated.

And oh, I failed to Cc the NXP people. I added them to Cc:, maybe one of
them can add something valuable to the discussion.

On Wed, May 11, 2022 at 09:29:10PM -0400, Paul Gortmaker wrote:
> [[PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice] On 11/05/202=
2 (Wed 11:32) Uwe Kleine-K=F6nig wrote:
>=20
> > Some Freescale 8250 implementations have the problem that a single long
> > break results in one irq per character frame time. The code in
> > fsl8250_handle_irq() that is supposed to handle that uses the BI bit in
> > lsr_saved_flags to detect such a situation and then skip the second
> > received character. However it also stores other error bits and so after
> > a single frame error the character received in the next irq handling is
> > passed to the upper layer with a frame error, too.
> >=20
> > To weaken this problem restrict saving LSR to only the BI bit.
>=20
> But what is missing is just what "this problem" is - what applications
> are broken and how?  What are the symptoms?  This is a 15+ year old
> platform and so one has to ask why this is just being seen now.

The problem is "However it also stores other error bits and so after a
single frame error the character received in the next irq handling is
passed to the upper layer with a frame error, too." which is just the
sentence before. I hoped this would be understandable :-\

> > Note however that the handling is still broken:
> >=20
> >  - lsr_saved_flags is updated using orig_lsr which is the LSR content
> >    for the first received char, but there might be more in the FIFO, so
> >    a character is thrown away that is received later and not necessarily
> >    the one following the break.
> >  - The doubled break might be the 2nd and 3rd char in the FIFO, so the
> >    workaround doesn't catch these, because serial8250_rx_chars() doesn't
> >    handle the workaround.
> >  - lsr_saved_flags might have set UART_LSR_BI at the entry of
> >    fsl8250_handle_irq() which doesn't originate from
> >    fsl8250_handle_irq()'s "up->lsr_saved_flags |=3D orig_lsr &
> >    UART_LSR_BI;" but from e.g. from serial8250_tx_empty().
> >  - For a long or a short break this isn't about two characters, but more
> >    or only a single one.
>=20
> I've long since flushed the context required to parse the above, sorry.
> But the part where it says "is still broken" stands out to me.

The current state is (assuming the errata is accurate and I understood
it correctly):=20
 - You get a problem for sure if there is a frame error (because the
   next good char is thrown away).
 - You get a problem for sure if there is a parity error (because the
   next good char is thrown away).
 - You get a problem for sure if there was an overflow (because the
   first good char after the overflow is thrown away).
 - The code is racy for break handling. In some unlikely cases the break
   workaround is applied wrongly.

(Where "thrown away" is really: passed to the tty layer with an error
indication, which depending on tty settings results in dropping the
character or passing it on to userspace.)

My patch only fixes the first three issues. A part of the reason for the
uncomplete fix is that I don't have a platform that requires the workaround.
(I thought I had, but it doesn't show the described behaviour and
instead behaves nicely, i.e. one irq per break and no stray bits are
set.)

That the patch I did is correct is quite obvious for me. Currently the
fsl8250_handle_irq() function sets the bits BI, OE, FE and PE in
lsr_saved_flags, but only evaluates BI for the workaround. The commit
that introduced that only talks about BI, the mentioned erratum also
only mentions BI.

I can try to make the commit log more convincing. Or if the ability to
test this code on an affected platform is declared a requirement, I will
drop the topic, just stop using fsl8250_handle_irq() without feeling sad.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ome74vnpv3pyyryr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ8pnEACgkQwfwUeK3K
7AncYAgAhZL2+BMimg3idGfa/sa88v1jYhJSCxoIVPMePDZW8hsyMnxUKk53ROlc
5lLx0hQCP2MPYGoTRW9oI4KeBIMlVofL5CZ55UUrxTq1fPlHB8EgjzBLN37SplZf
jhIz2B6eNdrf1v3Z+rn4cD5jrhSk2zdLqURAItkbKdBUAF5cQMEU/ZSozsMZYFUs
vNLKZ9ZllU9vXpKIrPsbdAk4Ni+7BELE2mG0lEvJr96m4Uv+QWj4uROLhhUKqBaE
KoyySx7frdYi9lk/Wmp53030j78t3KwcdmaxpSBl1KH3LBFqdL5qkJVl5rnZLXmM
0TmO1wMa2vzMpd/XpehNl7YYef1sbw==
=z8p+
-----END PGP SIGNATURE-----

--ome74vnpv3pyyryr--
