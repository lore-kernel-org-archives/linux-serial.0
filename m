From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 03/15] serial: sh-sci: Restrict non-COMPILE_TEST compilation
Date: Wed, 11 Dec 2013 13:44:54 +0100
Message-ID: <1644962.Fmr1aLVkXP@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1385515117-23664-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20131128073711.GF24146@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42919 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab3LKMom (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Dec 2013 07:44:42 -0500
In-Reply-To: <20131128073711.GF24146@verge.net.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Hi Simon,

Could you please add this patch to your tree with the "[PATCH 00/47] sh-sci 
updates for v3.14" series ?

On Thursday 28 November 2013 16:37:11 Simon Horman wrote:
> On Wed, Nov 27, 2013 at 02:18:25AM +0100, Laurent Pinchart wrote:
> > Hardware supported by the driver is only found on SUPERH or
> > ARCH_SHMOBILE platforms. Restrict non-COMPILE_TEST compilation to them.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-serial@vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> > ---
> > 
> >  drivers/tty/serial/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index a3817ab..a640d0b 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -709,7 +709,8 @@ config SERIAL_IP22_ZILOG_CONSOLE
> > 
> >  config SERIAL_SH_SCI
> >  	tristate "SuperH SCI(F) serial port support"
> > -	depends on HAVE_CLK && (SUPERH || ARM || COMPILE_TEST)
> > +	depends on HAVE_CLK
> > +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> >  	select SERIAL_CORE
> >  
> >  config SERIAL_SH_SCI_NR_UARTS

-- 
Regards,

Laurent Pinchart

