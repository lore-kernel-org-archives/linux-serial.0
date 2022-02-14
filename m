Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4637FC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 14 Feb 2022 06:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbiBNGth (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Feb 2022 01:49:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbiBNGtg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Feb 2022 01:49:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F79857177;
        Sun, 13 Feb 2022 22:49:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5wME+PvvEkE0RKN2eOrOsEi0meVIXVU0b830xxVKfNufQ5fjjDBiLMqjU2UfqRMUBQ17eBmyVha6jsYt674ayPJFiNZEvapifaTIGiWiIqR+5zob2ER3pA5OJY9MrXFFzQmDYZZG+9QMXa57bEgt1jpCXRWXOGsv4v+Ui+0AGzbutnz9I7LOQoGWvCqpBBeyEHIIgfC+yImlcO37tVi3JS8GIDaaIU8YQouvuEifqcmsiN35LPHjJKykMlIJJjuwHYITgkJczwloY7eiEim1n0FD09U0oD/l8WauR2j3wPbLNvJYXxeYmGN46ZzpgBlYzgXXUCJL+ycjycpjSkeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SBtV1HWi6hQtegp1+ys6LHAWYQzByChBz5goE4f2t8=;
 b=dkTX2wzcvq/Uc5iAvcUsgNXLBS8iRDEyZOFxsVaQhkfr8ovxFASP5Nf6S4LMRn35YoXcK1fMi5ZKFs1ls70lvFk0avBHCXzCKj7fzzLq59N+mXnF8/2GbdvnlV/WBF1FnQNfrofrA76DRQ21REdeWKB+YD/cgTVsI54129a0hUAjXMoFIPfeRZrYqSra8HpEQEA3zfIUm5nHBKtnOhavNINrP6yfPA9ZhzoRDqs8FWxnZ+5Oylbaxfk8WCjvh6j+NBG2D0UjYXk1wFJqhs7vwjw7J9McWcbSOOwuczscp2C2AHmas2kM2J5vHjIKfPYMIWeYbHhvFnkZL8Hg2ygVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SBtV1HWi6hQtegp1+ys6LHAWYQzByChBz5goE4f2t8=;
 b=FoW3n44jaLMZ1iEvnrzqh7p3+kj0aY5/8Z13a6duB0tR/6aN6ANAnxD1Ch9q16YM/z9XOu9FQYHGoQb4quO1HkduDhC9BiaKhH9w6TAU91puAgXQ7kELrviYI0KL7d7kZsx741p1MuDsZYhqtnD0ulhm0/sFXLFoobJEy1+K8OI=
Received: from MN2PR02MB6640.namprd02.prod.outlook.com (2603:10b6:208:1d0::19)
 by SJ0PR02MB7438.namprd02.prod.outlook.com (2603:10b6:a03:294::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 06:49:25 +0000
Received: from MN2PR02MB6640.namprd02.prod.outlook.com
 ([fe80::9c93:5721:58a1:27dd]) by MN2PR02MB6640.namprd02.prod.outlook.com
 ([fe80::9c93:5721:58a1:27dd%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 06:49:25 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Raviteja Narayanam <rna@xlnx.xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>
Subject: RE: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Thread-Topic: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Thread-Index: AQHX2tuZuKAQ26hOP0aW5QzRukRvFawbJZYAgBClDzCAZ11GsA==
Date:   Mon, 14 Feb 2022 06:49:25 +0000
Message-ID: <MN2PR02MB6640017950EFB0FD21D2AD91AA339@MN2PR02MB6640.namprd02.prod.outlook.com>
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <YaVPYiGmDsqY+1at@robh.at.kernel.org>
 <DM6PR02MB663589B3489C53A34DC25A31AA719@DM6PR02MB6635.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB663589B3489C53A34DC25A31AA719@DM6PR02MB6635.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4ff42f2-8221-45cb-bb77-08d9ef8623db
x-ms-traffictypediagnostic: SJ0PR02MB7438:EE_
x-microsoft-antispam-prvs: <SJ0PR02MB7438B0925741671A1F6409BBAA339@SJ0PR02MB7438.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yG03dZNXkD/KylZj9lUDgj9fRQY2lZ/4PXqw4rDTL3ir1g31Dd3Ud/vgpKt49MUb/Lz0ZUS2wx2Fsg2Pm9zy0FFwMl4aduMB7BOeHApEvetk7HxhYh2K83sDkmombnn5lYE90WRKS/SkSOy+IJKXXSPXva5gbSS+2BHXaUcb0zMUeFBVt4UzJEqUmx4pWl1V9j+mnj5mAQ0aPCnB0U+taVQkY/K1yhqTtcmShJ7tqcfy9ra6Ynd2AfbY3bzTQuvTLWoMWH2oXFp52r6YaiMz413WgDkshD9OaeSktatiOQbD3ZXoZCfYBsMD8GApkNwPGSUpxOFc1U6O/hFf/UzQ1stTYcitSRJtcxgJEWfvF+OwtAi2sev4Jqvk09BKWzijmexLAHtQGA4ZIwc7T5Rojf0hdisncgTneCR0/p4+IhvVZJEtxEpcMMDXo8mOnaWPP189dmQqy1hTUZ7cSHtM0DV+wmfbUlJ8BmoczwN8YW+6kYuYDfMlvwC9pfFBw1w5gzUQpww2VVTuRq5ZeVAQEImVSzZtkuleNnb5DGVSlSa3NrBI7H+5yVO0FqnxV06aOJWUvA7ryDVtkM+s6EocAOdUqmFzgogG3TSF0m1RAdUyo8RbWe1c9bg5/f42/mjtWNodF37yZovfCK9r2CPdaPQO0Z3FIpGBjpeB7i6ELbGe2eLehI3WBK7zr+FVuCElvmQF+J5ZtnFZmwkY6o/lsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR02MB6640.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(2906002)(38070700005)(86362001)(122000001)(5660300002)(8936002)(52536014)(55016003)(38100700002)(64756008)(9686003)(4326008)(66946007)(66446008)(66556008)(66476007)(76116006)(8676002)(186003)(6916009)(54906003)(71200400001)(316002)(83380400001)(53546011)(107886003)(508600001)(7696005)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yC+SR50nEQQ/gs5lwmv36GTAEHl7aeUtyh4dVfufB2SKEy2/ObbMMzXOqRCZ?=
 =?us-ascii?Q?cN4H+LYgQ517uivuWTT0PXGFdY6pEMPkWn1cxYPZGnzozg/p3Cesv/eL6snp?=
 =?us-ascii?Q?orZNGpMudTES0vpFIY9xp1CN9yh74m3/8a9TWlV5OueWbT7gzCVj17VOiB5V?=
 =?us-ascii?Q?xqBu2JBzLgFjwz3eS4MkDzjhOCgLYSCRi7bQl1yeQLikWHZ2Jjx6bdrbjh2G?=
 =?us-ascii?Q?ao1y2i7cV9B2C2mIt3Dxz33dXmQXORQGWrQUVUwxmvB5WN4uGPVvmXwN4eHT?=
 =?us-ascii?Q?GUS/ACc0OGeXzRCU+Sq8hAi44ecrsktWHySMFqCWhcwqSbQ5SjXzmTSNflTy?=
 =?us-ascii?Q?40YrUXTn1sStP/cVvBAZHWhcdEN0UtsEfnSl+HSNOacPOB/zm7q84rRG7gpv?=
 =?us-ascii?Q?0wKJUBR8Ia3kUGshdr25UOaFv9+L5XzDiyDVTj+qcKrJQ1SuwiwYoX8Vvn8c?=
 =?us-ascii?Q?FJTtIz8H0l+HqWaJBfGXi6U6voog5y4/PSBEhlRIHoRstG1H5HfGf4RhhKbP?=
 =?us-ascii?Q?9MPJZ/27qbP2WBktsBG1YiDoOATxrytVARvqyZe90TgC2cXWMIJi3X0ZRVzM?=
 =?us-ascii?Q?8KtDXCp+ZYt1iljPDIphi50/94YpYRJfEIUtSseqnuXmSyH0Lc+XsC1axoJN?=
 =?us-ascii?Q?4Cl1+v0SAHjkdH/JeFz8Fw8JtNsy6txhkokvOriuzvm4JaNRcj7TUhnELV6r?=
 =?us-ascii?Q?27mx6usT5Rxgwk2NkqsbuaiTtwbaM48k1sjyfMjMfMZN22rxO7WvGdF6C5tF?=
 =?us-ascii?Q?LKIqtdpLb72MehItFGA6cxtQOmZMKkXI8nfQ1r9oVClwVj13d6PSK7xphcJ3?=
 =?us-ascii?Q?zVWTXVv2KREG6qiwkQGPKxnmJR9NBPXdzbNiXDfgm9PZ0339aWdDD4Qy4DWw?=
 =?us-ascii?Q?RpJEVyGjqnsJWo95SM1Ibi0SjihDtwRWmEoTaiJitpJjxFSkRlXdIy/yLJxm?=
 =?us-ascii?Q?zipceHtpNhH0D5gaY3nKP/pVAu7Rwk+JWoH0EjFzSUFNmVWpLle747cei3+V?=
 =?us-ascii?Q?h72NiHJ8vnmevlplDpXX8rnNf6/vIwmP0U2LAX92MZNWL22Z5meskWNLwPyV?=
 =?us-ascii?Q?pGkxDSFyTzRg+ALn7Q5RQwtXNahk/nlYk18v6315tBjxSTZWmJn7Sxgl1Bgr?=
 =?us-ascii?Q?NFPS+hH7TwRuq3/ARX+yXF/StdxT4/qekPkiUvfvJUHzLaR/AN7FqzmElLR+?=
 =?us-ascii?Q?/j8oOycV774OaUTt7EAIXWWdcIqq/K3CB1HVNXX+iVO6veMnZJgwHXlx1xEI?=
 =?us-ascii?Q?4xSD86DUAIRmnKV5fhzvkqwELjZVDumUYc0UY4OShtXrRjoPVXfur+LtcxSo?=
 =?us-ascii?Q?oNnIDo8EP/51Rq/45TqPDUTiuk+KuPwE+3C4jrkhX1ccS2uwmxRo1BAB9i/w?=
 =?us-ascii?Q?xND3bZNvV5IVyyG53Yi05CpQwFURcrFsdP8WiT6ph24nckubpy4iVVFJZr4P?=
 =?us-ascii?Q?9AI1tS0NT2NHRfw03lXGq/b18YD1jcij4q7UtmQ9bBBdyWIuj7fQY7KnGxv3?=
 =?us-ascii?Q?GudRsZxh8EtW0UaL+q8rSBuKhtUiJkbU7g8EQdpAZfuJwezj01//VXnNPklf?=
 =?us-ascii?Q?lpR+8KDobUuZQn9H7FC61/wnPlqvq0hUPJa6+6rL5Tugq8rt5GlbeWwBl8Y7?=
 =?us-ascii?Q?jPNwn78I0+ufeGZkR7RhBcY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ff42f2-8221-45cb-bb77-08d9ef8623db
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 06:49:25.5113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEAhMjCVHJJqngwvwNNBTLM9dYJzucjIbfq7t5/noE0rwItF/GMCG7MzE1cKHjnA2zuLwut3vZpHvMW44PoFOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7438
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Shubhrajyoti Datta
> Sent: Friday, December 10, 2021 7:12 PM
> To: Rob Herring <robh@kernel.org>
> Cc: linux-serial@vger.kernel.org; devicetree@vger.kernel.org;
> gregkh@linuxfoundation.org; Raviteja Narayanam <rna@xlnx.xilinx.com>
> Subject: RE: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
>=20
>=20
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, November 30, 2021 3:39 AM
> > To: Shubhrajyoti Datta <shubhraj@xilinx.com>
> > Cc: linux-serial@vger.kernel.org; devicetree@vger.kernel.org;
> > gregkh@linuxfoundation.org; Raviteja Narayanam <rna@xlnx.xilinx.com>
> > Subject: Re: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart=
'
> >
> > On Tue, Nov 16, 2021 at 04:47:45PM +0530, Shubhrajyoti Datta wrote:
> > > Add support for Uart used in Xilinx Versal SOCs as a platform device.
> >
> > No. Why would we want to do that?
> Apologies did not understand that.
>=20
> >
> > >
> > > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > > Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> > > ---
> > >  Documentation/devicetree/bindings/serial/pl011.yaml | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml
> > > b/Documentation/devicetree/bindings/serial/pl011.yaml
> > > index 5ea00f8a283d..6c73923dd15e 100644
> > > --- a/Documentation/devicetree/bindings/serial/pl011.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/pl011.yaml
> > > @@ -24,9 +24,13 @@ select:
> > >
> > >  properties:
> > >    compatible:
> > > -    items:
> > > -      - const: arm,pl011
> > > -      - const: arm,primecell
> > > +    oneOf:
> > > +      - items:
> > > +          - const: arm,pl011
> > > +          - const: arm,primecell
> > > +      - items:
> > > +          - const: arm,pl011
> > > +          - const: arm,xlnx-uart # xilinx uart as platform device
> >
> > 'arm,primecell' means the block has ID registers. Are you saying this
> > implementation doesn't?
>=20
> The ID registers do not have any Xilinx specific identifiers.
> However there are differences  like 32-bit access.

Hope that the current approach is fine with you.

Thanks=20
> >
> > >
> > >    reg:
> > >      maxItems: 1
> > > --
> > > 2.25.1
> > >
> > >
