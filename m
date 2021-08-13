Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910AEC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 03:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A383610A7
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 03:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbhHMD25 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 23:28:57 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:46833 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236205AbhHMD24 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 23:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628825309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NfmjbF5cgthguMKf6Gqa0o+pqCK+SqwC2RBeLJkmAiU=;
        b=dNcMvTzEhFNRVRQ2fUH5K7987AQtWDbZnzJlmdFaDhxETxG6HsaZaKQN6PC1DrFx12mSWx
        fp6tCBLs4tpkmpGpSR1dgWJ1w9DgG9kdD+AlfSZeobDuGfG0oBuPGGKyzFk7JvtDB8ulmT
        E0GHDGpM9Ygpkieewharo0JPgIJvWTg=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-U5KWajHVOnetU8s61KsJKw-1; Fri, 13 Aug 2021 05:28:27 +0200
X-MC-Unique: U5KWajHVOnetU8s61KsJKw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYoFtw+HnXWyi1Uxq6hnJOgMUAdNE39jJQw2YL7vGOVsOc3x84vCS56s5Uk1hY9A/duLiHoqQ1AyCJMo9QgnyXkiT8xluF2SLQ7LM/XPy7Z6xpEMQ8TA6XboOEhfnCfcFyO/2uO0yP+sSgYAkoJBU5Q9pF6Nu/SPZB9BxoXdn2y+VqC2x4kl8OQfY9/770kd5oA2tDbvGkzV22AGJvIbMTdPByKiXOgeSN8xl0Ej3dubwJAFtiZmWatSK6K58VHRyCPzV/oqKEv+RadCE8oYKjOqWoEL0LqFeGAcmqo0EqsMwhyLes/dBQVc3nrsLp7WtcyVJ/NwuMzYZwRw3W/2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIwuPSMc8LlpTDklqwMo+7/49QSZzPo2xLr42LOAaW4=;
 b=LZ6AV7ydaUcOAwO4FMzzFqJrGwBy8l4vss900ro20IHQ+opMTzc8LXvLWmy2te1URhSJ+uh+HfQLZSIQ1pwL721Z7GEL1tT2X9OanXQH+3fg7//bpYj0RAZZwwvuNGPduNxr9ufjZvK6Qah6sstn+FLmQa2NL5EmuP6Na2yhLt/8wE6029ekcSJkd9rNhnntq5yHDpveJU1D0nKJIYEzvnuKS0mfjPS0KmDeOuN521Sk4DCcAd67EwtZF9/C3cWaRpebrp/LADzvViPovVH91/COWssw3IeezTSQfT0KIJvib4LUIE45OYXpAtVTR3ThqUuHADoB414C6HDqqrmvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 03:28:24 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344%4]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 03:28:24 +0000
Date:   Fri, 13 Aug 2021 11:28:04 +0800
From:   Chester Lin <clin@suse.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
CC:     Rob Herring <robh+dt@kernel.org>, s32@nxp.com,
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
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Marc Zyngier <maz@misterjones.org>
Subject: Re: [PATCH 4/8] arm64: dts: add NXP S32G2 support
Message-ID: <YRXmxD5u7drotWxP@linux-8mug>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-5-clin@suse.com>
 <d09ed0fd-83e7-a6aa-0bd6-f679ffb64eaf@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d09ed0fd-83e7-a6aa-0bd6-f679ffb64eaf@suse.de>
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.51.198) by HK2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:202:2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Fri, 13 Aug 2021 03:28:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79275458-5c75-4bc9-cd9c-08d95e0a67e1
X-MS-TrafficTypeDiagnostic: VE1PR04MB7261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB72612DCB9183B90E9391529FADFA9@VE1PR04MB7261.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wwKME8P2Rt6i7R/w2N6MhJb5s2WzDSbtF3Rudz1/uUKdl5hFpq1h742nRnm5dZw73QhXmYjEUvvyzgNBv0mpfzqtlGbMkA5aqPKXiVw74y6KqmNOpF7qo7L3EKYqtsv9zIh9ln+5Zj7v+3GRNyE/jfHPkhQlUZJdgaiEDRleJmtDZVxAgGo6DyRsLNPwThBXKrYkwiqgakG5VDXl4hojDzoZPwCLURLqy9zbrFlDqAP8+akzgjQh6Qjl5eRQSZa3CCLn2pitCYPGUBpPxaSSISv+ZK5jRSbkQpyK77Espefaou0BuisIqy6s6HbY0KUIbfAh5mT5icVHYKYNZFrbvtLUQ8wtCyIraA+mMPgXgCkL/kwrMAx4o5ZUHNhJStkgT1UABdqkDBYfYKdqJYtcRzxBkWjp0JOdUvuLH2n6D8If3bi4Cx8De0UupGeJCT0ZohkDWxsyNQyzuPMCqamP5n1Irfz6sfA/uda5KIsicjgZCx6LEXXWZREpEDN1C7Un+J7s7qeSIv77HFn79kvS/dxlBTMx+bi8RG2Ry4J1R7VOAtJEdo/QnmuAMZ1xv1eTaTWUjJEcWl2j+qOfcFBaoFxkHMZe6ccfiPe6PshJ/lW+1D2cwJjJIYUK1FZBcNJ0IXkjgVT764pHiCIuvXQzfCgzCC7k+VUWLMzAxdSSqxX3bhVGh/4gIlvTD3iHd4Vd2/UyJSvv7dwayGgz1nEwY9f8w1BXdHnyHVWaIju8xpSwjYa/gfKcQZha3x0loA/Ve6VtyP2CjIPQoxr6v7xGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39850400004)(346002)(366004)(396003)(136003)(186003)(6916009)(8936002)(316002)(966005)(54906003)(956004)(86362001)(8676002)(478600001)(38100700002)(9686003)(4326008)(53546011)(55016002)(66476007)(66556008)(6496006)(66946007)(83380400001)(26005)(66574015)(7416002)(33716001)(55236004)(5660300002)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iaGPbXCxW5NAtYIGNqjVzXH/EFZCARr7jXStY2FssaBfYFX8rTP/WJFihT9i?=
 =?us-ascii?Q?P8YaOGYzK54OmSlDjtXERpCm8KfxVSCl0xVamKMTh8/pw4rC29x2N7UQu1mB?=
 =?us-ascii?Q?tYosVt9M7hH8J/L6K8qP4ExpNNorqT/7hBnqQc7cPLuiVGCMZOVoXAtzS8Za?=
 =?us-ascii?Q?QOL4RjxIDyPmEHcVqzRx7SS5GNbYEiCjlBpLhOGVNw7RYx0DnNNnWQSrCeDz?=
 =?us-ascii?Q?FGaUynbd//IiKfN+5vYeIvHJJqWrVwg2EgL5TVb2qMGtbU3UyVrrhygiTBRY?=
 =?us-ascii?Q?LB3DrxBFZsntn5nSotsuSs0FLgg3Z66YFLRI3h3Cwf6moe6azoAur99ccAAR?=
 =?us-ascii?Q?EeQgXoBKz3nEoBjrTdcfwnUOa38XlntM/ve6hRomE2XjEeHfWuHiiGkF2vEm?=
 =?us-ascii?Q?9jr73mc9CrJzNPBq00SK9nWinTUl6PkPLEE6mHE2zCDZ6vbZjMgNDBh00Pzq?=
 =?us-ascii?Q?N+/x3ULg1sRBnP+DzJbg7zF1o4v81hPWkVfqTTb0cbYxzhwQIF4SFkCgpzzD?=
 =?us-ascii?Q?Ckl1fXCawi4j8KmbIhlvUdL34fGX4y5B9teyCl/AFPjjfZ8gS1YZr1y0Xkyo?=
 =?us-ascii?Q?6dxgfnlNRtPnBTxT28GE8YdY7gqE4EUy290P8LOy+T+kSCfhuXVXVgqr55w6?=
 =?us-ascii?Q?CGNie/EUtsfVlv8BuNpRnhhcFWa3IhECsRM+F3ttrSVl7FYS+7GG4nDnXc7Q?=
 =?us-ascii?Q?w1kiTcEHZeGvu66GqFG0vMwlW9IlQK7Zu8cDyClwBnPhqdICkZVs/iLhUYCN?=
 =?us-ascii?Q?1BpU1glRLBgoVXJrtIR1H84A+wN7yJ68A8YU5M83Dlil8XUscWyBetgMMXz+?=
 =?us-ascii?Q?s106SZAtAoqGVjWJ0qr2W0+2OYhbNH1vZnJxlRhd8C8D+GX9lUQXUAv57M++?=
 =?us-ascii?Q?zsmfVhaUOdXngrEav5vJA4WQhE3Qo5bSKZuAfEKeHeGPRRSOpuZyKsLSXbuv?=
 =?us-ascii?Q?aWvu8soHXpi/JZCv70mkhHLEdSRw+y4JDMXu55YNbA1TVm7+gze1LC9Dycjd?=
 =?us-ascii?Q?A69Tr5yChdzrsvmJAJg9CS1XwP1OZouYqKaUf81+0Wg/xAw1bpMsNXnd0YfW?=
 =?us-ascii?Q?uk9j7u9NBkgVHEUbLZdMtg8Oadc419fe7sQQVV04t7YJCpfJQnaL5x+WD4hE?=
 =?us-ascii?Q?ZwD6LWVqm3OgdcJQvRxxtxb03YbdM8HOb5pC37pGtrnIWYot688XqNnZn8MW?=
 =?us-ascii?Q?1SG08657GYJvL7gxaIcApMBWUb6WTLFZsSIhIq8ymw/HYETf/Q8ocFoq3e90?=
 =?us-ascii?Q?8m2Ry/kTZ5JF9ZIsQ014yRPAKm4G0O79Ily8YzMUCrgX+ot1l44eWTx8cnUK?=
 =?us-ascii?Q?SbOj7CqB9I3hdd/2uC2Lq2nq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79275458-5c75-4bc9-cd9c-08d95e0a67e1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 03:28:23.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RsEqHUxnBmRdLV+tgKhPjasvQ3kpzD2W/3LUXyB+aUTbGpwbC2lJ//lo/dFmKxc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 12, 2021 at 07:26:28PM +0200, Andreas F=E4rber wrote:
> Hi Chester et al.,
>=20
> On 05.08.21 08:54, Chester Lin wrote:
> > Add an initial dtsi file for generic SoC features of NXP S32G2.
> >=20
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  arch/arm64/boot/dts/freescale/s32g2.dtsi | 98 ++++++++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/s32g2.dtsi
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot=
/dts/freescale/s32g2.dtsi
> > new file mode 100644
> > index 000000000000..3321819c1a2d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>=20
> Note: This DT is for running on the Cortex-A53 cores, but S32G2 also has
> Cortex-M7 cores. For Vybrid SoCs, DTs later got contributed to also run
> on its Cortex-M4 core:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
arch/arm/boot/dts/vf610.dtsi
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
arch/arm/boot/dts/vf500.dtsi
> vs.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
arch/arm/boot/dts/vf610m4.dtsi
>=20
> Should we plan for this in our file naming here and in following patches
> (e.g., s32g2-a53* vs. s32g2-m7*)? To me, a later concatenation of
> s32g274am7* would look awkward, and s32g274a-m7* would sort between -evb
> and -rdb2.
>=20
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
>=20
>  * NXP S32G2 SoC family
>  *
> ?

Will add it.

>=20
> @NXP: Are any models other than 274A in the queue that we should
> distinguish between s32g2.dtsi and s32g274a.dtsi here already?
>=20
> > + * Copyright (c) 2021 SUSE LLC
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +	compatible =3D "fsl,s32g2";
> > +	interrupt-parent =3D <&gic>;
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	cpus {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		cpu0: cpu@0 {
> > +			device_type =3D "cpu";
> > +			compatible =3D "arm,cortex-a53";
> > +			reg =3D <0x0>;
> > +			enable-method =3D "psci";
> > +			next-level-cache =3D <&cluster0_l2>;
> > +		};
> > +
> > +		cpu1: cpu@1 {
> > +			device_type =3D "cpu";
> > +			compatible =3D "arm,cortex-a53";
> > +			reg =3D <0x1>;
> > +			enable-method =3D "psci";
> > +			next-level-cache =3D <&cluster0_l2>;
> > +		};
> > +
> > +		cpu2: cpu@100 {
> > +			device_type =3D "cpu";
> > +			compatible =3D "arm,cortex-a53";
> > +			reg =3D <0x100>;
> > +			enable-method =3D "psci";
> > +			next-level-cache =3D <&cluster1_l2>;
> > +		};
> > +
> > +		cpu3: cpu@101 {
> > +			device_type =3D "cpu";
> > +			compatible =3D "arm,cortex-a53";
> > +			reg =3D <0x101>;
> > +			enable-method =3D "psci";
> > +			next-level-cache =3D <&cluster1_l2>;
> > +		};
> > +
> > +		cluster0_l2: l2-cache0 {
> > +			compatible =3D "cache";
> > +		};
> > +
> > +		cluster1_l2: l2-cache1 {
> > +			compatible =3D "cache";
> > +		};
> > +	};
> > +
> > +	pmu {
> > +		compatible =3D "arm,cortex-a53-pmu";
> > +		interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>=20
> interrupt-affinity =3D <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;

Actually I traced the pmu_parse_irqs() and found that this SoC never falls =
into
the pmu_has_irq_affinity() check because it's a percpu IRQ so the flow ends=
 at
pmu_parse_percpu_irq(). But it looks good to me to have an interrupt-affini=
ty
to indicate that each core has an associated PPI for PMU events as the bind=
ing
file has suggested.

>=20
> > +	};
> > +
> > +	timer {
> > +		compatible =3D "arm,armv8-timer";
> > +		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +
> > +	psci {
> > +		compatible =3D "arm,psci-1.0";
> > +		method =3D "smc";
> > +	};
>=20
> Should we move this into a /firmware node, to group with future OP-TEE?
>=20

So far I can only see a few examples [e.g. ti/k3-*] which add the psci node
into /firmware but logically we should do it.

> > +
> > +	soc {
> > +		compatible =3D "simple-bus";
> > +		interrupt-parent =3D <&gic>;
>=20
> Duplicate, already set on root node.

Will remove it.

>=20
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
>=20
> Why? Does it have any peripherals that go beyond 32-bit space?
> For 64-bit Realtek platforms Rob had asked me to use 1, if possible.
> I do understand that for /memory nodes we do have high-memory addresses,
> so 2 for the root node looks correct.

Actually it's a limitation due to [PATCH 7/8] "arm64: dts: s32g2: add memor=
y
nodes for evb and rdb2", which adds memory nodes to indicate maximum system
RAM size combined by two separated memory banks, and the second bank starts
from the offset 0x880000000 so that's why we need 64-bit address space here=
.
Please feel free to let me know if any suggestion.

>=20
> > +
>=20
> Please drop this white line.
>=20

Will do.

> > +		ranges;
>=20
> According to Rob, the /soc ranges should exclude any RAM ranges for
> safety reasons. Compare:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
arch/arm64/boot/dts/realtek/rtd129x.dtsi
>=20
> If you're lacking the maximum RAM areas to carve out, NXP is in CC to
> help out :) and the EVB and RDB2 boards should give you starting numbers
> that could be enlarged later if needed.

I added memory nodes in [PATCH 7/8] "arm64: dts: s32g2: add memory nodes fo=
r
evb and rdb2" to describe maximum RAM areas, which are based on the informa=
tion
we found in NXP BSP and boards.

@NXP: Please feel free to correct me if anything wrong, thanks.

>=20
> > +
> > +		gic: interrupt-controller@50800000 {
> > +			compatible =3D "arm,gic-v3";
> > +			#interrupt-cells =3D <3>;
> > +			interrupt-controller;
> > +			reg =3D <0 0x50800000 0 0x10000>,
> > +			      <0 0x50880000 0 0x200000>,
> > +			      <0 0x50400000 0 0x2000>,
> > +			      <0 0x50410000 0 0x2000>,
> > +			      <0 0x50420000 0 0x2000>;
>=20
> Please order reg after compatible by convention, and sort
> interrupt-controller or at least #interrupt-cells (applying to
> consumers) last, after the below one applying to this device itself.
>=20

Will do.

> > +			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
> > +						 IRQ_TYPE_LEVEL_HIGH)>;
> > +		};
>=20
> CC'ing Marc for additional GIC scrutiny, often the sizes are wrong.
>=20

IIRC, gic-v3 shouldn't have this kind of interrupt specifier. It's my fault=
 and
will fix it. Feel free to let me know if any suggestions.

> > +	};
> > +};
>=20
> Thanks,
> Andreas
>=20
> --=20
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> GF: Felix Imend=F6rffer
> HRB 36809 (AG N=FCrnberg)
>=20

