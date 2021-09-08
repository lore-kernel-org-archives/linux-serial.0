Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FE0C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BF061104
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344915AbhIHGr2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:47:28 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:31498 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345785AbhIHGr1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Sep 2021 02:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631083579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyZV9JgejIZ6nlKeHARY+ZcZgqueiibMQQ3iBeKspd4=;
        b=PrVzPMm46lAM6q2MPm3ZiNJZODt/YpHNzcphqLLnHh+jC46x3DnNvRee1fPEsozp55gqEh
        5JV8jKdcE0e0hcvBoUa0ozCZnAxo1liSNNACMrQjkDJ/QC4lTy/laIE9pwTdMGEZyJBmhb
        +Cy1JrVGfxx0mS/wJZechhiyeitHK1E=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-6Dh0eDEUNu2uxXX_MxNdxg-1; Wed, 08 Sep 2021 08:46:18 +0200
X-MC-Unique: 6Dh0eDEUNu2uxXX_MxNdxg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpxceKW3mhKfvcgvrsm/fSDJ8pFfpQFcQZKq5MaZpFhZTQpfpjy/fyaub1d7okAEnyxlLK9kyuLjWChLGjs5EsirdfgPDppGKNKDwT1bszCkJfEtl5bIea5hV/PtvaDdiZR9nlwN2eW91wkvhyQ5U7ZFMAA+NzUO/5KhCdVL0dSH0p/Cl2NxGyloURIDBDFhdoKNAb+xMkF33dFZ0jVZ/Ag6hKm+wr40xGJsRkSXVHsZb/Ed1D39ZGu6erCKLQ30CS64KEsrqYoZhFbzthiiv9g2ELiwMb7Ys5unJQDVahPPfkMZwWTzmTuAr5kpQ9EwRFhz8tt488bCC5yQGEzA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5IPhH0o/YMZZyYJEY8b6B6yfHpqxvcVUWCDTpkpdAho=;
 b=LpmliTiUvrETJP24XO6mx9x5enLkhz7c3Xz45DgT5CzbRt/JigWoJ6kIa01ucBRVjoZdVtdAjGSSqMs8HJDMKKwljQGujwAG3DTD7q4cp9h7sJv5Btkjjre4ab++LJ+gqICSGwDcDuzvCeUmjFtQ2x3MNhPxWd4UNtSN9W43mFmf06mbkHMR6maJ6pWXRG212JfyzOLvEYPIRBocv1/0iG9d0dcVgeJdhdDdRcWfnYhHqDS1igC7CPunzvVZ8HRNGQRrNyvZpMhKmURnjeIgpq+K52pOG7inLHvkkJLsS77YfQ7uSNAsLg2xVUojBTvsRYraKvtXngfDyVICakoIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4000.eurprd04.prod.outlook.com (2603:10a6:803:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 06:46:15 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 06:46:15 +0000
From:   Chester Lin <clin@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
        Larisa Grigore <larisa.grigore@nxp.com>
CC:     s32@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, catalin-dan.udma@nxp.com,
        bogdan.hamciuc@nxp.com, bogdan.folea@nxp.com,
        ciprianmarian.costea@nxp.com,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        ghennadi.procopciuc@nxp.com, Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH v2 2/8] dt-bindings: serial: fsl-linflexuart: convert to json-schema format
Date:   Wed,  8 Sep 2021 14:45:22 +0800
Message-ID: <20210908064528.922-3-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210908064528.922-1-clin@suse.com>
References: <20210908064528.922-1-clin@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::23) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (36.224.129.215) by AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:46:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fee7328-fb3d-4b4d-27d3-08d972945ae2
X-MS-TrafficTypeDiagnostic: VI1PR04MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB40006E987720F30BECCB5C02ADD49@VI1PR04MB4000.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRMFom3Sm9RUoxYrMcSjMBqiDWslKtTJob2Gys5il/ywxhM31kc9Z1sqpOADQSJ7iV2K5yoXYhWv/beS6CAKDAPJAN6xYXZR6syq7fET3artG2JN0MPWC/0rSISogtg3ju/u53Q+vEyibm/gu6KR8gof57qfsTkLV96QzFoGkWUuIXO26Kmeif3P/FZs+ExdVqy/l0kHhc3zXCItA82e4a6ufaAXOKZAvpA00HxbZpOcGHqPySOtFz0A4VkFTIOnFEJ19dyLVT9K8W/y36Ze2ygRCouRVf9j5Of1/nHDn3Qn5DD4A02yUafyaDdg2Yh1GUsDzO/bVpMBqSJrUvQum3p8/daKIWNjrHygITO2cqWiXs8i6vP3W8/P+XG1WlPWxZwDpRIcasQOcJHX9/7aU0kuZdzGcK9p/XQBcxCHe/XmGx5RZU3WsU6OP4F0DP9E3BXxX4QESstBv+AX4+BX3MbnsoItPQo/IzHBwZ70HynRjc68+5OvRjeSu3YOWO29cLDvgYtucAkXEIjqxeTafJ9G558aOSeUWqPN1kWHmvT1RQGMiqfDbRbIyOK7IQYUibIu7OoDPJTfcb8BtxYJJ9uPNW6xjt6hiG167XsJQJYEGGHAC9WTL+UV93UGhJAjUzVB5/j83w41ZwSP8vy85Ii9c3asEZaDzi+e44sFsKh2g4GwETxPzFmw6cRuVNk85njsZ6lAc4ziypesjB/2JLHPk3xSSNBExdvskFERkPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(66946007)(38100700002)(66556008)(66476007)(86362001)(7416002)(478600001)(2906002)(8936002)(83380400001)(2616005)(110136005)(186003)(5660300002)(6486002)(66574015)(54906003)(107886003)(8676002)(36756003)(1076003)(26005)(6496006)(966005)(956004)(316002)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ruPoeT8rmZgANwlInw5czMV1aokX9W5GjTBNS066vfw0VgQV8T1Akq98z295?=
 =?us-ascii?Q?YDKKoQcP54o2t57WkAjnM7v1RnUFJ8k7+wDcBCFJeAfA6uyUGuL6vJfjTVkJ?=
 =?us-ascii?Q?RpzzMZMgPXq0/CiUFDxxAKpccyNlQNBWlRJLVeu7KxGyVzTX29IcvJfwBX9D?=
 =?us-ascii?Q?r40cmc9jFUl0KOT4v5kAofvzwAyL4ouMW2rlfCHFX04GqIcvgLtHrdHdK+DM?=
 =?us-ascii?Q?SQhSqWHxrDE+KgNPz4BSh4YRuJ1j0B0HStX6mGVAHjDynIwT4cLvPScm73m/?=
 =?us-ascii?Q?B0pyi+NybnCAAA8AABDsa1yd4ELLhmagCwQvj5CtG9f01klChY0xewORmYAW?=
 =?us-ascii?Q?BN6mijyScxqFuom34vqTfRNUG7et0ZgGPcXQ75G7+zWQsZxsNGBDpVwTqlin?=
 =?us-ascii?Q?tGxscCUAjw1SOjYw81/xPa824oRfbYsjYJ4ZaYnfYHU206ZifnxpwD0lZ6Mp?=
 =?us-ascii?Q?ujyXl7XX5w2yHMZBiBlSdzjl/Y8/lO1uNzIU90sPZtYVC54Q/85/Ku4SlxSF?=
 =?us-ascii?Q?ssTc0cKx6K/BiCNB9oBiONiCp6QAsfYVosixJdkmGEJrDTwlNG/ZUm5JxCO/?=
 =?us-ascii?Q?30gipDLzdnZG3utCRzvuwljNM33DB+zKZQS+wYr/mQMibIWtRQIO2/yb1gx2?=
 =?us-ascii?Q?uTZt30shTkRBvbdoK4Gydb9RFSmgeWjBhApDZmd7mx03RihoHnyw1Fc+1Pmo?=
 =?us-ascii?Q?QHum+YEdrTGPImREskq2FoXQ5V52uuVDMzdilURyYxrWffiQ1pZT94ikBz61?=
 =?us-ascii?Q?cPiEym5D3oj2fnme7+NDz8mKjGx5I4mgQqvOtg5tIBQXyIeRrfFcFNoz5Ztr?=
 =?us-ascii?Q?ZDAMsk3syssWe6P78YtlAOCD4RpXEIf10v4MipVpIIDQ379w9U+Lr7qkN5Vj?=
 =?us-ascii?Q?Z6xAX1uC7g3KlKqiJi4h2xjGXEjW9KTolNu8iZQHnsEr91VFTm1Sb3sC4tih?=
 =?us-ascii?Q?XKv4ywhl7W1ckshcb0eayzdwqAB1QMnsRqR85IJVF40156P9HlbvZEjq1e35?=
 =?us-ascii?Q?ioKgL1GFC6vvSUyX0Zu46t/IU0wnWvLkMHLaeyXa6WDmwJ0/+stW1iV2yLGd?=
 =?us-ascii?Q?9sNF7AinIUBiLoEHbuRYRUBLm3MXvTONF5oQImn+zEN4/3Fv/4V3FAqN1Tlk?=
 =?us-ascii?Q?sGb5QqGNg46/YfOrMrcEtmcDlD9iFgAmDCtRog/5uAKv4tzH8HrfQH2nkt1U?=
 =?us-ascii?Q?fgtDwy9jtD0H7H1U6Twi52QBpgk/apiyTZ6ouPU3m/nvy9bgrO+qanpmmthD?=
 =?us-ascii?Q?68z2zr+jJqADKa2X/8/MY6143kHybY4yoMdMeBafMGPaCVy+PAs8CCWi4Yi7?=
 =?us-ascii?Q?vkpKFhR8HaXcFhVSz5/qZ12U?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fee7328-fb3d-4b4d-27d3-08d972945ae2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:46:15.9260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2nnrJZOfEFb3F2jbFEDEN6k78vA3XYm9cP8LiqSSISHybEaDc5BsABSK/bMc9sS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4000
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the FSL LINFlexD UART binding to json-schema.

Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
Changes in v2:
- Drop the specific description "S32V234 SoC".
- Fill my name in the maintainer field. I tried to contact the authors
  of fsl,s32-linflexuart.txt but got no response.

 .../bindings/serial/fsl,s32-linflexuart.txt   | 22 ---------
 .../bindings/serial/fsl,s32-linflexuart.yaml  | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 22 deletions(-)
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
index 000000000000..b6fc123e8375
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -0,0 +1,46 @@
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
+  - Chester Lin <clin@suse.com>
+
+allOf:
+  - $ref: "serial.yaml"
+
+properties:
+  compatible:
+    description: The LINFlexD controller in UART mode.
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

