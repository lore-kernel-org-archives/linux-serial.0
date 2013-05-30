From: Fabio Fumi <ffumi68@googlemail.com>
Subject: Connection to a 3G USB Module using USB-Serial
Date: Thu, 30 May 2013 14:54:40 +0200
Message-ID: <CA+y4WrSC0Z5hFodTDNL0KGu2_pZtu3WB98re-yQJOsFCo21nRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:46502 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab3E3Myk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 May 2013 08:54:40 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

I'm struggling with this issue since a while and as the author of the
USB-Serial module I thought experts here might provide some help... As
it's a USB-serail issue, I've posted on both USB and Serial lists.
thanks in advance!

The problem is about connecting with a 3G USB modem, a ZTE MF-210
mini-pci board; plugged as a daughter board inside an Android tablet.
I have posted already on a couple forums, but got no useful feedback
yet.

As soon as I power up the module I get the expected /dev/ttyUSB0-3 and
that's fine, so far:

<6>usb 1-1.1: new high speed USB device using emxx-ehci-driver and address 3
<6>option 1-1.1:1.0: GSM modem (1-port) converter detected
<6>usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB0
<6>option 1-1.1:1.1: GSM modem (1-port) converter detected
<6>usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB1
<6>option 1-1.1:1.2: GSM modem (1-port) converter detected
<6>usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB2
<6>option 1-1.1:1.3: GSM modem (1-port) converter detected
<6>usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB3

Issue is when I try to communicate with any of these ports. I can
connect using picocom to all but can't receive any feedback from AT
commands sent over to them. I made some partial progress only after
using the "-i" option (i.e. "no port init"), but below you can find
what I get if I simply type A + T + Z + <enter>, for example.

As you can see, characters and commands are repeated several times.
That's what I can't understand.

Without the -i option, I don't even get any feedback from the modem
and the same happens using other connection programs, e.g. busybox
microcom. I'm using picocom as it's very small and I succesfully used
it already in a similar case, though on a different Android platform
and kernel.

This Kernel is built including standard usb-serial options below:

CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_WWAN=y
CONFIG_USB_SERIAL_OPTION=y

Is the kernel missing anything, or requiring some special ZTE-specific
customizations in your opinion?

What are the best connection options I could try?

 thanks
