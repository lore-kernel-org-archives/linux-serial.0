Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05761C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FA360F25
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhGWVvg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:51:36 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:51343
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232301AbhGWVvd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 17:51:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh3k+uWWNSea+Wf0/hHky1krVO6I5OeFDi6hF5FbioFlnQfL6KidJs5dsHU/lQTQFEHK64mOxIs5wIaB7laacoj3bU6gUADRHv1VTIH2H5kSC+d0uhdC3dxYSOGSWUdKiUOQOK/q0ds4l5InsmjWCYFS6pxk2/9nPcTKTtws9Ac9KVoYCt+nCWLO5ySiRyphEZa22CIrtajvC9JG5fVUBXkVApD/Q78kpwJRQiXh1vWHUob2VVSPsKGIUrvLvVx0+75s1P3Pv1RQA2P4q2V1Tvp1qvZ74i9J3FkUY2Bn7C8b/Azy4GmAw60836RhbBw/Vpqm3WztIE8DBYWKe/XDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckz772AntD/S+oZfxN8PtWWTbWO9arb0RHy2pzyEU3k=;
 b=A8d2SUUKJcRHQT0FPCxcfwPBm06CpT27wZ5Eg+uR518p4t9cR07SAwnu3D8kFXrZIpvKirMwPDwTGzlCcIIs1fGFx3gV3S/9bYf5fKGyDylQ4NtygNUe2bshmnSdLQggxAQxwA3taUUz8QRE8MRvS44rDS+s7piRgjiV50jy4MUWTrgvBnT65lAQgzHFEkEqy8jWquzkf2GJYXXPROovdm5EHY3BtVVKTAXxQGoiMOxjyU2BBIbY3u1G1ZH+LE9llb0fwU0uNArrrX+mFaHMHy14a8wnWBp+rOZxDAUfsVkGcd/3MW1jM1KzF0eIof3+tE0n2LBSUDIk8fFLSSA3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckz772AntD/S+oZfxN8PtWWTbWO9arb0RHy2pzyEU3k=;
 b=UdvQqtgr2h2HyETvOZSgVfJTzmhZ0nOc9VVbH7T5OhJ/Tk6/SJfcKlgbdqFAmTBsuVBmdz1WwNANU3vyEvJUgqZ8U+quXcq/LH+VR95dAJGDqiuD1U3phEHYP4hfo73B4YpNEvdD5taG2M0GTWjUo5JFK3lR2LvDMn5Qi5W6nRU=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7068.eurprd03.prod.outlook.com (2603:10a6:10:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Fri, 23 Jul
 2021 22:32:03 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.025; Fri, 23 Jul 2021
 22:32:02 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: serial: uartlite: Convert to json-schema
Date:   Fri, 23 Jul 2021 18:31:47 -0400
Message-Id: <20210723223152.648326-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723223152.648326-1-sean.anderson@seco.com>
References: <20210723223152.648326-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::32) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 22:32:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc634b06-5ad0-4b54-346b-08d94e29b178
X-MS-TrafficTypeDiagnostic: DBBPR03MB7068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB70684EE537F48B46B91E73CA96E59@DBBPR03MB7068.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyIjhiO/rcfF1DGk2rnBLRCwYZXc4S5x6r/RcEZREkSQiPO/GBQDBoKsch79kcfRtn+dOtdY7QazDTYqAuJWu27l1BLjjK3xi32hg73pBhNxGAGubJauSEjLdhJtatMcVzhcS5QnBfW36CQmTEvGdWa3CSCZtljdvT1Oxd5Q0XFu8E0Q/6x2riyqg88P+Ha/WuXQRrIZxtg+qwg4kQdWDkis6Zr2yAaTETSILaM2gusb4SmIJi6uqKAYPIe+do8n2h6yKVD/2Johjp2AsAxLUZPqKuY4zvctz73TSX0IGRuJLfJl92EM7kK7v0NkQTg5x1kQgvLNC2n/wPPv9VzOQNqCDza9LMdres9VrWv6iHoxG0xhp3gIZjb9qUxmsEEuqo3xlT1qvGLgHyjFd/C9A2zWBiNTJS8zvYk7tnG2UgOhC+YqIkTRitG1yVcak0sYl+pTJfosGgZqzG3pTf9hSPVL8JRK2fTMfYsSKDpP/kT5Reo7xoiqmUQTQQotDyCCkdYkO33dn/dS4qfwDXSlpH+8FiIqdWArJ2rcPx97lA+Pf/bc1KEZIHHhpYhPiCE0Mbvl47O8bvw0Pc1af5p+QPD+TZ+ozKA0K192iidEugB8+0c/tSCLF5xeBXuCGSATxrPJBAfhjQeWk3RMQU7g8Lwwy+dklv+knm8FrIVQEd+Uxell3ojV656b7E0ncrLMC9XIYkbdCziXhBTvg+vHIIe57J90uLhY+9oq7bZBAD8Vk8X+DRFebT9rZ66g7+Cqv8X4ZEuv8H0u5w6XDqp1GW69+s5U6CyiTK9f4Ky0QmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39840400004)(52116002)(478600001)(2906002)(2616005)(6512007)(6666004)(186003)(26005)(1076003)(956004)(44832011)(966005)(5660300002)(36756003)(38350700002)(38100700002)(316002)(8676002)(110136005)(4326008)(86362001)(6486002)(8936002)(83380400001)(66556008)(66476007)(6506007)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IviaRhzZG1b4rjq2rPFXP6TwqidA+6USK3MBn+KJ719z0ZK7NImP8PhpQsXj?=
 =?us-ascii?Q?/PKF95/M8tyV8w8Z2VQBqov5ouiMxn21Cd0DyDLX+iXxnYpsa2ra6s78U2nT?=
 =?us-ascii?Q?jYpawdl8YLhGh3MTwvynkjyLUrIzWoZxQO0thXnCYsaVlvxbgpu15PYhZ4gT?=
 =?us-ascii?Q?U4xZSNuieeKLM+hd92FfM8rdrk0V/Vv1cdryiRWx3Vschjo1Rg1hkCeQMD6T?=
 =?us-ascii?Q?AQinv/ENWSJBwHZVgb8VCXE/pEaRZBiFP1itkYMq8h+t761JKHUWA/r5ob1G?=
 =?us-ascii?Q?LLi/G2/FbMhSOQwwDn9beTlMFY7ad1pdIMBwfnr1VTla+mFZmZTSmTptDlzN?=
 =?us-ascii?Q?b+qsDHPSI34obIjjwKhd3uHgh/kn8YocNX48DM40QslPReC0n/YTYoh9CIXE?=
 =?us-ascii?Q?e7Y6tUZLUeV+gsZiPI+nvU4auI2hOYppMz0WdyVlhnLdMq22sFc9nNe+JLVD?=
 =?us-ascii?Q?oTTG3cOJF7SEPz+qeiMzpXecLOCgSCuqzL2CHWo8KBAjdcg/J3I58kbQulhK?=
 =?us-ascii?Q?IuAT/xqczKI7qTZClnh5/M2llQXuE+G5sKlyIPrpaCUlefUrSPowKr4N4Vyq?=
 =?us-ascii?Q?tRBHRbmyJmwN/RWxZI2dmVhShjylFeha9DiR8Ra6CYZOyKbLdYWowvZBLV1D?=
 =?us-ascii?Q?AAeqMiSt/sYbJstTaBNShoHWgYTxWNm5Hno3gyBQWyaW7AbxfwFgEZWcN/ht?=
 =?us-ascii?Q?dBGah1lfiI6c/lCTSmL6lDlfK36+wgAEzB44xpiGiC6p1U6F0prp6/sAsuk/?=
 =?us-ascii?Q?cIZ+p5TaSxxvn1DMytbTI/IhLk8nF3Y5mu5Wecb/IHFcCefB4f74Cv/xQ06S?=
 =?us-ascii?Q?CXdt5XZ3HqrcCPEg9GL4GHBWPaYXrJE6ACkv4p3y5FvGBi6Zo9opv32BIcw0?=
 =?us-ascii?Q?Q6jI8vDAgf9UBPhaa2rQtOetECnZEAoxul+oceV4cbB8I/m1wErd+L+FfR7p?=
 =?us-ascii?Q?NRAVGQM6dtS+N46+ZQh1eCOJ82VjUguEUc9byaFtpzGLKq8nPT6uJSGRhX0A?=
 =?us-ascii?Q?yXtICabR8LRDfZsyA7NXhR02lS8DgNfe0ByVkaVjL8qCx2tDHwnIA/0htP44?=
 =?us-ascii?Q?T5YnuSAN+ZzaT1if5DdfFBo8n5zOij9IxfC/S8Usa5ZVRWzwmhhB8tsJhJwk?=
 =?us-ascii?Q?DW9eUxTwsBLAE2V1w9k8FM9vfHISpm5kXQlQkcL9cW6WObvWvXv9tFMKzALX?=
 =?us-ascii?Q?ZMnhqDBALxeyw0A/231u4eBAuDkEOLN5k4mnYip5MIOuEyYolXrLrCePSQj5?=
 =?us-ascii?Q?XM9VV1Za1Ygxl08bavlgkx2d3hxOpLh7ED0bWS5349iweQFY3No+tp5vNKDn?=
 =?us-ascii?Q?39hpng5iqpKHoCoASQlrGd+/?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc634b06-5ad0-4b54-346b-08d94e29b178
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 22:32:02.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hN/3yFqPlXa0S9nLsMSZMf5bagD3ZXQbGXIu9x6SJcTUV2feD6ZMzVpcZUuJ6gXP7lxEjmu5o+UuzBh/t0GeUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7068
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This converts the existing documentation for the uartlite binding to
json-schema.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

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

