From: Magnus <magnus-swe@telia.com>
Subject: USB to Serial converter code pl2303
Date: Tue, 18 Feb 2014 02:57:45 +0100
Message-ID: <1392688665.7323.32.camel@mange>
Reply-To: magnus-swe@telia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out12.han.skanova.net ([195.67.226.212]:58666 "EHLO
	smtp-out12.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753411AbaBRCDo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Feb 2014 21:03:44 -0500
Received: from [192.168.0.10] (83.255.132.218) by smtp-out12.han.skanova.net (8.5.133) (authenticated as u26116172)
        id 52C0564D00B9FDC2 for linux-serial@vger.kernel.org; Tue, 18 Feb 2014 02:57:46 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I just bought a Plexgear USB to serial adapter that i wanted to use
for a robot that im building.

This works fine via a serial connection, but now i want my new
Raspberry PI mini computer to handle the chip and it only has USB
unless i connect some special Raspberry converter that i cant buy
where i live atm and dont know if itll work for this kind of
controller chip.

After plugging in the plexgear adapter into my linux boxes:
Fedora 18, Debian 3.11.0-15-generic #25-Ubuntu and weezy it doesnt
send any commands to the servo controller chip on the other side
of the converter.

I can open the port /dev/ttyUSB0 and send to it with stty, but not
a beep on the other side. I have also set the tty Baudrate manually to
2400 but this made no difference. My code does this as well including
setting stopbit
parity and so on.

The robot controller chip only handles 2400 Baud but is fast enough
for the connected servos to spin around as fast as possible.
Those are up to 5 regular rc-servos running on 9 volts and
controlled via a FT639/EDE639 chip that i made some code for
many years ago for Linux.


Some data i get from Linux and Plexgear converter follows:

$ lsmod | grep pl2303
pl2303                 18527  0 
usbserial              38603  1 pl2303


$ lsusb
Bus 005 Device 007: ID 067b:2303 Prolific Technology, Inc.
PL2303 Serial Port

$ lsusb -v

Bus 005 Device 007: ID 067b:2303 Prolific Technology, Inc.
PL2303 Serial Port

Couldn't open device, some information will be missing
(My comment... hmm, but it can read from it ?)..

Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x067b Prolific Technology, Inc.
  idProduct          0x2303 PL2303 Serial Port
  bcdDevice            3.00
  iManufacturer           1 
  iProduct                2 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               1
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
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0

I can code some, but i dont know where to start so any
help on this is highly appreciated.


When i google to find info on adapters i read that
"bMaxPacketSize0 64" indicates that its a counterfeit product
but i paid 250 Swedish for it and that not very cheap for a
univeristy student i think.

This is what it looks like,
(It has a sticker on it saying its from China):
https://serialio.com/sites/default/files/images/USB-RS232-Cable-med-wm1.jpg


Sincerely,
Magnus-swe


