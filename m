From: Johan Hovold <jhovold@gmail.com>
Subject: Re: USB to Serial converter code pl2303
Date: Tue, 18 Feb 2014 10:09:46 +0100
Message-ID: <20140218090946.GA1954@localhost>
References: <1392688665.7323.32.camel@mange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:46904 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbaBRJKR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Feb 2014 04:10:17 -0500
Content-Disposition: inline
In-Reply-To: <1392688665.7323.32.camel@mange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Magnus <magnus-swe@telia.com>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

[ Please make sure to CC the linux-usb list as well. ]

On Tue, Feb 18, 2014 at 02:57:45AM +0100, Magnus wrote:
> After plugging in the plexgear adapter into my linux boxes:
> Fedora 18, Debian 3.11.0-15-generic #25-Ubuntu and weezy it doesnt
> send any commands to the servo controller chip on the other side
> of the converter.
> 
> I can open the port /dev/ttyUSB0 and send to it with stty, but not
> a beep on the other side. I have also set the tty Baudrate manually to
> 2400 but this made no difference. My code does this as well including
> setting stopbit parity and so on.

First verify that the converter works by connecting it to a serial port
on your PC and using a terminal program such as minicom at 115200 baud
(and the same port settings including flow control) on both ends.

Also make sure you got the wiring right (e.g. use a null-modem cable).

> Some data i get from Linux and Plexgear converter follows:
> 
> $ lsmod | grep pl2303
> pl2303                 18527  0 
> usbserial              38603  1 pl2303
> 
> 
> $ lsusb
> Bus 005 Device 007: ID 067b:2303 Prolific Technology, Inc.
> PL2303 Serial Port
> 
> $ lsusb -v
> 
> Bus 005 Device 007: ID 067b:2303 Prolific Technology, Inc.
> PL2303 Serial Port
> 
> Couldn't open device, some information will be missing
> (My comment... hmm, but it can read from it ?)..
> 
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0        64
>   idVendor           0x067b Prolific Technology, Inc.
>   idProduct          0x2303 PL2303 Serial Port
>   bcdDevice            3.00
>   iManufacturer           1 
>   iProduct                2 
>   iSerial                 0 
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           39
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0 
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              100mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           3
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0 
>       bInterfaceProtocol      0 
>       iInterface              0 
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x000a  1x 10 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
> 
> I can code some, but i dont know where to start so any
> help on this is highly appreciated.
> 
> When i google to find info on adapters i read that
> "bMaxPacketSize0 64" indicates that its a counterfeit product
> but i paid 250 Swedish for it and that not very cheap for a
> univeristy student i think.

This device is likely not a clone, but should be supported by the pl2303
driver either way (at least at 115200 baud).

Good luck,
Johan
