Return-Path: <SRS0=iYMu=4J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9360CC11D25
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 01:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3442465D
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 01:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bNyHmlna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgBUBah (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:30:37 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:6148
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729502AbgBUBah (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 20:30:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXvWpEFh6c57m8T3LmzGFjGUPPuIuJgXYMKnbjRHXMZ0LacdO8x1oPMSeCCAoengNwNeOBF7qNkF2Be+Ex74IPgivQEhWdt2ag9o7MUxOa5QAwPBXV/PvT1dTKvxod5IMRRIipwpwDoARDsg3hfwWOWPH1YBh1ObQS0LXZp+zrvV/Pdq2DCCBz2lPUKgCLn6Q76ecs3JrsUG80b/2u+sKDrP7GB9A3u3O8EPDfEv8Qb/EtAD4QhKXgWqI5AucYz5U7D7otnt1A6yBucbSeY3NdnpcSbeRYGZd+5iTwvt0yOQ751Bem7fciso5WY/b0M2hL8ESrKt3sI25fcppxC07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqX3MXmUjl7rY+YlYpcaFD1oI55p9Id+Q0l2GMrQPEk=;
 b=Tp8UtG9jYVUqOCL9FwodS8yrpZ4lbCPeQKMcXOoxJkqqSuF3o86qjwEzjSKlI5z9yz7Li7xQdiMN9pdHZ6SVWhTXHuueSeTD+ud3TZH/gT013cFr8Lpfp0SkdcPEt4yUlsFYJMiOueoDHj5CjeIYEPUMUe1DpFVyKhNi0VLQZd/R42jiB5nukFjMcDqSKdP2s8BsKKk/lmfMfM+2KPokvboecJFdBeMlvIF7iQ4Z8Jvl9SI1UkZwrph/8wSFFK97LZM2I024STKAw6oXFgkjaMFVgipwvZxpAxhF7ToSLbwCrkbyKCDRz3gW8M5Io59aWa4d+aOqUQIbV/LqkZ5jzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqX3MXmUjl7rY+YlYpcaFD1oI55p9Id+Q0l2GMrQPEk=;
 b=bNyHmlna2wHvZDPFPxdQrJu5Nru/cIVwHFEmFXDzEXY3cJ9wJ4rYBWMjv3vlfPiSZdRIPHEhf3e2lukimaLMJnRDR2FTJA8afDofKwtffVMooi/L/bmQvw7lkSwgVo3zIyZ1+ZyfPzkMmsAH8pT8hX0ilqoWouw5xiAXAuGkjB0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4705.eurprd04.prod.outlook.com (20.176.214.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 21 Feb 2020 01:30:33 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 01:30:33 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Yuan Yao <yao.yuan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop
 EARLYCON_DECLARE"
Thread-Topic: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop
 EARLYCON_DECLARE"
Thread-Index: AQHV6BVTF5F9eyvotUSiqL0QbCpNFagk3KrQ
Date:   Fri, 21 Feb 2020 01:30:33 +0000
Message-ID: <AM0PR04MB44817308EA80EBEDC0338E6D88120@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20200220174334.23322-1-michael@walle.cc>
In-Reply-To: <20200220174334.23322-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d65e3365-6452-4f61-2336-08d7b66da51f
x-ms-traffictypediagnostic: AM0PR04MB4705:|AM0PR04MB4705:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4705DC4A197131C6A0AB3D2888120@AM0PR04MB4705.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:83;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(136003)(366004)(376002)(396003)(199004)(189003)(110136005)(86362001)(54906003)(316002)(44832011)(33656002)(6506007)(8936002)(7416002)(7696005)(26005)(186003)(81166006)(81156014)(8676002)(478600001)(71200400001)(52536014)(9686003)(55016002)(2906002)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(4326008)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4705;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h5uzTNUJBvw1QTPLlgWtQQ3CTvUGOUeGAu1kmMxhr2IxRGJwF7MV6N5ZCzdg8Tg2CXLxR9WAa7PQIXjiYXAwhS/aLzOTdmVbsVEj2+3u9NUMNovJAVE0412nwSbjzQ6HD8jHc3VeJh3qD2Q0H/dDBPwKjZaTfqCE7bBtHMQoHL1SmifILfZ1Fng6bknUi/Ji0r4C753U7sbyPnoUFSDfqWGycpqNFeDJIFNM7DQ/kphyjRFJW5WiVF8ZRUAMZ/F+AlsZGFwxj3TrpPMCsUV6iXs/5xAa30E0VltpZpOKAIJ9XaMqHpWIQE5zUzT6dCHIOgJEkCr4nWDw9vsWfEzvS/0hnA3H4VwnaS8fu+6u5JImNqSRXI4XTA4VIKDQdAf2uJ8AkU8hPJT6y0I+sBFmgoMg8ckXU5khfMDQMRYK0adHZ/TUZT7YX94t+KRlulCo
x-ms-exchange-antispam-messagedata: Z3XEwukUvEr7DTT+hWxr3CbLJhV0ksZ7tiQRImDKfPEY1vj3leXIUxlL7ZX+GWVuFLiSHqqpyDVw3OJAw2GIfrHqkfA7RVX6eaKba+Q9hIeTcQbhbXl3LoGjIptFt1lOtvwvynngxaedT6k0hbcjZA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65e3365-6452-4f61-2336-08d7b66da51f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 01:30:33.3226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n22Oce0rTQYUVvpIEhck4DllfeY879p0O8ajuGfGDlLzh9WqPrC23rSvj5Rf7KS5Qm4SRK4hsa6iCMKc/D1nmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4705
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> Subject: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop EARLYCON_DECLA=
RE"
>=20
> This reverts commit a659652f6169240a5818cb244b280c5a362ef5a4.
>=20
> This broke the earlycon on LS1021A processors because the order of the
> earlycon_setup() functions were changed. Before the commit the normal
> lpuart32_early_console_setup() was called. After the commit the
> lpuart32_imx_early_console_setup() is called instead.

How do you pass earlycon args to kernel?

Regards,
Peng.=20

>=20
> Fixes: a659652f6169 ("tty: serial: fsl_lpuart: drop EARLYCON_DECLARE")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 91e2805e6441..27fdc131c352 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2390,6 +2390,8 @@ static int __init
> lpuart32_imx_early_console_setup(struct earlycon_device *devic
> OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart",
> lpuart_early_console_setup);  OF_EARLYCON_DECLARE(lpuart32,
> "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
> OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart",
> lpuart32_imx_early_console_setup);
> +EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
> +EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
>=20
>  #define LPUART_CONSOLE	(&lpuart_console)
>  #define LPUART32_CONSOLE	(&lpuart32_console)
> --
> 2.20.1

