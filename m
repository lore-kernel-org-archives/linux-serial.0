From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: FTDI spontanteous disconnect/reconnect
Date: Thu, 3 Apr 2014 11:01:02 -0700
Message-ID: <20140403180102.GA21565@kroah.com>
References: <3F4B290D8BFAD2458191EB243C0592C4850B0D4EC9@seuppms301>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:58658 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbaDCR6j (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Apr 2014 13:58:39 -0400
Content-Disposition: inline
In-Reply-To: <3F4B290D8BFAD2458191EB243C0592C4850B0D4EC9@seuppms301>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sven Lahr <Sven.Lahr@biotage.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Thu, Apr 03, 2014 at 07:03:13PM +0200, Sven Lahr wrote:
> Hi there
>=20
> I work for a company that produces a system that contains a device wi=
th an FTDI 232R chip, as well as a Linux (Debian) computer that the dev=
ice is attached to.
> We often get reports from our customers that the device is
> disconnected, and then reconnected shortly thereafter. I have searche=
d
> the web, and apparently quite a lot of people experience this when
> they use the Linux driver.

The driver can't disconnect itself from the bus, that sounds like an
electrical issue.

> I wonder if there is any plan to fix this. From what I can tell the
> Linux driver hasn't been updated in 5 years.

Where are you looking?  The in-kernel driver is updated all the time.

>=20
> Below I have pasted the relevant part of my kernel log.
>=20
>=20
> Best regards
> Sven L=E4hr, Biotage AB, Sweden
>=20
> Feb 27 19:45:44 kernel: [  936.368366] ftdi_sio ttyUSB0: FTDI USB Ser=
ial Device converter now disconnected from ttyUSB0
> Feb 27 19:45:44 kernel: [  936.368379] ftdi_sio 4-2:1.0: device disco=
nnected
> Feb 27 19:45:44 kernel: [  936.608030] usb 4-2: new full-speed USB de=
vice number 3 using uhci_hcd
> Feb 27 19:45:44 kernel: [  936.806105] usb 4-2: New USB device found,=
 idVendor=3D0403, idProduct=3D6001
> Feb 27 19:45:44 kernel: [  936.806110] usb 4-2: New USB device string=
s: Mfr=3D1, Product=3D2, SerialNumber=3D3
> Feb 27 19:45:44 kernel: [  936.806115] usb 4-2: Product: FT232R USB U=
ART
> Feb 27 19:45:44 kernel: [  936.806118] usb 4-2: Manufacturer: FTDI
> Feb 27 19:45:44 kernel: [  936.806121] usb 4-2: SerialNumber: A602WS4=
T
> Feb 27 19:45:44 kernel: [  936.814150] ftdi_sio 4-2:1.0: FTDI USB Ser=
ial Device converter detected
> Feb 27 19:45:44 kernel: [  936.814195] usb 4-2: Detected FT232RL
> Feb 27 19:45:44 kernel: [  936.814198] usb 4-2: Number of endpoints 2
> Feb 27 19:45:44 kernel: [  936.814201] usb 4-2: Endpoint 1 MaxPacketS=
ize 64
> Feb 27 19:45:44 kernel: [  936.814205] usb 4-2: Endpoint 2 MaxPacketS=
ize 64
> Feb 27 19:45:44 kernel: [  936.814208] usb 4-2: Setting MaxPacketSize=
 64
> Feb 27 19:45:44 kernel: [  936.816223] usb 4-2: FTDI USB Serial Devic=
e converter now attached to ttyUSB1

That shows the device disconnecting itself, and then coming back.
Perhaps something is lowering the voltage on the device such that the
host thinks it is gone?

Again, this isn't something that the driver can even do, so I'd start
looking for physical issues first.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
