From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD function
Date: Tue, 14 May 2019 10:00:54 +0200
Message-ID: <87bm05mpmx.fsf@haabendal.dk>
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-3-esben@geanix.com> <20190507114905.GB29524@dell>
        <87o94ejwrx.fsf@haabendal.dk> <20190507133844.GA6194@dell>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507133844.GA6194@dell> (Lee Jones's message of "Tue, 7 May
        2019 14:38:44 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Tue, 07 May 2019, Esben Haabendal wrote:
>
>> Lee Jones <lee.jones@linaro.org> writes:
>> 
>> > On Fri, 26 Apr 2019, Esben Haabendal wrote:
>> >
>> >> The serial8250-mfd driver is for adding 8250/16550 UART ports as functions
>> >> to an MFD driver.
>> >> 
>> >> When calling mfd_add_device(), platform_data should be a pointer to a
>> >> struct plat_serial8250_port, with proper settings like .flags, .type,
>> >> .iotype, .regshift and .uartclk.  Memory (or ioport) and IRQ should be
>> >> passed as cell resources.
>> >
>> > What?  No, please!
>> >
>> > If you *must* create a whole driver just to be able to use
>> > platform_*() helpers (which I don't think you should), then please
>> > call it something else.  This doesn't have anything to do with MFD.
>> 
>> True.
>> 
>> I really don't think it is a good idea to create a whole driver just to
>> be able to use platform_get_*() helpers.  And if I am forced to do this,
>> because I am unable to convince Andy to improve the standard serial8250
>> driver to support that, it should be called MFD.  The driver would be
>
> I assume you mean "shouldn't"?

Of-course.

>> generally usable for all usecases where platform_get_*() works.
>> 
>> I don't have any idea what to call such a driver.  It really would just
>> be a fork of the current serial8250 driver, just allowing use of
>> platform_get_*(), supporting exactly the same hardware.
>> 
>> I am still hoping that we can find a way to improve serial8250 to be
>> usable in these cases.
>
> Me too.

Unfortunately, I don't seem to be able to convince Andy to accept
something like that.

I might have to do this out-of-tree :(

/Esben
