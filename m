From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: linux-3.9.3 - hit limit of 255 usb->serial devices
Date: Fri, 24 May 2013 10:23:54 -0700
Message-ID: <20130524172354.GA1402@kroah.com>
References: <519F7195.8090306@linuxdingsda.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57173 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab3EXRXz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 May 2013 13:23:55 -0400
Content-Disposition: inline
In-Reply-To: <519F7195.8090306@linuxdingsda.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Winter <tobias@linuxdingsda.de>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, May 24, 2013 at 03:56:37PM +0200, Tobias Winter wrote:
> Hi there,
> 
> since my propblem is with usb to serial adapters I was unsure if this is
> the right place. If not, please let me know.

Not really, linux-usb@ is the proper one, I've included that on the cc:

> After equipping a server with a lot of ftdi singleport usb2serial
> devices, I ran into a serial device limit that is included in
> include/linux/usb/serial.h .
> 
> The limit of devices seems to be 255, resulting in ttyUSB254 to be the
> last supported device.
> 
> The codesnippet in question is:
> 
> #define SERIAL_TTY_MINORS 254 /* loads of devices :) */
> #define SERIAL_TTY_NO_MINOR 255 /* No minor was assigned */

Yes, that's the limit of usb-serial devices in the system at the moment.
In 10+ years, no one has complained yet, so it's been a good number :)

> Output of `lsusb | sort` with 256 usb2serial devices connected:
> http://pastebin.com/wqrYUbwZ

Nice job.

> In case you end up agreeing with me that there are no reasons to limit
> the devices to 255, would you be inclined to fix this in the main kernel
> tree? Do I have to open up a bug somewhere?

You can send a patch making the number dynamic, that would be great to
have.

> I also tried increasing the numbers further but I run into rollover
> issues as the kernel tries to reassign ttyUSB0 ttyUSB1 which is already
> taken. It seems without some other modification 256 devices is the limit?

Yes, there might be some limits in the tty layer as well for only 256
tty devices, but I haven't looked there in a long time, perhaps that is
now no longer the case.

> Bus 001 Device 091: ID 0403:6001 Future Technology Devices International, Ltd FT232 USB-Serial (UART) IC

I'm just glad to see we can support 91 different devices on a single
root hub, that's good to see, as I don't think anyone has tested that in
a very long time :)

thanks,

greg k-h
