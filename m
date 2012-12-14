From: David Robillard <david.robillard@gmail.com>
Subject: Re: Edgeport/416 io_edgeport problem.
Date: Fri, 14 Dec 2012 11:47:47 -0500
Message-ID: <CADH15GiJeTmL=WPNoc_8g17AkzyrU4w-jRB0H2wy_+OoGGQByQ@mail.gmail.com>
References: <CADH15GikmfJh+nFbMFVcrW8RB8pmLsJvhtutue7L7iq8+7sdHQ@mail.gmail.com>
	<20121214095220.1be799ee@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:46183 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab2LNQrt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Dec 2012 11:47:49 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so646812wib.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Dec 2012 08:47:48 -0800 (PST)
In-Reply-To: <20121214095220.1be799ee@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

Hello Alan,

Thank you for the suggestion.

> Please try a recent upstream kernel. 2.6.32 is old, and the Red
> Hat/CentOS version quite a bit different. If 3.6/3.7 break then yes we
> might care about it.

I've tried with kernel 3.7.0-1.el6.elrepo.i686 from
http://elrepo.org/tiki/kernel-ml but unfortunately it's even worse.
Now the OS only sees half of the Edgeport/416. Ports 1 to 8 are seen
and /dev/ttyUSB0 to 7 are created. But I still can't access them.
Ports 10 to 16 are not seen and the character devices are not created.

Performing `sudo strace cat /dev/ttyUSB0` results in this error :

open("/dev/ttyUSB0", O_RDONLY|O_LARGEFILE) = -1 ENODEV (No such device)

Which is exactly the same error I used to get with kernel
2.6.32-279.14.1.el6.i686. But at least with that kernel version, the
OS would see the full 16 ports of the Edgeport/416.

This Edgeport/416 hardware successfully passed the Digi digital
loopback test as explained in this article
http://www.digi.com/support/kbase/kbaseresultdetl?id=3061. The test
was performed on a Windows 7 machine.

The model's PN is (1P) 50000780-01 E.

This device appears to be faulty according this Digi forum thread :
http://forums.digi.com/support/forum/viewthread_thread,4977#15792

Any help would be appreciated.

Many thanks,

David

P.S. Syslog messages when connecting the device to a CentOS 6.3
machine running kernel 3.7.0-1.el6.elrepo.i686

ec 14 11:30:52 solo kernel: usb 1-2: new full-speed USB device number
20 using ohci_hcd
Dec 14 11:30:52 solo kernel: usb 1-2: New USB device found,
idVendor=0451, idProduct=2077
Dec 14 11:30:52 solo kernel: usb 1-2: New USB device strings: Mfr=0,
Product=1, SerialNumber=0
Dec 14 11:30:52 solo kernel: usb 1-2: Product: General Purpose USB Hub
Dec 14 11:30:52 solo kernel: hub 1-2:1.0: USB hub found
Dec 14 11:30:52 solo kernel: usb 1-2.5: new full-speed USB device
number 21 using ohci_hcd
Dec 14 11:30:52 solo kernel: usb 1-2.5: device descriptor read/64, error -62
Dec 14 11:30:53 solo kernel: usb 1-2.5: device descriptor read/64, error -62
Dec 14 11:30:53 solo kernel: usb 1-2.5: new full-speed USB device
number 22 using ohci_hcd
Dec 14 11:30:53 solo kernel: usb 1-2.5: device descriptor read/64, error -62
Dec 14 11:30:53 solo kernel: usb 1-2.5: device descriptor read/64, error -62
Dec 14 11:30:53 solo kernel: usb 1-2.5: new full-speed USB device
number 23 using ohci_hcd
Dec 14 11:30:54 solo kernel: usb 1-2.5: device not accepting address
23, error -62
Dec 14 11:30:54 solo kernel: usb 1-2.5: new full-speed USB device
number 24 using ohci_hcd
Dec 14 11:30:54 solo kernel: usb 1-2.5: device not accepting address
24, error -62
Dec 14 11:30:54 solo kernel: hub 1-2:1.0: unable to enumerate USB
device on port 5
Dec 14 11:30:54 solo kernel: usb 1-2.6: new full-speed USB device
number 25 using ohci_hcd
Dec 14 11:30:54 solo kernel: usb 1-2.6: New USB device found,
idVendor=1608, idProduct=0012
Dec 14 11:30:54 solo kernel: usb 1-2.6: New USB device strings: Mfr=1,
Product=2, SerialNumber=5
Dec 14 11:30:54 solo kernel: usb 1-2.6: Product: Edgeport/416
Dec 14 11:30:54 solo kernel: usb 1-2.6: Manufacturer: Inside Out Networks
Dec 14 11:30:54 solo kernel: usb 1-2.6: SerialNumber: V70430350-1
Dec 14 11:30:54 solo kernel: usb 1-2.6: Inside Out Networks
Edgeport/416 detected
Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB0
Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB1
Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB2
Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB3
Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB4
Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB5
Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB6
Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
converter now attached to ttyUSB7

On Fri, Dec 14, 2012 at 4:52 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Thu, 13 Dec 2012 15:03:59 -0500
> David Robillard <david.robillard@gmail.com> wrote:
>
>> Hello everyone,
>>
>> I'm having a problem with a Digi Inside Out Networks Edgeport/416
>> device. According to the kernel.org file (see exerpt below) this
>> particular model is not listed in the supported products.
>>
>> The device is connected to a 32 bit CentOS 6.3 machine running with
>> kernel 2.6.32-279.14.1.el6.i686.
>
>
> Alan
