Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F501C3F2C6
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 22:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE1820866
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 22:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Af0JZZlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCCWnU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:43:20 -0500
Received: from mail-am6eur05on2042.outbound.protection.outlook.com ([40.107.22.42]:51584
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbgCCWnU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 17:43:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4bIRiOZDf7JlGd5Z9sGhQhJMFjlVQuF0g5JoFIrgwPv6AlX1CWMujYJIBbds9PFdMtbM5oQKhj2skTjJcsET1nDIPLv3SvYJwjI+muDz07rVjwAuFLeaQRATwUDYhFiORvDAWd8F4ih5vbTxDkKO83bBl5BTaxg+qxidjX0AcHiKowgYs4VrPWo4Ob86OlJX3IOyE8qjb4JtzfI+z/Z01FAJfTua8WTJTOxgbM1jV3FuqUu25ABLYx1FgscJkvj70JI1tdsJiH9fkrDDirqOyWdpzsh4gF6m9wNkKgtrLfpf3peBPGtBl3Ou5CbbB3NDDZPMQhv9tEuNdHqmBm0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRGNM/6Q4FAeMS+OD8oZg1UrMD2a0m+34mqWV+T66vo=;
 b=nklG32qGDCZO8zqrKM2uOw6Koiz787tDl2OHSbg6+eYr9mawdTSotHKa+5EGRBdPnk/1+RbPRxbp7yGcVg1p6CjPYiT4K5iPRqOfXvVsWQR3lXgyoallOLXS9kA4T9qyIg5YPCFvLxyB9lgFuJv5id24Mt9LvqBGVsD+t1sYCmcsUd2+46VOgMxxM8oiKRdBSI6R7DMIjWADdxdJOpUk29zYCBg1Kcm8bzJpahqEzqWmVH1o+pObSLIoa3tzj68Rc+d53X92NlP6vcl5S7kymP6LSYRx47gH/axAb1WWcXXbONpoc+PJfBmOdJH5jT6dCqQ05h1LO2OxqttJ890Mcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRGNM/6Q4FAeMS+OD8oZg1UrMD2a0m+34mqWV+T66vo=;
 b=Af0JZZlJ6zszftrGmMPZ+1KVDAFxDHV21V7y0ZR7LMjFwrywp6au+QiVNJKHUNJAjgNJsALN6bqJqBmSn+mcGhwm4FePCy1FbMuRQNz3lt/X7TjmfLA0gu0VQJp7qy6HlC173DSZfq+VoegMbUKzZ0xwJl9HZVtcgck0/jDWPsU=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6765.eurprd04.prod.outlook.com (20.179.235.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Tue, 3 Mar 2020 22:43:16 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 22:43:16 +0000
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
Subject: RE: [PATCH v3 8/9] arm64: dts: ls1028a: add "fsl,vf610-edma"
 compatible
Thread-Topic: [PATCH v3 8/9] arm64: dts: ls1028a: add "fsl,vf610-edma"
 compatible
Thread-Index: AQHV8YM+rjjpH1ep4E+nXaFwPvP5Z6g3di1A
Date:   Tue, 3 Mar 2020 22:43:16 +0000
Message-ID: <VE1PR04MB668748A35B0611CFC0C21CA38FE40@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20200303174306.6015-1-michael@walle.cc>
 <20200303174306.6015-9-michael@walle.cc>
In-Reply-To: <20200303174306.6015-9-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3d34b14-6880-4ebb-aa5f-08d7bfc443a1
x-ms-traffictypediagnostic: VE1PR04MB6765:|VE1PR04MB6765:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6765FA63A337626A324ADA068FE40@VE1PR04MB6765.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(9686003)(7696005)(8936002)(81156014)(316002)(110136005)(76116006)(54906003)(2906002)(71200400001)(66556008)(478600001)(66946007)(8676002)(66476007)(86362001)(81166006)(33656002)(4326008)(55016002)(5660300002)(64756008)(53546011)(6506007)(52536014)(66446008)(7416002)(186003)(26005)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6765;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zjqrXFLv/K21G4Nb8jnGUCGKSQf+3EBpwVxjUQ0baWjTLq0RAOLlsTraNpXXD4ETGZckgMM9L/VuNVcmEurKhJcIU3KnPeyiCuVCC5cX/1UuAzZpLYpqxesHyjqsIwZ62rMUnlZbrWKT6OPUJjVmL9Amwy2iLpDwWRCVAnPNoW6pOB2Zlgk5VXbuoldv9FFBzavnZQ/m1njdT6q0pTGr74x6N7bY4EqsEs4v+LUYOvapZMX1eiaTNUaF7UOY9y6iqcSog8q9XEWMSxNqV66Lr/sJgOxTO2JVaCajEUpkiv8VPbT84esiwGeqecHK4hHa3FEOPm4gOQfN6zLVuio/RVq1OEwZNmvLUckKnH8fVsgFeurJYq/JYQ54czxHcybrRPHJlhd0j0XavT/BQhFYa9F6T2fab4u3z72J4dxKSWVq8ZgkP/ia3wM4vHNMAvITP9zV9djDv9zzJ0BfH+L8fAA3tJNyLneGWN9/g/8gC0eFP1Xi6HM3L/EJO1XNp9Cb
x-ms-exchange-antispam-messagedata: D0qelNDjuMFbYoukyWjznD4bToAf5FztoB/bgYjdXYEp0/8V+iFJuk/rbTaHG4IoZ85CvFc94mWJjcVjVKCTLy20e++R1YOgMKD/5re9PvI7Rc/01ygtAlltFlXORtOVdRjCpH1MoEMtNsUiYpPOEQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d34b14-6880-4ebb-aa5f-08d7bfc443a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 22:43:16.3779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbNogP6wJHy79TKcRipYtOHRHjUgPe97DkInCUbYNAxcTVgIjmAcGFVgKecYzAagNSVFm9J+pmO3lqDkR5eOMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6765
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
> Subject: [PATCH v3 8/9] arm64: dts: ls1028a: add "fsl,vf610-edma" compati=
ble
>=20
> The bootloader does the IOMMU fixup and dynamically adds the "iommus"
> property to devices according to its compatible string. In case of the eD=
MA
> controller this property is missing. Add it. After that the IOMMU will wo=
rk
> with the eDMA core.

It probably makes sense to have the fsl,vf610-edma as a secondary compatibl=
e.  But I think it probably need an update to the binding document too(espe=
cially the compatible is required to function).  Also looks like the recent=
 update for the binding has a typo for " fsl,fsl,ls1028a-edma", can you als=
o fix that all together?

>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 0bf375ec959b..0843cfbe7ae1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -335,7 +335,7 @@
>=20
>  		edma0: dma-controller@22c0000 {
>  			#dma-cells =3D <2>;
> -			compatible =3D "fsl,ls1028a-edma";
> +			compatible =3D "fsl,ls1028a-edma", "fsl,vf610-edma";
>  			reg =3D <0x0 0x22c0000 0x0 0x10000>,
>  			      <0x0 0x22d0000 0x0 0x10000>,
>  			      <0x0 0x22e0000 0x0 0x10000>;
> --
> 2.20.1

