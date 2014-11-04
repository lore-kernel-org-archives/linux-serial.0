From: Janne Huttunen <jahuttun@gmail.com>
Subject: Re: usbserial / ftdi_sio (+ others) bug?
Date: Tue, 4 Nov 2014 20:29:13 +0200
Message-ID: <20141104202913.4b0d6cd2@sauron>
References: <CAHdUje_wc+-SwUTDsNHg8HkD2ynJDtOE18VXe5616UpFYyAU0Q@mail.gmail.com>
	<20141029085128.GC7841@localhost>
	<20141103234609.03842d21@sauron>
	<20141104081449.GI31358@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:40804 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaKDS3Y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2014 13:29:24 -0500
In-Reply-To: <20141104081449.GI31358@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org

On Tue, 4 Nov 2014 09:14:49 +0100
Johan Hovold <johan@kernel.org> wrote:
> > 2. The chip responds with single correct character followed by a few
> >    hundred or so replies containing only the overrun status (no
> > data) which are then converted to a bunch of binary zeroes by the
> > ldisc because of the bug I mentioned earlier. After that the chip
> > starts responding with proper data again and works until closed.
> 
> Note that the only "bug" is that the application cannot disable the
> overrun reporting, but why would you want that?

The merits of doing so may be debatable, but if using the quotes
around "bug" is supposed to indicate that it isn't one, I have
to respectfully disagree. I know it is not the most important
thing in the world and without the hardware fault I probably
would not have seen it at all, but I would still call it a bug.

> What's on the other side of the FTDI chip?

Some kind of an optical receiver circuit (the link is optically
isolated). On the other side of that is then the device that sends
periodical data packets (a couple of times per second 17 bytes
each) to the computer. The computer doesn't send anything i.e.
the tx functionality of the chip is not used at all.

> It still sounds like your hardware is broken, but at least you
> seem to have found a work-around.

Like I said, the hw is the real culprit here, there's no doubt
about it. But I also doubt that it's just the individual chip
in my device that has this issue. The device is practically
brand new and while that is no guarantee that there won't be any
faults, I find it much more likely that what I am seeing here is
a quirk of the implementation and there are lots of these chips
with the same issue out there.

The real questions that remain are then; 1. is the chip real or
counterfeit and how am I supposed to know it, 2. how much the
driver can or even should try to accommodate the quirks of
the hw, and 3. does the answer to #2 depend on the answer to #1.

> Perhaps you can report it to the logging-device (?) manufacturer
> or FTDI.

Sure, if I can find someone that cares, which is doubtful.

> What is the "lsusb -v" output for your device by the way.

Bus 002 Device 006: ID 0403:6001 Future Technology Devices
International, Ltd FT232 USB-Serial (UART) IC Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0403 Future Technology Devices International, Ltd
  idProduct          0x6001 FT232 USB-Serial (UART) IC
  bcdDevice            6.00
  iManufacturer           1 FTDI
  iProduct                2 FT232R USB UART
  iSerial                 3 A400EJPK
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower               90mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              2 FT232R USB UART
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
Device Status:     0x0000
  (Bus Powered)

