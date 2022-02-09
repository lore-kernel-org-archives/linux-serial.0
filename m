Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33789C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  9 Feb 2022 12:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiBIMD5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiBIMDc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80518DF28ADF
        for <linux-serial@vger.kernel.org>; Wed,  9 Feb 2022 03:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19809B8203E
        for <linux-serial@vger.kernel.org>; Wed,  9 Feb 2022 11:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B0EC340E7;
        Wed,  9 Feb 2022 11:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644406252;
        bh=+o1peUzqHoB2kOycrTBvPMWbnbTJdM7wmBzQA1hJiJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/U8P1JJMOO2qffiyHkzLVcwrbU0T4CQqmCi77DNPwqt8mPmX0eN5dse+HO4kNNBe
         CeOQLwnMc+Cl9bINK63MtU2tCG/LdIzu5F+vvSKc2UqutD/crn3zEiqf5mp0lWTO9c
         +0YpesDcAdJfs0nMZG+5l89eEz2idTGG4FCjw2m4=
Date:   Wed, 9 Feb 2022 12:30:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     linux-serial@vger.kernel.org, Sundararaman.H@microchip.com,
        Ronnie.Kunin@microchip.com, Tharunkumar.Pasumarthi@microchip.com,
        Annirudh.D@microchip.com, Pragash.Mangalapandian@microchip.com
Subject: Re: Reg: Serial port driver for microchip's new PCIe UART device
Message-ID: <YgOl6SFsKnZxkbFy@kroah.com>
References: <CH0PR11MB538034CCE6C1868DB7BD8127E92E9@CH0PR11MB5380.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR11MB538034CCE6C1868DB7BD8127E92E9@CH0PR11MB5380.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 09, 2022 at 10:38:34AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> Dear Greg KH,
> 
> I am Kumaravel Thiagarajan from Microchip India.
> 
> We are working on a PCIe based multi-instance UART device.
> Based on the Linux community feedback few months back, we had written it as a custom driver inside drivers/tty/serial/8250.
> Now this custom driver is requiring a DWORD FIFO access for both Tx and Rx, and I am in the process of changing my driver code.

Why does the hardware not follow the normal standard here?

And are you sure it will still not fit into the 8250 format?

> Can I model my custom driver on serial drivers present in drivers/tty/serial/ directory?

You could, but it would be much smaller and easier to use the 8250
framework given that you probably do have an 8250-like device, right?

> I am implementing my functions for uart_ops structure and the necessary ISR in a separate file mchp_pci1xxxx_uart.c inside the drivers/tty/serial/ directory.
> 
> I wish this custom UART driver to get through Linux community submission.
> Do you see any risk in this approach? Do you have any suggestions?

Let's see the code before we can give you any firm answers.

good luck!

greg k-h
