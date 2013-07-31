From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] serial8250-em: Convert to devm_* managed helpers
Date: Wed, 31 Jul 2013 09:25:48 +0900
Message-ID: <20130731002547.GC17209@verge.net.au>
References: <1374848522-13125-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130730020859.GB27724@verge.net.au>
 <1693887.iFDQbH8OZ5@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1693887.iFDQbH8OZ5@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 30, 2013 at 12:00:37PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Tuesday 30 July 2013 11:08:59 Simon Horman wrote:
> > [ CC Greg Kroah-Hartman, linux-serial@vger.kernel.org,
> >   linux-arm-kernel@lists.infradead.org ]
> > 
> > On Fri, Jul 26, 2013 at 04:22:02PM +0200, Laurent Pinchart wrote:
> > > Replace kzalloc and clk_get by their managed counterparts to simplify
> > > error and cleanup paths.
> > 
> > Hi Laurent,
> > 
> > I was recently asked for shmobile clocksource patches to be reviewed by the
> > clocksource maintainers.
> 
> I suppose you mean serial port, not clock source.
> 
> > I believe that means Greg Kroah-Hartman and linux-serial@vger.kernel.org who
> > I have CCed on this email accordingly.
> 
> linux-serial@vger.kernel.org was already CC'ed in my original e-mail. 
> 
> > I have also CCed linux-arm-kernel@lists.infradead.org
> 
> Actually you haven't ;-)

:^)

> > as many moons ago I was asked for all patches that will go through my tree
> > and on to arm-soc to be sent there.
> 
> This patch will likely go through the serial tree, which is why I hadn't CC'ed 
> LAKML.

Understood, that makes sense.

> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  drivers/tty/serial/8250/8250_em.c | 27 ++++++++-------------------
> > >  1 file changed, 8 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_em.c
> > > b/drivers/tty/serial/8250/8250_em.c index 916cc19..5f3bba1 100644
> > > --- a/drivers/tty/serial/8250/8250_em.c
> > > +++ b/drivers/tty/serial/8250/8250_em.c
> > > @@ -95,25 +95,23 @@ static int serial8250_em_probe(struct platform_device
> > > *pdev)> 
> > >  	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ,
> > >  	0);
> > >  	struct serial8250_em_priv *priv;
> > >  	struct uart_8250_port up;
> > > -	int ret = -EINVAL;
> > > +	int ret;
> > > 
> > >  	if (!regs || !irq) {
> > >  		dev_err(&pdev->dev, "missing registers or irq\n");
> > > -		goto err0;
> > > +		return -EINVAL;
> > >  	}
> > > 
> > > -	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > >  	if (!priv) {
> > >  		dev_err(&pdev->dev, "unable to allocate private data\n");
> > > -		ret = -ENOMEM;
> > > -		goto err0;
> > > +		return -ENOMEM;
> > >  	}
> > > 
> > > -	priv->sclk = clk_get(&pdev->dev, "sclk");
> > > +	priv->sclk = devm_clk_get(&pdev->dev, "sclk");
> > >  	if (IS_ERR(priv->sclk)) {
> > >  		dev_err(&pdev->dev, "unable to get clock\n");
> > > -		ret = PTR_ERR(priv->sclk);
> > > -		goto err1;
> > > +		return PTR_ERR(priv->sclk);
> > >  	}
> > >  	
> > >  	memset(&up, 0, sizeof(up));
> > > @@ -136,20 +134,13 @@ static int serial8250_em_probe(struct
> > > platform_device *pdev)> 
> > >  	ret = serial8250_register_8250_port(&up);
> > >  	if (ret < 0) {
> > >  		dev_err(&pdev->dev, "unable to register 8250 port\n");
> > > -		goto err2;
> > > +		clk_disable(priv->sclk);
> > > +		return ret;
> > >  	}
> > >  	
> > >  	priv->line = ret;
> > >  	platform_set_drvdata(pdev, priv);
> > >  	return 0;
> > > -
> > > - err2:
> > > -	clk_disable(priv->sclk);
> > > -	clk_put(priv->sclk);
> > > - err1:
> > > -	kfree(priv);
> > > - err0:
> > > -	return ret;
> > >  }
> > >  
> > >  static int serial8250_em_remove(struct platform_device *pdev)
> > > 
> > > @@ -158,8 +149,6 @@ static int serial8250_em_remove(struct platform_device
> > > *pdev)> 
> > >  	serial8250_unregister_port(priv->line);
> > >  	clk_disable(priv->sclk);
> > > 
> > > -	clk_put(priv->sclk);
> > > -	kfree(priv);
> > > 
> > >  	return 0;
> > >  
> > >  }
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
