Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D771C433DB
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 16:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CC964ED6
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 16:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhBVQss (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhBVQsq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Feb 2021 11:48:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C688F64ED6;
        Mon, 22 Feb 2021 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614012484;
        bh=MXWBO5J/B4ehCuAjOGHLdM4atFpj8B3PWrif6H43n14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeKbyy0tmr3l0m6/IBkrwfcG7tjyEq2wSF8ie468m4y5KvNxwCCzqjaHX0Jciyhue
         rPzAXXPqXtiKbDy5viGuPNVVFH4dz71XzyrEEsh6YF9NuFL6eLuUEcYBWt/DVRiKjY
         AlFIE6zFtkBJPtyOtPFhvh+rGnF/CKQBH9/81d3LE0mep8tDV8oh56A2geWPhn40ug
         zFO2zf9ECtLYcVK3xsI18i0k5eeLPbUWJy3qCrwW6AQqcWWZeLUPSG+5frOC2bIYoo
         88Z1WVWc2pzK25Y7Yrn/TM0fZOOSrCQ2wgGhLim5hQdOj6ZyqI5/6IWbeEKgK1armG
         Sse9t4ZjZTqpg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lEENh-0006BJ-OF; Mon, 22 Feb 2021 17:48:21 +0100
Date:   Mon, 22 Feb 2021 17:48:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDPgVZ4GbNq6cGDP@hovoldconsulting.com>
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
 <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
 <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
 <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <cd92ea17-4e0a-2b6c-1032-9a81727841c9@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd92ea17-4e0a-2b6c-1032-9a81727841c9@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 22, 2021 at 11:37:30AM -0500, Michael G. Katzmann wrote:

> For reference this is the device I have ...
> 
> Bus 001 Device 011: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
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
>   iManufacturer           1
>   iProduct                2

Would be interesting to compare with a real TA in case this one happens
to be a clone after all.

My HXD has

  bcdDevice            4.00
  iManufacturer           1 Prolific Technology Inc. 
  iProduct                2 USB-Serial Controller D

here.

>   iSerial                 0
>   bNumConfigurations      1

Thanks!

Joe, would you mind posting the output of "lsusb -v" for your device as
well?

Johan
