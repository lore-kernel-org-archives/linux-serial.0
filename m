Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEB4C4338F
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F2D610A0
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhHEGzn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:55:43 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:45597 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238304AbhHEGza (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 02:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628146516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Zmc6Tja/FDrw+1LpizfijcQa0175lf29b5kr0oBbuc=;
        b=LSlHoKXUy0cFFQn+tnLv1ESj4Zapv2sqjiz6NvSEFkfEhLbDezXxxLsElu1SLC5u0lvZFH
        z4pQsUMovRb+ItIcKAIXBSQu+P9yxB5g6NZe1KbzOkvzBQMQdiSbZjS3dwFHbncEGVOAlo
        /9Zi99Mv+HPyVbikQh/8gevZ6HaCmos=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-JFMEcdLjNbimZ4qLnXA_sA-1; Thu, 05 Aug 2021 08:55:14 +0200
X-MC-Unique: JFMEcdLjNbimZ4qLnXA_sA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frAN76kDLvH/F9REfRObahHDfntB+VA2nRy8hwpqxxTTmpbo5Gn6Bz0AoEjHt6QESfcIPfzz31xFdm+FQkA6hIHK7BowfH32f/3dnofAt4866VRhQ2Cq0k88UL/yiM4b3JVHu9Etnxlblnvtv6SNt0UF4HqEUKJRN0ovmkgUpDnGFGLFDzXykyWjELTltuQk+XYDD2QI+BTZfZr93WalJMdYQvPyRjxji9GJzVGuQlyQogQbcDAycQ6jT2XbBP1Mi/goXQCr4YtC5XoE3DbYHlHdD0Vhu7yeRGjt1jWlx98OuoLzliicq2uV3HLGG18vjPI4iQs/LoZGsCa+tcwFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjIW4uXbAmVlo30kygizRjnAv9qD6xr52oshhgvP4Uc=;
 b=Dz9GiAiNv7KLAgNDskxvqHS91Utb0IAe+fqZONhTqcXrpHhy3H1A4qgaMpqseB9y7SHOvzaqoV7LAaMZuTvoQl5vIz0zppbMpzn6GWowcTYI4eziW8IjhhJWLSM8cqRH+KWpSgSbQ6lTNsS6CsxYJkhYT3UqvbHG+sEjwRUXlBolR/lNzPLC60eB7N1qdaemfEByADUlK1BO6HD1+Q91l4mBShvqL52qesUJp9/IUsieT07J75NbhsPOdQeTXY22s6gL6Rax7g9gnFMO0faF4QEIc1xQyGDa7DirZhzM58JF8CCit6aIDHuVxlK08Xa5timDSwmt1KFeLA/E9mNxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0401MB2368.eurprd04.prod.outlook.com (2603:10a6:800:29::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 06:55:12 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667%5]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 06:55:12 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH 4/8] arm64: dts: add NXP S32G2 support
Date:   Thu,  5 Aug 2021 14:54:25 +0800
Message-ID: <20210805065429.27485-5-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210805065429.27485-1-clin@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0135.eurprd05.prod.outlook.com
 (2603:10a6:207:3::13) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (118.166.54.149) by AM3PR05CA0135.eurprd05.prod.outlook.com (2603:10a6:207:3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 06:55:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 685e81ec-8238-49db-a8af-08d957ddf87c
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2368C6195913E8F1B6777EB3ADF29@VI1PR0401MB2368.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riBkHNOKX0JtspFFEMH+/pakwQVu/kwBOsgbVQdlvsHY8HaDeEuw3ae+pIRlXHSS5zeX9Q9HGXTaRAALhq/tYWOY2nzcAAFW0ePtMiWmoBVY3tFsTq67S3GJblX8VYbTAz5at4tldupnAtGd55rmqkSZ8RZoFTIy5KJAEUvLNxtic4qKxxSNZJVQRkctViSd9L6/wOCD2k95lvySZOVzI0pAQtxuyE0OqhAW8sVzitYuWirDuXLRye56B5SWCP4rpWCRIiBdhqze6fCjUsXzCqH6rbdt+CZMfS432h58zbVXgV1R2YalTWLm9Z6y+HZ/0fE3hTEk4mwdYI+0RYVKUi+6vtByrLBLvShQIureKeYTE5n2WoaSpgJKJJ95i2h98p1pDwuDhV/7I/4yAn7uKcEjIvqc8slmLmBwZE0PWXAk8XQk20cm+TJFrud0WaANV3s75Rzed218lZbyEYACMh1bebPdu7xXjL+KUMpVNlz1oOhbI4weMyH4iMf9vxChtkRpp8zkPw3ew8Hr6qa5IqWa/gNBHN2Q4VT2hK7UgVVnNMXlB33HNmp8de/vimXvkRRB6SwV+63BUTER/dfIjljf/oSNAjcb4ugZcEDysDYTqVH2LlMPsHMhnUb0nvy8oTpH2Mn5cL0CDby9+5hbMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(6666004)(8936002)(66946007)(66476007)(66556008)(956004)(2616005)(508600001)(1076003)(5660300002)(26005)(4326008)(7416002)(6486002)(186003)(36756003)(107886003)(2906002)(54906003)(38100700002)(55236004)(316002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?edSvwQiXqFu5pJ4rX1FGqWHf3V2Dy7rYfOqd0lmlB/OJ9YtHwGLKzM6xtIGH?=
 =?us-ascii?Q?gafF+zIkGu1EPPPSgrdtA2GOuUJVCwL025Tn6hpL3o0MXempanOg/PTMXudj?=
 =?us-ascii?Q?mTttM+ZkKwlEEnpvcA2/d3/IqUy1lJyp6QT+yKyAKB3Fz+YQ2Rqvxi3NYaST?=
 =?us-ascii?Q?YeRpo8+8WaU5ZGrPBwfz5wbbbq9/+OqKm4vW3z/6Wb37vVgJSRENhrimbBV3?=
 =?us-ascii?Q?Y/q95Q5x4CPSJaaEYhEpyhv28YelKZpxIyFSv59l8C/3FEJu+0iGOi0aTijJ?=
 =?us-ascii?Q?2BN2MlhqiqzhK0rk+rzNPLWb3IeRnhPdHS9vDPtdCSMm8tBRaTT7Dl9EbIUv?=
 =?us-ascii?Q?ZhoKIz1qSNHpJpl+Ge2MV7j99f+ZOeBnquOPSXYMy8Di5+Pj+2x5FR2Cjyp9?=
 =?us-ascii?Q?ZuCRLFE6YKLc0PwC0b1R2adBZKjxEiYCIG2VUUc0GAIVwAWih25bRcCaCQCC?=
 =?us-ascii?Q?Om3UP6sgzhBbalPoZzYX2LbeVDV4bQabg++XYr4EtD6LFJ2+qEicBzm9enP0?=
 =?us-ascii?Q?eqAhfDlUGPax5fKKjTbexD1b62r46wPXx+oYJ+mVJJlhHIDw3m1+VDpQ5QfX?=
 =?us-ascii?Q?Fi5QNTe3YyBIUthJxroL1oMvgfy3DS9b6mGenbiHL8MNmkedce8XTQAzYQXU?=
 =?us-ascii?Q?txU3ar8nTwrQwcQ9TTZOQm0IVa+m0+3zVKpMlAbfrD4JYvNVRQ/aCGdA/Ots?=
 =?us-ascii?Q?pMTkyRxu3C7+/XnadZoDKGjPf15AujTbbS3qiQFqW95daFncrSsaquzlbby7?=
 =?us-ascii?Q?HRbudJXkijjO389WVMz5ta5PWnyZJUEj5Al5k8/art974vcV+OevRQr8ctig?=
 =?us-ascii?Q?GikpejK1k63b0fSxU1kDubvJESGl86DR54MUd4acgz7IQqJ4yESlEzgu4Ghv?=
 =?us-ascii?Q?+5x6jE1Z9hBX5LdHU4mH5Eh01gpC8gd9ehB1pd7G8+Cp2OkMzVZ8SMivq0iI?=
 =?us-ascii?Q?2eL2Mee3kzccWuJGkhFbXqANz7F4TWSN2Zs13GoTbM5CvOr4BJhV0zaP+Rno?=
 =?us-ascii?Q?Q1o23Q4hSS7baimdcq+1t2U1BAuMd3JlJ7WOUxrbxcs36jRUwYXKruLik2s/?=
 =?us-ascii?Q?Mtq+H+SyRBaXpPyIX3mEwrTi5SUc17qWFLEZKv9HrzlRFYZhC0kdr1BGBgo+?=
 =?us-ascii?Q?grQfBrdE7y3OUjYJf+gqP1DaBetEnILWGcBToom4Y+Ik7is7Guosf2lehu7j?=
 =?us-ascii?Q?kH4Fy8KDu1q5KEZ57eTVKrR01EMjlZT4kwUUkvrx6Ekb53Kfe+57ZZsnvYsp?=
 =?us-ascii?Q?asHXo5lEINhufRAE8zlnSy7Nj2nMN5BDQ9hnhEM3BXLANCmj5rGXjTD4erAH?=
 =?us-ascii?Q?JD5wj4XWQdjeCRXFlZ6cDKep?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685e81ec-8238-49db-a8af-08d957ddf87c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:55:12.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGiG28JfJ2jerAenpxc2fLbBaN68bpbsVSuewGT/OZ1EzJ8W8GkwfjQT8ICoKz0x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2368
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add an initial dtsi file for generic SoC features of NXP S32G2.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 98 ++++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32g2.dtsi

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts=
/freescale/s32g2.dtsi
new file mode 100644
index 000000000000..3321819c1a2d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 SUSE LLC
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible =3D "fsl,s32g2";
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
+	psci {
+		compatible =3D "arm,psci-1.0";
+		method =3D "smc";
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		interrupt-parent =3D <&gic>;
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+
+		ranges;
+
+		gic: interrupt-controller@50800000 {
+			compatible =3D "arm,gic-v3";
+			#interrupt-cells =3D <3>;
+			interrupt-controller;
+			reg =3D <0 0x50800000 0 0x10000>,
+			      <0 0x50880000 0 0x200000>,
+			      <0 0x50400000 0 0x2000>,
+			      <0 0x50410000 0 0x2000>,
+			      <0 0x50420000 0 0x2000>;
+			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+						 IRQ_TYPE_LEVEL_HIGH)>;
+		};
+	};
+};
--=20
2.30.0

