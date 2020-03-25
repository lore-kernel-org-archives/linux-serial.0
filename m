Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A98DC43331
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 12:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D032077D
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 12:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fLTCTl7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCYMVx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:21:53 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:5750
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbgCYMVx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 08:21:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOqCEksFhCxOhafqg8tvgo+ZGNzFM+EsRlBZd3c8Y09VPCIMSyoXxG/XHgBHSFpQQ5Zo2mWlm8ti1FbOQSwjiNo5+d8Mp/49bOcdYla8/FlN9loRwrnMwHsBwyrAQR9n5OqBTz45yUkDVG29vTnipjrlMz4f5FWaG6caKYz27vRfXJ7gRNFd09k29iwrB0ZN5VVtmsorgUAGEnztQrS42myi4xKQtMUbvQ7+JSjvKxZPlFRxGmNZoWBzl8Oit4zY1XCkyVai7OyMnl2BOhi3eKEY/1kCJzIKEDf8IE8UEldoHrp34Teu7zhfsWObSO8/5/WdJQRo5bKBxrzHDdyE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8Yl7WR3MoOPQIIqZfLHo2mMB0b/TWBvsp1m8XtOysg=;
 b=SAfCEpxuhzUPTVfflTFh/C89oXzB+3/Y+/LFtOg+WWAfB+NhqhVWUUk0itRng40ggn0vGYB2Wg4kUYLc3Xb+LZeWy80z9KFiK3meILJ09vjJ/BMEW3OTaSxENc+nOE3XQ0PqYgS0M8Z+jNAkgB1PomliFIqIgtIpQ5KJOgpieuQ9QudvQTDlf6ugaUaotPsbB5uEPLLmE1vpZFvta6leLNZkIvelAKsfTSxTvVtj4lj2fYm30b1ZbPzRA2wAGIFw8TwL7R0uEl0/+Sg9u0qeg5FKH86i1zm0HrIqXTtFa8x6ZAIghy3IRqlGLDOM/kHjgA1jd+hfnWD0IHlwbXLRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8Yl7WR3MoOPQIIqZfLHo2mMB0b/TWBvsp1m8XtOysg=;
 b=fLTCTl7v7xCixNt+xdwZOWBQvNOWcDzTmHD5Ur1eQgkp22PXrC3W5RB+vasY1g/V7zCaeSdVLbxzfnXSCcP9qAPY9AoNB0q8olXnzq+wCOPFsC3Fs/tPAO2Q+5X5oouBvKwNEVgQ33s7pKx8HAGXAOSE1R9tfuHH1R9GafZN8h0=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (52.133.244.87) by
 VI1PR04MB5344.eurprd04.prod.outlook.com (52.134.123.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Wed, 25 Mar 2020 12:21:50 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 12:21:50 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Michael Walle <michael@walle.cc>, Andy Duan <fugang.duan@nxp.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [RFC PATCH 3/3] tty: serial: fsl_lpuart: fix possible console
 deadlock
Thread-Topic: [RFC PATCH 3/3] tty: serial: fsl_lpuart: fix possible console
 deadlock
Thread-Index: AQHWAgzKEoI3mdcAQEisgh3SMoTgrg==
Date:   Wed, 25 Mar 2020 12:21:49 +0000
Message-ID: <VI1PR04MB6941AD02204DF50B8D24D23AEECE0@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <20200324184758.8204-1-michael@walle.cc>
 <20200324184758.8204-3-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90c51c9d-a5e3-4d69-21c0-08d7d0b7183e
x-ms-traffictypediagnostic: VI1PR04MB5344:|VI1PR04MB5344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB534486C09AB6A2F43BE906A1EECE0@VI1PR04MB5344.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(2906002)(5660300002)(8676002)(81156014)(8936002)(81166006)(66946007)(52536014)(71200400001)(91956017)(76116006)(86362001)(66556008)(66476007)(33656002)(64756008)(66446008)(478600001)(4326008)(44832011)(186003)(6636002)(7696005)(55016002)(9686003)(26005)(53546011)(6506007)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5344;H:VI1PR04MB6941.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O01gT4VoW6J0+5DAtu88Qlp6boJR2W1/+26cHoxKortFF8CXfphCbRyG44yEUs5OHCmH42fBlX6oBH3eEREbLlG71NL0ua3B+QsEr4sqRJRT2sOpFm6+VI36vre/4zJlllMMhxq5R8GMflfXlD+K55zdwi+9nR3IKHwElqVTe7PkxF1w1Bqzz/sDbGVtBzV0Q6jRrtpNlNPaI8hkLEG2IDIxM70BJbQxN37LskkasDd1VhnsbGwRXQny7ahlSXv+fuLSvVs88rdG6IN08j4FQm8r/NRQUcXqkdC8rMNQ+kpJMeo/iS3UWw+xhyyygWZfHAHkx52RMhR7Kj2zLwsh8QjsbU0vbHzdYfU2ehVKAA1cDHsAQe2BWeR4onh2KQVMEYTKvVW07i84//QpKT8WZvfMuW0t4mp+VnkD0ahRwCNZ9rp0yfBamJRxcPnZIoPL
x-ms-exchange-antispam-messagedata: Lqj8SZzGp5SA3MeKYPdi44TnPqxXe4seyui80iyi0l0cEcMzUn1RsMDk/kwH28aPrK1KKz/74VZ9n1Orgc2hGy0iE/c1vhdUnvDp+MGTant/J1A9WaLGVghE22MY98e0iKuFJR2W06AnkKW+Uq+/gw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c51c9d-a5e3-4d69-21c0-08d7d0b7183e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 12:21:49.8789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agI5BRr8Q/q1NLgXX3LxOphIBMCa3NpoFzlWJafFEGpRpvdM2bVvaFfXPvE+6KBjcXPJvl4VrnwF7Sf8I7MoBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5344
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-03-24 8:48 PM, Michael Walle wrote:=0A=
> If the kernel console output is on this console any=0A=
> dev_{err,warn,info}() may result in a deadlock if the sport->port.lock=0A=
> spinlock is already held. This is because the _console_write() try to=0A=
> aquire this lock, too. Remove any error messages where the spinlock is=0A=
> taken or print after the lock is released.=0A=
> =0A=
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> Signed-off-by: Michael Walle <michael@walle.cc>=0A=
=0A=
It seems that this was an issue even before commit 159381df1442 ("tty: =0A=
serial: fsl_lpuart: fix DMA operation when using IOMMU") but these error =
=0A=
prints never triggered.=0A=
=0A=
Would it be possible to move all the dma alloc/config/prep outside the =0A=
serial port lock? As it stands this still calls into dmaengine coode and =
=0A=
that might decide to print as well.=0A=
=0A=
Really I don't think the lock needs to protect more than bits like =0A=
TDMAE/RDMAE.=0A=
=0A=
BTW: You should add more people in CC for reviews, for example =0A=
linux-imx@nxp.com is checked by a lot of people.=0A=
=0A=
> ---=0A=
>   drivers/tty/serial/fsl_lpuart.c | 35 +++++++--------------------------=
=0A=
>   1 file changed, 7 insertions(+), 28 deletions(-)=0A=
> =0A=
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c=0A=
> index bbba298b68a4..0910308b38b1 100644=0A=
> --- a/drivers/tty/serial/fsl_lpuart.c=0A=
> +++ b/drivers/tty/serial/fsl_lpuart.c=0A=
> @@ -420,7 +420,6 @@ static void lpuart_dma_tx(struct lpuart_port *sport)=
=0A=
>   {=0A=
>   	struct circ_buf *xmit =3D &sport->port.state->xmit;=0A=
>   	struct scatterlist *sgl =3D sport->tx_sgl;=0A=
> -	struct device *dev =3D sport->port.dev;=0A=
>   	struct dma_chan *chan =3D sport->dma_tx_chan;=0A=
>   	int ret;=0A=
>   =0A=
> @@ -442,10 +441,8 @@ static void lpuart_dma_tx(struct lpuart_port *sport)=
=0A=
>   =0A=
>   	ret =3D dma_map_sg(chan->device->dev, sgl, sport->dma_tx_nents,=0A=
>   			 DMA_TO_DEVICE);=0A=
> -	if (!ret) {=0A=
> -		dev_err(dev, "DMA mapping error for TX.\n");=0A=
> +	if (!ret)=0A=
>   		return;=0A=
> -	}=0A=
>   =0A=
>   	sport->dma_tx_desc =3D dmaengine_prep_slave_sg(chan, sgl,=0A=
>   					ret, DMA_MEM_TO_DEV,=0A=
> @@ -453,7 +450,6 @@ static void lpuart_dma_tx(struct lpuart_port *sport)=
=0A=
>   	if (!sport->dma_tx_desc) {=0A=
>   		dma_unmap_sg(chan->device->dev, sgl, sport->dma_tx_nents,=0A=
>   			      DMA_TO_DEVICE);=0A=
> -		dev_err(dev, "Cannot prepare TX slave DMA!\n");=0A=
>   		return;=0A=
>   	}=0A=
>   =0A=
> @@ -520,21 +516,12 @@ static int lpuart_dma_tx_request(struct uart_port *=
port)=0A=
>   	struct lpuart_port *sport =3D container_of(port,=0A=
>   					struct lpuart_port, port);=0A=
>   	struct dma_slave_config dma_tx_sconfig =3D {};=0A=
> -	int ret;=0A=
>   =0A=
>   	dma_tx_sconfig.dst_addr =3D lpuart_dma_datareg_addr(sport);=0A=
>   	dma_tx_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;=0A=
>   	dma_tx_sconfig.dst_maxburst =3D 1;=0A=
>   	dma_tx_sconfig.direction =3D DMA_MEM_TO_DEV;=0A=
> -	ret =3D dmaengine_slave_config(sport->dma_tx_chan, &dma_tx_sconfig);=0A=
> -=0A=
> -	if (ret) {=0A=
> -		dev_err(sport->port.dev,=0A=
> -				"DMA slave config failed, err =3D %d\n", ret);=0A=
> -		return ret;=0A=
> -	}=0A=
> -=0A=
> -	return 0;=0A=
> +	return dmaengine_slave_config(sport->dma_tx_chan, &dma_tx_sconfig);=0A=
>   }=0A=
>   =0A=
>   static bool lpuart_is_32(struct lpuart_port *sport)=0A=
> @@ -1074,8 +1061,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_por=
t *sport)=0A=
>   =0A=
>   	dmastat =3D dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);=
=0A=
>   	if (dmastat =3D=3D DMA_ERROR) {=0A=
> -		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");=0A=
>   		spin_unlock_irqrestore(&sport->port.lock, flags);=0A=
> +		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");=0A=
>   		return;=0A=
>   	}=0A=
>   =0A=
> @@ -1179,23 +1166,17 @@ static inline int lpuart_start_rx_dma(struct lpua=
rt_port *sport)=0A=
>   	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);=0A=
>   	nent =3D dma_map_sg(chan->device->dev, &sport->rx_sgl, 1,=0A=
>   			  DMA_FROM_DEVICE);=0A=
> -=0A=
> -	if (!nent) {=0A=
> -		dev_err(sport->port.dev, "DMA Rx mapping error\n");=0A=
> +	if (!nent)=0A=
>   		return -EINVAL;=0A=
> -	}=0A=
>   =0A=
>   	dma_rx_sconfig.src_addr =3D lpuart_dma_datareg_addr(sport);=0A=
>   	dma_rx_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;=0A=
>   	dma_rx_sconfig.src_maxburst =3D 1;=0A=
>   	dma_rx_sconfig.direction =3D DMA_DEV_TO_MEM;=0A=
> -	ret =3D dmaengine_slave_config(chan, &dma_rx_sconfig);=0A=
>   =0A=
> -	if (ret < 0) {=0A=
> -		dev_err(sport->port.dev,=0A=
> -				"DMA Rx slave config failed, err =3D %d\n", ret);=0A=
> +	ret =3D dmaengine_slave_config(chan, &dma_rx_sconfig);=0A=
> +	if (ret < 0)=0A=
>   		return ret;=0A=
> -	}=0A=
>   =0A=
>   	sport->dma_rx_desc =3D dmaengine_prep_dma_cyclic(chan,=0A=
>   				 sg_dma_address(&sport->rx_sgl),=0A=
> @@ -1203,10 +1184,8 @@ static inline int lpuart_start_rx_dma(struct lpuar=
t_port *sport)=0A=
>   				 sport->rx_sgl.length / 2,=0A=
>   				 DMA_DEV_TO_MEM,=0A=
>   				 DMA_PREP_INTERRUPT);=0A=
> -	if (!sport->dma_rx_desc) {=0A=
> -		dev_err(sport->port.dev, "Cannot prepare cyclic DMA\n");=0A=
> +	if (!sport->dma_rx_desc)=0A=
>   		return -EFAULT;=0A=
> -	}=0A=
>   =0A=
>   	sport->dma_rx_desc->callback =3D lpuart_dma_rx_complete;=0A=
>   	sport->dma_rx_desc->callback_param =3D sport;=0A=
> =0A=
=0A=
