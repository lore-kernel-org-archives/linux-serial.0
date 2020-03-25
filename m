Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD09C2D0E5
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 18:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58B620774
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 18:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EpcEsU6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCYSFV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:05:21 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:10820
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbgCYSFV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 14:05:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYy6NGgMo5zdFkWJNdwDC/8x/SqAT0xaF2NDXrn7HPPL3Yactvs7P+YBnl0S6EbUjMewPZrPEBeyyNwKpUTQAsIn+eMX2lyoKVKRqubsNfl4VBE2qr3iR8bkwOVm6zj/MQVPczdxSJs9Ojk6IkmBsl6WktflAvGtll5zWXzaJCy5zgql3Vvbu8+0RozAyEmCxqzje4Io39qkInzNcKz2hhnbAMuHLsuqGe0zUP/bG8b/7eXXDnyRXQ6AxETuGO8O4VIJz7JECpITXRNVzghKQjYaGRheodFs2q/OJvP9Wy8c6g+xg48RL1la/21kGfJw3cCpf8N6zsjh8B85e/lE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33L7n3k3VOyDkqvUXSTxOX1m7iM9sAgG2Z/83s4lI1U=;
 b=fzJVU6Uj8/HUsjOtU+qvHwOeDeJh9MAICH6AwfVfV3arjbkoQBwJsYy907j/NfDo+OGuAzEEUK582QcpJvGJH1dexhtCNW/ZWDxHYarBP+wrLqk/p4rXMqEFXMot6VKKqT+dtthOq0Ah9z6ADfu9Wq9qygE0gKiov/vnUDnvFbanHPwOQm1bjk599yvVdt2qYR8ivUZ4j00rBVgZiiEr4negTOZJAIoGtcaYzwDmb54cVPj7+FOaaHB4gbpZyLzix1JykYZ7NW8grLQ/gNkMp+egTmAUOcF08UrQiWmE906CgYkbQsI8vxk7ytGxskBhYK88rtsNsQQjCYNzmvRq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33L7n3k3VOyDkqvUXSTxOX1m7iM9sAgG2Z/83s4lI1U=;
 b=EpcEsU6sOVm9WvvZjNE5lcVsnVphpv0WTQPHmjjaXu+fuxokSsQ6c7CvXM9IXT3+n9DdJ3ErjcwVCU+hv9Zv3iaC1wP5AJQ4nhpLiwhYERMyKNtmhV89al6qYbehTtmUtAaiUOgC3/qEE09Pizrv0jDy+XczLn7cw/oqfDM7MOc=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (52.133.244.87) by
 VI1PR04MB5565.eurprd04.prod.outlook.com (20.178.121.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Wed, 25 Mar 2020 18:05:16 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 18:05:16 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>, Andy Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH v2 1/2] tty: serial: fsl_lpuart: move dma_request_chan()
Thread-Topic: [PATCH v2 1/2] tty: serial: fsl_lpuart: move dma_request_chan()
Thread-Index: AQHWAoTFxHV8sVlM60KMfOo/y+nDDA==
Date:   Wed, 25 Mar 2020 18:05:16 +0000
Message-ID: <VI1PR04MB69417B19A6FFF0AA22585884EECE0@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <20200325090658.25967-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8bd0b62-f53b-4581-2b47-08d7d0e712a8
x-ms-traffictypediagnostic: VI1PR04MB5565:|VI1PR04MB5565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB55657722641D3DCE6344E6A6EECE0@VI1PR04MB5565.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(53546011)(6506007)(4326008)(8676002)(110136005)(54906003)(7696005)(44832011)(33656002)(316002)(8936002)(81166006)(81156014)(478600001)(66946007)(76116006)(91956017)(66476007)(5660300002)(186003)(66446008)(64756008)(86362001)(2906002)(71200400001)(66556008)(52536014)(26005)(9686003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5565;H:VI1PR04MB6941.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tkMGksVvVh1C0tsnfOTdsUj0BXs1f6FbN+vJDF8QD5s4n4LFTnwGssvuyzPLHxkCRg2yQWgjHklIn9AYn3LFrbbHEMNbzKhD/jsB8neGdRcwfZpBa/MkCnBrJ8fHv06FkIhuH59rxgEWmFFNaqUV+PpwrgrVzpgN5WmKsOq58Qqqckj71SNipdFJw8gSoIZExWG3wQCgurA9lqds/Tw5H3ejSQjEyoKH3Pu3pmDJE7VKTWt7Mw91p1VeqjSq+7fMmGkIfSfgUdikMKVc8AxcoyMli05RnXqmWAsusHIlPoaSZrnoHrd9pUVMPcMtFkW1QCmSuy4dlmR6rMhJJTHsvRz4740M1aEwRLWMDcH1QQeL8ZqqoFDaIVyvmGXObE5j8diHnVI8KEmhmJYUvfIMAEwPENBqXGneDwKoz0XWGHEnAMcJr5KIE84pgoFpNdss
x-ms-exchange-antispam-messagedata: 0XAINS6k1TmDHUU4L3Wq/fmSQfUhb88meLdq77bq9k+AMkP6lud0mmiAHGMv0rNFZEkOEwVzyLrC4R8a/oROtdnpot4MIB1ptcYkgj3UvvfOwIEp/20hMlZo9pki0FSq3/1hsWCHURbaWd/5HU4XPQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bd0b62-f53b-4581-2b47-08d7d0e712a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 18:05:16.4860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkl2xzxZzgoxq2RHR8oNAzzw63NrMtkly7S3Tc8kuG+qAMPx82UrgfEGpOV6I3+62/HXSYtrce1BK2GRVNc5Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5565
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-03-25 11:07 AM, Michael Walle wrote:=0A=
> Move dma_request_chan() out of the atomic context. First this call=0A=
> should not be in the atomic context at all and second the=0A=
> dev_info_once() may cause a hang because because the console takes this=
=0A=
> spinlock, too.=0A=
> =0A=
> Fixes: 159381df1442f ("tty: serial: fsl_lpuart: fix DMA operation when us=
ing IOMMU")=0A=
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> Signed-off-by: Michael Walle <michael@walle.cc>=0A=
> ---=0A=
> changes since v1:=0A=
>   - instead of just moving the dev_info_once() out of the spinlock protec=
ted=0A=
>     section, move the whole dma_request_chan(). Thanks Andy!=0A=
> =0A=
> I've tested this on my board. Andy, Leonard, can you double check it? For=
=0A=
> all which are not aware, this deadlock happens only if you have the kerne=
l=0A=
> console output on the lpuart, so if someone wants to test it, make sure y=
ou=0A=
> have something like console=3DttyLP0,115200.=0A=
> =0A=
>   drivers/tty/serial/fsl_lpuart.c | 36 +++++++++++++++++++++------------=
=0A=
>   1 file changed, 23 insertions(+), 13 deletions(-)=0A=
=0A=
Tested-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
Since the original commit only made it into next it might make sense to =0A=
squash the commits in the tty tree.=0A=
=0A=
This way future bisections won't get stuck on a boot failure.=0A=
=0A=
> =0A=
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c=0A=
> index 9c6a018b1390..131018979b77 100644=0A=
> --- a/drivers/tty/serial/fsl_lpuart.c=0A=
> +++ b/drivers/tty/serial/fsl_lpuart.c=0A=
> @@ -1510,20 +1510,33 @@ static void rx_dma_timer_init(struct lpuart_port =
*sport)=0A=
>   	add_timer(&sport->lpuart_timer);=0A=
>   }=0A=
>   =0A=
> -static void lpuart_tx_dma_startup(struct lpuart_port *sport)=0A=
> +static void lpuart_request_dma(struct lpuart_port *sport)=0A=
>   {=0A=
> -	u32 uartbaud;=0A=
> -	int ret;=0A=
> -=0A=
>   	sport->dma_tx_chan =3D dma_request_chan(sport->port.dev, "tx");=0A=
>   	if (IS_ERR(sport->dma_tx_chan)) {=0A=
>   		dev_info_once(sport->port.dev,=0A=
>   			      "DMA tx channel request failed, operating without tx DMA (%ld)=
\n",=0A=
>   			      PTR_ERR(sport->dma_tx_chan));=0A=
>   		sport->dma_tx_chan =3D NULL;=0A=
> -		goto err;=0A=
>   	}=0A=
>   =0A=
> +	sport->dma_rx_chan =3D dma_request_chan(sport->port.dev, "rx");=0A=
> +	if (IS_ERR(sport->dma_rx_chan)) {=0A=
> +		dev_info_once(sport->port.dev,=0A=
> +			      "DMA rx channel request failed, operating without rx DMA (%ld)\=
n",=0A=
> +			      PTR_ERR(sport->dma_rx_chan));=0A=
> +		sport->dma_rx_chan =3D NULL;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static void lpuart_tx_dma_startup(struct lpuart_port *sport)=0A=
> +{=0A=
> +	u32 uartbaud;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (!sport->dma_tx_chan)=0A=
> +		goto err;=0A=
> +=0A=
>   	ret =3D lpuart_dma_tx_request(&sport->port);=0A=
>   	if (!ret)=0A=
>   		goto err;=0A=
> @@ -1549,14 +1562,8 @@ static void lpuart_rx_dma_startup(struct lpuart_po=
rt *sport)=0A=
>   {=0A=
>   	int ret;=0A=
>   =0A=
> -	sport->dma_rx_chan =3D dma_request_chan(sport->port.dev, "rx");=0A=
> -	if (IS_ERR(sport->dma_rx_chan)) {=0A=
> -		dev_info_once(sport->port.dev,=0A=
> -			      "DMA rx channel request failed, operating without rx DMA (%ld)\=
n",=0A=
> -			      PTR_ERR(sport->dma_rx_chan));=0A=
> -		sport->dma_rx_chan =3D NULL;=0A=
> +	if (!sport->dma_rx_chan)=0A=
>   		goto err;=0A=
> -	}=0A=
>   =0A=
>   	ret =3D lpuart_start_rx_dma(sport);=0A=
>   	if (ret)=0A=
> @@ -1592,6 +1599,8 @@ static int lpuart_startup(struct uart_port *port)=
=0A=
>   	sport->rxfifo_size =3D UARTFIFO_DEPTH((temp >> UARTPFIFO_RXSIZE_OFF) &=
=0A=
>   					    UARTPFIFO_FIFOSIZE_MASK);=0A=
>   =0A=
> +	lpuart_request_dma(sport);=0A=
> +=0A=
>   	spin_lock_irqsave(&sport->port.lock, flags);=0A=
>   =0A=
>   	lpuart_setup_watermark_enable(sport);=0A=
> @@ -1649,11 +1658,12 @@ static int lpuart32_startup(struct uart_port *por=
t)=0A=
>   		sport->port.fifosize =3D sport->txfifo_size;=0A=
>   	}=0A=
>   =0A=
> +	lpuart_request_dma(sport);=0A=
> +=0A=
>   	spin_lock_irqsave(&sport->port.lock, flags);=0A=
>   =0A=
>   	lpuart32_setup_watermark_enable(sport);=0A=
>   =0A=
> -=0A=
>   	lpuart_rx_dma_startup(sport);=0A=
>   	lpuart_tx_dma_startup(sport);=0A=
>   =0A=
> =0A=
=0A=
