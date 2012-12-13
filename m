From: David Robillard <david.robillard@gmail.com>
Subject: Edgeport/416 io_edgeport problem.
Date: Thu, 13 Dec 2012 15:03:59 -0500
Message-ID: <CADH15GikmfJh+nFbMFVcrW8RB8pmLsJvhtutue7L7iq8+7sdHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57321 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779Ab2LMUEB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Dec 2012 15:04:01 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so1097961wey.19
        for <linux-serial@vger.kernel.org>; Thu, 13 Dec 2012 12:04:00 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello everyone,

I'm having a problem with a Digi Inside Out Networks Edgeport/416
device. According to the kernel.org file (see exerpt below) this
particular model is not listed in the supported products.

The device is connected to a 32 bit CentOS 6.3 machine running with
kernel 2.6.32-279.14.1.el6.i686. When I connect the Edgeport/416, the
messages which show up in /var/log/messages don't show any errors (see
below). The 16 /dev/ttyUSB character devices are created in /dev. I
can see the Edgeport/416 in /proc/bus/devices and in
/sys/bus/usb/drivers/io_edgeport.

But when I try to access any one of the 16 ports, I always get a
timeout followed by a no such device error. If I do this...

sudo strace cat /dev/ttyUSB14

...it always fail with this line :

open("/dev/ttyUSB14", O_RDONLY|O_LARGEFILE) = -1 ENODEV (No such device)

I tried to contact Digi, but their answer is a bit dull :

this driver is supported by the Linux community, we recommend
contacting the Linux-USB group to see if they might be familiar with
this behavior and a possible patch. Otherwise, a bug report should be
filed with them.

I'm not quite sure where to go from there? Any help would be very appreciated.

Many thanks,

David

P.S. Below is the output when I connect the unit to the CentOS machine
and the contents of the
http://www.kernel.org/doc/Documentation/usb/usb-serial.txt file.

Dec 12 14:42:40 solo kernel: usb 1-2: new full speed USB device number
2 using ohci_hcd
Dec 12 14:42:40 solo kernel: usb 1-2: New USB device found,
idVendor=0451, idProduct=2077
Dec 12 14:42:40 solo kernel: usb 1-2: New USB device strings: Mfr=0,
Product=1, SerialNumber=0
Dec 12 14:42:40 solo kernel: usb 1-2: Product: General Purpose USB Hub
Dec 12 14:42:40 solo kernel: usb 1-2: configuration #1 chosen from 1 choice
Dec 12 14:42:40 solo kernel: hub 1-2:1.0: USB hub found
Dec 12 14:42:40 solo kernel: hub 1-2:1.0: 7 ports detected
Dec 12 14:42:40 solo kernel: usb 1-2.5: new full speed USB device
number 3 using ohci_hcd
Dec 12 14:42:40 solo kernel: usb 1-2.5: New USB device found,
idVendor=1608, idProduct=0012
Dec 12 14:42:40 solo kernel: usb 1-2.5: New USB device strings: Mfr=1,
Product=2, SerialNumber=5
Dec 12 14:42:40 solo kernel: usb 1-2.5: Product: Edgeport/416
Dec 12 14:42:40 solo kernel: usb 1-2.5: Manufacturer: Inside Out Networks
Dec 12 14:42:40 solo kernel: usb 1-2.5: SerialNumber: V70430350-0
Dec 12 14:42:40 solo kernel: usb 1-2.5: configuration #1 chosen from 1 choice
Dec 12 14:42:40 solo kernel: usbcore: registered new interface driver usbserial
Dec 12 14:42:40 solo kernel: USB Serial support registered for generic
Dec 12 14:42:40 solo kernel: usb 1-2.6: new full speed USB device
number 4 using ohci_hcd
Dec 12 14:42:41 solo kernel: usb 1-2.6: New USB device found,
idVendor=1608, idProduct=0012
Dec 12 14:42:41 solo kernel: usb 1-2.6: New USB device strings: Mfr=1,
Product=2, SerialNumber=5
Dec 12 14:42:41 solo kernel: usb 1-2.6: Product: Edgeport/416
Dec 12 14:42:41 solo kernel: usb 1-2.6: Manufacturer: Inside Out Networks
Dec 12 14:42:41 solo kernel: usb 1-2.6: SerialNumber: V70430350-1
Dec 12 14:42:41 solo kernel: usb 1-2.6: configuration #1 chosen from 1 choice
Dec 12 14:42:41 solo kernel: usbcore: registered new interface driver
usbserial_generic
Dec 12 14:42:41 solo kernel: usbserial: USB Serial Driver core
Dec 12 14:42:41 solo kernel: USB Serial support registered for
Edgeport 2 port adapter
Dec 12 14:42:41 solo kernel: USB Serial support registered for
Edgeport 4 port adapter
Dec 12 14:42:41 solo kernel: USB Serial support registered for
Edgeport 8 port adapter
Dec 12 14:42:41 solo kernel: USB Serial support registered for EPiC device
Dec 12 14:42:41 solo kernel: io_edgeport 1-2.5:1.0: Edgeport 8 port
adapter converter detected
Dec 12 14:42:41 solo kernel: usb 1-2.5: Inside Out Networks
Edgeport/416 detected
Dec 12 14:42:41 solo kernel: usb 1-2.5: firmware: requesting edgeport/down.fw
Dec 12 14:42:42 solo kernel: usb 1-2.5: firmware: requesting edgeport/boot.fw
Dec 12 14:42:42 solo kernel: usb 1-2.5: Edgeport 8 port adapter
converter now attached to ttyUSB0
Dec 12 14:42:42 solo kernel: usb 1-2.5: Edgeport 8 port adapter
converter now attached to ttyUSB1
Dec 12 14:42:42 solo kernel: usb 1-2.5: Edgeport 8 port adapter
converter now attached to ttyUSB2
Dec 12 14:42:42 solo kernel: usb 1-2.5: Edgeport 8 port adapter
converter now attached to ttyUSB3
Dec 12 14:42:42 solo kernel: usb 1-2.5: Edgeport 8 port adapter
converter now attached to ttyUSB4
Dec 12 14:42:42 solo kernel: usb 1-2.5: Edgeport 8 port adapter
converter now attached to ttyUSB5
Dec 12 14:42:42 solo kernel: usb 1-2.5: Edgeport 8 port adapter
converter now attached to ttyUSB6
Dec 12 14:42:42 solo kernel: usb 1-2.5: Edgeport 8 port adapter
converter now attached to ttyUSB7
Dec 12 14:42:42 solo kernel: io_edgeport 1-2.6:1.0: Edgeport 8 port
adapter converter detected
Dec 12 14:42:42 solo kernel: usb 1-2.6: Inside Out Networks
Edgeport/416 detected
Dec 12 14:42:42 solo kernel: usb 1-2.6: firmware: requesting edgeport/down.fw
Dec 12 14:42:43 solo kernel: usb 1-2.6: firmware: requesting edgeport/boot.fw
Dec 12 14:42:43 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB8
Dec 12 14:42:43 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB9
Dec 12 14:42:43 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB10
Dec 12 14:42:43 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB11
Dec 12 14:42:43 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB12
Dec 12 14:42:43 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB13
Dec 12 14:42:43 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB14
Dec 12 14:42:43 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB15
Dec 12 14:42:43 solo kernel: usbcore: registered new interface driver
io_edgeport
Dec 12 14:42:43 solo kernel: io_edgeport: v2.7:Edgeport USB Serial Driver


Inside Out Networks Edgeport Driver

  This driver supports all devices made by Inside Out Networks, specifically
  the following models:
       Edgeport/4
       Rapidport/4
       Edgeport/4t
       Edgeport/2
       Edgeport/4i
       Edgeport/2i
       Edgeport/421
       Edgeport/21
       Edgeport/8
       Edgeport/8 Dual
       Edgeport/2D8
       Edgeport/4D8
       Edgeport/8i
       Edgeport/2 DIN
       Edgeport/4 DIN
       Edgeport/16 Dual

  For any questions or problems with this driver, please contact Greg
  Kroah-Hartman at greg@kroah.com
