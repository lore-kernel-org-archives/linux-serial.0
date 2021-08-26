Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554C7C19F37
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEF461053
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbhHZTXM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:23:12 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:10016
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243360AbhHZTXL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Aug 2021 15:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMikZuFuHZdNGHhueO3LjrpghbAa5R0hLM3P5a07H6Eujrh84MItQ8fYN2yXeMMhzujXPRDkumF427VAVT+dSzCBPc+6oSYJzNRq4J1whHsE1xKsatua77cEniu3J2pia3x0GZ85q8yJRKxmbqRjmDHnIIqMGyai2A0cupa8ZNUbdOGZ5i1sYrh60mFKZ2PiaZm9TufFwXYvi9F7saI59r2tPccvWY6e/x5oeL4w4TnFivfciUjPPCVq96chLRcrl/3rA4Xq5dd7jd1UWpPKLBiHZW1rM7BpfQCa3N90aKDL9IOvJO8kAyaXNZm0c4zYFsQVbIhrheYuKepFY3f/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqEDdB0HgKNcvn5dMidfdmzHvG3ttIKx5o9jhdUwnLI=;
 b=T75KoWM0LwCP9IVmzKPa+7mo9oIy3qP2J+Yyb5xvKLNpENvcn7bAwZToPww+VZJcvz+utkkWDUygcL6CcUg1Zkg7btTNGO6MIJLQWAgkYXVyT1q3Dx9jT+I6ysHEgtPFJsq+cUGKfAEDL7l+y8HutomirLdij4MV7nNU1VuRJq8tkShps4CvpcapSEdjWcZQ5jXV4LeiGcnxbVS2tpWPWLRG/H3RryiRdeulSsj4judp0DYkdII2wpuPySmcMa5cHsPXEEBbl79BV1abwJupA/1iU/c//A2IOG9USiS7HXP5TYrKQIT1oF0PVJK/DLdAbjcgkzcHmwXPMw7ubwWJYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqEDdB0HgKNcvn5dMidfdmzHvG3ttIKx5o9jhdUwnLI=;
 b=N4Z7McIJ/CAKpUGV9mf2Ah7biG+bWmEFwkPvuq6ZtPPZ8gieIca4Br0V68W3VC0H5QVoCjytGojWbw2sNecpl95Gx9K0FNO5kxofSWZW5fc+C0/W+n+tbCur5y75lQv7Z6RaLIKUYBBl2KwSNOZflFottKy4CShMtntinBI4+Oo=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6748.eurprd03.prod.outlook.com (2603:10a6:10:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 19:22:15 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 19:22:15 +0000
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
Subject: [PATCH v3 2/4] dt-bindings: serial: uartlite: Add properties for synthesis-time parameters
Date:   Thu, 26 Aug 2021 15:21:52 -0400
Message-Id: <20210826192154.3202269-3-sean.anderson@seco.com>
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
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0046.namprd13.prod.outlook.com (2603:10b6:208:257::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Thu, 26 Aug 2021 19:22:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 174cdff2-6f81-4079-72d9-08d968c6d014
X-MS-TrafficTypeDiagnostic: DBBPR03MB6748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB67485EF58A07C25BF103B35596C79@DBBPR03MB6748.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpnpjwSAhOvV21E6fznk2byBJCbBq5QiQkfvUDk3s1lWN9npyHPHsTYeUkDSLRJoRxC1NuHAt5kbc9yGX0fcwHoe+kqNLGOtlMU88aE+0pgFFxwQBkHdtfwArNa4SIbpvPYzOCsB3uD/q8u0RMgoAU7zqlqa+7sgYy4v59karmIZ+agb3SrWc2AZGjNDXKAyL/eW1F/xev/VQT4hqk6TncyjCcSbET6o0n2hzTv+jLZ1603qvKIyumu7bRgWsu2bBbVze+BcSAU4rLDpbM7Th3Ev0EYTJaPo/7izSGBnWRy6Sq2+GKjVzmIasi+e6yPfto4s7RAOFMbjp4z7MAgPfAlClyKx51kHpdcl74vaFs4/u1VamaIVc0BiqY1weXUB06+DBk7qyDPFkaO3l5d9BbrtXQXCpF346Xi6AGs+UlovB9CE6ukoe9BSdbBCYsXxqKcIe1jjhTU0hJJkbfVQfYJe3LGz+vWRgQfMkbK4RXK66EVmPwlF4I+TVgEM1eqqG25+slk4WLqUs1AJ44hEZUAsCGHucC2wrHKfJWjO/9Q2ZR0Any320eB9ytC3hJbxcCKmmUtHE/MA5CteKsBgXhzdlIukcqCNrQFG5Sd/rs17sWHC6p06mVji9pkkWqlQHkdQ1DXwtkZ1UHMV4K+9xza3gtQiwHbSy6qG2th3OGvMdU4tjs+jg3p3Bi6DSzqahZxDqcfT84o80oi72eKI6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(366004)(396003)(376002)(83380400001)(6512007)(66476007)(86362001)(478600001)(110136005)(186003)(66556008)(4326008)(54906003)(38100700002)(36756003)(38350700002)(316002)(6486002)(52116002)(8676002)(26005)(6506007)(6666004)(2616005)(44832011)(956004)(5660300002)(66946007)(2906002)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6pUvqH5SGsvYkoyc24kdr3NcJO8UKiL3UZ6ebyHXTVHIuBFRtOmXD+Hep+J?=
 =?us-ascii?Q?SywEKl98eb2X0+V0DARR0+5494Okv1X3l1TmEuRXWG1C6KYWr/RSgb0HC8Ho?=
 =?us-ascii?Q?SMnObe9fgdhBofiHybmCVMoiiCWLN/lMqIjgWzEc/uH7ulCSyQItPk52twFR?=
 =?us-ascii?Q?B4BRnVt9Hjmrb24QHih9QOH7a32kgQ/rk8jbW/QABDSwhHFIjWlEQcyKM3R1?=
 =?us-ascii?Q?lOAnS67YqTO9iJlUmHx4WShc2X5DmJOBO80sfkvHwM/qFyG+XTR6eaCh6vf+?=
 =?us-ascii?Q?WzSYjWQ1dABhvgEzRHG7vhOewjgVa/JWshyT1v6HomXn9azgij4O165o+eEx?=
 =?us-ascii?Q?3qsn49ljDmbWHTVjhv6QNDCl7KgjOQASTfNwrkxArW9TobdpZuSIxCYBCdzB?=
 =?us-ascii?Q?zIf0hdZnKZYL6P8JomKoUqWN5jAx5clY9N6qx6d663BTVlevClo2i5aRdXgn?=
 =?us-ascii?Q?+zZEr9SV+3Z0G1/aEfigzF5baHWdMaDbWN2HCMSCiGS5ayAuiKrtU2DcR0cQ?=
 =?us-ascii?Q?Grmdnsu8r0Yt8YrROY+MNbL+9evkjUYpAhyJv8MTdZLgYIJDZmcu70N1O4Wa?=
 =?us-ascii?Q?86EUtIqSnjQo+Lyv6zaNAwZgT1GiMOz9/pe01fZ4mA6Y/PXqMl0jFGnQ8IJb?=
 =?us-ascii?Q?/9C86JBYjFsvMFPBVERG7MAcuXvyHCfomoFFo80jbvtTqewU7ElJq8BVC/30?=
 =?us-ascii?Q?R2M30qbC0ATLhmezKgFiZ475J2skWuLoed9pdzjCJ5eNYJSI4FCen3K3YFY0?=
 =?us-ascii?Q?IAWnQVLCag3N89Qa2g7Sn3ocImOfi4hrvjUbYwkqZiu4o2Hc9JP3Ef1svJIM?=
 =?us-ascii?Q?DBOmgoQzfNmYHNPWx6L/O2V27f6O+Y3z7df6NjXgjQdp1tbG4TQzTpxzIzNw?=
 =?us-ascii?Q?FuceoGccR27BFdMT1SwairTZqHNZgTdVp23buNBvrjv+Hw5xXeTqZEzUalLv?=
 =?us-ascii?Q?pyhz5xlPRAdslUEEycI2TCc8z/IMHZv+QCikmCIvrk8mIn/vCR+IEUuGqKJf?=
 =?us-ascii?Q?BSZPOtGD5YxDyWZ+hTjHadohT/uF1X/HWtOA/7sop1B35aKvmYmHsuFGU2di?=
 =?us-ascii?Q?V2GaU7BAJ4l9ZZMQgVTO1f2d/IZwnKjceXuzcXrcRQVLtWuqEoYOTXHZaUNC?=
 =?us-ascii?Q?u1uD6BPV07991W6rmk2Qs/1LMOIGY4mNgzY0USGVkXKi+Wz/X7Ew3S65OZlP?=
 =?us-ascii?Q?XLLl4wC+8mKDuZYVxHNjxkXqwGFXSULA8lV/0mmL3jQ+25Z8b2v9ucBJxlst?=
 =?us-ascii?Q?w/mwxbp8/XG/+bM34xGZIfkPUek4lNQYeSCO8ptF0H9ufrhW4/t6Aucnh3Wc?=
 =?us-ascii?Q?4PghkJWDqkAnLFy8VFDSzmed?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174cdff2-6f81-4079-72d9-08d968c6d014
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 19:22:15.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zINDlE10WLq+3dfxyH1Hsi0ELStoKaalwS4lTkKUhRIIsZvPnhMOKN12KFsECk7Ld4C0xxVtrGYmckIIAP6FAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6748
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

Changes in v3:
- Removed defaults for required properties

 .../bindings/serial/xlnx,opb-uartlite.yaml    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
index 0cc94c920b17..b8a2bfe14bed 100644
--- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
+++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
@@ -32,13 +32,47 @@ properties:
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
+    description:
+      The fixed number of data bits that the device was configured for.
+
+  xlnx,use-parity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
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
 
 unevaluatedProperties: false
 
@@ -49,5 +83,8 @@ examples:
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

