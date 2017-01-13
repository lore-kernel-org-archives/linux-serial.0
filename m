From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 8/9] serdev: add a tty port controller driver
Date: Fri, 13 Jan 2017 09:28:07 -0600
Message-ID: <CAL_JsqKjKz2=vWTBmzp9E3HrzJRszpq2hV4gsxcvnkTgRLH1QQ@mail.gmail.com>
References: <20170106162635.19677-1-robh@kernel.org> <20170106162635.19677-9-robh@kernel.org>
 <1483798314.26691.3.camel@linux.intel.com> <CAL_JsqJtJaadieC2PSe6YV9pvvv8TXTM-hSDR5MZR+n-aRWo1g@mail.gmail.com>
 <1484319863.2133.110.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484319863.2133.110.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 13, 2017 at 9:04 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, 2017-01-12 at 10:01 -0600, Rob Herring wrote:
>> On Sat, Jan 7, 2017 at 8:11 AM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > On Fri, 2017-01-06 at 10:26 -0600, Rob Herring wrote:
>> > > Add a serdev controller driver for tty ports.
>> > >
>> > > The controller is registered with serdev when tty ports are
>> > > registered
>> > > with the TTY core. As the TTY core is built-in only, this has the
>> > > side
>> > > effect of making serdev built-in as well.
>> > >
>> > >
>> > > +if SERIAL_DEV_BUS
>> > > +
>> > > +config SERIAL_DEV_CTRL_TTYPORT
>> > > +     bool "Serial device TTY port controller"
>> > > +     depends on TTY
>> > > +     depends on SERIAL_DEV_BUS=y
>> >
>> > Do you need one?
>>
>> Yes, otherwise the bus can be built as a module and this driver can
>> still be enabled breaking the build. I could drop supporting building
>> the bus as a module because as long as this is the only controller
>> driver, it all has to be built-in.
>
> Would
>
> if SERIAL_DEV_BUS=y
>
> work for you?

Yes, until we add a driver that doesn't have to be built-in. What
about "depends on SERIAL_DEV_BUS != m"? That would be a bit more clear
what the reason is.

Rob
