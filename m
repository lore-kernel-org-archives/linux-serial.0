From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v5 1/7] tty: serial: imx: correct dma cookie status
Date: Fri, 29 Jun 2018 16:33:46 +0530
Message-ID: <20180629110346.GD22377@vkoul-mobl>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
 <1529427424-12321-2-git-send-email-yibin.gong@nxp.com>
 <20180626192252.6qdpwzpbpn6s5sd3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180626192252.6qdpwzpbpn6s5sd3@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>, s.hauer@pengutronix.de, l.stach@pengutronix.de, dan.j.williams@intel.com, gregkh@linuxfoundation.org, jslaby@suse.com, dmaengine@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 26-06-18, 21:22, Uwe Kleine-König wrote:
> On Wed, Jun 20, 2018 at 12:56:58AM +0800, Robin Gong wrote:
> > Correct to check the right rx dma cookie status in spit of it
> > works because only one cookie is running in the current sdma.
> > But it will not once sdma driver support multi cookies
> > running based on virt-dma.
> > 
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Looks wrong (because of tx_status vs rx_cookie), but is right
> nevertheless I think:

hehe, tx refers to transfer status for rx (receive) cookie and not
transmit .. yeah notations can be better!

> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Thanks
> Uwe
> 
> > ---
> >  drivers/tty/serial/imx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 4e85357..2879407 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1051,7 +1051,7 @@ static void imx_uart_dma_rx_callback(void *data)
> >  	unsigned int r_bytes;
> >  	unsigned int bd_size;
> >  
> > -	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
> > +	status = dmaengine_tx_status(chan, sport->rx_cookie, &state);
> >  
> >  	if (status == DMA_ERROR) {
> >  		imx_uart_clear_rx_errors(sport);
> > -- 
> > 2.7.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

-- 
~Vinod
