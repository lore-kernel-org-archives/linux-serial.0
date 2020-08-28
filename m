Return-Path: <SRS0=9Cit=CG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18DDC433E6
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC18520C56
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598602420;
	bh=Zp8K4vddXscFNJB+koD6++cG3sBRN6nFAw1ORyFBsyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=afgRb4GzqtkJ0bJvTgKOGcFQytkt4HKME01QypoVEwvLTLIbCDgY6MB1sUwNLJBp3
	 ebO4mcGmdgEcgm6zah31kXQVKKSO5tDB472Tbcv/bSlzPBRVDHUaaxipwxEB3WJOBq
	 F7WBB2+jnLX1iuTmkLc882Aeu4Bsxt0vCw2mUd2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH1INk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgH1IN2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Aug 2020 04:13:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A39920665;
        Fri, 28 Aug 2020 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598602407;
        bh=Zp8K4vddXscFNJB+koD6++cG3sBRN6nFAw1ORyFBsyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXjswc1Ej+in+j37dVLAKMe3ZeYvEKZM12N9ilvAbuXpPuo7A+WZN+Z48PRMCRB5p
         rCvAxlKtAHczT/W5zwpW5yHJ2O4Dok+Zc+C0IMPc8CH+7iJ3x6FbpsSLW8cc8IUSEV
         2YOrrTpcaBm0vg0ABq8jEF5gcYVTDQX5LkQwP85o=
Date:   Fri, 28 Aug 2020 10:13:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-serial@vger.kernel.org,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [PATCH v2] serial: 8250_fsl: Add ACPI support
Message-ID: <20200828081340.GA1007729@kroah.com>
References: <20200825133135.807-1-kuldip.dwivedi@puresoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825133135.807-1-kuldip.dwivedi@puresoftware.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 25, 2020 at 07:01:35PM +0530, kuldip dwivedi wrote:
> This adds support for ACPI enumerated FSL 16550 UARTs.
> For supporting ACPI, I added a wrapper so that this driver
> can be used if firmware has exposed the HID "NXP0018" in
> DSDT table.
> 
> This will be built as object file if config "SERIAL_8250_FSL"
> is enabled which depends on config "SERIAL_8250_CONSOLE".
> 
> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> ---
> 
> Notes:
>     1. revert the license change from v1
>     2. revert the file header format change from v1
>     3. remove extra headers from v1
>     4. this is tested on layerscape platform LS1046A
>        with the firmware having ACPI support.
>     
>        This will be built as object file if config " SERIAL_8250_FSL"
>        is enabled which depends on config " SERIAL_8250_CONSOLE ".
>        this driver will be probed if firmware has exposed HID " NXP0018" in DSDT table
> 
>  drivers/tty/serial/8250/8250_fsl.c | 98 ++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
> index 0d0c80905c58..62e5e2d33f69 100644
> --- a/drivers/tty/serial/8250/8250_fsl.c
> +++ b/drivers/tty/serial/8250/8250_fsl.c
> @@ -1,11 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/acpi.h>
>  #include <linux/serial_reg.h>
>  #include <linux/serial_8250.h>
>  
>  #include "8250.h"
>  
> +#define DRIVER_NAME		"fsl-ns16550-uart"

Why is this needed?


> +
>  /*
>   * Freescale 16550 UART "driver", Copyright (C) 2011 Paul Gortmaker.
> + * Copyright 2020 NXP
> + * Copyright 2020 Puresoftware Ltd.

Copyright info goes at the top of the file, not down here.

>   *
>   * This isn't a full driver; it just provides an alternate IRQ
>   * handler to deal with an errata.  Everything else is just
> @@ -20,6 +25,10 @@
>   * IRQ event to the next one.
>   */
>  
> +struct fsl8250_data {
> +	int	line;
> +};
> +
>  int fsl8250_handle_irq(struct uart_port *port)
>  {
>  	unsigned char lsr, orig_lsr;
> @@ -79,3 +88,92 @@ int fsl8250_handle_irq(struct uart_port *port)
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
> +	port8250.port.mapbase           = regs->start;
> +	port8250.port.irq               = irq;
> +	port8250.port.handle_irq        = fsl8250_handle_irq;
> +	port8250.port.type              = PORT_16550A;
> +	port8250.port.flags             = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
> +						| UPF_FIXED_PORT | UPF_IOREMAP
> +						| UPF_FIXED_TYPE;
> +	port8250.port.dev               = dev;
> +	port8250.port.mapsize           = resource_size(regs);
> +	port8250.port.iotype            = UPIO_MEM;
> +	port8250.port.irqflags          = IRQF_SHARED;
> +
> +	port8250.port.membase = devm_ioremap(dev,  port8250.port.mapbase,
> +							port8250.port.mapsize);
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
> +static const struct acpi_device_id fsl_8250_acpi_id[] = {
> +	{ "NXP0018", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, fsl_8250_acpi_id);

Will this now break the build on non-acpi systems, which the original
driver first was written for?

Don't you need some sort of dependancy on ACPI now?

thanks,

greg k-h
