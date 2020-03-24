Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DB8C43331
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 15:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AF120788
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 15:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RrrDjg6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCXP1K (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:27:10 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:13983
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727491AbgCXP1K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 11:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrMy6vSgOJ4kTKfN4mSbWhUZQ4oH+bp85T13gGVfWYqrOtXBa/PG7Sg3WVPrVMGo7xoi0KxfkMduAZsw2XUA4atpiQqxf4/5GQ/JqrNUEO2qFmXIitBsJ3cCcsrMtYqNfGYgIL3RyCB0t2bwHOyAKBlF5EkyiXFmuc1FmG9t7FtWBnHCdEr4IpxEPSah1pXnkYqTCPjkJuC5k7qBk8++IXzA8Lu5XqcJhWlnQGDAi1Tm7vtZHbjmQh7yzYfqckE4URVjpH2WTy9cLuO2M3dSLkv3Dfk1pI+xd7ynj/64bo443Pa1AutqkSawLgXc/DdhXEiR5ZgcOtb/0hKMbEWWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuJZuayat3lACbCJ0Ki+WPbx+dX4ZyH2LV+lm197IBM=;
 b=a1h9F7qG72W76fsSHT5qS+IYUr7PlTp+jyZ+AuBogGkG47tCrJ/yNxfD6tYHiMpo/QfdHfLMX0rv++wuqMOxnzICAr9lAGMdKNVnhVglEv/nzMMU9/9eJyQtOJXBeVJ4FAB4OOMR0z50bm8E5OWNLWhcb6SeWZHCuycXecPsy4qF21fncQx0eyJaRAcN2TTP+6Ne+EJuP0QnpR0a81MTn8rk/Yzdd1AoCkeJBd/AyYtvvhmBOSw+0zDLYmTMnqR4n6Sg7kUcsZT2ZAvBAz556Qky32hK3N0UJu5Q5gX6/Z6agYs+jSdnr1oSdH1paHC6ytsCKXkCkRo6S6wirEU6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuJZuayat3lACbCJ0Ki+WPbx+dX4ZyH2LV+lm197IBM=;
 b=RrrDjg6RJHAjogSg7gIhooTu6657Ox0OGB014OT0jDQazVNW2NY+P3KINqANVe8aQOl6QxuKpcF3ZaIlIb7lgLRVPuQRLa+i6/51tLgtNTjeoYXpAyEPXSkgMGx7ymGZfljvszWEaRvwA5aWxrylRNZKc+RgvX6o3UMQeWl5OOw=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (52.133.244.87) by
 VI1PR04MB5741.eurprd04.prod.outlook.com (20.178.125.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 15:27:06 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:27:06 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 1/4] tty: serial: fsl_lpuart: fix DMA operation when
 using IOMMU
Thread-Topic: [PATCH v4 1/4] tty: serial: fsl_lpuart: fix DMA operation when
 using IOMMU
Thread-Index: AQHV9AB7XTSsAtbd1E+3Etbi7F0aCA==
Date:   Tue, 24 Mar 2020 15:27:06 +0000
Message-ID: <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <20200306214433.23215-1-michael@walle.cc>
 <20200306214433.23215-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86f55109-45cb-4eb7-4f52-08d7d007cfe0
x-ms-traffictypediagnostic: VI1PR04MB5741:|VI1PR04MB5741:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB574107754A0E12B3D8E86723EEF10@VI1PR04MB5741.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(2906002)(55016002)(26005)(186003)(33656002)(110136005)(54906003)(4326008)(316002)(86362001)(52536014)(8676002)(81166006)(81156014)(71200400001)(8936002)(44832011)(5660300002)(66946007)(53546011)(6506007)(7696005)(66446008)(9686003)(76116006)(478600001)(66556008)(66476007)(91956017)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5741;H:VI1PR04MB6941.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ynh+iOCSXO5X4qu/z03aCE7GrLDlUyubI9kSXQO9S5i8Mv5hZI5XXrMerLZROVDcJbTiHu7COJ0XoGToRy6Cpot2vwVtOy1pEktJpWf9isLIH8NQ2dDKgnIaIJAznxyhGUYrDPIutxuS03mSvACN69ChSggnF1v4KIW0VNYDeaVCI2m552VeqkSCEDVZp1Zg7nyUIgsBAWnyi28kEcB0LxRME6wKh+ukgqNoBMOu8oEMLvbpm39H4I9p7PV+VpOva2xxbeZc2mfIPe+qbA4IkvgqiKCq+jqvcFXOn6GunsYJYyeHXXFqAXOclJKHw7x17EM/t86I/TKO7jxa6rw3sguCV8t6/Hn0SNDAYBPzzXyr1d5hojBJfIWCQqS9zmPNZw9V8PI15BpsLfrfXojLUbOmuP1t00cPpvcUfrbW1T96Zr2k3qMr7VjogWgfQ0CZ
x-ms-exchange-antispam-messagedata: ETxzSRRLdRJJeyIyaVjqyX2CkZfQnyNWXxtNeD0YimTxCGN5WhPBKPrsFNUhW8f21P+4gLOVQMgKPbRUXif4l2ngsqn0e0dLqqRM4yoNTA0N5t6fgmCQWKKdhE8lDUILulSQExyIf0Two2naNZM/qw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f55109-45cb-4eb7-4f52-08d7d007cfe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 15:27:06.5892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ys88zf+e90w92HGJfF4+Yu1CeK2UVLCCINAV8TnmRj6woSN4mpmnPB8Eg1v86eDxOEfXpP5RaO1mWok5Mzvvjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5741
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06.03.2020 23:44, Michael Walle wrote:=0A=
> The DMA channel might not be available at probe time. This is esp. the=0A=
> case if the DMA controller has an IOMMU mapping.=0A=
> =0A=
> There is also another caveat. If there is no DMA controller at all,=0A=
> dma_request_chan() will also return -EPROBE_DEFER. Thus we cannot test=0A=
> for -EPROBE_DEFER in probe(). Otherwise the lpuart driver will fail to=0A=
> probe if, for example, the DMA driver is not enabled in the kernel=0A=
> configuration.=0A=
> =0A=
> To workaround this, we request the DMA channel in _startup(). Other=0A=
> serial drivers do it the same way.=0A=
> =0A=
> Signed-off-by: Michael Walle <michael@walle.cc>=0A=
=0A=
This appears to cause boot hangs on imx8qxp-mek (boards boots fine on =0A=
next-20200324 if this patch is reverted)=0A=
=0A=
> ---=0A=
>   drivers/tty/serial/fsl_lpuart.c | 88 +++++++++++++++++++++------------=
=0A=
>   1 file changed, 57 insertions(+), 31 deletions(-)=0A=
> =0A=
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c=0A=
> index c31b8f3db6bf..33798df4d727 100644=0A=
> --- a/drivers/tty/serial/fsl_lpuart.c=0A=
> +++ b/drivers/tty/serial/fsl_lpuart.c=0A=
> @@ -1493,36 +1493,67 @@ static void rx_dma_timer_init(struct lpuart_port =
*sport)=0A=
>   static void lpuart_tx_dma_startup(struct lpuart_port *sport)=0A=
>   {=0A=
>   	u32 uartbaud;=0A=
> +	int ret;=0A=
>   =0A=
> -	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {=0A=
> -		init_waitqueue_head(&sport->dma_wait);=0A=
> -		sport->lpuart_dma_tx_use =3D true;=0A=
> -		if (lpuart_is_32(sport)) {=0A=
> -			uartbaud =3D lpuart32_read(&sport->port, UARTBAUD);=0A=
> -			lpuart32_write(&sport->port,=0A=
> -				       uartbaud | UARTBAUD_TDMAE, UARTBAUD);=0A=
> -		} else {=0A=
> -			writeb(readb(sport->port.membase + UARTCR5) |=0A=
> -				UARTCR5_TDMAS, sport->port.membase + UARTCR5);=0A=
> -		}=0A=
> +	sport->dma_tx_chan =3D dma_request_chan(sport->port.dev, "tx");=0A=
> +	if (IS_ERR(sport->dma_tx_chan)) {=0A=
> +		dev_info_once(sport->port.dev,=0A=
> +			      "DMA tx channel request failed, operating without tx DMA (%ld)\=
n",=0A=
> +			      PTR_ERR(sport->dma_tx_chan));=0A=
=0A=
It seems that this since this is called from lpuart32_startup with =0A=
&sport->port.lock held and lpuart32_console_write takes the same lock it =
=0A=
can and hang.=0A=
=0A=
As a workaround I can just remove this print but there are other =0A=
possible error conditions in dmaengine code which can cause a printk.=0A=
=0A=
Maybe the port lock should only be held around register manipulation?=0A=
=0A=
> +		sport->dma_tx_chan =3D NULL;=0A=
> +		goto err;=0A=
> +	}=0A=
> +=0A=
> +	ret =3D lpuart_dma_tx_request(&sport->port);=0A=
> +	if (!ret)=0A=
> +		goto err;=0A=
=0A=
This is backwards: lpuart_dma_tx_request returns negative errno on failure.=
=0A=
=0A=
> +=0A=
> +	init_waitqueue_head(&sport->dma_wait);=0A=
> +	sport->lpuart_dma_tx_use =3D true;=0A=
> +	if (lpuart_is_32(sport)) {=0A=
> +		uartbaud =3D lpuart32_read(&sport->port, UARTBAUD);=0A=
> +		lpuart32_write(&sport->port,=0A=
> +			       uartbaud | UARTBAUD_TDMAE, UARTBAUD);=0A=
>   	} else {=0A=
> -		sport->lpuart_dma_tx_use =3D false;=0A=
> +		writeb(readb(sport->port.membase + UARTCR5) |=0A=
> +		       UARTCR5_TDMAS, sport->port.membase + UARTCR5);=0A=
>   	}=0A=
> +=0A=
> +	return;=0A=
> +=0A=
> +err:=0A=
> +	sport->lpuart_dma_tx_use =3D false;=0A=
>   }=0A=
>   =0A=
>   static void lpuart_rx_dma_startup(struct lpuart_port *sport)=0A=
>   {=0A=
> -	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {=0A=
> -		/* set Rx DMA timeout */=0A=
> -		sport->dma_rx_timeout =3D msecs_to_jiffies(DMA_RX_TIMEOUT);=0A=
> -		if (!sport->dma_rx_timeout)=0A=
> -			sport->dma_rx_timeout =3D 1;=0A=
> +	int ret;=0A=
>   =0A=
> -		sport->lpuart_dma_rx_use =3D true;=0A=
> -		rx_dma_timer_init(sport);=0A=
> -	} else {=0A=
> -		sport->lpuart_dma_rx_use =3D false;=0A=
> +	sport->dma_rx_chan =3D dma_request_chan(sport->port.dev, "rx");=0A=
> +	if (IS_ERR(sport->dma_rx_chan)) {=0A=
> +		dev_info_once(sport->port.dev,=0A=
> +			      "DMA rx channel request failed, operating without rx DMA (%ld)\=
n",=0A=
> +			      PTR_ERR(sport->dma_rx_chan));=0A=
> +		sport->dma_rx_chan =3D NULL;=0A=
> +		goto err;=0A=
>   	}=0A=
> +=0A=
> +	ret =3D lpuart_start_rx_dma(sport);=0A=
> +	if (ret)=0A=
> +		goto err;=0A=
=0A=
This is not backwards.=0A=
=0A=
> +=0A=
> +	/* set Rx DMA timeout */=0A=
> +	sport->dma_rx_timeout =3D msecs_to_jiffies(DMA_RX_TIMEOUT);=0A=
> +	if (!sport->dma_rx_timeout)=0A=
> +		sport->dma_rx_timeout =3D 1;=0A=
> +=0A=
> +	sport->lpuart_dma_rx_use =3D true;=0A=
> +	rx_dma_timer_init(sport);=0A=
> +=0A=
> +	return;=0A=
> +=0A=
> +err:=0A=
> +	sport->lpuart_dma_rx_use =3D false;=0A=
>   }=0A=
>   =0A=
>   static int lpuart_startup(struct uart_port *port)=0A=
> @@ -1615,6 +1646,11 @@ static void lpuart_dma_shutdown(struct lpuart_port=
 *sport)=0A=
>   			dmaengine_terminate_all(sport->dma_tx_chan);=0A=
>   		}=0A=
>   	}=0A=
> +=0A=
> +	if (sport->dma_tx_chan)=0A=
> +		dma_release_channel(sport->dma_tx_chan);=0A=
> +	if (sport->dma_rx_chan)=0A=
> +		dma_release_channel(sport->dma_rx_chan);=0A=
>   }=0A=
>   =0A=
>   static void lpuart_shutdown(struct uart_port *port)=0A=
> @@ -2520,16 +2556,6 @@ static int lpuart_probe(struct platform_device *pd=
ev)=0A=
>   =0A=
>   	sport->port.rs485_config(&sport->port, &sport->port.rs485);=0A=
>   =0A=
> -	sport->dma_tx_chan =3D dma_request_slave_channel(sport->port.dev, "tx")=
;=0A=
> -	if (!sport->dma_tx_chan)=0A=
> -		dev_info(sport->port.dev, "DMA tx channel request failed, "=0A=
> -				"operating without tx DMA\n");=0A=
> -=0A=
> -	sport->dma_rx_chan =3D dma_request_slave_channel(sport->port.dev, "rx")=
;=0A=
> -	if (!sport->dma_rx_chan)=0A=
> -		dev_info(sport->port.dev, "DMA rx channel request failed, "=0A=
> -				"operating without rx DMA\n");=0A=
> -=0A=
>   	return 0;=0A=
>   =0A=
>   failed_attach_port:=0A=
> =0A=
=0A=
