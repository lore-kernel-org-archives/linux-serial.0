Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3D4C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 11 Mar 2022 13:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348998AbiCKN4k (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Mar 2022 08:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbiCKN4j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Mar 2022 08:56:39 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400B41C4B1B;
        Fri, 11 Mar 2022 05:55:35 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id h11so12133522ljb.2;
        Fri, 11 Mar 2022 05:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75zvCJ9zIPmwZGQt+Vs2mthvfxo+EmGaG+QYamw7P3A=;
        b=md56CzXWXhmUpVPInmuiE8Z/dNrOp6r/QcbzXWzvjslwt4ivvbYrJS3MfbuuSXz9Hz
         XdD5VedSYbVcTbbeZ/Z0zvl+t4A0X02pXT69eZZlWHmvyzx44uL3fw2JRzdc0XWDOIZQ
         Rm5t+Ax/r4FVK4wlqfw5VdlIMLEerW8nglZ/5IQHEEqLjPMjHCEXKocQOiwv3qfr5VaM
         JSBV83VZGmD6Dj+kdwRFk7QuNNNjhtLOlvDo0xx045RTm4Opalv5k5JcCrFb3DnM6dt8
         nVwdIfJRNo+MDKxVT7+6TzBZsVj2digKADY9ax2jCPq9ePc5zRPpnsV2qq6PcdbP3NZ8
         zKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75zvCJ9zIPmwZGQt+Vs2mthvfxo+EmGaG+QYamw7P3A=;
        b=GMYvGkmmvjcT+l4giu3C2B9V4hLtg9usiBWK5LxqasUNCEyY4QAzlV47bFn7/YsRRC
         ZD2vHcwb3fxdL7m/uLeWTdDiZ+j+imRcfVHGWCzf+LD+kPEWI+L/zavHVeMdBchB/A3/
         ePSF0o7r1Sl4z8jronEzkTpEs2k6NgeYVEBq2tCc5vMcv55PQpPsbVfHHSaSl21ZQdAj
         HKtdLCIE6R/sxSRX08Stxuct9+U7G/XDpYn8IcNyAmD8uBhjHHuOn05qa/UtiAJAHYGw
         a6Pc4ygLsaSgVZSVZ6DAkfwKvPCGlPpbBdZG7TFQSRViXXx3fP5ZGFDi4QRmnn070nWN
         cyLg==
X-Gm-Message-State: AOAM530qDIgjNflO/V2an5huXdxxaZZ+lvp8mzeHxQSSOkwyPd5fcdvK
        2jv1WaZwBbVwZ0/Jhn6tAGINPKWa8Qw=
X-Google-Smtp-Source: ABdhPJxOd6V5XF19FodfxgZpNZ7Jtlep1EIgaHiVzRVT5lA3r+HIL12cmKhjHTdgDpZOo2Bf8n+jLA==
X-Received: by 2002:a05:651c:905:b0:247:e451:48a5 with SMTP id e5-20020a05651c090500b00247e45148a5mr5948012ljq.313.1647006933035;
        Fri, 11 Mar 2022 05:55:33 -0800 (PST)
Received: from dev-box.local ([213.134.179.138])
        by smtp.googlemail.com with ESMTPSA id l26-20020a2e701a000000b002463f024de9sm1745892ljc.110.2022.03.11.05.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:55:32 -0800 (PST)
From:   Dawid Buchwald <buchwald.dawid@gmail.com>
To:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     johan@kernel.org
Subject: [PATCH] USB: serial: pl2303: Add support for PL2303GS
Date:   Fri, 11 Mar 2022 14:55:31 +0100
Message-Id: <20220311135531.12832-1-buchwald.dawid@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is the issue I have with recently acquired PL2303 adapter:

[   70.502848] usb 1-2: new full-speed USB device number 5 using xhci_hcd
[   70.652523] usb 1-2: New USB device found, idVendor=067b,
idProduct=23f3, bcdDevice= 6.05
[   70.652533] usb 1-2: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[   70.652538] usb 1-2: Product: USB-Serial Controller
[   70.652540] usb 1-2: Manufacturer: Prolific Technology Inc.
[   70.652543] usb 1-2: SerialNumber: CJAKj19B616
[   70.674558] usbcore: registered new interface driver usbserial_generic
[   70.674578] usbserial: USB Serial support registered for generic
[   70.677490] usbcore: registered new interface driver pl2303
[   70.677498] usbserial: USB Serial support registered for pl2303
[   70.677510] pl2303 1-2:1.0: pl2303 converter detected
[   70.677513] pl2303 1-2:1.0: unknown device type, please report to
linux-usb@vger.kernel.org

lsusb -v -d 067b:23f3

Bus 001 Device 005: ID 067b:23f3 Prolific Technology, Inc. USB-Serial Controller 
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x067b Prolific Technology, Inc.
  idProduct          0x23f3 
  bcdDevice            6.05
  iManufacturer           1 Prolific Technology Inc. 
  iProduct                2 USB-Serial Controller 
  iSerial                 3 CJAKj19B616
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0027
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
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

Signed-off-by: Dawid Buchwald <buchwald.dawid@gmail.com>

---
 drivers/usb/serial/pl2303.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index a70fd86f735c..1072f8eb6ab9 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -435,6 +435,7 @@ static int pl2303_detect_type(struct usb_serial *serial)
 		case 0x105:
 		case 0x305:
 		case 0x405:
+		case 0x605:
 			/*
 			 * Assume it's an HXN-type if the device doesn't
 			 * support the old read request value.
-- 
2.32.0

