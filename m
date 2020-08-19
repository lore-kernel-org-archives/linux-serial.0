Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A41AC433E1
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 15:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040A220888
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597851299;
	bh=Pyt1m/KVEyQ5O3OhE4xvSYZIJxh25I6hcg5HpYHtkg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZT4HBcOoHu6E7AlSGCpVk9SMHIHZxV+8DeYlwmBpeQ84YkP0CtmtGXy3OMqUUkxXX
	 KmzEBimG6gEBSTWyR/RAzIV7/sH/5DFRxyuFh6aDl1XdcM0MhhxfEGb0TKp3UsutKg
	 m475VWQkoNdHp7QvIObFjqm40w//Yb3O5LZAFNuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHSPe6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgHSPe5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 11:34:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13451207FF;
        Wed, 19 Aug 2020 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597851296;
        bh=Pyt1m/KVEyQ5O3OhE4xvSYZIJxh25I6hcg5HpYHtkg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYCaGHjqykW3fGHKdRNzTlEYrYQsI0YMLhoexiYJN7B4a3J1VjqdeEhS4vAot62/x
         mVrpvJ0o//NuyvJQe1LS6OUrPh9SffjV+M5/kwCh/DdTD9xWgEBBS5Jo+cAqzzzC44
         65wmsk8AP/QPvvU+FaTkwMBVsPvi7zG+vd8VBDIw=
Date:   Wed, 19 Aug 2020 17:35:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-serial@vger.kernel.org,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [PATCH] serial: 8250_fsl: Add ACPI support
Message-ID: <20200819153518.GA3684861@kroah.com>
References: <20200819152935.3182-1-kuldip.dwivedi@puresoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819152935.3182-1-kuldip.dwivedi@puresoftware.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 19, 2020 at 08:59:35PM +0530, kuldip dwivedi wrote:
> This adds support for ACPI enumerated FSL 16550 UARTs.

Why?  We need more information here than just this, please.

> 
> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> ---
>  drivers/tty/serial/8250/8250_fsl.c | 147 +++++++++++++++++++++++++----
>  1 file changed, 131 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
> index 0d0c80905c58..49e5987e538b 100644
> --- a/drivers/tty/serial/8250/8250_fsl.c
> +++ b/drivers/tty/serial/8250/8250_fsl.c
> @@ -1,24 +1,50 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+

Why are you changing the license of this file?  Are you _SURE_ you are
allowed to do that?

> +//
> +// Freescale 16550 UART "driver"
> +//
> +// Copyright (C) 2011 Paul Gortmaker.
> +// Copyright 2020 NXP
> +// Copyright 2020 Puresoftware Ltd
> +//
> +// This isn't a full driver; it just provides an alternate IRQ
> +// handler to deal with an errata.  Everything else is just
> +// using the bog standard 8250 support.
> +//
> +// We follow code flow of serial8250_default_handle_irq() but add
> +// a check for a break and insert a dummy read on the Rx for the
> +// immediately following IRQ event.
> +//
> +// We re-use the already existing "bug handling" lsr_saved_flags
> +// field to carry the "what we just did" information from the one
> +// IRQ event to the next one.

/* */ is nicer for file headers, please.

> +
> +#include <linux/acpi.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
>  #include <linux/serial_reg.h>
>  #include <linux/serial_8250.h>
>  
> +
> +#include <asm/byteorder.h>

Why the extra blank lines here?  And why asm/ ?  what do you need from
that?

> +
>  #include "8250.h"
>  
> -/*
> - * Freescale 16550 UART "driver", Copyright (C) 2011 Paul Gortmaker.
> - *
> - * This isn't a full driver; it just provides an alternate IRQ
> - * handler to deal with an errata.  Everything else is just
> - * using the bog standard 8250 support.
> - *
> - * We follow code flow of serial8250_default_handle_irq() but add
> - * a check for a break and insert a dummy read on the Rx for the
> - * immediately following IRQ event.
> - *
> - * We re-use the already existing "bug handling" lsr_saved_flags
> - * field to carry the "what we just did" information from the one
> - * IRQ event to the next one.
> - */
> +#define DRIVER_NAME "fsl-ns16550-uart"
> +
> +struct fsl8250_data {
> +	int			line;
> +};
>  
>  int fsl8250_handle_irq(struct uart_port *port)
>  {
> @@ -79,3 +105,92 @@ int fsl8250_handle_irq(struct uart_port *port)
>  	return 1;
>  }
>  EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
> +
> +static int fsl8250_acpi_probe(struct platform_device *pdev)
> +{
> +	struct fsl8250_data *data;
> +	struct uart_8250_port port8250;
> +	struct device *dev = &pdev->dev;
> +	struct resource *regs;
> +
> +	int ret, irq;
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!regs) {
> +		dev_err(dev, "no registers defined\n");
> +		return -EINVAL;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(dev, "cannot get irq\n");
> +		return irq;
> +	}
> +
> +	memset(&port8250, 0, sizeof(port8250));
> +
> +	ret = device_property_read_u32(dev, "clock-frequency",
> +					&port8250.port.uartclk);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock_init(&port8250.port.lock);
> +
> +	port8250.port.mapbase		= regs->start;
> +	port8250.port.irq		= irq;
> +	port8250.port.handle_irq	= fsl8250_handle_irq;
> +	port8250.port.type		= PORT_16550A;
> +	port8250.port.flags		= UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
> +						| UPF_FIXED_PORT | UPF_IOREMAP
> +						| UPF_FIXED_TYPE;
> +	port8250.port.dev		= dev;
> +	port8250.port.mapsize		= resource_size(regs);
> +	port8250.port.iotype		= UPIO_MEM;
> +	port8250.port.irqflags		= IRQF_SHARED;
> +
> +	port8250.port.membase = devm_ioremap(dev,  port8250.port.mapbase,
> +						port8250.port.mapsize);
> +	if (!port8250.port.membase)
> +		return -ENOMEM;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->line = serial8250_register_8250_port(&port8250);
> +	if (data->line < 0)
> +		ret = data->line;
> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +}
> +
> +static int fsl8250_acpi_remove(struct platform_device *pdev)
> +{
> +	struct fsl8250_data *data = platform_get_drvdata(pdev);
> +
> +	serial8250_unregister_port(data->line);
> +	return 0;
> +}
> +
> +static const struct acpi_device_id fsl8250_acpi_match[] = {
> +	{ "NXP0018", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, fsl8250_acpi_match);
> +
> +static struct platform_driver fsl8250_platform_driver = {
> +	.driver = {
> +		.name			= "fsl-16550-uart",
> +		.acpi_match_table	= ACPI_PTR(fsl8250_acpi_match),
> +	},
> +	.probe			= fsl8250_acpi_probe,
> +	.remove			= fsl8250_acpi_remove,
> +};
> +
> +module_platform_driver(fsl8250_platform_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("FSL 8250 serial port driver");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> -- 
> 2.17.1
> 

Are you _sure_ this will work properly with the build system?  You are
turning an individual file into a stand-alone module, but you didn't
touch any build files.

thanks,

greg k-h
