From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] RFC: serial: core: Dynamic minor support
Date: Thu, 20 Apr 2017 14:54:16 +0200
Message-ID: <20170420125416.GA5659@kroah.com>
References: <20170420120357.18317-1-sjoerd.simons@collabora.co.uk>
 <20170420121544.GA1131@kroah.com>
 <1492692258.27393.8.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492692258.27393.8.camel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: linux-serial@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 20, 2017 at 02:44:18PM +0200, Sjoerd Simons wrote:
> On Thu, 2017-04-20 at 14:15 +0200, Greg Kroah-Hartman wrote:
> > On Thu, Apr 20, 2017 at 02:03:57PM +0200, Sjoerd Simons wrote:
> > > --- a/include/linux/serial_core.h
> > > +++ b/include/linux/serial_core.h
> > > @@ -31,6 +31,8 @@
> > >  #include <linux/sysrq.h>
> > >  #include <uapi/linux/serial_core.h>
> > >  
> > > +#define LOW_DENSITY_UART_MAJOR 204
> > 
> > Where are you stealing this from?
> 
> Heh, 204 is defined as the "Low-density serial ports" in
> devices.txt. As documented in the commit message, i've repurposed that
> for dynamic minors (if configured). Maybe it's better to request a new
> major for this purpose? But then again, then just means 204 will go
> unused when the option is on so...
> 
> Lots of drivers do have it as a hard-coded number, seemed sane to put
> it a bit more central for some potential later cleanup in other
> drivers.

Ah, no, that's fine, didn't realize it wasn't already defined somewhere
already.

> > > +
> > >  #ifdef CONFIG_SERIAL_CORE_CONSOLE
> > >  #define uart_console(port) \
> > >  	((port)->cons && (port)->cons->index == (port)->line)
> > > @@ -313,6 +315,10 @@ struct uart_driver {
> > >  	 */
> > >  	struct uart_state	*state;
> > >  	struct tty_driver	*tty_driver;
> > > +
> > > +#ifdef CONFIG_SERIAL_DYNAMIC_MINORS
> > > +	struct list_head	dynamic_uarts;
> > > +#endif
> > 
> > Why not just always have this?
> 
> Trying to save a few bytes if the option is unused; Maybe overdoing it
> :)
> 
> > Nice first try though!
> 
> Thanks, If there are no big comments onthe general approach i'll respin
> without RFC soonish addressing your other comments.

Wait, can you use an idr for this instead of rolling your own search
logic for a series?  I think the usb-serial core did this same sort of
functionality in the drivers/usb/serial/usb-serial.c:allocate_minors()
function using an idr.  Try that instead here as well.

thanks,

greg k-h
