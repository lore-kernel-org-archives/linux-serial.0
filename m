Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BFEC07E99
	for <linux-serial@archiver.kernel.org>; Mon, 12 Jul 2021 20:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8749461245
	for <linux-serial@archiver.kernel.org>; Mon, 12 Jul 2021 20:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhGLUhc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:37:32 -0400
Received: from fgw20-7.mail.saunalahti.fi ([62.142.5.81]:54381 "EHLO
        fgw20-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230058AbhGLUhc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Jul 2021 16:37:32 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 95ef6bdb-e350-11eb-ba24-005056bd6ce9;
        Mon, 12 Jul 2021 23:34:42 +0300 (EEST)
Date:   Mon, 12 Jul 2021 23:34:41 +0300
From:   andy@surfacebook.localdomain
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: Re: [PATCH V2] serial: 8250_pnp: Support configurable clock frequency
Message-ID: <YOynYT29jF6JwgN/@surfacebook.localdomain>
References: <20210705130010.1231798-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705130010.1231798-1-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Mon, Jul 05, 2021 at 09:00:10PM +0800, Huacai Chen kirjoitti:
> From: Jianmin Lv <lvjianmin@loongson.cn>
> 
> ACPI-based Loongson boards need configurable rather than fixed clock
> frequency for serial ports.

...

>  #include <linux/kernel.h>
>  #include <linux/serial_core.h>
>  #include <linux/bitops.h>
> +#include <linux/property.h>

Can you try to keep it ordered (to some extend), please?

...

>  	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
>  	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
>  		uart.port.flags |= UPF_SHARE_IRQ;
> -	uart.port.uartclk = 1843200;
> +	if (device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk))
> +		uart.port.uartclk = 1843200;
>  	uart.port.dev = &dev->dev;

You can avoid conditional completely by calling 

	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);

here.

-- 
With Best Regards,
Andy Shevchenko


