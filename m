From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v2 1/6] serial: uartps: Do not initialize field to
 zero again
Date: Wed, 27 Jun 2018 18:09:17 +0800
Message-ID: <20180627100917.GA20940@kroah.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
 <e8b0169887855a5ef2c1a0456842f650601b451c.1528288895.git.michal.simek@xilinx.com>
 <e7b01bd9-5763-75c0-1384-2536313f5854@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e7b01bd9-5763-75c0-1384-2536313f5854@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 19, 2018 at 10:09:05AM +0200, Michal Simek wrote:
> On 6.6.2018 14:41, Michal Simek wrote:
> > Writing zero and NULLs to already initialized fields is not needed.
> > Remove this additional writes.
> > 
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> > 
> > Changes in v2:
> > - new patch - it can be sent separately too
> > 
> >  drivers/tty/serial/xilinx_uartps.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> > index 8a3e34234e98..5f116f3ecd4a 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -1510,15 +1510,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
> >  
> >  	/* At this point, we've got an empty uart_port struct, initialize it */
> >  	spin_lock_init(&port->lock);
> > -	port->membase	= NULL;
> > -	port->irq	= 0;
> >  	port->type	= PORT_UNKNOWN;
> >  	port->iotype	= UPIO_MEM32;
> >  	port->flags	= UPF_BOOT_AUTOCONF;
> >  	port->ops	= &cdns_uart_ops;
> >  	port->fifosize	= CDNS_UART_FIFO_SIZE;
> >  	port->line	= id;
> > -	port->dev	= NULL;
> >  
> >  	/*
> >  	 * Register the port.
> > 
> 
> Alan, Rob, Greg: Any comment about this RFC?

I rarely review RFC patchesets as obviously you don't think it is good
enough to be submitted "for real" :)

If you think this is all good, great, please resend it without the RFC
and it will end up in my queue.

thanks,

greg k-h
