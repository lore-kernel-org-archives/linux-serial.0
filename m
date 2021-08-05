Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA00C4338F
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5306B60ED6
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbhHEG4E (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:56:04 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:28642 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238348AbhHEGzh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 02:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628146520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtyUz1WM9GduhJ+JpYxAxePP9bArCgW5jeOHNMAwSRw=;
        b=PjO6jnxlY1uGr+PIapF3E7xITgLuuFGUGYlgXxJb91uNfW1/nsvFZTFBFIsQ8pW35PlCRZ
        OpvwUKWxYikXMI/bSe42KDYRilRKUCAVTJoOK5QY58rGjYOC4pmhA3qwjbFSl9xT+oZxeG
        EBju/IsRVBNtDv7Xizse56tUGZiE8Qo=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-WW7BnNmYOPqvHr9iBLzbKg-1; Thu, 05 Aug 2021 08:55:18 +0200
X-MC-Unique: WW7BnNmYOPqvHr9iBLzbKg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN0RE5+u3XNa0DCnySCoZ1VNJ87wgXtCoI3usq+mx5IkupM3WJ4TnaH+ekayLDcjiwN2Nw2Bap4pxixQj/2XcWSsZvVGqq4k7WtDWvdGN/lP4+C1EvbbAmWsGQj6heiUBCw6XdAAhc8a0yuZ8Cll6jrBzotzCbo0oYlCLE4vBGgB186/pwKyoMHVS6ewW05ZxsuQVpaOALdthZhCTyooZlmIKbk9xVbzL1tA+BANsQMU6Lou8kVJ3kkx4N9kwr8XQ186ghk2mkjMpHw887dOjQp2UgUJbgiVTyEGHDRtRfT7aA0wBOAETQc3mUNyLTPbp9TSwXqm8b+AldVY4+ggSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTd5YWY+hWCRPjqqB6Wb9W9t5J8FxV+zb6JupzkHl5k=;
 b=bdyO5ERIgZALKqV4ag7p8DxGAGzpvaCiqgnmmhP8pXMTO54xTTbxD+zRt02o1F44UlFXV8iSN6ZA/014de6G/2W3vDhhKzBPvgSLJMQGEwBVhiXwuNbtHtaM4Ryxo9GXkqL6C1Pn3UQUiHZmAcHO9DjWsNHNc74eo/2nQs2AYcvsO0i0NN/eKBVRbiK/pdr3MickQ9zwBrd66Ph5QWw32dsK4TPvl6zA1apcI6uOfsc7rsSs6rkj/YPYg+lbek7/3ztOWSO+WDLEU0X+UFUkF2l501tS5JJ/651AtsbKDp3gzK8l4+7VN6hdRfPvpO4aeec2XgUGXSYVm52/E/JuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0401MB2368.eurprd04.prod.outlook.com (2603:10a6:800:29::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 06:55:16 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667%5]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 06:55:16 +0000
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
Subject: [PATCH 5/8] arm64: dts: s32g2: add serial/uart support
Date:   Thu,  5 Aug 2021 14:54:26 +0800
Message-ID: <20210805065429.27485-6-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210805065429.27485-1-clin@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0141.eurprd05.prod.outlook.com
 (2603:10a6:207:3::19) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (118.166.54.149) by AM3PR05CA0141.eurprd05.prod.outlook.com (2603:10a6:207:3::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 06:55:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3443da3a-3c01-4f42-ebb4-08d957ddfaf4
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23680CB42C4AE3C7102086E1ADF29@VI1PR0401MB2368.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHlwsNoKyr7K8xirtEbeumjBqmiiudcfmPCo1nS4EydSk63W2MKA1FkHshmxu0JkoQQRHAYrFqRESnHIH8HLKBaSB3kIbSj3tUld2MW9FgJOdPxb1ZZ6kV4NEpfffHDNMtFctOkaDwLtIOvuudA6fW2/EARK9z8U/8kAsRseDvjRW66X0CRStwmpee5azhXC8+YaywgGGG/0/b49rGDWrTHnSmsqTFPOUvoGQjUH3ifOoB6ANiVRTCfBP0Ouk8ctv7lgiQR8uM3remRd74hsgw91wb+mIfZWAoedbZSfokmstSydMK9y0HDN5VbuKx8HXJVAYixYDvSdGVP2hnkgspNDcFZP8zll2XvDUQBNcQjxZcjd+MhZALB8O24FbZarmTVM+ZReLEiSr86LDb0Zs8mwYg5UqupSuh5fh8q8r5C++l/hSY2GIMZVCBU3Im7avxxYX+NDJHIiKdjMNtfOCwezoTXL8l3EZZbUa+mCghpFNFCBkAP7GNqHU0vM4O5XgUcGQM/6Po04+8TO/TzNDS4cP6Q9JCn15E/j7Tf/Lzld8rlMBbw86uIYFz7t76x5ZnwOc8KICC9xgcejS77RBmIxcYwGxsi1v2rITu+g2fUbiiBFjUE2Dz3zA0pDYqROt0wXIqgJ6mrni1lTieXbLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(6666004)(8936002)(66946007)(66476007)(66556008)(956004)(2616005)(508600001)(83380400001)(1076003)(5660300002)(26005)(4326008)(7416002)(6486002)(186003)(36756003)(107886003)(2906002)(54906003)(38100700002)(55236004)(316002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D/T+K8OUXViZbpwIYlllCNYRtCA5KIvgIXg/mK/Mr54OJNn2SfogdEMYb2+m?=
 =?us-ascii?Q?52YSOIY6gwwXIHhM9VsWX+1Rpq6elw5DUkLcrpfT3lzn94/STKoLn3rrHP5B?=
 =?us-ascii?Q?XyH0ped0eQs60axjAvF37UmR8c2WMqA37OxIRJ0V3SERYS8PqyF8bbEBAhzE?=
 =?us-ascii?Q?SnwWAsDFafFGXGgYeIgLV4RHxHnzs7SH85mKu293yTpC2Rls2fxBdz9GHF1n?=
 =?us-ascii?Q?2vinOPHOKclzn+NNV1jOARrZMmUnpsOk6yf2SjcObQffXi0jFTXJry6NvAQZ?=
 =?us-ascii?Q?saxmK6RAi1NsquI/uE+mlv0hO2ZcZdXjKpoS6rLAXbKgU+K0RDv/gZBSqS5D?=
 =?us-ascii?Q?pbmgkecOEXX4G0EF6r8dwGmtPRE5jJBZ4KhkcuWrzdxdSRmrj1X2LEqYhJWR?=
 =?us-ascii?Q?uN8VvD+fCk4HnFnkRTzFRxaF/n0kGNBwVidRhFhZEuRPVx9hzKOdUYI7KfGQ?=
 =?us-ascii?Q?H2qTBVw2UwWDQ0zFAGJJgU/oO7K69Ru3R4HWK0uLGWtXLtRqzxguV92O7YVS?=
 =?us-ascii?Q?zjHG4u9Tzb4ZqMyKvz91pWdx0P5ZbVr4zNYZGNL84TGLuQ7xROuI4Eto8xr7?=
 =?us-ascii?Q?dXTRmFfJaRHa20Viv1Hm2WVsP0qj1acj4ylu9aJt1Z6ibEmc5tvhg0qXAjvF?=
 =?us-ascii?Q?yw9VYxphyGdd4AHYDKaLMiPd2Lqoz3rBOBniQLP1clGKf6iuSdDlWKrJkjW1?=
 =?us-ascii?Q?M5pocGCnLZfnwfnyv8d1ZTYxxPHDQOCge6mKqoxXx/8Nqw5AF4BIbNbhzN8n?=
 =?us-ascii?Q?0456+k5hxqmWQorOAfCrOkG005ncFWBdU/ChY4Kh5xqmba9eaqD2d1quXdS9?=
 =?us-ascii?Q?q+PGpyK5euZu1geN41fdJPSIbGPvmHAtip7ErJ6fKnYEWtKXJd5PVJ7ae9Oq?=
 =?us-ascii?Q?aU23ncAlZNQ5Kd/GZctXaOp3aKqOLM7D571jHTb1N3+VywTwNS/Cw6CQ7XI+?=
 =?us-ascii?Q?9Z5C/kDu+hrI02irqkfafkNTib+eKblC+cnn9jlIxZGBxoXsTPznQs0qj5AG?=
 =?us-ascii?Q?YwSJi4I8Y/xc0t3zB1ltVoNgvk54bHoiSfZnIrr+xJJ8Ebhw8CKwKwe9HqRp?=
 =?us-ascii?Q?POVlGzxq/LpeC52k2m7Ewdjs+X98VfaKFi0zFDlZngadyEi2sMdUDW/VBOwR?=
 =?us-ascii?Q?CCkZT8NMgdwiRyC7qYdWJjpfxWfBL6o94Wv/+GPp/hyfhMt1FtgJI8EttF55?=
 =?us-ascii?Q?xOrilTEH75SBiEyPQ4AleKRhjqj/Xd1a0chP/F4Oh3OERWTmaGpFQrp22xh4?=
 =?us-ascii?Q?AEvCoFlNjVfPpQIqLroOo9NEIxvd9oiicI75Hb4cHLuRhd6d/6KchlyrDzJ/?=
 =?us-ascii?Q?5aSfZH4UDl2ygYX3YBepYgLI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3443da3a-3c01-4f42-ebb4-08d957ddfaf4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:55:16.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS1vz+maa2hMWyQVrr2T57pU19dqoYD9Sh94HLgJpboInbXYHjhrgcGWCyVBdp3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2368
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add serial/uart support for NXP S32G2.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts=
/freescale/s32g2.dtsi
index 3321819c1a2d..0076eacad8a6 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (c) 2021 SUSE LLC
+ * Copyright 2017-2020 NXP
  */
=20
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -11,6 +12,12 @@ / {
 	#address-cells =3D <2>;
 	#size-cells =3D <2>;
=20
+	aliases {
+		serial0 =3D &uart0;
+		serial1 =3D &uart1;
+		serial2 =3D &uart2;
+	};
+
 	cpus {
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
@@ -82,6 +89,30 @@ soc {
=20
 		ranges;
=20
+		uart0: serial@401c8000 {
+			compatible =3D "fsl,s32g2-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg =3D <0 0x401c8000 0 0x3000>;
+			interrupts =3D <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+			status =3D "disabled";
+		};
+
+		uart1: serial@401cc000 {
+			compatible =3D "fsl,s32g2-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg =3D <0 0x401cc000 0 0x3000>;
+			interrupts =3D <GIC_SPI 83 IRQ_TYPE_EDGE_RISING>;
+			status =3D "disabled";
+		};
+
+		uart2: serial@402bc000 {
+			compatible =3D "fsl,s32g2-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg =3D <0 0x402bc000 0 0x3000>;
+			interrupts =3D <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@50800000 {
 			compatible =3D "arm,gic-v3";
 			#interrupt-cells =3D <3>;
--=20
2.30.0

