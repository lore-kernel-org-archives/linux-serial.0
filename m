Return-Path: <SRS0=QEsI=ZE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61AAC43331
	for <linux-serial@archiver.kernel.org>; Tue, 12 Nov 2019 10:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5AE206BA
	for <linux-serial@archiver.kernel.org>; Tue, 12 Nov 2019 10:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfKLKpM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:45:12 -0500
Received: from mail-eopbgr820044.outbound.protection.outlook.com ([40.107.82.44]:38496
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726924AbfKLKpL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Nov 2019 05:45:11 -0500
Received: from MWHPR0201CA0106.namprd02.prod.outlook.com
 (2603:10b6:301:75::47) by MWHPR02MB2621.namprd02.prod.outlook.com
 (2603:10b6:300:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Tue, 12 Nov
 2019 10:45:09 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR0201CA0106.outlook.office365.com
 (2603:10b6:301:75::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 10:45:09 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 10:45:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTc0-00023I-VM; Tue, 12 Nov 2019 02:41:28 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTbv-0008CI-Qd; Tue, 12 Nov 2019 02:41:23 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACAfNAG018069;
        Tue, 12 Nov 2019 02:41:23 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iUTbu-00089t-JA; Tue, 12 Nov 2019 02:41:23 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jacmet@sunsite.dk,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv4 4/4] serial: uartlite: Fix compilation issue on !OF platforms
Date:   Tue, 12 Nov 2019 16:11:11 +0530
Message-Id: <1573555271-2579-4-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1573555271-2579-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1573555271-2579-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--3.240-7.0-31-1
X-imss-scan-details: No--3.240-7.0-31-1;No--3.240-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132180291092602611;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(76482006)(4326008)(426003)(9686003)(26005)(336012)(107886003)(11346002)(2351001)(73392003)(446003)(54906003)(36756003)(498600001)(14444005)(316002)(6666004)(356004)(47776003)(61266001)(55446002)(50226002)(305945005)(6916009)(81166006)(81156014)(486006)(23676004)(86362001)(50466002)(9786002)(2616005)(5660300002)(2870700001)(2361001)(76176011)(2906002)(126002)(82202003)(476003)(8676002)(70206006)(70586007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2621;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ee86e85-8462-42e5-637f-08d7675d6351
X-MS-TrafficTypeDiagnostic: MWHPR02MB2621:
X-Microsoft-Antispam-PRVS: <MWHPR02MB262104688BB70A41E9F7D9B887770@MWHPR02MB2621.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ycYuyPFJmhqOVJed4L1fiJujCxaYtjgfexfOcURB6Afwc+fXtr+Hj7IkPKI3XP4GXbhSmCEoqolbR8XkwZ9LIB/n+LCrrE/GB1W+xoJONVX3Cc/oOKwc8lXlE0MK9FN7+6r6ywmHRNChV2RjJZoOAgAqIaVpxaE4LTcrY0VYsbTg+xl7N5bsexMUsLvotEd9/y3NSVSbey8AvIWltEZBAhSCkk8uvxFjtaEUNNYBks6eqtUtKVBl/tA5HgEdqnWDzCeQeGQRbytsvZYUg7KGr/riwSOoe6wKwGrNKHIwHkL6zm+v6YebgNe2QWolP+3uU+/LcCRwW3NtAXRTpVM4gA01uX1yCVLm1UJe1XMHTNHFwJrwin1/OYcflaaGleYLeSpeKtJkHQvnWfLYphMHqJPysezigvNTrgyg0Uru9WVS37CJvaqhX9rA6Me9jsjY
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 10:45:09.0372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee86e85-8462-42e5-637f-08d7675d6351
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2621
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

There is missing ulite_of_match on !OF platforms.
Use of_match_ptr() to fix it.

Warning log:
drivers/tty/serial/uartlite.c: In function ‘ulite_get_id’:
drivers/tty/serial/uartlite.c:774:33: error: ‘ulite_of_match’ undeclared
(first use in this function)
   ret = of_alias_get_alias_list(ulite_of_match, "serial",
                                 ^
drivers/tty/serial/uartlite.c:774:33: note: each undeclared identifier
is reported only once for each function it appears in

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v5:
new patch addition

 drivers/tty/serial/uartlite.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 1bc3e59..19f68f3 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -773,8 +773,9 @@ static int ulite_get_id(struct platform_device *pdev)
 
 	/* Alias list is stable that's why get alias bitmap only once */
 	if (!alias_bitmap_initialized) {
-		ret = of_alias_get_alias_list(ulite_of_match, "serial",
-					      alias_bitmap, MAX_UART_INSTANCES);
+		ret = of_alias_get_alias_list(of_match_ptr(ulite_of_match),
+					      "serial", alias_bitmap,
+					      MAX_UART_INSTANCES);
 		if (ret) {
 			mutex_unlock(&bitmap_lock);
 			return ret;
-- 
2.1.1

