From: Bin Gao <bin.gao@linux.intel.com>
Subject: Re: [PATCH v3 1/2] serial_core: add pci uart early console support
Date: Tue, 19 May 2015 10:32:26 -0700
Message-ID: <20150519173224.GA202975@worksta>
References: <20150518212152.GA95407@worksta>
 <1432036867.9091.75.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432036867.9091.75.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Tue, May 19, 2015 at 02:01:07PM +0200, Paul Bolle wrote:
> On Mon, 2015-05-18 at 14:21 -0700, Bin Gao wrote:
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2228,6 +2228,8 @@ config PCI
> >  	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
> >  	  VESA. If you have PCI, say Y, otherwise N.
> >  
> > +	select HAVE_EARLY_PCI
> > +
> 
> It's legal to have options after the help text of a Kconfig entry. It's
> also very uncommon to do that. Please put this select statement before
> the line reading "---help---" of the PCI entry.
>  
Will fix this in next patch set.

> > +config HAVE_EARLY_PCI
> > +	def_bool y
> 
> You probably want just
> 	bool
> 
> here. Because this symbol has no further dependencies, which means
> HAVE_EARLY_PCI will now always be set to 'y'. That, in turn, makes the
> select you added above pointless.
>
Yes, you're right. bool is better.

 
> > +	help
> > +	  This option indicates that a group of APIs are available (in
> > +	  asm/pci-direct.h) so the kernel can access pci config registers
> > +	  before the PCI subsystem is initialized. Any arch that supports
> 
> Is this expected to be used outside of X86?
Yes, drivers/tty/serial/serial_core.c is going to use it.
