Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F40C07E99
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jul 2021 12:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DFB613C1
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jul 2021 12:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhGEMix (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhGEMiw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Jul 2021 08:38:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F15F46135F;
        Mon,  5 Jul 2021 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625488576;
        bh=xR/GpZr+pK4IpeOWXwUMQwgyZcxgtOC7o07oAsnXuqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYLSyMuVev1YvhN14fIOlKRz0OTKAT7url6QfM9fH0mBVrZ8zKnG9vJ5yFnJmjHob
         7m5Qbx/Wxv3G3Z3V//0+4+qgvndlIcwwIbTICf05jq5VbTKFmxAX4EfYq51zRKu9G8
         +HkS5fByDAO8xdOZXh83U4+iKJ/Cb6x73YfBJU4U=
Date:   Mon, 5 Jul 2021 14:36:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     linux-serial@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: Re: [PATCH] serial: 8250_pnp: Support configurable clock frequency
Message-ID: <YOL8uo7tJ5TDpUNI@kroah.com>
References: <20210705121238.1223921-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705121238.1223921-1-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 05, 2021 at 08:12:38PM +0800, Huacai Chen wrote:
> From: Jianmin Lv <lvjianmin@loongson.cn>
> 
> ACPI-based Loongson boards need configurable rather than fixed clock
> frequency for serial ports.
> 
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/tty/serial/8250/8250_pnp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
> index de90d681b64c..5f8fc724ba46 100644
> --- a/drivers/tty/serial/8250/8250_pnp.c
> +++ b/drivers/tty/serial/8250/8250_pnp.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/serial_core.h>
>  #include <linux/bitops.h>
> +#include <linux/property.h>
>  
>  #include <asm/byteorder.h>
>  
> @@ -474,7 +475,9 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>  	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
>  	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
>  		uart.port.flags |= UPF_SHARE_IRQ;
> -	uart.port.uartclk = 1843200;
> +	if (device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk)) {
> +		uart.port.uartclk = 1843200;
> +	}
>  	uart.port.dev = &dev->dev;
>  
>  	line = serial8250_register_8250_port(&uart);
> -- 
> 2.27.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
