From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
Date: Mon, 29 Apr 2019 08:27:56 +0200
Message-ID: <87y33tz5oz.fsf@haabendal.dk>
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-2-esben@geanix.com>
        <20190426143946.GX9224@smile.fi.intel.com>
        <871s1og11u.fsf@haabendal.dk>
        <20190426215103.GD9224@smile.fi.intel.com>
        <87tvejakot.fsf@haabendal.dk>
        <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
        (Andy Shevchenko's message of "Sat, 27 Apr 2019 19:41:10 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, He Zhe <zhe.he@windriver.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Sat, Apr 27, 2019 at 12:01 PM Esben Haabendal <esben@haabendal.dk> wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
>> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> >> The reason for this patch is to be able to do exactly that (set port
>> >> type and UPF_FIXED_TYPE) without having UPF_BOOT_AUTOCONF added.
>> >>
>> >> In the current serial8250_register_8250_port() there is:
>> >>
>> >>     uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
>> >>
>> >> So, even though I set UPF_FIXED_TYPE, I get
>> >> UPF_FIXED_TYPE|UPF_BOOT_AUTOCONF.
>> >
>> > Yes.
>> >
>> >> So I need this patch.
>> >
>> > Why? I don't see any problems to have these flags set.
>>
>> The problem with having UPF_BOOT_AUTOCONF is the call to
>> serial8250_request_std_resource().  It calls request_mem_region(), which
>> fails if the MFD driver already have requested the memory region for the
>> MFD device.
>
> If it's MFD, why it requested the region for its child?
> Isn't it a bug in MFD driver?

It is a PCI driver, which calls pci_request_regions().  The PCI device
carries a lot of different functions, which uses small slices of the PCI
memory region(s).  With the resources being a tree structure, I don't
think it is a bug when a parent driver requests the entire memory
region.

It would be nice if child drivers requesting memory would pass the
parent memory resource.  Maybe 8250 driver could be changed to accept a
struct resource pointer instead of a simple mapbase value, allowing to
setup the resource with parent pointing to the MFD memory resource.

/Esben
