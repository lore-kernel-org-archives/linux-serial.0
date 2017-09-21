From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: Re: [PATCH v3 1/6] serial: imx: remove CTSC and CTS handling from
 imx_disable_dma
Date: Thu, 21 Sep 2017 20:12:57 +0100
Message-ID: <20170921191257.GJ6739@hermes.home>
References: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
 <1506010697-22114-2-git-send-email-martyn.welch@collabora.co.uk>
 <20170921182017.t7c75tyy66q7q3ns@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170921182017.t7c75tyy66q7q3ns@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 21, 2017 at 08:20:17PM +0200, Uwe Kleine-König wrote:
> On Thu, Sep 21, 2017 at 05:18:12PM +0100, Martyn Welch wrote:
> > From: Nandor Han <nandor.han@ge.com>
> > 
> > The CTSC and CTS bits affect operation of the CTS/RTS hardware flow
> > control signal (depending on whether the device is in DCE or DTE mode) and
> > are not related to DMA. When in RS-232 mode, the driver is using the
> > automatic CTSC control based on a rxFIFO fill level unless the state of
> > the CTS signal is explictly set via an ioctl call.
> > 
> > Previous improvements to the imx serial driver have resulted on
> > imx_disable_dma() only being called on shutdown, by which point the
> > serial core has already correctly deasserted CTS.
> > 
> > Testing shows that without this handling in imx_disable_dma() the CTS
> > signal state is set correctly when the device is open and TIOCM_RTS is
> > set/cleared via the TIOCMGET ioctl. The CTS signal is also correctly
> > deasserted when the device file is closed.
> 
> With that block kept CTS set once more to inactive. So the block doesn't
> hurt and is "only" superflous, right?
> 

That's my understanding, yes.

> > When in RS-485 mode, the driver uses the CTS signal very differently and
> > appears to control it via calls to imx_port_rts_active() and
> > imx_port_rts_inactive().
> > 
> > This configuration of the CTSC and CTS bits are therefore not needed.
> > 
> > Signed-off-by: Nandor Han <nandor.han@ge.com>
> > Signed-off-by: Romain Perier <romain.perier@collabora.com>
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> > ---
> >  drivers/tty/serial/imx.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index fe368a4..d90dae3 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1225,11 +1225,6 @@ static void imx_disable_dma(struct imx_port *sport)
> >  	temp &= ~(UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN);
> >  	writel(temp, sport->port.membase + UCR1);
> >  
> > -	/* clear UCR2 */
> > -	temp = readl(sport->port.membase + UCR2);
> > -	temp &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
> > -	writel(temp, sport->port.membase + UCR2);
> 
> The commit log doesn't mention ATEN, I guess that one just doesn't
> matter any more at this stage? Would be nice to point out though.
> 

Hmm, going to need to look at this again...

Patch 5 adds clearing ATEN into imx_stop_rx(), which is sensible given
that it's the aging timer on the rxFIFO, but I don't think we should be
removing that from here before it's in imx_stop_rx().

> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
