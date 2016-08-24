From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Wed, 24 Aug 2016 14:57:14 +0100
Message-ID: <20160824145714.02bbebb3@lxorguk.ukuu.org.uk>
References: <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
        <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
        <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
        <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk>
        <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org>
        <20160822223223.398ee72d@lxorguk.ukuu.org.uk>
        <20160822220017.GA10689@amd>
        <20160822235414.4b2f8712@lxorguk.ukuu.org.uk>
        <20160822235758.gh33xupgyroye5wa@earth>
        <20160823011521.0ed94283@lxorguk.ukuu.org.uk>
        <20160823005749.io6x4oi7muttkhfx@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160823005749.io6x4oi7muttkhfx@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> So you mean if I do "hciconfig hci0 down", then the uart-bus should
> "down" the tty and only on "hciconfig hci0 up" it should "up" the
> tty? I would expect a uart-bus slave-device takes control of the
> device ("up" it) on probe. It's hardwired anyway.

Today you can switch stacks at runtime, you can switch between the kernel
stack and debug tools at runtime. Breaking that is a regression.

> Also what should happen if old userspace use hciattach while
> uart-bus slave-device doesn't have control over it? Do you

You would either use the old hciattach in which case you wouldn't be able
to manage it via a new API while attached, or the new API in which case
you wouldn't be able to manage it via the old interface while it was
being used directly.

> Or do you suggest to register hci1 and one cannot use hci0? I guess
> this breaks even more devices, as the device number changes.

Device numbers are dynamic anyway. Plug a USB adapter in and if it beats
your onboard adapter to registration then the order changes.

> So yes, from your point of view there is a regression, just because
> it's working automatically. So let's just not convert existing boards
> with working hciattach based bluetooth devices. New devices can use

>From a distribution point of view that would be a nightmare.

> the uart-bus, as it's not a regression for them and Nokia N series
> can also do it, since they have no working bluetooth at all at the
> moment.

The Nokia N series is a weird corner case.

> > In many cases you'll also still need the tty interface to do
> > things like firmware upgrades.  
> 
> I would expect the uart-slave driver to know how to do firmware
> updates. Actually most bluetooth chips are initialized by uploading
> a firmware to them.

Usually no - you don't want a ton of kernel code for flashing adapters
when they have built in firmware (similar issue for 3G modems)

> And there are definitely uart drivers not caring about having a tty
> device. Nokia's vendor driver for their bluetooth protocol contains
> a custom omap-serial driver combined with the actual bluetooth
> driver. There is nothing related to the tty framework. I think the
> same would work for the other hardwired bluetooth chips perfectly
> fine.

That means having two different omap serial drivers to maintain which is
not ideal.

To me there are four different things

1. bluetooth devices "just work". That can be user space (eg it seems to
just work on my Fedora boxes and bluetooth enumeration is being done via
user space, or may be via kernel enumeration, or a mix. PPP is an
existing example of this - serial port PPP is an ldisc but ports that are
not UART like speak directly to the PPP layer as network adapters.

2. Sideband controls and power management, where we need to give the
tty_port a child device and power it up/down properly and have the
tty_port hooks to do so based upon the ldisc protocol state machine when
talking stuff like NMEA or HCI.

3. The special case UART power saving features/hacks like GPIO snooping,
again with the right hooks

4. Whether it's useful to be able to create a tty device in kernel and
attach that to stuff with no userspace involved.

All are independent.

Alan
