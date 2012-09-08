From: peter.sheeren@axiris.be
Subject: Re: Bug in USB FTDI SIO driver
Date: Sun, 09 Sep 2012 00:09:59 +0200
Message-ID: <20120909000959.41003ow8kex7h8vr@webmail.axiris.be>
References: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
 <20120908181634.7c6e5c73@pyramind.ukuu.org.uk>
 <20120908192037.20412mlnvfniwkmd@webmail.axiris.be>
 <20120908183015.2ca02043@pyramind.ukuu.org.uk>
 <20120908193516.11911xl64w1z7lxw@webmail.axiris.be>
 <20120908181917.GA7038@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay02-01.mx.hostbasket.com ([85.255.198.148]:45977 "EHLO
	mailrelay02-01.mx.hostbasket.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753947Ab2IHWKF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Sep 2012 18:10:05 -0400
In-Reply-To: <20120908181917.GA7038@kroah.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org


It's interesting to know the driver aren't unloaded. So I did a couple  
of tests with rmmod:

Test 1:
1. Plug in the USB device
2. Run test application, baud rate is successfully set
3. Plug out the USB device, lsmod shows usbserial and ftdi_sio
4. rmmod ftdi_sio
5. Plug in the USB device
6. Run test application, baud rate not set in the USB device

Test 2:
1. Plug in the USB device
2. Run test application, baud rate is successfully set
3. Plug out the USB device, lsmod shows usbserial and ftdi_sio
4. rmmod ftdi_sio
5. rmmod usbserial
6. Plug in the USB device
7. Run test application, baud rate is successfully set

Thus if I remove both ftdi_sio and usbserial before I plug the USB  
device back in, the problem is solved. Maybe usbserial is causing the  
problem?


Quoting Greg KH <gregkh@linuxfoundation.org>:

> On Sat, Sep 08, 2012 at 07:35:16PM +0200, peter.sheeren@axiris.be wrote:
>>
>> I'm sorry, I've no experience with compiling a driver for Linux.
>>
>> Q: When I plug in the USB device without even using it, should
>> ftdi_sio and usbserial remain loaded after I unplug the USB device?
>
> Yes, no one unloads modules after devices are removed, as you really
> don't know if the driver is still needed or not.
>
> But, this shouldn't be an issue for you, when you replug the device in,
> it should be reset, with no internal, or kernel, state as to what it is
> in.  You have to always explicitly set the line settings up again,
> otherwise you have no idea what it is running at.
>
> greg k-h
>


