Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72693C433DB
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41ADC64DE9
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 23:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhBXXJV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Feb 2021 18:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbhBXXJV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Feb 2021 18:09:21 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6DC061574
        for <linux-serial@vger.kernel.org>; Wed, 24 Feb 2021 15:08:41 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id d20so4187702oiw.10
        for <linux-serial@vger.kernel.org>; Wed, 24 Feb 2021 15:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rollanet.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wpj+a9V2DGnr0WTvH1xhbbreuTOrd8eGzy9YprlAGH4=;
        b=XZI8d2HAG+PXl7FXfcDlt5TQpLFgtPQetHTJfI6IpBsL/c8Rf8jUVT/rNIWvpSw/aJ
         zd7LIOJIxH1GQTasUEOQHY+vaPowcb3zW67jkoHUr0/s1LBNkT/pGyuDKXqTLPtR7ZUq
         QH115lVITHW2rNwKBRRvd+IbbPhAOu+Rprud4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wpj+a9V2DGnr0WTvH1xhbbreuTOrd8eGzy9YprlAGH4=;
        b=GJx7Zpt1DTqliM+NJzOMZd2qRSFrGq9WBkSS6ZTBHw2sd5K3DL6QhtyfKW+ckFDHu6
         gcIoGO6DXlKQEXt8A1qVnxSRTZgjAciqpHqmlPDDprCHCS/h4xQ2N5K+QA54bI6BTkFe
         4qx4nWp5DRrBAmniJ6B+sOKLRivJga2H3Ve2jQf0Sb2O07N4gX6GEMBm6zqvec/z2Sh9
         6jL+VY1wPrM7IkGj1mC/N29MyI2w0sgV1SSHL6WokgsdgpLDcXgcUI+YYqrg23YsBDbE
         TAikzwOgQsV5fEa0hqYQMhQ8iixZ5mACev8YEO/zm2GNq13LLnnXp2ObCcyrJJM96TX7
         lM9A==
X-Gm-Message-State: AOAM532CPs4IyL96GJ4Hp0f4FZjPFDwXq68Jv9wYAuxajHsHjRK6bJcV
        /1vzaNZl72APiWuuhSOInlUSnTUmdO/fEC/0K2kPd5MP8IU0QzDl
X-Google-Smtp-Source: ABdhPJya/F7ZAHjdEhuzxI9gop64Kvg2YCTi/GZAPPQH+qO1s6iohv/sozlJb/Tenm6AHlcLKegsn5QwvcjJehxIrvg=
X-Received: by 2002:aca:1113:: with SMTP id 19mr4277792oir.32.1614208120498;
 Wed, 24 Feb 2021 15:08:40 -0800 (PST)
MIME-Version: 1.0
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
 <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org> <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org> <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org> <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org> <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <cd92ea17-4e0a-2b6c-1032-9a81727841c9@IEEE.org> <YDPgVZ4GbNq6cGDP@hovoldconsulting.com>
In-Reply-To: <YDPgVZ4GbNq6cGDP@hovoldconsulting.com>
From:   Joe Abbott <jabbott@rollanet.org>
Date:   Wed, 24 Feb 2021 17:08:28 -0600
Message-ID: <CADuz4ON8Jj5unz_eeD--7n5kp2uQmqeyM_2-DTrTFKFwFtoudw@mail.gmail.com>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
To:     Johan Hovold <johan@kernel.org>
Cc:     "Michael G. Katzmann" <michaelk@ieee.org>,
        charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 22, 2021 at 10:48 AM Johan Hovold <johan@kernel.org> wrote:

>
> Joe, would you mind posting the output of "lsusb -v" for your device as
> well?
>
Bus 007 Device 002: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x067b Prolific Technology, Inc.
  idProduct          0x2303 PL2303 Serial Port
  bcdDevice            3.00
  iManufacturer           1 Prolific Technology Inc.
  iProduct                2 USB-Serial Controller
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
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
Device Status:     0x0000
  (Bus Powered)

Also, here's the 110b windows wireshark capture
https://drive.google.com/file/d/1HP5RMRtP11zm4uQNzqlcbILGwebDJaOz/view?usp=sharing

Joe
