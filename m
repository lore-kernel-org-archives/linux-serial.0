From: "Tony Murray" <murraytony@gmail.com>
Subject: Patch: Correct Sierra Wireless USB EVDO Modem Device ID
Date: Fri, 22 Aug 2008 17:30:44 -0500
Message-ID: <2f5034170808221530h6bea5dc9hcb63a839a9589d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:53325 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbYHVWaq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Aug 2008 18:30:46 -0400
Received: by ik-out-1112.google.com with SMTP id c28so464252ika.5
        for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2008 15:30:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: klloyd@sierrawireless.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

I was trying to figure out why my device wasn't supported by the
drivers/usb/serial/sierra.c driver, while looking throught the device
IDs I spotted what I believe to be a typo in the device IDs.  Please
apply the following patch:

--- drivers/usb/serial/sierra.c.orig    2008-08-22 16:55:00.000000000 -0500
+++ drivers/usb/serial/sierra.c 2008-08-22 17:08:55.000000000 -0500
@@ -185,7 +185,7 @@
        { USB_DEVICE(0x1199, 0x0017) }, /* Sierra Wireless EM5625 */
        { USB_DEVICE(0x1199, 0x0018) }, /* Sierra Wireless MC5720 */
        { USB_DEVICE(0x1199, 0x0218) }, /* Sierra Wireless MC5720 */
-       { USB_DEVICE(0x0f30, 0x1b1d) }, /* Sierra Wireless MC5720 */
+       { USB_DEVICE(0x03f0, 0x1b1d) }, /* HP ev2200 a.k.a MC5720 */
        { USB_DEVICE(0x1199, 0x0020) }, /* Sierra Wireless MC5725 */
        { USB_DEVICE(0x1199, 0x0220) }, /* Sierra Wireless MC5725 */
        { USB_DEVICE(0x1199, 0x0019) }, /* Sierra Wireless AirCard 595 */


If you look down further, there is another HP wireless broadband card,
which has a vendor ID of 03f0, like my device.  Below is my "lsusb -v
-d 03f0:1b1d".

Bus 001 Device 005: ID 03f0:1b1d Hewlett-Packard
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x03f0 Hewlett-Packard
  idProduct          0x1b1d
  bcdDevice            0.01
  iManufacturer           1 HP
  iProduct                2 HP ev2200 1xEV-DO Broadband Wireless Module
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           67
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           7
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              3 Data Interface
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval             128
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
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
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
Device Status:     0x0000
  (Bus Powered)


Tony Murray

PS: Sorry about the multi-list spam, but I was unsure exactly to send this.
