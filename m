Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C8EC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 11:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9ACD61A38
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 11:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhKPLUx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:20:53 -0500
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:16480
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234812AbhKPLUv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 06:20:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5DyiCXclayFYKgs4kS05e4DSgdYU01u7mPjLOQy7WfcOtv8uTVLUjM5mNG9PMznN5IQpmTONP+ayreC8z7rA8Kjrzr1pSnVYqQWnTMSBOt1memuTRVh2XYprJuveOW9D4HknF0o174n8OZnnChfvo8AEc2Pe+OM07dlNphsdXcUvJVGpdXQgbhpM43+p+I0kSQteSoAJdTWdBsUwQRCNzuj4cUvDMXvk9EYEm94PPjVl9v5oNhNje6ofLgL4oHHmOcSJO1D6Tbm7xNLOtZkjPl477XSWO7AHAnr1kvjeWNi0grjTx8nAvwKbkK5F3WRwnM9frJiDujVGBDckCpZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urw+8bSAHxy5ADLJwnxpSDhklbZ8Qznk0sKGq0lh4I4=;
 b=YTrC42I+5xatELy0qTz9FQ4nhR0Cn6EzPpYvH7QNoBtD6jphxeTFThZ7zrAChA0jklolFhINrGQcwrPLVUxsN6q2enwQGwdhwz3Z/iTX0o6ZL0eDHQirrZE3etrASsFBCHd4C4cwviJ5aydpa6H/eCqQVVCzY0WtaISZHxMTPiiuR7XIdWTbKWN7ok0XFK+cUdeM2jUP5wsH1os4i6SecM1yl/DJYucy0B/rYkQZYWpWxh1mXFb/2gv2uy4pP6pQ3P1Y4ELH/pbsxzRr2mwGA0x5IWe2eytbyq7TsJDdbxkjXT4Z+EL0WTIikWgHtuoVkYHOnP63GckI41KNRfKRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urw+8bSAHxy5ADLJwnxpSDhklbZ8Qznk0sKGq0lh4I4=;
 b=m5zM+GngydJSOrNsq0lJh+BbmATI4Bjw98jfkG0XO1ptooA5vtPpO6g4QlTZPx/ut577dbhfFDcQZqEfJFQna0p5MOhCYGOYWtgUm/jJ3x+S/IB2TtPE9zjMtdOI/w7OQeraJtGB5WkUnv2ZzrUQDW7BUbq+SSBT0Acbb3KBDRU=
Received: from BN6PR22CA0040.namprd22.prod.outlook.com (2603:10b6:404:37::26)
 by BL0PR02MB5569.namprd02.prod.outlook.com (2603:10b6:208:8f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Tue, 16 Nov
 2021 11:17:52 +0000
Received: from BN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::dd) by BN6PR22CA0040.outlook.office365.com
 (2603:10b6:404:37::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend
 Transport; Tue, 16 Nov 2021 11:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT025.mail.protection.outlook.com (10.13.2.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Tue, 16 Nov 2021 11:17:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 03:17:52 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 03:17:52 -0800
Envelope-to: linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.140.6.39] (port=51454 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1mmwTH-0004ZS-Mi; Tue, 16 Nov 2021 03:17:52 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Date:   Tue, 16 Nov 2021 16:47:45 +0530
Message-ID: <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c8122e8-1134-473a-b293-08d9a8f2bb61
X-MS-TrafficTypeDiagnostic: BL0PR02MB5569:
X-Microsoft-Antispam-PRVS: <BL0PR02MB556924E822651A037F8193C7AA999@BL0PR02MB5569.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaWR9HJcTaoxjLYrMK7Q4VHH0r3dx3atFw8c5dKZ2ciFQnNzQz46wepa6lOD891BrGf9Cuzx35gb5emWyIx57epNClcKmWOD69Jvnt2n78Sxm+DIQBrniobITMWftUikGfRrkSb6l05S6VSM8XvoPQgkNe67hmcCuaUadrY+PH0I5Hxao9lJCXtM+E/vV2wsczs2Z5GsQi8bTV1kLRinoLYEozOT2zq5RBcquiJeqRJsG/TYKtDmNhwS+QEMDgIat+oEMqo7AciFSDGkcE+xvJXwwn5V9781V1t4za6Zz5qfr/C0kRu8lLfjAWk7bvJvvoLgExs8CRxNIcFltfRU4g5M/1Y+vq6aC/YThG2cGiPUxamN8wwlsEmuH8/2C5GoBF+c+x3DP4YkyoJV1TLfyWlBGgf/FvhmkvokuFh7y8+h2BeodbRjLYwX3C3sjNacvBPUK/qq0c6HxDMMuKYINyXKtprtlWMXid0nTwX/vjJ1ydHXg8zYc/jlUcOh9SFgew+V6G5L/04jL7DdAtidgzYwahF36Z9BFAG5Dql7QTlHDkmbBnrUH0EBsYwSHT9m44i5AgnS+FaItPvXgWSynUQiTNts6o/GZOTofCPjXHy1VNPo/c7wEj5gY5IKb7zdR/sy4O09bb97JOPzCf1EjepLh8CNoW/sjCrdMVQzDOAIf5g6vD+JBJh/nGWImVHG3ICL9Yd8fczYKTg4zPvq8VOmLOWxYhFjMRGaHhKAW34=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(70586007)(70206006)(4326008)(44832011)(47076005)(7636003)(336012)(6916009)(26005)(8676002)(186003)(8936002)(356005)(83380400001)(4744005)(2616005)(508600001)(36906005)(5660300002)(6666004)(82310400003)(7696005)(54906003)(107886003)(2906002)(316002)(9786002)(36860700001)(426003)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 11:17:52.7520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8122e8-1134-473a-b293-08d9a8f2bb61
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5569
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add support for Uart used in Xilinx Versal SOCs as a platform
device.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
---
 Documentation/devicetree/bindings/serial/pl011.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index 5ea00f8a283d..6c73923dd15e 100644
--- a/Documentation/devicetree/bindings/serial/pl011.yaml
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -24,9 +24,13 @@ select:
 
 properties:
   compatible:
-    items:
-      - const: arm,pl011
-      - const: arm,primecell
+    oneOf:
+      - items:
+          - const: arm,pl011
+          - const: arm,primecell
+      - items:
+          - const: arm,pl011
+          - const: arm,xlnx-uart # xilinx uart as platform device
 
   reg:
     maxItems: 1
-- 
2.25.1

