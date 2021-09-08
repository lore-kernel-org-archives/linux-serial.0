Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360BAC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193D461158
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbhIHGsO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:48:14 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:57348 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347786AbhIHGsE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Sep 2021 02:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631083616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7X87LDlLYd76YEF35hfuxw2T3G8cLCbt7Zyc0LG6go=;
        b=XeuM0feY0qyH5mG1gGuNZ1ZkbZv5uW7voyheWU8/1YgMXfvTLYv+SdMQ5PBUl17mO2BInM
        KexiCRw2xGMdcHPptNMA39cqOt1OTPLZSl3jAq87ObyVqHs/eKhOWZayGJAYP/9V9A0L8w
        KxIqDw4HAUaSRqpm2FOGtlul2bAL61E=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-q_5yquMNPYCYjbJ7bQG_8A-1; Wed, 08 Sep 2021 08:46:55 +0200
X-MC-Unique: q_5yquMNPYCYjbJ7bQG_8A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7IVb7NqBGhW7Sw+iLwNyj6c3Tts8IOtSAOcQM3XXs4sXL5YLiOJYK57+47TU40e64eus1458Xq+K5A3ia7fWVJ9dDal0dEEuCH4r4XxKp4ZdnfZYH1ohbGgCy9k8UytwiNBRklDOcS/yOxrvUpCyK8awYfK94IFjdd3U2ZgbA4xObNJiqvrgPf9XVv5QHUkZemqMfyETptTpO+6P5FyofbpvIxu2O5d2vYWcXKrktse/+4DAznV+eblmPlIvHll/Z4hn0/hEi83I7EPYRwE9YEv/w8teAj26N71zJW9ZxVJvgcr8hcHqPIWeHcFuYfkib1otGKU5duy1XOXQjlgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vHER5H3QOvEjJKfezvjaLQh/BvJAynblwJASxw2/21U=;
 b=kuPm4Y4xm6bok9RcsFfTjU4b2mucXtkQ/4hFq8obd+CTv7jSMoZe6p5W4DxAkm3rx+pskDMxPHtTWG8fuBNi8O6+0g7oKZuUf9UnaLiHldK++RC3HCdQqyJJseHxkUnE34Ak52H9hPzFunNzN3/cByna7/VPGRZlY7kUmZsIKdOwQk5lEBftKdeBU7LPLnD9YHvP0uKCTb+WQhWSW5sq3Z2RTEc7nZNY7vB4JWmw/TXU92u0Z5rKqnoKOdNTxyKYzn50tQ87nKY4id8dWZYjdJFk0lGnVCgREqszyVVVp4/2KRfIqGTA4JlbsGN+ci8ByAkhQIMI8FVMpTLOezBRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4477.eurprd04.prod.outlook.com (2603:10a6:803:6e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 06:46:51 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 06:46:51 +0000
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
Subject: [PATCH v2 7/8] arm64: dts: s32g2: add memory nodes for evb and rdb2
Date:   Wed,  8 Sep 2021 14:45:27 +0800
Message-ID: <20210908064528.922-8-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210908064528.922-1-clin@suse.com>
References: <20210908064528.922-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR3P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::11) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (36.224.129.215) by PR3P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:46:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf6a7951-d790-4d61-aba2-08d972946ffe
X-MS-TrafficTypeDiagnostic: VI1PR04MB4477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB447755CE2A3B1D5A745BDFBEADD49@VI1PR04MB4477.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGR0q2v0dC6781iNttwz0s9c/yVuSjY8YV2kRGtxLEXvQb2OeTPOLLKs97eCH4Zy47132xJx5OdutBtlGP1z4kvVCIHUJxpMp6H9/nwgr8yF6JpsQf/ND5uQO9ULNu+ITqb9XwhTd/KFR6YvHdEM/KX0w2n3iy1Ixkty0Gibq6s8/T0bl/pqDeN92NTLl5umqMA0sOwY8EVnYXhm/JtEjhb6ZktufZHvcMbZABvQzkgVdLULxhZdiZyjyiQW160dGTNk4fodQOWECjKw0enwHt8jz/F+VJxak15pymSAz2qwlvhRhvHmuw0y7rh9mtAl4TeZnRBo5UGihyEQUHLmdFDhUKTQGFHwwEvAbmMFO143BvG47kFyC4hpKsgkO4quEPZ94lyAMKb12FhqXLk4HdvFV63cul4+cI2fphURf6qsVsTmAUHtBfK6kgy9bHqzWIO5ShwFFaDe4LcTnaKS+aKPAAmoug78g4YoHYCyAblcngpAD8ZXVttRzJoSASHx9MPhm/n5qF8zmMylcScUvAFGVgLfOteRi00I51MDlyYm5cElB6SpCZAlIjuk5Ql8MCd6Dz2usD3gqDu0has/2q1BaLg/EHxR67Cg3mS1NX4369CB+d93iOc4rejQ9NqMKzQllDI5cjKQW63Q4LdxTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(6666004)(1076003)(316002)(956004)(4326008)(6636002)(186003)(54906003)(36756003)(110136005)(5660300002)(66556008)(66946007)(6486002)(38100700002)(2906002)(7416002)(8676002)(107886003)(86362001)(8936002)(66476007)(2616005)(508600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/AuwP5Rh0a6QMKje02QOqaTatdhmI3tDYMP2hx0LKAE5czbkS8XCt2pSZsxo?=
 =?us-ascii?Q?akfHi+goP2USFmMR+ogsafvDRir/M+WM1tefwXTNkJNdQlOpJKDLWDomIYvC?=
 =?us-ascii?Q?89pVioHocqPSKCEH0w6U91M18CS/84DIN5vd8/GnT8LeHn06fK8CKciWEx5O?=
 =?us-ascii?Q?ZLacOrz59STAREbzG6FyBIy0QgRkSY7iyNaxoAasM7Ydk26ruBwhAe17Qz8o?=
 =?us-ascii?Q?69Xsaaa4D55x9DUL2BArEpifNmXlt7z7VWqeD6qzx8AFLIZknvJHM95uy+C7?=
 =?us-ascii?Q?HzdZfGAKmNVRcrvr3a2jyowZmf253lfDjTPE1kL7sQq2hVad3Cxi8h8ucSHU?=
 =?us-ascii?Q?0rW+1cyqTFPiC9ANtJfy1sC2E4p81hsjbu37ZMpYWz7bZ5AABAyzzPlWdb0P?=
 =?us-ascii?Q?yBMeJcr482A540u8H9dc0mmAjs5p0Hn8VNmlPOaMRiQOktVNuR6bOITBT9K7?=
 =?us-ascii?Q?wOwwi6Wel6m/HGUbt2omvQ+rqTjbX8g6Kg/2yju+yN4GlbqXHt9TYkycnHRi?=
 =?us-ascii?Q?Ya3RMI8j5tQRiKVCseFainnnKTjH3qUn1T0ErFJ4qEZ0z16Ag9II17JnNdOW?=
 =?us-ascii?Q?Bb6Wg2lsZfshj+sMBn7V4l+fTXpralC/KpYD//sNozO2EZj0GdZkF3XTXTqA?=
 =?us-ascii?Q?8XKHjBE8mQFzAb7Hn0UdoaiuIgoRK4XQ6g6Z10ki1VCHiO6xIWteqXGNyXY7?=
 =?us-ascii?Q?26JL4W5bZqym3veXVLp3+YDnl1k6gp+zTHM6VkKxXXiLEhZM6mTaWOUGZLnf?=
 =?us-ascii?Q?Hqxg0JRZddmKgtxn81bKnjpVWTkl7byvz5YGiE0dTMTxmmwhfJUBdARjkcTc?=
 =?us-ascii?Q?HjUI1daIUjp8pTW6/JtFHFOuGRZ58MPg6Vz6mE+/oEX7fUSz8+F/8SU3IAQY?=
 =?us-ascii?Q?W2VlAHj7mwlV7zMTwL8BdKwwwPAKt9YdLvfClnuHJ7x5sfIClxIW1sXfWkQC?=
 =?us-ascii?Q?/iq7njsNjQP06WwZw/VftjuvWBcc0XEXwBnUKgmWrSqkzUVoxIxat8+d1nJz?=
 =?us-ascii?Q?tU+uHfrLhOq1MFJKGPdSloMMzfhI6yrSGiUbhQIdcfYbmMjKcMgKuuVNUcKw?=
 =?us-ascii?Q?E9nJJ9yGxSUNHf580PlTVYcmqBH/I2Hs1k9SuTQyycOqMi0MU9mG8k4AXNHj?=
 =?us-ascii?Q?ria8mbQ/n51PhbMbR/P5lfOENwH/AAJaP+Ms94E8Q2rD0iVkmhbZZ6DZcXU0?=
 =?us-ascii?Q?aSGnQaIzpJUwotnpzFLvJy2R4j7Iu9VldBOrNL7E2akGrT6gQ2S68CGI35dl?=
 =?us-ascii?Q?8iRDx8OIqJJZeiNtY6wXUytw+0X7qUxtS8Vjx4Z6Yed227rQkamoHFqstOAv?=
 =?us-ascii?Q?BiTMzZzgGAqqGkO7nvfgIgno?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6a7951-d790-4d61-aba2-08d972946ffe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:46:51.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkv2B5q5+yuMM9XaLDIHNi5XcahGQR+8kl5IUV4XFROoSh8MpU7AsL0Yvsu/eWKf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4477
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add memory nodes for S32G-VNP-EVB and S32G-VNP-RDB2.

Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v2:
- Modify the patch description.
- Fix the copyright string.
- Adjust RAM size comments.
- Convert reg addresses of memory nodes into hex format.

 arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 8 ++++++++
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/bo=
ot/dts/freescale/s32g274a-evb.dts
index 3aec05de0842..9118d8d2ee01 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (c) 2021 SUSE LLC
+ * Copyright (c) 2019-2021 NXP
  */
=20
 /dts-v1/;
@@ -18,6 +19,13 @@ aliases {
 	chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
+
+	/* 4GiB RAM */
+	memory@80000000 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x80000000 0 0x80000000>,
+		      <0x8 0x80000000 0 0x80000000>;
+	};
 };
=20
 /* UART (J58) to Micro USB port */
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/b=
oot/dts/freescale/s32g274a-rdb2.dts
index ed3f23babdca..e05ee854cdf5 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (c) 2021 SUSE LLC
+ * Copyright (c) 2019-2021 NXP
  */
=20
 /dts-v1/;
@@ -19,6 +20,13 @@ aliases {
 	chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
+
+	/* 4GiB RAM */
+	memory@80000000 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x80000000 0 0x80000000>,
+		      <0x8 0x80000000 0 0x80000000>;
+	};
 };
=20
 /* UART (J2) to Micro USB port */
--=20
2.30.0

