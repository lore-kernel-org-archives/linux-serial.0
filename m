Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B4FC1975A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 10:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74233207FC
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 10:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GIKz4C1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgCYKDS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:03:18 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:47872
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbgCYKDS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 06:03:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK1NUQf8uXZklPxWkw5QaNWlP6Q/b8P0CtRFHak8/6z/XRI3/wDb+r7++aQ4uMxQ9yJYYhP5yGoy4+3HzMghgJRP/quSx6/ellxFKXZCxPpQiqGxQ9YuWZwrY0tD2KN6FaIk19skUh5yy6Xq+rNqS7onN5WjiA9SogOpI/GnV/p2A2xX8CzIciJGDttuQBgnUGBrhA5X2eY4vL+GcdSJEkH9l7YCQZbaeioAl9ASCPgL6w06WkEEubKYojxOk9BZEV+0+xd32mzfr9vs7rM9ErFuobkx1QiAcNdd1J+SP9KNi5MWQ8l+i1VvCHdfVYogIdswHGKhxWpJCuGuW4mgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4nkXgqwEGwu3C0mhI4fV+lNIIWf2s6jvVCjObQIz68=;
 b=dXZ3F91TqYp55MAIrdLrtXecW0k0zK1qddEnj/lRTF0CDvf3YCCTwHu6gZTq5/xRAgARbABATKlPr9xB2oduQzDjmi6mNhmAVlxz5TCN1hO8KrTrpop1Tus2yu03ML4Cn+XGEkc2LDhHtdP2VJBe4+LAwsu1VnqiAgF4C8JjJpYuOQRp8vP8f1x1U/rCGUoKhFnEF2DmQR5DTeJq/NmckBHe9hr/MIARiYBoLnmWbJkieTvsboUkNghJIbezFx48Dd9EgxireY0vZXZjFrLtsdX73+xOZDOEalkS3GyBHFnjUcCjGSzhN6OUlHES3LeF1rke11eKLQKrEySSU6Q6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4nkXgqwEGwu3C0mhI4fV+lNIIWf2s6jvVCjObQIz68=;
 b=GIKz4C1Bfp4OByPTwFllga9goP6+6jUuQ4m1IbdPFADu3F5B7mni+s/JEP4HlHIxxVuEe3JrsDn/rRcx6iKJjvU+mRQPSCPZWB+WUaAPNBR4fFiGnwfb9XUa2NaN+dSLyarN383emBY2oAQlxzQWwqKTN77YQk45NXThnO4ZI6M=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB3856.eurprd04.prod.outlook.com (52.134.16.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Wed, 25 Mar 2020 10:03:14 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c991:848b:cc80:2768]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c991:848b:cc80:2768%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 10:03:14 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [EXT] [PATCH v2 1/2] tty: serial: fsl_lpuart: move
 dma_request_chan()
Thread-Topic: [EXT] [PATCH v2 1/2] tty: serial: fsl_lpuart: move
 dma_request_chan()
Thread-Index: AQHWAoTFksFC9Hjm7kudzC7IE2Rl+KhZE/PA
Date:   Wed, 25 Mar 2020 10:03:13 +0000
Message-ID: <VI1PR0402MB36008DD884D7623C12DF2709FFCE0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20200325090658.25967-1-michael@walle.cc>
In-Reply-To: <20200325090658.25967-1-michael@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4d6e59f-2adb-45b5-4e5a-08d7d0a3bb82
x-ms-traffictypediagnostic: VI1PR0402MB3856:|VI1PR0402MB3856:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB38567F2D338E0B88A1592A3DFFCE0@VI1PR0402MB3856.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(7696005)(86362001)(71200400001)(186003)(478600001)(26005)(6506007)(2906002)(110136005)(9686003)(66946007)(316002)(81166006)(64756008)(66476007)(5660300002)(55016002)(76116006)(54906003)(66556008)(4326008)(8676002)(8936002)(52536014)(33656002)(81156014)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3856;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjv5TcjgXBkckTSUG4KjBd1lOmiBerXpQaG9QgxcloQJYh8a7TiAP8b7pQYWU3tbOKTc9BQXCjHgh2OzPMb7MMOtVG3L2LNAwnFsqB6lFdg4KS1jikia4K73X1bT5ea7yHnokxHhCvSv4fObmyzspNcZBuQBWFr4sFdMbyPhPktMrK/UprWB52r2XaI5oZZ3nATALMQ3nhF59N/SAmfYxMtrChO37v86MYMoSwBc0aI+GXDYANMCeBixLJHrQsJLCl42pH5inL/GYUPMOjagyAfXnBUTp9L0Ads2pXaQJL0Vqb25IsKsgerzSQybsO9rVjfPEGynwK8lG9sm/qLOzV3qTFhBVpkDhozfQjCjbB4ZclRtuFldo4waIkG6obJ3QyIrhjy5hmeAdvpxVnBZ16qMwpccHmaKmMeRJLK/3USshimY5Spc86li4qHOZXCm
x-ms-exchange-antispam-messagedata: H4ftV4Yd9OCE92T01SpXakxxVXRxEyaeQRtbjTL4dj2PWjvz5FXGc++XgvROhOPExiUbFbGNVbDBYHY2Bnr/3TKZQl4jWAV69YfEka5BHerrnJYcs3+FrqxD9/R79qC8jyX0fUkS3A2qZb8/OJWQkw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d6e59f-2adb-45b5-4e5a-08d7d0a3bb82
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 10:03:13.8681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9Hcio84Kg5J8P7DAghKKw43jDaNB1ReIczzziLyU+wmItUvc5HHQ29IX2QapRA+Pae4kkr4fWCRuGo2pvc62w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3856
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Michael Walle <michael@walle.cc> Sent: Wednesday, March 25, 2020 5:07=
 PM
> Move dma_request_chan() out of the atomic context. First this call should=
 not
> be in the atomic context at all and second the
> dev_info_once() may cause a hang because because the console takes this
> spinlock, too.
>=20
> Fixes: 159381df1442f ("tty: serial: fsl_lpuart: fix DMA operation when us=
ing
> IOMMU")
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>

> ---
> changes since v1:
>  - instead of just moving the dev_info_once() out of the spinlock protect=
ed
>    section, move the whole dma_request_chan(). Thanks Andy!
>=20
> I've tested this on my board. Andy, Leonard, can you double check it? For=
 all
> which are not aware, this deadlock happens only if you have the kernel
> console output on the lpuart, so if someone wants to test it, make sure y=
ou
> have something like console=3DttyLP0,115200.
>=20
>  drivers/tty/serial/fsl_lpuart.c | 36 +++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 9c6a018b1390..131018979b77 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1510,20 +1510,33 @@ static void rx_dma_timer_init(struct lpuart_port
> *sport)
>         add_timer(&sport->lpuart_timer);  }
>=20
> -static void lpuart_tx_dma_startup(struct lpuart_port *sport)
> +static void lpuart_request_dma(struct lpuart_port *sport)
>  {
> -       u32 uartbaud;
> -       int ret;
> -
>         sport->dma_tx_chan =3D dma_request_chan(sport->port.dev, "tx");
>         if (IS_ERR(sport->dma_tx_chan)) {
>                 dev_info_once(sport->port.dev,
>                               "DMA tx channel request failed,
> operating without tx DMA (%ld)\n",
>                               PTR_ERR(sport->dma_tx_chan));
>                 sport->dma_tx_chan =3D NULL;
> -               goto err;
>         }
>=20
> +       sport->dma_rx_chan =3D dma_request_chan(sport->port.dev, "rx");
> +       if (IS_ERR(sport->dma_rx_chan)) {
> +               dev_info_once(sport->port.dev,
> +                             "DMA rx channel request failed,
> operating without rx DMA (%ld)\n",
> +                             PTR_ERR(sport->dma_rx_chan));
> +               sport->dma_rx_chan =3D NULL;
> +       }
> +}
> +
> +static void lpuart_tx_dma_startup(struct lpuart_port *sport) {
> +       u32 uartbaud;
> +       int ret;
> +
> +       if (!sport->dma_tx_chan)
> +               goto err;
> +
>         ret =3D lpuart_dma_tx_request(&sport->port);
>         if (!ret)
>                 goto err;
> @@ -1549,14 +1562,8 @@ static void lpuart_rx_dma_startup(struct
> lpuart_port *sport)  {
>         int ret;
>=20
> -       sport->dma_rx_chan =3D dma_request_chan(sport->port.dev, "rx");
> -       if (IS_ERR(sport->dma_rx_chan)) {
> -               dev_info_once(sport->port.dev,
> -                             "DMA rx channel request failed,
> operating without rx DMA (%ld)\n",
> -                             PTR_ERR(sport->dma_rx_chan));
> -               sport->dma_rx_chan =3D NULL;
> +       if (!sport->dma_rx_chan)
>                 goto err;
> -       }
>=20
>         ret =3D lpuart_start_rx_dma(sport);
>         if (ret)
> @@ -1592,6 +1599,8 @@ static int lpuart_startup(struct uart_port *port)
>         sport->rxfifo_size =3D UARTFIFO_DEPTH((temp >>
> UARTPFIFO_RXSIZE_OFF) &
>=20
> UARTPFIFO_FIFOSIZE_MASK);
>=20
> +       lpuart_request_dma(sport);
> +
>         spin_lock_irqsave(&sport->port.lock, flags);
>=20
>         lpuart_setup_watermark_enable(sport);
> @@ -1649,11 +1658,12 @@ static int lpuart32_startup(struct uart_port
> *port)
>                 sport->port.fifosize =3D sport->txfifo_size;
>         }
>=20
> +       lpuart_request_dma(sport);
> +
>         spin_lock_irqsave(&sport->port.lock, flags);
>=20
>         lpuart32_setup_watermark_enable(sport);
>=20
> -
>         lpuart_rx_dma_startup(sport);
>         lpuart_tx_dma_startup(sport);
>=20
> --
> 2.20.1

