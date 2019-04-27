From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
Date: Sat, 27 Apr 2019 10:58:42 +0200
Message-ID: <87tvejakot.fsf@haabendal.dk>
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-2-esben@geanix.com>
        <20190426143946.GX9224@smile.fi.intel.com>
        <871s1og11u.fsf@haabendal.dk>
        <20190426215103.GD9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426215103.GD9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Sat, 27 Apr 2019 00:51:03 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, He Zhe <zhe.he@windriver.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Fri, Apr 26, 2019 at 10:40:37AM +0200, Esben Haabendal wrote:
>> >> With serial8250_register_8250_port() forcing UPF_BOOT_AUTOCONF bit on, it
>> >> is not possible to register a port without having
>> >> serial8250_request_std_resource() called.
>> >> 
>> >> For adding a 8250 port to an MFD device, this is problematic, as the
>> >> request_mem_region() call will fail, as the MFD device (and rightly  so)
>> >> has requested the region.  For this case, the 8250 port should accept
>> >> having passed mapbase and membase, and just use that.
>> >
>> > You need to simple set port type and use UPF_FIXED_TYPE.
>> > No need for this patch.
>> 
>> The reason for this patch is to be able to do exactly that (set port
>> type and UPF_FIXED_TYPE) without having UPF_BOOT_AUTOCONF added.
>> 
>> In the current serial8250_register_8250_port() there is:
>> 
>>     uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
>> 
>> So, even though I set UPF_FIXED_TYPE, I get
>> UPF_FIXED_TYPE|UPF_BOOT_AUTOCONF. 
>
> Yes.
>
>> So I need this patch.
>
> Why? I don't see any problems to have these flags set.

The problem with having UPF_BOOT_AUTOCONF is the call to
serial8250_request_std_resource().  It calls request_mem_region(), which
fails if the MFD driver already have requested the memory region for the
MFD device.  And I believe that is a valid thing to do.

To workaround this, I first thought I could just avoid setting
port->mapbase, causing serial8250_request_std_resource() to be a no-op.
But this breaks with more than one UART port, as uart_match_port() will
match the same line for all such UART ports, causing all but the last
one to be removed.

That said, the purpose of UPF_BOOT_AUTOCONF (for 8250 driver) is to
request and map the register memory.  So when that is already done by
the parent MFD driver, I think it is silly to workaround problems caused
by UPF_BOOT_AUTOCONF being force setted, when it really shouldn't.

> Moreover, some drivers
> are used as MFD counterparts with exactly same bits set.
>
>> I think it is unfortunate that UPF_BOOT_AUTOCONF is or'ed to flags like
>> that, but changing that will surely break stuff.
>
> True.
