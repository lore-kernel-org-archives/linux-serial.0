From: Richard Zhao <richard.zhao@linaro.org>
Subject: Re: [PATCH 1/1] serial: imx: convert to clk_prepare/clk_unprepare
Date: Thu, 10 Nov 2011 16:24:33 +0800
Message-ID: <20111110082432.GA14617@b20223-02.ap.freescale.net>
References: <1320901158-13103-1-git-send-email-richard.zhao@linaro.org>
 <20111110080641.GT16886@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:16888
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753321Ab1KJIYw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Nov 2011 03:24:52 -0500
Content-Disposition: inline
In-Reply-To: <20111110080641.GT16886@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: kernel@pengutronix.de, eric.miao@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, alan@linux.intel.com

On Thu, Nov 10, 2011 at 09:06:41AM +0100, Sascha Hauer wrote:
> On Thu, Nov 10, 2011 at 12:59:18PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  drivers/tty/serial/imx.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 163fc90..22fd9c8 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1390,6 +1390,7 @@ static int serial_imx_probe(struct platform_device *pdev)
> >  		ret = PTR_ERR(sport->clk);
> >  		goto unmap;
> >  	}
> > +	clk_prepare(sport->clk);
> >  	clk_enable(sport->clk);
> >  
> >  	sport->port.uartclk = clk_get_rate(sport->clk);
> > @@ -1415,6 +1416,7 @@ deinit:
> >  clkput:
> >  	clk_put(sport->clk);
> >  	clk_disable(sport->clk);
> > +	clk_unprepare(sport->clk);
> 
> Ouch, clk_put before clk_disable? This is is bug. Care to fix it?
hmm.. I'll fix the two bugs in my next version patch.
> 
> >  unmap:
> >  	iounmap(sport->port.membase);
> >  free:
> > @@ -1438,6 +1440,7 @@ static int serial_imx_remove(struct platform_device *pdev)
> >  	}
> >  
> >  	clk_disable(sport->clk);
> > +	clk_unprepare(sport->clk);
> >  
> 
> Here clk_put is missing, another bug.
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

