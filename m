From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Plug and play for a tty line disciple networking device
Date: Wed, 20 Mar 2013 17:25:44 -0700
Message-ID: <9B6A11C6-810F-41D0-94F7-E64E498F079A@holtmann.org>
References: <CAKON4OxNV85-J8C-hodpq9pY5tRCT+7aYa=m4T3Vk04XSGhOrA@mail.gmail.com> <20130320232645.GC19779@kroah.com> <CAKON4Oz+2DfzeOcvmKgi3ADAtyC5ie5-22uUQdfH_gcqeaDSYA@mail.gmail.com> <20130321001424.GA27981@kroah.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:47210 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab3CUAZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Mar 2013 20:25:49 -0400
In-Reply-To: <20130321001424.GA27981@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Ott <alan@signal11.us>

Hi Greg,

>>>> How can you achieve plug and play for a ft2232 based USB serial device
>>>> implementing 802.15.4 networking?
>>>> 
>>>> The device has a 802.15.4 SOC with a UART attached to a ft2232. With
>>>> firmware loaded the only thing it can do is talk the 802.15.4 tty line
>>>> discipline, it is not a general purpose serial port.
>>>> 
>>>> Right now the device works by plugging it in and it appears as a
>>>> generic USB serial device like ttyUSB0. You then run a user space app
>>>> which sets the line discipline, holds the port open and attaches it to
>>>> the 6lowpan implementation in the networking code. But doing that is
>>>> inconvenient and users needs to be trained to do it. Much simpler if
>>>> we could just plug the device in and it worked.
>>>> 
>>>> We can add a EEPROM to the ft2232 to give it a unique USB ID.  Is it
>>>> possible to make a kernel driver that see this ID, sets the line
>>>> discipline and wires the serial port directly into the networking
>>>> code?
>>> 
>>> Yes, you can do that.
>> 
>> Is there an existing driver in the kernel that does this?
>> So far all of the ones I've checked still need a user space app.
> 
> Look at the bluetooth drivers, they have their own line dicipline I
> think.

yes we do. And we also have a userspace tool (hciattach) to setup the line discipline. However the automatic setup can be easily automated with a simple udev rule.

Regards

Marcel

