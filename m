From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 17:16:21 -0400
Message-ID: <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org> <12886761.WF058qtZp8@wuerfel> <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com> <2775954.hrE2UdODgU@wuerfel> <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com> <20160822180254.5c95af7c@lxorguk.ukuu.org.uk> <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com> <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Alan,

>>>> - a child of the uart node
>>>> - a reg property containing the line number if the parent has multiple
>>>> uarts (I'd expect this to rarely be used).  
>>> 
>>> That surprises me as for current x86 platforms it would be the norm,
>>> except that we use ACPI.  
>> 
>> Exactly, we're talking DT bindings here. Each port will be a separate
>> node otherwise things like serial aliases and stdout-path won't work
>> correctly. Compatible strings for 8250 uarts are for a single port.
>> But if you had h/w such that it has common and per port registers then
>> it may be a single node. I'm not aware of any example offhand (maybe
>> PPC CPM). But it doesn't matter as reg can handle this case just fine
>> if we need to.
> 
> For the tty side by the way here's a first RFC of one approach we could
> take. This should (unless I missed anything) allow the core tty framework
> to be used directly from a kernel created tty object rather than one
> backed by a file.
> 
> commit fcd072e755594f9c9c0533d45223f56f76e3d104
> Author: Alan <alan@linux.intel.com>
> Date:   Mon Aug 22 18:05:56 2016 +0100
> 
>    [RFC] tty_port: allow a port to be opened with a tty that has no file handle
> 
>    Let us create tty objects entirely in kernel space. Untested proposal to
>    show why all the ideas around rewriting half the uart stack are not needed.
> 
>    With this a kernel created non file backed tty object could be used to handle
>    data, and set terminal modes. Not all ldiscs can cope with this as N_TTY in
>    particular has to work back to the fs/tty layer.
> 
>    The tty_port code is however otherwise clean of file handles as far as I can
>    tell as is the low level tty port write path used by the ldisc, the
>    configuration low level interfaces and most of the ldiscs.
> 
>    Currently you don't have any exposure to see tty hangups because those are
>    built around the file layer. However a) it's a fixed port so you probably
>    don't care about that b) if you do we can add a callback and c) you almost
>    certainly don't want the userspace tear down/rebuild behaviour anyway.
> 
>    This should however be sufficient if we wanted for example to enumerate all
>    the bluetooth bound fixed ports via ACPI and make them directly available.
> 
>    It doesn't deal with the case of a user opening a port that's also kernel
>    opened and that would need some locking out (so it returned EBUSY if bound
>    to a kernel device of some kind). That needs resolving along with how you
>    "up" or "down" your new bluetooth device, or enumerate it while providing
>    the existing tty API to avoid regressions (and to debug).

why would we even have it create a /dev/ttyX for these devices in the first place. Lets just not create an uevent for it and lets not create a dev_t for it.

The Bluetooth power on (aka hciconfig hci0 up/down) is already solved with modern Intel and Broadcom UART drivers. Essentially we attach the ldisc and tell it which vendor it is. That is it. Everything else is done inside the kernel from that point on.

So attaching the ldisc (via btattach tool) is similar to plugging in a dongle via USB. It runs that basic setup like firmware loading and configuration and then goes back into sleep mode. Only when powering the Bluetooth hciX device up (via bluetoothd or manually) it gets out of sleep mode. And the details for that are left up to the driver.

Internally the setup stage does a hciconfig hci0 up and it is already abstracted out that way. So there has been a lot of work in the Bluetooth subsystem to allow for this. That part is really solved.

Regards

Marcel
