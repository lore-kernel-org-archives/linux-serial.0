From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/7] serial: imx: init dma_is_{rx|tx}ing variables
Date: Wed, 5 Jul 2017 13:58:47 +0200
Message-ID: <20170705115847.nxgznbv5xacnbjqg@pengutronix.de>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-4-romain.perier@collabora.com>
 <20170630141329.6144cddd@karo-electronics.de>
 <20170703065221.imbpbybsrd3of4ec@pengutronix.de>
 <91cc9a48-58e9-98a9-58aa-1a949b9b5552@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <91cc9a48-58e9-98a9-58aa-1a949b9b5552@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Perier <romain.perier@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: linux-serial@vger.kernel.org

Hello Romain,

On Wed, Jul 05, 2017 at 12:14:57PM +0200, Romain Perier wrote:
> Le 03/07/2017 à 08:52, Uwe Kleine-König a écrit :
> > On Fri, Jun 30, 2017 at 02:13:29PM +0200, Lothar Waßmann wrote:
> >> On Fri, 30 Jun 2017 14:04:42 +0200 Romain Perier wrote:
> >>> From: Nandor Han <nandor.han@ge.com>
> >>>
> >>> Initialize both dma_is_{rx|tx}ing variables when DMA is enabled to avoid
> >>> checking uninitialized variables if port shutdown is requested before
> >>> DMA channels get a chance to start.
> >>>
> >>> Signed-off-by: Nandor Han <nandor.han@ge.com>
> >>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> >>> ---
> >>>  drivers/tty/serial/imx.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >>> index 188063d..81fb413 100644
> >>> --- a/drivers/tty/serial/imx.c
> >>> +++ b/drivers/tty/serial/imx.c
> >>> @@ -1225,6 +1225,9 @@ static void imx_enable_dma(struct imx_port *sport)
> >>>  
> >>>  	imx_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
> >>>  
> >>> +	sport->dma_is_rxing = 0;
> >>> +	sport->dma_is_txing = 0;
> >>> +
> >>>  	sport->dma_is_enabled = 1;
> >>>  }
> >>>  
> >> sport is devm_kzalloc()ed, so the variables are initialized to 0 anyway.
> > I'd agree to Lothar's statement. Did you find this issue by inspection,
> > or does it fix a compiler warning? Do you think there is an actual
> > problem?
> >
> > Best regards
> > Uwe
> >
> What does happen if the UART port is shutdown and then re-enabled ? I
> don't think that kzalloc will work in this case

imx_shutdown has:

        if (sport->dma_is_enabled) {
		sport->dma_is_rxing = 0;
		sport->dma_is_txing = 0;

which might be good enough. Can dma_is_[rt]xing be != 0 if
dma_is_enabled is false? It seems it cannot, the only place where
dma_is_enabled is set to 0 (apart from the kzalloc where dma_is_[rt]xing
is set to zero) is imx_disable_dma(). The only caller sets both
dma_is_[rt]xing to zero before.

So this patch should be dropped or its commit log improved to point out
the actual problem.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
