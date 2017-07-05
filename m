From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH v2 3/6] serial: imx: remove CTSC and CTS handling
Date: Wed, 5 Jul 2017 16:42:37 +0200
Message-ID: <20170705144237.GA8892@archie.localdomain>
References: <20170705130706.10388-1-romain.perier@collabora.com>
 <20170705130706.10388-4-romain.perier@collabora.com>
 <20170705133845.32ov37meqcea3wtz@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170705133845.32ov37meqcea3wtz@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Romain Perier <romain.perier@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hi,

On Wed, Jul 05, 2017 at 03:38:45PM +0200, Uwe Kleine-König wrote:
> Cc += Clemens Gruber + Fabio Estevam
> 
> On Wed, Jul 05, 2017 at 03:07:03PM +0200, Romain Perier wrote:
> > From: Nandor Han <nandor.han@ge.com>
> > 
> > CTSC and CTS are not related to DMA and might add
> > disruption in some cases.
> > 
> > Signed-off-by: Romain Perier <romain.perier@collabora.com>
> 
> If it was Nandor Han who created this patch, it would be great to get
> his sob. If it was you, drop the From: line above.
> 
> > ---
> >  drivers/tty/serial/imx.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 5291b86..dd3ebb4 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1249,11 +1249,6 @@ static void imx_disable_dma(struct imx_port *sport)
> >  	imx_stop_rx_dma(sport);
> >  	imx_stop_tx_dma(sport);
> >  
> > -	/* clear UCR2 */
> > -	temp = readl(sport->port.membase + UCR2);
> > -	temp &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
> > -	writel(temp, sport->port.membase + UCR2);
> > -
> 
> Before this patch imx_disable_dma resulted in the #CTS pin being high
> (inactive).
> 
> Does this qualify as a fix? If so, you should sort this patch to the
> beginning of the series. Did you do test this patch and its effects
> separately?
> 
> @Clemens: maybe this patch makes a relevant difference when the port is
> operated in rs485 mode. Do you care to test?

I just finished testing it. The results are about the same as with v1 of
this patch series:

Applying v2 of patch 1/6, 2/6 and 3/6 (or even 3/6 alone) does not fix
the RS-485 DMA bug. It behaves exactly the same as without these
patches, meaning the whole xmit circ_buf (UART_XMIT_SIZE bytes) is sent
out, as seen in the logic analyzer screenshots from my first bug report:
https://pqgruber.com/rs485_results.png

Applying the whole series does make a (small) difference though:
The first few transmissions after a fresh boot work correctly! However,
after a few transmissions, characters are sent out twice and longer
transmissions are garbled, although not in the same way as before. The
whole circ_buf is no longer sent out.

With all patches from this series applied, I see the following on the
logic analyzer, when calling "echo Test > /dev/ttymxc4":
https://pqgruber.com/rs485txtest.png
(This pattern is not always the same, sometimes it is TeTesstt\n\n,
sometimes TeTesst\nt\n or TeTsestt\n\n and so on)

This behavior is reproducible on i.MX6Q and i.MX6D, not on i.MX6S/etc.,
I therefore assume that it is a SMP-/locking-related problem.

I will try to debug this further, and verify if - with this series
applied - xmit->tail is still jumping over xmit->head. And when exactly
this is happening.

Help is much appreciated!

Best regards,
Clemens
