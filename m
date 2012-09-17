From: "Steven J. Ackerman" <steve-I01wfHm1r9xGyKhy+UYuEA@public.gmane.org>
Subject: Linux USB Serial
Date: Mon, 17 Sep 2012 15:28:56 -0400
Message-ID: <00a301cd950a$ae9081d0$0bb18570$@acscontrol.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: en-us
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello-

Looking to provide support under Linux for our device which implements
a USB virtual  serial port using the Communications Device Class.

The device enumerates and communicates correctly under Windows XP, 
and shows up under lsusb -v command as:

Bus 005 Device 005: ID 0c6a:0005  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            2 Communications
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0c6a 
  idProduct          0x0005 
  bcdDevice            1.00
  iManufacturer           1 ACS
  iProduct                2 ACS-LCD-Color-320x240
  iSerial                 3 1.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           67
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass     32 
      bInterfaceProtocol      0 
      iInterface              0 
      CDC Header:
        bcdCDC               1.10
      CDC ACM:
        bmCapabilities       0x02
          line coding and serial state
      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1 
      CDC Call Management:
        bmCapabilities       0x00
        bDataInterface          1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval             255
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
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
Device Status:     0x0000
  (Bus Powered)

However it does not show up without the -verbose option.

Trying to load the usbserial module to activate the device results in the 
following error:

FATAL: Module vendor=0x0c6a not found.

Can anyone provide assistance in how to troubleshoot why Linux is 
not happy with this USB device ?

Thank you,

Steven J. Ackerman, Consultant
ACS, Sarasota, FL
http://www.acscontrol.com
mailto:steve-I01wfHm1r9xGyKhy+UYuEA@public.gmane.org




--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
