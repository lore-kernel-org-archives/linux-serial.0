Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C864C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 20 Aug 2021 15:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E113F60ED6
	for <linux-serial@archiver.kernel.org>; Fri, 20 Aug 2021 15:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbhHTPQv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:16:51 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:35057 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240952AbhHTPQv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Aug 2021 11:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629472571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klp+6b8zvhTMY6DL3XHrPsuOrmt80/fuCsVxEmvC4dc=;
        b=BqnOJuZDbXmuU22xzgMJw1VWxJDm3Y7h9396/aNJDMiI90DAq/WNg3WzTHC4ZtUqy9oUAO
        yD5edf7JCq5bEj0cJf2XHJXviFt8u2W1RU2AmgDcyG0P/Mr/AvjZwIeVKxH8eU783y0YVp
        9vEDzFeDMxShZjSsTSqbXGUIaOQufBE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-lVrR_MbcOru9p3goYepU_g-1; Fri, 20 Aug 2021 17:16:10 +0200
X-MC-Unique: lVrR_MbcOru9p3goYepU_g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVWVaN/z35l80JMfj8EABijQnRZVMEQpgTDUrd8YPEQy32UljZdO5ATbin5aSTLvfntuOobujYObWIqVh7AvY5khXtlWAqI+hACqBx8T+BppjuTxBI71UmDkJo8KaTdMzJmn21rFmzAC3afbYkEuuJIMjPHwZgn1UwtW3XVr0y5+yB9cy6jUd1AYN/vlTpWQPeJ95CwGt2K1BnzkAqUPJb+vOmLFLNKC6MU+zoo5Bm48mukhjeKHOeN2OdJU8Zsw2vF4SsCvYrsLni9JZR1SzJF46g8d8Kfhn08WMEBVfwwwXQBKkU4SlNYM7ZTXeVV3LaVrwdk9uyVKld33gnQDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7RZ5YLSc7IwfRJf+8vFufugwpWAPmLIx++tFNe3+Jc=;
 b=HdTSGGjtg2PtQRzkmUD1sbX6K6hMXOq9ll1kfu4UDkugU/eCaW3YfOSzfsTcQKDCWHYYtlghtAH71+n3/EHYjLlm2vwfeflnBBnP5SRCEQe7iUDFYLdtWWkNTRE/Jf73Y4CcCyXYxekIe6jK642X3biPIZ+1qi2TQ9O1xk48HEzDU/GRLRJdHTPxc23ZrXtcmXm/llz4T6siXHrPmtpun4ebrYkFMjteBxL7b8S6wx0KfT/ZPeup4G9uekgXKYwSNku+bmX2beLSRbobpKsSjlQVcN53/YliAbxMd2bUcae2gXjPFxX09yPcCwzPSDazRqbukTGYiOQbXQhrKIFq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4094.eurprd04.prod.outlook.com (2603:10a6:803:43::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 20 Aug
 2021 15:16:09 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344%4]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:16:09 +0000
Date:   Fri, 20 Aug 2021 23:15:49 +0800
From:   Chester Lin <clin@suse.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, s32@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 4/8] arm64: dts: add NXP S32G2 support
Message-ID: <YR/HJQDGJ1C+ku6O@linux-8mug>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-5-clin@suse.com>
 <d09ed0fd-83e7-a6aa-0bd6-f679ffb64eaf@suse.de>
 <87o89sqmz6.wl-maz@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87o89sqmz6.wl-maz@kernel.org>
X-ClientProxiedBy: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.160.215.224) by HK2PR03CA0066.apcprd03.prod.outlook.com (2603:1096:202:17::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Fri, 20 Aug 2021 15:15:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0ae009a-d712-4d4a-3129-08d963ed6ffe
X-MS-TrafficTypeDiagnostic: VI1PR04MB4094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4094F4094F657B7E3F0AFCA3ADC19@VI1PR04MB4094.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUJLr0uF7ZYSoMEwxQyaN2yqSpdDLMp2DRA2ztTGIVM7JWMl2vCdRvZhJXxCqh3at76OxtM64Mn/WOoYFCB+7gxqWx0BZ4w3oVyODF4lKN3nzSoegqlu8Fwt+e4BwqahcGxf4kFRNBmADhk4C1ET8kNeYDuG/IeuPTzu2LNZyuYRPeo6RF66oiQzO2Wrrpg/wQRXdQsidNo12KaISSWnWK6zy+78QB6nUhjYUVoSoe3lj4Ofx6tQaNZ7dipxHyLmJtolS41dotW2lt9/qmtqRvaXPYqgXBphTpojQA1ypAPLF41B8O6cGFM54XwA/RLMglkqYYkmUu87CHkfGWzF3ksaZ+8241mS71WKpa00zJcdu1C0mfs8BwliSbNSgSAs9xMyOMgR+wKyIG0PuA1Eo6i4X4eMB5vNU2vONPOMrWIR58xBxxcVSvnZCRf2lgFgeM5EaBCjTbsHc+9fBft7i3R1kfw8apv9d3pMQiTzo5/vmmsSGsIfIK+sqQKy4TsjaYfK3gneHzrYw0IlosVQaKzewBg4QLA89Czs6d0fReihkZPeIP8EEujUwUJYCCAoO5LVAgoV9ZpF+o1+7mq86aaL3zB6MHvCOcr9Yw51ejVpK9DceovO0xajISOeG2qzrRjajV5CT1Nfco8gXMbHNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(38100700002)(26005)(86362001)(54906003)(66574015)(956004)(107886003)(6666004)(4326008)(55016002)(2906002)(9686003)(6496006)(5660300002)(55236004)(316002)(478600001)(33716001)(83380400001)(66476007)(66556008)(66946007)(8936002)(186003)(8676002)(6916009)(53546011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a1Ojzq6wiA1MGDJFEFl0Np4yoMqbmDVxadiEa52K6us4VnorNABc0jE/pWUf?=
 =?us-ascii?Q?Jxyg9RmVxwhMn7VOAUml7gPXII/F08lvSzxL1eD5AVURgsbs7ZKZlOdUmoRH?=
 =?us-ascii?Q?5nS0IZDTIOxkz+gUckljwLZvg2ajWSb2nniHNyOsqsZ/IRHvmKzpE7L88fMd?=
 =?us-ascii?Q?Qkj9qHXuspC25fQO7od/ylVFHVWEAutgQqdRBomxfhhVQPz+GtX79ml+YbSP?=
 =?us-ascii?Q?PFP93kZj/UQUD0vZ/I+7rGocBrV3MQ/2a8jJ3Ucc5GPvqkicj0baYHNRazCO?=
 =?us-ascii?Q?nKoz2W1thp1/whYzVD1WzL4UxqA13t0iUXcie2E1hRB3l4mfpoNkUbrCkPk6?=
 =?us-ascii?Q?rPikMKbcKf/tbsSRE0+OgJKwdA7R0NoeCJ6PMmqBJj5J4fxJYJ/AyjHdQ7wE?=
 =?us-ascii?Q?OMeGb6ffIv3UFgAjK3ZJGNpDvey3XnzsuGPDmCAxcOMs+vZyqGBwRpr9kj/n?=
 =?us-ascii?Q?v77BF7CQbo2BSBc3m09kHhLYL+UijkccBzb3Ti6WDIPYrt6y5b4Ml3gCgXQ9?=
 =?us-ascii?Q?rcclDVaRzimwt5c0uJ+W3tj0sEZwyZdVYkIAZ4AJvSM4NxStkSHB5gNr5ANc?=
 =?us-ascii?Q?Gv1DyvvcZ7V0jWhhJUwjhVm+3ua4rl70rRggEfwxs/F9poFd8+aX/XYe4m5O?=
 =?us-ascii?Q?83P0V8WTEabr/51CdDyztY98PHNHwbiGlpdbFzJcz42E4Au89w8/h70QurdX?=
 =?us-ascii?Q?teqcPSBsjwPuT0ARfdSmQC8OVINquW74TbdJLy+rVVf9tZ8vgUxWvGqaTmrx?=
 =?us-ascii?Q?S/XFI0NwUbpFpzAaktxDI1JyQdMUQDLGR8nWYxSxp+FojFfVIIyYP2u86/8a?=
 =?us-ascii?Q?H0043s1S+rsRXw3mVRdOkUQwBSo5ybEI5C6jyV3bZiRLsAx0u/+ojAjjhPJP?=
 =?us-ascii?Q?AVmVns7aFRmpPAEEU3ywAmZvAS6HtuCwgb0J3h6lxP6xNPoh3VkUQktPanry?=
 =?us-ascii?Q?hLZwpiLv4adSNuiHAw2YFKaGJZ7a2Erj+wuU+nfCl46AzGHToPle4s+1mCaj?=
 =?us-ascii?Q?GjDaOT2raC2XdsqL3r3nAwAQBrwhuBmPkuGKPa1uX89rtQZrWIxE/HiihA+z?=
 =?us-ascii?Q?zH0hetsZqfHd39fMZzWiHTl/wOCS7r+/c/RrdOQdYL75Xw3xPPYDKPMFISps?=
 =?us-ascii?Q?3Hv6os5bvPO98LMdbduU3VaYxALq2/Ly4he9gz0gtDz4sPEdrq4pKVw2FXd8?=
 =?us-ascii?Q?qFUp3h5uvz4XB9arjNSE0u62wv3E+9tV77U22a2coTq3fBu1nKHRsJ3NY9ZR?=
 =?us-ascii?Q?bquzynoQ8aMZyzzcNjdSGZKzKvRQWWeFBnmNWLsXwaRMkI+N10dgXBi12qKM?=
 =?us-ascii?Q?u1MqRPKkfbtaHx/ZX5XFllvo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ae009a-d712-4d4a-3129-08d963ed6ffe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:16:09.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rR6igNikNTwAb7MUnoO9zYCjN/aImMvRUup/zP3Ynw+Lz5OalLBfxZRWjKjiFynW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4094
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 20, 2021 at 02:12:13PM +0100, Marc Zyngier wrote:
> On Thu, 12 Aug 2021 18:26:28 +0100,
> Andreas F=E4rber <afaerber@suse.de> wrote:
> >=20
> > Hi Chester et al.,
> >=20
> > On 05.08.21 08:54, Chester Lin wrote:
> > > Add an initial dtsi file for generic SoC features of NXP S32G2.
> > >=20
> > > Signed-off-by: Chester Lin <clin@suse.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/s32g2.dtsi | 98 ++++++++++++++++++++++=
++
> > >  1 file changed, 98 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/s32g2.dtsi
> > >=20
> > > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/bo=
ot/dts/freescale/s32g2.dtsi
> > > new file mode 100644
> > > index 000000000000..3321819c1a2d
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>=20
> [...]
>=20
> > > +		gic: interrupt-controller@50800000 {
> > > +			compatible =3D "arm,gic-v3";
> > > +			#interrupt-cells =3D <3>;
> > > +			interrupt-controller;
> > > +			reg =3D <0 0x50800000 0 0x10000>,
> > > +			      <0 0x50880000 0 0x200000>,
>=20
> That's enough redistributor space for 16 CPUs. However, you only
> describe 4. Either the number of CPUs is wrong, the size is wrong, or
> the GIC has been configured for more cores than the SoC has.

Confirmed the SoC can only find 4 redistributors:

localhost:~ # dmesg | grep CPU
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D480 to nr_cpu_i=
ds=3D4.
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000508800=
00
[    0.063865] smp: Bringing up secondary CPUs ...
[    0.068852] Detected VIPT I-cache on CPU1
[    0.068894] GICv3: CPU1: found redistributor 1 region 0:0x00000000508a00=
00
[    0.068963] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.069809] Detected VIPT I-cache on CPU2
[    0.069851] GICv3: CPU2: found redistributor 100 region 0:0x00000000508c=
0000
[    0.069903] CPU2: Booted secondary processor 0x0000000100 [0x410fd034]
[    0.070698] Detected VIPT I-cache on CPU3
[    0.070722] GICv3: CPU3: found redistributor 101 region 0:0x00000000508e=
0000
[    0.070749] CPU3: Booted secondary processor 0x0000000101 [0x410fd034]
[    0.070847] smp: Brought up 1 node, 4 CPUs
<..snip..>

I will correct the size to 0x80000, thanks!

>=20
> > > +			      <0 0x50400000 0 0x2000>,
> > > +			      <0 0x50410000 0 0x2000>,
> > > +			      <0 0x50420000 0 0x2000>;
> >=20
> > Please order reg after compatible by convention, and sort
> > interrupt-controller or at least #interrupt-cells (applying to
> > consumers) last, after the below one applying to this device itself.
> >=20
> > > +			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
> > > +						 IRQ_TYPE_LEVEL_HIGH)>;
> > > +		};
> >=20
> > CC'ing Marc for additional GIC scrutiny, often the sizes are wrong.
>=20
> There is more than just sizes. The interrupt specifier for the
> maintenance interrupt is also wrong.
>=20
> 	M.

I will remove the wrong interrupt specifier. Thanks!

Chester.

>=20
> --=20
> Without deviation from the norm, progress is not possible.
>=20

