Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63C2C19F29
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 11:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiG2LsS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jul 2022 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiG2LsP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jul 2022 07:48:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5644887F50
        for <linux-serial@vger.kernel.org>; Fri, 29 Jul 2022 04:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Came900xPZfworgZztO2UX/qUQBZxHm2/tX/bLVwRxkPar2xujSMSayDqLgha9x3L0KYCC1g4OngWYoBZ/LEOlOPWAVV836A/YZBlnJ6qrdN0o3YJ803q75AaFluzI/v2V4UKM3/Hvxl7YGm11Ibn4/y4nshb4ZnxxIOjPuHI5SYcIzGjLyCvzqyR3AaJSOfgGM94puQEfXFxiLyyRZOmEm12z597EbwCdRFszw2TuA/rJg3yNPDfD5m+/BAyohca1wGsbD1LIJ/6aox9EFbbfvtMbgX5r9NJD+H6sUq708zSwqzbukGrE8QKjCfMPfVCndC9DGpLuiuxdUlhXa//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUtb0QZ9zq2RY8DbP+9SPGORnzgtT4ZMKE8RGjl8+sc=;
 b=Wi7DBDprikMD9B5i/xPUTY2YsFj1H4BTz/plRwNaExYFM9JpVVh7jXGs0aCkRnXwGAU4POhpXFxm+uvZg+E6pE4upJS+OeU3U6zpfaJ3+lxKyh9m4XBq87mmNCfECNeUgpXMs9yFQ5Qzb/CUEj+iQwN5+dFG5jWCXYgiAsD1UVF9bDaDQRxhgasCQ2P+BvD/RMQupN+wDggwF9BUWhepSKIckWqydQP2Y3smkOTO+ocODoznpSOLaJIEVmQHezsK9fhDewBWj1p0FIcXeJXpQgppLaUb0hPLWI0vOTfjxScvz/k9V8pGp5a1TvF4SJSKmWpl+8TObojr1eT3mkIs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUtb0QZ9zq2RY8DbP+9SPGORnzgtT4ZMKE8RGjl8+sc=;
 b=bmFKscSoW0EpOYV6ReVS+Bg2byS3qZfpR7s0UURvyyifYzUyByE9gyJJHqdrDyY7f+sk2Q11JZZINOdjrTV7QAkHNdoUB1DR1yxAe9Ac7MBZuI7ckt8z0iMZMaNxyH4eDP7L1E3fX1rF7qKWOCV8q1aUoes2b1rHBJnv4GzYwOU=
Received: from SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42) by
 CO6PR02MB8788.namprd02.prod.outlook.com (2603:10b6:303:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 11:48:01 +0000
Received: from SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::48) by SN6PR01CA0029.outlook.office365.com
 (2603:10b6:805:b6::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Fri, 29 Jul 2022 11:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0041.mail.protection.outlook.com (10.97.5.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 29 Jul 2022 11:48:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Jul 2022 04:47:59 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Jul 2022 04:47:59 -0700
Envelope-to: linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 shubhrajyoti.datta@gmail.com,
 git@amd.com
Received: from [10.140.6.18] (port=57946 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oHOTG-000DJo-Pf; Fri, 29 Jul 2022 04:47:59 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>, <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 2/7] tty: xilinx_uartps: Update copyright text to correct format
Date:   Fri, 29 Jul 2022 17:17:43 +0530
Message-ID: <20220729114748.18332-3-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
References: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e60d2ed-c3e3-4c17-9a23-08da715830ab
X-MS-TrafficTypeDiagnostic: CO6PR02MB8788:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+nSGZXVRT4lXSLRjn3yKVjjqw96jlqEQTu1rCiGY1WWKVTDo1QsWj5JYDNsDh3FsnJvGjCClO/vgjza6TAlof3eVXtDT6SCIR4squC7obSM8uxjunKIPRmhLYlaQby8gdKqcTFEu9lBC5qbtGJWo3T4fLTSdkBzVvG2isGhuk92/13YZtF8T2Sy4G+IoVKuZFKk86vsJxXp6gwlYYPDVaZOimb1N+W/Q9xsU6EU4vtEftVxtoWe5oHc5j2NQp+7LUWouszXT81wRPUNe1A7YDemPcJTHJxpdIea4WcBwi6tZO8ns5gdsD05ghVxwvVa6cPUW/mBeFeS+QSDSZRYXigpI7TLOEvbC5XV6vW5RzbP1vZ4lg+pGc3uYp/L8FGGktJcOQtNSq5CHVPsyqIovNotQiF+kg2ZHHeUlkKdICGQ2lXk5RX3EC9ll0mdKwRE6qc9iwS7x/81VjXQiP9CjNSlQWSAnxv54Ge5A2hZXPphOifQfXlCDeaamNqSmhYLgUc8+WNRZnfUHDXd1qnNOrv1N2ushEL+6l8JR0doTv+J2L88tgRXNCKX5H2L3jdu9mNtzhxBugFO7DK5t4EZP9w7EdFXSQRIYP/f6p1Lf3nsHbHBrCRkHSH7gBxN5ffPB+mgO679smzjoZB7MU61dD7enpPrhDjEijBXnvHYlXknvkk2ND9ruujJR37SLsMUptqiC1hvMnI7iBvrFvXkQRDJBWzpsqmSj5V33A3K00pp6dS+wAoEmtbNaviZTEPKr8DcyZxEnAy2AVJRzDlMmFbLfqdg8l8HVTePpw81CDO8ZgQcGbfwtucb/qtEtRqEiMYoCWAHze12Y+O4W4iHYQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(40470700004)(46966006)(47076005)(2616005)(7696005)(107886003)(186003)(54906003)(83380400001)(40480700001)(6916009)(41300700001)(6666004)(316002)(336012)(2906002)(9786002)(5660300002)(8936002)(356005)(4744005)(36756003)(44832011)(478600001)(26005)(40460700003)(1076003)(4326008)(426003)(7636003)(8676002)(70586007)(70206006)(36860700001)(82740400003)(82310400005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 11:48:01.2866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e60d2ed-c3e3-4c17-9a23-08da715830ab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8788
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

Based on recommended guidance Copyright term should be also present in
front of (c). That's why aligned drivers to match this pattern.
It helps automated tools with source code scanning.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 51fd09e14eda..8d2c21718869 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -2,7 +2,7 @@
 /*
  * Cadence UART driver (found in Xilinx Zynq)
  *
- * 2011 - 2014 (C) Xilinx Inc.
+ * Copyright (c) 2011 - 2014 Xilinx, Inc.
  *
  * This driver has originally been pushed by Xilinx using a Zynq-branding. This
  * still shows in the naming of this file, the kconfig symbols and some symbols
-- 
2.25.1

