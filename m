From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] serial: atmel: add missing dmaengine header
Date: Thu, 16 Oct 2014 13:41:12 +0530
Message-ID: <20141016081112.GC1638@intel.com>
References: <1413445197-22304-1-git-send-email-vinod.koul@intel.com>
 <1413448929.2396.13.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4123 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbaJPIrS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 04:47:18 -0400
Content-Disposition: inline
In-Reply-To: <1413448929.2396.13.camel@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org

On Thu, Oct 16, 2014 at 11:42:09AM +0300, Andy Shevchenko wrote:
> On Thu, 2014-10-16 at 13:09 +0530, Vinod Koul wrote:
> > The atmel serial driver uses dmaengine APIs but never included the dmaengine
> > header as it was getting inculded thru one of driver headers.
> > 
> > commit 3d588f83e4d6a5230d9094b97d38621cbaa9a972 - "dmaengine: dw: split
> > dma-dw.h to platform and private parts" broke this as it moved headers
> > around.  Fix this by doing the right thing to include the dmaengine header
> > 
> 
> Thanks, I just sent similar idea to Fengguang and you.
> 
> I don't know if it would be a stable material. If so, it would be nice
> to add:
> 
> Fixes: 08f738be88bb (serial: at91: add tx dma support)
> Cc: stable@vger.kernel.org
Fixes yes, but am not too keen on marking this stable as it wont show up
unless we have 3d588f8

-- 
~Vinod

> 
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> > Greg, since this is path which broke this is sitting in my next, would it be
> > okay to carry this thru dmaengine tree as get it merged in current window.
> > Planning to send pull request in day or so to Linus
> > 
> >  drivers/tty/serial/atmel_serial.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> > index d7d4584..edde3ec 100644
> > --- a/drivers/tty/serial/atmel_serial.c
> > +++ b/drivers/tty/serial/atmel_serial.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/dmaengine.h>
> >  #include <linux/atmel_pdc.h>
> >  #include <linux/atmel_serial.h>
> >  #include <linux/uaccess.h>
> 
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@intel.com>
> Intel Finland Oy
> 

-- 
