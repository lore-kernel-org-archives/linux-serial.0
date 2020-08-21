Return-Path: <SRS0=3upM=B7=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32741C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 21 Aug 2020 08:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2E12078D
	for <linux-serial@archiver.kernel.org>; Fri, 21 Aug 2020 08:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="OI+X44M3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgHUIHw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgHUIHv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Aug 2020 04:07:51 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA93C061385
        for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2020 01:07:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so1283523eje.7
        for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2020 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=Cfeb5A9q8GlOghomiM27GDveEKVsPnFsnPAZ81hLNfE=;
        b=OI+X44M3+gVsb56OSrbxHSOQJmIWju7ckFZSTFvusZXG4jYUMixKSsd/+7FW09LpTV
         zdVuyiw94voAy+oaYxbPftcrEB+pakq/SFwYYo8PwCT6DOq/9uaQAeld/9AqXsUPS4jK
         TSouvkwr0Ki5/YiBh2jjuQ+DV9T/N+NEYCOi/MDLUw7GANbZj8Ty48RV6oxqnbo1Xdn/
         E/WsJtvumo2LYjF6MzMhH8ZQACCodrJKj84dp48uvGYvIXcc77hfDtexXbB9zyJzPymK
         TxRsdHe8yW+pvPIWhBPKCUWwSppGe5yHEP4kyQAn4kho/Ct3ENYovtPj4g+NpcWWj7O1
         VIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=Cfeb5A9q8GlOghomiM27GDveEKVsPnFsnPAZ81hLNfE=;
        b=gO3S14CDHeBCOg+Xj0MRqYGo6K/C4bVDlrPiMzak5eW9zvcVcikTZZj/wpNgrPcACA
         07fVoqLldWQ+XFXDumyys91BxyZC7msulr7CCGdeZkRgihjFaABYh5V9MB60ZZoQBcke
         +xAruHTzF0BkRMvFzezr9Cod0KIVhryUtK2jrpxDUJ0licvPBnXaknjayS1DIrKaKR+H
         yhBBlE6Zvi4P9RTLk9SdpwBm0h6kzDvRsGB2org1lB8xwewnxPuneDnijTTruSWlQASv
         sapRUExX5F+FsbUStKcbqvKfz1paOkWDLXyJkhUhR0L0SUns6oOPSV7yT+BUi6Ncs5IX
         1qzQ==
X-Gm-Message-State: AOAM530X8Jq9cIDTtP7cTjU8DT+XU2fBlCt9pZ/RTALZo9YxDIV66uZv
        M5+2vQZNf0BzdDb1Gs3gqdF6i0ngS/bb+HXLcn0FVA==
X-Google-Smtp-Source: ABdhPJwtCu0c8TO8UbhNQDJdzOPELtssFZh3ZfiJjVi5P4+leOCTyGGVn1XcSyQIuo9/MTABQqA29TnidEW3IZevnZM=
X-Received: by 2002:a17:906:e118:: with SMTP id gj24mr1659044ejb.219.1597997269629;
 Fri, 21 Aug 2020 01:07:49 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200819152935.3182-1-kuldip.dwivedi@puresoftware.com> <20200819153518.GA3684861@kroah.com>
In-Reply-To: <20200819153518.GA3684861@kroah.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIDgctPRSbXiOw3RDAXISnQeeYAqgJR+QGdqNV0ZjA=
Date:   Fri, 21 Aug 2020 13:37:47 +0530
Message-ID: <dd106690608758902cd617b2a36461f1@mail.gmail.com>
Subject: RE: [PATCH] serial: 8250_fsl: Add ACPI support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-serial@vger.kernel.org,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, August 19, 2020 9:05 PM
> To: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>; Dmitry Safonov
<0x7f454c46@gmail.com>;
> linux-serial@vger.kernel.org; Vabhav Sharma <vabhav.sharma@nxp.com>;
Pankaj
> Bansal <pankaj.bansal@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: Re: [PATCH] serial: 8250_fsl: Add ACPI support
>
> On Wed, Aug 19, 2020 at 08:59:35PM +0530, kuldip dwivedi wrote:
> > This adds support for ACPI enumerated FSL 16550 UARTs.
>
> Why?  We need more information here than just this, please.
Currently there is  the support of DT only for 8250 in 8250_of.c.
For adding ACPI support, I added a wrapper so that this driver can be used
if
firmware has exposed the support of HID "NXP0018" in DSDT table.
>
> >
> > Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> > ---
> >  drivers/tty/serial/8250/8250_fsl.c | 147
> > +++++++++++++++++++++++++----
> >  1 file changed, 131 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_fsl.c
> > b/drivers/tty/serial/8250/8250_fsl.c
> > index 0d0c80905c58..49e5987e538b 100644
> > --- a/drivers/tty/serial/8250/8250_fsl.c
> > +++ b/drivers/tty/serial/8250/8250_fsl.c
> > @@ -1,24 +1,50 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +// SPDX-License-Identifier: GPL-2.0+
>
> Why are you changing the license of this file?  Are you _SURE_ you are
allowed to
> do that?
I will revert this in v2 PATCH
>
> > +//
> > +// Freescale 16550 UART "driver"
> > +//
> > +// Copyright (C) 2011 Paul Gortmaker.
> > +// Copyright 2020 NXP
> > +// Copyright 2020 Puresoftware Ltd
> > +//
> > +// This isn't a full driver; it just provides an alternate IRQ //
> > +handler to deal with an errata.  Everything else is just // using the
> > +bog standard 8250 support.
> > +//
> > +// We follow code flow of serial8250_default_handle_irq() but add //
> > +a check for a break and insert a dummy read on the Rx for the //
> > +immediately following IRQ event.
> > +//
> > +// We re-use the already existing "bug handling" lsr_saved_flags //
> > +field to carry the "what we just did" information from the one // IRQ
> > +event to the next one.
>
> /* */ is nicer for file headers, please.
Agree, will Fix this in v2 PATCH
>
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>
> > +
> >  #include <linux/serial_reg.h>
> >  #include <linux/serial_8250.h>
> >
> > +
> > +#include <asm/byteorder.h>
>
> Why the extra blank lines here?  And why asm/ ?  what do you need from
that?
asm/ and extra blank line is not required here. Will fix this in v2 PATCH
>
> > +
> >  #include "8250.h"
> >
> > -/*
> > - * Freescale 16550 UART "driver", Copyright (C) 2011 Paul Gortmaker.
> > - *
> > - * This isn't a full driver; it just provides an alternate IRQ
> > - * handler to deal with an errata.  Everything else is just
> > - * using the bog standard 8250 support.
> > - *
> > - * We follow code flow of serial8250_default_handle_irq() but add
> > - * a check for a break and insert a dummy read on the Rx for the
> > - * immediately following IRQ event.
> > - *
> > - * We re-use the already existing "bug handling" lsr_saved_flags
> > - * field to carry the "what we just did" information from the one
> > - * IRQ event to the next one.
> > - */
> > +#define DRIVER_NAME "fsl-ns16550-uart"
> > +
> > +struct fsl8250_data {
> > +	int			line;
> > +};
> >
> >  int fsl8250_handle_irq(struct uart_port *port)  { @@ -79,3 +105,92 @@
> > int fsl8250_handle_irq(struct uart_port *port)
> >  	return 1;
> >  }
> >  EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
> > +
> > +static int fsl8250_acpi_probe(struct platform_device *pdev) {
> > +	struct fsl8250_data *data;
> > +	struct uart_8250_port port8250;
> > +	struct device *dev = &pdev->dev;
> > +	struct resource *regs;
> > +
> > +	int ret, irq;
> > +
> > +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!regs) {
> > +		dev_err(dev, "no registers defined\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		if (irq != -EPROBE_DEFER)
> > +			dev_err(dev, "cannot get irq\n");
> > +		return irq;
> > +	}
> > +
> > +	memset(&port8250, 0, sizeof(port8250));
> > +
> > +	ret = device_property_read_u32(dev, "clock-frequency",
> > +					&port8250.port.uartclk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	spin_lock_init(&port8250.port.lock);
> > +
> > +	port8250.port.mapbase		= regs->start;
> > +	port8250.port.irq		= irq;
> > +	port8250.port.handle_irq	= fsl8250_handle_irq;
> > +	port8250.port.type		= PORT_16550A;
> > +	port8250.port.flags		= UPF_SHARE_IRQ |
> UPF_BOOT_AUTOCONF
> > +						| UPF_FIXED_PORT |
> UPF_IOREMAP
> > +						| UPF_FIXED_TYPE;
> > +	port8250.port.dev		= dev;
> > +	port8250.port.mapsize		= resource_size(regs);
> > +	port8250.port.iotype		= UPIO_MEM;
> > +	port8250.port.irqflags		= IRQF_SHARED;
> > +
> > +	port8250.port.membase = devm_ioremap(dev,  port8250.port.mapbase,
> > +						port8250.port.mapsize);
> > +	if (!port8250.port.membase)
> > +		return -ENOMEM;
> > +
> > +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	data->line = serial8250_register_8250_port(&port8250);
> > +	if (data->line < 0)
> > +		ret = data->line;
> > +
> > +	platform_set_drvdata(pdev, data);
> > +	return 0;
> > +}
> > +
> > +static int fsl8250_acpi_remove(struct platform_device *pdev) {
> > +	struct fsl8250_data *data = platform_get_drvdata(pdev);
> > +
> > +	serial8250_unregister_port(data->line);
> > +	return 0;
> > +}
> > +
> > +static const struct acpi_device_id fsl8250_acpi_match[] = {
> > +	{ "NXP0018", 0 },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, fsl8250_acpi_match);
> > +
> > +static struct platform_driver fsl8250_platform_driver = {
> > +	.driver = {
> > +		.name			= "fsl-16550-uart",
> > +		.acpi_match_table	= ACPI_PTR(fsl8250_acpi_match),
> > +	},
> > +	.probe			= fsl8250_acpi_probe,
> > +	.remove			= fsl8250_acpi_remove,
> > +};
> > +
> > +module_platform_driver(fsl8250_platform_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("FSL 8250 serial port driver");
> > +MODULE_ALIAS("platform:" DRIVER_NAME);
> > --
> > 2.17.1
> >
>
> Are you _sure_ this will work properly with the build system?  You are
> turning an individual file into a stand-alone module, but you didn't
> touch any build files.
Yes, this is tested on layerscape platform LS1046A with the firmware
having ACPI support.
This will be built as object file if config " SERIAL_8250_FSL" is enabled
which depends on
config " SERIAL_8250_CONSOLE ". this driver will be probed
if firmware has exposed HID " NXP0018" in DSDT table.
>
> thanks,
>
> greg k-h
