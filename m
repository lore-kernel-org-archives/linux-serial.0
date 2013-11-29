From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/3] serial: mxs-auart: implement flush_buffer hook
Date: Fri, 29 Nov 2013 19:02:49 +0100
Message-ID: <1385748169.4244.1.camel@weser.hi.pengutronix.de>
References: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
	 <201311291750.22215.marex@denx.de> <5298D3B6.5050700@digi.com>
	 <201311291902.34445.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35770 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab3K2SHf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Nov 2013 13:07:35 -0500
In-Reply-To: <201311291902.34445.marex@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Hector Palacios <hector.palacios@digi.com>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "b32955@freescale.com" <b32955@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Am Freitag, den 29.11.2013, 19:02 +0100 schrieb Marek Vasut:
> Dear Hector Palacios,
> 
> > Hi Marek,
> > 
> > On 11/29/2013 05:50 PM, Marek Vasut wrote:
> > > Hello Hector,
> > > 
> > >> Terminate any DMA transfer and verify the TX FIFO is empty.
> > >> 
> > >> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> > >> ---
> > >> 
> > >>   drivers/tty/serial/mxs-auart.c | 23 +++++++++++++++++++++++
> > >>   1 file changed, 23 insertions(+)
> > >> 
> > >> diff --git a/drivers/tty/serial/mxs-auart.c
> > >> b/drivers/tty/serial/mxs-auart.c index 9f0461778fc1..d9bf6e103f65 100644
> > >> --- a/drivers/tty/serial/mxs-auart.c
> > >> +++ b/drivers/tty/serial/mxs-auart.c
> > >> @@ -782,6 +782,28 @@ static unsigned int mxs_auart_tx_empty(struct
> > >> uart_port *u) return 0;
> > >> 
> > >>   }
> > >> 
> > >> +/*
> > >> + * Flush the transmit buffer.
> > >> + * Locking: called with port lock held and IRQs disabled.
> > >> + */
> > >> +static void mxs_auart_flush_buffer(struct uart_port *u)
> > >> +{
> > >> +	struct mxs_auart_port *s = to_auart_port(u);
> > >> +	struct dma_chan *channel = s->tx_dma_chan;
> > >> +	unsigned int to;
> > >> +
> > >> +	if (auart_dma_enabled(s)) {
> > >> +		/* Avoid deadlock with the DMA engine callback */
> > >> +		spin_unlock(&s->port.lock);
> > >> +		dmaengine_terminate_all(channel);
> > >> +		spin_lock(&s->port.lock);
> > > 
> > > Can you not maybe just set some flag here to tell the DMA engine callback
> > > things are shutting down and to don't do anything funny anymore ?
> > 
> > I copied these spin_lock protections from the amba-pl011.c driver.
> > The callbacks in the mxs-auart driver are not taking the lock but I was not
> > sure if any of the serial core functions they call are, so I thought it
> > was a good idea to take it.
> 
> It might be worth investigating this then.
> 
> > >> +	}
> > >> +	/* Wait for the FIFO to flush */
> > >> +	to = u->timeout;
> > >> +	while (!mxs_auart_tx_empty(u) && to--)
> > >> +		mdelay(1);
> > > 
> > > Maybe you can put some cond_resched() into the loop to avoid wasting too
> > > many cycles ?
> > 
> > Do you mean like this? Ok
> > 
> > 	while (!mxs_auart_tx_empty(u) && to--) {
> > 		cond_resched();
> > 		mdelay(1);
> > 	}
> 
> Yes, like that.
> 
This path isn't timing critical. mdelay still keeps the cpu spinning,
even with a resched. Just use an absolute timeout and sleep instead of
delay.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

