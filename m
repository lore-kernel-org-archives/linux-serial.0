From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] tty: 8250_dw: fix build error for CONFIG_SERIAL_8250=m
Date: Wed, 24 Aug 2011 16:12:27 +0100
Message-ID: <20110824151227.GP23757@pulham.picochip.com>
References: <1314169906-12958-1-git-send-email-jamie@jamieiles.com>
 <201108241645.16377.arnd@arndb.de>
 <20110824145400.GO23757@pulham.picochip.com>
 <20110824150934.GA25080@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40860 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab1HXPMl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Aug 2011 11:12:41 -0400
Received: by wwf5 with SMTP id 5so1322874wwf.1
        for <linux-serial@vger.kernel.org>; Wed, 24 Aug 2011 08:12:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110824150934.GA25080@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jamie Iles <jamie@jamieiles.com>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org

On Wed, Aug 24, 2011 at 08:09:34AM -0700, Greg KH wrote:
> On Wed, Aug 24, 2011 at 03:54:00PM +0100, Jamie Iles wrote:
> > On Wed, Aug 24, 2011 at 04:45:16PM +0200, Arnd Bergmann wrote:
> > > On Wednesday 24 August 2011, Jamie Iles wrote:
> > > > Allow 8250_dw to be built as a module and export serial8250_handle_irq
> > > > so that 8250 can still be built as a module.  This prevents the
> > > > following build failure:
> > > > 
> > > > drivers/built-in.o: In function `dw8250_handle_irq':
> > > > 8250_dw.c:(.text+0xcad9c): undefined reference to `serial8250_handle_irq'
> > > 
> > > I think this won't fix the bug that Stephen was reporting, it will only
> > > make the error message go away but it won't work in the end: When
> > > CONFIG_SERIAL_8250_DW is set to 'm', the declaration of
> > > serial8250_use_designware_io now gets stubbed out from of_serial.ko,
> > > meaning that the 8250_dw module becomes useless.
> > > 
> > > At the very least you also need to export the serial8250_use_designware_io
> > > symbol and check for CONFIG_SERIAL_8250_DW_MODULE in the header.
> > 
> > Ahh, I didn't realise that this would define 
> > CONFIG_SERIAL_8250_DW_MODULE rather than CONFIG_SERIAL_8250_DW.
> > 
> > > When go go to such length, I think the approach I initially advocated
> > > (making 8250_dw a standalone platform_driver like of_serial) will be
> > > nicer.
> > 
> > OK, in hindsight that does seem like a much better option.  I'll spin a 
> > separate platform_driver instead.
> > 
> > Greg, I'm not sure how to best handle this, do you want patches to 
> > revert:
> > 
> > 	tty: serial8250: add helpers for the DesignWare 8250
> > 	tty: of_serial: add support for the DesignWare 8250
> > 
> > or can these be dropped?
> 
> I'll go revert them myself, as that's easiest, right?

Thanks Greg, that would be great (and sorry for the breakage!).

Jamie
