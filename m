From: David Robillard <david.robillard@gmail.com>
Subject: Re: Edgeport/416 io_edgeport problem.
Date: Tue, 18 Dec 2012 11:56:47 -0500
Message-ID: <CADH15Ghu3VqwZ-XFHzMFHjcYwkP-q0P9LudTyckgO15Xeq_N0Q@mail.gmail.com>
References: <CADH15GikmfJh+nFbMFVcrW8RB8pmLsJvhtutue7L7iq8+7sdHQ@mail.gmail.com>
	<20121214095220.1be799ee@pyramind.ukuu.org.uk>
	<CADH15GiJeTmL=WPNoc_8g17AkzyrU4w-jRB0H2wy_+OoGGQByQ@mail.gmail.com>
	<20121215020331.GA21221@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:56872 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab2LRRXQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Dec 2012 12:23:16 -0500
Received: by mail-la0-f53.google.com with SMTP id w12so791713lag.12
        for <linux-serial@vger.kernel.org>; Tue, 18 Dec 2012 09:23:15 -0800 (PST)
In-Reply-To: <20121215020331.GA21221@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Hello Greg,

Thanks for the suggestion. See my comments below.

> This looks good, so you should be able to talk to the device, the fact
> that it returns -ENODEV is odd.

I totally agree here.

> Can you do the following from a command line as root:
> Clear out the kernel log:
>         dmesg -c
> remove the io_edgeport driver
>         rmmod io_edgeport
> Unplug the device.
> load the edgeport driver with debugging enabled:
>         modprobe io_edgeport debug=1

Everytime I try this with kernel 3.7.0-1.el6.elrepo.i686 I always get
this error :

FATAL: Error inserting io_edgeport
(/lib/modules/3.7.0-1.el6.elrepo.i686/kernel/drivers/usb/serial/io_edgeport.ko):
Invalid argument

I've tried different syntaxes, but it always fails.

Meanwhile, I power cycled the Edgeport/416 device and now kernel
3.7.0-1.el6.elrepo.i686 can see all 16 ports. But I still can't access
any of the /dev/ttyUSB* devices.

So I installed kernel 2.6.32-279.14.1.el6.i686 from the base CentOS
repository and this time the sudo modprobe io_edgeport debug=1 command
worked (i.e. I was able to load the kernel module without the invalid
argument error). This kernel has io_edgeport module version 2.7.

> plug the device in.
>
> Try to access the device
>         cat /dev/ttyUSB0

I'm still on kernel and I still get this error :

open("/dev/ttyUSB0", O_RDONLY|O_LARGEFILE) = -1 ENODEV (No such device)

I tried both module sides (i.e. ttyUSB0 and ttyUSB10) as this unit is
basically two 8 port switches bundled together. Both sides fail with
the ENODEV error.

> Send us the output of the kernel log:
>         dmesg

Here goes :

usbcore: registered new interface driver usbserial
USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial Driver core
USB Serial support registered for Edgeport 2 port adapter
USB Serial support registered for Edgeport 4 port adapter
USB Serial support registered for Edgeport 8 port adapter
USB Serial support registered for EPiC device
usbcore: registered new interface driver io_edgeport
io_edgeport: v2.7:Edgeport USB Serial Driver
usb 1-2: new full speed USB device number 2 using ohci_hcd
usb 1-2: New USB device found, idVendor=0451, idProduct=2077
usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-2: Product: General Purpose USB Hub
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 7 ports detected
usb 1-2.5: new full speed USB device number 3 using ohci_hcd
usb 1-2.5: New USB device found, idVendor=1608, idProduct=0012
usb 1-2.5: New USB device strings: Mfr=1, Product=2, SerialNumber=5
usb 1-2.5: Product: Edgeport/416
usb 1-2.5: Manufacturer: Inside Out Networks
usb 1-2.5: SerialNumber: V70430350-0
usb 1-2.5: configuration #1 chosen from 1 choice
io_edgeport 1-2.5:1.0: Edgeport 8 port adapter converter detected
drivers/usb/serial/io_edgeport.c: get_string - USB String ID = 1
drivers/usb/serial/io_edgeport.c: get_string - USB String Inside Out Networks
drivers/usb/serial/io_edgeport.c: get_string - USB String ID = 2
drivers/usb/serial/io_edgeport.c: get_string - USB String Edgeport/416G
usb 1-2.5: Inside Out Networks Edgeport/416G detected
drivers/usb/serial/io_edgeport.c: get_epic_descriptor result = -32
drivers/usb/serial/io_edgeport.c: getting manufacturer descriptor
drivers/usb/serial/io_edgeport.c: rom_read - ff, 7c00, 960
drivers/usb/serial/io_edgeport.c: **Manufacturer Descriptor
drivers/usb/serial/io_edgeport.c:   RomSize:        8K
drivers/usb/serial/io_edgeport.c:   RamSize:        32K
drivers/usb/serial/io_edgeport.c:   CpuRev:         1
drivers/usb/serial/io_edgeport.c:   BoardRev:       1
drivers/usb/serial/io_edgeport.c:   NumPorts:       8
drivers/usb/serial/io_edgeport.c:   DescDate:       11/2/2000
drivers/usb/serial/io_edgeport.c:   SerialNumber: V70430350-0
drivers/usb/serial/io_edgeport.c:   AssemblyNumber:
drivers/usb/serial/io_edgeport.c:   OemAssyNumber:
drivers/usb/serial/io_edgeport.c:   UartType:       1
drivers/usb/serial/io_edgeport.c:   IonPid:         18
drivers/usb/serial/io_edgeport.c:   IonConfig:      0
drivers/usb/serial/io_edgeport.c: getting boot descriptor
drivers/usb/serial/io_edgeport.c: rom_read - ff, 7fc0, 64
drivers/usb/serial/io_edgeport.c: **Boot Descriptor:
drivers/usb/serial/io_edgeport.c:   BootCodeLength: 7044
drivers/usb/serial/io_edgeport.c:   MajorVersion:   1
drivers/usb/serial/io_edgeport.c:   MinorVersion:   13
drivers/usb/serial/io_edgeport.c:   BuildNumber:    7
drivers/usb/serial/io_edgeport.c:   Capabilities:   0x1
drivers/usb/serial/io_edgeport.c:   UConfig0:       241
drivers/usb/serial/io_edgeport.c:   UConfig1:       127
drivers/usb/serial/io_edgeport.c: **Product Information:
drivers/usb/serial/io_edgeport.c:   ProductId             12
drivers/usb/serial/io_edgeport.c:   NumPorts              8
drivers/usb/serial/io_edgeport.c:   ProdInfoVer           0
drivers/usb/serial/io_edgeport.c:   IsServer              0
drivers/usb/serial/io_edgeport.c:   IsRS232               1
drivers/usb/serial/io_edgeport.c:   IsRS422               0
drivers/usb/serial/io_edgeport.c:   IsRS485               0
drivers/usb/serial/io_edgeport.c:   RomSize               8
drivers/usb/serial/io_edgeport.c:   RamSize               32
drivers/usb/serial/io_edgeport.c:   CpuRev                1
drivers/usb/serial/io_edgeport.c:   BoardRev              1
drivers/usb/serial/io_edgeport.c:   BootMajorVersion      1.13.7
drivers/usb/serial/io_edgeport.c:   FirmwareMajorVersion  0.0.0
drivers/usb/serial/io_edgeport.c:   ManufactureDescDate   11/2/2000
drivers/usb/serial/io_edgeport.c:   iDownloadFile         0xff
drivers/usb/serial/io_edgeport.c:   EpicVer               0
drivers/usb/serial/io_edgeport.c: edge_startup - time 1 495604
usb 1-2.5: firmware: requesting edgeport/down.fw
drivers/usb/serial/io_edgeport.c: downloading firmware version (930) 1.16.4
drivers/usb/serial/io_edgeport.c: sram_write - ff, 0, 6
drivers/usb/serial/io_edgeport.c: sram_write - ff, b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 13, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 1b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 23, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 2b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 33, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 3b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 43, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 4b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 53, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 7b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 80, 7
drivers/usb/serial/io_edgeport.c: sram_write - ff, 3000, 2178
drivers/usb/serial/io_edgeport.c: sram_write - ff, 4000, 15381
drivers/usb/serial/io_edgeport.c: sram_write - ff, 7fc6, 4
drivers/usb/serial/io_edgeport.c: sram_write - ff, 7c15, 330
drivers/usb/serial/io_edgeport.c: sending exec_dl_code
drivers/usb/serial/io_edgeport.c: edge_startup - time 2 496829
usb 1-2.5: firmware: requesting edgeport/boot.fw
drivers/usb/serial/io_edgeport.c: Current Boot Image version 1.13.7
drivers/usb/serial/io_edgeport.c: Boot Image -- already up to date
drivers/usb/serial/io_edgeport.c: edge_startup - time 3 496849
drivers/usb/serial/io_edgeport.c:   FirmwareMajorVersion  0.0.4
usb 1-2.5: Edgeport 8 port adapter converter now attached to ttyUSB0
usb 1-2.5: Edgeport 8 port adapter converter now attached to ttyUSB1
usb 1-2.5: Edgeport 8 port adapter converter now attached to ttyUSB2
usb 1-2.5: Edgeport 8 port adapter converter now attached to ttyUSB3
usb 1-2.5: Edgeport 8 port adapter converter now attached to ttyUSB4
usb 1-2.5: Edgeport 8 port adapter converter now attached to ttyUSB5
usb 1-2.5: Edgeport 8 port adapter converter now attached to ttyUSB6
usb 1-2.5: Edgeport 8 port adapter converter now attached to ttyUSB7
usb 1-2.6: new full speed USB device number 4 using ohci_hcd
usb 1-2.6: New USB device found, idVendor=1608, idProduct=0012
usb 1-2.6: New USB device strings: Mfr=1, Product=2, SerialNumber=5
usb 1-2.6: Product: Edgeport/416
usb 1-2.6: Manufacturer: Inside Out Networks
usb 1-2.6: SerialNumber: V70430350-1
usb 1-2.6: configuration #1 chosen from 1 choice
io_edgeport 1-2.6:1.0: Edgeport 8 port adapter converter detected
drivers/usb/serial/io_edgeport.c: get_string - USB String ID = 1
drivers/usb/serial/io_edgeport.c: get_string - USB String Inside Out Networksb
drivers/usb/serial/io_edgeport.c: get_string - USB String ID = 2
drivers/usb/serial/io_edgeport.c: get_string - USB String Edgeport/416G
usb 1-2.6: Inside Out Networksb Edgeport/416G detected
drivers/usb/serial/io_edgeport.c: get_epic_descriptor result = -32
drivers/usb/serial/io_edgeport.c: getting manufacturer descriptor
drivers/usb/serial/io_edgeport.c: rom_read - ff, 7c00, 960
drivers/usb/serial/io_edgeport.c: **Manufacturer Descriptor
drivers/usb/serial/io_edgeport.c:   RomSize:        8K
drivers/usb/serial/io_edgeport.c:   RamSize:        32K
drivers/usb/serial/io_edgeport.c:   CpuRev:         1
drivers/usb/serial/io_edgeport.c:   BoardRev:       1
drivers/usb/serial/io_edgeport.c:   NumPorts:       8
drivers/usb/serial/io_edgeport.c:   DescDate:       11/2/2000
drivers/usb/serial/io_edgeport.c:   SerialNumber: V70430350-1
drivers/usb/serial/io_edgeport.c:   AssemblyNumber:
drivers/usb/serial/io_edgeport.c:   OemAssyNumber:
drivers/usb/serial/io_edgeport.c:   UartType:       1
drivers/usb/serial/io_edgeport.c:   IonPid:         18
drivers/usb/serial/io_edgeport.c:   IonConfig:      0
drivers/usb/serial/io_edgeport.c: getting boot descriptor
drivers/usb/serial/io_edgeport.c: rom_read - ff, 7fc0, 64
drivers/usb/serial/io_edgeport.c: **Boot Descriptor:
drivers/usb/serial/io_edgeport.c:   BootCodeLength: 7044
drivers/usb/serial/io_edgeport.c:   MajorVersion:   1
drivers/usb/serial/io_edgeport.c:   MinorVersion:   13
drivers/usb/serial/io_edgeport.c:   BuildNumber:    7
drivers/usb/serial/io_edgeport.c:   Capabilities:   0x1
drivers/usb/serial/io_edgeport.c:   UConfig0:       241
drivers/usb/serial/io_edgeport.c:   UConfig1:       127
drivers/usb/serial/io_edgeport.c: **Product Information:
drivers/usb/serial/io_edgeport.c:   ProductId             12
drivers/usb/serial/io_edgeport.c:   NumPorts              8
drivers/usb/serial/io_edgeport.c:   ProdInfoVer           0
drivers/usb/serial/io_edgeport.c:   IsServer              0
drivers/usb/serial/io_edgeport.c:   IsRS232               1
drivers/usb/serial/io_edgeport.c:   IsRS422               0
drivers/usb/serial/io_edgeport.c:   IsRS485               0
drivers/usb/serial/io_edgeport.c:   RomSize               8
drivers/usb/serial/io_edgeport.c:   RamSize               32
drivers/usb/serial/io_edgeport.c:   CpuRev                1
drivers/usb/serial/io_edgeport.c:   BoardRev              1
drivers/usb/serial/io_edgeport.c:   BootMajorVersion      1.13.7
drivers/usb/serial/io_edgeport.c:   FirmwareMajorVersion  0.0.0
drivers/usb/serial/io_edgeport.c:   ManufactureDescDate   11/2/2000
drivers/usb/serial/io_edgeport.c:   iDownloadFile         0xff
drivers/usb/serial/io_edgeport.c:   EpicVer               0
drivers/usb/serial/io_edgeport.c: edge_startup - time 1 497118
usb 1-2.6: firmware: requesting edgeport/down.fw
drivers/usb/serial/io_edgeport.c: downloading firmware version (930) 1.16.4
drivers/usb/serial/io_edgeport.c: sram_write - ff, 0, 6
drivers/usb/serial/io_edgeport.c: sram_write - ff, b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 13, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 1b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 23, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 2b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 33, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 3b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 43, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 4b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 53, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 7b, 3
drivers/usb/serial/io_edgeport.c: sram_write - ff, 80, 7
drivers/usb/serial/io_edgeport.c: sram_write - ff, 3000, 2178
drivers/usb/serial/io_edgeport.c: sram_write - ff, 4000, 15381
drivers/usb/serial/io_edgeport.c: sram_write - ff, 7fc6, 4
drivers/usb/serial/io_edgeport.c: sram_write - ff, 7c15, 330
drivers/usb/serial/io_edgeport.c: sending exec_dl_code
drivers/usb/serial/io_edgeport.c: edge_startup - time 2 498316
usb 1-2.6: firmware: requesting edgeport/boot.fw
drivers/usb/serial/io_edgeport.c: Current Boot Image version 1.13.7
drivers/usb/serial/io_edgeport.c: Boot Image -- already up to date
drivers/usb/serial/io_edgeport.c: edge_startup - time 3 498329
drivers/usb/serial/io_edgeport.c:   FirmwareMajorVersion  0.0.4
usb 1-2.6: Edgeport 8 port adapter converter now attached to ttyUSB8
usb 1-2.6: Edgeport 8 port adapter converter now attached to ttyUSB9
usb 1-2.6: Edgeport 8 port adapter converter now attached to ttyUSB10
usb 1-2.6: Edgeport 8 port adapter converter now attached to ttyUSB11
usb 1-2.6: Edgeport 8 port adapter converter now attached to ttyUSB12
usb 1-2.6: Edgeport 8 port adapter converter now attached to ttyUSB13
usb 1-2.6: Edgeport 8 port adapter converter now attached to ttyUSB14
usb 1-2.6: Edgeport 8 port adapter converter now attached to ttyUSB15
drivers/usb/serial/io_edgeport.c: edge_open - port 0
drivers/usb/serial/io_edgeport.c: send_iosp_ext_cmd - 0, 0
edgeport_8 ttyUSB0: write_cmd_usb - length = 3, data = c8 00 00
drivers/usb/serial/io_edgeport.c: write_cmd_usb - ALLOCATE URB
c17b3240 (outstanding 1)
drivers/usb/serial/io_edgeport.c: edge_bulk_out_cmd_callback
drivers/usb/serial/io_edgeport.c: edge_bulk_out_cmd_callback - FREE
URB c17b3240 (outstanding 0)
drivers/usb/serial/io_edgeport.c: edge_open - open timedout
drivers/usb/serial/io_edgeport.c: edge_open - port 10
drivers/usb/serial/io_edgeport.c: send_iosp_ext_cmd - 0, 0
edgeport_8 ttyUSB10: write_cmd_usb - length = 3, data = ca 00 00
drivers/usb/serial/io_edgeport.c: write_cmd_usb - ALLOCATE URB
f613aae0 (outstanding 1)
drivers/usb/serial/io_edgeport.c: edge_bulk_out_cmd_callback
drivers/usb/serial/io_edgeport.c: edge_bulk_out_cmd_callback - FREE
URB f613aae0 (outstanding 0)
drivers/usb/serial/io_edgeport.c: edge_open - open timedout

> Hopefully that should show us what is going on here.

Indeed.

I'm no expert of kernel modules, but what I see and I don't understand
is those lines...

drivers/usb/serial/io_edgeport.c: downloading firmware version (930) 1.16.4

...then...

drivers/usb/serial/io_edgeport.c: Current Boot Image version 1.13.7
drivers/usb/serial/io_edgeport.c: Boot Image -- already up to date

...but didn't it download version 1.16.4 and now it's saying that
1.13.7 is up to date? Unless these are different firmware for
different parts of the unit.

Also, the driver seems to be hitting a timeout when it tries to open a
port. This error shows up for both /dev/ttyUSB0 and /dev/ttyUSB10 :

drivers/usb/serial/io_edgeport.c: edge_open - open timedout

Maybe we can increase the timeout value in the driver? Again, I'm no
expert, just trying to help :)

> thanks,
>
> greg k-h

Thank you for your help,

David
