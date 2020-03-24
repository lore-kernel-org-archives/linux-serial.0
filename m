Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0749C43331
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779712076F
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 16:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OUcOEDBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCXQdJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:33:09 -0400
Received: from mail-am6eur05on2055.outbound.protection.outlook.com ([40.107.22.55]:6038
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727708AbgCXQdI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 12:33:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwhpTdCvdveh/SleeC+hxFS+qd6eiFLDL6yQ6Xo6JZqRpDsMtX7Mdw1wQndi+QhXd4YNzrfPESkK/TpL0t40lliHDjw0d5xZHYeR1PqKL5AEMlWRTmRKkgFrS6lfEf4ZHD0zt+sYHu04qzvddRb30VZbPUVnY9RRY9iycW+Xnw02GhIUKk2694gHR2ulg9A9Ec8+PCurIzzNV8/53HOQW77OAQCPpRyStoQjwWxk7tONeWX6JWarevVB/Vcw8N4tFyE12XVWPyOLlMjyxBC72QBvuWMke/adope+gta3/9zF1hszja/jyHV5JEEuWUf5qkyeDwmUPcTWWABuDx+E5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO4SitEsSdMrauGa+H+QKbY8zClaLVoA2coop8hf9LU=;
 b=ZlIup9kmEu/aPZipMVbTGwAr7R3T2qxMTKj7mPsDr2dbmicPliLj+D39YdITEmCIOkcQpoxVKnVdGs9WJ0Cx1mTVLwuDQTa2aHXC+7sWgX8S+2a1mSBcTY/7tRYf7iWqkJJqkheAkxKSyifBDw5YebdsRLfpESCqNrM9UIp0BoubUlOutDDuCir1AGIz+HiXrp5Zu69uZtnY4Ks9Bd86KMcWmD8IUDT8+YsLBe6jIbQWIoOdiknkc+UV03VhWFupTitVVniNHTHtiP85QIBt4fEh/Iq2lK88hu5oQ1aSSX5qajDdSkW8136MD1LbXdtG8kZ4JjOl/VAFaidPavn8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO4SitEsSdMrauGa+H+QKbY8zClaLVoA2coop8hf9LU=;
 b=OUcOEDBxgUCioetBe05bs0RioFhy2WzYf5CQANjMnr0sGShKDlcUV4aAu6Q5EzeyDBz1BO0MfsTYLJj+G6e3LaEN52Kpf6YgDlkLprnA81AeDQniKDgJjMoZBXcC2Zdqwv6S6Z7mHGluNa/06tOVxjzA1SAxf2ZPR8gU+1gvCnc=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB2752.eurprd04.prod.outlook.com (10.175.21.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Tue, 24 Mar 2020 16:28:29 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c991:848b:cc80:2768]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c991:848b:cc80:2768%7]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 16:28:29 +0000
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
Thread-Index: AQHV9AB7XTSsAtbd1E+3Etbi7F0aCKhYBLIQgAACxwCAAAGMwA==
Date:   Tue, 24 Mar 2020 16:28:29 +0000
Message-ID: <VI1PR0402MB360060ABA69BB138A33C9615FFF10@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20200306214433.23215-1-michael@walle.cc>
 <20200306214433.23215-2-michael@walle.cc>
 <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <VI1PR0402MB36001AEE78E0F067D29F2816FFF10@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <725d2abdcdc0ab05cc1f03028f8a2919@walle.cc>
In-Reply-To: <725d2abdcdc0ab05cc1f03028f8a2919@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3442d14e-efcf-42d6-b94a-08d7d01062e5
x-ms-traffictypediagnostic: VI1PR0402MB2752:|VI1PR0402MB2752:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB2752B55E0786FD924465AD4FFFF10@VI1PR0402MB2752.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(6916009)(478600001)(9686003)(55016002)(2906002)(8676002)(316002)(81156014)(4326008)(186003)(26005)(53546011)(86362001)(7696005)(6506007)(52536014)(54906003)(64756008)(71200400001)(66476007)(66946007)(76116006)(33656002)(66446008)(81166006)(8936002)(5660300002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2752;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNiK6eJhHnXwzzaxmnIeAFp5xN9GEPnj/8ufBJJffJWWrH1CXG5F8sTlYNjE8AFi26B869e3qWcpx3zp7DEobzO7p3USD96jG9YunUnMeaapgrersIeyp2JfF6vP95IAVhGTNA0GnWIW5xHeox+g0/l/A1ShIZFrEaYVaeWTyU7gNeEdjzumJ2n9VcK6/tsxpm/iJvGfFIaEd1FJUsVcvhhVYqQBLf71uh0+HmKa/wcN5EF2Y1Fx15BCC+VlopaI/QcfUi61+zTUTufj+HNSKzCbwZVnFAJ4qcrKqxOQBN8mSJUecsTIgwAed9x6W3VTIg1VJEd3BFsQq8yqXSJAJ6Hd33I0E1sC/QAjcpAH0E3Lj+2OaBgJApDn9VT/pxzjjyyme+e267XmpJb65WLOQBowW+MkLbil2VpZr20lyBlfE8SbL3N9blRVgt3aFDMk
x-ms-exchange-antispam-messagedata: RVPy1rDoTTezv9rjG5k1Uha87M4dPg6BX7Z6FYYtzGk5CoWSXEQBMSxUgP3CFaOY2j62P+wq8ITKWEBCbema7kbm/PVAJEUDvV/9slrDwNjEa0usqs1rmcKcxu/Yy5euwdCtO9gTEs6MNvFqIZ45qw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3442d14e-efcf-42d6-b94a-08d7d01062e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 16:28:29.1642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 194814UYINzri0Rec8vNKFFez+IE9EM4zhKg+ouVKfcTGwP7qPwbNNPExDNY0nd1IyZJyRjZ09Vlr8i/h8MEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2752
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Michael Walle <michael@walle.cc> Sent: Wednesday, March 25, 2020 12:1=
8 AM
> Am 2020-03-24 17:12, schrieb Andy Duan:
> > From: Leonard Crestez <leonard.crestez@nxp.com> Sent: Tuesday, March
> > 24, 2020 11:27 PM
> >> On 06.03.2020 23:44, Michael Walle wrote:
> >> > The DMA channel might not be available at probe time. This is esp.
> >> > the case if the DMA controller has an IOMMU mapping.
> >> >
> >> > There is also another caveat. If there is no DMA controller at all,
> >> > dma_request_chan() will also return -EPROBE_DEFER. Thus we cannot
> >> > test for -EPROBE_DEFER in probe(). Otherwise the lpuart driver will
> >> > fail to probe if, for example, the DMA driver is not enabled in the
> >> > kernel configuration.
> > If DMA driver is not enabled, we should disable DMA controller node in
> > dts file to match current sw environment, then driver doesn't do defer
> > probe.
> >
> > So I still suggest to check -EPROBE_DEFER for
> > dma_request_slave_channel() in
> > .probe() function.
>=20
> I don't know if I can follow you here. This would lead to non functional =
setups,
> eg. one build its own kernel with DMA disabled, but still have a device t=
ree
> with the DMA nodes. And besides, the current workaround to request the
> DMA channel in startup() is basically working, isn't it? And once the und=
erlying
> problem is fixed (the infinite EPROBE_DEFER), it could be moved back into
> _probe().
>=20
> -michael

I think the user use wrong dtb file. The dtb file doesn't reflect the real =
enabled
modules. For such case, there have many problems for syscon,... that other =
modules
depends on them.

So we cannot support wrong usage cases, that is my thought.

Thanks,
Andy =20

>=20
> >
> > Andy
> >> >
> >> > To workaround this, we request the DMA channel in _startup(). Other
> >> > serial drivers do it the same way.
> >> >
> >> > Signed-off-by: Michael Walle <michael@walle.cc>
> >>
> >> This appears to cause boot hangs on imx8qxp-mek (boards boots fine on
> >> next-20200324 if this patch is reverted)
> >>
> >> > ---
> >> >   drivers/tty/serial/fsl_lpuart.c | 88
> +++++++++++++++++++++------------
> >> >   1 file changed, 57 insertions(+), 31 deletions(-)
> >> >
> >> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> >> > b/drivers/tty/serial/fsl_lpuart.c index c31b8f3db6bf..33798df4d727
> >> > 100644
> >> > --- a/drivers/tty/serial/fsl_lpuart.c
> >> > +++ b/drivers/tty/serial/fsl_lpuart.c
> >> > @@ -1493,36 +1493,67 @@ static void rx_dma_timer_init(struct
> >> lpuart_port *sport)
> >> >   static void lpuart_tx_dma_startup(struct lpuart_port *sport)
> >> >   {
> >> >    u32 uartbaud;
> >> > +  int ret;
> >> >
> >> > -  if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
> >> > -          init_waitqueue_head(&sport->dma_wait);
> >> > -          sport->lpuart_dma_tx_use =3D true;
> >> > -          if (lpuart_is_32(sport)) {
> >> > -                  uartbaud =3D lpuart32_read(&sport->port,
> UARTBAUD);
> >> > -                  lpuart32_write(&sport->port,
> >> > -                                 uartbaud |
> UARTBAUD_TDMAE, UARTBAUD);
> >> > -          } else {
> >> > -                  writeb(readb(sport->port.membase + UARTCR5)
> |
> >> > -                          UARTCR5_TDMAS,
> sport->port.membase + UARTCR5);
> >> > -          }
> >> > +  sport->dma_tx_chan =3D dma_request_chan(sport->port.dev, "tx");
> >> > + if (IS_ERR(sport->dma_tx_chan)) {
> >> > +          dev_info_once(sport->port.dev,
> >> > +                        "DMA tx channel request failed, operating
> >> > + without tx
> >> DMA (%ld)\n",
> >> > +                        PTR_ERR(sport->dma_tx_chan));
> >>
> >> It seems that this since this is called from lpuart32_startup with
> >> &sport->port.lock held and lpuart32_console_write takes the same lock
> >> it can and hang.
> >>
> >> As a workaround I can just remove this print but there are other
> >> possible error conditions in dmaengine code which can cause a printk.
> >>
> >> Maybe the port lock should only be held around register manipulation?
> >>
> >> > +          sport->dma_tx_chan =3D NULL;
> >> > +          goto err;
> >> > +  }
> >> > +
> >> > +  ret =3D lpuart_dma_tx_request(&sport->port);
> >> > +  if (!ret)
> >> > +          goto err;
> >>
> >> This is backwards: lpuart_dma_tx_request returns negative errno on
> >> failure.
> >>
> >> > +
> >> > +  init_waitqueue_head(&sport->dma_wait);
> >> > +  sport->lpuart_dma_tx_use =3D true;  if (lpuart_is_32(sport)) {
> >> > +          uartbaud =3D lpuart32_read(&sport->port, UARTBAUD);
> >> > +          lpuart32_write(&sport->port,
> >> > +                         uartbaud | UARTBAUD_TDMAE,
> UARTBAUD);
> >> >    } else {
> >> > -          sport->lpuart_dma_tx_use =3D false;
> >> > +          writeb(readb(sport->port.membase + UARTCR5) |
> >> > +                 UARTCR5_TDMAS, sport->port.membase +
> UARTCR5);
> >> >    }
> >> > +
> >> > +  return;
> >> > +
> >> > +err:
> >> > +  sport->lpuart_dma_tx_use =3D false;
> >> >   }
> >> >
> >> >   static void lpuart_rx_dma_startup(struct lpuart_port *sport)
> >> >   {
> >> > -  if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
> >> > -          /* set Rx DMA timeout */
> >> > -          sport->dma_rx_timeout =3D
> msecs_to_jiffies(DMA_RX_TIMEOUT);
> >> > -          if (!sport->dma_rx_timeout)
> >> > -                  sport->dma_rx_timeout =3D 1;
> >> > +  int ret;
> >> >
> >> > -          sport->lpuart_dma_rx_use =3D true;
> >> > -          rx_dma_timer_init(sport);
> >> > -  } else {
> >> > -          sport->lpuart_dma_rx_use =3D false;
> >> > +  sport->dma_rx_chan =3D dma_request_chan(sport->port.dev, "rx");
> >> > + if (IS_ERR(sport->dma_rx_chan)) {
> >> > +          dev_info_once(sport->port.dev,
> >> > +                        "DMA rx channel request failed, operating
> >> > + without rx
> >> DMA (%ld)\n",
> >> > +                        PTR_ERR(sport->dma_rx_chan));
> >> > +          sport->dma_rx_chan =3D NULL;
> >> > +          goto err;
> >> >    }
> >> > +
> >> > +  ret =3D lpuart_start_rx_dma(sport);  if (ret)
> >> > +          goto err;
> >>
> >> This is not backwards.
> >>
> >> > +
> >> > +  /* set Rx DMA timeout */
> >> > +  sport->dma_rx_timeout =3D msecs_to_jiffies(DMA_RX_TIMEOUT);  if
> >> > + (!sport->dma_rx_timeout)
> >> > +          sport->dma_rx_timeout =3D 1;
> >> > +
> >> > +  sport->lpuart_dma_rx_use =3D true;  rx_dma_timer_init(sport);
> >> > +
> >> > +  return;
> >> > +
> >> > +err:
> >> > +  sport->lpuart_dma_rx_use =3D false;
> >> >   }
> >> >
> >> >   static int lpuart_startup(struct uart_port *port) @@ -1615,6
> >> > +1646,11 @@ static void lpuart_dma_shutdown(struct lpuart_port
> >> > +*sport)
> >> >
> dmaengine_terminate_all(sport->dma_tx_chan);
> >> >            }
> >> >    }
> >> > +
> >> > +  if (sport->dma_tx_chan)
> >> > +          dma_release_channel(sport->dma_tx_chan);
> >> > +  if (sport->dma_rx_chan)
> >> > +          dma_release_channel(sport->dma_rx_chan);
> >> >   }
> >> >
> >> >   static void lpuart_shutdown(struct uart_port *port) @@ -2520,16
> >> > +2556,6 @@ static int lpuart_probe(struct platform_device *pdev)
> >> >
> >> >    sport->port.rs485_config(&sport->port, &sport->port.rs485);
> >> >
> >> > -  sport->dma_tx_chan =3D dma_request_slave_channel(sport->port.dev,
> >> "tx");
> >> > -  if (!sport->dma_tx_chan)
> >> > -          dev_info(sport->port.dev, "DMA tx channel request failed,=
 "
> >> > -                          "operating without tx DMA\n");
> >> > -
> >> > -  sport->dma_rx_chan =3D dma_request_slave_channel(sport->port.dev,
> >> "rx");
> >> > -  if (!sport->dma_rx_chan)
> >> > -          dev_info(sport->port.dev, "DMA rx channel request failed,=
 "
> >> > -                          "operating without rx DMA\n");
> >> > -
> >> >    return 0;
> >> >
> >> >   failed_attach_port:
> >> >
