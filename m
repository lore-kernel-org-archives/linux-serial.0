Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD2EC4338F
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDED6056B
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbhHEG4X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:56:23 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:35519 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238269AbhHEGzn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 02:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628146528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCCC9Syx6UuJsaIS43c31Wz4vCLY3Y5n1wxKYn8SM4E=;
        b=eC6PRb2IseinidN35Fu1q4EqAj0O5h/LDamnGy9fRCXWp6tAFau/LW+Qhxi+q8gwZ7a/31
        V4cJGrll+ALZuDlMDhvaw8g32DZUijcGS1/apoJS3rV4rh+2WskUUfh/vveFzVwuzdJ7NI
        MYe/ajaOe6T5Uz8HZpwH+PP29WDlMwQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-Vahh3s1uMJmyv8i6MOS4ug-1; Thu, 05 Aug 2021 08:55:27 +0200
X-MC-Unique: Vahh3s1uMJmyv8i6MOS4ug-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRQGvLU76L07xAJiIpJU1WIiUm3RTEYqJzpojrPkNwMvuDSMYjNEhKe9cI3+GndNs3FCF7FFFMKC68U0PODUWvFnIfFGDJJFKXDpt3tYP7a3UUcuFnYGb+DqGikW6ZZcSxVESVSB3DnTDxLEp9lgjjfc1Yopyz7F9zqBKGPe34zTJvIbjvU/QRXBszlNrEjXe/Pr9C1zZgaO7NGoJ5Tg1GlWDWCtogPEYVkbcYLIhYE5JRO+dLx4X//UjSdy20F+f9t/dIfvZOKk0o+4U/ioNUiCjNhNjKGf0XETdjCF31xia3FIfdJhcTmpQBPu/cNwyPtRHcixs20tsVdQotT5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxlE0toVtsEVgBR9KurVJLbFKGuIuBanUf78w1pErgQ=;
 b=Z8X3Wruhz+RJtQITg05wspsvSJUgSvAlBEDA0px2/NGvX+w7VueAaJS/LBo4H/mu2I83HXb6dVYJsWjPeM/FN4GaiGdrdj10Y/MQFoNzuFIDhlJeh57ycf4IHZap3tlfLiHe/tz++fbfI0p530SmhJdtJIrwOMHjEHKUzcnjcFmF6njytmxxTbnzo2vfi3r4KO2Ik12Mttr+wJyr1E4mUyD+t3+XbWihw65owosNmyhyI5Ox21cm+YzbYsccozswjEVcFWtGRWc6Do7yOBNojlOQo2w6r45YF8TWmeeULJs6ZUrEqZvFEqdbImJvukuf6/z67Pg++W67w+G2MABJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0401MB2368.eurprd04.prod.outlook.com (2603:10a6:800:29::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 06:55:24 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667%5]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 06:55:24 +0000
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
Subject: [PATCH 7/8] arm64: dts: s32g2: add memory nodes for evb and rdb2
Date:   Thu,  5 Aug 2021 14:54:28 +0800
Message-ID: <20210805065429.27485-8-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210805065429.27485-1-clin@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:200:89::27) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (118.166.54.149) by AM4PR0202CA0017.eurprd02.prod.outlook.com (2603:10a6:200:89::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 06:55:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42082391-6b23-4155-26db-08d957ddfff5
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23686F31F28FBE26F184E027ADF29@VI1PR0401MB2368.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqYFzWbged0ieRmWnfb0bU2lTelTqJCV+L/X3Sqlq4OJld6i0Qi7XEBVzZXjJqGmjgf2hzCmLaZR6g2uS8mY1Ap4oL4aQh7bnNPPcNjCGZxN7RrItaxDREkF4KgNsI5Fj0Jv8hp4b4r6O7QVx1pURe5UQiNtCjqd9HMB+ImVha7PABZccN2cGI30JmcuwXsX2r2GygHVUkPuImqBqpXEGFlwaLAGHw+PR3xuiDfzZhnZICxsDcMVUYwRLllE6nola5P426PhM6xBD2B7XIIMWlfxw4endASgzoBfySwIg8XHjjJ55fkcHCrT6KzaDj8EvASZvoWqRnNh5hUtxbw0+uMcxKuxLkZxCJaufP3yJsVpmc4cwnzGkCMmY5FPP1EXIUh6G9X8JB4xhhfbsV2hYTRcWm/VFCiGsIh7cSeEJXy+XLP1x3CJTuBEqlgSXF4G1hpYYCZmbRB4ZgKxUCrBJ61ix/hEtu1n02renBOj9lj2U+OPWh47c1vn5aicFTPR34tt+zh6CYx9qNuesw6Am+VvZq5Et6HXo/mjTShvXhk2Vt0tFR1SBj3k5GEAtTVVkrLDsaKOGpvf4NFRhiGJIGONVCOiXpDWHabSDgG4uCoZl42ItJX0bB1hZGRMKn04VyxXNqklSjVIfW1SPZ53Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(8936002)(66946007)(66476007)(66556008)(956004)(2616005)(508600001)(1076003)(5660300002)(26005)(4326008)(7416002)(6486002)(186003)(36756003)(107886003)(2906002)(54906003)(38100700002)(55236004)(316002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LnFJvhi4Asbl3FrP8xeecf9E2+ZnHMu3ymy86j0Pxt9iAvCcOa2kAFDgRTGm?=
 =?us-ascii?Q?I+Q5Vxc0Jn2yedTo0S1URllBBFPBffT4Jma220V8X39pDtpfIfsyXJeWq59M?=
 =?us-ascii?Q?+g3PBKw2eaykmZOyY2B0D7WlQG5oCnHHbPGn/yPVufwT9PaYcat2HgxjJo7Z?=
 =?us-ascii?Q?myF5gyi2yEAad+nEwsj6gkR+l5qwCOU9bJSg7WoPSPb92b1xVdiVF68R8PbY?=
 =?us-ascii?Q?Nuo8sGy458olLvujvs7Td/XLba8CsPpyrSeoDlR0Yd/yMUiyjGUJEb3Civ2i?=
 =?us-ascii?Q?VQnbZXyRBMs/UDPNEfoQa7QuswvewAh7DAyla3QgSgMf+HqI0jt3KgmpbC62?=
 =?us-ascii?Q?VPOWr1dGpYXbGgVks1MzyRXQPkt+DHuyBAhXqxFbSXZDZtASHBr5K7IVURbr?=
 =?us-ascii?Q?GgVaPA63NneYxIHhiRpKhci7xg9hKXZm9pYyGZhKq4bxzCgUf4A3rZXmFLqi?=
 =?us-ascii?Q?yAGhfq9WpOJ+gNloalyq8k158LZwdrdGTlx0FqPUAUWwT3G1OBBi/eY1JanO?=
 =?us-ascii?Q?wqtufpMXn03nnqwWTh7XqbnEA2i39yAg+2dbpTS67OWQJ4vEOg8yuIM1HIQl?=
 =?us-ascii?Q?zbzA+9UJEZt8zi9jzmm5Qtd+k/3FhwtzMIwifs7pEd3JmlOMH9Ft5VuKZHdz?=
 =?us-ascii?Q?I4Rl66MwqMwDvOoo/c3XcZNDI4vOD5EE7tkBVYUnyMmAMq+ABaqt4J51O2s1?=
 =?us-ascii?Q?QzNJb3UKrM4lZSqIwm3qgCoeenI1A9f7cY3/zdc6I3yF1tiBq1MqBHXQafBJ?=
 =?us-ascii?Q?0yngveWEAc/gZjXTIBMrpq7tLodeMX7Yf+1O95vC3pRAfFF6j8FKIsc10mJy?=
 =?us-ascii?Q?fol/aRK+0HJB5C495Ng0jqiz0M+OKKiLOfy/mFSfGL3O2ZAojRpbwYDEz/ye?=
 =?us-ascii?Q?dsO4jW4nGzjp4A56xG/9XKj3AZ2usI2nm0XUw3sfqQ4Tn1eYfCJtKGkLyD4j?=
 =?us-ascii?Q?lOos5FrQJM9Jg8lD5ResG82+Ny+oBJLTXwLnMwmd+/OXCsRogu5smii28Vn6?=
 =?us-ascii?Q?8HHQBg9+mga+OP/blZKr+Z+IxInYuVhn5HJgMO64MGQr/O1cAgS6NT33dmcN?=
 =?us-ascii?Q?6cML9flhCZ9/cuIcm7kCg5yNXbLmehywbTtm8VPjolT1yFO5SyawforAyYGz?=
 =?us-ascii?Q?S8eOqX8eiKHuv9NBGA9+KG/ugRzQb+hiOK32aUs6IhoscGDVp2R8iKFAXYXm?=
 =?us-ascii?Q?bVqEWxNQNNnriR+REEWB7TQt2NGnYF8qZWCIf/jm74UXnZNDHgkZmfYh7AZu?=
 =?us-ascii?Q?cOrwuW77vMIRxCtzcz7zwzYy5P3B+mjO9b4/Sfv5vsh9zG1FsuaEEY9OO6f7?=
 =?us-ascii?Q?4luQikyL9t3868Iwc6KAsLQc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42082391-6b23-4155-26db-08d957ddfff5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:55:24.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVleUQphznbvLyCnfMV4O8Pb0ZTS7sqxu7V9cxScigH7TPz5dlCEz9lKy9HBSEfw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2368
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add memory nodes for S32G-VNP-EVB and S32G-VNP-RDB2 since they have fixed
RAM size.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 8 ++++++++
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/bo=
ot/dts/freescale/s32g274a-evb.dts
index a1ae5031730a..cd41f0af5dd8 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (c) 2021 SUSE LLC
+ * Copyright 2019-2020 NXP
  */
=20
 /dts-v1/;
@@ -14,6 +15,13 @@ / {
 	chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
+
+	memory@80000000 {
+		device_type =3D "memory";
+		/* 4GB RAM */
+		reg =3D <0 0x80000000 0 0x80000000>,
+		      <8 0x80000000 0 0x80000000>;
+	};
 };
=20
 &uart0 {
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/b=
oot/dts/freescale/s32g274a-rdb2.dts
index b2faae306b70..8fbbf3b45eb8 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (c) 2021 SUSE LLC
+ * Copyright 2019-2020 NXP
  */
=20
 /dts-v1/;
@@ -14,6 +15,13 @@ / {
 	chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
+
+	memory@80000000 {
+		device_type =3D "memory";
+		/* 4GB RAM */
+		reg =3D <0 0x80000000 0 0x80000000>,
+		      <8 0x80000000 0 0x80000000>;
+	};
 };
=20
 &uart0 {
--=20
2.30.0

