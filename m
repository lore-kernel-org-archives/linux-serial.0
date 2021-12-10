Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A77C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 10 Dec 2021 13:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhLJNpa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Dec 2021 08:45:30 -0500
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:4065
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229984AbhLJNpa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Dec 2021 08:45:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqOlyh5Z26TmaHIszcVNwjj/dBUsENMIEKLaQNDLOV3jJ57O16rwDOPF01sg2nfXkBxRZ4zxj2ObLPtu2fs9RJwlClu6Y6lfuDfCkzqhDiG5nxuOGX71n6om+7etJJ6kNBhD2N0NLzo14TBsEZ8M2mA5z4uTtslUMWpgcrk12cvSSNNk8DEUYCBVzp/eKlueQecsvtv2a+BxWccP54W39QL4bia0LOxmX8WqR+BoO5sjDSPsrJ8k1R5bqJWZxrxdR4y1Vs5F0kuHoSVR9Kj/CRI75zhRUmxSLSR+UnaMo8wzEyd+YrNnHKwEKG+9BtoUMoKRUEi4VOYfTtcjH1CXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJvz0YdImIEJbQfStYPkPDHAg6FB0GayaOcjt1QYk/E=;
 b=Oeo+DW2LdgWBXVanT0u+vg84EPZ1L4DjzjsJ6snV9Y7H70xGYWRtHW2aj2gHMKiVqTU6A6P/T+1qB8XaPl1INExGIjFmC5vwInEwZWo32elbTlIyvlPTWGrz2kkf6SNRmRNHUU9TlpqeGHJ3GTXBmxe5iyvGPe484GPFy+qH3zxvdFooSSdvlQbgQ4DAeljhNrzCdbulUV/RvqYC0aolAfvgIfuw/cNn+ybQXR1W7+djbLVR8aUDJQTnoWM/ra4yMFPgTpxcPhO2lFL6NS3zJbBYUXuvu74q4HlWcX7vg9w2XrpxisgyUISn3SKb7PMIXh23b46dA5G/y3HNnFgO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJvz0YdImIEJbQfStYPkPDHAg6FB0GayaOcjt1QYk/E=;
 b=LFt5mRGYElBS2krBeKcajgy43c5s1G7dBufgAMNUHqAMifgm4fx5iS8HBaQgc+s9pBtEZ3e7PZ8zTF5lOkpP5jvAUPm1vICiqDO25OnF8b2v7ctEOpNn9UGEj0gFU7wG/VVkR/c5TZgsKgi+NAsonrZdBVroUQ+JOfRzdTuY440=
Received: from DM6PR02MB6635.namprd02.prod.outlook.com (2603:10b6:5:221::18)
 by DM6PR02MB6985.namprd02.prod.outlook.com (2603:10b6:5:25d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 13:41:53 +0000
Received: from DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::34ae:48da:1b03:553a]) by DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::34ae:48da:1b03:553a%4]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 13:41:53 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Raviteja Narayanam <rna@xlnx.xilinx.com>
Subject: RE: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Thread-Topic: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Thread-Index: AQHX2tuZuKAQ26hOP0aW5QzRukRvFawbJZYAgBClDzA=
Date:   Fri, 10 Dec 2021 13:41:53 +0000
Message-ID: <DM6PR02MB663589B3489C53A34DC25A31AA719@DM6PR02MB6635.namprd02.prod.outlook.com>
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <YaVPYiGmDsqY+1at@robh.at.kernel.org>
In-Reply-To: <YaVPYiGmDsqY+1at@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75d0c635-a9d6-455b-ac90-08d9bbe2d384
x-ms-traffictypediagnostic: DM6PR02MB6985:EE_
x-microsoft-antispam-prvs: <DM6PR02MB6985C1DC8F245C9231FFC129AA719@DM6PR02MB6985.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EM9xwjiZcNN3gYlx/UQQ09tCKwCoSxAZ6RpJQj13JP41rEJvC/CzM58UKObpOEypTPLlwJwqCUjJQzHmOfOC7avvSWQhPSo4/uQ9+K0/mWWnOSD5gAqeWirCYxTTF2WdaSDzhqmsd6r11dCkBg10yG1J+Pj+KgxVuzK8KLf4XX4HxCddZ6+ARodXe5/+GrCdWjtrYikzjPI+BIZJm81fw0zJHJ9jKY7Uk4Xyx8DaMRai01YMuyX4AvmkCPHCgGexLnu2l7TSHCgPyavQs/gB3aq+gzhO426pPkmYQ/phcEpRcmnADC15Q5xTWc2RPDKBaH0753y/PDS7WPuMeWueQ3P7A8KAJYUwEJ+OWlDrQJXtkrpaeWsH1jl/XOuOnwlFgvog7kVbS/Bc2e0BAboiY2LE2LxYnDBiBzkvmKVHEgubmwwfts0ck+oTEZKiD77VJptF2mndqbjoEGqZs9xEQa3qqeDlDefpLXlIMA/cijLiuRdVqnt9m6f0UHuGnI/J8c6RC4R/cUYzejL+BfoGkGUiirVnIen7w/XO+ZGS9jDTEJYoXGScrNz36WDWlUOy0EesqfuFxg1ddxnfU3fwiBRKrx2ZbZ1SBMKTLY68zdHb6L+l07nppk9L7NF4zZUlnfZzr15RbmF29W7tFqxJjkdgSbYgnRK/hH9YzuIOt5bA/4/5afPKhvWYPDuGSC2Rvicy4sGPH5Qx+CcbDCy/NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6635.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016003)(5660300002)(2906002)(122000001)(86362001)(71200400001)(8676002)(54906003)(4326008)(316002)(6916009)(8936002)(52536014)(6506007)(107886003)(53546011)(33656002)(76116006)(38070700005)(26005)(38100700002)(9686003)(66946007)(186003)(66446008)(64756008)(66556008)(66476007)(7696005)(508600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?82iDYRglQBmhxsjRjPT13KMvBwFUIOj6jxnqTUykT+pdgTFzbqMuvvw2pyoM?=
 =?us-ascii?Q?jw8almqij8xtvkI/OvIZqTp5QdXVdQ3nea71oaiINlO7hT4CDTva0+cdWv37?=
 =?us-ascii?Q?JxaBi0lpZXYNxOyt1WaYRqHIxrvJfwe+4xrfm44zOku2KripSCPOh/693yGU?=
 =?us-ascii?Q?zRzPgZZ1kaIOKWghupem4V+Hq8vFQ0WcF3mQzxvEBk3NXRmJzxf4aTuKeIe3?=
 =?us-ascii?Q?fufYtra0ALWrJdvFhPk4QvNtWH5JONR9hNLNm7luGxe3bMdJXDoeZ72bgrfb?=
 =?us-ascii?Q?zn7gRq6YoijRHiwg/YlyBTHtDLRcRnq9hZmhyXLS3ZC/aVbcY2btBPXEozaQ?=
 =?us-ascii?Q?Z/VE7DcEU1WIGi2ta7VPBnfhtSofjVM/yftWkh4NnsR1RgKj1Ms9PLsMgjMX?=
 =?us-ascii?Q?86CRYwR4IVrGCP8ZFMoXy4og7gKWWfHMGrQHEA+zngRjC7FQvCKemTrig1P1?=
 =?us-ascii?Q?g4XCfiJW1ughDL0YfLVrfBKLn314rD0/X5XjvveRTN4o622MWugsf1Za6abL?=
 =?us-ascii?Q?w1Cpl9UYLEAiaJHDyLPMDrdCTy37cheu1j3vEWa4kbYJparE8zA3V+xfNg0R?=
 =?us-ascii?Q?ctw5j6wLqBnPvszZd4bAkE/9wNob82SA7djJn4gCJi3Gum95qTepWIykdBGn?=
 =?us-ascii?Q?brzZ1Xt+bS78xmRaJl7+DIvVpTOxt5P/FAUPgoHbb6mH7xZwmuu05TI/Zuc+?=
 =?us-ascii?Q?rjUprKAeqiteyzMAaLh6ktrarLd7F6yCOJHYnqAq5AjDGvA6g4hwOYfTpjor?=
 =?us-ascii?Q?0qBoVQFeOSRV5fJWYwIctVzhedyyzogfDgQ0N/OCo/gOQ/FP2sNollnyjVoS?=
 =?us-ascii?Q?noGAbCWSQT5/c+IRczOvKpGnANQd8j4Lh5g7gVVRw7AZ3K8+zWTLUi+fl1Im?=
 =?us-ascii?Q?qr6RuTVO59UUDNlJjXnWMR+xOMDAZMV91BqM5HCCQjXTGD+6aoac/QXr4vcK?=
 =?us-ascii?Q?HBgpcvRs04QWEt5J5rNFEb0rB8tokrlRhRhakl9WJDIAACovsfmzQa2UYQmI?=
 =?us-ascii?Q?unLBuRlLOBFFVG1sRwi5j7YCNOg3BvsNbI+yvDW4F3FAVXPxgtOFkmV4iT50?=
 =?us-ascii?Q?VL8Jnb8vE9jlEbqDrRc9R7uLCLjJa3qA96874dYtQhb01N4socBLTDhJoJ+N?=
 =?us-ascii?Q?MaS2a6S6tgVxrReeDxoTRiLrVW3t3sVVVSZeON/0eAMfpu00yWMfFVkGt2ja?=
 =?us-ascii?Q?zsKgco1THWb59TjPdPE3kBCt6m3MbaUxocxqXRKHbzu/hQ4DmPwuXo1hkskJ?=
 =?us-ascii?Q?7ifBLosx0V/oyiOSt0zM0u8EnnhrxYr5Sgw7SIeLR0hO1KgW4XWkP/jNosm0?=
 =?us-ascii?Q?Almi++ye0+d36gGdDbUkVJHNxzEWpji1HhRwBCmHG3FcQsZ3XVd6L/JWx0qj?=
 =?us-ascii?Q?OOTqROhSeEvDpE40SOasWtC5xmAXrlyi/kMm30y+0Hys1szXBDPVovQLuSAQ?=
 =?us-ascii?Q?LpJGwP+VmBcXxf1KrCQvGCqu0gxRGyO4Y376uBIG9qENFk5OREGkD4+doHue?=
 =?us-ascii?Q?oKOuoKDyhBARVRPWksjgInOlRUo3SehRQbJwPR70S8Q7QVeiy5XLfohoLJg+?=
 =?us-ascii?Q?v7Zc4joDwQVGr5SnCFRb8F3WgUkrYRfwIJcglx9t047wIE56YvNpYNKnF9om?=
 =?us-ascii?Q?2y2kaNqqO6/vWvV0wyZfl70=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d0c635-a9d6-455b-ac90-08d9bbe2d384
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 13:41:53.3106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haxnXivcMTfe32cWmkuYCEbbIfh1dNJwMFHfFD6HPskpLKC8yynqZXFIJoRRwBb6gQxW43cPwdWINl/F9eeong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6985
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, November 30, 2021 3:39 AM
> To: Shubhrajyoti Datta <shubhraj@xilinx.com>
> Cc: linux-serial@vger.kernel.org; devicetree@vger.kernel.org;
> gregkh@linuxfoundation.org; Raviteja Narayanam <rna@xlnx.xilinx.com>
> Subject: Re: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
>=20
> On Tue, Nov 16, 2021 at 04:47:45PM +0530, Shubhrajyoti Datta wrote:
> > Add support for Uart used in Xilinx Versal SOCs as a platform device.
>=20
> No. Why would we want to do that?
Apologies did not understand that.=20

>=20
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> > ---
> >  Documentation/devicetree/bindings/serial/pl011.yaml | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml
> > b/Documentation/devicetree/bindings/serial/pl011.yaml
> > index 5ea00f8a283d..6c73923dd15e 100644
> > --- a/Documentation/devicetree/bindings/serial/pl011.yaml
> > +++ b/Documentation/devicetree/bindings/serial/pl011.yaml
> > @@ -24,9 +24,13 @@ select:
> >
> >  properties:
> >    compatible:
> > -    items:
> > -      - const: arm,pl011
> > -      - const: arm,primecell
> > +    oneOf:
> > +      - items:
> > +          - const: arm,pl011
> > +          - const: arm,primecell
> > +      - items:
> > +          - const: arm,pl011
> > +          - const: arm,xlnx-uart # xilinx uart as platform device
>=20
> 'arm,primecell' means the block has ID registers. Are you saying this
> implementation doesn't?

The ID registers do not have any Xilinx specific identifiers.
However there are differences  like 32-bit access.
>=20
> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.25.1
> >
> >
