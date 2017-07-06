From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/6] serial: imx: only set DMA rx-ing when DMA starts
Date: Thu, 6 Jul 2017 12:02:27 +0200
Message-ID: <20170706100227.gn3acq2ppdlofuj7@pengutronix.de>
References: <20170705130706.10388-1-romain.perier@collabora.com>
 <20170705130706.10388-2-romain.perier@collabora.com>
 <20170705132910.nmixhnh4l6h2hlga@pengutronix.de>
 <49bfa666-b036-3ed9-8209-9ea59468371b@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49bfa666-b036-3ed9-8209-9ea59468371b@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Perier <romain.perier@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 06, 2017 at 10:31:38AM +0200, Romain Perier wrote:
> Hello,
> 
> 
> Le 05/07/2017 à 15:29, Uwe Kleine-König a écrit :
> > Hello,
> >
> > On Wed, Jul 05, 2017 at 03:07:01PM +0200, Romain Perier wrote:
> >> From: Nandor Han <nandor.han@ge.com>
> >>
> >> Avoid the situation when `dma_is_rxing` could incorrectly signal that
> >> DMA RX channel is receiving data in case DMA preparation or sg mapping
> >> fails.
> >>
> >> This commit fixes the issues by moving the assignment of dma_is_rxing
> >> out of imx_disable_rx_int(), then the variable is set to 1 from
> >> start_rx_dma() only when the preparation is correctly done.
> > I'd write:
> >
> > 	There are a few issues with setting dma_is_rxing to 1 in
> > 	imx_disable_rx_int:
> >
> > 	 - Currently always after imx_disable_rx_int() the function
> > 	   start_rx_dma() is called. This dependency isn't obvious though.
> > 	 - start_rx_dma() does error checking and might exit without enabling
> > 	   DMA but keeping dma_is_rxing 1.
> >
> > 	So the more natural place for setting dma_is_rxing to 1 is in
> > 	start_rx_dma after all errors are checked.
> >
> > If you use this, there is nothing left of Nandor Han's patch and you can
> > drop his authorship.
> >
> > Best regards
> > Uwe
> >
> Ok, will do. No other feedback for the rest of the series ? (just to
> know if I send a v3 or If I wait a bit...)

I didn't come around looking in the patches I didn't comment yet.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
