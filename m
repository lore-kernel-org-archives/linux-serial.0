From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Date: Tue, 8 May 2018 20:46:12 +0200
Message-ID: <20180508184612.iixr3psap4ik5fdr@pengutronix.de>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
 <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
 <20180508134047.zocurxwelw3a24ti@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180508134047.zocurxwelw3a24ti@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Sebastian,

On Tue, May 08, 2018 at 03:40:47PM +0200, Sebastian Reichel wrote:
> On Tue, May 08, 2018 at 08:43:51AM +0200, Uwe Kleine-König wrote:
> > On Mon, May 07, 2018 at 11:36:10PM +0200, Sebastian Reichel wrote:
> > > This properly unmaps DMA SG on device shutdown.
> > > 
> > > Reported-by: Nandor Han <nandor.han@ge.com>
> > > Suggested-by: Nandor Han <nandor.han@ge.com>
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > ---
> > >  drivers/tty/serial/imx.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > index 3ca767b1162a..6c53e74244ec 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_port *port)
> > >  	u32 ucr1, ucr2;
> > >  
> > >  	if (sport->dma_is_enabled) {
> > > -		sport->dma_is_rxing = 0;
> > > -		sport->dma_is_txing = 0;
> > >  		dmaengine_terminate_sync(sport->dma_chan_tx);
> > > +		if (sport->dma_is_txing) {
> > > +			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> > > +				     sport->dma_tx_nents, DMA_TO_DEVICE);
> > > +			sport->dma_is_txing = 0;
> > > +		}
> > 
> > did you find this because the kernel crashed or consumed more and more
> > memory, or is this "only" a finding of reading the source code? If the
> > former it would be great to point out in the commit log, if the latter,
> > I wonder if this is a real problem that warrants a stable backport.
> 
> A bit of both. One of Collabora's customers had a (scarce) kernel crash
> in imx-serial and modified multiple things in the driver. The crash is
> gone, but it's not clear which change fixed it. I could not
> reproduce the crash so far and I'm currently rebasing and splitting
> their changes into upstreamable portions with proper patch
> descriptions. From reading the source this looked like a real issue.

In which context (kernel version, operating mode (e.g. rs485)) did these
happen? What does "crash" mean? The kernel did just hang or produced an
oops? If the latter, can you show it/them?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
