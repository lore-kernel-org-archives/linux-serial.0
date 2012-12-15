From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Edgeport/416 io_edgeport problem.
Date: Fri, 14 Dec 2012 18:03:31 -0800
Message-ID: <20121215020331.GA21221@kroah.com>
References: <CADH15GikmfJh+nFbMFVcrW8RB8pmLsJvhtutue7L7iq8+7sdHQ@mail.gmail.com>
 <20121214095220.1be799ee@pyramind.ukuu.org.uk>
 <CADH15GiJeTmL=WPNoc_8g17AkzyrU4w-jRB0H2wy_+OoGGQByQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35754 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab2LOCAw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Dec 2012 21:00:52 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2779192pbc.19
        for <linux-serial@vger.kernel.org>; Fri, 14 Dec 2012 18:00:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADH15GiJeTmL=WPNoc_8g17AkzyrU4w-jRB0H2wy_+OoGGQByQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Robillard <david.robillard@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Fri, Dec 14, 2012 at 11:47:47AM -0500, David Robillard wrote:
> Hello Alan,
> 
> Thank you for the suggestion.
> 
> > Please try a recent upstream kernel. 2.6.32 is old, and the Red
> > Hat/CentOS version quite a bit different. If 3.6/3.7 break then yes we
> > might care about it.
> 
> I've tried with kernel 3.7.0-1.el6.elrepo.i686 from
> http://elrepo.org/tiki/kernel-ml but unfortunately it's even worse.
> Now the OS only sees half of the Edgeport/416. Ports 1 to 8 are seen
> and /dev/ttyUSB0 to 7 are created. But I still can't access them.
> Ports 10 to 16 are not seen and the character devices are not created.
> 
> Performing `sudo strace cat /dev/ttyUSB0` results in this error :
> 
> open("/dev/ttyUSB0", O_RDONLY|O_LARGEFILE) = -1 ENODEV (No such device)
> 
> Which is exactly the same error I used to get with kernel
> 2.6.32-279.14.1.el6.i686. But at least with that kernel version, the
> OS would see the full 16 ports of the Edgeport/416.
> 
> This Edgeport/416 hardware successfully passed the Digi digital
> loopback test as explained in this article
> http://www.digi.com/support/kbase/kbaseresultdetl?id=3061. The test
> was performed on a Windows 7 machine.
> 
> The model's PN is (1P) 50000780-01 E.
> 
> This device appears to be faulty according this Digi forum thread :
> http://forums.digi.com/support/forum/viewthread_thread,4977#15792
> 
> Any help would be appreciated.
> Dec 14 11:30:54 solo kernel: usb 1-2.6: New USB device found,
> idVendor=1608, idProduct=0012
> Dec 14 11:30:54 solo kernel: usb 1-2.6: New USB device strings: Mfr=1,
> Product=2, SerialNumber=5
> Dec 14 11:30:54 solo kernel: usb 1-2.6: Product: Edgeport/416
> Dec 14 11:30:54 solo kernel: usb 1-2.6: Manufacturer: Inside Out Networks
> Dec 14 11:30:54 solo kernel: usb 1-2.6: SerialNumber: V70430350-1
> Dec 14 11:30:54 solo kernel: usb 1-2.6: Inside Out Networks
> Edgeport/416 detected
> Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
> converter now attached to ttyUSB0
> Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
> converter now attached to ttyUSB1
> Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
> converter now attached to ttyUSB2
> Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
> converter now attached to ttyUSB3
> Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
> converter now attached to ttyUSB4
> Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
> converter now attached to ttyUSB5
> Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
> converter now attached to ttyUSB6
> Dec 14 11:30:56 solo kernel: usb 1-2.6: Edgeport 8 port adapter
> converter now attached to ttyUSB7

This looks good, so you should be able to talk to the device, the fact
that it returns -ENODEV is odd.

Can you do the following from a command line as root:
Clear out the kernel log:
	dmesg -c
remove the io_edgeport driver
	rmmod io_edgeport
Unplug the device.
load the edgeport driver with debugging enabled:
	modprobe io_edgeport debug=1
plug the device in.

Try to access the device
	cat /dev/ttyUSB0

Send us the output of the kernel log:
	dmesg

Hopefully that should show us what is going on here.

thanks,

greg k-h
