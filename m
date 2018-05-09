From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Date: Wed, 9 May 2018 12:42:56 +0200
Message-ID: <20180509104256.slkzauicnhsktqqf@pengutronix.de>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
 <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
 <20180508134047.zocurxwelw3a24ti@earth.universe>
 <20180508184612.iixr3psap4ik5fdr@pengutronix.de>
 <20180509102058.6mshag4y7aq4w2n2@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180509102058.6mshag4y7aq4w2n2@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, May 09, 2018 at 12:20:58PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, May 08, 2018 at 08:46:12PM +0200, Uwe Kleine-König wrote:
> > On Tue, May 08, 2018 at 03:40:47PM +0200, Sebastian Reichel wrote:
> > > On Tue, May 08, 2018 at 08:43:51AM +0200, Uwe Kleine-König wrote:
> > > > On Mon, May 07, 2018 at 11:36:10PM +0200, Sebastian Reichel wrote:
> > > > > This properly unmaps DMA SG on device shutdown.
> > > > > 
> > > > > Reported-by: Nandor Han <nandor.han@ge.com>
> > > > > Suggested-by: Nandor Han <nandor.han@ge.com>
> > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > > > ---
> > > > >  drivers/tty/serial/imx.c | 12 ++++++++++--
> > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > > index 3ca767b1162a..6c53e74244ec 100644
> > > > > --- a/drivers/tty/serial/imx.c
> > > > > +++ b/drivers/tty/serial/imx.c
> > > > > @@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_port *port)
> > > > >  	u32 ucr1, ucr2;
> > > > >  
> > > > >  	if (sport->dma_is_enabled) {
> > > > > -		sport->dma_is_rxing = 0;
> > > > > -		sport->dma_is_txing = 0;
> > > > >  		dmaengine_terminate_sync(sport->dma_chan_tx);
> > > > > +		if (sport->dma_is_txing) {
> > > > > +			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> > > > > +				     sport->dma_tx_nents, DMA_TO_DEVICE);
> > > > > +			sport->dma_is_txing = 0;
> > > > > +		}
> > > > 
> > > > did you find this because the kernel crashed or consumed more and more
> > > > memory, or is this "only" a finding of reading the source code? If the
> > > > former it would be great to point out in the commit log, if the latter,
> > > > I wonder if this is a real problem that warrants a stable backport.
> > > 
> > > A bit of both. One of Collabora's customers had a (scarce) kernel crash
> > > in imx-serial and modified multiple things in the driver. The crash is
> > > gone, but it's not clear which change fixed it. I could not
> > > reproduce the crash so far and I'm currently rebasing and splitting
> > > their changes into upstreamable portions with proper patch
> > > descriptions. From reading the source this looked like a real issue.
> > 
> > In which context (kernel version, operating mode (e.g. rs485)) did these
> > happen? What does "crash" mean? The kernel did just hang or produced an
> > oops? If the latter, can you show it/them?
> 
> I pasted the oops, that triggered writing the patches (Linux 4.8, no
> rs485, 4MHz baudrate). I think, that the actual issue has already been
> fixed upstream between 4.13 and current master.
> 
> -- Sebastian
> 
> ...
> [  302.516696] Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0938000

This is usually a missing clk. Alternatively RX is disabled and the
RXDATA register is read. Scrolling through

	git log v4.13..linus/master -- drivers/tty/serial/imx.c

I didn't find a candidate for fixing that.

> [  302.524394] pgd = 80004000
> [  302.527111] [f0938000] *pgd=de81a811, *pte=53fc0653, *ppte=53fc0453
> [  302.533451] Internal error: : 1008 [#1] SMP ARM
> [  302.537994] Modules linked in: smsc95xx usbnet atmel_mxt_ts
> [  302.543651] CPU: 0 PID: 357 Comm: _ACFRead Not tainted 4.8.0 #1
> [  302.549578] Hardware name: Freescale i.MX53 (Device Tree Support)
> [  302.555679] task: edbf1f00 task.stack: ed5ce000
> [  302.560228] PC is at imx_rxint+0x5c/0x228
> [  302.564261] LR is at lock_acquired+0x494/0x57c

If you still have this kernel, disabling imx_rxint would be helpful.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
