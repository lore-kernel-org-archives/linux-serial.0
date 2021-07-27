Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD02C43214
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3657460F9B
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhG0WSU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:18:20 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:30900
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232642AbhG0WSS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Jul 2021 18:18:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6Jd90YuqFlF5ZPjbDi0B5GU1JKbrUALnV8J4UCTMX/4Cq9QDG18msVzdSU3Xnj2d5ZCFRe1ltqiWNF5dGIoRd14PQCTqVHo0j0Oe7W7UXDiW+CG1fNaAF7LHJ4XpKWn6kGN+MDFBeQcC2LGBQzdbMfipSBIeUYQ6v8thQ5Yp4cAuFElu2exYrYyr4V9lWOznifaKn2Z2ljjUxe8wKhWyn78DS9fpbJRfBnJdtrYDp+g+KdZD4//Ktt36t59pUgkf4ZmZETMNS/MoB2H6JO2V7eQyDtfYzQC2G+TEutYnDPM+UCHZLCDw8H7x117thg+tsXl5LB21MN7neLyARpLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxQKQvIIbEewsnpAENOMHK20LQRFM3P6GplNrPEl4YQ=;
 b=ea4DCMpRytMrdXqcv8eqE/xiioiMeHCymNTrz8e86EHkorbcRBmhtE0X174UjRxptSinq2eL+L/DHqmTXEnKfeezZDEhizcapBwr0zd6NHhHByKk46fL+KZe4tMkak0g/V/5wmJmc17nzbGhXD1cLh6NpT0SRWh7eILaOtVAiAzBYbqw7w+42uA0gzSUJJ/P3Em77tJ728R2DAK0vdaXG+9U2wiuhJk7G29xz34+qA5VXkZk79LNZ2XuN7e4y/j+PykkwYZgU1xC/BMnFNVFsjY9JR1a6Tm6dKA4KBnrn3JBS9rPgVeC9BbWIm8sMrlWpqCAs003XRLC8OZn5MXw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxQKQvIIbEewsnpAENOMHK20LQRFM3P6GplNrPEl4YQ=;
 b=nPZrVVoneRuxLgqnMX5GSNjC9oijEu8CBtgZBLBVGWRBfvapYIsTJgoBMj3EK2uUjsTfSXi8mm5zG5u+yW21saRMpJvrH2huOXFKDnfKT3sr7Xopz6pD2LFwHc0VMZg2xHKdct+jm2uvSim/wjJGZQO0G55AHYDHrVbweBE5hwk=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5141.eurprd03.prod.outlook.com (2603:10a6:10:f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 22:18:12 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.032; Tue, 27 Jul 2021
 22:18:12 +0000
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
Subject: [PATCH v2 2/4] dt-bindings: serial: uartlite: Add properties for synthesis-time parameters
Date:   Tue, 27 Jul 2021 18:17:38 -0400
Message-Id: <20210727221740.1997731-3-sean.anderson@seco.com>
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
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR06CA0008.namprd06.prod.outlook.com (2603:10b6:208:23d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 22:18:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c9b2227-2f76-4f27-d4be-08d9514c6be7
X-MS-TrafficTypeDiagnostic: DBBPR03MB5141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB5141C303EC273165EB1F1DB396E99@DBBPR03MB5141.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VGRB/vvBdwMk5Bs+PQ9dNd+fOOazQg54oobAmxiElvqhur7v9C9DdmfEAjdL+bIk/6G37tfH0dYr9QDNDKSYCc7rBJoRwgIhKdVZRyxha2XfR3/qi6wG3LfQfp7E+67Os87nROlEYNzr7bu0FZSPH+zz9r6w3uqh0QwrO85zz/rSbl6j6jObgQnfII+eIzYYuytuQzktOrT04kkM/w1kgOfis3/4/+6cgTpB3yc3zeh+ETJ1aoB40XxgfKzmSxChNosyY3aJzORgupkoALMHF0uT2wWkLbRZ9rgvUyz5p/L/e00FF2Wos2L33CsAspP7W9Xw+JSlrfiWzSG4g1sMbB+aZ2IPUHBKWZGAD1PpqUmRaJatrpH97fxpltgTQKrOA2b2/KrD0Q7JiYBRgGqmugTMasiPTORv2St+p5/okQDd2lYhmZlWnml/v116Dr4VlEL+dsrpGdo+uPATpkr/AEtJX2UQWFo/qkNvOqzU33kktq9jX7TAim5IirnhpqB5ZOwB8Y97jA78ZtCk3HlAuScgCWYSWJNxAfjCVIIJYlmJLGXrYwajefawZKd3eIjSLnhWQ9CTfPZ7nq/Tc3sj6+mY5PlDGiCaJb6ypzFgF3W6hEjQTsp+CCUUmVYuab8LYxqYsQxQ9Grdow3B7zqmvGSQ44Oq4+tWkeWF0dmiQwTYKIzhOPfEw/Z6XtpBJRG9hwDbzwuaZgs9UMaA62iLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39830400003)(346002)(366004)(8936002)(38100700002)(38350700002)(66946007)(1076003)(6666004)(316002)(44832011)(86362001)(26005)(6486002)(4326008)(956004)(186003)(6506007)(5660300002)(54906003)(110136005)(2616005)(83380400001)(66556008)(66476007)(36756003)(2906002)(478600001)(52116002)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AIp7YO0tCNQYuEh2JrR6bn+YsAUO8m4a3rm8PBjWsH3v7iL7FShhbsFDbT5F?=
 =?us-ascii?Q?b9khKqysHWKtIpthYXcN1z4HgAK4UaN32PLgy3iWmIqg4FEiOxWdmH/zd0pZ?=
 =?us-ascii?Q?+EuLBfoPDmL8gzwUJcFnb7nhpgETZPNs51vtr67GMEAGM1lsu+wMCjDuUMcK?=
 =?us-ascii?Q?n1LwEtdFcx0qFqjXGq9nvWuduv3VdFuySdG4Ehak+Ycbi4Iw6QKRwOOWk7nD?=
 =?us-ascii?Q?WCYVK1dvYQEp6g6wH7eDDghUFlREQoGAxPIn1db9SaobfpjPrVYRgmDHY93G?=
 =?us-ascii?Q?tXnY12QopPpQjNAs3dblhpJoMRioSaYZl5YMPLyA7O95VGRpmebP2FePkc7z?=
 =?us-ascii?Q?R/VvE/ypW9T9dJtybuD3dB6wf3pv7mCgtQp3lCxacJ0YPJ/aJBvCGt7Hyka7?=
 =?us-ascii?Q?44oGYcaNjO8zR9FliVXjikdjQf0wjdRPYaZBXd4R6mOj/XQIUfrk22SGZV7u?=
 =?us-ascii?Q?G685BpxyQyHJa3ej4brtCfh9Ak/sTFZ/TH0EbW0CuA48zUjyhSx9XkfxfPXy?=
 =?us-ascii?Q?QGcb4cVxAVDtBn1oSQ52eMhSktjPrEO4X0AsSQH3zGKwizn6tp0fOeiUXnaS?=
 =?us-ascii?Q?E1/C6hP2Cqt04mQgFKYta2h9UNsMcrnzNRdjeT3fYL4wiXGS4MWQY2Tv3EEz?=
 =?us-ascii?Q?7+GXsvFquf30UljQ5VBxR7K+04CxAuHnXc+/cm6NTpI8Vm4z5+n2XXLcZkpW?=
 =?us-ascii?Q?6ZlAIlrpcGnIKDgH+QVImdLwgO+U/Xh8zuwrkvk+W37aFIfeQlPqTNIQzDO0?=
 =?us-ascii?Q?NszuEpQVtGaiiq7cxaaKFg7b/Zwjqzb7+bWNgmFm3YmkNfmCyJSG/vMLYftp?=
 =?us-ascii?Q?5YWiQiDXZXhS/33faQ4jDmWRuhjLTLbIstTWdn2QBsD3iLYTeOYc9DhXkvuf?=
 =?us-ascii?Q?4GiRdV7iTVlDT/pym5TGZjuBlH2twuMRBFWlCrJgIvp3haR8NkSsyoUay/5S?=
 =?us-ascii?Q?/J4B8S5Eq7NWxVEdy5YTkaSvmf9EVtgyaW46tie1kUc/K6cM9bIrjYOC6Qya?=
 =?us-ascii?Q?GzmdGWE/o/TMVMwk4AgXnFhvK9Auf3ZHLo9oqTbwhX3DVV1YcvexbhE43e8U?=
 =?us-ascii?Q?6GCiHosSKR2Hp92JPwKpHk5UuhHnJW25KFPc6tBPQMmbOgiftgFD4qfdHiA4?=
 =?us-ascii?Q?i7ubpTkUQGRxKLU52ZlTm/5GqhBOfoV8nrEEQOBgi1npfBoEq8ui5z7zWcML?=
 =?us-ascii?Q?vApiYf9/dbFuxQM68U/L6VJTAs3tDbG6YMw4L4mK/5EQFX9Tay5pfb+GNN+V?=
 =?us-ascii?Q?3nkXSRDXx43YmwAWCRZqx7x56gX0ziCNATBhqRQkYQLvcpFeKjlmJA3oNafC?=
 =?us-ascii?Q?OIxvdwB9/D4gwinLTytrSdD2?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9b2227-2f76-4f27-d4be-08d9514c6be7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:18:12.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC+ndNB9gcdcl0BaIRovxAHHJIDf+lSY+fumOicqkOOSl0XKzktQL4epnqWEcp6+IfXbTVsulb0RY2DL4bieHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5141
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The uartlite device is a "soft" device. Many parameters, such as baud
rate, data bits, and the presence of a parity bit are configured before
synthesis and may not be changed (or discovered) at runtime. However, we
must know what these settings are in order to properly calculate the
uart timeout (and to inform the user about the actual baud of the uart).

These properties are present for out-of-tree bindings generated by
Xilinx's tools. However, they are also (mostly) present in in-tree
bindings. I chose current-speed over xlnx,baudrate primarily because it
seemed to be used by more existing bindings. Although these properties
are marked as "required", note that only current-speed is required by
the driver itself. Hopefully, this will allow for an easier transition.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 .../bindings/serial/xlnx,opb-uartlite.yaml    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
index 4ef29784ae97..28859e70e60f 100644
--- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
+++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
@@ -32,13 +32,49 @@ properties:
   clock-names:
     const: s_axi_aclk
 
+  current-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The fixed baud rate that the device was configured for.
+
+  xlnx,data-bits:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [5, 6, 7, 8]
+    default: 8
+    description:
+      The fixed number of data bits that the device was configured for.
+
+  xlnx,use-parity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+    description:
+      Whether parity checking was enabled when the device was configured.
+
+  xlnx,odd-parity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      Whether odd parity was configured.
+
 required:
   - compatible
   - reg
   - interrupts
+  - current-speed
+  - xlnx,data-bits
+  - xlnx,use-parity
 
 allOf:
   - $ref: /schemas/serial.yaml#
+  - if:
+      properties:
+        xlnx,use-parity:
+          contains:
+            const: 1
+    then:
+      required:
+        - xlnx,odd-parity
 
 additionalProperties: true
 
@@ -49,5 +85,8 @@ examples:
         reg = <0x800c0000 0x10000>;
         interrupts = <0x0 0x6e 0x1>;
         port-number = <0>;
+        current-speed = <115200>;
+        xlnx,data-bits = <8>;
+        xlnx,use-parity = <0>;
       };
 ...
-- 
2.25.1

