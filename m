From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/2] serial: mxs-auart: wait for FIFO to flush before
 shutdown
Date: Wed, 16 Oct 2013 12:54:11 -0700
Message-ID: <20131016195411.GA21020@kroah.com>
References: <1380785524-20490-1-git-send-email-hector.palacios@digi.com>
 <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
 <20131003181740.GB10079@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37022 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760584Ab3JPTyM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Oct 2013 15:54:12 -0400
Content-Disposition: inline
In-Reply-To: <20131003181740.GB10079@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Hector Palacios <hector.palacios@digi.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b32955@freescale.com, marex@denx.de, fabio.estevam@freescale.com, shawn.guo@linaro.org, jslaby@suse.cz

On Thu, Oct 03, 2013 at 08:17:40PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> there is only a single concern left and probably only the Freescale g=
uys
> can comment here ...
> On Thu, Oct 03, 2013 at 09:32:04AM +0200, Hector Palacios wrote:
> > The shutdown function was not waiting for the FIFO (which may be th=
e
> > real 16 byte FIFO or the DMA buffer, if DMA is enabled) to flush
> > before disabling the AUART.
> > This lead to many bytes not being transferred (specially at low
> > baudrates), as they were still in the DMA buffer when the AUART was
> > shutdown.
> > This patch also adds the check for the BUSY flag on the tx_empty
> > callback.
> >=20
> > Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> > ---
> >  drivers/tty/serial/mxs-auart.c | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mx=
s-auart.c
> > index 9f046177..30edb91 100644
> > --- a/drivers/tty/serial/mxs-auart.c
> > +++ b/drivers/tty/serial/mxs-auart.c
> > @@ -757,9 +757,26 @@ static int mxs_auart_startup(struct uart_port =
*u)
> >  	return 0;
> >  }
> > =20
> > +static unsigned int mxs_auart_tx_empty(struct uart_port *u)
> > +{
> > +	unsigned long stat;
> > +
> > +	stat =3D readl(u->membase + AUART_STAT);
> > +	if ((stat & (AUART_STAT_BUSY | AUART_STAT_TXFE)) =3D=3D AUART_STA=
T_TXFE)
> > +		return TIOCSER_TEMT;
> Can it happen that both the fifo and the shifter are empty but there =
are
> still some chars pending to be transfered via DMA? If you were checki=
ng
> if dma is still setup you'd be on the safe side.

I'm deleting this from my queue until this gets resolved.  Someone
please resend it when it does.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
