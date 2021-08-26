Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7FBC00143
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB7061037
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243391AbhHZTXL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:23:11 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:10016
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243342AbhHZTXK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Aug 2021 15:23:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfNA9psK3TC5w1VX6r3jxF1oxabbbrL6yaNrFP+ez6SYxQyb6lmNIGtQps0FslM78FK4A9LKYUGh6/60B5ChoNwwd+Ev2lN2NMJszURMZ9YAgU9bW0qSw8kxY4WpnrWM068ZA3Z3cujoydEOQz7RhzT/ks+x2qyAMmwNhguUMgwUJsUv9GUdo16BSub+t/mH/+OgSapOtmUW2sKx2pXOZGofY8qrh+mkfvtbz9/Krzlsb61TM5BhnYuhE2r8REoHeXM8ioqqTIud5R4Kpytvy8rGSdp7kP6dr8zq6u8BTiIuMtCtq1wzrtOny20WMAwqcmbtgcSALMxEraPwfz8kdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hej7rbzxBDMjsHNDpAmXDL4Of/gybLbwFsjz0+SA3w=;
 b=EiIoXU8qUA9THN+M3rzuniBFCaRDz0DssAucELEGewi5VIhsvrFZnIZQ9DLGfdB6lYQEZxmhcwHzkplMD7XS/tG7oFkugSL5SV3N9Ck0eyWtEWuYqE858B9hii5EtrjypHEJL0Ub5lt6zoWaLXsSRXaQgWAdlxynkbuwcPfsQIKxX8wUM/yZhhphTthMiSQTf3ZQU93qahPt1rEFBBXi/Jp8tSZOMBufwmUnYsWrkH36Ei1YvoPdWOKSxi6naGGdXxYBD3ZmxyUJI8SG+Gz5puMEj7Q7KSTuf0EYq+6Zh93sqDs8nh16g1t1SYp109OQZh5zdZh/nV/DLLU03Jo8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hej7rbzxBDMjsHNDpAmXDL4Of/gybLbwFsjz0+SA3w=;
 b=BpzqP14ci2WFbr/DzS09oGx1tNM5lIlJnJUkWiIoBibtMFHCc4gPl3350cDfWCFWQD9C8+jygytXxhXCjtaeh/xc7YLH9lnXPCm280JBYQc629iP5Arg7z8olppYd2zuc1EDYDtWNfMrZ2oF4MyEpJKVG5eoz1Qpl/FHapRb978=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6748.eurprd03.prod.outlook.com (2603:10a6:10:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 19:22:13 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 19:22:13 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: serial: uartlite: Convert to json-schema
Date:   Thu, 26 Aug 2021 15:21:51 -0400
Message-Id: <20210826192154.3202269-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826192154.3202269-1-sean.anderson@seco.com>
References: <20210826192154.3202269-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:208:257::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0046.namprd13.prod.outlook.com (2603:10b6:208:257::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Thu, 26 Aug 2021 19:22:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66ff275a-6521-4ed1-3235-08d968c6cf11
X-MS-TrafficTypeDiagnostic: DBBPR03MB6748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB674830D4B7E7C4BAEFD4D42E96C79@DBBPR03MB6748.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdCEXApyPnI6KdU4q27rzYQt81xbd7B4f92TcUHrnR+LLrZEEsiOutHqM8YjGJ3QufTk1sfsEOeAugAqoTmcSrsS+psG9o63PjYq0FAKwYyjdzITg1vCwtMiTyTQ9QEOh1l9KfHn3HwbTazSwf2ksPzWziqhOjxqUf2JbcE5+nTgWN4rTgxZtsluHy6DLnhCskqhQ2jY19r48LsYcUjPyT/4Cq/OvwJDnlG6lcyivDudQl9QcahZ5JxP3pzOBaQMvLIk9RNPUt8NvR4nZpYxZQ9tbZESN81mOfvZjNwRuqDHmlhuZu4H/FDsO7mdy1CzIq0vQU+vYfPNECw10x1tZq0cgA+PBoxRROLfFLMQUbvto2rgBFA6Kamp92fbeR5uGntWaVCP55vRB6xWG1YE5Jb5F5e5J67J1KXDpGZejgLJC1wCaUQxLwyYXTvnHq+YMCmZFCaZJIEOto3Vv0So9LHJtJ8R0uk/YcEwdjONxU86+1y9M2AkHmvmDJOdP3C/hZ5elDahIcbCXAT4jDwvU5v0hAEWfXQYDdDm/xn+G3gotunwdmFPb9efJ1jeInb+rstv/FS3Q1x198Ib4ehdhAIXyFy5iReTgG9UxcODMj0vUdHHSwRtFeQSgHaQ/ceAmUI0cxxVRhVRsMxDSxJ44wSdXGEHlTrgOc1NaRSVF4pNb0Rg4vLjg5EnGcwWF4TWLt0JNxiN824o6T/h75rqdpwuLzyWzzU9zqH+a5mJBGD6KlMiSzTKZq0twEjp7BnY9QEB4A2drf0nA7tWgrhcCmw8roVSR37Igw2PI/9a23A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(366004)(396003)(376002)(83380400001)(6512007)(966005)(66476007)(86362001)(478600001)(110136005)(186003)(66556008)(4326008)(54906003)(38100700002)(36756003)(38350700002)(316002)(6486002)(52116002)(8676002)(26005)(6506007)(6666004)(2616005)(44832011)(956004)(5660300002)(66946007)(2906002)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sK+8wMd0wuFy+grOgfzhkGm/ucpt0FCg7daFDQNn5CYDV1Fs7K8acn7CZLRs?=
 =?us-ascii?Q?PkcPA91y7HlXx+03OZ1QLAjGbEru99VK5IJKjdC7ZJSJqHWjpUeXSyaiC/b0?=
 =?us-ascii?Q?bNNh6WvEcv14ahczIKgBRAZLc9XYOPO+jfXeKEk7O32rEa8ei/IAQRjYckZ7?=
 =?us-ascii?Q?QvM0Y0pJx70WuJ44DJv769DyX65B7IK1geXXt1vFAneXjS6DapRiA62O43lu?=
 =?us-ascii?Q?4ZcwmZD9CE8cXIZlZbl8YFF2mUFO7SGFBa7bZOjcflYQxN+uZ01e4FnC/rCP?=
 =?us-ascii?Q?VN+C7LTKxdsrVwP/k7cN36wrHCerldimg2BcVfD0P2xVG/6KhLstH1VAIapg?=
 =?us-ascii?Q?rx9Cc46qIzXG5UlgWP+4h9VRqop7S6/eVtaZJL8fF/jAKtmJb9WrWH7kqynb?=
 =?us-ascii?Q?iAd1EvVm/RylVOvTwGNgkJAmKQK96UfK2SBO3dtxQ+sCT0pequc92PA+DtJq?=
 =?us-ascii?Q?HALItPKFDeRZzNRdNWTLr9jk+fwvyy02Ss98fee4HcQS1v9zCdFdryo24xTt?=
 =?us-ascii?Q?7QHmLQuI1P8EzGXlNsTplb5uJ6DRWAehDFe0MUqd6TpMfpsZJdhH86iHjAi0?=
 =?us-ascii?Q?fG838mCVVkzkQa+jvBSN+joLuGRhWgvMxCm0/UsnBTxPxX47ivar7cl3s1jw?=
 =?us-ascii?Q?VczGD4XL3wfNIsXp2UWMVBYB2zKIXqIT22QahJ0vwdXWom+iKIytyMv1dOln?=
 =?us-ascii?Q?Ye1NsdUUfgtXoK63yX673SJhRUHVtgQF9Uoxl6JF5k50v6PUfZXMytMPl6uV?=
 =?us-ascii?Q?Y2mP4QH/mHd2fqmEhhxYiRfx12pjkYW4/FLTf/Hk4yC2MeSL0popvgwYdmID?=
 =?us-ascii?Q?wVOCXsqVAtQ5NPkAIWaWK9eGJYPleRF7/X0Tn0MKVxds0Ai00C8vbkXzzY6E?=
 =?us-ascii?Q?pkACJE7SdobHDY20fM2lCR3HEgmpVF2AVGKKko7OjyHX3lKy5u2aulErjlAY?=
 =?us-ascii?Q?kezu2vSMPtvCMvaoAU9/O3n5su7JUBfCMeXhplmclgRXoMBK6ctEM5unCCDe?=
 =?us-ascii?Q?5cteTktWqiqj9smrZTJHaDjbNFlyq8MFg+EQqQ5ekk6YEKuQqI9NQxmSg+oK?=
 =?us-ascii?Q?T/1ijtuzN9iS8XiMIXCTbM/CuHodOvS3HoUJETrkRkV6OQm8+PybZWnyRMeP?=
 =?us-ascii?Q?KQ8ZnAdRoVsoKJvsFkNZT0jVevh6D+QsQBxHcUc6bSb+zmLeVbMJ+XVrgh+m?=
 =?us-ascii?Q?MXOBWokqawgdxQ8AG0gy4Sgk35oO9ExUK51XIV+o6XHwn85I1t3gPWmomfJJ?=
 =?us-ascii?Q?r5WomR+5eH/kHYXIXzeA0x/iQitzquf17xlDN9YT9CUYB+1Y0Cw79YE69ejP?=
 =?us-ascii?Q?go92/x4LAfGT0QYkme9D4uOf?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ff275a-6521-4ed1-3235-08d968c6cf11
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 19:22:13.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlHxruYnHaegj8Y/eVCUIRG+IIdEhsiT1EauiXBECsu2bmvH3Di1PRGKpWVVHnBe4fkfV/741S4eSFZ9MfBRpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6748
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This converts the existing documentation for the uartlite binding to
json-schema.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3:
- Use unevaluatedProperties: false instead of additionalProperties

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
index 000000000000..0cc94c920b17
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
+unevaluatedProperties: false
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

