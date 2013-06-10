From: Fabio Fumi <ffumi68@googlemail.com>
Subject: Re: Connection to a 3G USB Module using USB-Serial
Date: Mon, 10 Jun 2013 15:58:38 +0200
Message-ID: <CA+y4WrRcrnYNHsFEZ2aTPGyPB1e9z508wzMp0Cf3-kxXPoNEBg@mail.gmail.com>
References: <CA+y4WrSC0Z5hFodTDNL0KGu2_pZtu3WB98re-yQJOsFCo21nRw@mail.gmail.com>
	<20130608182232.GB5918@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:58200 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab3FJN6j (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Jun 2013 09:58:39 -0400
In-Reply-To: <20130608182232.GB5918@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

Thanks Greg for taking som etime to answer.

My kernel is an old 2.6.35.7 and migrating it entirely to 3+ one is a
real mess (given the number of platfomr customization it includes). So
probably the best is to try back-porting the ZTE usb-serial driver...
I guess. Is it "drivers/usb/serial/zte_ev.c" what you're referring to?
My device is a ZTE MF-210... does the same driver really apply for
this device too?

Does the same driver rely on some kernel 3.x-only features?
I can always give it a *blind* try, of course... but better knowing in
advance, if it won't work.

On Sat, Jun 8, 2013 at 8:22 PM, Greg KH <greg@kroah.com> wrote:
> On Thu, May 30, 2013 at 02:54:40PM +0200, Fabio Fumi wrote:
>> I'm struggling with this issue since a while and as the author of the
>> USB-Serial module I thought experts here might provide some help... As
>> it's a USB-serail issue, I've posted on both USB and Serial lists.
>> thanks in advance!
>>
>> The problem is about connecting with a 3G USB modem, a ZTE MF-210
>> mini-pci board; plugged as a daughter board inside an Android tablet.
>> I have posted already on a couple forums, but got no useful feedback
>> yet.
>>
>> As soon as I power up the module I get the expected /dev/ttyUSB0-3 and
>> that's fine, so far:
>>
>> <6>usb 1-1.1: new high speed USB device using emxx-ehci-driver and address 3
>> <6>option 1-1.1:1.0: GSM modem (1-port) converter detected
>> <6>usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB0
>> <6>option 1-1.1:1.1: GSM modem (1-port) converter detected
>> <6>usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB1
>> <6>option 1-1.1:1.2: GSM modem (1-port) converter detected
>> <6>usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB2
>> <6>option 1-1.1:1.3: GSM modem (1-port) converter detected
>> <6>usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB3
>>
>> Issue is when I try to communicate with any of these ports. I can
>> connect using picocom to all but can't receive any feedback from AT
>> commands sent over to them. I made some partial progress only after
>> using the "-i" option (i.e. "no port init"), but below you can find
>> what I get if I simply type A + T + Z + <enter>, for example.
>>
>> As you can see, characters and commands are repeated several times.
>> That's what I can't understand.
>>
>> Without the -i option, I don't even get any feedback from the modem
>> and the same happens using other connection programs, e.g. busybox
>> microcom. I'm using picocom as it's very small and I succesfully used
>> it already in a similar case, though on a different Android platform
>> and kernel.
>>
>> This Kernel is built including standard usb-serial options below:
>>
>> CONFIG_USB_SERIAL=y
>> CONFIG_USB_SERIAL_WWAN=y
>> CONFIG_USB_SERIAL_OPTION=y
>
> What kernel version are you using?
>
>> Is the kernel missing anything, or requiring some special ZTE-specific
>> customizations in your opinion?
>
> There is a new zte-specific driver in the 3.9 kernel release that should
> work for your device.  We just got some patches merged that moved the
> device id from the option driver to the zte driver, which should resolve
> issues like the one you are seeing here (i.e. the wrong driver
> controlling the device.)  Can you test the 3.10-rc5 kernel that comes
> out in a few days, or the next 3.9-stable release 3.9.6 should have the
> proper patches)?
>
> thanks,
>
> greg k-h
