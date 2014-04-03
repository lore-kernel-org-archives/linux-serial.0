From: Sven Lahr <Sven.Lahr@biotage.com>
Subject: FTDI spontanteous disconnect/reconnect
Date: Thu, 3 Apr 2014 19:03:13 +0200
Message-ID: <3F4B290D8BFAD2458191EB243C0592C4850B0D4EC9@seuppms301>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from semailgw001.biotage.se ([194.33.80.213]:49488 "EHLO
	semailgw001.biotage.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbaDCRDQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Apr 2014 13:03:16 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi there

I work for a company that produces a system that contains a device with=
 an FTDI 232R chip, as well as a Linux (Debian) computer that the devic=
e is attached to.
We often get reports from our customers that the device is disconnected=
, and then reconnected shortly thereafter. I have searched the web, and=
 apparently quite a lot of people experience this when they use the Lin=
ux driver.
I wonder if there is any plan to fix this. From what I can tell the Lin=
ux driver hasn't been updated in 5 years.

Below I have pasted the relevant part of my kernel log.


Best regards
Sven L=E4hr, Biotage AB, Sweden

=46eb 27 19:45:44 kernel: [  936.368366] ftdi_sio ttyUSB0: FTDI USB Ser=
ial Device converter now disconnected from ttyUSB0
=46eb 27 19:45:44 kernel: [  936.368379] ftdi_sio 4-2:1.0: device disco=
nnected
=46eb 27 19:45:44 kernel: [  936.608030] usb 4-2: new full-speed USB de=
vice number 3 using uhci_hcd
=46eb 27 19:45:44 kernel: [  936.806105] usb 4-2: New USB device found,=
 idVendor=3D0403, idProduct=3D6001
=46eb 27 19:45:44 kernel: [  936.806110] usb 4-2: New USB device string=
s: Mfr=3D1, Product=3D2, SerialNumber=3D3
=46eb 27 19:45:44 kernel: [  936.806115] usb 4-2: Product: FT232R USB U=
ART
=46eb 27 19:45:44 kernel: [  936.806118] usb 4-2: Manufacturer: FTDI
=46eb 27 19:45:44 kernel: [  936.806121] usb 4-2: SerialNumber: A602WS4=
T
=46eb 27 19:45:44 kernel: [  936.814150] ftdi_sio 4-2:1.0: FTDI USB Ser=
ial Device converter detected
=46eb 27 19:45:44 kernel: [  936.814195] usb 4-2: Detected FT232RL
=46eb 27 19:45:44 kernel: [  936.814198] usb 4-2: Number of endpoints 2
=46eb 27 19:45:44 kernel: [  936.814201] usb 4-2: Endpoint 1 MaxPacketS=
ize 64
=46eb 27 19:45:44 kernel: [  936.814205] usb 4-2: Endpoint 2 MaxPacketS=
ize 64
=46eb 27 19:45:44 kernel: [  936.814208] usb 4-2: Setting MaxPacketSize=
 64
=46eb 27 19:45:44 kernel: [  936.816223] usb 4-2: FTDI USB Serial Devic=
e converter now attached to ttyUSB1
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
