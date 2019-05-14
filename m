From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
Date: Tue, 14 May 2019 09:37:36 +0200
Message-ID: <87ftphmqpr.fsf@haabendal.dk>
References: <20190430140416.4707-1-esben@geanix.com>
        <20190430153736.GL9224@smile.fi.intel.com>
        <874l6efxta.fsf@haabendal.dk>
        <20190502104556.GS9224@smile.fi.intel.com>
        <87pnp11112.fsf@haabendal.dk> <20190507093239.GB4529@dell>
        <87sgtqjy3l.fsf@haabendal.dk>
        <20190507115325.GV9224@smile.fi.intel.com>
        <87k1f2jvyd.fsf@haabendal.dk>
        <20190507150847.GW9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507150847.GW9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Tue, 7 May 2019 18:08:47 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org, Thomas Bogendoerfer <tbogendoerfer@suse.de>
List-Id: linux-serial@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, May 07, 2019 at 02:22:18PM +0200, Esben Haabendal wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Tue, May 07, 2019 at 01:35:58PM +0200, Esben Haabendal wrote:
>> >> Lee Jones <lee.jones@linaro.org> writes:
>> >> > On Thu, 02 May 2019, Esben Haabendal wrote:
>> >> >
>> >> >> Could you help clarify whether or not this patch is trying to do
>> >> >> something odd/wrong?
>> >> >> 
>> >> >> I might be misunderstanding Andy (probably is), but the discussion
>> >> >> revolves around the changes I propose where I change the serial8250
>> >> >> driver to use platform_get_resource() in favour of
>> >> >> request_mem_region()/release_mem_region().
>> >> >
>> >> > Since 'serial8250' is registered as a platform device, I don't see any
>> >> > reason why it shouldn't have the capability to obtain its memory
>> >> > regions from the platform_get_*() helpers.
>> >> 
>> >> Good to hear.  That is exactly what I am trying do with this patch.
>> >> 
>> >> @Andy: If you still don't like my approach, could you please advice an
>> >> acceptable method for improving the serial8250 driver to allow the use
>> >> of platform_get_*() helpers?
>> >
>> > I still don't get why you need this.
>> 
>> Because platform_get_resource() is a generally available and useful
>> helper function for working with platform_device resources, that the
>> current standard serial8250 driver does not support.
>> 
>> I am uncertain if I still haven't convinced you that current serial8250
>> driver does not work with platform_get_resource(), or if you believe
>> that it really should not support it.
>
> I believe there is no need to do this support.
>
> Most of the platform code that uses it is quite legacy, and all under arch/
> ideally should be converted to use Device Tree.

Please take a look at https://lkml.org/lkml/2019/4/9/576
("[PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip")

This is basically what I am trying to do.  I am just so unfortunate that
the serial devices I have are completely generic, so it does not make
sense for me to create a specialized 8250 driver.

Look at how the serial8250_ioc3_driver uses platform_get_resource() to
get the register memory, and how that works together with
mfd_add_devices() in the mfd driver.  Nice and elegant.  Standard
recommended approach for an mfd driver.

/Esben
