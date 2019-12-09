Return-Path: <SRS0=Yf3U=Z7=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9954C43603
	for <linux-serial@archiver.kernel.org>; Mon,  9 Dec 2019 06:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8722F206D3
	for <linux-serial@archiver.kernel.org>; Mon,  9 Dec 2019 06:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfLIGbK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:31:10 -0500
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:6171
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbfLIGbJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Dec 2019 01:31:09 -0500
Received: from BYAPR02CA0019.namprd02.prod.outlook.com (2603:10b6:a02:ee::32)
 by DM5PR02MB2459.namprd02.prod.outlook.com (2603:10b6:3:47::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Mon, 9 Dec 2019 06:31:07 +0000
Received: from SN1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BYAPR02CA0019.outlook.office365.com
 (2603:10b6:a02:ee::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.19 via Frontend
 Transport; Mon, 9 Dec 2019 06:31:07 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT041.mail.protection.outlook.com (10.152.72.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 06:31:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieCZV-0004ZV-EO; Sun, 08 Dec 2019 22:31:05 -0800
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieCZJ-0000sH-JD; Sun, 08 Dec 2019 22:30:53 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieCZI-0000ot-KW; Sun, 08 Dec 2019 22:30:53 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jacmet@sunsite.dk, git@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] tty: pl011: Add suspend resume support
Date:   Mon,  9 Dec 2019 12:00:48 +0530
Message-Id: <1575873048-14313-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.572-7.0-31-1
X-imss-scan-details: No--4.572-7.0-31-1;No--4.572-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132203466673271950;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(48376002)(50226002)(6916009)(50466002)(4326008)(107886003)(70206006)(26005)(36756003)(70586007)(9786002)(15650500001)(76482006)(336012)(6666004)(356004)(305945005)(73392003)(82202003)(5660300002)(4744005)(316002)(426003)(55446002)(81156014)(8676002)(81166006)(8936002)(2616005)(2906002)(86362001)(9686003)(51416003)(498600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2459;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee6f00c4-6370-4135-11d1-08d77c715f92
X-MS-TrafficTypeDiagnostic: DM5PR02MB2459:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2459E10C3D675C91347799AB87580@DM5PR02MB2459.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 02462830BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3v6nF9Z104+SEYARp56rZdV/tvOINOWVFYIk9ezLPFz1Eh8Qtz50F/RYSjqPJ6vjo5t+2lzFQUCC+CwwHTDj+kiDwLgBzkLGZIl3GzwlXVCwoASv74gqsm06eSdgPeP279ErvgJeg3McvkzYk301f7dQon+1KjgltnYQVbvkO6cIKoHqHfpezlnOqp7uWyKckLz884+H+oU9gbMIVN2vHDlIYH9axTbPWMQLTqHIjG7aCplhcwbPGuVZ74SSZ7tQTv41ZAQVN3gi8yQmKNfqIPrkEhCZu5FnWqHVOxs/QRseJqitsuO7f1oxFpOQeH5efRGZW2NfWU+pa8u1sOdGKIAeg8LEBvTQUOcwoqNJTQz91WkdRJ5hRYQMe/x5hQFUoCazilA/pdzTuP+XdsI2CLZlt6So1SIMJZXcKJ0BHD6PMjukG3hha6lcpjArwsVd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 06:31:07.1650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6f00c4-6370-4135-11d1-08d77c715f92
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2459
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add the suspend and resume handlers for the versal uart platform driver.
Adds the suspend for sbsa driver.
Sbsa is a subset of the pl011 driver.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/amba-pl011.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3a7d1a6..62141f32 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2775,6 +2775,7 @@ static struct platform_driver arm_sbsa_uart_platform_driver = {
 	.remove		= sbsa_uart_remove,
 	.driver	= {
 		.name	= "sbsa-uart",
+		.pm	= &pl011_dev_pm_ops,
 		.of_match_table = of_match_ptr(sbsa_uart_of_match),
 		.acpi_match_table = ACPI_PTR(sbsa_uart_acpi_match),
 		.suppress_bind_attrs = IS_BUILTIN(CONFIG_SERIAL_AMBA_PL011),
-- 
2.1.1

