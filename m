Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E297C00A5A
	for <linux-serial@archiver.kernel.org>; Tue, 17 Jan 2023 23:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjAQX16 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjAQX1J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Jan 2023 18:27:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051F9577F8
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 13:27:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtU6-0002Bg-7f; Tue, 17 Jan 2023 22:27:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtU4-006ldc-4i; Tue, 17 Jan 2023 22:27:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtU3-00DhPw-6n; Tue, 17 Jan 2023 22:27:07 +0100
Date:   Tue, 17 Jan 2023 22:27:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading
 loop
Message-ID: <20230117212702.vvwe3rqjedivqbhn@pengutronix.de>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
 <20230113184334.287130-8-sorganov@gmail.com>
 <20230117113205.l5byaz3srzpagzhz@pengutronix.de>
 <87bkmx47o4.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gn5itvqwewrq6p2y"
Content-Disposition: inline
In-Reply-To: <87bkmx47o4.fsf@osv.gnss.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--gn5itvqwewrq6p2y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sergey,

On Tue, Jan 17, 2023 at 04:22:51PM +0300, Sergey Organov wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
> > On Fri, Jan 13, 2023 at 09:43:33PM +0300, Sergey Organov wrote:
> >> Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we k=
now
> >> we read registers that must not be cached.
> >>=20
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> ---
> >>  drivers/tty/serial/imx.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >> index be00362b8b67..f4236e8995fa 100644
> >> --- a/drivers/tty/serial/imx.c
> >> +++ b/drivers/tty/serial/imx.c
> >> @@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, voi=
d *dev_id)
> >>  	struct imx_port *sport =3D dev_id;
> >>  	unsigned int rx, flg;
> >>  	struct tty_port *port =3D &sport->port.state->port;
> >> +	typeof(sport->port.membase) membase =3D sport->port.membase;
> >>  	u32 usr2;
> >> =20
> >>  	/* If we received something, check for 0xff flood */
> >> -	usr2 =3D imx_uart_readl(sport, USR2);
> >> +	usr2 =3D readl(membase + USR2);
> >>  	if (usr2 & USR2_RDR)
> >>  		imx_uart_check_flood(sport, usr2);
> >> =20
> >> -	while ((rx =3D imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
> >> +	while ((rx =3D readl(membase + URXD0)) & URXD_CHARRDY) {
> >>  		flg =3D TTY_NORMAL;
> >>  		sport->port.icount.rx++;
> >
> > One of the motivations to introduce imx_uart_readl was to have a single
> > place to add a debug output to be able to inspect what the driver is
> > doing.
> >
> > I wonder where your need for higher speed comes from and if the compiler
> > really generates more effective code with your change.
>=20
> Mostly it's because I'm obviously slowing things down a bit with the
> patch to fight the flood, so I feel obliged to get things back on par
> with the origin. Then, higher speed, let alone the time spent with
> interrupts disabled and/or spinlocks taken, is always one of generic
> goals for me.
>=20
> As for the generated code, with this patch I don't aim to affect code
> generation, I rather avoid execution of part of existing code while
> being on the most critical path. It should be quite obvious that not
> executing some code is at least not slower than executing it.

That's true, but I think it doesn't apply here.

I would expect that the compiler "sees" for the call

	imx_uart_readl(sport, USR2)

that the 2nd argument is constant and that for that value of offset the
call is equivalent to readl(sport->port.membase + offset);

So I doubt you're making anything quicker here.

I tried the following patch on mainline (that is without the preceding
patches in this series):

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 757825edb0cd..cfc2f7057345 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -807,7 +807,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_=
id)
 	unsigned int rx, flg, ignored =3D 0;
 	struct tty_port *port =3D &sport->port.state->port;
=20
-	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
+	while (readl(sport->port.membase + USR2) & USR2_RDR) {
 		u32 usr2;
=20
 		flg =3D TTY_NORMAL;

and the resulting code didn't change at all. For a bigger change (i.e.
adding a variable for sport->port.membase and replacing two
imx_uart_readl) the code changed quite a bit (it got 28 bytes bigger for
imx_v6_v7_defconfig) and in the short time I tried I couldn't judge if
the resulting code is better or not.

So a change that explicitly doesn't execute the code that the compiler
optimizes away anyhow isn't a win. Together with the fact that your
patch makes register access use different idioms and so makes it harder
to understand for a human I'd say the net benefit of your patch is negative.

> > Please either drop the patch from your series or provide the differences
> > the compiler produces and a benchmark.
>=20
> If your only objection against this patch is the desire to keep a single
> place to add debug output, I'll be happy to tune the resulting code to
> still have one.

I don't see the need to optimize it.

> That said, before we make a decision, could you please tell why register
> shadows that the imx_uart_readl/writel are dealing with are needed in
> the first place? It looks like all the registers that are shadowed are
> readable as well. What's going on here, and if it happens to be a
> speed-up, do we have any benchmarks?

Not sure I did benchmarks back then, probably not. The main motivation
was really to have that single access function. So I admit being guilty
to have implemented an optimization without hard numbers just assuming
that access to (cached) RAM is quicker than the register space.

Best regards,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gn5itvqwewrq6p2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPHEqIACgkQwfwUeK3K
7Am1JggAkHU4M4ym5VpJ1x3BS+Yor31Tcmc2+tOyH9KhsbDWfpsHVvnCv6SlFsOn
baRo7S7fvFYmKduujGC6tMtK7uEMl4o+diLMpBdImBa/ii6wwsTpFr+PJvfRiR9i
EXQq+I1H61IsAX4tFYG1apWn1/F++SIZE+nvrOKZckg4QUG7MAoHS9pZKBGe19Tc
wMnLzmamckrGStu6ISZ4IhTUcYKBmHWeanH4t3SrKgtPqJMOm5hml9YylanEaSqU
BYqiazpF6KpOzNqCQa2GUl44MXRew4eRaeQ+/m3ad9YQWocxIltFBiyf8vs81auC
qBKfg2FASSyVuoLd1TQX6h5hHiNchA==
=xR5L
-----END PGP SIGNATURE-----

--gn5itvqwewrq6p2y--
