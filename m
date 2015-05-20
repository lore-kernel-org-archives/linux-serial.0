From: Bin Gao <bin.gao@linux.intel.com>
Subject: Re: [PATCH v3 1/2] serial_core: add pci uart early console support
Date: Wed, 20 May 2015 10:59:23 -0700
Message-ID: <20150520175922.GA163133@worksta>
References: <20150518212152.GA95407@worksta>
 <1432036867.9091.75.camel@x220>
 <20150519173224.GA202975@worksta>
 <1432113385.21715.76.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432113385.21715.76.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Wed, May 20, 2015 at 11:16:25AM +0200, Paul Bolle wrote:
> What I should have asked is: do you expect architectures other than X86
> to set HAVE_EARLY_PCI? Because then you should put that Kconfig entry in
> a file reachable by all architectures. Say, in init/Kconfig or in
> drivers/tty/serial/Kconfig.
> 
> (You can also have an entry for HAVE_EARLY_PCI for each arch that needs
> it, but that would be a bit silly.)
> 

The HAVE_EARLY_PCI entry should be actually in generic PCI layer,
i.e. drivers/pci, because it's a PCI feature but only some archs
(currently only x86) support it.
Then an arch with this feature could announce it in arch/<arch>/Kconfig by:
select HAVE_EARLY_PCI if PCI
