Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6D3C11F66
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 06:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F10E611C0
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 06:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhGMGvg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 02:51:36 -0400
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72]:33403
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232908AbhGMGve (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 02:51:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyWvz1QiHvWL3awhbTda3GtYrijweZcvtg3DGqeP/FdtHPjiLdNC0ZdTJ2VdV+HXElx+Bwa1sYgmAVS5rwD3rwO1a6GS+1oMwXboKZyc7oYQFNd/VoksH/eGA8W1MQxskoDcQVYz/pXZ/P7hVdqTJ+TCiUfuzapkA4FzSHMCUzvnXt4MSbvX2Mpz5MD9dG4vrBldG/1U1ciYEY/WDzWkSJtzjZWArr6q5XJ/CLJ9Ub3Yu5xdsVtRqyQih5mZCBf6aGIWtwbAMzfKQbF4+w3it7FmGNMjL3T+kdBTyhs1E2DbEL+Gqa9wub+lFFz/5W53WzcZBNwB0t5PbntyABnFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipq38+A1UbYXoGMDg5WT1P6A5iCCFAOmC+BnkbRmlTo=;
 b=kfRtVdbdGlUM9TtXpCrBiva8ZU3ZnzzIIw8nG7X5LFsw2/c1w7I3gpHua2TQhQMo0V3u0PPXchuJ88Cs24QmPbao1u4XaQr4ZTFGhhvCRd+tr2j1l+egSyrAiC9Gq04EtOdG+JaEzC4Fmad28vGGxR84/xZhf8OODFCvOaEZbMkAbZZlZCqWHTitDDpOV7r69fRXH1jPWZh2ZzWzhytuXgzTL2uW93mZMdOOaSKjyRosurB68qYkPIStHSsyrdX28Zs81ismlwut2ORKvqylSoBjV5JIY0ORsCFq19XM94dbKq0o8G96cbSQbFACdKlc+gX5oORVnR31tthzXHrtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipq38+A1UbYXoGMDg5WT1P6A5iCCFAOmC+BnkbRmlTo=;
 b=ns7vd0kjR1VQfalMxGnUodsDUBeFeZjO6e+44P8jihGr4MhwvvbYUk/ziNktcEGwPB/U3sEgULw6WVAvd2tMStoJmczFe6HvyJlksPZMGXFt71TVNhWigDWw0s23obj8TIdkWSczBIUicGFQom7EZE4U5Eam7WdRG9L/vin1p6M=
Received: from DM5PR16CA0002.namprd16.prod.outlook.com (2603:10b6:3:c0::12) by
 SN6PR02MB5231.namprd02.prod.outlook.com (2603:10b6:805:70::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Tue, 13 Jul 2021 06:48:43 +0000
Received: from DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::b5) by DM5PR16CA0002.outlook.office365.com
 (2603:10b6:3:c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 06:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT062.mail.protection.outlook.com (10.13.5.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 06:48:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 23:48:41 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 12 Jul 2021 23:48:41 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.140.6.59] (port=58696 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1m3CDg-000Gjm-Ln; Mon, 12 Jul 2021 23:48:41 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <git@xilinx.com>, <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 1/2] tty: serial: uartlite: Disable clocks in case of errors
Date:   Tue, 13 Jul 2021 12:18:34 +0530
Message-ID: <20210713064835.27978-2-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210713064835.27978-1-shubhrajyoti.datta@xilinx.com>
References: <20210713064835.27978-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aafec82-7c71-41e3-7f9f-08d945ca4188
X-MS-TrafficTypeDiagnostic: SN6PR02MB5231:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5231D159966F0DA4523B36BBAA149@SN6PR02MB5231.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irbuZxGNxmCVEWWOXXiBSMs19mGnDMvQL9fP5BGRb1lH/lSQLD7c/o8EGBgCETmZSzbXMYlo0LRLkFoL6aUk8MT6ZyD0vpuO+pOilbUg+nAZmZkVo2M74llmKRKrCSygo4K8L/TXZe3ST7AJKSHDRAOLP9FqWpmnohk9ok0VsZ5Qa/MaGnNTk5jp607Mrwb9FdgdPDb+bVQh/cPXt7AdllxjpyW6xMnKIwprwwDxHo8kHjtjyZOm/oNL1RzQlepgPkGXhf4cv+/TjJpIpLOaqm1n291G45xVOGdPpEg/OtvlyhwQxQwlgjf4+6jq5Feik35OynPEHgRBgzIEwbsSOMuQ/MJ2RNkSOcVQ5Ev31bRV9hKA5Vr2T2113Fw+Sk9UuNKmjSVUz+lL1X1Tsqc5EO1Fd2aRZ1UeR7n9D7LUte/ZI3BheCkxtCmKldwT8OX5JtMLpLN2cuS/QbxCmJMCz2m7IGZ9JC5i66C1M/ArvtjuR5b8HyzDW8qN2zXdnyJQ9gn/2LLGlUoT0GulfZtqX9gRvRg8dq9XLMysLNR5wj8iGsfRkSAzrbDzPW7x5VADTti8WegZ8G5qBhnIDTYlFrckFb0mJOZqpNyTgVcbYrTkyTZQNPYotUeKp7rsd0prfRgQTSj3xLBYyHkorXKUj8dNuk7airKZsXF56UZf7yo/lG+5F7KgGSySfZvzOP0LAXDSuH+Rfm5x3E8b2H4vlGx2Y+nFJ7CwPOFGoL5rbxU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39840400004)(46966006)(36840700001)(110136005)(82310400003)(44832011)(7636003)(1076003)(4744005)(186003)(70206006)(107886003)(8676002)(54906003)(316002)(36906005)(47076005)(36860700001)(36756003)(478600001)(336012)(6666004)(8936002)(426003)(4326008)(26005)(9786002)(83380400001)(7696005)(2616005)(70586007)(356005)(5660300002)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 06:48:43.3901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aafec82-7c71-41e3-7f9f-08d945ca4188
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5231
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In case the uart registration fails the clocks are left enabled.
Disable the clock in case of errors.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
remove the go to

 drivers/tty/serial/uartlite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f42ccc40ffa6..fd7a2f82c885 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -799,6 +799,7 @@ static int ulite_probe(struct platform_device *pdev)
 		ret = uart_register_driver(&ulite_uart_driver);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Failed to register driver\n");
+			clk_disable_unprepare(pdata->clk);
 			return ret;
 		}
 	}
-- 
2.17.1

