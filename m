From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3] mxs: uart: allow setting RTS from software
Date: Tue, 8 Jan 2013 09:06:35 +0800
Message-ID: <20130108010631.GG29281@S2101-09.ap.freescale.net>
References: <1355405263-29625-1-git-send-email-s.trumtrar@pengutronix.de>
 <50CA8E8C.5060906@freescale.com>
 <50EA98CA.1060303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:52176
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751615Ab3AHBGR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 20:06:17 -0500
Content-Disposition: inline
In-Reply-To: <50EA98CA.1060303@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Huang Shijie <b32955@freescale.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Alan Cox <alan@linux.intel.com>, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Mon, Jan 07, 2013 at 10:43:38AM +0100, Marc Kleine-Budde wrote:
> On 12/14/2012 03:27 AM, Huang Shijie wrote:
> > =E4=BA=8E 2012=E5=B9=B412=E6=9C=8813=E6=97=A5 21:27, Steffen Trumtr=
ar =E5=86=99=E9=81=93:
> >> With the patch "serial: mxs-auart: fix the wrong RTS hardware flow=
 control" the
> >> mainline mxs-uart driver now sets RTSEN only when hardware flow co=
ntrol is
> >> enabled via software. It is not possible any longer to set RTS man=
ually via
> >> software. However, the manual modification is a valid operation.
> >> Regain the possibility to set RTS via software and only set RTSEN =
when hardware
> >> flow control is explicitly enabled via settermios cflag CRTSCTS.
> >>
> >> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >> ---
> >>  drivers/tty/serial/mxs-auart.c |    4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/m=
xs-auart.c
> >> index 6db23b0..9f63f88 100644
> >> --- a/drivers/tty/serial/mxs-auart.c
> >> +++ b/drivers/tty/serial/mxs-auart.c
> >> @@ -412,10 +412,12 @@ static void mxs_auart_set_mctrl(struct uart_=
port *u, unsigned mctrl)
> >> =20
> >>  	u32 ctrl =3D readl(u->membase + AUART_CTRL2);
> >> =20
> >> -	ctrl &=3D ~AUART_CTRL2_RTSEN;
> >> +	ctrl &=3D ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
> >>  	if (mctrl & TIOCM_RTS) {
> >>  		if (tty_port_cts_enabled(&u->state->port))
> >>  			ctrl |=3D AUART_CTRL2_RTSEN;
> >> +		else
> >> +			ctrl |=3D AUART_CTRL2_RTS;
> >>  	}
> >> =20
> >>  	s->ctrl =3D mctrl;
> > Reviewed-by: Huang Shijie <b32955@freescale.com>
>=20
> This patch is not not in today's next. What's the current status? Who
> will take it?
>=20
I see stable@vger.kernel.org is on copy.  But it's not the correct way
submit a fix for stable tree.  Check out Documentation/stable_kernel_ru=
les.txt
for the correct one.

Remember to copy Greg Kroah-Hartman <gregkh@linuxfoundation.org> who
is collecting serial patches believe.

Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
