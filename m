Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792B2C1975A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 04:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37215206F6
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 04:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dWbumP5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgCYEI3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 00:08:29 -0400
Received: from mail-db8eur05on2050.outbound.protection.outlook.com ([40.107.20.50]:64321
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbgCYEI3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 00:08:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy83IrurNHmwdTqNLUBruCKQDGCa+2i0ao3X3dEokAw5sCzsavXzB4eCzE+bCNZ7fGdiTX6CIY9oJtqVmkz2izRbN7riGSwp4dawrqNaDIZaKKGXKPKsPBzUxNKRuxe1lw+A3VCbgjq4tvcFaTUk/SVfC0Iqhiif6B469q2XAZMScMxiYVv9SuQ18Pd19eRntC15kk/CTrmoAMJ0IBHpzg3/bLkISeOedMPbSn7S8HPWk4oxTRe0kEQ+85R9ne+eEnRyyRYks+3FoxN8uRjKO7lj7UK6sa2Ujmcli47kl6nwsHmX1D3ws4mLZFGR44WlQBzNcwyi9mZ1NPoiNKcPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx8rcqc5rAXjpM6Am2DqFp7bOBpQPNLFQvk4mw2i3Ug=;
 b=B1U+SH0ZM5z/Q1OBchenQggpK1Sd5sm+hjQKz/GNxfn1ElyBcgIwtgQsbnKOmI3VSU/JJMMA9B5a2E9Ta/tgIeyBaP7PsIHQfAt5Ce78Wmc0v+PzLawKS5Xk1kz6VFucgWUxM4ho6tXXPydhAv+8aMbzLDVKEH9G4WAmzIBhnJI18R5MSGt7qZthaW8Ys1h5acKmZPtP60xi1GVcMBEeIR+k61/wiJczOnyNzIJSLrOnqEWvd2XizkRojjWyITAG71DiTFqoqjkXH8CoM2y346oOufHvXrIwChEi4N1RiwhEGlfjTHkf1DXqifKJ/34ylIAw68vC1DhSMsDBOkbLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx8rcqc5rAXjpM6Am2DqFp7bOBpQPNLFQvk4mw2i3Ug=;
 b=dWbumP5Xo2Vfe0ubzF8ISU/J+wpKFCsRakXarCWNptrxdhRKlHJcJny1oTWPwkvVN5cEwbZwNm1YlUqWecmrdI9+R0FwGdLIdcbJe42JRVmpscNkggkW7Cxc4fGO5gNMCM27hm7C4yVDePveO04yrm3KRAttdO1WBVR7OT+r2J8=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB3870.eurprd04.prod.outlook.com (52.134.16.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Wed, 25 Mar 2020 04:08:23 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c991:848b:cc80:2768]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c991:848b:cc80:2768%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 04:08:23 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 1/4] tty: serial: fsl_lpuart: fix DMA
 operation when using IOMMU
Thread-Topic: [EXT] Re: [PATCH v4 1/4] tty: serial: fsl_lpuart: fix DMA
 operation when using IOMMU
Thread-Index: AQHV9AB7XTSsAtbd1E+3Etbi7F0aCKhYBLIQgAACxwCAAAGMwIAAA1SAgAC/5pA=
Date:   Wed, 25 Mar 2020 04:08:23 +0000
Message-ID: <VI1PR0402MB360011B90343A8008BDB3A3AFFCE0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20200306214433.23215-1-michael@walle.cc>
 <20200306214433.23215-2-michael@walle.cc>
 <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <VI1PR0402MB36001AEE78E0F067D29F2816FFF10@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <725d2abdcdc0ab05cc1f03028f8a2919@walle.cc>
 <VI1PR0402MB360060ABA69BB138A33C9615FFF10@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <d9882e8769f234cff634cfdfa9a3dd33@walle.cc>
In-Reply-To: <d9882e8769f234cff634cfdfa9a3dd33@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e106faaa-9c8e-472c-7d45-08d7d0722948
x-ms-traffictypediagnostic: VI1PR0402MB3870:|VI1PR0402MB3870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB387073EC45BE660385593F8CFFCE0@VI1PR0402MB3870.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(478600001)(7696005)(53546011)(64756008)(6506007)(66476007)(66446008)(66556008)(186003)(71200400001)(26005)(66946007)(8676002)(81166006)(6916009)(5660300002)(33656002)(81156014)(8936002)(52536014)(9686003)(86362001)(316002)(2906002)(76116006)(4326008)(55016002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3870;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JuDBzJ1CpMJ6cafbtAewdKDJ8h83vnfweQPJiJ99+x0sXWh1OCj1Q/8LZ/7PmV1a1Afz9owgBUK109wgiZnlXnWoD2B1ltIIgVs9NyfCVLzeoe4+wAIKyIuABQD43OzTn7+i4LOzO0gDiI+KKtm1yPzYpDR5/YiQ82bsrPWqPe8kbn9Tv7LsYwy7eBgyMj7c8sqZSUrtDmgLLqig7cdzb2CuiGIa9Z4rhBpsUTODqXwjVU3jezVcJT+VBtu/1W0esHMbnXJXf9uPpTc1UYjkpLGuYlnH4yD7IL6OSqpod0SZ013zN7s/PmGqqzHG9g0Ema9L7566mpf1KWiS3gRl2zZrBMGx+AREfvncIAkpONWnASJYIZSNXft/g5FO0yvxWuPdg61mLFNxgf3dnWSwLY4lJWcqBrhDCx3dZb9p5NJMEIgFmxWkbQicO/MDChux
x-ms-exchange-antispam-messagedata: 4Kq8bGNR2TXQ4N3W5xvYDC699+2pVRYLpvm04tJcODPxDkavxuRehxiEczAq45ShhWB1dAbrsrXVFeVn4sZHwNGcSsTMogY2t8unmZs+HcdSjCjqTl/pb5P9nprhKhz/H7tS8nsUySZqk/agF4zjOQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e106faaa-9c8e-472c-7d45-08d7d0722948
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 04:08:23.2450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kiGPCMqo0EXGC9RCVCDfC5A2S5KGc5/zfGem1Q4s2DmoGgwdM1Z1GYS7scQc09j5QpidE7qccW5+Huj4ohAfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3870
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Michael Walle <michael@walle.cc> Sent: Wednesday, March 25, 2020 12:3=
5 AM
> Am 2020-03-24 17:28, schrieb Andy Duan:
> > From: Michael Walle <michael@walle.cc> Sent: Wednesday, March 25,
> 2020
> > 12:18 AM
> >> Am 2020-03-24 17:12, schrieb Andy Duan:
> >> > From: Leonard Crestez <leonard.crestez@nxp.com> Sent: Tuesday,
> >> > March 24, 2020 11:27 PM
> >> >> On 06.03.2020 23:44, Michael Walle wrote:
> >> >> > The DMA channel might not be available at probe time. This is esp=
.
> >> >> > the case if the DMA controller has an IOMMU mapping.
> >> >> >
> >> >> > There is also another caveat. If there is no DMA controller at
> >> >> > all,
> >> >> > dma_request_chan() will also return -EPROBE_DEFER. Thus we
> >> >> > cannot test for -EPROBE_DEFER in probe(). Otherwise the lpuart
> >> >> > driver will fail to probe if, for example, the DMA driver is not
> >> >> > enabled in the kernel configuration.
> >> > If DMA driver is not enabled, we should disable DMA controller node
> >> > in dts file to match current sw environment, then driver doesn't do
> >> > defer probe.
> >> >
> >> > So I still suggest to check -EPROBE_DEFER for
> >> > dma_request_slave_channel() in
> >> > .probe() function.
> >>
> >> I don't know if I can follow you here. This would lead to non
> >> functional setups, eg. one build its own kernel with DMA disabled,
> >> but still have a device tree with the DMA nodes. And besides, the
> >> current workaround to request the DMA channel in startup() is
> >> basically working, isn't it? And once the underlying problem is fixed
> >> (the infinite EPROBE_DEFER), it could be moved back into _probe().
> >>
> >> -michael
> >
> > I think the user use wrong dtb file. The dtb file doesn't reflect the
> > real enabled modules. For such case, there have many problems for
> > syscon,... that other modules depends on them.
>=20
> But the user doesn't use the wrong dtb. I don't consider having the DMA
> channels in the dtb makes it wrong, just because DMA is not enabled in th=
e
> kernel. If you'd follow that argument, then the dtb is also wrong if ther=
e is for
> example a crypto device, although the kernel doesn't have support for it
> enabled.
>=20
> -michael

dma_request_chan() is not atomic context.
Even if move it into .startup(), please move it out of spinlock context.

>=20
> >
> > So we cannot support wrong usage cases, that is my thought.
> >
> > Thanks,
> > Andy
> >
> >>
> >> >
> >> > Andy
> >> >> >
> >> >> > To workaround this, we request the DMA channel in _startup().
> >> >> > Other serial drivers do it the same way.
> >> >> >
> >> >> > Signed-off-by: Michael Walle <michael@walle.cc>
> >> >>
> >> >> This appears to cause boot hangs on imx8qxp-mek (boards boots fine
> >> >> on
> >> >> next-20200324 if this patch is reverted)
> >> >>
> >> >> > ---
> >> >> >   drivers/tty/serial/fsl_lpuart.c | 88
> >> +++++++++++++++++++++------------
> >> >> >   1 file changed, 57 insertions(+), 31 deletions(-)
> >> >> >
> >> >> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> >> >> > b/drivers/tty/serial/fsl_lpuart.c index
> >> >> > c31b8f3db6bf..33798df4d727
> >> >> > 100644
> >> >> > --- a/drivers/tty/serial/fsl_lpuart.c
> >> >> > +++ b/drivers/tty/serial/fsl_lpuart.c
> >> >> > @@ -1493,36 +1493,67 @@ static void rx_dma_timer_init(struct
> >> >> lpuart_port *sport)
> >> >> >   static void lpuart_tx_dma_startup(struct lpuart_port *sport)
> >> >> >   {
> >> >> >    u32 uartbaud;
> >> >> > +  int ret;
> >> >> >
> >> >> > -  if (sport->dma_tx_chan
> && !lpuart_dma_tx_request(&sport->port)) {
> >> >> > -          init_waitqueue_head(&sport->dma_wait);
> >> >> > -          sport->lpuart_dma_tx_use =3D true;
> >> >> > -          if (lpuart_is_32(sport)) {
> >> >> > -                  uartbaud =3D lpuart32_read(&sport->port,
> >> UARTBAUD);
> >> >> > -                  lpuart32_write(&sport->port,
> >> >> > -                                 uartbaud |
> >> UARTBAUD_TDMAE, UARTBAUD);
> >> >> > -          } else {
> >> >> > -                  writeb(readb(sport->port.membase +
> UARTCR5)
> >> |
> >> >> > -                          UARTCR5_TDMAS,
> >> sport->port.membase + UARTCR5);
> >> >> > -          }
> >> >> > +  sport->dma_tx_chan =3D dma_request_chan(sport->port.dev, "tx")=
;
> >> >> > + if (IS_ERR(sport->dma_tx_chan)) {
> >> >> > +          dev_info_once(sport->port.dev,
> >> >> > +                        "DMA tx channel request failed,
> >> >> > + operating without tx
> >> >> DMA (%ld)\n",
> >> >> > +                        PTR_ERR(sport->dma_tx_chan));
> >> >>
> >> >> It seems that this since this is called from lpuart32_startup with
> >> >> &sport->port.lock held and lpuart32_console_write takes the same
> >> >> lock it can and hang.
> >> >>
> >> >> As a workaround I can just remove this print but there are other
> >> >> possible error conditions in dmaengine code which can cause a print=
k.
> >> >>
> >> >> Maybe the port lock should only be held around register manipulatio=
n?
> >> >>
> >> >> > +          sport->dma_tx_chan =3D NULL;
> >> >> > +          goto err;
> >> >> > +  }
> >> >> > +
> >> >> > +  ret =3D lpuart_dma_tx_request(&sport->port);
> >> >> > +  if (!ret)
> >> >> > +          goto err;
> >> >>
> >> >> This is backwards: lpuart_dma_tx_request returns negative errno on
> >> >> failure.
> >> >>
> >> >> > +
> >> >> > +  init_waitqueue_head(&sport->dma_wait);
> >> >> > +  sport->lpuart_dma_tx_use =3D true;  if (lpuart_is_32(sport)) {
> >> >> > +          uartbaud =3D lpuart32_read(&sport->port, UARTBAUD);
> >> >> > +          lpuart32_write(&sport->port,
> >> >> > +                         uartbaud | UARTBAUD_TDMAE,
> >> UARTBAUD);
> >> >> >    } else {
> >> >> > -          sport->lpuart_dma_tx_use =3D false;
> >> >> > +          writeb(readb(sport->port.membase + UARTCR5) |
> >> >> > +                 UARTCR5_TDMAS, sport->port.membase +
> >> UARTCR5);
> >> >> >    }
> >> >> > +
> >> >> > +  return;
> >> >> > +
> >> >> > +err:
> >> >> > +  sport->lpuart_dma_tx_use =3D false;
> >> >> >   }
> >> >> >
> >> >> >   static void lpuart_rx_dma_startup(struct lpuart_port *sport)
> >> >> >   {
> >> >> > -  if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
> >> >> > -          /* set Rx DMA timeout */
> >> >> > -          sport->dma_rx_timeout =3D
> >> msecs_to_jiffies(DMA_RX_TIMEOUT);
> >> >> > -          if (!sport->dma_rx_timeout)
> >> >> > -                  sport->dma_rx_timeout =3D 1;
> >> >> > +  int ret;
> >> >> >
> >> >> > -          sport->lpuart_dma_rx_use =3D true;
> >> >> > -          rx_dma_timer_init(sport);
> >> >> > -  } else {
> >> >> > -          sport->lpuart_dma_rx_use =3D false;
> >> >> > +  sport->dma_rx_chan =3D dma_request_chan(sport->port.dev, "rx")=
;
> >> >> > + if (IS_ERR(sport->dma_rx_chan)) {
> >> >> > +          dev_info_once(sport->port.dev,
> >> >> > +                        "DMA rx channel request failed,
> >> >> > + operating without rx
> >> >> DMA (%ld)\n",
> >> >> > +                        PTR_ERR(sport->dma_rx_chan));
> >> >> > +          sport->dma_rx_chan =3D NULL;
> >> >> > +          goto err;
> >> >> >    }
> >> >> > +
> >> >> > +  ret =3D lpuart_start_rx_dma(sport);  if (ret)
> >> >> > +          goto err;
> >> >>
> >> >> This is not backwards.
> >> >>
> >> >> > +
> >> >> > +  /* set Rx DMA timeout */
> >> >> > +  sport->dma_rx_timeout =3D msecs_to_jiffies(DMA_RX_TIMEOUT);
> if
> >> >> > + (!sport->dma_rx_timeout)
> >> >> > +          sport->dma_rx_timeout =3D 1;
> >> >> > +
> >> >> > +  sport->lpuart_dma_rx_use =3D true;  rx_dma_timer_init(sport);
> >> >> > +
> >> >> > +  return;
> >> >> > +
> >> >> > +err:
> >> >> > +  sport->lpuart_dma_rx_use =3D false;
> >> >> >   }
> >> >> >
> >> >> >   static int lpuart_startup(struct uart_port *port) @@ -1615,6
> >> >> > +1646,11 @@ static void lpuart_dma_shutdown(struct lpuart_port
> >> >> > +*sport)
> >> >> >
> >> dmaengine_terminate_all(sport->dma_tx_chan);
> >> >> >            }
> >> >> >    }
> >> >> > +
> >> >> > +  if (sport->dma_tx_chan)
> >> >> > +          dma_release_channel(sport->dma_tx_chan);
> >> >> > +  if (sport->dma_rx_chan)
> >> >> > +          dma_release_channel(sport->dma_rx_chan);
> >> >> >   }
> >> >> >
> >> >> >   static void lpuart_shutdown(struct uart_port *port) @@
> >> >> > -2520,16
> >> >> > +2556,6 @@ static int lpuart_probe(struct platform_device *pdev)
> >> >> >
> >> >> >    sport->port.rs485_config(&sport->port, &sport->port.rs485);
> >> >> >
> >> >> > -  sport->dma_tx_chan =3D
> >> >> > dma_request_slave_channel(sport->port.dev,
> >> >> "tx");
> >> >> > -  if (!sport->dma_tx_chan)
> >> >> > -          dev_info(sport->port.dev, "DMA tx channel request
> failed, "
> >> >> > -                          "operating without tx DMA\n");
> >> >> > -
> >> >> > -  sport->dma_rx_chan =3D
> >> >> > dma_request_slave_channel(sport->port.dev,
> >> >> "rx");
> >> >> > -  if (!sport->dma_rx_chan)
> >> >> > -          dev_info(sport->port.dev, "DMA rx channel request
> failed, "
> >> >> > -                          "operating without rx DMA\n");
> >> >> > -
> >> >> >    return 0;
> >> >> >
> >> >> >   failed_attach_port:
> >> >> >
