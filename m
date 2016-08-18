From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 13:47:44 +0200
Message-ID: <FC7E1385-941F-4CC5-BE3C-A80828370A58@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org> <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com> <28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org> <20160818105521.GB7031@kroah.com> <20160818111046.GE7427@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818111046.GE7427@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, herkne@gmx.de
List-Id: linux-serial@vger.kernel.org

Hi Pavel,

>>> I am actually not convinced that GPS should be represented as
>>> /dev/ttyS0 or similar TTY. It think they deserve their own driver
>>> exposing them as simple character devices. That way we can have a
>>> proper DEVTYPE and userspace can find them correctly. We can also
>>> annotate them if needed for special settings.
>> 
>> I would _love_ to see that happen, but what about the GPS line
>> discipline that we have today?  How would that match up with a char
>> device driver?
> 
> ./drivers/usb/serial/garmin_gps.c ?
> 
> Hmm, some cleanups would be welcome there... plus it would be good to
> know what is its interface to userland... it is not easily apparent
> from the code.

however that driver is not a line discipline. That is just an USB driver. But I agree if we create a GPS driver framework / subsystem, then this one should be converted into using it.

> Actually, having some kind of common support for GPSes in the kernel
> would be nice. (Chardev that spits NMEA data?) For example N900 GPS is
> connected over network (phonet) interface, with userland driver
> translating custom protocol into NMEA. Not very nice from "kernel
> should provide hardware abstraction" point of view.

I agree that if we just had a dedicated GPS NMEA char device, then that would be great. However we might just add an additional /dev/unmea like /dev/uinput, /dev/uhid, /dev/vhci. It could be used for unit testing and also hardware where the protocol is in userspace in the first. Like the mentioned QMI or some Intel AT command based modem. We would then just convert oFono to create the /dev/unmea device for us. The advantage is that then even userspace NMEA device are part of the device tree and enumerated by udev.

Regards

Marcel
