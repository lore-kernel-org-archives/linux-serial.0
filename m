From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 23:46:10 +0100
Message-ID: <20160822234610.39d33dda@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <12886761.WF058qtZp8@wuerfel>
        <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
        <2775954.hrE2UdODgU@wuerfel>
        <20160822164533.688a6aec@lxorguk.ukuu.org.uk>
        <FAD4CEF6-93F4-41D1-915E-823867F740F7@holtmann.org>
        <20160822220313.wc47q7c4vub2cxmt@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822220313.wc47q7c4vub2cxmt@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> It's not enough to automatically set a ldisc. There is also need for
> additional resouces. For example the Nokia bluetooth driver needs
> some extra GPIOs. The same is true for the in-tree hci_bcm, which
> misuses the platform_device exactly like Greg doesn't want it.

This is one of those cases where ACPI gets it right. For the device tree
case you will also need to describe the GPIO lines as part of your power
management for that slave device.

> I think the problem with line disciplines is, that they do
> not follow the Linux device model. UART slaves may have extra

They follow it exactly.

You have a tty_port which wraps a device, and has the lifetime of the
hardware and lives on busses and can support enumeration.

You have a tty which is a file system object with a lifetime determined
by the use of the file handle, it's like any other file->private_data but
quite complex because we must comply with POSIX and historic Unix tty
behaviour.

You have an ldisc, which is simply a modularisation of the current
protocol handler and is carefully engineered not to include any device
specific knowledge. That's how you make it scale and actually work sanely.

> resources like gpios or regulators. 

Any resources belong to the tty_port or a child of the tty_port because
only it has the correct lifetime. And yes it's perfectly reasonable for
us to attach other resources to a tty_port or give it a child that is the
device the other end of the fixed link. Everything the DT describes
belongs hanging off the tty_port or a child thereof.

We don't get this problem in ACPI space in general because as far as ACPI
is concerned the tty has a child device and the child device describes
its own power management so you just power the child on or off through
ACPI and ACPI describes power sanely.

Eveything you have that is device specific belongs in the tty_port driver
for that hardware, or maybe shared library helpers if common.

Everything you have which involves invoking device defined policy
according to protocol defined behaviour belongs in the ldisc.

Unix has worked like this for well over 30 years and it works very well
as a model.

Alan
