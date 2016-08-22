From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 11:28:02 -0400
Message-ID: <EBCC7C4D-92E0-4EC7-9C81-4E859E511C88@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org> <12886761.WF058qtZp8@wuerfel> <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com> <2775954.hrE2UdODgU@wuerfel>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2775954.hrE2UdODgU@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

>>> My impression is that there is some overlap in what you want
>>> to do here, and what serio does today as a line discipline on top
>>> of a tty line discipline (and on top of other non-uart serial
>>> connections), so we should look into whether the two can be unified
>>> or not. Here is what I found so far:
>>> 
>>> For all I can tell, serio is only used for drivers/input/ but could
>>> easily be extended to other subsystems. It currently uses its own
>>> binary ID matching between drivers and devices through user space
>>> interfaces, though adding a DT binding for it would appear to be
>>> a good idea regardless.
>>> 
>>> It also has a bus_type already, and with some operations defined on
>>> it. In particular, it has an "interrupt" method that is used to
>>> notify the client driver when a byte is available (and pass
>>> that byte along with it). This seems to be a useful addition to
>>> what you have. Since it is based on sending single characters
>>> both ways, transferring large amounts of data would be slower,
>>> but the interface is somewhat simpler. In principle, both
>>> character based and buffer based interfaces could coexist here
>>> as they do in some other interfaces (e.g. smbus).
>> 
>> Given that about the only things it really provided are the bus_type
>> and associated boilerplate without much of a client interface, it
>> seemed to me that creating a new subsystem first made more sense. Then
>> we can convert serio to use the new subsystem.
> 
> One possible downside of merging later is that we end up having to
> support the existing user space ABI for serio that may not fit well
> within whatever we come up with independently.

if we need any kind of userspace ABI to setup of Bluetooth over UART devices, then we have failed. We want that the special UARTs are identified via ACPI or DT and become an enumeratable bus. So we can attach a driver to it.

Regards

Marcel
