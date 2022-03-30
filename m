Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D68C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 30 Mar 2022 14:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiC3OXP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Mar 2022 10:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243455AbiC3OXO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Mar 2022 10:23:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E7D0A8E
        for <linux-serial@vger.kernel.org>; Wed, 30 Mar 2022 07:21:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZZCQ-00005B-8Z; Wed, 30 Mar 2022 16:21:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZZCL-0040XK-Bm; Wed, 30 Mar 2022 16:21:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZZCN-0002gq-AL; Wed, 30 Mar 2022 16:21:23 +0200
Date:   Wed, 30 Mar 2022 16:21:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas.wunner@intel.com>, kernel@pengutronix.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH v3 1/3] serial: 8250: Handle UART without interrupt on
 TEMT using em485
Message-ID: <20220330142119.ejjlxbsnkp36nwy7@pengutronix.de>
References: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de>
 <20220330104642.229507-2-u.kleine-koenig@pengutronix.de>
 <1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="njkwkwvig4e63prx"
Content-Disposition: inline
In-Reply-To: <1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--njkwkwvig4e63prx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2022 at 02:20:01PM +0300, Ilpo J=E4rvinen wrote:
> On Wed, 30 Mar 2022, Uwe Kleine-K=F6nig wrote:
>=20
> > From: Eric Tremblay <etremblay@distech-controls.com>
> >=20
> > Introduce the UART_CAP_NOTEMT capability. The capability indicates that
> > the UART doesn't have an interrupt available on TEMT.
> >=20
> > In the case where the device does not support it, we calculate the
> > maximum time it could take for the transmitter to empty the
> > shift register. When we get in the situation where we get the
> > THRE interrupt, we check if the TEMT bit is set. If it's not, we start
> > the a timer and recall __stop_tx() after the delay.
> >=20
> > The transmit sequence is a bit modified when the capability is set. The
> > new timer is used between the last interrupt(THRE) and a potential
> > stop_tx timer.
>=20
> As a general note on this patch, I've also made a version of this patch=
=20
> which I intended to send among my dw rs485 v2 patchset once the merge=20
> window is over. I believe my approach is cleaner than this one. It is=20
> based on your suggestion on simply taking advantage of stop_tx_timer.
> In addition, I added frame_time into uart_port which removes the need
> for drivers to calculate the timing per usecase themselves (I believe=20
> frame_time could replace the timeout in uart_port entirely).

ok, if you Cc: me, I'm willing to test on my hardware platform.
=20
> > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > [moved to use added UART_CAP_TEMT]
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > [moved to use added UART_CAP_NOTEMT, improve timeout]
> > Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
> > [rebased to v5.17, making use of tty_get_frame_size]
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/tty/serial/8250/8250.h      |  1 +
> >  drivers/tty/serial/8250/8250_port.c | 76 ++++++++++++++++++++++++++++-
> >  include/linux/serial_8250.h         |  2 +
> >  3 files changed, 77 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8=
250.h
> > index db784ace25d8..39ffeb37786f 100644
> > --- a/drivers/tty/serial/8250/8250.h
> > +++ b/drivers/tty/serial/8250/8250.h
> > @@ -83,6 +83,7 @@ struct serial8250_config {
> >  #define UART_CAP_MINI	BIT(17)	/* Mini UART on BCM283X family lacks:
> >  					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
> >  					 */
> > +#define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT avai=
lable */
> > =20
> >  #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
> >  #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 3b12bfc1ed67..0af13b4c76a0 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -563,8 +563,21 @@ static void serial8250_clear_fifos(struct uart_825=
0_port *p)
> >  	}
> >  }
> > =20
> > +static inline void serial8250_em485_update_temt_delay(struct uart_8250=
_port *p,
> > +			unsigned int cflag, unsigned int baud)
> > +{
> > +	unsigned int bits;
> > +
> > +	if (!p->em485)
> > +		return;
> > +
> > +	bits =3D tty_get_frame_size(cflag);
> > +	p->em485->no_temt_delay =3D DIV_ROUND_UP(bits * NSEC_PER_SEC, baud);
>=20
> This is guaranteed to overflow on some archs?

Hmm, indeed, even overflows for the usual bits=3D10. Strange it still
worked for me in my tests. Maybe the irq latency is big enough to
explain this.

> > +}
> > +
> >  static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hr=
timer *t);
> >  static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrt=
imer *t);
> > +static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrt=
imer *t);
> > =20
> >  void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
> >  {
> > @@ -623,6 +636,16 @@ static int serial8250_em485_init(struct uart_8250_=
port *p)
> >  		     HRTIMER_MODE_REL);
> >  	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
> >  		     HRTIMER_MODE_REL);
> > +
> > +	if (p->capabilities & UART_CAP_NOTEMT) {
> > +		struct tty_struct *tty =3D p->port.state->port.tty;
>=20
> Is this safe (it was commented already by Jiri against one of Eric's=20
> patchsets)?

Oh, didn't see this comment. The problem is that the tty might be gone?

> > +		serial8250_em485_update_temt_delay(p, tty->termios.c_cflag,
> > +						   tty_get_baud_rate(tty));
> > +		hrtimer_init(&p->em485->no_temt_timer, CLOCK_MONOTONIC, HRTIMER_MODE=
_REL);
> > +		p->em485->no_temt_timer.function =3D &serial8250_em485_handle_no_tem=
t;
> > +	}
> > +
> >  	p->em485->stop_tx_timer.function =3D &serial8250_em485_handle_stop_tx;
> >  	p->em485->start_tx_timer.function =3D &serial8250_em485_handle_start_=
tx;
> >  	p->em485->port =3D p;
> > @@ -654,6 +677,7 @@ void serial8250_em485_destroy(struct uart_8250_port=
 *p)
> > =20
> >  	hrtimer_cancel(&p->em485->start_tx_timer);
> >  	hrtimer_cancel(&p->em485->stop_tx_timer);
> > +	hrtimer_cancel(&p->em485->no_temt_timer);
> > =20
> >  	kfree(p->em485);
> >  	p->em485 =3D NULL;
> > @@ -1496,6 +1520,11 @@ static void start_hrtimer_ms(struct hrtimer *hrt=
, unsigned long msec)
> >  	hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
> >  }
> > =20
> > +static void start_hrtimer_ns(struct hrtimer *hrt, unsigned long nsec)
> > +{
> > +	hrtimer_start(hrt, ns_to_ktime(nsec), HRTIMER_MODE_REL);
> > +}
> > +
> >  static void __stop_tx_rs485(struct uart_8250_port *p)
> >  {
> >  	struct uart_8250_em485 *em485 =3D p->em485;
> > @@ -1527,14 +1556,33 @@ static inline void __stop_tx(struct uart_8250_p=
ort *p)
> > =20
> >  	if (em485) {
> >  		unsigned char lsr =3D serial_in(p, UART_LSR);
> > +
> > +		p->lsr_saved_flags |=3D lsr & LSR_SAVE_FLAGS;
>=20
> This change doesn't belong to this patch. It's an independent fix?

Yes, that leaked into this patch, IIRC there are a few more code
locations that should update lsr_saved_flags.

> ...I'm not entirely sure it's fixing something though. After all, we're
> talking about half-duplex here so it should not have those rx related=20
> flags that need to be saved?

There is SER_RS485_RX_DURING_TX ...

> It doesn't hurt though even if possibly not=20
> strictly mandatory so I'm not strictly against it.

> > +
> >  		/*
> > -		 * To provide required timeing and allow FIFO transfer,
> > +		 * To provide required timing and allow FIFO transfer,
>=20
> This too is independent change that should be in its own patch.

*shrug*, it seems maintainers have different mileage regarding fixing
typos en passant in patches or making separate patches for them.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--njkwkwvig4e63prx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJEZ1wACgkQwfwUeK3K
7AlCSggAgcCJ0Vv35pB3WwPyvj6NE/5p8wz6At2YSD4dbHbDrjBcGnFtrFJ5Jaeg
w1nA6bLRfFmPHgU91a7yHO3hIyGRhCvv5Ck4ZarkIqG1nj7ozR8n1UmQO9gmps1X
eiDD1fvlD4S9SH5puxoqDJfo0GMNiCWzMVmqD80IxKobZlI9M+k5kaTRVXsQXMFP
jPHYhFnqjA3bJhvYclUprDoTDnvyWpy5dJ9mQ5b4SZ8SRewT9XRWJ+ht1j4z3CoK
XnWt2WaVb4DhhrUJcak1e2KhHA6lHZ+S2IqPiI6wROlBibpY1IStqw+aHP1JsL3/
IiBGsL9umFWYi3G+CJk62cLBlylu5Q==
=wkIC
-----END PGP SIGNATURE-----

--njkwkwvig4e63prx--
