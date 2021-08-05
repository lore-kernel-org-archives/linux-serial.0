Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ECAC4338F
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791C860F58
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhHEGzY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:55:24 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:49716 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238134AbhHEGzW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 02:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628146507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQ3sNnxHrPW+0NfPoOZXUmTpCXoqKD62Mr9gJOSmmRU=;
        b=SwmXJpQBByUAAP5TYEbnQJnAnfsQZxziGf+VxiS3lCp0U3wlzwz/nuLL+JXIWuNe/Q6JYR
        vqFHuUSkhhVh+2fmPNk+ROlbSH8jamS2EDMmPoqhCL1I8B8iCuoKig1T4LULYQNEC2t2Kj
        l2suQI+2jBbBnbCjHjasULiTT6LaCH0=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-nzQwq9hVN2WeBoLoozovjQ-1; Thu, 05 Aug 2021 08:55:06 +0200
X-MC-Unique: nzQwq9hVN2WeBoLoozovjQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NapABS16R6ap2YLFnly+1fX7uztH9mtRuAtJERQYfZE4VKS/hY2cHYWMo05Hl8ThNSs7nnZFF9f0UXag2rR1/32nRO6LaC9FCG8K1enJj9RkkJpdXIsMiQjEv4g/34GKACReFjYnco/yGX3/PITs9zh1GKwYjlqwngvdwHDHYOfzhYG4OSYJhRMBuruhNnRH2kk/HmlBER1w6hGY8hGSoRbhXubO78tE5/ZxgY0Lvr66IZPFdLArYgnai8P0ATdnKioFJTMdFQUILuZf4OsxPOETqYwdfWw8+sU6w2l0DbkHlmPtt16Cn2yFsve6Uks2VUwTG0VLrseZSB/2AI3o5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81yB69k1vG4wf6qDlHCwCoVh0suoz8CGiIPEt4LR5vI=;
 b=HDAhw1P6oJkRscYFU3+l6v+mu/TLGpWU5a1zN2yzn/eW9iJzTuBRMTZ2ExAj/y194t+fwmy0776yEzy0sGtQwPNalvOgtBRUjiI2lFMeXNc9VIbSrFxlCLSv409s6tfcUPGFZEax/AW7cbCz4Ojbu+cpBZuPd8Vo9dEI6oTkn91pawXYxHOY7kndMaEMyoEpG52jb45z7se0z+Br0/ACCVwuRfRmZINKVGgmjk7nDFoBxCbyHNq1pDUmYX3rr6YM2L3rHQLSbP5HGlenWU4plXryybdixkxd9XWuD9R9aUoR2EIz9f7NwMcP9PNg1BuhvcQMHLcWQVqmF+CrrxFCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0401MB2368.eurprd04.prod.outlook.com (2603:10a6:800:29::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 06:55:03 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667%5]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 06:55:03 +0000
From:   Chester Lin <clin@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
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
Subject: [PATCH 2/8] dt-bindings: serial: fsl-linflexuart: convert to json-schema format
Date:   Thu,  5 Aug 2021 14:54:23 +0800
Message-ID: <20210805065429.27485-3-clin@suse.com>
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
Received: from localhost (118.166.54.149) by AM3PR05CA0141.eurprd05.prod.outlook.com (2603:10a6:207:3::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 06:55:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22155975-0f0b-4e18-2348-08d957ddf383
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23689FC4B0A6503D55564AF8ADF29@VI1PR0401MB2368.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MoIkS5YxdR1Ap1chjNH01i58N6epMe1I9SZyUfiRLVn/qwcvu02KwnsIa/8ZYefuyAe3EqIZh/OYLk8aCvN/rBxni7ig2m+PG1g5jg799nlXB3BWiHtb+g7z9/f4KZm31vrBE+JsB5mIyUiTojB+3NWewh+lR63DGhAcbciQ/gxUo7xVuOo3OytOXyc5Ys+w6J5ERykVaWgQIA3myPSoDikcOnevxG5FdckKMiSt9duBNrEIEtcLkjsa1JT9w/dBRsl/ju740ejJeTK/4Avp9Idy3Tinh53WBmeSQrdYbEnF71Q+CfqQPkAGFmOieb2LaSgZhPniqIxo7h9/A8tZnuf2JMYCxSA+xajRFHLFEZBnwG3YSihH1PRawr0Rcvb5KRJIORvf0fJUU5qGh6AztPnS25VzUoN2sZC6AhHJG7mwrB2pRj9iyN2FO/Rikb0RgPp74l5/la33dOUwM7INA5icaHszLmesaaivD766n2LcKqns1YjhJ0gQOtn4YVV4wWx8r1JCq45z7a+VxA58Wp4FzUWfZtJNnDbc/Cx1lYP5kz94aWFvbQv40+Ja4elGp8bJZjWyD6b3YxXTXq4TJX9i9sqlnolCM1eEWDt3GIkZuytVuAIngLs32BDYgoY30twS5s42r4CFiYNKjDSzugcvmxfm81AoG4mIr4Cm7lw9VqGr9UYA0icPE7xn3tJdbHOJm0LtISI7DDZyfd2LmctNeHndwyKHkrnw/CKI2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(6666004)(8936002)(66946007)(66476007)(66556008)(966005)(956004)(2616005)(508600001)(83380400001)(1076003)(5660300002)(26005)(4326008)(7416002)(6486002)(186003)(36756003)(107886003)(2906002)(54906003)(38100700002)(55236004)(110136005)(316002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RJoFFTwqd8X1vu6r9FZzaJG6cCk0gIX16tm+wazGYzVGIMy1zkz/QUUA/kuv?=
 =?us-ascii?Q?RvljxkyueqmTj89S7tcpC4x9lxVgslwj9PFvf2XPBhZM8iPOeVihF0pYLGTZ?=
 =?us-ascii?Q?9SjJ2+AUi1Qb7/h5DqusCh4JJqQS9EqojaUn70PfW60TBR6qkbWZkxjzeKPH?=
 =?us-ascii?Q?bNErOZdmeXTQVUs/ukK23ZC+O4ALzWi7eLTPlSXNkXF95bBpAe5QSgeZeAIv?=
 =?us-ascii?Q?tlegWlmfYb57T+liAxVbYofr/xvRrQnhJY6xr6y59HU2MIDWoRysm+kaUpZL?=
 =?us-ascii?Q?renghX8Iioy01u9RxytftqxSFlehcpkAQ55QK+/f1r5TOCSgbH0mCJSq+Bn0?=
 =?us-ascii?Q?8v3UYixmDzhfQuAOul2QJpStga0sFAMUt+rRyUzqBBWsFaehIXwAAGD0HwEr?=
 =?us-ascii?Q?p1vw8yrdhJWIEzcw8Isqfs0XizAGAU1HasvCi97QHMB/GmdvMSHwOHqu5vnj?=
 =?us-ascii?Q?zRC9XP9K4XGHFiV7UN8WeLtngQbdi218iRuv7Mqh1grZipLjnwK5jx5tROHl?=
 =?us-ascii?Q?zNQEdxgcRjVW4nwELLAEbWSi35dcGVT8Fxl63potTvuwolTYJcCFCM4b0o9d?=
 =?us-ascii?Q?xz8TZQMNPmSxabV4jLFm1KYYsBHqadP9DkcE3A8yuXS8YhMRjWLGRHdFxHm9?=
 =?us-ascii?Q?8YvJSbdxjfWFIoCCx/yY1FsXj6369+OhAdQWdJm0im9oZvGDqYNyxakyLgvu?=
 =?us-ascii?Q?wd/0HZ3UFM43xaJfBKHmQIzjbYFJZWXWmgH5MZU4LGCejwraoSpWblCsHzUd?=
 =?us-ascii?Q?a3e6YqtZlv9KfHCJvvf55FDzjqx1uTOGz8fhzfaMoZhO6A1P674h2KUuN3W8?=
 =?us-ascii?Q?QIkE7Y3S5VgydgKgK2h5YPvfweoUzXRhzEm0QS/oU+e8s6osrQzw1MQqtJNl?=
 =?us-ascii?Q?wclSkGTVyHiZbU+b9lVvlUsL2/4SVczeYVW7/0HIOhZwhmJO6JQEuMJQQ3g4?=
 =?us-ascii?Q?QSOP7FK5TKP2x6q48T1viglgBv56s0ZquOYKGxw4KPkKSpKrmUUWYnCt57NW?=
 =?us-ascii?Q?mpltyZbmbj/L9xIfn5wYfO0NteN2QpVEJh0QCMQqWmVUK8ToOj08blhWRJSM?=
 =?us-ascii?Q?9nKFqyAXDcdOLoi2jVOP4mcFVE3YH7u3WnZH56tgDVFAuIFYJ8c5bCFNi7h8?=
 =?us-ascii?Q?3VKoDBKMCcu7PjTupxByjc7QnYkHMWiB+PTib/gtRq0Xo7infLaKm31IpcLi?=
 =?us-ascii?Q?86demHikBkpRqychfr6YNUMTAA5v/ylu23Pw59l6TZ/yzyXboEeC1aOSfLQe?=
 =?us-ascii?Q?Pad0f/I23sB/+gGpxgMXKsm0yGSTDWvqqWNKgx91OdUkw29Rguifeljue8lU?=
 =?us-ascii?Q?EUgqbaKVk7HsMUm1AUeGUtx6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22155975-0f0b-4e18-2348-08d957ddf383
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:55:03.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOB10xJSAW9pRj6+bgqUlecBvib0Y1LysaSuY8RiuwgFd6xHVkdKHvUH24+jyfSH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2368
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the FSL LINFlexD UART binding to json-schema.

Signed-off-by: Chester Lin <clin@suse.com>
---
 .../bindings/serial/fsl,s32-linflexuart.txt   | 22 ---------
 .../bindings/serial/fsl,s32-linflexuart.yaml  | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.yaml

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.t=
xt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
deleted file mode 100644
index f1bbe0826be5..000000000000
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Freescale LINFlexD UART
-
-The LINFlexD controller implements several LIN protocol versions, as well =
as
-support for full-duplex UART communication through 8-bit and 9-bit frames.
-
-See chapter 47 ("LINFlexD") in the reference manual[1].
-
-Required properties:
-- compatible :
-  - "fsl,s32v234-linflexuart" for LINFlexD configured in UART mode, which
-    is compatible with the one integrated on S32V234 SoC
-- reg : Address and length of the register set for the device
-- interrupts : Should contain uart interrupt
-
-Example:
-uart0: serial@40053000 {
-	compatible =3D "fsl,s32v234-linflexuart";
-	reg =3D <0x0 0x40053000 0x0 0x1000>;
-	interrupts =3D <0 59 4>;
-};
-
-[1] https://www.nxp.com/webapp/Download?colCode=3DS32V234RM
diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.y=
aml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
new file mode 100644
index 000000000000..acfe34706ccb
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/fsl,s32-linflexuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale LINFlexD UART
+
+description: |
+  The LINFlexD controller implements several LIN protocol versions, as wel=
l
+  as support for full-duplex UART communication through 8-bit and 9-bit
+  frames. See chapter 47 ("LINFlexD") in the reference manual
+  https://www.nxp.com/webapp/Download?colCode=3DS32V234RM.
+
+maintainers:
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+  - Rob Herring <robh@kernel.org>
+
+allOf:
+  - $ref: "serial.yaml"
+
+properties:
+  compatible:
+    description: The LINFlexD controller on S32V234 SoC, which can be
+      configured in UART mode.
+    items:
+      - const: fsl,s32v234-linflexuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial@40053000 {
+        compatible =3D "fsl,s32v234-linflexuart";
+        reg =3D <0x40053000 0x1000>;
+        interrupts =3D <0 59 4>;
+    };
--=20
2.30.0

