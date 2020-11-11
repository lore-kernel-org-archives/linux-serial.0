Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FDAC388F7
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 02:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2B9221F1
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 02:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dBkInCWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgKKCIo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Nov 2020 21:08:44 -0500
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:35317
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731713AbgKKCIo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Nov 2020 21:08:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb0gf2CTC1fxa50qTwcRRTigC5ftknm93wzBtd8JbccMP33VB0uLV5U5DSqClKtQXGElwtfGNCE5WggM6KF7SLN4LfdRkq0MBRDuRmRAh3aHlfH2au3oVhRRVONO3QmBsbze5Y1uVc4fC9SHn23Jwwvppkiuh+lWVrbNcHB4VgL/HHl2IMNy6NjQ97YTSGDjp4JGEIpu8FOg/6iNn529FDBbaWP0x8WZOR1BpiCdHQExySwIN+blOWJIEpjyVetBMHXgnSts6I18WOcl4TblAaO9tIuKtnXGWoQpVam7EFQ6s0x3w3QSAh/Hv0P1kLExBtzlRhsEJgkZDLj5acaxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqEgbcc8Fi1CYual/GboW6VSBjMc1b5c9oULP8vV8G8=;
 b=AJ23/tjB955LbzQFTJcu4C7YUp6fxc3Nh2JoD/WwaOh40jmE4JaQuYSTUVh22L63Yzo0Fkx7DofsQ0Y64wHKMQtPPsxszYMFl0ouRqylBv3MtmCOWm2YsvvkzHLxP/LZ8RigMrCUByanr5x66bhLOVcpfwk8xiNNv0ftQgO7cuxkTYnUfwMbq5SNyW3DOabBVRa1+XW0oZ47ckSK/oq01HuiAhIGvlDNQAaW5Z9W9pSvTA6km/59BVVk+IJxzKxULMDMlqPK4MWOmxQsi1Or6EMMYrWgX/L8ou3tKWvBB/kdd1HTZbZu1h5FcNA0+0LtUe/BFYdYl9XKM05vDGPreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqEgbcc8Fi1CYual/GboW6VSBjMc1b5c9oULP8vV8G8=;
 b=dBkInCWS/9udptAy27DGPk99s2ho6zBDeXET2EnI3Oo+M70dbDLvIjxksV8+afnlZ5BDAfBySERG476kxHON+fodeTRe4pO5ppb3XKWcaj+RV4ZGB8eLlvwta9tX8vo+hXg3kRJa2lcJ/G99O1ir+j2rvYMEQ/SXl96nvMQEu0c=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM0PR04MB5105.eurprd04.prod.outlook.com (2603:10a6:208:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 02:08:40 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 02:08:40 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [EXT] [PATCH] serial: imx: Remove unused platform data support
Thread-Topic: [EXT] [PATCH] serial: imx: Remove unused platform data support
Thread-Index: AQHWt6tIdmFxLdPoXk2Mwm631biCH6nCL6iw
Date:   Wed, 11 Nov 2020 02:08:40 +0000
Message-ID: <AM8PR04MB7315F778C9048F23982323D2FFE80@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20201110214840.16768-1-festevam@gmail.com>
In-Reply-To: <20201110214840.16768-1-festevam@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cb3ccc4-e957-4f6a-3fc8-08d885e6b544
x-ms-traffictypediagnostic: AM0PR04MB5105:
x-microsoft-antispam-prvs: <AM0PR04MB5105AE27B090277F9B5C4550FFE80@AM0PR04MB5105.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ze3HMkXpCaEwFh+EdMz2c7EpdBRcs3b7wB0oTP+Rgh8m4Frgu+r4wB9OqkLXln0emfAluHTfjc+fVNoitpkvwPxkbvDtfpFppkj3qWHB9xbWKMZ2z2/KdhT0FiS0YluUSxBQOKf2mNOBiVMYsk4IBvnI46xonzUk6hd7yycWjRj7e8ZuXiXXlL9MBbHReDnEF+eNK7ABGAr45pFaK4btTgBmEXWyOVdkb7VVYe1aHnOjh8RbDvRi07EJQ+U6HyN+tMyqaMoLLtb3T33ln94hq6MvTfal1klmEulllH/kj36iqypgNm0JwPkG/XZZ8pO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(6506007)(478600001)(71200400001)(4326008)(55016002)(33656002)(66446008)(9686003)(110136005)(66556008)(316002)(66476007)(186003)(64756008)(76116006)(66946007)(54906003)(26005)(83380400001)(5660300002)(2906002)(52536014)(86362001)(7696005)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1geGPi5Wbyf2PI9fci9kMhKk5WEwaXu1w6PreTXEQ5QW7fzsWv3EN8AeWL5slVy35DQ27SZiuB9TQQw+oTt06qZjX4D6Q5jar1RUII0hRb3zksmb9bfsBbtIXBR3EgCsZ8QIV5s8VaIuWWJ7jAR6DLVVYm3gQZgZhQjsjMeORidnhli7j/4rXTM6iBKR3PmGevGslzgyyDh/tdnxLBuyLTV8L9e48yQ/+utqPL1MGIQU1DXbi+Dt77tIU81qZ1rVW/+h2Zblo0asWt4UJsoWAevcqME4i9DpocFMhG/ydc3/6nG88T4imYsedJAuIAAHYaojuiMO7HFR8VYSPVV3NCLhlDW7mJqtdplcSG6c3qLPqTxzMFndRg0oohPGIXDqZQ9WpHD4nTUaGNu4d5FW4m9ZwIckuoyxOwfH6IPX1ZP2olYj/lXY0iyCkFhGUAMspwKytCfXo6mqHp0S9kulw27sQpNcLe+ZSEzsBFaYBTlMWHUSDQUrEYLXcPrdcMtbRhUAIU9gLBiboHNvR+/7geNcgIqF5UfdXeVZgdpFN3m8B/4x33uz/u/DHMD88p6CUjXJ/lKHUgLJ7eWwg2MKHhJq5xSaKxKEhGMYxdsv+tRcX6BDiIOYXzKDb2XrwGJc1nPFqUTSi55MgmCoEzk03g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb3ccc4-e957-4f6a-3fc8-08d885e6b544
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 02:08:40.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0nhwzRiGxTTuIEZ089LgjWTqEKoqqwhfGGNPZr2/eCFTmXwes8gDp8B8e3lPYG3cFf9SB1rB4suSapcCN1DHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5105
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com> Sent: Wednesday, November 11, 2020=
 5:49 AM
> Since 5.10-rc1 i.MX is a devicetree-only platform and the existing platfo=
rm data
> support in this driver was only useful for old non-devicetree platforms.
>=20
> Get rid of the platform data support since it is no longer used.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/tty/serial/imx.c                 | 32 +++---------------------
>  include/linux/platform_data/serial-imx.h | 15 -----------
>  2 files changed, 3 insertions(+), 44 deletions(-)  delete mode 100644
> include/linux/platform_data/serial-imx.h
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> 1731d9728865..7ce38ade9a8e 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -30,7 +30,6 @@
>  #include <linux/dma-mapping.h>
>=20
>  #include <asm/irq.h>
> -#include <linux/platform_data/serial-imx.h>
>  #include <linux/platform_data/dma-imx.h>
>=20
>  #include "serial_mctrl_gpio.h"
> @@ -2191,10 +2190,9 @@ static struct uart_driver imx_uart_uart_driver =3D=
 {
>         .cons           =3D IMX_CONSOLE,
>  };
>=20
> -#ifdef CONFIG_OF
>  /*
> - * This function returns 1 iff pdev isn't a device instatiated by dt, 0 =
iff it
> - * could successfully get all information from dt or a negative errno.
> + * This function returns 0 iff it could successfully get all
> + information
> + * from dt or a negative errno.
>   */
>  static int imx_uart_probe_dt(struct imx_port *sport,
>                              struct platform_device *pdev) @@
> -2232,28 +2230,6 @@ static int imx_uart_probe_dt(struct imx_port *sport,
>=20
>         return 0;
>  }
> -#else
> -static inline int imx_uart_probe_dt(struct imx_port *sport,
> -                                   struct platform_device *pdev)
> -{
> -       return 1;
> -}
> -#endif
> -
> -static void imx_uart_probe_pdata(struct imx_port *sport,
> -                                struct platform_device *pdev)
> -{
> -       struct imxuart_platform_data *pdata =3D
> dev_get_platdata(&pdev->dev);
> -
> -       sport->port.line =3D pdev->id;
> -       sport->devdata =3D (struct imx_uart_data  *)
> pdev->id_entry->driver_data;
> -
> -       if (!pdata)
> -               return;
> -
> -       if (pdata->flags & IMXUART_HAVE_RTSCTS)
> -               sport->have_rtscts =3D 1;
> -}
>=20
>  static enum hrtimer_restart imx_trigger_start_tx(struct hrtimer *t)  { @=
@
> -2295,9 +2271,7 @@ static int imx_uart_probe(struct platform_device *pdev=
)
>                 return -ENOMEM;
>=20
>         ret =3D imx_uart_probe_dt(sport, pdev);
> -       if (ret > 0)
> -               imx_uart_probe_pdata(sport, pdev);
> -       else if (ret < 0)
> +       if (ret < 0)
>                 return ret;
>=20
>         if (sport->port.line >=3D ARRAY_SIZE(imx_uart_ports)) { diff --gi=
t
> a/include/linux/platform_data/serial-imx.h
> b/include/linux/platform_data/serial-imx.h
> deleted file mode 100644
> index 0844b21372c7..000000000000
> --- a/include/linux/platform_data/serial-imx.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright (C) 2008 by Sascha Hauer <kernel@pengutronix.de>
> - */
> -
> -#ifndef ASMARM_ARCH_UART_H
> -#define ASMARM_ARCH_UART_H
> -
> -#define IMXUART_HAVE_RTSCTS (1<<0)
> -
> -struct imxuart_platform_data {
> -       unsigned int flags;
> -};
> -
> -#endif
> --
> 2.17.1

