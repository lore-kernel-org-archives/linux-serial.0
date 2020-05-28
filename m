Return-Path: <SRS0=aTVb=7K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F4C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 12:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8C4215A4
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 12:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389470AbgE1MG7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 May 2020 08:06:59 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34448 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389551AbgE1MGv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 May 2020 08:06:51 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BA73C1C0351; Thu, 28 May 2020 14:06:49 +0200 (CEST)
Date:   Thu, 28 May 2020 14:06:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Hovold <johan@kernel.org>
Cc:     Denis Ahrens <denis@h3q.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] 16C950 UART enable Hardware Flow Control
Message-ID: <20200528120649.GC22054@duo.ucw.cz>
References: <BACA4F76-3D51-4854-894B-2E69272B5676@h3q.com>
 <20200525082750.GB5276@localhost>
 <B7715399-667F-4DB7-A19D-4CB037ECE64A@h3q.com>
 <20200527075554.GG5276@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <20200527075554.GG5276@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Adding Pavel who disabled EFR at one point to CC. ]
>=20
> On Mon, May 25, 2020 at 07:49:54PM +0200, Denis Ahrens wrote:
> >=20
> >=20
> > > On 25. May 2020, at 10:27, Johan Hovold <johan@kernel.org> wrote:
> > >=20
> > > On Sun, May 24, 2020 at 06:31:44PM +0200, Denis Ahrens wrote:
> > >> From: Denis Ahrens <denis@h3q.com>
> > >>=20
> > >> Enable Automatic RTS/CTS flow control for the 16C950 UART in Enhance=
d Mode
> > >> like described in the Data Sheet Revision 1.2 page 28 and 29.
> > >>=20
> > >> Without this change normal console output works, but everything putt=
ing
> > >> a little more pressure on the UART simply overruns the FIFO.
> > >>=20
> > >> Signed-off-by: Denis Ahrens <denis@h3q.com>
> > >> ---
> > >>=20
> > >> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/seria=
l/8250/8250_port.c
> > >> index f77bf820b7a3..024235946f4d 100644
> > >> --- a/drivers/tty/serial/8250/8250_port.c
> > >> +++ b/drivers/tty/serial/8250/8250_port.c
> > >> @@ -2168,7 +2168,9 @@ int serial8250_do_startup(struct uart_port *po=
rt)
> > >>                serial_port_out(port, UART_LCR, 0);
> > >>                serial_icr_write(up, UART_CSR, 0); /* Reset the UART =
*/
> > >>                serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
> > >> -               serial_port_out(port, UART_EFR, UART_EFR_ECB);
> > >> +               serial_port_out(port, UART_EFR, UART_EFR_ECB |
> > >> +                                               UART_EFR_RTS |
> > >> +                                               UART_EFR_CTS);
> > >>                serial_port_out(port, UART_LCR, 0);
> > >>        }
> > >=20
> > > This doesn't look right as you're now enabling automatic flow control
> > > for everyone.
> > >=20
> > > Try adding this to set_termios() instead when enabling flow control.
> >=20
> > The part in set_termios() is never reached because the UART_CAP_EFR
> > capability was removed ca. 10 years ago. The code fails to preserve
> > the UART_EFR_ECB bit which is in the same register as UART_EFR_CTS.
> > Also for some reason UART_EFR_RTS is not set.
>=20
> The EFR capability was added by commit 7a56aa45982b ("serial: add
> UART_CAP_EFR and UART_CAP_SLEEP flags to 16C950 UARTs definition") and
> then removed half a year later by commit 0694e2aeb81 ("serial: unbreak
> billionton CF card") -- you should mention that in the commit message
> too.

Hmm, that's compact flash card, and long time ago. I probably still
have it somewhere, but I have not used it in a long long time...

Best regards,

									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXs+pWQAKCRAw5/Bqldv6
8ucRAJ9b5jV7BUa3hViRhQzgXWYGbKGXuQCeMPm4QauEIQa0vzmIpfNuRN+Ws/A=
=EYCv
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
