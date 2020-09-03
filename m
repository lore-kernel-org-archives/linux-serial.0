Return-Path: <SRS0=JhiI=CM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02FDC433E9
	for <linux-serial@archiver.kernel.org>; Thu,  3 Sep 2020 11:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE237206A5
	for <linux-serial@archiver.kernel.org>; Thu,  3 Sep 2020 11:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="SyCdGVqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgICLhs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgICLhf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Sep 2020 07:37:35 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5115C061245
        for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2020 04:37:13 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so2355892edk.0
        for <linux-serial@vger.kernel.org>; Thu, 03 Sep 2020 04:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=mkc7E1vGI7JIcGluVlJsrfdoh7WemG/hYFtaIt2ZnDA=;
        b=SyCdGVqvoChNph3WNVi1q6O1EhbLJ+ns1hA1krYeKUZAlQWheTgHar+NB40GLzS7q3
         ztmeiTnj9BgWfHpFiI4KeBbFm3PKxCdRjArabN9vGqFs/o3T3p5hiqPH+sEECYkbxb9w
         ZXl8d84n+itWB+U136L/sB8QMXMhiY2zbQyE/pJChhWweWe/3npQLg8kgggLUj3ek2eB
         ClW6OLGoL6yEBGvYxl1RJAmEUa0SgU4/g61aj/yxpln2wNeop39SXV22ge0z3N/LwH/V
         VWs3Ve+aBZiLxkxOjxQo3BR9rGtPcg0muTpeOUVIRdh6i76mqA1YVRl4OZ5tesDTNYpf
         T3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=mkc7E1vGI7JIcGluVlJsrfdoh7WemG/hYFtaIt2ZnDA=;
        b=NZo8IXNKuc00xzCGkQ2CDpuAfQRIqiu8g+B+OCPbUEnluIQnI1ak5lrNfMXorQFTF2
         1TjmaboXrFPw0LStQ74F5E+pER8iejjaq9itaYxQdTHF0OaySmWiy38GMmM0FX9QioJI
         TjjlL58jIwo0ySdRrTMpb2FXjkR7j9dUSdfc811j8Ph8UaI19x/Cltvu2Jg+Rltgb2Xl
         96THK7fvuIErAZv4u0/UeN1k0udyvzuC8Mh5MBKSFoVvXucaPOWsOmmQQBt2Z8uXo0Or
         NisvzjCd+zYebY9nRiZ1iOzIZCKjoYEJKB50+aWLWEuaZIBx0jeZSYJQwkYU4hwjIdNq
         0HFA==
X-Gm-Message-State: AOAM5302dm9DKM9DIbHQRkICBPwfHdNggGYDRDmR+OvkIElbmuDiQfnd
        ZEWHSRmnmh/bfKsksP0DUXlzMvICzWzIyFU+D8nLSg==
X-Google-Smtp-Source: ABdhPJzmWyLR04HKXDLOicfwmgTzDRW6fwyVwp1XIHMZfjrw79vnalar9I6GDlHvSrWp2rgM/hUiBn1sJb7gthfMfmI=
X-Received: by 2002:a05:6402:212:: with SMTP id t18mr2714867edv.124.1599133032272;
 Thu, 03 Sep 2020 04:37:12 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200829144316.18360-1-kuldip.dwivedi@puresoftware.com> <VI1PR04MB4800CFC9A587B88DB34DBCA1F32F0@VI1PR04MB4800.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4800CFC9A587B88DB34DBCA1F32F0@VI1PR04MB4800.eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKD9Q69WgQxeB8vpSXmqhKIMBO5/ALHj51hp+WmUZA=
Date:   Thu, 3 Sep 2020 17:07:10 +0530
Message-ID: <1b7c81cbc3495a29de7bef891142f4af@mail.gmail.com>
Subject: RE: [EXT] [PATCH v3] serial: 8250_fsl: Add ACPI support
To:     "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-serial@vger.kernel.org
Cc:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Vabhav Sharma (OSS) <vabhav.sharma@oss.nxp.com>
> Sent: Wednesday, September 2, 2020 9:10 PM
> To: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; Dmitry
Safonov
> <0x7f454c46@gmail.com>; linux-serial@vger.kernel.org
> Cc: Pankaj Bansal <pankaj.bansal@nxp.com>; Varun Sethi
<V.Sethi@nxp.com>;
> Arokia Samy <arokia.samy@nxp.com>; kuldip dwivedi
> <kuldip.dwivedi@puresoftware.com>
> Subject: RE: [EXT] [PATCH v3] serial: 8250_fsl: Add ACPI support
>
>
> > -----Original Message-----
> > From: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> > Sent: Saturday, August 29, 2020 8:13 PM
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
> > <jirislaby@kernel.org>; Dmitry Safonov <0x7f454c46@gmail.com>; linux-
> > serial@vger.kernel.org
> > Cc: Vabhav Sharma <vabhav.sharma@nxp.com>; Pankaj Bansal
> > <pankaj.bansal@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Arokia Samy
> > <arokia.samy@nxp.com>; kuldip dwivedi
> > <kuldip.dwivedi@puresoftware.com>
> > Subject: [EXT] [PATCH v3] serial: 8250_fsl: Add ACPI support
> >
> > Caution: EXT Email
> >
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
> >     1. Move Copyright and File description at top of the file
> >     2. Add ACPI wrapper code within CONFIG_ACPI macro
> >     3. this change is tested with DT and ACPI boot on LS1046A platform
> >
> >  drivers/tty/serial/8250/8250_fsl.c | 108
> > +++++++++++++++++++++++++++--
> >  1 file changed, 101 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_fsl.c
> > b/drivers/tty/serial/8250/8250_fsl.c
> > index 0d0c80905c58..68bfbf392281 100644
> > --- a/drivers/tty/serial/8250/8250_fsl.c
> > +++ b/drivers/tty/serial/8250/8250_fsl.c
> > @@ -1,15 +1,12 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include <linux/serial_reg.h>
> > -#include <linux/serial_8250.h>
> > -
> > -#include "8250.h"
> > -
> >  /*
> >   * Freescale 16550 UART "driver", Copyright (C) 2011 Paul Gortmaker.
> > + * Copyright 2020 NXP
> > + * Copyright 2020 Puresoftware Ltd.
> >   *
> >   * This isn't a full driver; it just provides an alternate IRQ
> > - * handler to deal with an errata.  Everything else is just
> > - * using the bog standard 8250 support.
> > + * handler to deal with an errata and provide ACPI wrapper.
> > + * Everything else is just using the bog standard 8250 support.
> >   *
> >   * We follow code flow of serial8250_default_handle_irq() but add
> >   * a check for a break and insert a dummy read on the Rx for the @@
> > -20,6
> > +17,16 @@
> >   * IRQ event to the next one.
> >   */
> >
> > +#include <linux/acpi.h>
> > +#include <linux/serial_reg.h>
> > +#include <linux/serial_8250.h>
> > +
> > +#include "8250.h"
> > +
> > +struct fsl8250_data {
> > +       int     line;
> > +};
> > +
> >  int fsl8250_handle_irq(struct uart_port *port)  {
> >         unsigned char lsr, orig_lsr;
> > @@ -79,3 +86,90 @@ int fsl8250_handle_irq(struct uart_port *port)
> >         return 1;
> >  }
> >  EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
> > +
> > +#ifdef CONFIG_ACPI
> > +static int fsl8250_acpi_probe(struct platform_device *pdev) {
> > +       struct fsl8250_data *data;
> > +       struct uart_8250_port port8250;
> > +       struct device *dev = &pdev->dev;
> > +       struct resource *regs;
> > +
> > +       int ret, irq;
> > +
> > +       regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!regs) {
> > +               dev_err(dev, "no registers defined\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       if (irq < 0) {
> > +               if (irq != -EPROBE_DEFER)
> > +                       dev_err(dev, "cannot get irq\n");
> > +               return irq;
> > +       }
> > +
> > +       memset(&port8250, 0, sizeof(port8250));
> > +
> > +       ret = device_property_read_u32(dev, "clock-frequency",
> > +                                       &port8250.port.uartclk);
> > +       if (ret)
> > +               return ret;
> > +
> > +       spin_lock_init(&port8250.port.lock);
> > +
> > +       port8250.port.mapbase           = regs->start;
> > +       port8250.port.irq               = irq;
> > +       port8250.port.handle_irq        = fsl8250_handle_irq;
> > +       port8250.port.type              = PORT_16550A;
> > +       port8250.port.flags             = UPF_SHARE_IRQ |
UPF_BOOT_AUTOCONF
> > +                                               | UPF_FIXED_PORT |
UPF_IOREMAP
> > +                                               | UPF_FIXED_TYPE;
> > +       port8250.port.dev               = dev;
> > +       port8250.port.mapsize           = resource_size(regs);
> > +       port8250.port.iotype            = UPIO_MEM;
> > +       port8250.port.irqflags          = IRQF_SHARED;
> > +
> > +       port8250.port.membase = devm_ioremap(dev,
port8250.port.mapbase,
> > +
port8250.port.mapsize);
> > +       if (!port8250.port.membase)
> > +               return -ENOMEM;
> > +
> > +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return -ENOMEM;
> > +
> > +       data->line = serial8250_register_8250_port(&port8250);
> > +       if (data->line < 0)
> > +               ret = data->line;
> Would you like to return error here?
Addressed in v4
> > +
> > +       platform_set_drvdata(pdev, data);
> > +       return 0;
> > +}
> > +
> > +static int fsl8250_acpi_remove(struct platform_device *pdev) {
> > +       struct fsl8250_data *data = platform_get_drvdata(pdev);
> > +
> > +       serial8250_unregister_port(data->line);
> > +       return 0;
> > +}
> > +
> > +static const struct acpi_device_id fsl_8250_acpi_id[] = {
> > +       { "NXP0018", 0 },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, fsl_8250_acpi_id);
> > +
> > +static struct platform_driver fsl8250_platform_driver = {
> > +       .driver = {
> > +               .name                   = "fsl-16550-uart",
> > +               .acpi_match_table       = ACPI_PTR(fsl_8250_acpi_id),
> > +       },
> > +       .probe                  = fsl8250_acpi_probe,
> > +       .remove                 = fsl8250_acpi_remove,
> > +};
> > +
> > +module_platform_driver(fsl8250_platform_driver);
> > +#endif
> > --
> > 2.17.1
