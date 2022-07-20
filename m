Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA680C43334
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jul 2022 14:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiGTO0Z (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGTO0Y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jul 2022 10:26:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D0D3ED68;
        Wed, 20 Jul 2022 07:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpj/s+lppKZqWrn5gatqrPCuzbc1my7GZExF/diijnZV7JzJCgfw1/Xq+FCfp+RPbeo1pcY5CmqViv/Kqx/Fi32yEuGFH8bXmTceg3A30IZpSap4RQhpaohmcT97rdiLekgzqBdkzn/HHwv0s+lX7pAkCY6M8OZh4TLWexJVksRnzLjXfhouD+LZ9UCCiJUOOiWpQ932isoYn8ARdRKZQz1+nO9/j+s9YyXbt49mPdCkeerU4gyyRjhfHEMAnn8xOcqKYMLXyHcZsCGg8Q7bKcvdoefScUVE2KrFc7CTWII1+X048RJ2UG2gm7kz+nfshu4FzAFH5wbRCBfLCzQaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRYfdJvrOs+sZvH+MTLrzXCbSHS5XhTJltq83gLtT3Q=;
 b=QtKTrAu0Ycps2rvKH2MVPLt76rduOWKCT36uw3gb9z38U8p6dl6fHG+u+J2f1eaG9zUvpSRRCSVjwn4vNKnDhFXHK/d+1H3zNYRRM74u9K5i+Mxf4C8og5JnBmzT0mrDuTymMnSd553jkCSr69Z13S705hCR/mQZ4vh7SZMU/ZSkS8LzPZmJ3QwxToXobEztM2xOfO3kwPe3rqUJUPVw3BNiMKpTjfg6IYTKvF8JQl2hXzeo9+VPCegea5GBeD9FnlEwgUqwcUtiIPLqXI68SDfwNhjNebUbLm4RiBYFeLiObJoAg8a5gOXZjeWHuwltfRj1ulmAIukKdCPlytxTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRYfdJvrOs+sZvH+MTLrzXCbSHS5XhTJltq83gLtT3Q=;
 b=RT94h5Gt27+orC6mqaJ/qFjWt5/rfAIUafh7DCsxd5Q7ky0i562s4gyHOVQehCnYB45wp0d8mV/Ny/UeJe1ljwEUaoTYl6CEH1UyDuAMPfYG8k5H/lPSmpbVh5LgnaUxY5BinMLXL9l9X52NxGJ/MilqQWlQmIVrkrv08NYHES0=
Received: from SN4PR0501CA0022.namprd05.prod.outlook.com
 (2603:10b6:803:40::35) by DM6PR02MB5211.namprd02.prod.outlook.com
 (2603:10b6:5:49::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Wed, 20 Jul
 2022 14:26:19 +0000
Received: from SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::e6) by SN4PR0501CA0022.outlook.office365.com
 (2603:10b6:803:40::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.9 via Frontend
 Transport; Wed, 20 Jul 2022 14:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0060.mail.protection.outlook.com (10.97.4.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 14:26:19 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Jul 2022 07:26:18 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Jul 2022 07:26:18 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 gregkh@linuxfoundation.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.59] (port=55844 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oEAeX-0000jg-LR; Wed, 20 Jul 2022 07:26:18 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@xilinx.com>, <shubhrajyoti.datta@xilinx.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Date:   Wed, 20 Jul 2022 19:56:11 +0530
Message-ID: <20220720142612.19779-2-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220720142612.19779-1-shubhrajyoti.datta@xilinx.com>
References: <20220720142612.19779-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72586925-0de9-4c2f-9e35-08da6a5bd060
X-MS-TrafficTypeDiagnostic: DM6PR02MB5211:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdNtVTVCN8PQMBepJ/oQ3ftUMfwfUxQdy7Fx/dpxFyA/ABSv9k7cIEsEYB/juxFvRzhaU70g1dEbd0HJemz1Xvo6txUz8tjZqwssNSkJqd6cdmOKVCaeMGRpNhkO3NzjZCVxS8kqGUy+tvQyn9LtM++vENGcSjfSI9Bp5LxHb3W4dccGLKCm+yjOwcMtywYHE9DRx5O2YP+ac4L55/3a81i93/Ygk0yX6C0Ygkh+LU3bTCgwq+/QkDFnS6ghu5FB8a79RPjE3enbKDv5zX7RyB+oCsKvz6dEmDEq01y54ZJCLkyyCamAVzccQeSLWvgLcVouxe2hXjnAmw3sLrq1QOXRtE8DArbSbpXZL8Nzd/if09Mtl1L43/6USchl8dKlQ04nXIKC3CWt0O/4RtVCRy9zkASlZ/hdlxWr2Wywv+LiozBg4YPSPaXCzJAGAgp+F12u8UGrD8yyFptUzDfshadF2NvhfQUC9lt1ZaJArgnJJPpklGJgNjm9ncDM3ZdPqGRSnsDJTIm6LUvhrUXpgN+gBAn0pXKDjcpyn52gCYtwzv/hpQrJ3lQj7zMiFai5fzmkjjYQztFT8+6f4MKeLcjABxHSzEEhTdPN+itUY8vGhpJJrrExTge8quJ3lmoao7H8xgUcX7XjqRPFWNcsoES+dw1+tsUcHyCI0bhM1kxDifEvZN//lAjnzl5z84tIwd5sEYbMghcZ6OBLYKA/+NRp6sbdsGeJyG/aXOQc3uFCnj5pcVjVtwCtw4qYwT2RT+7cLSokihJfXsCbPFCv31hbCAImH3y3oDNAmX5FfbV1TxWlUq+wkyXixf7pA9tjcffDhXCxR8Nu4qm/ElRRtg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(346002)(40470700004)(36840700001)(46966006)(70586007)(8676002)(7696005)(4326008)(70206006)(8936002)(186003)(82310400005)(426003)(47076005)(336012)(6916009)(40480700001)(44832011)(83380400001)(356005)(82740400003)(54906003)(40460700003)(316002)(2616005)(478600001)(36756003)(5660300002)(6666004)(26005)(9786002)(36860700001)(2906002)(7636003)(41300700001)(1076003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 14:26:19.5813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72586925-0de9-4c2f-9e35-08da6a5bd060
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5211
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Xilinx Versal board uses the arm,pl011 ip. However the
axi port that it is connected to has a limitation that it allows
only 32-bit accesses. So to differentiate we add a compatible.

Add support for Uart used in Xilinx Versal SOCs as a platform
device.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
---
 Documentation/devicetree/bindings/serial/pl011.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index d8aed84abcd3..bf094ab93086 100644
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
2.17.1

