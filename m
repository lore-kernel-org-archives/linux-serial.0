Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0031C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 20 Dec 2021 09:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhLTJ53 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Dec 2021 04:57:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38746 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLTJ53 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Dec 2021 04:57:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B8C9B80C8D
        for <linux-serial@vger.kernel.org>; Mon, 20 Dec 2021 09:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D59C36AE9;
        Mon, 20 Dec 2021 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639994246;
        bh=zG1YTF2hwQikANUz6g64f90GRKHqoDlKF42L2/HNaW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEsU3bVLH45N9fd/7kCpkfwaUhqWCph6yJ8QT+VstWtMVvmCi8oIpCtBrXs1KSXUX
         FwPPcXpGqMeI811obpzifsCbcB6MUtFxHX+GIAFmjMcVl9ZUW4JqUw/s9wmtsxEJk4
         Kv6UNpcHYB9Ny3sNj4RyQbS20qNFa9m9JRQrwMFU=
Date:   Mon, 20 Dec 2021 10:57:24 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Miao, Jun" <jun.miao@intel.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [BUG report]: serial8250 unbind/bind failture
Message-ID: <YcBThJYwRk1i9emo@kroah.com>
References: <DM6PR11MB47391ECD2402AB4F521DAC869A7B9@DM6PR11MB4739.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB47391ECD2402AB4F521DAC869A7B9@DM6PR11MB4739.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 20, 2021 at 09:54:41AM +0000, Miao, Jun wrote:
> [Hardware]
> Intel Corporation Alder Lake Client Platform/AlderLake-M LP5 RVP, BIOS ADLPFWI1.R00.2265.A01.2107010436 07/01/2021
> About x86 old UART, not the PNP device.
> 
> [how to reproduce]
> root@ALD-M:/sys/devices/platform/serial8250/tty/ttyS0/device/driver# echo -n "serial8250" > unbind
> root@ALD-M:/sys/devices/platform/serial8250/tty/ttyS0/device/driver# echo -n "serial8250" > bind

After you unbound, this device is gone, so how does this path still
work?

> [What`s my Confusion]
> After the unbind and bind the serial8250_probe cannot register ttyS0.

Then do not do that :)

> And there is not dmesg like this: "serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A".
> 
> Any one have some advice about 8250 serial ?  It is a common operation if we believe that the old UART which don`t support like this unbind. Or we ignore about this really bug before?

What are you trying to do here exactly?  Why are you wanting to unbind
the driver from this device?  Why do you then want to bind it again?
What problem are you trying to solve by doing this?

thanks,

greg k-h
