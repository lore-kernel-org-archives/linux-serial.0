From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 13:24:35 +0200
Message-ID: <20160818112435.GA20876@kroah.com>
References: <20160818011445.22726-1-robh@kernel.org>
 <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
 <28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org>
 <20160818105521.GB7031@kroah.com>
 <6A3D5EFF-AC8B-4039-AFF8-652687EB8EDA@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6A3D5EFF-AC8B-4039-AFF8-652687EB8EDA@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 18, 2016 at 01:01:24PM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> >>>> Currently, devices attached via a UART are not well supported in the
> >>>> kernel. The problem is the device support is done in tty line disciplines,
> >>>> various platform drivers to handle some sideband, and in userspace with
> >>>> utilities such as hciattach.
> >>>> 
> >>>> There have been several attempts to improve support, but they suffer from
> >>>> still being tied into the tty layer and/or abusing the platform bus. This
> >>>> is a prototype to show creating a proper UART bus for UART devices. It is
> >>>> tied into the serial core (really struct uart_port) below the tty layer
> >>>> in order to use existing serial drivers.
> >>>> 
> >>>> This is functional with minimal testing using the loopback driver and
> >>>> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the slave
> >>>> device). It still needs lots of work and polish.
> >>>> 
> >>>> TODOs:
> >>>> - Figure out the port locking. mutex plus spinlock plus refcounting? I'm
> >>>> hoping all that complexity is from the tty layer and not needed here.
> >>>> - Split out the controller for uart_ports into separate driver. Do we see
> >>>> a need for controller drivers that are not standard serial drivers?
> >>>> - Implement/test the removal paths
> >>>> - Fix the receive callbacks for more than character at a time (i.e. DMA)
> >>>> - Need better receive buffering than just a simple circular buffer or
> >>>> perhaps a different receive interface (e.g. direct to client buffer)?
> >>>> - Test with other UART drivers
> >>>> - Convert a real driver/line discipline over to UART bus.
> >>>> 
> >>>> Before I spend more time on this, I'm looking mainly for feedback on the
> >>>> general direction and structure (the interface with the existing serial
> >>>> drivers in particular).
> >>> 
> >>> Some quick comments (can't do any real life tests in the next weeks) from my (biased) view:
> >>> 
> >>> * tieing the solution into uart_port is the same as we had done. The difference seems to
> >>>  me that you completely bypass serial_core (and tty) while we want to integrate it with standard tty operation.
> >>> 
> >>>  We have tapped the tty layer only because it can not be 100% avoided if we use serial_core.
> >>> 
> >>> * one feedback I had received was that there may be uart device drivers not using serial_core. I am not sure if your approach addresses that.
> >>> 
> >>> * what I don't see is how we can implement our GPS device power control driver:
> >>> - the device should still present itself as a tty device (so that cat /dev/ttyO1 reports NMEA records) and should
> >>>   not be completely hidden from user space or represented by a new interface type invented just for this device
> >>>   (while the majority of other GPS receivers are still simple tty devices).
> >>> - how we can detect that the device is sending data to the UART while no user space process has the uart port open
> >>>   i.e. when does the driver know when to start/stop the UART.
> >> 
> >> I am actually not convinced that GPS should be represented as
> >> /dev/ttyS0 or similar TTY. It think they deserve their own driver
> >> exposing them as simple character devices. That way we can have a
> >> proper DEVTYPE and userspace can find them correctly. We can also
> >> annotate them if needed for special settings.
> > 
> > I would _love_ to see that happen, but what about the GPS line
> > discipline that we have today?  How would that match up with a char
> > device driver?
> 
> we have a GPS line discipline? What is that one doing? As far as I
> know all GPS implementations are fully userspace.

Hm, for some reason I thought that was what n_gsm.c was being used for,
but I could be wrong, I've never seen the hardware that uses that
code...

greg k-h
