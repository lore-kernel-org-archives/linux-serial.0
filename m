From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v3 1/2] serial_core: add pci uart early console support
Date: Wed, 20 May 2015 11:16:25 +0200
Message-ID: <1432113385.21715.76.camel@x220>
References: <20150518212152.GA95407@worksta> <1432036867.9091.75.camel@x220>
	 <20150519173224.GA202975@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150519173224.GA202975@worksta>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-05-19 at 10:32 -0700, Bin Gao wrote:
> On Tue, May 19, 2015 at 02:01:07PM +0200, Paul Bolle wrote: 
> > Is this expected to be used outside of X86?
> Yes, drivers/tty/serial/serial_core.c is going to use it.

What I should have asked is: do you expect architectures other than X86
to set HAVE_EARLY_PCI? Because then you should put that Kconfig entry in
a file reachable by all architectures. Say, in init/Kconfig or in
drivers/tty/serial/Kconfig.

(You can also have an entry for HAVE_EARLY_PCI for each arch that needs
it, but that would be a bit silly.)

Thanks,


Paul Bolle
