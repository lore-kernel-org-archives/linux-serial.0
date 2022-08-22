Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE4FC3F6B0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Aug 2022 13:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiHVNDt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHVNDr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Aug 2022 09:03:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884C36574;
        Mon, 22 Aug 2022 06:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpFEvktkwQD/LzKYvtbVuJzK49ISrCpv7UxWRW//1Drrdd4De6ddIOYIy8WNyeFYROPhTLIjVBbInaxlrQk2wDgS/3+5inxZgmVIvE4ognvsjBq0KaLyvb3OyfMDyWgnCSFBhbLzgHlLWTRIKzQn6DTRzMTZIdck1E7pNQyOnKe4+9wcltvOmR9QS91TOmNAI1nlRZzNe969tuDnnI4ewDEsHq1ELlixAllDpsdx4G/WsCvuC5K7xlh616JzgyUjFg8SNcxVcTdnvudVQRRbsOa28RtQi72qN4LbYH3vZhVs7UdlFZ/eBrdP1fN2CXO5RbEL+xkSjkmu4CP325i+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTtK4XQ6m5jI8bNKdz9lcBE564c5yQR9KqCFhne5qeY=;
 b=ng1q34oNJY2VixMiXvRnRRudg4ScV1MvBFS06TwbtbrzKfU+rcPRrejRU2ZuBuo/T6WPkiUQDULRUGHIsNCNAf6dVIV28uul52xhdZiCvs78AtH0UNVXmNG0o/KiY4z8KQRrze5KCJ3kTYRujD4qfpr+gN+eBcK0NceLy/IRUiumvA4OOY9v/qLw0d39lq6l2fndL9LV+sD6tSLP8bGNmVl6Go9/LcbgWM9h5s2qSYCRkwuTeM+9G+3ttsdy8OD67oBRppAyv5A9Ow+gHOOYl7GpmwMgo5T2mP4KpvPuEzGcqEzXPpheGrorr+7My5uNidO823L9nU0+mHLNFlfXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTtK4XQ6m5jI8bNKdz9lcBE564c5yQR9KqCFhne5qeY=;
 b=zIhgggqVCOhrAYfeGG7W1DTKatcgqpM3/pdQDxk48zFwxDUCnPAct455OxpoTfLaKP58kaDrP53f8BbWSbHAQtdDDGpT9beE4DtY/gFWMlJ9tT+2/o0+p5r2F+lYhXtP8lFa+4tFP6DYyFmA/2cOUbtdHes9rDPWW4/YffjREjo=
Received: from DM6PR21CA0026.namprd21.prod.outlook.com (2603:10b6:5:174::36)
 by SN6PR12MB4703.namprd12.prod.outlook.com (2603:10b6:805:ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 13:03:41 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::cd) by DM6PR21CA0026.outlook.office365.com
 (2603:10b6:5:174::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.2 via Frontend
 Transport; Mon, 22 Aug 2022 13:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:03:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:03:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 06:03:39 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 22 Aug 2022 08:03:37 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: serial: pl011: Add a reg-io-width parameter
Date:   Mon, 22 Aug 2022 18:33:32 +0530
Message-ID: <20220822130333.5353-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220822130333.5353-1-shubhrajyoti.datta@amd.com>
References: <20220822130333.5353-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7a472ac-f467-446e-c049-08da843ebc94
X-MS-TrafficTypeDiagnostic: SN6PR12MB4703:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4+JHTmxleIK8okn6wsrJCu2CUj4XbT7nkjVgS86W78vvCjHrqAfRFJnl6IMWFFohnNrljymAV5VA5J8wjZhxicZi+QqGYRAWSig+h4VY/1Tu8YluGinov+5fCUcFPNiI5hSI8D+3tdL6Qs9QmVh/m2hNIyHqSjfAhSrHIEc9D0GrdQ8+cHy/JlNdMeQ9/Cy6XW4dSMvlXqWbDU8ucgUUHwTzrFZyNUVplLuQhoPstf4y216+U/yqcm96W17v0z0sTaKYQkceUMBBFaccDzUYwr8OBq2/jRyl1mjBH8F6PybjX/3tcxR7GWUnlrei89Jvfz651WAfN7zV0OkOItx34FOmSnc8UOgY+R0d5DuYyP793Y5FS2YWy0qFypv56Kn87lWQIm1DDweSPfgwTpNyoSZAJooSl/iI0/Y26c0NxYC9gcGev8jBz3e1xENYLy0DfzyZZpyuMSY7fGuTIxKI7sxi4+/85joovIPsEv4DVHuL9L2qWziqnvi7HX/nhE3JfsyXEBXfH1O+1oTPVGFdt9T4m8O4KNiIP2UXnPp3rHBwse8LJuCrhU5Xc3bKgNvEUuzhlhSgEuYB9htBBuEeOxXvh81jcGx8Ew6KmHJ2HHe1F5wTxbqhsQc4vMzJssH3kww/2TLBXanA4KoiDd8AdOfAErTAwF28jC+dRC0EqORHa4QJIqkIO+4wqg80xynEc+kN5aYkGCBujDFryzoW9iITohldFiBATndBHo48e/0dS3jzLJbb51x2yiAXgIuYTjYtGuZrlkNO73DkGEUpmB8owRefIj4ZEFn4ijAm00ulLCEhdc+lcbX/ayFnA8t
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(40470700004)(36840700001)(26005)(4744005)(44832011)(8676002)(40460700003)(70206006)(70586007)(83380400001)(336012)(186003)(8936002)(1076003)(6666004)(478600001)(4326008)(41300700001)(5660300002)(426003)(47076005)(36860700001)(82740400003)(6916009)(54906003)(36756003)(82310400005)(316002)(2906002)(356005)(81166007)(86362001)(2616005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:03:41.1956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a472ac-f467-446e-c049-08da843ebc94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4703
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Some of the implementations support only 32-bit accesses.
Add a parameter reg-io-width for such platforms.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v3:
patch addition

 Documentation/devicetree/bindings/serial/pl011.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index d8aed84abcd3..c8a4cbb178fe 100644
--- a/Documentation/devicetree/bindings/serial/pl011.yaml
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -94,6 +94,13 @@ properties:
   resets:
     maxItems: 1
 
+  reg-io-width:
+    description: |
+      The size (in bytes) of the IO accesses that should be performed
+      on the device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 4]
+
 required:
   - compatible
   - reg
-- 
2.17.1

