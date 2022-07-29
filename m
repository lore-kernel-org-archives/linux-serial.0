Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7419C19F2B
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 11:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiG2LsT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jul 2022 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiG2LsO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jul 2022 07:48:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFC27E303
        for <linux-serial@vger.kernel.org>; Fri, 29 Jul 2022 04:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQHFNCXhFnqxffHMMRYcqSwxbQLtEq3o6HGtaq8oXijxH7R29q7iRi9qAXMV7iZnuzhFkhTTftEfFUNJ0Cd4zqHVvnrRo8lG2MK4FyASwQ/jW74BgrzsQL6yL4tyVYRSu+n4JpZOyGyCSYgB8vUT1pxqc79g+3VAHpxI0Xxv/ApoMx9bni9Y7NHqkmWoEKxnuNKmpgVT1ES5eq4SpnYAz7l6mMEVYhLtYhLBkWSEoGcvXyUBqYLeyI21gArTqx3plQeJw6H0I5MpP6PRkgNJHPYL+7xNfvJbEZadFCpxG+YbPoDangGvgmTc1pZB+X/xdPZaTgukJl16zQSWg/J27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T71jb1ykbDEOg/3WtiDYhD/Z7WSaAegD9j/XE38qa0w=;
 b=JjPnbrj72lW+n2BbnN56XZ5R5Z7PZ7ZQWPRiGKe0hGyT/utVrhjcmcyiDJbGEGjSzoHDPaTp5ZRc28rejuO+ACh0T42SNX9PID6Uzmhn9TwMhTj4fyWjpkGbkJDgeEsbUy8TgkYz5mttgBSUdxpu09GYeH5b1UZpiEVJr849YwJ2kRiJNYni2Wx5GEEqBSYq//8ea1ls2GUE4Q9BpgrzUr53y9jbSuEpHqqQeNb7SWULTSPiLj2SGy3WxxNtZ2pkMX/2Dd8ar2FFKnnO6+64aiB8IANb061QFYc1yseariK8k1nTOIjrB0mYR4YqlMeUWLBLIkzgG/OahxB6Y31yUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T71jb1ykbDEOg/3WtiDYhD/Z7WSaAegD9j/XE38qa0w=;
 b=idbkPdfFmrZ6EHhCUZIy1/7hGe4Kx86jlGaiKa2FKTelmSIfVWSXiN9BZAa/3VhDKOywGPJT/W2t1LGOo7RRAdMrfRDeBAB/4o6AAyTG93vdAKx4oINn8/wR+5dlJSjTmRXeYkXHRNz9qtmf0kVH/fT5lkp0ULIx9fjRl6DeolY=
Received: from SA0PR11CA0042.namprd11.prod.outlook.com (2603:10b6:806:d0::17)
 by BN7PR02MB3988.namprd02.prod.outlook.com (2603:10b6:406:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 11:48:12 +0000
Received: from SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d0:cafe::1e) by SA0PR11CA0042.outlook.office365.com
 (2603:10b6:806:d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21 via Frontend
 Transport; Fri, 29 Jul 2022 11:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0042.mail.protection.outlook.com (10.97.4.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 29 Jul 2022 11:48:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Jul 2022 04:48:09 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Jul 2022 04:48:09 -0700
Envelope-to: linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 shubhrajyoti.datta@gmail.com,
 git@amd.com
Received: from [10.140.6.18] (port=57946 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oHOTR-000DJo-3a; Fri, 29 Jul 2022 04:48:09 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>, <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 6/7] tty: xilinx_uartps: Add timeout waiting for loop
Date:   Fri, 29 Jul 2022 17:17:47 +0530
Message-ID: <20220729114748.18332-7-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
References: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f5d3f6d-53aa-4350-12ff-08da7158370a
X-MS-TrafficTypeDiagnostic: BN7PR02MB3988:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpjNEF46qkr44kCX8l6TWO9reT2QZzfzZmCTpkdXA1dTQa9rjEPzJWF7T+8WpRJA0i+gd+itMSWq5AE1w8Dd39vK+yTdZ15lL8e2sd6VhY9df7BdS7B89At3QyoBrPS7TCNgkw6/uTteGJUNnycbAiLAvdURKsb5oLFjES3BVSIYONs+7YrIS0vEHqyW9pdY9vzkDaBhawkv/GKgbh1Bhein6dQq/koI/1TGJMMgijeOT3wXwL+1I6iaAXCqUswvTYGT5okVt5KrrJ+Gg4G6GgNSRYrqPULPmgaq9gFsQaaK9GDm6knlVP5UVNLLzgjG3P0WyZgqHxyFLOjFX8ssdFHWiwRlj2C2jbjzQIVPeZ6XQ+bCmb75BX6stguy4laio8tlpm35Wwzfn14no6wcbe6wRyooLCxY9LjatVDWTARewTorWbnfOw4OJgjaFVon4jGnelQ4+VFFGsHqXGYy0nrzqqEjvaNTDVaUaLy34U3RUznEjzizSOYlmZhzUToL/8qc99/Z5ipb4oM2l5GreREiBluEuiapJV6CuWzcWVkSV8/NX+4/n7gliZcL3k9z6WW4ITm1J1aqWQJ5rQy2tNmxumqlz/2/iCMgha8N8IigNIMgxX+lmCflWDitOqMVrR6vXuNwVjisCpwkK3ZWZEUxloSmbIsauAYLmY1aOj6yoU7GNl2YVYUxv/8Jdvk8gUSl5j+gKJrYvDsVrmRfBw+o6chPhSF9/XADTsi3DfdH+EfwGFXWNsvcGJAmbWY4Zxy1QxzogI2I0Y4Xc0vlz2YyQFhNz4AB/5BnfMBePDksicTVn1/n8AltRouO3e1GwfS2ZjpQM1sql9ZI7rzsfg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(40470700004)(36840700001)(46966006)(6916009)(426003)(186003)(2616005)(83380400001)(7636003)(336012)(356005)(70586007)(70206006)(8676002)(4326008)(5660300002)(36756003)(9786002)(44832011)(1076003)(2906002)(316002)(40480700001)(7696005)(47076005)(82740400003)(40460700003)(36860700001)(41300700001)(107886003)(54906003)(26005)(82310400005)(478600001)(6666004)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 11:48:11.9876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5d3f6d-53aa-4350-12ff-08da7158370a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB3988
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is a potential infinite loop while waiting for the 
the TXFULL to deassert. Adds the error message and timeout to
avoid infinite loop if it fails to get the TX fifo not full.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e119da69e190..a1ff03f24f51 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1147,8 +1147,20 @@ static void cdns_uart_console_putchar(struct uart_port *port, unsigned char ch)
 		}
 		cpu_relax();
 	}
-	while (readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (1) {
+		ctrl_reg = readl(port->membase + CDNS_UART_SR);
+
+		if (!(ctrl_reg & CDNS_UART_SR_TXFULL))
+			break;
+		if (time_after(jiffies, timeout)) {
+			dev_warn(port->dev,
+				 "timeout waiting for TX fifo\n");
+			return;
+		}
 		cpu_relax();
+	}
 	writel(ch, port->membase + CDNS_UART_FIFO);
 }
 
-- 
2.25.1

