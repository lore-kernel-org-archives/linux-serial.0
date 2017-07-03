From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/7] serial: imx: init dma_is_{rx|tx}ing variables
Date: Mon, 3 Jul 2017 08:52:21 +0200
Message-ID: <20170703065221.imbpbybsrd3of4ec@pengutronix.de>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-4-romain.perier@collabora.com>
 <20170630141329.6144cddd@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630141329.6144cddd@karo-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Perier <romain.perier@collabora.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 30, 2017 at 02:13:29PM +0200, Lothar Waßmann wrote:
> Hi,
> 
> On Fri, 30 Jun 2017 14:04:42 +0200 Romain Perier wrote:
> > From: Nandor Han <nandor.han@ge.com>
> > 
> > Initialize both dma_is_{rx|tx}ing variables when DMA is enabled to avoid
> > checking uninitialized variables if port shutdown is requested before
> > DMA channels get a chance to start.
> > 
> > Signed-off-by: Nandor Han <nandor.han@ge.com>
> > Signed-off-by: Romain Perier <romain.perier@collabora.com>
> > ---
> >  drivers/tty/serial/imx.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 188063d..81fb413 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1225,6 +1225,9 @@ static void imx_enable_dma(struct imx_port *sport)
> >  
> >  	imx_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
> >  
> > +	sport->dma_is_rxing = 0;
> > +	sport->dma_is_txing = 0;
> > +
> >  	sport->dma_is_enabled = 1;
> >  }
> >  
> sport is devm_kzalloc()ed, so the variables are initialized to 0 anyway.

I'd agree to Lothar's statement. Did you find this issue by inspection,
or does it fix a compiler warning? Do you think there is an actual
problem?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
