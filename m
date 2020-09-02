Return-Path: <SRS0=Wt+Y=CL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C274C433E7
	for <linux-serial@archiver.kernel.org>; Wed,  2 Sep 2020 15:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E68720829
	for <linux-serial@archiver.kernel.org>; Wed,  2 Sep 2020 15:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E0uhkZGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgIBPkU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:40:20 -0400
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:61702
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbgIBPkS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Sep 2020 11:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azo9w1CJf584xVIq4hsRmwv3dc/7sicxApWYU3LC3ck2LOe4TdO72DtrcL6UzJQbuk+Gve+xLLxu7S2H29/iqOVBm3+Qn21wlMzGcKCRch3hqCeRTu8QPY6LLkU5HmsOU5iZ/HFb0DsCUEHnQ8/dwtbDCUnOuN1IfE4Zr24zis9CLa7W1yCXUC3wpBCyy2Y7skRzGRtLVLHeln81iWszymqUr5VhqM/9T7ND4pldj13K84fTguM2Q/cdzYfiz2CUHb4mqrsj5IVNaSGvRo6Ut/Wb3hZcEeBVuf0a6FjyawhzsLkItOUiRRHy2nxq0HXRhMj04bxeLc7LzrbB0obXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvvO2rnVxydtDl6VYJV7AC5uqd5PmyRfpSkWLgBrIuY=;
 b=eqJgUgmDwxlHCtBfKikOGWlP6CumO6etkMI59ijeF6nm1vQHIN4uD+XYQPTaEstJdCR2eSKJIE6OC2UaPsei2JgO+AMPbzA5qHVOTS/lGC51wo5dbsZOf+bK49pZXQbtNV9QxWeNaFiMNV8yc1HgwTDjUlVoBmnY9Ag3dNigdyH/B7I9smgsjXcqju9oIYvS5CPnPJgRWOftenj+RPO19MDVVd10BrsEGmzV3ztZ65pSt/8YBEG4JIEHfGnalP3tAYai5qyTH7WTWPVQNwaxTi4PVh0QTA5xde46NZ5ORP3U1dFS7yIXWStzNm+AWtYkJSavpTVC2RY4AKguLq+OsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvvO2rnVxydtDl6VYJV7AC5uqd5PmyRfpSkWLgBrIuY=;
 b=E0uhkZGUfdAv8P/UhP5WvjoNTPeocOzgrsd+GiShvUc00gm9PTcB3jnWyj+WVWqKJDDN3ocv1hnGCSYcPjmJgx9ISV9zSc81BKk7VDePR8mCULQCUXQ5VuRCzw1/jC+9vbJwTAfeefWeO3ZxzS2pNOiZnsVbW3YXAi8ZBmZMPSg=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:5a::12)
 by VI1PR0402MB3566.eurprd04.prod.outlook.com (2603:10a6:803:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 15:40:14 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::b1e8:9472:353d:8011]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::b1e8:9472:353d:8011%5]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 15:40:14 +0000
From:   "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
To:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Subject: RE: [EXT] [PATCH v3] serial: 8250_fsl: Add ACPI support
Thread-Topic: [EXT] [PATCH v3] serial: 8250_fsl: Add ACPI support
Thread-Index: AQHWfhKqzZnqDbjZ5E2nS+qaileWRqlVf0TQ
Date:   Wed, 2 Sep 2020 15:40:14 +0000
Message-ID: <VI1PR04MB4800CFC9A587B88DB34DBCA1F32F0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <20200829144316.18360-1-kuldip.dwivedi@puresoftware.com>
In-Reply-To: <20200829144316.18360-1-kuldip.dwivedi@puresoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: puresoftware.com; dkim=none (message not signed)
 header.d=none;puresoftware.com; dmarc=none action=none
 header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [103.49.154.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfb7449b-614d-4f50-8889-08d84f567c69
x-ms-traffictypediagnostic: VI1PR0402MB3566:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB356628F0BA8AF5162120C798B22F0@VI1PR0402MB3566.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XVhTa5qoSKop7ts9BgbNL0g3mZDzSTDmwE3tFtNCZKfWtInaULUUMqKz99WZIuuGESc16bVAE+pbB5mM/LaT+WwOgIpvlZkBtZ7KKqDnpJTz2YSVTQiMo1JZmXZfwA0Uyen5Mhj9fHHS2CP+60PbSPh3lI9vNMM+LVQMK27whp/56Mygg/+viNTrBlEzimVntBD+TsrKwQdiJUaCUdygMcsLPjiWaPnz5LbpyNNUcvdwpnLrfLnPTJg4Z4WPUmNGaoeisAIkEjC1fw1x2vG0gfEZ87+w32ARtKwSK+LZGtX8Hf/IlnQ2TFTsZMqc2XVtyFwcjxfu2XkRaPF2vE/44g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(186003)(4326008)(7696005)(8936002)(2906002)(33656002)(6506007)(86362001)(9686003)(53546011)(71200400001)(8676002)(55016002)(316002)(110136005)(66946007)(66556008)(66476007)(83380400001)(54906003)(5660300002)(26005)(76116006)(52536014)(66446008)(64756008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WAYo93GinelJ/tZiLCx7vwgBgMR7KM6AUobU5vd0AoPz0jXV4ZOp+DU2llDaetkeQdbfG4lw83EHaJjyqsIeIPsUYOmXyPEZ2rexEQGu/eFYO9TR0lH2GbiIm3kJd98uLfoulMWn0fyuAw6FIjfk6+Rr7FUUpNcCIY3AH9jUrjG57Mjl0Mp8qV7Dk8/r4TWuxnzrlviKmrg+TiZAH4GkjGhm7FaNgOs4wd/LpUec8j78RCvDnfwO2DbBBqtMi+fMG+AKjb/j5D7AjTMGtunrnANGQFfHIG4A6SBwNioqpmcOagvgG4wDUZmud6KF2UA8FpK5N174xXbIk6FEKCra+ykzerGd32u9mm+Vagk/7fhoZR0YieWctT/hTr02Ad0oB4CMih9zuxldkmEDW+lOD+fCjsc6tn5QfdbhNPfjyH5QufONM1HyjamNuf6Ocsk3ORXYYgygmmB5kiTuTJHHqzqZgRJG2tLNjcpgYoA3Y0q7yg2Geeb3W2nsJROUwdWterVkCPqhCld949QDpP3QxSsFf3rYRZIOcB2/ai05hDQYsgh8DGBbPO3AiTMicJhvqAG/DzvirrnejVDjWRH1b9FK9i4dpNBxPWiq42RG+oQijG+xYs4uOJEvi/PmaMLi66rFSVbgctiN7NeOAhaV+g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb7449b-614d-4f50-8889-08d84f567c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:40:14.4019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XbwBC5wv6NJRBcJhUpPAvJ8897Kfnke+E1F9GFq6F1hZ+phGqY1zsdrd+2g+0HsRcokjnFEGOFHD0gmwThUNSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3566
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


> -----Original Message-----
> From: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Sent: Saturday, August 29, 2020 8:13 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
> <jirislaby@kernel.org>; Dmitry Safonov <0x7f454c46@gmail.com>; linux-
> serial@vger.kernel.org
> Cc: Vabhav Sharma <vabhav.sharma@nxp.com>; Pankaj Bansal
> <pankaj.bansal@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Arokia Samy
> <arokia.samy@nxp.com>; kuldip dwivedi
> <kuldip.dwivedi@puresoftware.com>
> Subject: [EXT] [PATCH v3] serial: 8250_fsl: Add ACPI support
>=20
> Caution: EXT Email
>=20
> This adds support for ACPI enumerated FSL 16550 UARTs.
> For supporting ACPI, I added a wrapper so that this driver can be used if
> firmware has exposed the HID "NXP0018" in DSDT table.
>=20
> This will be built as object file if config "SERIAL_8250_FSL"
> is enabled which depends on config "SERIAL_8250_CONSOLE".
>=20
> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> ---
>=20
> Notes:
>     1. Move Copyright and File description at top of the file
>     2. Add ACPI wrapper code within CONFIG_ACPI macro
>     3. this change is tested with DT and ACPI boot on LS1046A platform
>=20
>  drivers/tty/serial/8250/8250_fsl.c | 108 +++++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_fsl.c
> b/drivers/tty/serial/8250/8250_fsl.c
> index 0d0c80905c58..68bfbf392281 100644
> --- a/drivers/tty/serial/8250/8250_fsl.c
> +++ b/drivers/tty/serial/8250/8250_fsl.c
> @@ -1,15 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/serial_reg.h>
> -#include <linux/serial_8250.h>
> -
> -#include "8250.h"
> -
>  /*
>   * Freescale 16550 UART "driver", Copyright (C) 2011 Paul Gortmaker.
> + * Copyright 2020 NXP
> + * Copyright 2020 Puresoftware Ltd.
>   *
>   * This isn't a full driver; it just provides an alternate IRQ
> - * handler to deal with an errata.  Everything else is just
> - * using the bog standard 8250 support.
> + * handler to deal with an errata and provide ACPI wrapper.
> + * Everything else is just using the bog standard 8250 support.
>   *
>   * We follow code flow of serial8250_default_handle_irq() but add
>   * a check for a break and insert a dummy read on the Rx for the @@ -20,=
6
> +17,16 @@
>   * IRQ event to the next one.
>   */
>=20
> +#include <linux/acpi.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_8250.h>
> +
> +#include "8250.h"
> +
> +struct fsl8250_data {
> +       int     line;
> +};
> +
>  int fsl8250_handle_irq(struct uart_port *port)  {
>         unsigned char lsr, orig_lsr;
> @@ -79,3 +86,90 @@ int fsl8250_handle_irq(struct uart_port *port)
>         return 1;
>  }
>  EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
> +
> +#ifdef CONFIG_ACPI
> +static int fsl8250_acpi_probe(struct platform_device *pdev) {
> +       struct fsl8250_data *data;
> +       struct uart_8250_port port8250;
> +       struct device *dev =3D &pdev->dev;
> +       struct resource *regs;
> +
> +       int ret, irq;
> +
> +       regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!regs) {
> +               dev_err(dev, "no registers defined\n");
> +               return -EINVAL;
> +       }
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               if (irq !=3D -EPROBE_DEFER)
> +                       dev_err(dev, "cannot get irq\n");
> +               return irq;
> +       }
> +
> +       memset(&port8250, 0, sizeof(port8250));
> +
> +       ret =3D device_property_read_u32(dev, "clock-frequency",
> +                                       &port8250.port.uartclk);
> +       if (ret)
> +               return ret;
> +
> +       spin_lock_init(&port8250.port.lock);
> +
> +       port8250.port.mapbase           =3D regs->start;
> +       port8250.port.irq               =3D irq;
> +       port8250.port.handle_irq        =3D fsl8250_handle_irq;
> +       port8250.port.type              =3D PORT_16550A;
> +       port8250.port.flags             =3D UPF_SHARE_IRQ | UPF_BOOT_AUTO=
CONF
> +                                               | UPF_FIXED_PORT | UPF_IO=
REMAP
> +                                               | UPF_FIXED_TYPE;
> +       port8250.port.dev               =3D dev;
> +       port8250.port.mapsize           =3D resource_size(regs);
> +       port8250.port.iotype            =3D UPIO_MEM;
> +       port8250.port.irqflags          =3D IRQF_SHARED;
> +
> +       port8250.port.membase =3D devm_ioremap(dev,  port8250.port.mapbas=
e,
> +                                                       port8250.port.map=
size);
> +       if (!port8250.port.membase)
> +               return -ENOMEM;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->line =3D serial8250_register_8250_port(&port8250);
> +       if (data->line < 0)
> +               ret =3D data->line;
Would you like to return error here?
> +
> +       platform_set_drvdata(pdev, data);
> +       return 0;
> +}
> +
> +static int fsl8250_acpi_remove(struct platform_device *pdev) {
> +       struct fsl8250_data *data =3D platform_get_drvdata(pdev);
> +
> +       serial8250_unregister_port(data->line);
> +       return 0;
> +}
> +
> +static const struct acpi_device_id fsl_8250_acpi_id[] =3D {
> +       { "NXP0018", 0 },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(acpi, fsl_8250_acpi_id);
> +
> +static struct platform_driver fsl8250_platform_driver =3D {
> +       .driver =3D {
> +               .name                   =3D "fsl-16550-uart",
> +               .acpi_match_table       =3D ACPI_PTR(fsl_8250_acpi_id),
> +       },
> +       .probe                  =3D fsl8250_acpi_probe,
> +       .remove                 =3D fsl8250_acpi_remove,
> +};
> +
> +module_platform_driver(fsl8250_platform_driver);
> +#endif
> --
> 2.17.1

