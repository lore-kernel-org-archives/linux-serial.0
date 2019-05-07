From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
Date: Tue, 07 May 2019 13:32:41 +0200
Message-ID: <87woj2jy92.fsf@haabendal.dk>
References: <20190430140416.4707-1-esben@geanix.com>
        <20190430153736.GL9224@smile.fi.intel.com>
        <874l6efxta.fsf@haabendal.dk>
        <20190502104556.GS9224@smile.fi.intel.com>
        <87pnp11112.fsf@haabendal.dk> <20190507093239.GB4529@dell>
        <20190507093631.GC4529@dell>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507093631.GC4529@dell> (Lee Jones's message of "Tue, 7 May
        2019 10:36:31 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Tue, 07 May 2019, Lee Jones wrote:
>> On Thu, 02 May 2019, Esben Haabendal wrote:
>> 
>> > Could you help clarify whether or not this patch is trying to do
>> > something odd/wrong?
>> > 
>> > I might be misunderstanding Andy (probably is), but the discussion
>> > revolves around the changes I propose where I change the serial8250
>> > driver to use platform_get_resource() in favour of
>> > request_mem_region()/release_mem_region().
>> 
>> Since 'serial8250' is registered as a platform device, I don't see any
>> reason why it shouldn't have the capability to obtain its memory
>> regions from the platform_get_*() helpers.
>
> Not sure which device you're trying to enable, but if it's booted
> using Device Tree, you could always use 'of_serial'.

It is an x86_64 platform, so there is unfortunately no device tree.

> It does seem a little odd that the 'serial8250' IP block has been
> incorporated into an MFD.  Which device is it you're trying to enable
> exactly? 

It is a Xilinx FPGA, containing a number of different devices, including
5 16550A UART devices (XPS 16550 UART v3.00a).  It also contains 3
Ethernet interfaces and a number of custom IP blocks.

The FPGA is connected to the CPU using PCIe, with all devices using
parts of a big common io memory block, specified by a PCI BAR.

/Esben
