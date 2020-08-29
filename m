Return-Path: <SRS0=6ZGZ=CH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DACC433E6
	for <linux-serial@archiver.kernel.org>; Sat, 29 Aug 2020 12:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6282720776
	for <linux-serial@archiver.kernel.org>; Sat, 29 Aug 2020 12:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="YQetjrxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgH2MSU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Aug 2020 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgH2MSI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Aug 2020 08:18:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B1AC061236
        for <linux-serial@vger.kernel.org>; Sat, 29 Aug 2020 05:18:06 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s19so2586251eju.6
        for <linux-serial@vger.kernel.org>; Sat, 29 Aug 2020 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=UyNI8A82T7J0v1q5CuskHwXbDdskl9t8MbNV9vzjZw0=;
        b=YQetjrxXo+49PFGO/B4NQvGxZLUOl57f+gdyG/c3BIOaSfWlRlpxf+4P7hJ7NDmLLr
         S8nYYdoweSuldb5/yOZh3KxG3grn+/JJ5kb9NIeBsljnS91jEbGsX4rsioBUfZ2Uvouk
         SmAmflM2iutjHifHHf5LMo8F3Lej8SPrtOZ8DUX8vKAiyzwWL8qIUrCOYhTKklayj3Ig
         EMqHFiakAh7fOS7yITzRxrQszAaiFDEzfRvZ1O8rEgqcFBaX735sN3hRcOkY1v9WSESB
         AW8XFgjovZ56rnqZmBnsM5A2isoZW78PDa/HOpne0i/p1HJpCDdN7nD4ECyu3pct0ggp
         dNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=UyNI8A82T7J0v1q5CuskHwXbDdskl9t8MbNV9vzjZw0=;
        b=lx2UACQbmfvN6lIXsAElpqAXRQ+CtT0Fi3Y4+8LOoLDH5Cj/hPNz9LiCFdCPKEebNU
         2bxy30ADM7SA+QrQRC/Gt89rDgH1M15OCujk5zRK/fqPSwCU2Hk6nsuz/5zkz9YXQuny
         S/VKsk2WtxgtqV18bwRJhW3QyTd3d6GHvWVNLee0z2stZeiCdHP95vn7UiZQo4HhU8YK
         oryc7eQWlAecTtupFFGpMddyxmK45QYARACH1k/yRywJRXrmtswo/ThmmJ/RL36u3rMB
         7+zvjUuft02kmu2g0hsB70adDFpDVKuCe8bvmndWJNJEHW2van0hfs/9ZLL3uwV20oAO
         ZoPQ==
X-Gm-Message-State: AOAM532Tw9eVRXmShFWbP2G62Ver1xaZHSeVeUiuckiSv7OTxydQW3QH
        vyq19xGHUJPq9EQzPzELHcUFeFzWmsZ3Rl+gswhqfg==
X-Google-Smtp-Source: ABdhPJzpeleEypCJEOY4Bl9GL667HkXbWCcw4oKJfkdgyYbhwyHelyZkvwzg4xbLSZMuDOACnQBFJXKJaQoVhf1aaKo=
X-Received: by 2002:a17:906:b2d7:: with SMTP id cf23mr3244515ejb.113.1598703484685;
 Sat, 29 Aug 2020 05:18:04 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200825133135.807-1-kuldip.dwivedi@puresoftware.com> <20200828081340.GA1007729@kroah.com>
In-Reply-To: <20200828081340.GA1007729@kroah.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFYMMINT3dktr4ITsTIx19Fh9eUdAHG4U3Qqj1fjRA=
Date:   Sat, 29 Aug 2020 17:48:50 +0530
Message-ID: <49b6d38fcb13d2c30c5d14dc5e695f44@mail.gmail.com>
Subject: RE: [PATCH v2] serial: 8250_fsl: Add ACPI support
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
> Sent: Friday, August 28, 2020 1:44 PM
> To: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>; Dmitry Safonov
<0x7f454c46@gmail.com>;
> linux-serial@vger.kernel.org; Vabhav Sharma <vabhav.sharma@nxp.com>;
Pankaj
> Bansal <pankaj.bansal@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: Re: [PATCH v2] serial: 8250_fsl: Add ACPI support
>
> On Tue, Aug 25, 2020 at 07:01:35PM +0530, kuldip dwivedi wrote:
> > This adds support for ACPI enumerated FSL 16550 UARTs.
> > For supporting ACPI, I added a wrapper so that this driver can be used
> > if firmware has exposed the HID "NXP0018" in DSDT table.
> >
> > This will be built as object file if config "SERIAL_8250_FSL"
> > is enabled which depends on config "SERIAL_8250_CONSOLE".
> >
> > Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> > ---
> >
> > Notes:
> >     1. revert the license change from v1
> >     2. revert the file header format change from v1
> >     3. remove extra headers from v1
> >     4. this is tested on layerscape platform LS1046A
> >        with the firmware having ACPI support.
> >
> >        This will be built as object file if config " SERIAL_8250_FSL"
> >        is enabled which depends on config " SERIAL_8250_CONSOLE ".
> >        this driver will be probed if firmware has exposed HID "
> > NXP0018" in DSDT table
> >
> >  drivers/tty/serial/8250/8250_fsl.c | 98
> > ++++++++++++++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_fsl.c
> > b/drivers/tty/serial/8250/8250_fsl.c
> > index 0d0c80905c58..62e5e2d33f69 100644
> > --- a/drivers/tty/serial/8250/8250_fsl.c
> > +++ b/drivers/tty/serial/8250/8250_fsl.c
> > @@ -1,11 +1,16 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#include <linux/acpi.h>
> >  #include <linux/serial_reg.h>
> >  #include <linux/serial_8250.h>
> >
> >  #include "8250.h"
> >
> > +#define DRIVER_NAME		"fsl-ns16550-uart"
>
> Why is this needed?
As this is not standalone module so not required. I added MODULE_ALIAS
but I don't think it is required so I will remove this in v3 PATCH.
>
>
> > +
> >  /*
> >   * Freescale 16550 UART "driver", Copyright (C) 2011 Paul Gortmaker.
> > + * Copyright 2020 NXP
> > + * Copyright 2020 Puresoftware Ltd.
>
> Copyright info goes at the top of the file, not down here.
Old Copyright was already there so I just added our copyright but I will
move
Copyright and file description at top in v3
>
> >   *
> >   * This isn't a full driver; it just provides an alternate IRQ
> >   * handler to deal with an errata.  Everything else is just @@ -20,6
> > +25,10 @@
> >   * IRQ event to the next one.
> >   */
> >
> > +struct fsl8250_data {
> > +	int	line;
> > +};
> > +
> >  int fsl8250_handle_irq(struct uart_port *port)  {
> >  	unsigned char lsr, orig_lsr;
> > @@ -79,3 +88,92 @@ int fsl8250_handle_irq(struct uart_port *port)
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
> > +	port8250.port.mapbase           = regs->start;
> > +	port8250.port.irq               = irq;
> > +	port8250.port.handle_irq        = fsl8250_handle_irq;
> > +	port8250.port.type              = PORT_16550A;
> > +	port8250.port.flags             = UPF_SHARE_IRQ |
UPF_BOOT_AUTOCONF
> > +						| UPF_FIXED_PORT |
> UPF_IOREMAP
> > +						| UPF_FIXED_TYPE;
> > +	port8250.port.dev               = dev;
> > +	port8250.port.mapsize           = resource_size(regs);
> > +	port8250.port.iotype            = UPIO_MEM;
> > +	port8250.port.irqflags          = IRQF_SHARED;
> > +
> > +	port8250.port.membase = devm_ioremap(dev,  port8250.port.mapbase,
> > +
port8250.port.mapsize);
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
> > +static const struct acpi_device_id fsl_8250_acpi_id[] = {
> > +	{ "NXP0018", 0 },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, fsl_8250_acpi_id);
>
> Will this now break the build on non-acpi systems, which the original
driver first
> was written for?
No this will not break on non-acpi systems as irq handler is already
exported
As "fsl8250_handle_irq" and I  have tested this change with ACPI as well
as DT boot.
Safe side I can put acpi specific changes in acpi config macro
"CONFIG_ACPI".
>
> Don't you need some sort of dependancy on ACPI now?
Can you please explain more ?
>
> thanks,
>
> greg k-h
