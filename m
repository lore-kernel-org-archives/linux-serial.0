Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7ADC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 14:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E0C61002
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 14:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhETObb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 10:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236853AbhETOb3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 10:31:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFD4861002;
        Thu, 20 May 2021 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621521007;
        bh=DwkT+nQymoBm5mEDw50KxpS1sTtx5DPSq6uiROs6fx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v0kK+vQb6CCfEXNMqvKXTPIWzmEKVvm8T1pZjg4R7x1j0Z2heovIq0Pm5JLpbLpaR
         Vk5ofpXLNVXNbK7kgOedujHBJKLyV0HFUr6QzUWlVquXpGUUGSQ6jvmN8PRRkvm74b
         GaeTeak/FyZrcrAmGuAjRmwwzGJmoZDzQTisVuiM=
Date:   Thu, 20 May 2021 16:30:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     cernekee@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: rp2: disable interrupt in rp2_probe():
Message-ID: <YKZybdcwoI1eMbzj@kroah.com>
References: <1620991027-25856-1-git-send-email-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620991027-25856-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 14, 2021 at 11:17:07AM +0000, Zheyu Ma wrote:
> In 'rp2_probe', the driver registers 'rp2_uart_interrupt' then calls
> 'rp2_fw_cb' through 'request_firmware_nowait'. In 'rp2_fw_cb', if the
> firmware don't exists, function just return without initializing ports
> of 'rp2_card'. But now the interrupt handler function has been registered,
> and when an interrupt comes('rp2' may shares an interrupt line with other
> devices), 'rp2_uart_interrupt' may access those ports then causing NULL
> pointer dereference or other bugs.
> 
> Fix this by disabling interrupt after registering 'rp2_uart_interrupt',
> and enable it in 'rp2_uart_startup'.

What prevents an interrupt from coming in right after callin
rp2_uart_interrupt()?  The driver has to be able to handle that.  Why is
the interrupt being registered before the firmware is loaded?  That
should be the proper fix as once you register an interrupt, the driver
HAS to be able to properly handle it.

thanks,

greg k-h
