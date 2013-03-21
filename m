From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Plug and play for a tty line disciple networking device
Date: Wed, 20 Mar 2013 17:38:17 -0700
Message-ID: <20130321003817.GA28389@kroah.com>
References: <CAKON4OxNV85-J8C-hodpq9pY5tRCT+7aYa=m4T3Vk04XSGhOrA@mail.gmail.com>
 <20130320232645.GC19779@kroah.com>
 <CAKON4Oz+2DfzeOcvmKgi3ADAtyC5ie5-22uUQdfH_gcqeaDSYA@mail.gmail.com>
 <20130321001424.GA27981@kroah.com>
 <CAKON4OyB6Tc_NSYjb9HRjpzZJOTEZowoYB8NeJwtO6T42wegBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:60877 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab3CUAiU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Mar 2013 20:38:20 -0400
Received: by mail-pb0-f51.google.com with SMTP id un15so1770167pbc.38
        for <linux-serial@vger.kernel.org>; Wed, 20 Mar 2013 17:38:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKON4OyB6Tc_NSYjb9HRjpzZJOTEZowoYB8NeJwtO6T42wegBg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Ott <alan@signal11.us>

On Wed, Mar 20, 2013 at 08:25:15PM -0400, jonsmirl@gmail.com wrote:
> On Wed, Mar 20, 2013 at 8:14 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Mar 20, 2013 at 08:04:29PM -0400, jonsmirl@gmail.com wrote:
> >> On Wed, Mar 20, 2013 at 7:26 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> > On Tue, Mar 19, 2013 at 11:30:05AM -0400, jonsmirl@gmail.com wrote:
> >> >> How can you achieve plug and play for a ft2232 based USB serial device
> >> >> implementing 802.15.4 networking?
> >> >>
> >> >> The device has a 802.15.4 SOC with a UART attached to a ft2232. With
> >> >> firmware loaded the only thing it can do is talk the 802.15.4 tty line
> >> >> discipline, it is not a general purpose serial port.
> >> >>
> >> >> Right now the device works by plugging it in and it appears as a
> >> >> generic USB serial device like ttyUSB0. You then run a user space app
> >> >> which sets the line discipline, holds the port open and attaches it to
> >> >> the 6lowpan implementation in the networking code. But doing that is
> >> >> inconvenient and users needs to be trained to do it. Much simpler if
> >> >> we could just plug the device in and it worked.
> >> >>
> >> >> We can add a EEPROM to the ft2232 to give it a unique USB ID.  Is it
> >> >> possible to make a kernel driver that see this ID, sets the line
> >> >> discipline and wires the serial port directly into the networking
> >> >> code?
> >> >
> >> > Yes, you can do that.
> >>
> >> Is there an existing driver in the kernel that does this?
> >> So far all of the ones I've checked still need a user space app.
> >
> > Look at the bluetooth drivers, they have their own line dicipline I
> > think.
> 
> Bluetooth drivers use line discipline on UARTs. On USB they have their
> own set of Bluetooth descriptors.
> 
> CAN over serial has a line discipline but it needs a user space app.

In your driver, just attach the line discipline directly to the tty
device you create.  You will not be using the "normal" usb-serial logic
at all if you do this, but you should be fine, right?

greg k-h
