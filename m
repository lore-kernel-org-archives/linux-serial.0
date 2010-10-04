From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/3] sc16is7x2: use threaded irqs
Date: Mon, 4 Oct 2010 15:18:35 -0700
Message-ID: <20101004151835.0440d201.akpm@linux-foundation.org>
References: <201010012118.o91LI4OP021284@imap1.linux-foundation.org>
	<20101001233753.GB5733@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36257 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751687Ab0JDWTP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Oct 2010 18:19:15 -0400
In-Reply-To: <20101001233753.GB5733@rere.qmqm.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq@rere.qmqm.pl>
Cc: manuel.stahl@iis.fraunhofer.de, greg@kroah.com, linux-serial@vger.kernel.org

On Sat, 2 Oct 2010 01:37:53 +0200
Micha__ Miros__aw <mirq@rere.qmqm.pl> wrote:

> On Fri, Oct 01, 2010 at 02:18:04PM -0700, akpm@linux-foundation.org wrote:
> > From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> > 
> > Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> > Cc: Greg KH <greg@kroah.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  drivers/serial/sc16is7x2.c |  115 ++++++++++++-----------------------
> >  1 file changed, 40 insertions(+), 75 deletions(-)
> > 
> > diff -puN drivers/serial/sc16is7x2.c~sc16is7x2-use-threaded-irqs drivers/serial/sc16is7x2.c
> > --- a/drivers/serial/sc16is7x2.c~sc16is7x2-use-threaded-irqs
> > +++ a/drivers/serial/sc16is7x2.c
> [...]
> > @@ -1066,21 +1051,18 @@ static bool sc16is7x2_handle_channel(str
> >  	return (chan->iir & UART_IIR_NO_INT) == 0x00;
> >  }
> >  
> > -static void sc16is7x2_work(struct work_struct *w)
> > +static irqreturn_t sc16is7x2_work(int irq, void *data)
> >  {
> > -	struct sc16is7x2_chip *ts =
> > -			container_of(w, struct sc16is7x2_chip, work);
> > +	struct sc16is7x2_chip *ts = (struct sc16is7x2_chip *)data;
> 
> You don't need to cast from (void *).
> 
> [...]
> >  
> > -static irqreturn_t sc16is7x2_interrupt(int irq, void *dev_id)
> > +static irqreturn_t sc16is7x2_irq(int irq, void *data)
> >  {
> > -	struct sc16is7x2_chip *ts = dev_id;
> > -
> > -	dev_dbg(&ts->spi->dev, "%s\n", __func__);
> > +	struct sc16is7x2_chip *ts = (struct sc16is7x2_channel *)data;
> 
> This cast seems wrong. Better to just drop it, like in sc16is7x2_work().
> 
> >  
> > -	if (!ts->force_end_work && !work_pending(&ts->work) &&
> > -	    !freezing(current) && !ts->suspending)
> > -		queue_work(ts->workqueue, &ts->work);
> > -
> > -	return IRQ_HANDLED;
> > +	/* It takes too long to read the regs over SPI,
> > +	 * so just wake up the thread */
> > +	if (ts->channel[0].active || ts->channel[1].active)
> > +		return IRQ_WAKE_THREAD;
> > +	else
> > +		return IRQ_NONE;
> >  }
> >  
> [...]
> 
> Since this is fixing up patch #1, wouldn't it be better to merge the two?

I think I'll drop them both and will ask for a resend.

I have a note here that Greg mentioned the need to #define
PORT_SC16IS7X2 - please ensure that that is addressed in the next
version, thanks.

