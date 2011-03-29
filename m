From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Wrong GIT author ? also bugs: serial: Add uart driver for
 i.MX23/28
Date: Tue, 29 Mar 2011 11:14:56 +0200
Message-ID: <20110329091456.GI30938@pengutronix.de>
References: <201103180302.p2I326tA020159@hera.kernel.org>
 <20110318112920.07148450@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110318112920.07148450@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-serial@vger.kernel.org, torvalds@linux-foundation.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hello,

On Fri, Mar 18, 2011 at 11:29:20AM +0000, Alan Cox wrote:
> >     serial: Add auart driver for i.MX23/28
> >    =20
> >     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> You have a few things that need fixing, one of which is quite nasty
I'm going to address these as Sascha is currently busy doing other
stuff.

> > + * Freescale STMP37XX/STMP378X Application UART driver
> > + *
> > + * Author: dmitry pervushin <dimka@embeddedalley.com>
>=20
> So its signed off by one person and without a signature from the auth=
or ?
> Is that intentional
The base for the driver was taken from a vendor BSP and polished to be
(nearly :-) ready for mainline. I don't know if Sascha tried to contact
Dimtry (I guess not) but keeping the original author listed is IMHO OK
as is using GIT_AUTHOR=3DSascha when the polishing was non-trivial.

So maybe make this read:

	Based on a driver by dmitry pervushin <dimka@embeddedalley.com>
	and modified for mainline by Sascha Hauer <...>

?
> > +static void mxs_auart_rx_chars(struct mxs_auart_port *s)
> > +{
> > +	struct tty_struct *tty =3D s->port.state->port.tty;
> > +	u32 stat =3D 0;
>=20
> tty may be NULL at this point, in which case your code will try and p=
ush
> bits through a NULL pointer and crash
>=20
> A user can seek to make tty NULL at the right moment by judicious use=
 of
> vhangup, and a remote device can use carrier signals and bit timing t=
o
> mount an attack. See tty_port_tty_get() and/or hold the port lock ove=
r
> the IRQ as other drivers do. For the uart stuff I'd hold the port loc=
k as
> the rest of the code in the uart layer sort of assumes that
OK

> > +static void mxs_auart_settermios(struct uart_port *u,
> > +				 struct ktermios *termios,
> > +				 struct ktermios *old)
>=20
> Minor things here
> - You need to set the termios bits to reflect the mode you actually s=
et.
>   So as you don't seem to support mark/space you need to clear the bi=
t,
>   ditto h/w flow control if not supported
>=20
> - You also need to report back the actual baud rate
I don't understand how to do this and didn't find something like that i=
n
other drivers. (I checked amba-pl011.c and imx.c.) Also
Documentation/serial/driver doesn't describe this. (It is also silent
about CMSPAR and doesn't even advise to clear unsupported bits.)
Can you be a bit more verbose here?
=20
> > +static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
> > +{
> > +	u32 istatus, istat;
> > +	struct mxs_auart_port *s =3D context;
> > +	u32 stat =3D readl(s->port.membase + AUART_STAT);
>=20
> Your IRQ handler either needs to take the port lock or have the
> underlying methods do that or their own full locking, you aren't doin=
g
> that.
OK, below you can find my current wip patch (yet untested on real hardw=
are).
(If/when this looks OK for you and the above issue is addressed I will
create a proper patch.)

Best regards
Uwe
=20
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-au=
art.c
index 7e02c9c..3b4c96a 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1,17 +1,14 @@
 /*
  * Freescale STMP37XX/STMP378X Application UART driver
  *
- * Author: dmitry pervushin <dimka@embeddedalley.com>
+ * Based on a driver by dmitry pervushin <dimka@embeddedalley.com>
+ * and modified for mainline by Sascha Hauer <s.hauer@pengutronix.de>
  *
  * Copyright 2008-2010 Freescale Semiconductor, Inc.
  * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
  *
  * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
+ * License; version 2 or later.
  */
=20
 #include <linux/kernel.h>
@@ -286,6 +283,9 @@ static void mxs_auart_settermios(struct uart_port *=
u,
 {
 	u32 bm, ctrl, ctrl2, div;
 	unsigned int cflag, baud;
+	unsigned long flags;
+
+	spin_lock_irqsave(&u->lock, flags);
=20
 	cflag =3D termios->c_cflag;
=20
@@ -303,11 +303,9 @@ static void mxs_auart_settermios(struct uart_port =
*u,
 	case CS7:
 		bm =3D 2;
 		break;
-	case CS8:
+	default: /* CS8 */
 		bm =3D 3;
 		break;
-	default:
-		return;
 	}
=20
 	ctrl |=3D AUART_LINECTRL_WLEN(bm);
@@ -368,13 +366,23 @@ static void mxs_auart_settermios(struct uart_port=
 *u,
=20
 	writel(ctrl, u->membase + AUART_LINECTRL);
 	writel(ctrl2, u->membase + AUART_CTRL2);
+
+	/* clear unsupported flags */
+	termios->c_cflag &=3D ~CMSPAR;
+
+	spin_unlock_irqrestore(&u->lock, flags);
 }
=20
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
 	u32 istatus, istat;
 	struct mxs_auart_port *s =3D context;
-	u32 stat =3D readl(s->port.membase + AUART_STAT);
+	unsigned long flags;
+	u32 stat;
+      =20
+	spin_lock_irqsave(&s->port.lock, flags);
+
+	stat =3D readl(s->port.membase + AUART_STAT);
=20
 	istatus =3D istat =3D readl(s->port.membase + AUART_INTR);
=20
@@ -401,6 +409,8 @@ static irqreturn_t mxs_auart_irq_handle(int irq, vo=
id *context)
 		| AUART_INTR_CTSMIS),
 			s->port.membase + AUART_INTR_CLR);
=20
+	spin_unlock_irqrestore(&s->port.lock, flags);
+
 	return IRQ_HANDLED;
 }
=20
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
