Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00C2C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 15:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E62D64E5C
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 15:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhBWPoV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 10:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233296AbhBWPoU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 10:44:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C729664E5C;
        Tue, 23 Feb 2021 15:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614095016;
        bh=WAhVeOGLACocx02ucbRxzqV77x8vxbUrpijOrxw1cOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcDEX5ZhJmQSRsolvEFH6or4hxSJ6VLZ+vJiVamhvYllLvtdVOETvRYRmIk3FAOCB
         /GmCwayejVtt9RFxpDjEnStacpXJDiBvqF5H80T6xVB0OyEegwhl47q2j9JqH3oBjJ
         MU2uo8zOTTL3w6bIpxifeBSUJpjK8vDjWPJaIsSktniKjm4KVzyCp94N++Yad69jv7
         0qvU6XEs24lSjyssi7p2fRrjqlglMQNiir/dkuld/RwSCAJ292ZcRtb4kSSt9kJUsy
         mQido7Opmrq7beVf/h1xhHASJrdKx4MBzR1Kt7XbKFX5ZNTtPGNUDv38PjCPceBmeq
         +aSBHB4Elx63A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lEZqq-0004Qf-MQ; Tue, 23 Feb 2021 16:43:53 +0100
Date:   Tue, 23 Feb 2021 16:43:52 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
 <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
 <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
 <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 23, 2021 at 09:58:47AM -0500, Michael G. Katzmann wrote:

> Well I found I have another Prolific device here that I got from
> Adafruit (https://www.adafruit.com/product/954)
> 
> It also has a Prolific 2303 and behaves exactly like the other one.
> i.e. with the current Linux driver it gives a very high baudrate when
> set to 110 bd and gives 110bd when the modifications are made to the
> driver that I found.

Interesting.

> Is it that we are presuming that what Prolific is telling us is true
> and only Joe and I are actually measuring the data rate?  (i.e. why
> does the Prolific Windows driver set the values as Joe found ???)

I'm starting to think they've added some alternate baud rate encoding in
order to make life harder for the people pushing (or unknowingly buying)
counterfeit devices.

As you say, why else would the Windows driver support this encoding?

The driver might be triggering on the device descriptors or some control
request so having a packet trace might provide some insight.

I think Joe may already have collected one?
 
> Adafruit device:
> 
> Bus 001 Device 013: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x067b Prolific Technology, Inc.
>   idProduct          0x2303 PL2303 Serial Port
>   bcdDevice            3.00
>   iManufacturer           1 Prolific Technology Inc.
>   iProduct                2 USB-Serial Controller
>   iSerial                 0
>   bNumConfigurations      1

Johan
