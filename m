From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
Date: Mon, 29 Apr 2019 08:37:59 +0200
Message-ID: <87tvehz588.fsf@haabendal.dk>
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-2-esben@geanix.com>
        <20190426143946.GX9224@smile.fi.intel.com>
        <871s1og11u.fsf@haabendal.dk>
        <20190426215103.GD9224@smile.fi.intel.com>
        <87tvejakot.fsf@haabendal.dk>
        <7a1fd6cc-050f-a077-6169-03552a89c563@metux.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7a1fd6cc-050f-a077-6169-03552a89c563@metux.net> (Enrico
        Weigelt's message of "Sat, 27 Apr 2019 13:57:57 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, He Zhe <zhe.he@windriver.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

"Enrico Weigelt, metux IT consult" <lkml@metux.net> writes:

> On 27.04.19 10:58, Esben Haabendal wrote:
>
> Hi folks,
>
>> That said, the purpose of UPF_BOOT_AUTOCONF (for 8250 driver) is to
>> request and map the register memory.  So when that is already done by
>> the parent MFD driver, I think it is silly to workaround problems
>> caused by UPF_BOOT_AUTOCONF being force setted, when it really
>> shouldn't.
> I tend to agree. Maybe we should give serial8250_register_8250_port()
> some flags for controlling this, or add another function for those
> cases.

Changing serial8250_register_8250_port() would break existing drivers,
as I have seen that some explicitly rely on the automtic addition of
UPF_BOOT_AUTOCONF.

> A minimal-invasive approach could be introducing an
> serial8250_register_8250_port_ext() with extra parameters, and let
> serial8250_register_8250_port() just call it.

So basically a rename of __serial8250_register_8250_port() in my patch
to serial8250_register_8250_port_ext()?  Fine with me.  Should we give
it an EXPORT_SYMBOL() also, as it is just as valid to use in modules as
the current serial8250_register_8250_port()?

/Esben
