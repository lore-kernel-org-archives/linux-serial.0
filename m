From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
Date: Mon, 06 May 2019 17:19:27 +0200
Message-ID: <87imunobk0.fsf@haabendal.dk>
References: <20190430140416.4707-1-esben@geanix.com>
        <a535c7b6-54e0-ab58-7626-f7f631773c18@metux.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a535c7b6-54e0-ab58-7626-f7f631773c18@metux.net> (Enrico
        Weigelt's message of "Thu, 2 May 2019 21:41:01 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

"Enrico Weigelt, metux IT consult" <lkml@metux.net> writes:

> On 30.04.19 16:04, Esben Haabendal wrote:
>> Allow getting memory resource (mapbase or iobase) as well as irq from
>> platform_device resources.
>> 
>> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
>> resources are to be used.  When not set, driver behaves as before.
>> 
>> This allows use of the serial8250 driver together with devices with
>> resources added by platform_device_add_resources(), such as mfd child
>> devices added with mfd_add_devices().
>
> I like the idea (actually, quite the direction I'd like to go), but
> unfortunately it's more compilicated than that.
>
> Some drivers don't use these fields, eg. 8250 determines the mapsize
> based on several factors, at the time of the mapping is done. That's
> one of the things my patches shall clean up.

Could you take a quick look at my patch again.  The patch only changes
the probe method in the serial8250_isa_driver in 8250_core.c file.

So other drivers are not affected by this change.

And with the addition of the new UPF_DEV_RESOURCES flag, no existing
platforms should be affected either.

The patch merely makes it possible to start using plain "serial8250"
driver (serial8250_isa_driver) with standard platform resources, fx. as
implemented by mfd-core.

/Esben
