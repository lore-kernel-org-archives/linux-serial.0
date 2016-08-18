From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 13:41:40 +0200
Message-ID: <07FF6D1B-7B9B-441C-AFB9-E06AC5F469E2@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org> <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com> <28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org> <EE9DA3F6-382C-4930-8511-8D1C9A7D1E77@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EE9DA3F6-382C-4930-8511-8D1C9A7D1E77@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Nikolaus,

>>>> Currently, devices attached via a UART are not well supported in the
>>>> kernel. The problem is the device support is done in tty line disciplines,
>>>> various platform drivers to handle some sideband, and in userspace with
>>>> utilities such as hciattach.
>>>> 
>>>> There have been several attempts to improve support, but they suffer from
>>>> still being tied into the tty layer and/or abusing the platform bus. This
>>>> is a prototype to show creating a proper UART bus for UART devices. It is
>>>> tied into the serial core (really struct uart_port) below the tty layer
>>>> in order to use existing serial drivers.
>>>> 
>>>> This is functional with minimal testing using the loopback driver and
>>>> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the slave
>>>> device). It still needs lots of work and polish.
>>>> 
>>>> TODOs:
>>>> - Figure out the port locking. mutex plus spinlock plus refcounting? I'm
>>>> hoping all that complexity is from the tty layer and not needed here.
>>>> - Split out the controller for uart_ports into separate driver. Do we see
>>>> a need for controller drivers that are not standard serial drivers?
>>>> - Implement/test the removal paths
>>>> - Fix the receive callbacks for more than character at a time (i.e. DMA)
>>>> - Need better receive buffering than just a simple circular buffer or
>>>> perhaps a different receive interface (e.g. direct to client buffer)?
>>>> - Test with other UART drivers
>>>> - Convert a real driver/line discipline over to UART bus.
>>>> 
>>>> Before I spend more time on this, I'm looking mainly for feedback on the
>>>> general direction and structure (the interface with the existing serial
>>>> drivers in particular).
>>> 
>>> Some quick comments (can't do any real life tests in the next weeks) from my (biased) view:
>>> 
>>> * tieing the solution into uart_port is the same as we had done. The difference seems to
>>> me that you completely bypass serial_core (and tty) while we want to integrate it with standard tty operation.
>>> 
>>> We have tapped the tty layer only because it can not be 100% avoided if we use serial_core.
>>> 
>>> * one feedback I had received was that there may be uart device drivers not using serial_core. I am not sure if your approach addresses that.
>>> 
>>> * what I don't see is how we can implement our GPS device power control driver:
>>> - the device should still present itself as a tty device (so that cat /dev/ttyO1 reports NMEA records) and should
>>>  not be completely hidden from user space or represented by a new interface type invented just for this device
>>>  (while the majority of other GPS receivers are still simple tty devices).
>>> - how we can detect that the device is sending data to the UART while no user space process has the uart port open
>>>  i.e. when does the driver know when to start/stop the UART.
>> 
>> I am actually not convinced that GPS should be represented as /dev/ttyS0 or similar TTY. It think they deserve their own driver exposing them as simple character devices. That way we can have a proper DEVTYPE and userspace can find them correctly. We can also annotate them if needed for special settings.
> 
> Yes, we can. But AFAIK no user space GPS client is expecting to have a new DEVTYPE.

but we can fix userspace clients to deal with DEVTYPE.

> I have several different GPS devices. One is by bluetooth. So I get a /dev/tty through hci. Another one has an USB cable. I get a /dev/tty through some USB serial converter. A third one is integrated in a 4G modem which provides a /dev/ttyACM port. So I always get something which looks like a /dev/tty... Seems to be pretty standard.

Actually for Bluetooth RFCOMM it would be a lot better to use the RFCOMM socket instead of the TTY emulation. However that said, Bluetooth RFCOMM is already split in a way that you can have either a socket or a TTY emulation. There is nothing stopping us from adding a GPS emulation and with that natively hooking it up to a future GPS driver. I mean why not have a GPS subsystem that allows for that. I know this is future talk, but it can be done.

Same goes for the USB GPS devices that use a serial converter. If they use proper VID:PID or some sort of identification, we can have a dedicated USB driver that matches it to a GPS device. At the end of the day, the only difference for the usb-serial driver is if it registers a TTY or a future GPS device.

The 4G modem ones are a bit funky. Not all of them expose a ttyACM port btw. Some of them have the NMEA via Qualcomm QMI or some other channel. So inside oFono we have abstracted that into a file descriptor so that power control etc. is handled by oFono. Since you need to use the telephony stack to control the GPS state. But again here, there is nothing stopping us from moving parts of QMI into the kernel. We have done that for the Nokia ISI and the ST-Ericsson CAIF already.

However honestly, my main focus would be to get Bluetooth UARTs integrated natively without line discipline before I would worry about GPS.

> Yes it would be nice to have a /dev/gps2 device.
> 
> And how do you want to control if the gps device should send records with cr / lf (INLCR, IGNCR)? Can you use tcsetattr?

That needs to be seen. In general NMEA does not need it. However there is more than NMEA out there. Maybe it would need to focus on NMEA GPS anyway. As said above, oFono just hands out the NMEA sentences for QMI devices via file descriptor. So I am not sure we need to control that much.

I mean with Bluetooth we have done a bunch of extra framing enforcement so that a read() only returns a full frame. So that userspace applications have it a lot easier and don't have to worry about byte-byte reading. Something similar could be done for GPS NMEA. Anyway, I am just pointing out ideas here. We do not have the UART bus upstream yet.

Regards

Marcel
