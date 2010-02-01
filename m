From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] bcm63xx_uart: allow more than one uart to be
 registered.
Date: Mon, 1 Feb 2010 14:29:19 -0800
Message-ID: <20100201222919.GD19294@kroah.com>
References: <1264873377-28479-1-git-send-email-mbizon@freebox.fr>
 <1264873377-28479-3-git-send-email-mbizon@freebox.fr>
 <20100130182343.GA6971@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:51043 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755475Ab0BAWhi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Feb 2010 17:37:38 -0500
Content-Disposition: inline
In-Reply-To: <20100130182343.GA6971@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Maxime Bizon <mbizon@freebox.fr>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org

On Sat, Jan 30, 2010 at 07:23:43PM +0100, Wolfram Sang wrote:
> On Sat, Jan 30, 2010 at 06:42:57PM +0100, Maxime Bizon wrote:
> > The bcm6358 CPU has two uarts, make it possible to use the second one.
> > 
> > Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> > ---
> >  drivers/serial/bcm63xx_uart.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/serial/bcm63xx_uart.c b/drivers/serial/bcm63xx_uart.c
> > index f78ede8..6ab959a 100644
> > --- a/drivers/serial/bcm63xx_uart.c
> > +++ b/drivers/serial/bcm63xx_uart.c
> > @@ -35,7 +35,7 @@
> >  #include <bcm63xx_regs.h>
> >  #include <bcm63xx_io.h>
> >  
> > -#define BCM63XX_NR_UARTS	1
> > +#define BCM63XX_NR_UARTS	2
> >  
> >  static struct uart_port ports[BCM63XX_NR_UARTS];
> >  
> > @@ -784,7 +784,7 @@ static struct uart_driver bcm_uart_driver = {
> >  	.dev_name	= "ttyS",
> >  	.major		= TTY_MAJOR,
> >  	.minor		= 64,
> > -	.nr		= 1,
> > +	.nr		= 2,
> 
> Err, why not using the #define here?

Good idea, I've tweaked the patch to do that.

thanks,

greg k-h
