From: Sam Povilus <kernel.development@povil.us>
Subject: Re: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
Date: Tue, 23 May 2017 21:27:46 -0600
Message-ID: <20170524032746.43w6b5uut44qzbuc@irascible.povil.us>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
 <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
 <20170522192636.5b578d89@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170522192636.5b578d89@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Michal Simek <michal.simek@xilinx.com>, gregkh@linuxfoundation.org, jslaby@suse.com, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, May 22, 2017 at 07:26:36PM +0100, Alan Cox wrote:
> > We have in soc vendor tree similar patch but the reason is different.
> > 
> >     tty: serial: Added a CONFIG_SERIAL_XILINX_NR_UARTS option.
> > 
> >     This patch Adds CONFIG_SERIAL_XILINX_NR_UARTS option to allow
> >     the user to provide the Max number of uart ports information.
> >     If multiple cards (or) PL UARTS are present, the default limit
> >     of 2 ports should be increased.
> > 
> > I haven't checked all drivers but in our case we have added this as
> > quick fix for scenarios where you use serial aliases where alias is
> > pointed to serial2 or more.
> > In cdns_uart_init() cdns_uart_uart_driver is passed which contains .nr
> > which is required to be passed.
> > 
> > What's the best driver to look at dynamic allocation?
> 
> So there are quite a few that dynamically allocate the objects as they
> are enumerated (eg max3100), but have a maximum set that is just pointers
> (so for the max number of ports cheaper than the dynamic code)
> 
> The other question is why is it a CONFIG_ option. I'm assuming these
> platforms are all ARM and in that case you could just pass the value in
> the device tree, or hard code a safe maximum number of pointers to a
> value which is the worst case and then install them as they are
> enumerated.
> 
> There are lots of options better than breaking the "one kernel many
> platforms" model.
> 
> Alan


I guess I'm confused how this isn't a better solution than what we have
now, or how it breaks the "one kernel many platforms model".

I agree that it is not the best solution, certainly this driver should be
re-written to use the device tree and dynamic allocation, but that is
not the patch being offered at this time.

This is a very minor module buried deep in the drivers tree. I guess I
don't understand how allowing users to choose how many UARTS they might
want to implement breaks the "one kernel" model. The users of this module
and those like it do not use a pre-compiled kernel and customize their
kernels extensively.

Is there some documentation online I could read that explains this "one
kernel many platforms" model? Specifically how it pertains to FPGAs? I
am but a humble embedded developer trying to make the kernel more useful
to myself (and hopefully others), and I think I might have a limited
worldview that restricts my ability to see the full picture and I would
like to learn.
