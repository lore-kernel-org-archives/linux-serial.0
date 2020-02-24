Return-Path: <SRS0=FrDw=4M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142EFC35670
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 01:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E762071C
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 01:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F2TjBfL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgBXBMF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:12:05 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:21947
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727169AbgBXBMF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 23 Feb 2020 20:12:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7ymAx8D25/ndR3TYEwVvGW7+AHt7Ug54/dZAHBaEgzOnv0E9+w3MGVL9BkdJZpJWRGW1hpZcevYY2QZzNCIlx5aG3TtIQPDYcZ9Ljq2NhMQKK1bGJFq8fYcgicBgT2oJgk+2tbWWYxAc6EUvYuyKbMhj6IOYtkAz/DvGK1x0BSkDqEVsCxiIzJ69x2fwT2KQM4UwyuVI+WNFX3tpvBC8rLUJJy8OBnm+m6G5hSgqDGMGrhOX3GMspREmP8fGQx3A6FtNG71c4FlksCDAhWMqEXZaA5QL75sCNKtZxLYKKwZRHwB0MorsiuO8Luns74FUfJZaBdcT13f0cPRgTow3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bdffaJQO9W7n089H4zE4HqzCrs4JYq0DgQjqccv1R8=;
 b=g23dHmIFSo9gMH0kjEwKKpDT7KGliceCGLXB0CmNo7OON4tWUscgUT4U4+MAh5PM3Id6XbmX6G1ky8Tx4U4TG1IjBiLAutGxBnj162urQkvExGbNjt1HaFgCa5JXw7+e2Ylqu1kp3/vvyJAwFEQj/Ot8VefKg5GbNzz993cde5zZCOQlv8NL1o5v/ieQrl4+7RHLIRp1Y5pCPONRXTfuy5wWNtD+Pqk3HpDf2pC+Lf0RPHpyFgJc592bh/RwVqTXpbCp/9k0I59ANzmMh0PZIxwSCpVPMmFaDpPIxgqq0UGmIfasSXJ1+j0wlnWDFEB1GozKpfLmFM9cPlHyUf9eGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bdffaJQO9W7n089H4zE4HqzCrs4JYq0DgQjqccv1R8=;
 b=F2TjBfL+s7kTxPed1TgaNaegljvDXfDP571Klo0ECzgb645t3qdzC/KCTOqeImE7JmQUFX3Z86Eebhd18ju6bIt6E+9ly5zBkRkqtCRcXF2z8gQgNu08cIiVI+DLj7VEoylPwYhvJvqEcSEEi3vwTiQz8CuVEyLtr4NtflTbpV4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5219.eurprd04.prod.outlook.com (20.177.42.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 01:12:02 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 01:12:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Yuan Yao <yao.yuan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop
 EARLYCON_DECLARE"
Thread-Topic: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop
 EARLYCON_DECLARE"
Thread-Index: AQHV6BVTF5F9eyvotUSiqL0QbCpNFagk3KrQgACHdoCABCoLkA==
Date:   Mon, 24 Feb 2020 01:12:02 +0000
Message-ID: <AM0PR04MB4481B36B83A67E32EA816A5988EC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20200220174334.23322-1-michael@walle.cc>
 <AM0PR04MB44817308EA80EBEDC0338E6D88120@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <51db0e6ba10b4b32dab207e0df8ef0d8@walle.cc>
In-Reply-To: <51db0e6ba10b4b32dab207e0df8ef0d8@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [117.82.241.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b341fb73-13ae-418f-6517-08d7b8c68e0d
x-ms-traffictypediagnostic: AM0PR04MB5219:|AM0PR04MB5219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5219F1DF1540654D0A54F99588EC0@AM0PR04MB5219.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(966005)(45080400002)(71200400001)(8936002)(81156014)(2906002)(81166006)(44832011)(52536014)(7416002)(478600001)(8676002)(316002)(54906003)(66556008)(66446008)(66476007)(66946007)(64756008)(5660300002)(86362001)(7696005)(33656002)(186003)(6506007)(4326008)(110136005)(9686003)(55016002)(76116006)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5219;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0zFqWr8XxSfa/U4KYq1jt/Thnl0nVgxGmtLOwQHAYRPFGTKskRu8/MTsJ5UrBegCsboWtLhNIF7hs6hSPjv2nJgmnjM72jMIb85w4+FuGOIgbU3tcXQZ08ctpOXgi0zqEL0AHfuz01RBf8rH+BDsphxHdTOM7OFG0zTAcquVBe5quExcT/pZmYXK4i2+g/hyRv9O+TWJdGwNkyo+CeDiHtGLFur1F1lkS7u6AhlSeC9gyBYRqyF3Rod5hxCHNuZi43CM25ARTaofe6OwyJdWLvGnKUrxyMFsCsUMfVbSh7POpegzMZR1eH5I2hNSteZFBAIJZULPiNlymEaAqf+UNoE40vY0eaYr+GCytCbRpxtSm6uqWGddzdeQuLpZquzRt/+wvSwuWsTHIT2nhiddqjl4xfu6iWgjl+UM5nTuQEVGiIPLs785z3ygT69HO23v7RTvBWzvq9gMTjXjnkYBbLBSN8nlKcwmSeZyuwxH3IzdLlUsoVaZzNtFH2zlSZxGQJmXyru5RAae1UB2IsROA==
x-ms-exchange-antispam-messagedata: g8kj1ZqOhYQHDKRbs/YflHBWiuxrFunP1+F4CxAniyBb8JoBv8+jdUz6XfvPbLCFXDZmiVHBNz3SR1GDvfeGOz2s8pL7r+rBPc9Rc3MB3IT9luItKHBhRa5e+uiy6X5pJeYYL9vFANrs+PSl2Xjm3g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b341fb73-13ae-418f-6517-08d7b8c68e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 01:12:02.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmOfX86CmKYkH4oKK+kl3eOdH3wOCYFAi91dZRmM/XBpZi/WW52qZnAjqIXJv2GYr5mJGuURGeMGf6m4VaunCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5219
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> Subject: Re: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop
> EARLYCON_DECLARE"
>=20
> Hi,
>=20
> Am 2020-02-21 02:30, schrieb Peng Fan:
> >> Subject: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop
> >> EARLYCON_DECLARE"
> >>
> >> This reverts commit a659652f6169240a5818cb244b280c5a362ef5a4.
> >>
> >> This broke the earlycon on LS1021A processors because the order of
> >> the
> >> earlycon_setup() functions were changed. Before the commit the normal
> >> lpuart32_early_console_setup() was called. After the commit the
> >> lpuart32_imx_early_console_setup() is called instead.
> >
> > How do you pass earlycon args to kernel?
>=20
> earlycon=3Dlpuart32,mmio32be,0x2950000,115200
>=20
> please note that there are two possible declarations: (1) an OF/ACPI base=
d
> earlycon, eg just "earlycon" on the bootargs and (2) an elaborate one whe=
re
> you can give the offset and access method yourself, eg. the one from abov=
e.
>=20
> (1) will still work even with the EARLYCON_DECLARE() removed. But (2) wil=
l
> search through all possible
>    OF_DELARE_EARLYCON(lpuart32,..)
>    EARLYCON_DECLARE(lpuart32,..)
>=20
> and doesn't take the compatible into account. So which setup function is
> actually called depends on (a) the order of the OF_DECLARE_EARLYCON() and
> EARLYCON_DECLARE() statements and (b) on the compiler (thats just a guess=
!).
> For me, the order in which it will actually end up in the __earlycon_tabl=
e is
> reversed, eg. the last one is called. So now that you've removed the
> EARLYCON_DECLARE() the last one is the imx setup function which will add
> the reg offset and doesn't work on LS1021A.

You mean the OF_DECLARD_EARLYCON for i.MX7ULP will be put before LS1021A
in Image? I am not sure about this. If this is true, you could try below di=
ff, to see
whether it works. i.MX always use little endian.

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 91e2805e6441..1b0aa3b836c5 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2381,8 +2381,10 @@ static int __init lpuart32_imx_early_console_setup(s=
truct earlycon_device *devic
        if (!device->port.membase)
                return -ENODEV;

-       device->port.iotype =3D UPIO_MEM32;
-       device->port.membase +=3D IMX_REG_OFF;
+       if (device->port.iotype !=3D UPIO_MEM32BE) {
+               device->port.iotype =3D UPIO_MEM32;
+               device->port.membase +=3D IMX_REG_OFF;
+       }
        device->con->write =3D lpuart32_early_write;

        return 0;

Thanks,
Peng.

>=20
> I've proposed a fix of the underlying problem [1]. But that fix also requ=
ires the
> EARLYCON_DECLARE() in this driver.
>=20
>=20
> -michael
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Flinux-serial%2F20200220174607.24285-1-michael%40walle.cc%
> 2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7Cc411bf1d5d45435be2a
> 308d7b6b14a2c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 7178744883261681&amp;sdata=3Dgjl8rie%2FXhUQ0pxcAbbDI4NGqGDYj1jpqfR
> mRi%2FAgFk%3D&amp;reserved=3D0
