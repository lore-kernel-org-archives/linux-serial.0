Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8638C3F2C6
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 22:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DCD2072A
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 22:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bEpjs4re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCCWtv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:49:51 -0500
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:6221
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727274AbgCCWtu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 17:49:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCFypjR18m9ekFPZdvLG51XBsd/vcJvaQTC7g0Lde7k6igqPbEa6y1CWIunOK6IGw9GzDJG/xrsTBVSSSGutIvWeapFwwRzxxu6xhZCX9HLTYz3kwLniwCfzfpzEAZGcW9ML8oeQJIk1/bEded7yJA5XqfA5r7T0yQl51iiJdLpWt+QSmTNBi3VVSJg8T9Q1dlTm0TJK5Muhv/ksMouKq48PX+cW7oQ+aHX5SGPR2SCWo9u9/4bRkYy0LT+fXbZbpbokjGg+VV7AbD4yYsZTOSb9tdd5K0DnAnafGB6eunAFxq+Bf3bI1JZfPtFHoktgGcptjrO6lZUKoGpz/1Huwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9x1xnR9GSgOL8FUWHHycaXlpoypjT8Vcuij6Va7HNM=;
 b=hcNUKUC2jPiBxDG11qbUFMpR/P5MFG82xgHFmgW5Z0uDvHy6IhT4bCeezdD7YqdZDvzejs+O6GQfKBNu1PjHpImK7KVKtyu4xnxE3yxrYx2yYGZS6iBCY/ZCvZB/OSAriM3dntgcMX/yDCB5ebSUCHREXndNJDTy+xtx1leUA+zfEURIbu4ZL0aJnMiRW2jRik7zFrlxC/mjV+/OL0pRmlh66hboXu6Gi/VHNFtb7UbtVboh21Pi1DNKOYAIQM4IgLhdMtz6yTr7hJk5RD5Kp0aLJO3faj8NsMtTnDxjd9Z7zl8JuhaADJY/QIYtPtXvMTH3y6AO3nhpxhvhP8evFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9x1xnR9GSgOL8FUWHHycaXlpoypjT8Vcuij6Va7HNM=;
 b=bEpjs4reaX2r784SKXIyyCHs5rsekHTNgm37BCi1FVbHC/sB1Sf2fmJpAP0Z0YQcaY5EOH3k+ZrfjJRh/a6KVhwY3yO+BU59IhcFRcCZAiSVp55sU749NXXcVgBKgPKgVU4aYeCFBE6fSyXS6JIC/MMNMJzkQ9e1qEg8Yf9mm/Q=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Tue, 3 Mar 2020 22:49:47 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 22:49:47 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>
Subject: RE: [PATCH v3 0/9] tty: serial: fsl_lpuart various fixes and LS1028A
 support
Thread-Topic: [PATCH v3 0/9] tty: serial: fsl_lpuart various fixes and LS1028A
 support
Thread-Index: AQHV8YM971japwVgGkKdbH8fUbf17Kg3eLTQ
Date:   Tue, 3 Mar 2020 22:49:47 +0000
Message-ID: <VE1PR04MB6687681658B2460F8A0AD8608FE40@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20200303174306.6015-1-michael@walle.cc>
In-Reply-To: <20200303174306.6015-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1420d00-5ea5-461a-c7a0-08d7bfc52c72
x-ms-traffictypediagnostic: VE1PR04MB6687:|VE1PR04MB6687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6687D113ED885BE6AD4705048FE40@VE1PR04MB6687.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(110136005)(6506007)(9686003)(66446008)(33656002)(54906003)(53546011)(316002)(66476007)(66556008)(66946007)(478600001)(64756008)(2906002)(52536014)(86362001)(7696005)(76116006)(7416002)(5660300002)(26005)(4326008)(186003)(8676002)(8936002)(55016002)(81166006)(81156014)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6687;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: taxt+VKhO9iRyXtQFEr9hJG4ZZ2mRD1fCvF9IF+bAxGT5A3fE0RgDQ2iq7Nc3kI3aHs3gW5PJg3HFVi233sUGIPeKfqyZgmLHqXI1TMPmDSByrnHcmSiglDnGr8vNyLhLT4yqJtfrVPv4HVRiCjWYpRCOYjV9fULfc9WB3/tpYCnjjk6GkjjoTEHv4oT80K1X2I7/Fd87yowUK9ATMfIIlpCuvQ1VjBUD7oI5ww6EoWVOy72oDowbdFe/7wKWg+ZisFPOYOKNg/ITbw2QsVV3EUOQTYLiZCkMhRnSC0biCMuhIrFYahddzql8+oafKP0DGOfCGnI2z1bqJY19xpZ5ucO2zROKdEtVc8Bc9Bqht9D39I/TVnit0IWO9tZEB+79LUTBCFZ970utrmCWhbD+AOBOWuhDxCbYVRX9+GiI1+B7d8k6pTQo8opSLpWQnXE
x-ms-exchange-antispam-messagedata: ZNFK94WaZFRojkOae8uYRWhWJCKVkOwXw7F3WRN0qDr+c8pBKro8NVZiQrZOVAcmtr7s3nDH1vMQ2Wk8fa6ERNiKvcPhlgxqPOaf32uxtcMi7WcPc0zna5MJYoe5s0gwBtWF4KcSzQQnSRFA5+If3Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1420d00-5ea5-461a-c7a0-08d7bfc52c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 22:49:47.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dwjw1gK44pymHTVfw9J8FtFHt66QOzUwTBdjUplG14uHcO7J96s33AxVIY5vyKb6+ahEHoj+tFVpgBaOtOmMGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6687
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, March 3, 2020 11:43 AM
> To: linux-serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Shawn
> Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Jiri Slaby
> <jslaby@suse.com>; Peng Fan <peng.fan@nxp.com>; Vabhav Sharma
> <vabhav.sharma@nxp.com>; Yuan Yao <yao.yuan@nxp.com>; Michael Walle
> <michael@walle.cc>
> Subject: [PATCH v3 0/9] tty: serial: fsl_lpuart various fixes and LS1028A
> support
>=20
> These are various fixes for problems I found during development of the
> LS1028A support for the LPUART.
>=20
> Also, I'm not sure if this series should be split between the "tty:
> serial: fsl_lpuart" patches and the devicetree patches. So unless someone
> tell me otherwise I keep them together to avoid mention any dependencies.

Normally the soc maintainer prefer to have device tree patches merged throu=
gh the soc subsystem.  So probably better to separate.

>=20
> Changes since v2:
> Changed DMA channel request handling. Spotted by Rob Herring. Thanks.
>=20
> Modified patches:
>   tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
>=20
> Changes since v1:
> DMA support fixes.
>=20
> New patches:
>   tty: serial: fsl_lpuart: fix DMA mapping
>   arm64: dts: ls1028a: add "fsl,vf610-edma" compatible
>=20
> Modified patches:
>   arm64: dts: ls1028a: add missing LPUART nodes
>    - add dma phandles
>=20
> Michael Walle (9):
>   Revert "tty: serial: fsl_lpuart: drop EARLYCON_DECLARE"
>   tty: serial: fsl_lpuart: free IDs allocated by IDA
>   tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
>   tty: serial: fsl_lpuart: fix DMA mapping
>   dt-bindings: serial: lpuart: add ls1028a compatibility
>   tty: serial: fsl_lpuart: add LS1028A support
>   tty: serial: fsl_lpuart: add LS1028A earlycon support
>   arm64: dts: ls1028a: add "fsl,vf610-edma" compatible
>   arm64: dts: ls1028a: add missing LPUART nodes
>=20
>  .../devicetree/bindings/serial/fsl-lpuart.txt |  10 +-
>   .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  75 +++++-
>  drivers/tty/serial/fsl_lpuart.c               | 251 ++++++++++++------
>  3 files changed, 255 insertions(+), 81 deletions(-)
>=20
> --
> 2.20.1

