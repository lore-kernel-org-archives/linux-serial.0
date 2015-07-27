From: Bin Gao <bin.gao@linux.intel.com>
Subject: Re: [PATCH v6 1/2] serial_core: add pci uart early console support
Date: Mon, 27 Jul 2015 16:33:12 -0700
Message-ID: <20150727233312.GA188620@worksta>
References: <20150529183839.GA13090@worksta>
 <20150608181711.GA181146@worksta>
 <20150723222127.GA9973@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150723222127.GA9973@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 23, 2015 at 03:21:27PM -0700, Greg Kroah-Hartman wrote:
> > +config PCI_EARLY
> > +	bool "Early PCI access"
> > +	depends on PCI
> > +	default n
> 
> Default is always 'n' so this isn't needed here.

Will fix this.

> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 0b7bb12..5b21999 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -34,10 +34,15 @@
> >  #include <linux/serial_core.h>
> >  #include <linux/delay.h>
> >  #include <linux/mutex.h>
> > +#include <linux/pci_regs.h>
> >  
> >  #include <asm/irq.h>
> >  #include <asm/uaccess.h>
> >  
> > +#ifdef CONFIG_PCI_EARLY
> > +#include <asm/pci-direct.h>
> > +#endif
> 
> You shouldn't need an #ifdef here, the .h file should handle it.  Why
> doesn't pci.h always include this if it is present?

Only x86 has asm/pci-direct.h. Compiling on any other archs will fail
if we don't put CONFIG_PCI_EARLY here. That's way I added a new config
option CONFIG_PCI_EARLY to drivers/pci/Kconfig and let an arch to select
it. Do you want me to move "#include <asm/pci-direct.h>" to linux/pci.h?

> 
> thanks,
> 
> greg k-h
