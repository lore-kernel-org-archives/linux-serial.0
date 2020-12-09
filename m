Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B9DC4167B
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 12:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50AA23BDD
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 12:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbgLIMTr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 07:19:47 -0500
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:47553
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730428AbgLIMTk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 07:19:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vycu6D2mtwYTKhu8IYKaarJh0eaIdjzD3E2TeauikTstlQ/tZ4tSjSzhiPCyaE0A5SjoO08dvqXY3VwKmBEjsgxo5PKCQ5Bir0YgMnmhZOVKOz5Q5D4xkJ/c+cAlbgXl8EX/5EgfDXVAcAIQfDgWtKncL4EQgO0Z+gL/O5RRSVi0d5MWrT6zTEJ1Wc51c5nU0TKoIop+YYDwzEjunKKKRekMzBIOJCrcgm1FP2FRWm66ecp7pbO18cn+8C0xjZpYqw06sOi21Zi4vIXCPghBJ89pA9N4tsLhYJ2HRMi4gxMDfecxTbu83lfDrykCsBv5yruaA9uPDroSAwuEu3mDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zImqs/OFkjOnol/Bm/DqXVqF74CdIjzNGTY6f/GgotU=;
 b=K7eSp0UEjK1jCUq1V36JhlShrOEjFNG8p5JVc9QX52dyxz1nxSejQ+8czstgwEM50eNavGhA3xhRHmbvAVKc62Y+BkLAELl6/WL75aoe20FiP8XfXeFpHlq9VzPL6LtOk1FeTwZ5lGPP8fYzuiKLklHnsLjfA427r3+jkYr8pSU10/6ED0uQwoIZr8wQiVBJ0lwr/wt40oTiKsA7irnok+sGVdnHj6qguHa8NipCmJ0pifyVS9ygpGmXG9q2IYOKUwZ/3oxq8F82mc40PcFEDSeqs9DxDyhE/va2IYHoqyeirv8OftvKEOZcfOwFu6tWbiHJYxeEiULo6t9lOceDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zImqs/OFkjOnol/Bm/DqXVqF74CdIjzNGTY6f/GgotU=;
 b=FlGWuGodOKLuxxj/WvOuUah6mh3E1EZTQP2UawcH25yffNwPy05HI1Pw/gH6hxr7IvkhQZPPcrX+UWTDFkPjOLieSvDKhzjetZvR4zQdQhizwPFJYX0yb93vvL7ATjPeSk41ps2JqWzqHNsjeCKnrJi57wmyrrPURDgyCC8lAig=
Received: from CY4PR2201CA0016.namprd22.prod.outlook.com
 (2603:10b6:910:5f::26) by DM6PR02MB5067.namprd02.prod.outlook.com
 (2603:10b6:5:41::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 12:18:47 +0000
Received: from CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:5f:cafe::fd) by CY4PR2201CA0016.outlook.office365.com
 (2603:10b6:910:5f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 12:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT057.mail.protection.outlook.com (10.152.75.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 12:18:47 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 9 Dec 2020 04:18:26 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 9 Dec 2020 04:18:26 -0800
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jacmet@sunsite.dk
Received: from [10.140.6.59] (port=53746 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kmyQL-0007Zm-Bh; Wed, 09 Dec 2020 04:18:25 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@xilinx.com>, <jacmet@sunsite.dk>,
        <linuxfoundation.org@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/3] serial-uartlite: Disable clocks in the error path
Date:   Wed, 9 Dec 2020 17:48:19 +0530
Message-ID: <1607516301-26975-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d176a82-5572-4d81-c6f1-08d89c3c9454
X-MS-TrafficTypeDiagnostic: DM6PR02MB5067:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5067F730CB9477FBA19AB138AACC0@DM6PR02MB5067.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJl4UKk/YWZ47CAb+B/8K3HAAulysJHW5V3GIpc1gZMvI8U5O+wD39G6iU276eI9QzJU+yS0xBLZMBWt6hgR43JOEva6ZWmmGp8kAnHw3iHA7fdCJHgDkI1Zl/a2CwiC1iO8Eb1MuKfx2vN+iLzQV6m+GGLjUT8lIzHuD1CH7xcG7+jXPTgzq6p/if/4Kb/PL+OTsz4aowYO4ELUqOHxqLiqnuBzr4fTunCxC5IVrkZ4vJ+lU1JQLmBB5fLepnn5lTZgjN4Qmh05RNn0PoUl8xFupTclwNyCryqtnItJN1BrZm8n7r5FxZWVj+TBrESxwKofy/chH3mE3uOjxmexzlGGnXdTEj1awoN7E22DtMTmN49FJteRJ6frUDgmAFirNAVq3Esu/ae4hCxm5d1vpSQaD9b5TxW0HqQr4E1TF/A=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(46966005)(336012)(7696005)(8676002)(186003)(54906003)(4744005)(36756003)(7636003)(36906005)(6666004)(426003)(508600001)(9786002)(4326008)(82310400003)(44832011)(2616005)(356005)(107886003)(70206006)(8936002)(47076004)(5660300002)(2906002)(70586007)(6916009)(26005)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 12:18:47.2850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d176a82-5572-4d81-c6f1-08d89c3c9454
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5067
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Disable clocks in the error path.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 09379db..ab4954f 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -799,7 +799,7 @@ static int ulite_probe(struct platform_device *pdev)
 		ret = uart_register_driver(&ulite_uart_driver);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Failed to register driver\n");
-			return ret;
+			goto err_out_clk_disable;
 		}
 	}
 
@@ -808,6 +808,10 @@ static int ulite_probe(struct platform_device *pdev)
 	clk_disable(pdata->clk);
 
 	return ret;
+
+err_out_clk_disable:
+	clk_disable_unprepare(pdata->clk);
+	return ret;
 }
 
 static int ulite_remove(struct platform_device *pdev)
-- 
2.1.1

