Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B51C433E9
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 17:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F19364F08
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 17:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhBXRDo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236022AbhBXRBV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Feb 2021 12:01:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABC9F64DE9;
        Wed, 24 Feb 2021 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614186033;
        bh=K4LPZSrVGm3aU7A42bGOKqPIYD0sHf2htmWn3E3PkIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJLYptc8/miMSA1lF63nDfEyfKzGlEZKWkfPmZaflTcQBUK6f+tPm1Fg5udxV+dV5
         BRMg6CNK6sYaRhg4Yxs8JheQL+vX4Jq81qwpxFNFNbioQ0vc2Okvd50HjCLwpHcEsc
         niSAqd4cefi3qRX0RA02eeZDnbGV965leK46/7ZXJnB31cVN2FIn/KhYAyTRynNx5O
         Sa0Igh7PtxWerF13nTWMFdW0NumtrO/49mtOTZLOubLrh28atyKWZX4Yi2excuAyRr
         b2glSWTnZsa1qSz7KQ9mA4Suslc33UUgDK/M4zLKvEXBCYJ7dbWa+1aD8k3485ey1x
         9hsqiiBU1rLAw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lExWv-0006kQ-A7; Wed, 24 Feb 2021 18:00:53 +0100
Date:   Wed, 24 Feb 2021 18:00:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Charles Yeh <charlesyeh522@gmail.com>
Cc:     "Michael G. Katzmann" <michaelk@ieee.org>,
        =?utf-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
References: <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 24, 2021 at 03:34:43PM +0800, Charles Yeh wrote:
> PL2303HXD
>           ===>Device Descriptor<===
> bLength:                           0x12
> bDescriptorType:                   0x01
> bcdUSB:                          0x0110
> bDeviceClass:                      0x00  -> This is an Interface Class
> Defined Device
> bDeviceSubClass:                   0x00
> bDeviceProtocol:                   0x00
> bMaxPacketSize0:                   0x40 = (64) Bytes
> idVendor:                        0x067B = Prolific Technology, Inc.
> idProduct:                       0x2303
> bcdDevice:                       0x0400
> 
> 
> 
> PL2303TA
>           ===>Device Descriptor<===
> bLength:                           0x12
> bDescriptorType:                   0x01
> bcdUSB:                          0x0200
> bDeviceClass:                      0x00  -> This is an Interface Class
> Defined Device
> bDeviceSubClass:                   0x00
> bDeviceProtocol:                   0x00
> bMaxPacketSize0:                   0x40 = (64) Bytes
> idVendor:                        0x067B = Prolific Technology, Inc.
> idProduct:                       0x2303
> bcdDevice:                       0x0300
> 
> 
> PL2303HX(A)/XA ( EOL : PHASED OUT SINCE 2012 )
>           ===>Device Descriptor<===
> bLength:                           0x12
> bDescriptorType:                   0x01
> bcdUSB:                          0x0110
> bDeviceClass:                      0x00  -> This is an Interface Class
> Defined Device
> bDeviceSubClass:                   0x00
> bDeviceProtocol:                   0x00
> bMaxPacketSize0:                   0x40 = (64) Bytes
> idVendor:                        0x067B = Prolific Technology, Inc.
> idProduct:                       0x2303
> bcdDevice:                       0x0300
> 
> 
> You can use the two fields bcdUSB & bcdDevice to distinguish PL2303HXD
> / PL2303TA / PL2303HX(A)/XA

Thanks a lot, Charles, then we know how to detect the TA.

But can you confirm that your PL2303TA works with the current Linux
driver at 110 Bd (and doesn't need the alternate divisor encoding)?

Johan
