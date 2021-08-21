Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE71C4338F
	for <linux-serial@archiver.kernel.org>; Sat, 21 Aug 2021 12:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B96161222
	for <linux-serial@archiver.kernel.org>; Sat, 21 Aug 2021 12:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhHUMkC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Aug 2021 08:40:02 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:26898 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230042AbhHUMkC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Aug 2021 08:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629549560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XydOQQcCjoJuqcQTUUALkGwEOuIQ9Xu8BQVrHtd+pEs=;
        b=UwWLMCsbyEj49CQIW+Bc2rk4tJLZ0mZhwnREeOPIJMRHGU9xkg2ssT+RbwIlkKHIj+ytSO
        e9TtrhH3ylij68dOiG1bYZDReL6OzMTLGUsF4xm7h7XKVCOIJVdmLgsKjELOjxyiqXNjGv
        bNtLgq5l09/LCdlmS8iCzhX4uBWo8JQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-1Cfl5meYOTWZEaUsZ6aUWg-1; Sat, 21 Aug 2021 14:39:19 +0200
X-MC-Unique: 1Cfl5meYOTWZEaUsZ6aUWg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSbUcuRn8eP1AJF8/aD64IKK9zXGUU4VLfYlMILJQEY65NO/2lJ6CUuESlCVPOrSK/ISAChe7K+4AF2QXhDrOKi2A3BYuL0wD86C1w9FY3JaBagzULGbm1UpjQDSiv/2gU4mIc0hnnJsuCiCPgieQt1aGs/zMRpUMja48MHdGzRi+RZMXtQTrE7HGlRY6JrKmJmwVLLZg1qc8ZAaTVGPluoZUvLeBooZrqohUHpnrWWuU8xGrjychZ63/++4ahTjd4JZ8wku1HnP5TNLDJO3D26KT4uFlIXbxacsU5gor0tu3K5jLYmBdO6clMRxUO+Duxzv/mZJMN3Q/pafXLM3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5/0JDtMZnUe3MiIXlfusLo4XnTKw5E2RyewV2hookk=;
 b=QtBQAVPux7cgLwGIZbTeCtZ8//dD3UZjCQ2irM46QqxshTFKB7fTCcAE2iVAfdWYLfYOq7x8hgx36ula4yx7hpRPqJ+iKlKmC5dK+2eWis6g79YuuFaYsDd4DpBgOjfwEg3Sdd+pFuHpK4vXA7giaoPNutR+/4z6gfUIbHZJ8slAgnVAjGriGVPWFf6wyZPXHgFY7Wbne1YLLxuudlqEBZM7BdU5pEDbbTg3Bpek3z88gsTtNz4Wus9tigIkDS71s5Svy9ksbGzYQ0wbIzZubVXE/zGMHYroob63CMqcIgZmzPDZfoK8yaptgW+XCJAntWSwkEM7hJiL7BUgvdk5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB6031.eurprd04.prod.outlook.com (2603:10a6:803:102::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Sat, 21 Aug
 2021 12:39:16 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344%4]) with mapi id 15.20.4436.022; Sat, 21 Aug 2021
 12:39:16 +0000
Date:   Sat, 21 Aug 2021 20:39:04 +0800
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
Message-ID: <YSDz6EiNifqV2NAT@linux-8mug>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-5-clin@suse.com>
 <d09ed0fd-83e7-a6aa-0bd6-f679ffb64eaf@suse.de>
 <87o89sqmz6.wl-maz@kernel.org>
 <YR/HJQDGJ1C+ku6O@linux-8mug>
 <87lf4wqgn7.wl-maz@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87lf4wqgn7.wl-maz@kernel.org>
X-ClientProxiedBy: PR3P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::15) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (36.224.140.201) by PR3P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Sat, 21 Aug 2021 12:39:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 319d2460-d37d-4291-dd1d-08d964a0afc7
X-MS-TrafficTypeDiagnostic: VI1PR04MB6031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB60319B305BDCAE7A960F2A4FADC29@VI1PR04MB6031.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jDZ9UBtsfRmPGFzJ9Ed3HAzmYSuSRgdp/7j4auxR7b/UR+4U8cGODou4T/Il8jJzDPoIrm5GGCfKfTnCIzXAT4ryNPpkH3Io+2p+CcLSEoBfuj4Z/IhvKHkzvxHYHQYuSpUc1oT5zOBBwim891shEZICwJ4A1XPDhu2lGrjF0vjw0AWDkQ2Sy9ED2UpxaoTnZuljHo3uEP2aD+liUnqYZqfXAx58Tjc1l7WCExevJ9tgKniJJy73NN9NSXcvUgfRu9j9YOjhFYjQgNd5ShWzcT1sfcmwYLDDYT5JLxd9bIDDUHjKLrMtkgTdPIu9BPdBUTA1aOsjdQaaRAtnbYGYLfpd52fN2Z/MMzCaEIlF6RsPiwWbvg/EJ/8GzyVRePWuqKw1jB/Jl73EWxkjwHqmVdrR3pAAlR3/77ggHDZF9dKEs3AveDq7/dayOQoiU0PIPQPen0wvBX9zxdVV3br1Na6gB1vd0Ab8v6wCfowIn0xb8w7RUNXZfUOWKCpoJKByd5nQA1n1H+j0rEPrCG+dHhjTNZz7AmU2phtmRMxuXh0uCGQSwYro5BWBtqPLsR/crilVUFBzIlt+6O6c0iikSysyflBoJ70/PwNQAocfblXPKbsDpE5tBMcW+oOj+28SqzZ3AweRI2XWIyDJqp3vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(83380400001)(66574015)(8936002)(38100700002)(53546011)(6916009)(55016002)(6496006)(316002)(7416002)(26005)(8676002)(6666004)(2906002)(5660300002)(956004)(66946007)(66476007)(54906003)(33716001)(107886003)(66556008)(4326008)(508600001)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPOk76kVxUXoJ0DeFhMqYDfVw0KpGEE8q7kpbdBUUEhoOR7wYZCm3jKXw9Ee?=
 =?us-ascii?Q?6Ky2v0tYw94voOpQiR/yVn/IBuER+BGZzvgJWq/6Pp1tm+qZgt1uaJBatCqE?=
 =?us-ascii?Q?br+LqVcSirZe8ncpqlskhdTqgZVdBPtQM3YXjQGAfc3xlvwSv3UsncQBcIjL?=
 =?us-ascii?Q?BeKn4UUlglqCBZ2vg69Lb01WAihCDeGSUhCbSoW4DVvv+Jz1fBW/LHWX0jmp?=
 =?us-ascii?Q?IZ2uoF4kKvhJFxEPMdA7u86PuVx+JQusgtSyldeKkfQbZi2SpPQNj8WCjyOn?=
 =?us-ascii?Q?YyItGMKa1eO5zhzRaaqecJ0xQJSUq9PowxiWmqqdq4YnzJbP5HjktgRVrkPC?=
 =?us-ascii?Q?/2fTPDkQB8B5eEfVZ3bgDM05J+0AqkcA94fuMv+ZK3wanMLIy8CZbqTBbQC9?=
 =?us-ascii?Q?1qezzaWnndGLQMfkaF8/1h9mfDmVKmNrHBVtonxwAnzuwJCOsGKX4WxOHMAD?=
 =?us-ascii?Q?9a5XEVSW0/Y8CbelB6r/VN8xPMN6WpeKcFMUU+cJQIPVNx0elcxp1OLou8cJ?=
 =?us-ascii?Q?gG0Dx6koDbs9OV6hmkU2fThU/fQGNB3ULpfy1lSS7FTCNzudqfmFx4rYCGx+?=
 =?us-ascii?Q?Dsw+3n7x9Gv/GLrxiohGNYHS85zYaEhbNWn7uhtUEnqsD0MKuzNgHr8eXcEd?=
 =?us-ascii?Q?jDWdcL/C7oodh7INIRtgMznHhzKrO4VlBJbI+4sLrbITqvSmzaVCmYG8RGdU?=
 =?us-ascii?Q?ojek98QQoLqzOYZDPF0v7QrL2rXDwy/KNckzDewCR4UTDQ/ruKycpaDM5CHf?=
 =?us-ascii?Q?JZUKe2luoQ+iF9qFZoYVuZFyy9fG6w1c26/kbW3qKUiX30wDgIpLwsP+qAT/?=
 =?us-ascii?Q?TGlGnhP05pLKlK/EHPHn1ZzxlIO2A2YdgpuaOFtjbgrrUk1h3ua4VbRPpZcZ?=
 =?us-ascii?Q?lp+KdAhzS888v1mtfMije9XU7FKCpKCaXc3b1Xs/QkRuzv+UYP7pJXM5ZQ5a?=
 =?us-ascii?Q?RBn85a9TpLOMcFfXVZVh5B5pNPj9U1ypWfCQ+63WBGQNZ/RGHt83iAKtXzOM?=
 =?us-ascii?Q?gXCV7mZAIxxqY7694gVsCsNqlVeTbRBRsr9EkRx42YqagclG4HB8aveEbed9?=
 =?us-ascii?Q?F0ZXZeYYC0o0OQkq5mgiZKvsDS44N1CayXyyozMrmntZeDNc77jj0yIokFF9?=
 =?us-ascii?Q?KLHb5qM/SGaPDJyVEi1niQHU4UFOdkFHlZisCIIZ4lx8UN3MeHo6pCcAqtx5?=
 =?us-ascii?Q?fdkBb0ugH1K1HyeIF7n7z/AD7qNVFMsNxwwBkwi1oMkUsne930yUvv4naElD?=
 =?us-ascii?Q?bDy8a6cAeZqsnKhnNzoIxJgsRom/Cej+g/J/LCzW6WUdn4s9JEoCfxht/GvZ?=
 =?us-ascii?Q?CtiauVGDJq3trO4sLpnxvtx9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319d2460-d37d-4291-dd1d-08d964a0afc7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2021 12:39:16.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHWiU6k6WfcV51tGHG85g4mfCyAr513eV/Gy7DoOjJB5QHRScR1PNpcFPwzaKU8f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6031
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Marc,

On Fri, Aug 20, 2021 at 04:29:00PM +0100, Marc Zyngier wrote:
> On Fri, 20 Aug 2021 16:15:49 +0100,
> Chester Lin <clin@suse.com> wrote:
> >=20
> > On Fri, Aug 20, 2021 at 02:12:13PM +0100, Marc Zyngier wrote:
> > > On Thu, 12 Aug 2021 18:26:28 +0100,
> > > Andreas F=E4rber <afaerber@suse.de> wrote:
> > > >=20
> > > > Hi Chester et al.,
> > > >=20
> > > > On 05.08.21 08:54, Chester Lin wrote:
> > > > > Add an initial dtsi file for generic SoC features of NXP S32G2.
> > > > >=20
> > > > > Signed-off-by: Chester Lin <clin@suse.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/freescale/s32g2.dtsi | 98 ++++++++++++++++++=
++++++
> > > > >  1 file changed, 98 insertions(+)
> > > > >  create mode 100644 arch/arm64/boot/dts/freescale/s32g2.dtsi
> > > > >=20
> > > > > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm6=
4/boot/dts/freescale/s32g2.dtsi
> > > > > new file mode 100644
> > > > > index 000000000000..3321819c1a2d
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > >=20
> > > [...]
> > >=20
> > > > > +		gic: interrupt-controller@50800000 {
> > > > > +			compatible =3D "arm,gic-v3";
> > > > > +			#interrupt-cells =3D <3>;
> > > > > +			interrupt-controller;
> > > > > +			reg =3D <0 0x50800000 0 0x10000>,
> > > > > +			      <0 0x50880000 0 0x200000>,
> > >=20
> > > That's enough redistributor space for 16 CPUs. However, you only
> > > describe 4. Either the number of CPUs is wrong, the size is wrong, or
> > > the GIC has been configured for more cores than the SoC has.
> >=20
> > Confirmed the SoC can only find 4 redistributors:
> >=20
> > localhost:~ # dmesg | grep CPU
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> > [    0.000000] Detected VIPT I-cache on CPU0
> > [    0.000000] CPU features: detected: GIC system register CPU interfac=
e
> > [    0.000000] CPU features: detected: ARM erratum 845719
> > [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
4, Nodes=3D1
> > [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D480 to nr_c=
pu_ids=3D4.
> > [    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000050=
880000
> > [    0.063865] smp: Bringing up secondary CPUs ...
> > [    0.068852] Detected VIPT I-cache on CPU1
> > [    0.068894] GICv3: CPU1: found redistributor 1 region 0:0x0000000050=
8a0000
> > [    0.068963] CPU1: Booted secondary processor 0x0000000001 [0x410fd03=
4]
> > [    0.069809] Detected VIPT I-cache on CPU2
> > [    0.069851] GICv3: CPU2: found redistributor 100 region 0:0x00000000=
508c0000
> > [    0.069903] CPU2: Booted secondary processor 0x0000000100 [0x410fd03=
4]
> > [    0.070698] Detected VIPT I-cache on CPU3
> > [    0.070722] GICv3: CPU3: found redistributor 101 region 0:0x00000000=
508e0000
> > [    0.070749] CPU3: Booted secondary processor 0x0000000101 [0x410fd03=
4]
> > [    0.070847] smp: Brought up 1 node, 4 CPUs
> > <..snip..>
>=20
> That's not the correct way to find out. Each CPU tries to find its
> matching RD in the region. This doesn't mean there aren't more RDs
> present in the GIC.
>=20
> You need to iterate over all the RDs in the region until you find one
> that has GICR_TYPER.Last =3D=3D 1. This will give you the actual count.
> Alternatively, you can check whether the RD at 508e0000 has that bit
> set. If it doesn't, then you know there are more RDs than CPUs.
>=20
> 	M.
>=20

Thanks for your guidance. Not sure if any debug log can be enabled for this
check so I temporarily add an ugly message as below:


diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4debe64e1..5998306fff39 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -866,10 +866,11 @@ static int __gic_populate_rdist(struct redist_region =
*region, void __iomem *ptr)
 		gic_data_rdist_rd_base() =3D ptr;
 		gic_data_rdist()->phys_base =3D region->phys_base + offset;
=20
-		pr_info("CPU%d: found redistributor %lx region %d:%pa\n",
+		pr_info("CPU%d: found redistributor %lx region %d:%pa last: %d\n",
 			smp_processor_id(), mpidr,
 			(int)(region - gic_data.redist_regions),
-			&gic_data_rdist()->phys_base);
+			&gic_data_rdist()->phys_base,
+			(typer & GICR_TYPER_LAST) ? 1 : 0);
 		return 0;
 	}


The following log shows that the "Last" bit (GICR_TYPER[4]) of RD at
508e0000 has been set.

localhost:~ # dmesg | grep GIC
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] GICv3: 544 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000508800=
00 last: 0
[    0.078745] GICv3: CPU1: found redistributor 1 region 0:0x00000000508a00=
00 last: 0
[    0.089598] GICv3: CPU2: found redistributor 100 region 0:0x00000000508c=
0000 last: 0
[    0.100395] GICv3: CPU3: found redistributor 101 region 0:0x00000000508e=
0000 last: 1

