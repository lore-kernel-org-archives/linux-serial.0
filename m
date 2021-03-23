Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D418BC433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFB361963
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCWJcU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCWJcG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 05:32:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CACC61582;
        Tue, 23 Mar 2021 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616491926;
        bh=ISW4ToMWWfftZ2yf9jhDSf9JFXYLhQme4XKt3jgCRjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wZSlrB2vWiVbiTgIZ5SnH6KGwtHEPE20SUal2S4ZXeykFUqiaQLSnMN0Eqe7ZSKxR
         sgQbXGkn0HCc69T0sfUi3tPCW+VcCYwn8D3QVo/+1ECUK2Y7nn6PauBQFP17fu+BdC
         NQhyhN/5ZrHfHQlONfaNrLUdJ1+kn+U+oIwvrsVg=
Date:   Tue, 23 Mar 2021 10:32:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Zago <frank@zago.net>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/1] [RFC] USB: serial: ch341: Add I2C support to CH341
 driver
Message-ID: <YFm1kzrPJ00HhoHR@kroah.com>
References: <4286affb-bed1-0fc1-1d07-a5cb8d475fb1@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4286affb-bed1-0fc1-1d07-a5cb8d475fb1@zago.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 22, 2021 at 10:22:54PM -0500, Frank Zago wrote:
> The Winchiphead CH341 IC is more than a UART interface. Amongst other
> things, it can talk to an I2C bus.
> 
> Several people have contributed to an out of tree driver: Tse Lun
> Bien, Marco Gittler and Till Harbaum.
> 
>   https://github.com/allanbian1017/i2c-ch341-usb.git
> 
> This commit integrates the I2C portions into the CH341 serial driver
> and exposes the I2C device.
> 
> Tested with a CH341A, CH341B and CH341T.
> 
> Signed-off-by: Frank Zago <frank@zago.net>
> ---
> 
> I didn't find a way to say a USB device has several functions. I
> followed what the CP210x driver did with gpio, but I think it's a
> hack. The private data for the I2C part should be linked to the USB
> device, not the serial port. It works here and in the cp210x driver
> because there is only 1 serial port in the device. If it had 2 or more
> ports, I believe bad things would happen. So is there a better way to
> handle USB devices like that?
> 
> For info, the CH341A/B supports 3 different modes, each with a different
> USB PID, usually selected by jumpers. All of them support I2C, but
> only 2 support UART, one supports SPI and 2 support GPIOs.
> 
> 
>  drivers/usb/serial/Kconfig |   4 +-
>  drivers/usb/serial/ch341.c | 284 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 283 insertions(+), 5 deletions(-)

$ ./scripts/get_maintainer.pl --file drivers/usb/serial/ch341.c
Johan Hovold <johan@kernel.org> (maintainer:USB SERIAL SUBSYSTEM)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
linux-usb@vger.kernel.org (open list:USB SERIAL SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Please always send patches to the proper people and mailing lists,
otherwise it will be lost :(

thanks,

greg k-h
