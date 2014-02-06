From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] serial: sh_sci: remove HAVE_CLK build dependecy
Date: Thu, 6 Feb 2014 16:25:57 +0900
Message-ID: <20140206072557.GA24865@verge.net.au>
References: <2f1dd25b19bf588948fbebc734eebe5d61ca7007.1391628518.git.baruch@tkos.co.il>
 <20140206064056.GB17591@verge.net.au>
 <20140206071821.GC4125@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:53680 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111AbaBFHZ7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Feb 2014 02:25:59 -0500
Content-Disposition: inline
In-Reply-To: <20140206071821.GC4125@tarshish>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Feb 06, 2014 at 09:18:21AM +0200, Baruch Siach wrote:
> Hi Simon,
> 
> On Thu, Feb 06, 2014 at 03:40:56PM +0900, Simon Horman wrote:
> > On Wed, Feb 05, 2014 at 09:28:38PM +0200, Baruch Siach wrote:
> > > Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h
> > > like this driver needs not depend on HAVE_CLK.
> > > 
> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thanks. This patch conflicts with another sh_sci patch you have just posted 
> (http://article.gmane.org/gmane.linux.serial/13640). How would you like this 
> to be handled?

Indeed it does, sorry for not noticing that.

Perhaps it would be best to drop the patch that I posted?

> baruch
> 
> > > ---
> > >  drivers/tty/serial/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index a3815eaed421..ce6fd1dd0864 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -708,7 +708,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
> > >  
> > >  config SERIAL_SH_SCI
> > >  	tristate "SuperH SCI(F) serial port support"
> > > -	depends on HAVE_CLK && (SUPERH || ARM || COMPILE_TEST)
> > > +	depends on SUPERH || ARM || COMPILE_TEST
> > >  	select SERIAL_CORE
> > >  
> > >  config SERIAL_SH_SCI_NR_UARTS
> > > -- 
> > > 1.8.5.3
> 
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
