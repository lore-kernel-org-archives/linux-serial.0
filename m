From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dma: call serial8250_tx_dma unconditionally
Date: Thu, 06 Nov 2014 12:32:34 +0200
Message-ID: <1415269954.472.23.camel@linux.intel.com>
References: <1412772129-22816-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20141106032601.GA10724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:4385 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbaKFKce (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 05:32:34 -0500
In-Reply-To: <20141106032601.GA10724@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org

On Wed, 2014-11-05 at 19:26 -0800, Greg Kroah-Hartman wrote:
> On Wed, Oct 08, 2014 at 03:42:09PM +0300, Andy Shevchenko wrote:
> > Since we have the same check inside the function we may drop it away in
> > __dma_tx_complete().
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/tty/serial/8250/8250_dma.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> > index 148ffe4..189ae3c 100644
> > --- a/drivers/tty/serial/8250/8250_dma.c
> > +++ b/drivers/tty/serial/8250/8250_dma.c
> > @@ -36,8 +36,7 @@ static void __dma_tx_complete(void *param)
> >  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> >  		uart_write_wakeup(&p->port);
> >  
> > -	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port))
> > -		serial8250_tx_dma(p);
> > +	serial8250_tx_dma(p);
> >  
> >  	spin_unlock_irqrestore(&p->port.lock, flags);
> >  }
> 
> The code in this area has changed a lot now due to some dma work added
> to this driver.  Can you look at my tty-testing branch of tty.git on
> git.kernel.org and see if this is still relevant now? 

Yes, it is. I will create a patch and resend soon.

Heikki, I'm not going to apply your Reviewed-by because of those changes
Greg mentioned. Please, review again when I submit it.

>  If so, please
> refresh this patch and resend.
> 
> thanks,
> 
> greg k-h


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

