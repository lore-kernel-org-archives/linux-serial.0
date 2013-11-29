From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/3] serial: mxs-auart: implement flush_buffer hook
Date: Fri, 29 Nov 2013 19:02:34 +0100
Message-ID: <201311291902.34445.marex@denx.de>
References: <1385742927-11358-1-git-send-email-hector.palacios@digi.com> <201311291750.22215.marex@denx.de> <5298D3B6.5050700@digi.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:38293 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab3K2SCe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Nov 2013 13:02:34 -0500
In-Reply-To: <5298D3B6.5050700@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "b32955@freescale.com" <b32955@freescale.com>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>

Dear Hector Palacios,

> Hi Marek,
> 
> On 11/29/2013 05:50 PM, Marek Vasut wrote:
> > Hello Hector,
> > 
> >> Terminate any DMA transfer and verify the TX FIFO is empty.
> >> 
> >> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> >> ---
> >> 
> >>   drivers/tty/serial/mxs-auart.c | 23 +++++++++++++++++++++++
> >>   1 file changed, 23 insertions(+)
> >> 
> >> diff --git a/drivers/tty/serial/mxs-auart.c
> >> b/drivers/tty/serial/mxs-auart.c index 9f0461778fc1..d9bf6e103f65 100644
> >> --- a/drivers/tty/serial/mxs-auart.c
> >> +++ b/drivers/tty/serial/mxs-auart.c
> >> @@ -782,6 +782,28 @@ static unsigned int mxs_auart_tx_empty(struct
> >> uart_port *u) return 0;
> >> 
> >>   }
> >> 
> >> +/*
> >> + * Flush the transmit buffer.
> >> + * Locking: called with port lock held and IRQs disabled.
> >> + */
> >> +static void mxs_auart_flush_buffer(struct uart_port *u)
> >> +{
> >> +	struct mxs_auart_port *s = to_auart_port(u);
> >> +	struct dma_chan *channel = s->tx_dma_chan;
> >> +	unsigned int to;
> >> +
> >> +	if (auart_dma_enabled(s)) {
> >> +		/* Avoid deadlock with the DMA engine callback */
> >> +		spin_unlock(&s->port.lock);
> >> +		dmaengine_terminate_all(channel);
> >> +		spin_lock(&s->port.lock);
> > 
> > Can you not maybe just set some flag here to tell the DMA engine callback
> > things are shutting down and to don't do anything funny anymore ?
> 
> I copied these spin_lock protections from the amba-pl011.c driver.
> The callbacks in the mxs-auart driver are not taking the lock but I was not
> sure if any of the serial core functions they call are, so I thought it
> was a good idea to take it.

It might be worth investigating this then.

> >> +	}
> >> +	/* Wait for the FIFO to flush */
> >> +	to = u->timeout;
> >> +	while (!mxs_auart_tx_empty(u) && to--)
> >> +		mdelay(1);
> > 
> > Maybe you can put some cond_resched() into the loop to avoid wasting too
> > many cycles ?
> 
> Do you mean like this? Ok
> 
> 	while (!mxs_auart_tx_empty(u) && to--) {
> 		cond_resched();
> 		mdelay(1);
> 	}

Yes, like that.

Best regards,
Marek Vasut
