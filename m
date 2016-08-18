From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 13:51:41 +0200
Message-ID: <00D14BD1-B1DA-4242-B2F6-54F70CF72EF1@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org> <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com> <28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org> <20160818105521.GB7031@kroah.com> <6A3D5EFF-AC8B-4039-AFF8-652687EB8EDA@holtmann.org> <20160818112435.GA20876@kroah.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160818112435.GA20876-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

>>>>>> Currently, devices attached via a UART are not well supported in the
>>>>>> kernel. The problem is the device support is done in tty line disciplines,
>>>>>> various platform drivers to handle some sideband, and in userspace with
>>>>>> utilities such as hciattach.
>>>>>> 
>>>>>> There have been several attempts to improve support, but they suffer from
>>>>>> still being tied into the tty layer and/or abusing the platform bus. This
>>>>>> is a prototype to show creating a proper UART bus for UART devices. It is
>>>>>> tied into the serial core (really struct uart_port) below the tty layer
>>>>>> in order to use existing serial drivers.
>>>>>> 
>>>>>> This is functional with minimal testing using the loopback driver and
>>>>>> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the slave
>>>>>> device). It still needs lots of work and polish.
>>>>>> 
>>>>>> TODOs:
>>>>>> - Figure out the port locking. mutex plus spinlock plus refcounting? I'm
>>>>>> hoping all that complexity is from the tty layer and not needed here.
>>>>>> - Split out the controller for uart_ports into separate driver. Do we see
>>>>>> a need for controller drivers that are not standard serial drivers?
>>>>>> - Implement/test the removal paths
>>>>>> - Fix the receive callbacks for more than character at a time (i.e. DMA)
>>>>>> - Need better receive buffering than just a simple circular buffer or
>>>>>> perhaps a different receive interface (e.g. direct to client buffer)?
>>>>>> - Test with other UART drivers
>>>>>> - Convert a real driver/line discipline over to UART bus.
>>>>>> 
>>>>>> Before I spend more time on this, I'm looking mainly for feedback on the
>>>>>> general direction and structure (the interface with the existing serial
>>>>>> drivers in particular).
>>>>> 
>>>>> Some quick comments (can't do any real life tests in the next weeks) from my (biased) view:
>>>>> 
>>>>> * tieing the solution into uart_port is the same as we had done. The difference seems to
>>>>> me that you completely bypass serial_core (and tty) while we want to integrate it with standard tty operation.
>>>>> 
>>>>> We have tapped the tty layer only because it can not be 100% avoided if we use serial_core.
>>>>> 
>>>>> * one feedback I had received was that there may be uart device drivers not using serial_core. I am not sure if your approach addresses that.
>>>>> 
>>>>> * what I don't see is how we can implement our GPS device power control driver:
>>>>> - the device should still present itself as a tty device (so that cat /dev/ttyO1 reports NMEA records) and should
>>>>>  not be completely hidden from user space or represented by a new interface type invented just for this device
>>>>>  (while the majority of other GPS receivers are still simple tty devices).
>>>>> - how we can detect that the device is sending data to the UART while no user space process has the uart port open
>>>>>  i.e. when does the driver know when to start/stop the UART.
>>>> 
>>>> I am actually not convinced that GPS should be represented as
>>>> /dev/ttyS0 or similar TTY. It think they deserve their own driver
>>>> exposing them as simple character devices. That way we can have a
>>>> proper DEVTYPE and userspace can find them correctly. We can also
>>>> annotate them if needed for special settings.
>>> 
>>> I would _love_ to see that happen, but what about the GPS line
>>> discipline that we have today?  How would that match up with a char
>>> device driver?
>> 
>> we have a GPS line discipline? What is that one doing? As far as I
>> know all GPS implementations are fully userspace.
> 
> Hm, for some reason I thought that was what n_gsm.c was being used for,
> but I could be wrong, I've never seen the hardware that uses that
> code...

the n_gsm.c is for 3GPP TS 07.10. Which is a TTY multiplexer. Has nothing to do with GPS.

Regards

Marcel
