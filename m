Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69418C432BE
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D6060F41
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhHEG4F (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:56:05 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:60192 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238404AbhHEGzi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 02:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628146523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DD7zviREXQQlcg7evTk/OeIKc2yX2zWQYjkpZ5QZShg=;
        b=gNpO5Lo1IHJVte/BSSaHKsdxE++Z3aj/1dlhlMj+lzqryIBZKh8lN7/ZsqQJY9d/C+Bz6Y
        0u63odg+FO+DzQwJ9FdnSR2P871xhiuskDsCk5qjcptV1OZPWLUqfhBr9dD53C2k3nxypO
        A+aH44qOYGKeNB3eNJ8aFZ++el3ut+E=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-7-w_hP8sX2NByiXgd6NTtk1Q-1; Thu, 05 Aug 2021 08:55:22 +0200
X-MC-Unique: w_hP8sX2NByiXgd6NTtk1Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYfRBzN96rAP0nCfcuSA8656vVvqGiL9FlsnNB2IecgHHY67AAFP4m8qbik7H91cOxOgyJci1UrZjn3qtZyBkeBWJof8xy6Ayzrb5TNpNrXboJxTFUN3S/m/OeVj5oalGXxLbhVWNuDu2d8VdgK37ZOdbfpUEDIksiVJPrQsviqaAjBXa1k9QV4DRiebIspFANUOYogTPlsmkaulU5Dpi5VkxA2YybyRDD0ztwI5SEwjS8Ovm41IW+Ow+BG3KWL3B8+/FG1Sg5L+uKd1hFrCW52ldS9zy4AKfM0S0l8vJmiWJ3/fVDn/VHBvpUZ0DTXpT7PPcStzuYpfLTBC3JLS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t50iecsKjCtvY1sICL4y7g0m2qTZuEdWe1dFHXz2hHk=;
 b=dH5Mnv1ySeIIElwaHzs0cKRWyKvw4yMjTUDVPNQnKpZ/u0I9wxyvdPHMWkeAni8wjEmJNjAQlgnzDgFMUHEQwjqanYLjzqyxvAzTUH3CC2ROrzDlTbC2Mj1vNThHeCfkmryZFsrzZHXxieTxqm4/mutoR+NKI3Y5ZF0PrZe5zgc0MHEAKCHlXDDCdmN04IVwlL0PKCuPNcoFeuCUudYyWuNCd6AQwqmhtkU6VQ6I1I+WlQA6hik9YB21eSxxB0Wtdr18zf1hRP2x1ZH5MaZnEqa0+VLlY0892f7zJvfaV/zsuu/c55aB5IQVi+aBpRkiBIBgp5jFyb1cFytUF2MpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0401MB2368.eurprd04.prod.outlook.com (2603:10a6:800:29::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 06:55:20 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667%5]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 06:55:20 +0000
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
Subject: [PATCH 6/8] arm64: dts: s32g2: add VNP-EVB and VNP-RDB2 support
Date:   Thu,  5 Aug 2021 14:54:27 +0800
Message-ID: <20210805065429.27485-7-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210805065429.27485-1-clin@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:200:89::14) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (118.166.54.149) by AM4PR0202CA0004.eurprd02.prod.outlook.com (2603:10a6:200:89::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 06:55:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d790b56c-5f37-4097-5298-08d957ddfd5d
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23689AA5F1DC9BF92120B9B4ADF29@VI1PR0401MB2368.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfxjSAFmAM5cxDDfSR6uxgEe/Y/aPEDBq5nN4W+0tCO+Dlay/TVUTrClUQy4TokEUy3skrKyGcyogkQenIF16jBAGXmSP0ebCVFxMGNg5pkwT+xnv2hxogO3gBu3HS8SB8Z21Z843rpitcBAU5jQtK64Hvw/n3S82BGiY66AAlp5lw9HwIHf3wP9FyM6Ys18/vdDuzLw7ri89lQWWn17lqkpdtpoqFJ1Pu7G6sjz7uyC0Qr4O0IZu5qdnC+ssVp9E+9nUTcLmNjbMylhU3WcktOcgVQgtmErScQ1tM3VQSFQyHlHI9GLpDKPmQ+t1iEWI3dUpaz5FJ9OPBkg4ZBkA161R9rR3CpAerym61DlBCi9g0fDwh7mmz5YpzEzAkfInp9a78ytqvhsfdE+kXHdlP8v0inRHg1doQXt6BEQy5cadmGrEQtvH/o1I9SXCYdypuvT/AxTzbfusDi1ISha5uFT/CzRROTa35JZw2CEmT0wKFstro41EYpsUYTocfETX0ml0lkZC9A/pA+O9BBT0DvXPy5AaP6uYjWBIxtuFnk/Ofy4uiMkqXabIpAi5nFCA4+yKWaeq2SVc8tCX+vDM4cpqk26gl4kBGNfGCUCXUMFnIB45H909juy6HXgCOPJAp+AZtssFqyKhkNa8lc5PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(6666004)(8936002)(66946007)(66476007)(66556008)(956004)(2616005)(508600001)(1076003)(5660300002)(26005)(4326008)(7416002)(6486002)(186003)(36756003)(107886003)(2906002)(54906003)(38100700002)(55236004)(316002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?booowz/HrP0P/KS+gr94KkCu5T4mV4OO4tPe0DBs2JQDKwdEESruxnLvqPWd?=
 =?us-ascii?Q?YjXeDD8v82/utAQY8jSf49fLcysH4Ssxi8Rt+g2Me+1Lvq8WfbdB4m7hedzI?=
 =?us-ascii?Q?1U/oBoq5fj9nHyH+OAYDBsyfl+RYiCispk6yX0K5/g/pO8jm5KLejeTRkHMP?=
 =?us-ascii?Q?zOhVB5XYTsn13HQb0sYj/tL5yppvKV4xhoHe7O/FEUXlpGjV7+L7GdysWI1o?=
 =?us-ascii?Q?nmv4Uks0LDoynF+enZy7KMBYn5vIsnal/OLSJKon6HypUVPr2YE7C5964iZO?=
 =?us-ascii?Q?aIR5+PiHm3tv2FBbEBzzqSK5FmweU3TURm608xgWxdiNOX9VlljHmzpsVQaH?=
 =?us-ascii?Q?2Bj8Al9pDUu20illo4cZ3yDDua9V91277NQTNG/2we8kWs4IC2WHokY7IKwZ?=
 =?us-ascii?Q?8dTV0WayZzV/wKoFrJZIckVLY34G4N4b/aVSrLMMVhcwZSvNZaAUWHSdpZIc?=
 =?us-ascii?Q?Rjgz9CcqssNWeV+961i1oajRhwq8CpE2zPjYlTzlKxwYZTGWlGZN0to0vRQV?=
 =?us-ascii?Q?3i7c1O5HDdkCrjKTAW1ubSkRfQG1gOsH9z/4qZSj6qka1Iu3Gvk4idyWNZex?=
 =?us-ascii?Q?Bdf3SDRfoRPUl59rcdVTneoHstKv7P4NRDSFFvitfuyXQyXVkxTpMbvTSI9l?=
 =?us-ascii?Q?s0TU0URWoIIrmstvcwqO0Nskf20OVdN9nwXOGd8wRp6wzidinosLpoPGhDD/?=
 =?us-ascii?Q?TH0GlbkEtbPovIcjGGDCu7IfAe2+KtMqPf0xGForVbdxqLzV7XKEphfa5r8Y?=
 =?us-ascii?Q?nM7ixzVVFDqcb9uyErd4ipFHujPlhc/UPGTqTZBRbCCQSFV3sA28icaVgtIU?=
 =?us-ascii?Q?MvYVCngDkUXPXUcZB+Ysg2SixY+d6svW0Rk3Asp++rUADcoSuHziAKSF6heP?=
 =?us-ascii?Q?9MtfGh8pN9HUjbHllvWVgNf+LyuEKsIUk89EYLkbUF/T+6nD7aUdcJKnuTBB?=
 =?us-ascii?Q?YWgLgCuBXWpotuXjgZVZnPQqUy7eHOmCvxGwiUH0/EUBB/QoQeo+pLGCH/Kr?=
 =?us-ascii?Q?5rtNFTRk/SywTTCi/YlvARN83E4IP0GMwj53RUELqoesnuFaRtWQMTShLUad?=
 =?us-ascii?Q?8n1Mzqz6pXu1MWZyPMp760YSBMiNT/q29R74hgPj5jQUfj5I7iXt/HkCcX8t?=
 =?us-ascii?Q?WnoS2YbFIkNS+RHxvthN+FkNXhfHPce8zAExO91jR0UeEO8lTySk3/exEwn4?=
 =?us-ascii?Q?zw3KwFafGRa0+8QO90h5yJUYoMwt2hDXL8SRpAENidZkz2ldOH4JcKfY9yDl?=
 =?us-ascii?Q?tWWMu2qxGtIOZQ9ButMtJX54/UhFebxC3eJY67LdYJ17Cxfz1s5Vu7zTOMg9?=
 =?us-ascii?Q?WIXQEDCBG2L2BReJ8EguTVuD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d790b56c-5f37-4097-5298-08d957ddfd5d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:55:20.2674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzFOj+1h5Lx2QkWahOb+JGH43bVeXu/vz4g2eEcqSbnfsCW+Lc2c7MStaG7eez6t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2368
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add initial device-trees of NXP S32G2's Evaluation Board (S32G-VNP-EVB)
and Reference Design 2 Board (S32G-VNP-RDB2).

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  2 ++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts | 21 ++++++++++++++++
 .../boot/dts/freescale/s32g274a-rdb2.dts      | 25 +++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-evb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index 4b4785d86324..2886ddd42894 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -67,4 +67,6 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-ai_ml.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
=20
+dtb-$(CONFIG_ARCH_S32) +=3D s32g274a-evb.dtb
+dtb-$(CONFIG_ARCH_S32) +=3D s32g274a-rdb2.dtb
 dtb-$(CONFIG_ARCH_S32) +=3D s32v234-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/bo=
ot/dts/freescale/s32g274a-evb.dts
new file mode 100644
index 000000000000..a1ae5031730a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 SUSE LLC
+ */
+
+/dts-v1/;
+
+#include "s32g2.dtsi"
+
+/ {
+	model =3D "NXP S32G2 Evaluation Board (S32G-VNP-EVB)";
+	compatible =3D "fsl,s32g274a-evb", "fsl,s32g2";
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/b=
oot/dts/freescale/s32g274a-rdb2.dts
new file mode 100644
index 000000000000..b2faae306b70
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 SUSE LLC
+ */
+
+/dts-v1/;
+
+#include "s32g2.dtsi"
+
+/ {
+	model =3D "NXP S32G2 Reference Design 2 (S32G-VNP-RDB2)";
+	compatible =3D "fsl,s32g274a-rdb2", "fsl,s32g2";
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&uart1 {
+	status =3D "okay";
+};
--=20
2.30.0

