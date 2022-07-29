Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724FCC00144
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 11:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiG2LsV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jul 2022 07:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiG2LsU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jul 2022 07:48:20 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1798A74787
        for <linux-serial@vger.kernel.org>; Fri, 29 Jul 2022 04:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUNr7HGyugRCzEtFqnYLxc4zVlaRSfYGvTNsEHFQUce0AhSxg5drZmIomS6V3cNkvuOKKO5jOeqFDYnz+eDFoOlLtQ9qa/HVy3bx1/klpEwQnvfCdJaMMUomrGJgjS1LD8wRv7uECcYk6nnNVgu6y0m/JD0ghZmTL9J4NbSLGuPx3iB/9Vn2jBanNXkUb07ic/txtTPWj7W0Xx8X+BSdY6lllEFlFtHAEe9Dj5T/ntS3YZXuy4wQf1Lus8y//gC/DGjrs0XumN/jR/mFbd1B/esRnWEMlzvCvOpWNw/JfiJ0OanUJyJarhXh/Bf2e/FrtpXrAx3cMtbYqCi63CphcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1Sk+2WqL7TLYvL0w+umQhiAMZRbQWcWfSzyKzm6JCA=;
 b=WBIDU38PkUy4Dy3WcMzhxANxAmwGReYwjtd8nzQ1frsYFHK9vhwd9An7HYKyJAWpdPQ8vwpkPi6qwvi+ah5EW9eI1IHa8ZH0+F0mJAFU8quSS+2+a09GvwxPdTCgEmTqCPsN2S4z3/JWMrp9sKnwz85p4ojWA4PQqqxvlZO1egr214IkbGc8mWNzRTbDu/l/PDzNnphx6fqnWO6G2UaF17oKuXnB0+K+y5DMrVowLTDcTFW8eHyvSyD3+tgksLc+jD52gCTKeYZjjdbTUG1Mj6GpA+IhcflXaGexIhz3M/2+UX18c3+JhbcQ0VeTdt33uD3P1TpCxxqxLCRDnBR78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1Sk+2WqL7TLYvL0w+umQhiAMZRbQWcWfSzyKzm6JCA=;
 b=pmkZ7ojbJ9xsrJa2MGmAzg9ce71o1vZ2NgQ101ZrUeaePrlBrigeJFRo/ls6I/roKngXFam/dhCVF6NKSn5baUijtD+pMJBd8T0FucUJopYKEqeOG4HvUBjKCM3bJhvQVis4wNmsG4DLlDYZwDCEzI12m/H2bw9+kr4dy477iWM=
Received: from DS7PR03CA0206.namprd03.prod.outlook.com (2603:10b6:5:3b6::31)
 by SN6PR02MB5246.namprd02.prod.outlook.com (2603:10b6:805:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Fri, 29 Jul
 2022 11:48:17 +0000
Received: from DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::b) by DS7PR03CA0206.outlook.office365.com
 (2603:10b6:5:3b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20 via Frontend
 Transport; Fri, 29 Jul 2022 11:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT025.mail.protection.outlook.com (10.13.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 11:48:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Jul 2022 04:48:12 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Jul 2022 04:48:12 -0700
Envelope-to: linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 shubhrajyoti.datta@gmail.com,
 git@amd.com
Received: from [10.140.6.18] (port=57946 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oHOTT-000DJo-L4; Fri, 29 Jul 2022 04:48:12 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>, <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 7/7] tty: xilinx_uartps: Check the clk_enable return value
Date:   Fri, 29 Jul 2022 17:17:48 +0530
Message-ID: <20220729114748.18332-8-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
References: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 174d1abd-dd0c-4560-ee0a-08da71583a4e
X-MS-TrafficTypeDiagnostic: SN6PR02MB5246:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alZ2FuZKcybOicrMCd6jXT5qbR9hq9vKI8FcRe9vvPe+AOBMO007fEd0JM6CfMUYIr1ZaAITdGmioJoniU4yp2u8IkPrRiK29mc2ImK23uuFNdfAZPcz3l6xqdoE6bkoG5rkI5YDOPBb1tC6tVK0o7nHf/nFbAt/IAjYjsCDGAjvO8juUshP33M+pgc02EPZ+xzsQNAM9tlRqK7gpmnh919sSBXoKc9oFM07n6kCTiazfm155BH4awzGhRvqsKDL+OO7XNpKHxXm/dX5iLpP3b2J57y3YXfI61J/C6b/HiRf221+MhFTgqNc1aRDAFT5vVMU2zVcaWI3cwnPDTy0wR3r4DZ3NImtwt+d8+ZZFOMlXUNQzrxHFcu6jb3r3WjbHfeitwS+NocJrU6dxqC+tTMlYD7xUXwi4sLEM716GVHYWeP4RYIIlqfLqmZQy5bZDFYysuKD2ZqntAFstM6frOMnIMvJfYtVlaiqr1FDCwoxndK7V69ONGbu31S/twluG8gKNItwOgVcfbooYpAc6iIjwTOCuSVb58Dqx3O0OCMEUltGY7XEgCeO58EvOuUCGgidFj/6J25L9YtSfCYssiDUobsBjquSAGT+6RU9YNagPK2NhzCwPw4V4/A232qtF+xveAqYXJ2PVeXa5xjjy4GQSQKdLmJoKiSoUVaksR+CQouQed5oCVb1e3KM0RHbTavVc37p9xmi46AGLJR9iZJaaPJxstYvD9hzvFNcI4ezMRu1SZcV5/KbJVmiD7Jp6PCQEeYv54eDztPzEjSRP3bmWFART8VkPv0dbQUEaNESKcTVTXcscN5J/NYf6DMHVASS817nJG7wAGZbtE/92g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(40470700004)(46966006)(36840700001)(6916009)(4744005)(40460700003)(70206006)(70586007)(82310400005)(186003)(44832011)(54906003)(478600001)(8676002)(107886003)(6666004)(26005)(4326008)(1076003)(336012)(316002)(7636003)(7696005)(36860700001)(2616005)(40480700001)(82740400003)(2906002)(8936002)(356005)(36756003)(5660300002)(83380400001)(41300700001)(426003)(47076005)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 11:48:17.4721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 174d1abd-dd0c-4560-ee0a-08da71583a4e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5246
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Check the clk_enable return value.
If clocks are not enabled the register accesses could hang the
system so error out instead.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a1ff03f24f51..1dab870aa585 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1420,9 +1420,17 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	struct cdns_uart *cdns_uart = port->private_data;
+	int ret;
+
+	ret = clk_enable(cdns_uart->pclk);
+	if (ret)
+		return ret;
 
-	clk_enable(cdns_uart->pclk);
-	clk_enable(cdns_uart->uartclk);
+	ret = clk_enable(cdns_uart->uartclk);
+	if (ret) {
+		clk_disable(cdns_uart->pclk);
+		return ret;
+	}
 	return 0;
 };
 
-- 
2.25.1

