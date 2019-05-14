From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Date: Tue, 14 May 2019 15:38:43 +0300
Message-ID: <20190514123843.GC9224@smile.fi.intel.com>
References: <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
 <20190507093239.GB4529@dell>
 <87sgtqjy3l.fsf@haabendal.dk>
 <20190507115325.GV9224@smile.fi.intel.com>
 <87k1f2jvyd.fsf@haabendal.dk>
 <20190507150847.GW9224@smile.fi.intel.com>
 <87k1etmrfk.fsf@haabendal.dk>
 <CAHp75VfrP6SLVzmp6LepN7dU1c7QYxfRDRtj7dCTuWzmYp2tCA@mail.gmail.com>
 <871s11meg3.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871s11meg3.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: Lee Jones <lee.jones@linaro.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 14, 2019 at 02:02:36PM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Tue, May 14, 2019 at 10:24 AM Esben Haabendal <esben@haabendal.dk> wrote:
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> > On Tue, May 07, 2019 at 02:22:18PM +0200, Esben Haabendal wrote:
> >
> >> We are on repeat here.  I don't agree with you here.  I have a simple
> >> generic 8250 (16550A) compatible device, and cannot use it in a mfd
> >> driver using the standard mfd-core framework.
> >
> >> The lacking of support for platform_get_resource() in the generic
> >> serial8250 driver is not a feature.  It should be supported, just as it
> >> is in several of the specialized 8250 drivers.
> >
> > We are going circles here.
> > What exactly prevents you to use it? Presence of request_mem_region()?
> 
> Exactly.

And I completely tired to repeat that this is okay and does not prevent you to
use MFD.

> >> It would still mean that I would have revert to not using convenient and
> >> otherwise fully appropriate API calls like pci_request_regions() and
> >> mfd_add_devices().
> >
> > Yes, here is the issue. 8250 requires the parent not to *request*
> > resources. Because child handles IO access itself.
> 
> Ok, clearly we are not discussing the actual IO access.  The only issue
> is how to handle the memory resource management.
> 
> And yes, serial8250 requires "the parent" to not request the resources.
> But by doing so, it gets in the way of the mfd-core way of splitting a
> properly requested resource.

Which is right thing to do. Requesting resources should be done by their actual
user, no?

Moreover, if you look at /proc/iomem, for example, I bet there will be
a difference with your proposed method and a established one.

> >> The mfd driver in question is for a PCI device.  Not being able to
> >> request the PCI regions seems silly.
> >
> > Nope. Otherwise, the parent which *doesn't handle* IO on behalf of
> > child should not request its resources.
> 
> If I may, could I get you to discuss this with Lee Jones?
> 
> As I read both of your comments in this thread, you are not aligned on
> how mfd drivers should handle resources.  And in that case, one of you
> are most likely more right than the other, and if Lee is right, I seem
> to be unable to convince you about that.

MFD has nothing to do with *requesting* resource. It's about *slicing* them.
*Requesting* resource is orthogonal to the *slicing*.

> >> Not being able to register all child devices with the call introduced
> >> for that sole purpose also seems silly.
> >
> >> Please take a look at https://lkml.org/lkml/2019/4/9/576
> >> ("[PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip")
> >
> > Thank you for this link.
> > Now, look at this comment:
> >
> > + /*
> > + * Map all IOC3 registers.  These are shared between subdevices
> > + * so the main IOC3 module manages them.
> > + */
> >
> > Is it your case? Can we see the code?
> 
> That comment seems quite misleading.  I am quote certain that the uart
> registers which are part of BAR 0 is not more shared between subdevices
> than the uart registers in BAR 0 in my case.
> 
> But BAR 0 as a whole is shared between subdevices.  But BAR 0 can be
> (is) split in parts that are exclusive to one subdevice.  The only
> difference I see is that I don't have any registers accessed directly by
> the mfd driver.

I stopped here. Let's discuss an actual code.

-- 
With Best Regards,
Andy Shevchenko
