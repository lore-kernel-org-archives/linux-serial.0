From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Date: Tue, 7 May 2019 18:08:47 +0300
Message-ID: <20190507150847.GW9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
 <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
 <20190507093239.GB4529@dell>
 <87sgtqjy3l.fsf@haabendal.dk>
 <20190507115325.GV9224@smile.fi.intel.com>
 <87k1f2jvyd.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k1f2jvyd.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 07, 2019 at 02:22:18PM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Tue, May 07, 2019 at 01:35:58PM +0200, Esben Haabendal wrote:
> >> Lee Jones <lee.jones@linaro.org> writes:
> >> > On Thu, 02 May 2019, Esben Haabendal wrote:
> >> >
> >> >> Could you help clarify whether or not this patch is trying to do
> >> >> something odd/wrong?
> >> >> 
> >> >> I might be misunderstanding Andy (probably is), but the discussion
> >> >> revolves around the changes I propose where I change the serial8250
> >> >> driver to use platform_get_resource() in favour of
> >> >> request_mem_region()/release_mem_region().
> >> >
> >> > Since 'serial8250' is registered as a platform device, I don't see any
> >> > reason why it shouldn't have the capability to obtain its memory
> >> > regions from the platform_get_*() helpers.
> >> 
> >> Good to hear.  That is exactly what I am trying do with this patch.
> >> 
> >> @Andy: If you still don't like my approach, could you please advice an
> >> acceptable method for improving the serial8250 driver to allow the use
> >> of platform_get_*() helpers?
> >
> > I still don't get why you need this.
> 
> Because platform_get_resource() is a generally available and useful
> helper function for working with platform_device resources, that the
> current standard serial8250 driver does not support.
> 
> I am uncertain if I still haven't convinced you that current serial8250
> driver does not work with platform_get_resource(), or if you believe
> that it really should not support it.

I believe there is no need to do this support.

Most of the platform code that uses it is quite legacy, and all under arch/
ideally should be converted to use Device Tree.

> > If it's MFD, you may use "serial8250" with a given platform data like
> > dozens of current users do.
> 
> There is only one in-tree mfd driver using "serial8250", the sm501.c
> driver.  And that driver predates the mfd framework (mfd-core.c) by a
> year, and does not use any of the mfd-core functionality.

So, does it have an issue?

> I want to use the mfd-core provided handling of resource splitting,
> because it makes it easier to handle splitting of a single memory
> resource as defined by a PCI BAR in this case.  And the other drivers I
> need to use all support/use platform_get_resource(), so it would even
> have an impact on the integration of that if I cannot use mfd resource
> splitting with serial8250.

I tired to repeat, that is OKAY! You *may* split and supply resources to the
drivers, nothing prevents you to do that with current code base.

Do you see any problem with that? What is that problem?

If you would like utilize serial8250, just provide a platform data for it.

> > Another approach is to use 8250 library, thus, creating a specific glue driver
> > (like all 8250_* do).
> 
> As mentioned, I think this is a bad approach, and I would prefer to
> improve the "serial8250" driver instead.  But if you insist, what should
> I call such a driver?  It needs a platform_driver name, for use when
> matching with platform_device devices.  And it would support exactly the
> same hardware as the current "serial8250" driver.

If you need some specifics, you create a driver with whatever name
suits the IP in question. Nevertheless, if it's simple generic 8250, nothing
needs to be added, except platform data, see above.

> > Yes, I understand that 8250 driver is full of quirks and not modern approaches
> > to do one or another thing. Unfortunately it's not too easy to fix it without
> > uglifying code and doing some kind of ping-pong thru the conversion. I don't
> > think it worth to do it in the current state of affairs. Though, cleaning up
> > the core part from the quirks and custom pieces would make this task
> > achievable.
> 
> I think it should be possible and worthwhile to improve serial8250
> driver with support for using platform_device resources
> (platform_get_resource() helper).

I simple can't understand why it's needed. What problem would it solve which
can't be solved with existing code base?

> If we could stop discussing if it is a proper thing to do, we could try
> to find a good way to do it instead.

> > Btw, what exact IP of UART do you have implemented there?
> 
> It is an XPS 16550 UART (v3.00a).
> https://www.xilinx.com/support/documentation/ip_documentation/xps_uart16550.pdf

So, briefly looking at it I didn't find any deviations from a standard 16550a.

Also there are two drivers mentioned Xilinx, though I'm pretty sure it's not
your case.

Since you have more than one of them, it's even smaller to use current
infrastructure to enumerate them using only one serial8250 description.
See plenty examples in the Linux kernel, such as 8250_exar_st16c554.c.
That is what you may just modify for your needs and put inside your MFD.

-- 
With Best Regards,
Andy Shevchenko
