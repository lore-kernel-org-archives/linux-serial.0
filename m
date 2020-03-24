Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9F3C41621
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B42208E0
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cEtIX7FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCXQMJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:12:09 -0400
Received: from mail-eopbgr20054.outbound.protection.outlook.com ([40.107.2.54]:57764
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728571AbgCXQMI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 12:12:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ywi2b/v3xB/NzP5vGzUy2g+YDFTTeCp6CNlpLbInr3oe8VIsOVU6X/QoDcEMV3vDjFy/WC85AD+gsa2rQSb7KdbKbZfGFhE+oa54dsyEj93gyzam8HX83tsfhBa4QLviI9qjyaLbviQjvmNfPhF9tn3OKDx8wyGgECloBxUyeKj12gDIR8DcV2aHLmwjBq81LmrFeuVsymaQKU/edrULE5nRlHAFbm/RAy0llnwenw4QiFmx+3YUVveHVvzHeE7KwL3PD5UUOqx/S7LiZYUiEr5JJnnifXo6062vEsSgU5Bt7qxZ0mNL5ZL8gVA2cvyiGZDr8+Lr/qJk+XAM1HI6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEQ5an93V2aaUXoITnMc4MEvldKwDZ8+83cHgSDIVvM=;
 b=TJb7O8GHuzFBk1GcddK7q0H1QcvWAwQ6kb1+dItaRSSxMXwhgY0z/x2OsNWoHC7OHcBjxHFCau7TgY5I/O88V8M3Ogyho9Y1H5PQtYjLzglFb1g7Xfxg1UVgdhoFPGt8a5DkeDbxkl6o/IgmqdNEod954d7SkiUiJCaY3xOHkEXCNnXjIMbIE/mKe391HXmZkFhb3z5usWRck1jlSM6vHYhtWStr5jpqIXhz0NL46ql6Rbld7DB3FmFTDWDP2qmrRrxwwsIpG9tJDQ6W1utNKnXrQpD9ppfiKlA7G4VP2SIaI6UlByKMK/HXrPF/gfBFJaz4wSX3RYiaqCZR4HOygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEQ5an93V2aaUXoITnMc4MEvldKwDZ8+83cHgSDIVvM=;
 b=cEtIX7FC/gz8qGP7Cz0ruyEl3fRjYPP+hV9DbLuWXM0QcfcwzrofeqRYPetU3z0hy0Dr7ej4JKVLJKJhusBqShs572arGV8fHbEp56OuiJ8cNYR/8Ml4DpTKdfHScHQaZc1LCxG4okyONZS/xRHNYrS1QPvxpFD0YcccFSr/zRY=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB3663.eurprd04.prod.outlook.com (52.134.15.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Tue, 24 Mar 2020 16:12:04 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c991:848b:cc80:2768]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c991:848b:cc80:2768%7]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 16:12:04 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH v4 1/4] tty: serial: fsl_lpuart: fix DMA operation when
 using IOMMU
Thread-Topic: [PATCH v4 1/4] tty: serial: fsl_lpuart: fix DMA operation when
 using IOMMU
Thread-Index: AQHV9AB7XTSsAtbd1E+3Etbi7F0aCKhYBLIQ
Date:   Tue, 24 Mar 2020 16:12:04 +0000
Message-ID: <VI1PR0402MB36001AEE78E0F067D29F2816FFF10@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20200306214433.23215-1-michael@walle.cc>
 <20200306214433.23215-2-michael@walle.cc>
 <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50c138ea-4898-46aa-dd55-08d7d00e17d8
x-ms-traffictypediagnostic: VI1PR0402MB3663:|VI1PR0402MB3663:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3663B726C50928CB0F515ED5FFF10@VI1PR0402MB3663.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(71200400001)(186003)(53546011)(33656002)(4326008)(86362001)(8936002)(478600001)(55016002)(54906003)(81156014)(5660300002)(316002)(66946007)(7696005)(9686003)(26005)(6506007)(52536014)(66476007)(2906002)(66556008)(81166006)(66446008)(110136005)(76116006)(8676002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3663;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eaHPQDuFzH2SBfOTVRDyT00r7TWpCF74l8MFZUkAPP7Z6hik4UY8LFqg1DxE1yXJjt6rMVm8ETVqEXWX+r64UsQzzU9M37WRpUKk2IPcmDUHJZuf7smQ7YUpWTHKXyuPFc4PRDol+CMqSRlMqCv7SQ48DnmU2wvtb12wQXL4lO147M8P99iKCj7RchvU3BOyoUEpsITR8qhxUMrs2cVv2yG682zQLDEUAE8R4cvKE1DHSxS891svEcP7jO4/mIrP5mXSHuecFuh9AAQ5NBPlh8RpKtXx0n3WLZMviq1QGmEDaInz/KieGuARmKi3hQif8YTs5u1nUIqjnAQZg9Si/1+Qwhs8f04I0B6aJsRh2y4M02TQxdugVLACdoOGgnka0XdD2aC57g/ii0pQzeA73x+M4ZrKOcz6LA2KIovVGl2Xjr9NMd58scoI6k3PxMbW
x-ms-exchange-antispam-messagedata: GX2yMc+ZNbQ92m7VXrhDUFNIHSdYCjc/IaPoEOi3QBvuveOQIBj5hTX7KKQ1Y6h2/+OmtC43AL+PG2A29eUX7ZqwcFGEj3bufrlnJ+9+m2ay2pctCccAez6utPBt9WT1iayOKn+hQe4kmemVS7nP7Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c138ea-4898-46aa-dd55-08d7d00e17d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 16:12:04.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFlxcdq+hE/u72X5sgBBXCOowgjn2O8CQ3V7Xv4sYCuVSFV9rvJDstuq8HLIEBLOjZWif0JhApzDbCbjuGMd4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3663
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com> Sent: Tuesday, March 24, 20=
20 11:27 PM
> On 06.03.2020 23:44, Michael Walle wrote:
> > The DMA channel might not be available at probe time. This is esp. the
> > case if the DMA controller has an IOMMU mapping.
> >
> > There is also another caveat. If there is no DMA controller at all,
> > dma_request_chan() will also return -EPROBE_DEFER. Thus we cannot test
> > for -EPROBE_DEFER in probe(). Otherwise the lpuart driver will fail to
> > probe if, for example, the DMA driver is not enabled in the kernel
> > configuration.
If DMA driver is not enabled, we should disable DMA controller node in
dts file to match current sw environment, then driver doesn't do defer prob=
e.

So I still suggest to check -EPROBE_DEFER for dma_request_slave_channel() i=
n
.probe() function.

Andy
> >
> > To workaround this, we request the DMA channel in _startup(). Other
> > serial drivers do it the same way.
> >
> > Signed-off-by: Michael Walle <michael@walle.cc>
>=20
> This appears to cause boot hangs on imx8qxp-mek (boards boots fine on
> next-20200324 if this patch is reverted)
>=20
> > ---
> >   drivers/tty/serial/fsl_lpuart.c | 88 +++++++++++++++++++++-----------=
-
> >   1 file changed, 57 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index c31b8f3db6bf..33798df4d727
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -1493,36 +1493,67 @@ static void rx_dma_timer_init(struct
> lpuart_port *sport)
> >   static void lpuart_tx_dma_startup(struct lpuart_port *sport)
> >   {
> >   	u32 uartbaud;
> > +	int ret;
> >
> > -	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
> > -		init_waitqueue_head(&sport->dma_wait);
> > -		sport->lpuart_dma_tx_use =3D true;
> > -		if (lpuart_is_32(sport)) {
> > -			uartbaud =3D lpuart32_read(&sport->port, UARTBAUD);
> > -			lpuart32_write(&sport->port,
> > -				       uartbaud | UARTBAUD_TDMAE, UARTBAUD);
> > -		} else {
> > -			writeb(readb(sport->port.membase + UARTCR5) |
> > -				UARTCR5_TDMAS, sport->port.membase + UARTCR5);
> > -		}
> > +	sport->dma_tx_chan =3D dma_request_chan(sport->port.dev, "tx");
> > +	if (IS_ERR(sport->dma_tx_chan)) {
> > +		dev_info_once(sport->port.dev,
> > +			      "DMA tx channel request failed, operating without tx
> DMA (%ld)\n",
> > +			      PTR_ERR(sport->dma_tx_chan));
>=20
> It seems that this since this is called from lpuart32_startup with
> &sport->port.lock held and lpuart32_console_write takes the same lock it =
can
> and hang.
>=20
> As a workaround I can just remove this print but there are other possible=
 error
> conditions in dmaengine code which can cause a printk.
>=20
> Maybe the port lock should only be held around register manipulation?
>=20
> > +		sport->dma_tx_chan =3D NULL;
> > +		goto err;
> > +	}
> > +
> > +	ret =3D lpuart_dma_tx_request(&sport->port);
> > +	if (!ret)
> > +		goto err;
>=20
> This is backwards: lpuart_dma_tx_request returns negative errno on failur=
e.
>=20
> > +
> > +	init_waitqueue_head(&sport->dma_wait);
> > +	sport->lpuart_dma_tx_use =3D true;
> > +	if (lpuart_is_32(sport)) {
> > +		uartbaud =3D lpuart32_read(&sport->port, UARTBAUD);
> > +		lpuart32_write(&sport->port,
> > +			       uartbaud | UARTBAUD_TDMAE, UARTBAUD);
> >   	} else {
> > -		sport->lpuart_dma_tx_use =3D false;
> > +		writeb(readb(sport->port.membase + UARTCR5) |
> > +		       UARTCR5_TDMAS, sport->port.membase + UARTCR5);
> >   	}
> > +
> > +	return;
> > +
> > +err:
> > +	sport->lpuart_dma_tx_use =3D false;
> >   }
> >
> >   static void lpuart_rx_dma_startup(struct lpuart_port *sport)
> >   {
> > -	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
> > -		/* set Rx DMA timeout */
> > -		sport->dma_rx_timeout =3D msecs_to_jiffies(DMA_RX_TIMEOUT);
> > -		if (!sport->dma_rx_timeout)
> > -			sport->dma_rx_timeout =3D 1;
> > +	int ret;
> >
> > -		sport->lpuart_dma_rx_use =3D true;
> > -		rx_dma_timer_init(sport);
> > -	} else {
> > -		sport->lpuart_dma_rx_use =3D false;
> > +	sport->dma_rx_chan =3D dma_request_chan(sport->port.dev, "rx");
> > +	if (IS_ERR(sport->dma_rx_chan)) {
> > +		dev_info_once(sport->port.dev,
> > +			      "DMA rx channel request failed, operating without rx
> DMA (%ld)\n",
> > +			      PTR_ERR(sport->dma_rx_chan));
> > +		sport->dma_rx_chan =3D NULL;
> > +		goto err;
> >   	}
> > +
> > +	ret =3D lpuart_start_rx_dma(sport);
> > +	if (ret)
> > +		goto err;
>=20
> This is not backwards.
>=20
> > +
> > +	/* set Rx DMA timeout */
> > +	sport->dma_rx_timeout =3D msecs_to_jiffies(DMA_RX_TIMEOUT);
> > +	if (!sport->dma_rx_timeout)
> > +		sport->dma_rx_timeout =3D 1;
> > +
> > +	sport->lpuart_dma_rx_use =3D true;
> > +	rx_dma_timer_init(sport);
> > +
> > +	return;
> > +
> > +err:
> > +	sport->lpuart_dma_rx_use =3D false;
> >   }
> >
> >   static int lpuart_startup(struct uart_port *port) @@ -1615,6
> > +1646,11 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
> >   			dmaengine_terminate_all(sport->dma_tx_chan);
> >   		}
> >   	}
> > +
> > +	if (sport->dma_tx_chan)
> > +		dma_release_channel(sport->dma_tx_chan);
> > +	if (sport->dma_rx_chan)
> > +		dma_release_channel(sport->dma_rx_chan);
> >   }
> >
> >   static void lpuart_shutdown(struct uart_port *port) @@ -2520,16
> > +2556,6 @@ static int lpuart_probe(struct platform_device *pdev)
> >
> >   	sport->port.rs485_config(&sport->port, &sport->port.rs485);
> >
> > -	sport->dma_tx_chan =3D dma_request_slave_channel(sport->port.dev,
> "tx");
> > -	if (!sport->dma_tx_chan)
> > -		dev_info(sport->port.dev, "DMA tx channel request failed, "
> > -				"operating without tx DMA\n");
> > -
> > -	sport->dma_rx_chan =3D dma_request_slave_channel(sport->port.dev,
> "rx");
> > -	if (!sport->dma_rx_chan)
> > -		dev_info(sport->port.dev, "DMA rx channel request failed, "
> > -				"operating without rx DMA\n");
> > -
> >   	return 0;
> >
> >   failed_attach_port:
> >

