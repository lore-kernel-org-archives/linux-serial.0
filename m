Return-Path: <SRS0=QEsI=ZE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA21DC43331
	for <linux-serial@archiver.kernel.org>; Tue, 12 Nov 2019 10:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89182206BA
	for <linux-serial@archiver.kernel.org>; Tue, 12 Nov 2019 10:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfKLKpH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:45:07 -0500
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:35242
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfKLKpH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Nov 2019 05:45:07 -0500
Received: from MWHPR0201CA0017.namprd02.prod.outlook.com
 (2603:10b6:301:74::30) by BYAPR02MB4886.namprd02.prod.outlook.com
 (2603:10b6:a03:46::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Tue, 12 Nov
 2019 10:45:04 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR0201CA0017.outlook.office365.com
 (2603:10b6:301:74::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Tue, 12 Nov 2019 10:45:04 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 10:45:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTbs-000235-Kj; Tue, 12 Nov 2019 02:41:20 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTbn-0008AE-Fk; Tue, 12 Nov 2019 02:41:15 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACAfEQC018000;
        Tue, 12 Nov 2019 02:41:14 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTbm-00089t-A6; Tue, 12 Nov 2019 02:41:14 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jacmet@sunsite.dk,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv4 1/4] serial-uartlite: Change logic how console_port is setup
Date:   Tue, 12 Nov 2019 16:11:08 +0530
Message-Id: <1573555271-2579-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--8.857-7.0-31-1
X-imss-scan-details: No--8.857-7.0-31-1;No--8.857-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132180291041873495;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(54534003)(126002)(48376002)(9786002)(305945005)(2616005)(426003)(476003)(2351001)(2361001)(26005)(81166006)(8676002)(498600001)(336012)(86362001)(47776003)(61266001)(486006)(8936002)(81156014)(9686003)(73392003)(5660300002)(356004)(6666004)(76482006)(14444005)(50466002)(36756003)(82202003)(55446002)(70586007)(70206006)(4326008)(6916009)(50226002)(2906002)(16586007)(51416003)(107886003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4886;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cc5b071-b869-464f-88f6-08d7675d6043
X-MS-TrafficTypeDiagnostic: BYAPR02MB4886:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4886E7246FE2613585213EC887770@BYAPR02MB4886.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZUlkchc8JgAAs+4vNa8Y39MGGffnh06XztwLKkAsUByzG0Gob1E+zsmPIWVbhxp9WmV+HRLinAd0KK6PYThtUf4+RBBfwrNNpdJ98tsuttY1uTW5ru82YlvnTzy26cplX6KSOFJiOvTsRoUrgVnvLpuAh0yhfY/uk5+d9hDLYbzhUln2dDj4HEzUSAopiiVoyP/XPxVB727rx7dpmgz6pJbexyDAX65W/HvUu+aAYernu7+1engi+V2QUg66EtgeGdCPdwE7QnCl0yxW5cea2ATut9BFUvt4LSdVcSkyX4+A3bzhptGnmE7vXurd+BtrJSTR20Q7m1GCBHMADHlfuMCntSMQ2o7e3LmrICwzicBwNuID7asj8qBe7++oJD0JXmi+gwJBdvrxmqamK8xDqd0ktGFkUs6GJXdliAcd80eTaE92OnFgv/3l7JOkRbc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 10:45:03.9131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc5b071-b869-464f-88f6-08d7675d6043
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4886
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Change logic how console_port is setup by using CON_ENABLED flag
instead of index. There will be unique uart_console
structure that's why code can't use id for console_port
assignment.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v5: fix a compilation failure.

 drivers/tty/serial/uartlite.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 06e79c1..8b39b2b 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -665,7 +665,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	 * If register_console() don't assign value, then console_port pointer
 	 * is cleanup.
 	 */
-	if (ulite_uart_driver.cons->index == -1)
+	if (!console_port)
 		console_port = port;
 #endif
 
@@ -680,7 +680,8 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
-	if (ulite_uart_driver.cons->index == -1)
+	if (console_port == port &&
+	    !(ulite_uart_driver.cons->flags & CON_ENABLED))
 		console_port = NULL;
 #endif
 
@@ -864,6 +865,11 @@ static int ulite_remove(struct platform_device *pdev)
 
 	clk_unprepare(pdata->clk);
 	rc = ulite_release(&pdev->dev);
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+	if (console_port == port)
+		console_port = NULL;
+#endif
+
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.1.1

