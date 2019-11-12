Return-Path: <SRS0=QEsI=ZE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6A6C43331
	for <linux-serial@archiver.kernel.org>; Tue, 12 Nov 2019 10:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A062196E
	for <linux-serial@archiver.kernel.org>; Tue, 12 Nov 2019 10:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfKLKpJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:45:09 -0500
Received: from mail-eopbgr750075.outbound.protection.outlook.com ([40.107.75.75]:45060
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfKLKpJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Nov 2019 05:45:09 -0500
Received: from MWHPR02CA0002.namprd02.prod.outlook.com (2603:10b6:300:4b::12)
 by DM5PR02MB2457.namprd02.prod.outlook.com (2603:10b6:3:44::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 10:45:06 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MWHPR02CA0002.outlook.office365.com
 (2603:10b6:300:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Tue, 12 Nov 2019 10:45:05 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 10:45:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTbv-000236-QN; Tue, 12 Nov 2019 02:41:23 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTbq-0008Bq-L6; Tue, 12 Nov 2019 02:41:18 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACAfHsU018051;
        Tue, 12 Nov 2019 02:41:18 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTbp-00089t-CS; Tue, 12 Nov 2019 02:41:17 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jacmet@sunsite.dk,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCHv4 2/4] serial-uartlite: Use allocated structure instead of static ones
Date:   Tue, 12 Nov 2019 16:11:09 +0530
Message-Id: <1573555271-2579-2-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1573555271-2579-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1573555271-2579-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.678-7.0-31-1
X-imss-scan-details: No--6.678-7.0-31-1;No--6.678-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132180291056811555;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(86362001)(48376002)(73392003)(9686003)(426003)(54906003)(5660300002)(50466002)(336012)(446003)(305945005)(486006)(126002)(476003)(70586007)(47776003)(2906002)(11346002)(316002)(2361001)(2351001)(70206006)(2616005)(61266001)(16586007)(82202003)(9786002)(76482006)(36756003)(55446002)(498600001)(356004)(6666004)(51416003)(6916009)(8936002)(50226002)(4326008)(76176011)(26005)(81156014)(81166006)(8676002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2457;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53cf141f-4e93-4c7b-ff9c-08d7675d6128
X-MS-TrafficTypeDiagnostic: DM5PR02MB2457:
X-Microsoft-Antispam-PRVS: <DM5PR02MB24570CC8B2A1A2CF264F52F787770@DM5PR02MB2457.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVnfsGALgoe5rZbo2fOcyB4DqmqZMWmbqLQpEJ1zI/lFrEsoaK6bC5Ie90woDaWfm8RsStRPFDmGxxIqZH7WhwmU7wezAZS59VFnjJY2dTrdvSwM94oYlW+VzD2oshep+GXtVwpTNMvQD+B+07gffBsYjeKo2O+/dyuPu7/xqe05e5l4j9L0ryfIDv76EgVgTymJrtDpYcEKxBPKf0WyBD+svwsD0TuLhaDM1CM1dAD531EA3wyHkuyFFTvCnWlL9QseFVjC+XKWzsh90Yv0E85KIORBz5sG5sS/BWB1r98EOS9FletEjNPW1TC+9tfnhZjCagk5w6k5CqacU6D4afEwaRcvgwIjCvu5LuSmhgLud4Qao9yRLLx+xeCkIKrcSQM0K4trSHH/0VM3HeQ6JnsIApggUAGKrz2FkQuG3T6j67innszyKPnXPv1nRtJp
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 10:45:05.4179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cf141f-4e93-4c7b-ff9c-08d7675d6128
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2457
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Remove the use of the static uartlite structure.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 8b39b2b..4d431a2 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -670,7 +670,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 #endif
 
 	/* Register the port */
-	rc = uart_add_one_port(&ulite_uart_driver, port);
+	rc = uart_add_one_port(pdata->ulite_uart_driver, port);
 	if (rc) {
 		dev_err(dev, "uart_add_one_port() failed; err=%i\n", rc);
 		port->mapbase = 0;
@@ -681,7 +681,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
 	if (console_port == port &&
-	    !(ulite_uart_driver.cons->flags & CON_ENABLED))
+	    !(pdata->ulite_uart_driver->cons->flags & CON_ENABLED))
 		console_port = NULL;
 #endif
 
-- 
2.1.1

