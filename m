Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED5FC47096
	for <linux-serial@archiver.kernel.org>; Thu,  3 Jun 2021 07:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9884A613E3
	for <linux-serial@archiver.kernel.org>; Thu,  3 Jun 2021 07:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFCHP0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCHPZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Jun 2021 03:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78A9360230;
        Thu,  3 Jun 2021 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622704421;
        bh=NuHhNENlieeBM2HXwZyCbFcahLXbLDbLR/1wZf//oVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyTtmCJ8SGhUC8if/iKnyQoJrnTTj1xEY1+gunT+tFTzB6qHtI6xu2X1qwnJFPCgF
         hRS7EC8PNMeMh30F+EufuUr7lhOziXZWK/egBBfOTwBKZ0aFzrsTdByzZ8Xnt9+iO1
         C31Lh2kXlQtdkpBxr5XDlsOS7dO0BSmbz70P96NY=
Date:   Thu, 3 Jun 2021 09:13:38 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Raviteja Narayanam <rna@xilinx.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "jslaby@suse.com" <jslaby@suse.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: Re: Need suggestion for 'access_type' of AMBA pl011 serial driver
Message-ID: <YLiBIvkMVKA96Q5g@kroah.com>
References: <SN6PR02MB40936F8F2879AD5CFDFC80D2CA3C9@SN6PR02MB4093.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB40936F8F2879AD5CFDFC80D2CA3C9@SN6PR02MB4093.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 03, 2021 at 07:03:25AM +0000, Raviteja Narayanam wrote:
> Hi,
> 
> The uart peripheral on Xilinx Versal platform is ARM primecell.
> Our environment is 32-bit access type but the ARM primecell uart in pl011 driver has default 16 bit access type. 
> (https://github.com/torvalds/linux/blob/master/drivers/tty/serial/amba-pl011.c#L2665 access_32b is false for 'vendor_arm')
> This is causing asynchronous abort on our platform when any UART register is written from the pl011 driver.
> 
> Need suggestion on how we can address this issue and if the below approach is fine.
> 
> As this is platform specific issue, we can have a new device tree property (memory_access_type), specifying the 32 bit type.
> In the probe function, override the behavior (uap->port.iotype) if this property is present in DT.
> In this way, we can have support for our SOC, without breaking any legacy ones.

There is no other way to determine what this device is other than
platform data?  Why not just set the vendor id in your device to a new
one and provide a correct setting in that new vendor data structure,
like all other devices for this chip have done before?

If it is the same id, and works differently, then that is a hardware
issue that you need to take up with your hardware designers to get fixed
as that is obviously a problem.

thanks,

greg k-h
