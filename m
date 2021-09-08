Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA0AC433EF
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F1B6113D
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347851AbhIHGsF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:48:05 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:21857 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347809AbhIHGr4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Sep 2021 02:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631083607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgrqHMqckbWbg7tiY0mJzIhEH7EBvTLAsM3K9OF0ZY8=;
        b=fSx0Fn4+HqkpngMOL/bdIaX1wH/Xn42xGLiDpf1Bjyn4UD5gIYQAYccrNypnsOIbWEMf1a
        7N8fIUp7wo6lvfkjEq+/JruYTo/But9Q4FPVwdZ6D/KDxPpllY/op9i2VdV1oxAsWxSSvb
        j6BqJ/BuwOR4adXaHOUe85LK7X2dnsg=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-QJ5Wefg3P4KHC09aS3JBvQ-1; Wed, 08 Sep 2021 08:46:46 +0200
X-MC-Unique: QJ5Wefg3P4KHC09aS3JBvQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WO/aqVCZtFxqD4iN+Nlz3YnubvHR6kH4c3wUMnVOXsnfHlsq0d4yQYiVm2VIWc+TXJb1cNSugMfQ06y5GXjYdA8q60s8pjJUhuiGQDnuSsoFcT4DUpdEOmbbMQyLttQNJD2Jc01rmGI9lnkDuhKqgbwph3YMHjzlrV9cR2X9DHXBX3fHTmuw3NkrGf9gjvNsR5gXCuWod6vlSqhLqovX/ELWB5JoNidn7cTMsEtZZRAD2LYjLHP+6YuJJkgY6o7mBD+8+gPeP8kpsNzj1UtOnpqYAWIuso9CTj2lkuPxHv4N61reprgHjQfEUdMvwvRA1Lmp8F/AtYnoccoFjR2uaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=esWZKb43zqjLWpMKpC+/12Yv4FlaOr4yTvPrVtM21w4=;
 b=cazNeeX6Dq3TRxdKNhQTazGsVtDfKdgLQRnHPtY1FRuu9Qg7N2bfIrv9a8GlSnre6ePXvSKyE/zueYnCQ0AiRvHgjVTz1gxBnAsjqqw8GcI4FW1UnqVrlp4P45sVo/OCdagt5z/ZnZ5OC3D9TVO1qUJrl/8BGVzdIFpooTf8Fb6EN8BneQvHfjO/U92YdANc9vwry7LGQ2Neo8TQE2wXiH7X/o/ECwCuJykGj/F0/dviN3IE6rC/gYOFz4Dd3bU90DCnDBS0SeuLirZnKLnW+f0y9JFKdKuGJal+X/1uikuwUI4+RVK298jqKxffT4oj7zeL7xjkxWfCw2jUjP17Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4000.eurprd04.prod.outlook.com (2603:10a6:803:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 06:46:44 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 06:46:44 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
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
Subject: [PATCH v2 6/8] arm64: dts: s32g2: add VNP-EVB and VNP-RDB2 support
Date:   Wed,  8 Sep 2021 14:45:26 +0800
Message-ID: <20210908064528.922-7-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210908064528.922-1-clin@suse.com>
References: <20210908064528.922-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR3P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::6) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (36.224.129.215) by PR3P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:46:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 171f2613-388e-4139-8fc3-08d972946bcb
X-MS-TrafficTypeDiagnostic: VI1PR04MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB40004B87EA83EBDCAB70C990ADD49@VI1PR04MB4000.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lc4EzPvhWv1l7OPNuyMEAgfpyHtSzZlFQGvdRhxA5Krcr/PO1f/vQsXrYjLBzr/zAsk5e6Qu0suKU82fGuJVrJUSdSleyPDfZr3EkEpS/gzx1TzMTn0bvGTI0AacwfMGuXrBa8B7hV+yp6RSnILRxPZ7Y6WT7bi0crBDoB3YK+iTjhrxek+WKTdH812t5mL7eXcqOz4VH1Jayo6Msm/bY4USGxRtGcMsxlm+8Okf7BB46+MxQB4Eht5a5bv0P5BWRYXJ/A0pwhlEYJUmG7WxebzowYLkX96jrAlR7gflHtGlzt1XwfzlON3M3zxE4/Z6X8TXt8V/8z/qgOkjk+cS6iBFzd8sT0kxXDz9opU/2PP64XIThhDzPv8jBMAdjvP7EmbI1XPNO0nFBn8w2uWlVgNlBf53sJogwb9+3sftU/fnLyCQoPn2jDtbEaJRM+DBBiFcaYgIa9TOEJ2XwEM3Ma3Bp5Zu4fwZ7ehGlWrJrb8UHJ/iDcL6gH34to8MufC1HSih7Y8qOzdgI6aDueJO7nJn0ELX1WCqbuJAyrffQw2JIfD/jcpaXeXRL6k1asD139nTG2ZM6Qgsf6Cy9+ZwQk/4Sekh7dLq3Iw40M0kg336Jahzg+/8d5okIhDtMNQtRagMwx+mgFPGIuB5fpYNsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(66946007)(38100700002)(66556008)(66476007)(86362001)(7416002)(478600001)(6636002)(2906002)(8936002)(2616005)(110136005)(186003)(5660300002)(6486002)(54906003)(107886003)(8676002)(36756003)(1076003)(26005)(6496006)(956004)(316002)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xfnb9ZE/Y7Ol8E1ott4GxqwC9/6UYajzdt3CvDDfsCY7zRIkDO3AuU+dBWGx?=
 =?us-ascii?Q?KeLraUV2BF/l5j4mmYMHJB2k2ccnVCBpCgjItYVpNGXp2/QMTAeEIOTqE3Dc?=
 =?us-ascii?Q?nrfT6N+xHLafgYZKhEfZ/BtEBpy5c7RBJcRFueKWHrmMgma6RuF2s4pImmwX?=
 =?us-ascii?Q?jXTylZ5Hg3c20Gj6ZQE5wCVFsnRoktU7r1iveBcMoOD0vsdnQpUo1A4OR7xo?=
 =?us-ascii?Q?AmxnOid6mvbWAEK/sgxHBErdYJFZ/ZVKVpNmRLgIdQDxDq7dHjugu63GTq1A?=
 =?us-ascii?Q?63iD24zElf582giX0Urutc8W/v+8bcssFXhwnBSQ3JUalWRj6zxdq/HFu9mr?=
 =?us-ascii?Q?GVynI3ZyeNPcFMXw24Tw+8T4dxBiwApMhzpIo4jBrIGnqrhBJkSoo67muhM7?=
 =?us-ascii?Q?K/mPw2GNpu4n6vQj/1ZBGKqdGQ/T1ppWmPL+GLA1xQlMiAUHyPTB6LVFEyij?=
 =?us-ascii?Q?S0JCJefFVxrAU+UMTX4c+QzVWW6IBALGwdDP8Rk0z/OxUj5UPhbrii8EwPZ5?=
 =?us-ascii?Q?rSJu3bjxcRM69O4rz0pgVWVRCpt4ODyrcm3TVb5DZbAmTblEg+ywjU0T6SO4?=
 =?us-ascii?Q?iN/9Dj5jX6UZFEx345RN7MUlXsXvfrywXS8DkUoXcECuNPIMaNNYfSlDGHtd?=
 =?us-ascii?Q?l3NzYFgnI6ct0ipmQOX0FY/BXiP5bFGHiLRLUvTztvECJZHd/U4c7kPH4+SF?=
 =?us-ascii?Q?IfFaXmfmF+X4nHhJT2QaPxsiC5xBURaAXwwuuEsKrZAIGna/nRqhGbEu5Jun?=
 =?us-ascii?Q?C9xmdIwgjS1TXKtcfYbRkWRj7hLKAF4M7fBNdhnbH1fwtPWFAmd0510PZPwY?=
 =?us-ascii?Q?AsKK9tgor3WokwMK634GugJVC701GHO7ZrJ5nni56zCtqMClnZNn22Gc4a6Y?=
 =?us-ascii?Q?Mx+dV94f5/JGg9IKh6fzYJhzI/CmYLEyZ1quHBbHEZlBl7ePVfwuKWTs3ODQ?=
 =?us-ascii?Q?bPsdWdzz+ep1d0i9ZLNlNIbHxfKymZsb77NqTIpaERqdDYYj2dSpL4JXOz1W?=
 =?us-ascii?Q?7dGOKagOrCth+m2gVbiqPVNW/kfVPgXRoJGoobMQjLRs7cr7wOEsaN9gN6+Y?=
 =?us-ascii?Q?puztsdB3Ea41qjGBKH8Ed5fgf9PYcgsQ5oip1xMBKtb3TjbT4wb3rFZ+3BJ4?=
 =?us-ascii?Q?npAe/UxN2sk5JIazqjF9s/tU8i0HXNdIxSgjqwbEh/rkeQ+afjLv2JW0f8GA?=
 =?us-ascii?Q?88fAIfCNpoS2p4LCbDz6N4s5upCPK1NJHHlEeV/BTE4ccDtc1o5WZ0TB49HH?=
 =?us-ascii?Q?NnQ6k2qi25Qd/XW7Rdl+NHX3/BycSVQGLsKMq0aNaEFhId7d/QV4abiKxXDn?=
 =?us-ascii?Q?r9GCXsPnV9kKfuK/KLPEgE66?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171f2613-388e-4139-8fc3-08d972946bcb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:46:44.2242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGzaReDwl3mXcUwqIwxu2+J8lqH9qhi38kXjn5lbR9kiM66UOL9WCTdEoIBNg1bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4000
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add initial device-trees of NXP S32G2's Evaluation Board (S32G-VNP-EVB)
and Reference Design 2 Board (S32G-VNP-RDB2).

Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v2:
- Correct the model string.
- Rename the compatible vendor string to "nxp,".
- Move the serial/uart aliases from the SoC .dtsi to board .dts files.
- Add comments for the uart markings on PCB.

 arch/arm64/boot/dts/freescale/Makefile        |  2 ++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts | 26 +++++++++++++++
 .../boot/dts/freescale/s32g274a-rdb2.dts      | 32 +++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-evb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index db9e36ebe932..0d4a18bd83e6 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -70,4 +70,6 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-ai_ml.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
=20
+dtb-$(CONFIG_ARCH_S32) +=3D s32g274a-evb.dtb
+dtb-$(CONFIG_ARCH_S32) +=3D s32g274a-rdb2.dtb
 dtb-$(CONFIG_ARCH_S32) +=3D s32v234-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/bo=
ot/dts/freescale/s32g274a-evb.dts
new file mode 100644
index 000000000000..3aec05de0842
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -0,0 +1,26 @@
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
+	compatible =3D "nxp,s32g274a-evb", "nxp,s32g2";
+
+	aliases {
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+};
+
+/* UART (J58) to Micro USB port */
+&uart0 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/b=
oot/dts/freescale/s32g274a-rdb2.dts
new file mode 100644
index 000000000000..ed3f23babdca
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -0,0 +1,32 @@
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
+	model =3D "NXP S32G2 Reference Design Board 2 (S32G-VNP-RDB2)";
+	compatible =3D "nxp,s32g274a-rdb2", "nxp,s32g2";
+
+	aliases {
+		serial0 =3D &uart0;
+		serial1 =3D &uart1;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+};
+
+/* UART (J2) to Micro USB port */
+&uart0 {
+	status =3D "okay";
+};
+
+/* UART (J1) to Micro USB port */
+&uart1 {
+	status =3D "okay";
+};
--=20
2.30.0

