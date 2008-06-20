From: "Josh Hammond" <jhammond-qGaTmy9+pjn8wb0/L2CcF0B+6BGkLq7r@public.gmane.org>
Subject: Accessing USB thermometer sensor
Date: Fri, 20 Jun 2008 15:28:05 +0200 (CEST)
Message-ID: <8b08c39f01286180748bbc0eeddc56cb.squirrel@webmail.vp44.net>
Reply-To: jhammond-qGaTmy9+pjn8wb0/L2CcF0B+6BGkLq7r@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-c-programming-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello to everybody.
I have recently purchased a USB thermometer from a chinese ebay store.
The sensor has no brand whatsoever and just carries the "TEMPer" label.

I plugged it to my debian unstable box (with a vanilla 2.6.24.4 kernel)
and it was detected as

4348:5523 WinChipHead USB->RS 232 adapter with Prolifec PL 2303 chipset

I believe this means that it is, at least partly, accessible by a linux
system (although it seems to do some weird USB-serial emulation).
I am now trying to access the thermometer, and more specifically be able
to read the data it provides.

I realize this is a very broad question, but could somebody point me in
the right direction to be able to read the temperature from command
line?
The only serial experience I have is connecting to a switch's console and
configuring it with putty/minicom.

I pasted the outputs from syslog and lsusb but I dont' really see how
the latter relates to my problem.
Thanks to everyone that will respond, since now I feel quite lost.

Josh




dmesg:

usb 1-2.2: new full speed USB device using ehci_hcd and address 9
usb 1-2.2: configuration #1 chosen from 1 choice
pl2303 1-2.2:1.0: pl2303 converter detected
usb 1-2.2: pl2303 converter now attached to ttyUSB0


lsusb -v:

Bus 001 Device 009: ID 4348:5523 WinChipHead USB->RS 232 adapter with
Prolifec PL 2303 chipset
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x4348 WinChipHead
  idProduct          0x5523 USB->RS 232 adapter with Prolifec PL 2303
chipset
  bcdDevice            2.50
  iManufacturer           0
  iProduct                2 USB-SER!
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
    MaxPower               78mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol      2
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)




--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
