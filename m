Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89713C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693E86113D
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347778AbhIHGru (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:47:50 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:45868 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347796AbhIHGrm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Sep 2021 02:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631083594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Et1PFLk1ygM1w1yfk1DJAMxYD/S80JXu5lvYsknP2O0=;
        b=YZkNdfHbdHVY0S2BTooAbZP8eb/S4C0x8N4cN19v+qS35wtH/yxaB+Wgf5dRcbAf1PxHmi
        mHFsGJ37cluBdIh2OhFxdUTAfBe1xST0UiDwhXOX8Jk+a9iXI7sdDoUzfaqbsxfeZ35t6P
        u7g1UAlsJnKyz6JAAZZnLKnR3+DhJ+U=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-RZ2pbzjdPue51_m4ijRaXg-1; Wed, 08 Sep 2021 08:46:32 +0200
X-MC-Unique: RZ2pbzjdPue51_m4ijRaXg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzpAK5pFBrL/Mf9tc9hOgaBrdfCYNeEGWe6aq5ZywicFSozUtBqnkD/wnxfcVft/L6DHmtmVOuq8SRUPkmibw+KajyQ8QMPq3mfuqSnmW0r76q2IPaREQLwoHduan/GsSQMpr6pzy70TwreXJFgCM0WefDrVF+j4gSjggPm0KITeheSzGUbL/ixaN7XceGeBjN2NiMAjGJ+4yx2qQN13w0yOSY8Rps3hkl8WnyHw85+MjxPyTa0Yw9JBoL7yJ5h3HUHh+8LnSItUBhuRRt/1PmDbqv6QIRW17NId6a62a5vaKt+KpQpMFvwMeN6DqTiOWJXmUEOgjINZ1o3m3jBx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GUv7SDqwPC2UZLgKIyZN0i2FUybPDuc+evVX58iWOnQ=;
 b=W7ZUb/OXmx+298FQA7xs8VrYKHnoij/hZneuS3duLDw+FiuKTEEqRK6kWbH/WcUIQlEZuuAABUU/9Pki23sBR5DNyujw2iQWQ0WnlSP9VUyFywhbgylkgOKt+yuPPLq76aCOyg+ItzJYOX+NdFb6uGr0aUJl8fEGvJ3KybEqUGaRyV0mPqw7oggvKf1aSpdk0k3fdX0a9erRFyFvsigjUCx/8sGxesSJQ7RYi7Wdhf5YHfcwCy0TOzytfpIsNA2DXFzBs4SuQfgM7xwLNhVRSxnfsYAUKspHeAVFocE9dZif4zyGcEeOUAdqGhY/ImBtb1MuIx1ScIlBuUs+NeildA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4000.eurprd04.prod.outlook.com (2603:10a6:803:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 06:46:30 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 06:46:30 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>
CC:     s32@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        ghennadi.procopciuc@nxp.com, "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH v2 4/8] arm64: dts: add NXP S32G2 support
Date:   Wed,  8 Sep 2021 14:45:24 +0800
Message-ID: <20210908064528.922-5-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210908064528.922-1-clin@suse.com>
References: <20210908064528.922-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0107.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::23) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (36.224.129.215) by PR0P264CA0107.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:46:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25b56223-75a8-46ff-2ab5-08d972946311
X-MS-TrafficTypeDiagnostic: VI1PR04MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB40006081C789515B05440412ADD49@VI1PR04MB4000.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/vgs5kr8u7EFKFOdvneHcNk/JOGTMAbIdw6/e8evqlFnRTF4jUaBGV3xe9CMmuxaQFWU00b4xlugqpRZ9daDw4Ao8yriMlhkF1aBpiGrLrB0ydSKz0SgwaIcCIvT706nafRyPs1F2jlXwjWu6UXtPIHj3hfWgUeOYL7oxmdnVl+pUlQMMWVXC5xajTf6GzEAKG85PvPRU0Lu9VD+ocKF5pA+XK1lgRdXI8Yq5me4l4/fP8ijSsqh10m/xNma0+hz8tqDWrqxgUfpkg8RJLkJ9HWUEb8Ct1iFgNkF+kbPnW0ZGyA7ieQw+DU9LA56Yj1/7i1ZsMUiSqxDjGTwfOtxrKK8u+uaboCRXqNhk9k2aFTwuJI1eywGlRglYQMu9O6WwJuD7hBKsXVIZA71cFVug3NBbiqffalfaVfIQAWK5NHK4QNTB2vZQllMhis6zTCk0L/ernQbxGCHWOmJjo+UGFGPfNWfcMGw7rqfPd3HmEdXV+zb/MbqEajsr/LsBiP/+vZ/elFNyr8B6cOUNpu7zc4Yd6t+Xm8c4A3SSIpB/ZwZS0EiN8/4mFgNPjOsM31ZwPXsqxQG7X+FYP1+X6M8K1bELUFpcVCmsuTmGeYl7cZ/jzN0Yz4de7wWtNWvKWlHnGq92VokLT6mtGAU9Q67w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(66946007)(38100700002)(66556008)(66476007)(86362001)(7416002)(478600001)(6636002)(2906002)(8936002)(2616005)(110136005)(186003)(5660300002)(6486002)(54906003)(107886003)(8676002)(36756003)(1076003)(26005)(6496006)(956004)(316002)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IbbMbfcwZGQf3CaQi5lsvu9a/jxZiUByuyFTluM2AApaM4hvI5ZUCMu0tXR+?=
 =?us-ascii?Q?yJtnWiaAiXG+qsekEBgPGYPEWF6IVqsarZmnIE8pg0GoaNQop4OWU/PPL3jm?=
 =?us-ascii?Q?hPi4NfD9CKt1Muk97Zs8YGqgBZqo+iLeE2ignBJXwX1N1kqYv0dy1W5Z9TNd?=
 =?us-ascii?Q?JvKICcfENb0dPAOHVgN+U6UZGu+ogz+SWnNnQrxs9Lf0+9Lisj0hmpE+sQEM?=
 =?us-ascii?Q?F0vpJ955HnDM6Jw0A2tWHbArqki3oENk79brHNmZORshEVdL+XPK88/pm5WU?=
 =?us-ascii?Q?4Talav81yykxu2lXWGDjDyu6lCT0O82gINNx9+MLNnnnpIrc0IFLlojxb6Vl?=
 =?us-ascii?Q?3DeZQoCzlMAkSFgiKRecEdB/ngMRNYTgekBzKtvVvaMpgdsLRI6u2xFRLTfc?=
 =?us-ascii?Q?gDrBhneN+1DEN6GJ030EhNUgV+IDxJgUzj5ZwWz+yIluQ1rc9yQ0mxamXHuV?=
 =?us-ascii?Q?69rchX7vCYH1uAPCqv5vBFBITbm/13r9DcotnUYrcpBtDO99gfInZfQjP8yl?=
 =?us-ascii?Q?tNsPaHXporC8/JGaBIIFdcWDGglD5Er62NXzaBKwzLLQyo5Ymgkv/uR40beu?=
 =?us-ascii?Q?jWP6eOJxiKUviYPwjDzMnNtlzT0eHjtTIq+4K26Uz7FxhcElPZ37sof5Ml6Z?=
 =?us-ascii?Q?5SDpav4u3x9fOglopRDwvLY6YOM9XmMA5vYzspcoRmQBYPSEnOft1e0hbvv1?=
 =?us-ascii?Q?n/r8lGYJzHuipPyuNcApFwTQVDXBvQgz0WJxeYGLrVDcGHwf2/I6fEUnsh3p?=
 =?us-ascii?Q?Quov28SWsSeTNOd1PS/NGiSW1KlVaNb2ULvO5o/fhQnrckLPp5KwKVmJ35Dg?=
 =?us-ascii?Q?ln/jJaz1p+qzzD0pI3LBWz/bTRaFcatvw1Kt8LtFYJkWs7SKxdAkecFv6zUg?=
 =?us-ascii?Q?amAb6oEvk0F/jmvu5GZdu6a4wsC0u8nPiFVjKpIiSG7AeVj8EX00TfzXc+FG?=
 =?us-ascii?Q?6sIZy+P9rV4lvVxpXrzhAPLjw+jZ1M50zsbuoFIBHHKhd2kARNR6cuigU0pB?=
 =?us-ascii?Q?Yze8DhzmRRjyRZnzaBTba86zAqADyXkavAbk5QpZNh4mVRw+mHg4kRGN+0vf?=
 =?us-ascii?Q?YFvpH/BygejiXWODcFl98OdzC46Pgt/0wGKB+hsO98Z8qJ2R/XkLm4Pg7cay?=
 =?us-ascii?Q?nU8yGgASX1w6+na5yL3aJMz/vOapeTv3GL+UCOOvwTK9RICwjynBFEtDIWXE?=
 =?us-ascii?Q?ho8sb/HykVZ6CuLkg+f/snY8fFaCUYQknhn3eMV8UBtUX7esfOWUoANQ55DI?=
 =?us-ascii?Q?cJRTfU3Wnodjj4R6mn8kFpSmmapoA+5xN60etGrqot6roM6DdA9JFJkE8i8y?=
 =?us-ascii?Q?r3YU8enJ5FwtrmtEx53uIzlW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b56223-75a8-46ff-2ab5-08d972946311
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:46:30.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvU9SEgeHIijcz9t65SBp4yTHi6Vh87gWYuUneA8IIr2sdf0yDfNJ4RWo4CRUOTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4000
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add an initial dtsi file for generic SoC features of NXP S32G2.

Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v2:
- Add a SoC description.
- Add an interrupt-affinity to the pmu node.
- Move the psci node into the "/firmware" node.
- Remove the redundant properties and white lines.
- Remove the wrong interrupt specifier from the gic node.
- Specify the range and cell-size of /soc [0 - 4 GiB].
- Correct the reserved size of GICR to 512KiB [0x80000].

 arch/arm64/boot/dts/freescale/s32g2.dtsi | 99 ++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32g2.dtsi

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts=
/freescale/s32g2.dtsi
new file mode 100644
index 000000000000..53b18671deec
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * NXP S32G2 SoC family
+ *
+ * Copyright (c) 2021 SUSE LLC
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible =3D "nxp,s32g2";
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		cpu0: cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0>;
+			enable-method =3D "psci";
+			next-level-cache =3D <&cluster0_l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x1>;
+			enable-method =3D "psci";
+			next-level-cache =3D <&cluster0_l2>;
+		};
+
+		cpu2: cpu@100 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x100>;
+			enable-method =3D "psci";
+			next-level-cache =3D <&cluster1_l2>;
+		};
+
+		cpu3: cpu@101 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x101>;
+			enable-method =3D "psci";
+			next-level-cache =3D <&cluster1_l2>;
+		};
+
+		cluster0_l2: l2-cache0 {
+			compatible =3D "cache";
+		};
+
+		cluster1_l2: l2-cache1 {
+			compatible =3D "cache";
+		};
+	};
+
+	pmu {
+		compatible =3D "arm,cortex-a53-pmu";
+		interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	firmware {
+		psci {
+			compatible =3D "arm,psci-1.0";
+			method =3D "smc";
+		};
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		ranges =3D <0 0 0 0x80000000>;
+
+		gic: interrupt-controller@50800000 {
+			compatible =3D "arm,gic-v3";
+			reg =3D <0x50800000 0x10000>,
+			      <0x50880000 0x80000>,
+			      <0x50400000 0x2000>,
+			      <0x50410000 0x2000>,
+			      <0x50420000 0x2000>;
+			interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells =3D <3>;
+		};
+	};
+};
--=20
2.30.0

