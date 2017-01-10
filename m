From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/9] Serial slave device bus
Date: Tue, 10 Jan 2017 11:24:06 -0600
Message-ID: <CAL_JsqJHyQa9zeAzHVatRwWnH04nP35ykDLXD8C_1NSJucrkKA@mail.gmail.com>
References: <20170106162635.19677-1-robh@kernel.org> <1483786850.9552.249.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483786850.9552.249.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 7, 2017 at 5:00 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2017-01-06 at 10:26 -0600, Rob Herring wrote:
>> Here goes another attempt at a serial device bus (aka uart slaves, tty
>> slaves, etc.).
>>
>> After some discussions with Dmitry at LPC, I decided to move away from
>> extending serio and moved back to making a new bus type instead. He
>> didn't
>> think using serio was a good fit, and serio has a number of
>> peculiarities
>> in regards to sysfs and it's driver model. I don't think we want to
>> inherit
>> those for serial slave devices.
>>
>> This version sits on top of tty_port rather than uart_port as Alan
>> requested. Once I created a struct tty rather than moving everything
>> needed to tty_port, it became a lot easier and less invasive to the
>> tty
>> core code.
>>
>> I have hacked up versions of the BT ldisc and TI ST drivers moved over
>> to
>> use the serdev bus. I have BT working on the HiKey board which has TI
>> BT.
>> With the serdev bus support, it eliminates the need for the TI
>> userspace
>> UIM daemon.
>>
>> This series and the mentioned drivers can be found here[1].
>
> For patches 1-4:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks.

> Regarding to naming. Why can't we just name bus "serial"? If you are
> worrying about folder name under drivers/tty, I can propose at lease
> couple of options serialdev, serialbus.

Naming is hard, right?

I have don't have too much opinion on what the name should be. I just
came up with something unique and inspired by serio. It is a bit
easier to grep for serdev rather than just serial.

Rob
