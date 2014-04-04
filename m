From: =?iso-8859-1?Q?Mats_K=E4rrman?= <Mats.Karrman@tritech.se>
Subject: RE: FTDI spontanteous disconnect/reconnect
Date: Fri, 4 Apr 2014 06:31:19 +0000
Message-ID: <ED3E0BCACD909541BA94A34C4A164D4C5B3AD072@post.tritech.se>
References: <3F4B290D8BFAD2458191EB243C0592C4850B0D4EC9@seuppms301>
 <20140403180102.GA21565@kroah.com>
 ,<3F4B290D8BFAD2458191EB243C0592C4850B0D4FA7@seuppms301>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tritech.se ([46.59.120.190]:62921 "EHLO tritech.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbaDDGb2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 Apr 2014 02:31:28 -0400
In-Reply-To: <3F4B290D8BFAD2458191EB243C0592C4850B0D4FA7@seuppms301>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sven Lahr <Sven.Lahr@biotage.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi Sven,

The FTDI driver is now developed as an integral part of the Linux kerne=
l source tree.
See https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/usb/serial?id=3Drefs/tags/v3.14
(or just www.kernel.org to start with)

BR // Mats
________________________________________
=46rom: linux-serial-owner@vger.kernel.org [linux-serial-owner@vger.ker=
nel.org] on behalf of Sven Lahr [Sven.Lahr@biotage.com]
Sent: Friday, April 04, 2014 8:13 AM
To: linux-serial@vger.kernel.org
Subject: FW: FTDI spontanteous disconnect/reconnect

Hi!

Thank you for your quick response. We will definitely look into the ele=
ctronics.

But I am not quite sure what you mean when you say the in-kernel driver=
 is up-to-date. Where can I find that information?
The only place I have found any information about ftdi_sio is the Sourc=
eForge page, which clearly states nothing has happened since 2009.
And I have really searched the web, specifically I was trying to find a=
 "Known Issues" kinda page, bugtracker or something.

Regards
Sven L=E4hr

-----Original Message-----
=46rom: Greg KH [mailto:gregkh@linuxfoundation.org]
Sent: Thursday, April 03, 2014 8:01 PM
To: Sven Lahr
Cc: linux-serial@vger.kernel.org
Subject: Re: FTDI spontanteous disconnect/reconnect

On Thu, Apr 03, 2014 at 07:03:13PM +0200, Sven Lahr wrote:
> Hi there
>
> I work for a company that produces a system that contains a device wi=
th an FTDI 232R chip, as well as a Linux (Debian) computer that the dev=
ice is attached to.
> We often get reports from our customers that the device is
> disconnected, and then reconnected shortly thereafter. I have searche=
d
> the web, and apparently quite a lot of people experience this when
> they use the Linux driver.

The driver can't disconnect itself from the bus, that sounds like an el=
ectrical issue.

> I wonder if there is any plan to fix this. From what I can tell the
> Linux driver hasn't been updated in 5 years.

Where are you looking?  The in-kernel driver is updated all the time.

>
> Below I have pasted the relevant part of my kernel log.
>
>
> Best regards
> Sven L=E4hr, Biotage AB, Sweden
>
> Feb 27 19:45:44 kernel: [  936.368366] ftdi_sio ttyUSB0: FTDI USB
> Serial Device converter now disconnected from ttyUSB0 Feb 27 19:45:44
> kernel: [  936.368379] ftdi_sio 4-2:1.0: device disconnected Feb 27
> 19:45:44 kernel: [  936.608030] usb 4-2: new full-speed USB device
> number 3 using uhci_hcd Feb 27 19:45:44 kernel: [  936.806105] usb
> 4-2: New USB device found, idVendor=3D0403, idProduct=3D6001 Feb 27
> 19:45:44 kernel: [  936.806110] usb 4-2: New USB device strings:
> Mfr=3D1, Product=3D2, SerialNumber=3D3 Feb 27 19:45:44 kernel: [ 936.=
806115]
> usb 4-2: Product: FT232R USB UART Feb 27 19:45:44 kernel:
> [  936.806118] usb 4-2: Manufacturer: FTDI Feb 27 19:45:44 kernel: [
> 936.806121] usb 4-2: SerialNumber: A602WS4T Feb 27 19:45:44 kernel: [
> 936.814150] ftdi_sio 4-2:1.0: FTDI USB Serial Device converter
> detected Feb 27 19:45:44 kernel: [  936.814195] usb 4-2: Detected
> FT232RL Feb 27 19:45:44 kernel: [  936.814198] usb 4-2: Number of
> endpoints 2 Feb 27 19:45:44 kernel: [  936.814201] usb 4-2: Endpoint =
1
> MaxPacketSize 64 Feb 27 19:45:44 kernel: [  936.814205] usb 4-2:
> Endpoint 2 MaxPacketSize 64 Feb 27 19:45:44 kernel: [  936.814208] us=
b
> 4-2: Setting MaxPacketSize 64 Feb 27 19:45:44 kernel: [  936.816223]
> usb 4-2: FTDI USB Serial Device converter now attached to ttyUSB1

That shows the device disconnecting itself, and then coming back.
Perhaps something is lowering the voltage on the device such that the h=
ost thinks it is gone?

Again, this isn't something that the driver can even do, so I'd start l=
ooking for physical issues first.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
