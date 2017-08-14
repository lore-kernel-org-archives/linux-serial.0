From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: Improve PIO prevention if TX DMA has been
 started
Date: Mon, 14 Aug 2017 08:51:49 +0200
Message-ID: <20170814065149.cwgw5echcjhvqxjb@pengutronix.de>
References: <20170812151210.10420-1-clemens.gruber@pqgruber.com>
 <20170812195451.2g65wifawouz4t7d@pengutronix.de>
 <20170812220755.GA22225@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170812220755.GA22225@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org, Ian Jamison <ian.dev@arkver.com>
List-Id: linux-serial@vger.kernel.org

Hello Clemens,

On Sun, Aug 13, 2017 at 12:07:56AM +0200, Clemens Gruber wrote:
> On Sat, Aug 12, 2017 at 09:54:51PM +0200, Uwe Kleine-König wrote:
> > On Sat, Aug 12, 2017 at 05:12:10PM +0200, Clemens Gruber wrote:
> > > The imx_transmit_buffer function should return if TX DMA has already
> > > been started and not just skip over the buffer PIO write loop. (Which
> > > did fix the initial problem, but could have unintentional side-effects)
> > > 
> > > Tested on an i.MX6Q board with half-duplex RS-485 and with RS-232.
> > > 
> > > Cc: Ian Jamison <ian.dev@arkver.com>
> > > Cc: Uwe-Kleine König <u.kleine-koenig@pengutronix.de>
> > > Fixes: 514ab34dbad6 ("serial: imx: Prevent TX buffer PIO write when a
> > > DMA has been started")
> > 
> > AFAIK no newline in the Fixes: line.
> 
> Thanks. A checkpatch warning for this would be great.

I assume that is a note to yourself to look into that? :-)

> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > index 80934e7bd67f..fce538eb8c77 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -452,13 +452,14 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
> > >  		if (sport->dma_is_txing) {
> > >  			temp |= UCR1_TDMAEN;
> > >  			writel(temp, sport->port.membase + UCR1);
> > > +			return;
> > >  		} else {
> > >  			writel(temp, sport->port.membase + UCR1);
> > >  			imx_dma_tx(sport);
> > >  		}
> > 
> > Shouldn't the return go here?
> 
> Yes, it can also go here (and probably should). The problem of
> xmit->tail jumping over xmit->head occurs only if we are already DMA
> txing and then go into the PIO loop, but not the first time after
> calling imx_dma_tx. That's why the v1 passed the tests too.
> I'll have to conduct a few more tests and if they succeed I'll send a
> v2 where we return in both cases (already txing and starting to).
> 
> > Did you understand the problem? Can you say why this only hurts in RS485
> > half-duplex but not (as it seems) in regular rs232 mode?
> 
> I am not sure anyone understands (yet) why it a) only hurts RS-485 and
> b) only occurs on SMP systems.
> If you have more insight, please share it. :)

I asked because I thought you might have understood it before patching
it ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
