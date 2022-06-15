Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC43C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 07:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbiFOHdt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiFOHds (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 03:33:48 -0400
X-Greylist: delayed 503 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 00:33:45 PDT
Received: from mail.gtsys.com.hk (tunnel316222-pt.tunnel.tserv25.sin1.ipv6.he.net [IPv6:2001:470:35:5f1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337A44754B
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 00:33:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id BA43422A1D83
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 15:25:17 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vjtFLi9xEl4X for <linux-serial@vger.kernel.org>;
        Wed, 15 Jun 2022 15:25:17 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 97BE522A0306
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 15:25:17 +0800 (HKT)
Received: from [10.128.1.32] (unknown [182.239.120.85])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 773FFC01303
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 15:25:17 +0800 (HKT)
To:     linux-serial@vger.kernel.org
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: serial: usb: cdc-acm: OMRON B5L ToF, device probe failed
Message-ID: <ba16082c-f238-a724-0b13-8d298fa8c07b@gtsys.com.hk>
Date:   Wed, 15 Jun 2022 15:25:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi there,

yet an other cdc-acm which not probed and no /dev/ttyACM0 comes up.

[  539.655588] usb 2-1.4.3: USB disconnect, device number 9
[  568.792182] usb 2-1.4.3: new high-speed USB device number 10 using ehci-pci
[  568.890554] usb 2-1.4.3: New USB device found, idVendor=0590, idProduct=00ca, 
bcdDevice= 2.00
[  568.890562] usb 2-1.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  568.890566] usb 2-1.4.3: Product: OMRON B5L-001011
[  568.890568] usb 2-1.4.3: Manufacturer: OMRON Corporation
[  568.890571] usb 2-1.4.3: SerialNumber: 010000366A1
[  568.945679] cdc_acm 2-1.4.3:1.0: Zero length descriptor references
[  568.945690] cdc_acm: probe of 2-1.4.3:1.0 failed with error -22
[  568.946477] usbcore: registered new interface driver cdc_acm
[  568.946480] cdc_acm: USB Abstract Control Model driver for USB modems and 
ISDN adapters

so I set the quirk in the cdc-acm.c

  { USB_DEVICE(0x0590, 0x00ca), /* Omron b5l */
      .driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
  },

and solved the error.

[  724.148131] usbcore: deregistering interface driver cdc_acm
[  725.766219] usb 2-1.4.3: USB disconnect, device number 10
[  757.467770] usb 2-1.4.3: new high-speed USB device number 11 using ehci-pci
[  757.566100] usb 2-1.4.3: New USB device found, idVendor=0590, idProduct=00ca, 
bcdDevice= 2.00
[  757.566109] usb 2-1.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  757.566113] usb 2-1.4.3: Product: OMRON B5L-001011
[  757.566115] usb 2-1.4.3: Manufacturer: OMRON Corporation
[  757.566117] usb 2-1.4.3: SerialNumber: 010000366A1
[  757.622501] usbcore: registered new interface driver cdc_acm
[  757.622506] cdc_acm: USB Abstract Control Model driver for USB modems and 
ISDN adapters


But the kernel does not create the /dev/ttyACM0.

Kernel is vanilla 5.15.47

lsusb -v get me this.

Bus 002 Device 014: ID 0590:00ca Omron Corp. OMRON B5L-001011
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            2 Communications
   bDeviceSubClass         2 Abstract (modem)
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x0590 Omron Corp.
   idProduct          0x00ca
   bcdDevice            2.00
   iManufacturer           1 OMRON Corporation
   iProduct                2 OMRON B5L-001011
   iSerial                 3 010000366A1
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength       0x002e
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x80
       (Bus Powered)
     MaxPower                4mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           4
       bInterfaceClass         2 Communications
       bInterfaceSubClass      2 Abstract (modem)
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval              16
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x84  EP 4 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval              16
Device Qualifier (for other device speed):
   bLength                10
   bDescriptorType         6
   bcdUSB               2.00
   bDeviceClass            2 Communications
   bDeviceSubClass         2 Abstract (modem)
   bDeviceProtocol         0
   bMaxPacketSize0        64
   bNumConfigurations      1
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0001
   Self Powered


Anything you have in mind?

Thanks
Chris

