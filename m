Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC1C4320A
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768F860FC4
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhG0WSR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:18:17 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:30900
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232576AbhG0WSO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Jul 2021 18:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJjvg+MFalWPKHQYIO2Z9/jvagZssO//WL09/8T/qHBRTxvTDrQedndYXkYR+d9xwhUgzkwjQKodzRypLok7NJvfB6IYmLJtdA4EBfix7L11n6SkH7NPbvGbgppu9kUutvfRDJFiU15Qum45QMpjNBxmtDcv//mgtmZx//U5qgmaBFa1h8x+xggNAnuJh+xO/uCDhU/zdUBh371LludaDL3TLEn7a+XSxXeqlZfucdrO7EcV4ZjWTLYULgAUsM3A0sLTTNCoJE7l3tZsRdX/icYB3sQYf/c6Rc9NkKwUkucF39U7yYzZ/ZQ8BOOdN6jhCD6ATpZq9mL76Nc0sITHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63Emod5IjbBcRU0VgxADnDel7Ys2SsGRnWAwL+V2pm4=;
 b=Ynnay+BfYX11FSR1eWp5kVmseytJSPXEzv1Skvq2dhr791tnWQGUj7e0nHljeyf9EbrNE5QTc8iv9ufHBSe7l4rYi9FiC0yYCILgSuCXF7vi908vUVxFg+8OGp5RS5cSQItH/HmzY/GR8Ikwl1kBo+awl7VYHxBvinzaXijKNLmUNGKWKIzz4TooqLYBUUAcYpe4F3A5Ae5e7IpwHgv7xgdIHHh7sTfAfKzpOBZQsWCiGAe6X81MDonuNzXPoCIJLYlB5Xduhm+Tag1GAux+DStiaGg1FUYbWs9EMRGpo0sQspo7AZGiV8gTHyrgLhk0o+GfOYh1rNr0LHfOxvWvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63Emod5IjbBcRU0VgxADnDel7Ys2SsGRnWAwL+V2pm4=;
 b=fsL0fpRJqaVpqGWfwVIvpdn7U7HsjKS42XiWDPK1+z/1vEXTGHu0STAAVnH1jRNWkME22lJNg3tZljOSO1LK8r6M7ySnBkoFIiDHMLUBtdDuZLE8urrd6qntlGBcGWqCj8oVhFXspt52I0JtS7W9Xqn2ph6/yarIsQauTTqvL0Y=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5141.eurprd03.prod.outlook.com (2603:10a6:10:f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 22:18:10 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.032; Tue, 27 Jul 2021
 22:18:10 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: serial: uartlite: Convert to json-schema
Date:   Tue, 27 Jul 2021 18:17:37 -0400
Message-Id: <20210727221740.1997731-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727221740.1997731-1-sean.anderson@seco.com>
References: <20210727221740.1997731-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR06CA0008.namprd06.prod.outlook.com (2603:10b6:208:23d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 22:18:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2938bdc3-c145-4bad-529f-08d9514c6ae7
X-MS-TrafficTypeDiagnostic: DBBPR03MB5141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB51419B640A3F2B01DC590D2096E99@DBBPR03MB5141.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yimv9n/ndMfbOVUsY7rx0OSP8DJZLQYqbgsSgYT6NLHlSi2/2gdpmgW/rwoYqv/iu9QO8Jhkwl6jBkUxvMzWSUHjpheBxM8AWVbO6gN2v4OAw0XfEFOgXchQ61aHW+H+qsl4y1my8VeOknZ2PXgyIjx0UYOrRZ6dD1JQ8wCeKsEZpwtDt6p2pkP0CnDT4dnCD7e2xpR9BabDOnozyEiRUdwksA6Llfk4QU7F2aJjvzvFBi6x9Vmm8y5VO8HNFwBQWB/bxvAm18cg7B9xb/NeOxy8VcshIVXSbnAIZK+0/+CHOXYgraPEn62yPuAylAnNtObpTxeFsz9Off23buzps9jJo3g3DgFcFGYUhBiHSTOlPkpTmLO9K3w+SyiJCwUDvhmo9iOSfR/+j+My3hZ6exIPiToEisVp19EiOWeGHHKUGc/dR9jLrTsUs0gK+e6Ba0EgsJ/btY3LEjf3f/PlONeKqLgQlgvgN5c+n99IqEPKrflw/bRgYNxe59+WsgvtycF8l3KJy077CuHIbsr4zdGYRcBxGx6GNPvEVHD9jdIikMld40N51aWKkEcvHRYVQC5mStoI7aJgYqbxnCyNbPdzFRePar49rHtsGg+hVcTdXoCZ2vB7XNxjCyd2b5DP28qQpgLDpBD65yd0bAlPP709v0dGS+kcRzyjXAm1EezE9Y+zkQGrEiGlMftUKlmUeHHv9Up5F1TAGTrTSwO6C2dSLtsUi8RByd2qDwcuIWZoMp0dgGPA/LzialNZcogMk88Kr3vPmDvi9ZehHXDtWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39830400003)(346002)(366004)(8936002)(38100700002)(38350700002)(66946007)(1076003)(6666004)(316002)(44832011)(86362001)(26005)(6486002)(4326008)(956004)(186003)(6506007)(5660300002)(54906003)(110136005)(2616005)(83380400001)(66556008)(66476007)(36756003)(2906002)(478600001)(52116002)(6512007)(8676002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wPzViFFANL33kEdZ/7qqR4/MPFq/LoczytBbPnONgAILeW01P35G04XKe1QU?=
 =?us-ascii?Q?XGaEXOXzC4vZSR6JLbfAG60DX1ccNFL5tY1gNM/dEDZyjOEqkZD1w5Cx+AXE?=
 =?us-ascii?Q?LwwEU1c4TsU0hjpqU32LVHBy2fCab3wrQqcWGjidA7JCyFoTewz8sHn3BzL/?=
 =?us-ascii?Q?drqlpxk6nfvzFaQ9iyLOmfK1sNKRQVjiwmt9wRCbqmj7xa9sMo/t8SZQQnYG?=
 =?us-ascii?Q?ksbcoRq6Obraw4BNF4Dfo6lsQkndrlpi5tHz6N1UnLxsO0i/D+CZAMlm9QR/?=
 =?us-ascii?Q?u2dXUgdRbovPN9yEHg3QqIe2sj9+1JLYdd5UUcCP4pAf6/urZXYf6CG6S814?=
 =?us-ascii?Q?vZ365b059cv//WpswUCG93kkXDPZ2Irg4wWfMymhUEtiPSNcYfcmehWGUjHf?=
 =?us-ascii?Q?VzOUp0dHVORNxUMGWOsvUxTTbq9cM6yFK7/d5mM7LAyPugxjl/tQRl16tqcc?=
 =?us-ascii?Q?keqEb5dU4uZshy065m6/iu24cazBvS3R4CSiXKrXLfU8DJzy2Indv+k/DoU0?=
 =?us-ascii?Q?UPwoiFvQ2T1pA936B1PyPeyTLVA1Sakj+6gqOdc0NaCiaDpv4ZbyZe6bi8LG?=
 =?us-ascii?Q?tnOxt0GDAHDSHPjsgC5QNORWj0iPuB9URy4DYfTNMLDcERgQkiINGWhCeWW5?=
 =?us-ascii?Q?nA17djgmj/RDMKPq4wnaaK8plItKBHqoiNATcZgPGivJ4wASahJRF1x2Q7BJ?=
 =?us-ascii?Q?hIe/+WNKH5EyKkupUYzBCCOefG/vAH7cxZGzIOTPuMg8d4673KpO6FNWQHDy?=
 =?us-ascii?Q?iv+0DFX2wvgI2b6Is2szB0Zo3IUU0BxbOWFDfb8jmhp07Xo8HuG9lvEYmWlL?=
 =?us-ascii?Q?b5YSevsEdMlL5Nv+nIGm6tkrimvK5QBi7dkL5fQUf0Ara8gKjhoczQP3j5Yj?=
 =?us-ascii?Q?vgYu12xAcUZdeN0obVL/N8byClKvpEPcEikmWzK4wQ2mNJstV7ADwF+RnnpK?=
 =?us-ascii?Q?sLzgRGWwIVHzToKID6mhBhZMtX9Rnyww91u6qW72P4m3nhFUdb0u16xy+Cxp?=
 =?us-ascii?Q?rHi5w1Ahj0Fg0YvCm9h7xOC2Y5Hzt0BzrvLBdb3Or6Dfg3rpbazw5WKNMBNC?=
 =?us-ascii?Q?dUoCwW3taz0sqqXGEdY6LXLnlvVwrTXkfh8R7eJVkLS8Oau3XGlrmzt6hkED?=
 =?us-ascii?Q?o6V1o7hxMrnwq5KzZHDK9RO6uXX+buuWcDwupcpx9eF5dncBeOg37HFb4LD/?=
 =?us-ascii?Q?rVUac8gY4bGjJ5ZSW7/++pC75vylEbYGkUrVRwRMfQjgVXP7y4nabDVjYS2C?=
 =?us-ascii?Q?UaabGdpRvZScmZhSQV1ct+9RSyQbzgWz0p/N4npE4qbjt6WDDwi/Tn4iMaHH?=
 =?us-ascii?Q?Ex6x3gDkY+e99d46QBzeA+D4?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2938bdc3-c145-4bad-529f-08d9514c6ae7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:18:10.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJDiKgaEMQrWNTNmBXFmN5yGR6QBcJVYwjESnTGppyPbEnEYqIjSrXqBHP7ESx01/r98JVLX7u7bLQcN6ckOFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5141
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This converts the existing documentation for the uartlite binding to
json-schema.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 .../bindings/serial/xlnx,opb-uartlite.txt     | 23 --------
 .../bindings/serial/xlnx,opb-uartlite.yaml    | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
 create mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml

diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
deleted file mode 100644
index c37deb44dead..000000000000
--- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Xilinx Axi Uartlite controller Device Tree Bindings
----------------------------------------------------------
-
-Required properties:
-- compatible		: Can be either of
-				"xlnx,xps-uartlite-1.00.a"
-				"xlnx,opb-uartlite-1.00.b"
-- reg			: Physical base address and size of the Axi Uartlite
-			  registers map.
-- interrupts		: Should contain the UART controller interrupt.
-
-Optional properties:
-- port-number		: Set Uart port number
-- clock-names		: Should be "s_axi_aclk"
-- clocks		: Input clock specifier. Refer to common clock bindings.
-
-Example:
-serial@800c0000 {
-	compatible = "xlnx,xps-uartlite-1.00.a";
-	reg = <0x0 0x800c0000 0x10000>;
-	interrupts = <0x0 0x6e 0x1>;
-	port-number = <0>;
-};
diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
new file mode 100644
index 000000000000..4ef29784ae97
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/xlnx,opb-uartlite.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Axi Uartlite
+
+maintainers:
+  - Peter Korsgaard <jacmet@sunsite.dk>
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - xlnx,xps-uartlite-1.00.a
+        - xlnx,opb-uartlite-1.00.b
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  port-number:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Set Uart port number
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: s_axi_aclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+additionalProperties: true
+
+examples:
+  - |
+      serial@800c0000 {
+        compatible = "xlnx,xps-uartlite-1.00.a";
+        reg = <0x800c0000 0x10000>;
+        interrupts = <0x0 0x6e 0x1>;
+        port-number = <0>;
+      };
+...
-- 
2.25.1

