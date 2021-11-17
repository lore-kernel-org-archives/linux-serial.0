Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93711C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 05:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638C063225
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 05:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhKQFTk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Nov 2021 00:19:40 -0500
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:32617
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230130AbhKQFTk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Nov 2021 00:19:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4mNrJO83LbeYk8MeBMnZ2ZxhFRfhAuVgqREeBfV5GFkzGIdyqEGIL6QZlb3P9cI7wmGYPnSmxtgDXCbWJ/8ZCcCodH0WfI3CMZJ65qgnJr5MYE/OaFd7OUfzXPSkvlyhB8YGAXmK3XftbCsYDCnUZa5Osk+Nge7cNc0keFgc8Fnv9W6tcNPyusCKplognAIqhq/7tFjrPPi6GusngYBFjegDGJtYybBdSIrF7vCQ6rBeHDaef/0ux2EpOmfus/iPhyE6hry6tgiUITe+OoQnyHkZq6mBr60fmQCbXScnZLCQBg8anw4amsB/OZJ8k5wmrv4ueedy7u4dzWBhprIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDkvrbAs/GxwrKi08ALmY7+2I80IadLpWR3JwogL6uQ=;
 b=hvGvmMsViv+Lm+kj+84ZHJxuNiVqTD+wfXrNQGiaP09d4Q7C2WGe94tab5PdRTUAO8OzTmT3eimeNe18H06JWJVKLFBPPaqcsv/HbpG24jgt5lhxHkHHF9ryK6KwMDdSqmU/pTLsDN9mZS9VJGd1S7R9aMmowHKzDSnWEPUtZYlahZU6siQ8aSXtBDQQEyepKmoqCugmmp+tcFq3+xbtNubev/94QGCMZ1RzkFS2uRs0gPXqRk/AiaU9IxbGWsGSfJ5nI43DWxBBheLh0g0Kg916XIK910n7gyRQwMmBVJGfQ2rWvKHPL2pCKX4MLunFJedA9CX1lKgxtD5plKKCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDkvrbAs/GxwrKi08ALmY7+2I80IadLpWR3JwogL6uQ=;
 b=ekuq7xA/gK2w/MZUQ5JR8Gej51g7kx4TbhlvcaRFRWCjmf34w6dCYGuw+mvr8H3/K/0Zlb5Z3IDl//r9r2+ZfIsZPvgvUHCCAzbmapVf5mmP9DMJ1FOSTFuuBcLYHPs2GXvmBtURcZYwPyApIu82bF1zBSQ2LhzoVgWwx+OJBuE=
Received: from SN1PR12CA0082.namprd12.prod.outlook.com (2603:10b6:802:21::17)
 by MWHPR0201MB3402.namprd02.prod.outlook.com (2603:10b6:301:7f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 05:16:40 +0000
Received: from SN1NAM02FT0017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:21:cafe::bc) by SN1PR12CA0082.outlook.office365.com
 (2603:10b6:802:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Wed, 17 Nov 2021 05:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0017.mail.protection.outlook.com (10.97.4.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 05:16:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 21:16:38 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 21:16:38 -0800
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 kernel.development@povil.us,
 gregkh@linuxfoundation.org
Received: from [10.140.6.39] (port=52142 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1mnDJG-00035e-Ay; Tue, 16 Nov 2021 21:16:38 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <kernel.development@povil.us>, <michals@xilinx.com>,
        <git@xilinx.com>, <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2] uartlite: Update the default for the SERIAL_UARTLITE_NR_UARTS
Date:   Wed, 17 Nov 2021 10:46:35 +0530
Message-ID: <20211117051635.1316958-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c092df1b-1f81-4a5b-734a-08d9a9896fba
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3402:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3402BE99FDEF6729407411C5AA9A9@MWHPR0201MB3402.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6v/vMNIis6w2NJLbOAKqh6uIcQxXm2I2qsAhbhEHTJB5/yYgbybB6J2hc0am024oZlIEAmygTkae78XEzPCzWYYxZGrRO1ftmHnEgOHfKTPhmqz0hNxNayWH6SEJlgmPgSJde5j/kEZXwAg1rWgXfX97iedWFY9rJL0ZDWD7wmvnqhscMIbwGcl09tEQ3HsyMjSxhDcQWTIQc/MUOjv640P2ZQn2QGGiZmzR22K05K6DMEUj8WyZftN0q+65ih2V+yLIH+Eb0uSHHGuQnuAHxIfMessnK0Iw4ytTtgSKRTftUkm9gv5OM/itkd+UxoGUVOMjg4M+qQ6kuDz6rur1dg7dOU7NCfToR0Jc5YFZYfmh1xiOD1YrSxoniMfQhQDLMx4OXH7SH9MK8kr6RXtB8H5jlZRYJSnuHAgg7Y9BaQxL5WhFFHYozOuTKy8WUxvim/HEBF32tpXhZbcmYfY207dG8swOhmKfm4fA9fuXqFNyyDqwQJts8M4LH2ZrOyZijIa89LZvgi7tKptUCWfxjEx7ef27TGM6bc1RN9gMAqR7X7VzHE70Kc2TDV9rlU79PQ5KWFkRBDvyuzwxHWxTeGzxZN4Tmxbq4QVMinPTUFeKryBmInlBbi6oqze76uCyW0Vzd6FNXKzHh8OQyyostycoi/NIV0mqkOpOMh33OCeACNPRD3pfqTcBeNQUbRA6yKnBwAJtcl6SLDBUIv4yGUqMbKzao528wPnUWwq6fg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(356005)(54906003)(6916009)(36756003)(8676002)(336012)(7636003)(1076003)(82310400003)(9786002)(44832011)(36906005)(316002)(107886003)(6666004)(15650500001)(8936002)(2616005)(83380400001)(508600001)(70586007)(47076005)(70206006)(26005)(186003)(5660300002)(2906002)(7696005)(4326008)(426003)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 05:16:39.8930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c092df1b-1f81-4a5b-734a-08d9a9896fba
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3402
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The commit b44b96a060f3((uartlite: Adding a kernel parameter for the number of uartlites)
states 
"The uartlite is used by FPGAs that support a basically unlimited number
of uarts so limiting it at 16 dosn't make sense as users might need more
than that."
the commit also said that number should be unlimited. However it set the
default to 1 instead of 16.The original 16 written in driver should be
 quite reasonable default to cover most of the cases.

So change the default number of uarts back to 16.

Fixes: b44b96a060f3 (uartlite: Adding a kernel parameter for the number of uartlites)
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Cc: Sam Povilus <kernel.development@povil.us>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2: Update the commit message.

 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 131a6a587acd..1254b523ca9a 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -531,7 +531,7 @@ config SERIAL_UARTLITE_NR_UARTS
 	int "Maximum number of uartlite serial ports"
 	depends on SERIAL_UARTLITE
 	range 1 256
-	default 1
+	default 16
 	help
 	  Set this to the number of uartlites in your system, or the number
 	  you think you might implement.
-- 
2.25.1

