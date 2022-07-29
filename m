Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38718C00144
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 11:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiG2LsI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jul 2022 07:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiG2LsG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jul 2022 07:48:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7307E303
        for <linux-serial@vger.kernel.org>; Fri, 29 Jul 2022 04:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXGh0FB80L1m4Nt3M4TZy5sY4/8GJAIPodvGiTSYS8a1lALXs2fed5lMKjTdc+nrrQ07vguslWnDnOzpzEx3asx/k9XNIReWQm7WTJf4CBNOGhWMC4M+ZgOv4yqO8rT4MGstXH3rpvhaC6sTaCwIfgIdltyg15FjYynbfxDeKJvYgO3HxUE//Eqk/gD4jam3zcBgrLbiIcXfALW+8g9E8CsGue/Z5QecfKtpChoYhgvSQOyismAPYi5Y5b26aROCHzZFtT2XstcmsMrAK5VW5R02l0Bm8e6Y97aPSJ3CyvIGkCHkhPmf1g6bsvmwxNWpskjQijEDP2qryCH5jNH7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSn262ivQ/yhDBv1Kaj/LLFYFPVXX78d9KGdEKOYLDQ=;
 b=F2LW1yAs0h87/jQpuKfiU3eTHUQPkyKmRU7Gzlp1NFH3HXgGaVyWLa5h60nncdkjS6HXCBf5wKAwo9tAt9LZuZPl6Yq5hM0kINN64tUHstfYqOFTX6w9DxTev1dtB+3Wa/9uc+RZ/eb6aqwNoj4QMPsvkr9IEiwOone0fyWL2Kq5zsA0uUSY/j0Sdc7gzOjiEP3xZQuAazVljP3+nvAuf7fR5b3pL4M8NF3XvfCD3pDDX0UIpboqw6qBDJ7xUPaGZprWl+q6myMZKs8SmuaTuPpUjK/smcDmAXqMBidKvqhAIju9kAo2HndiMYtCOmusBXXTglP8OsnGVt9s2gCVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSn262ivQ/yhDBv1Kaj/LLFYFPVXX78d9KGdEKOYLDQ=;
 b=gssvqo5D2so4tgSC6X2hxAbvvroOzCMAs+w2arQYudnchurtcSS8w1pAMaRm7jEis+/OCoiTSCI7YGFTgHa1v4WTk+97i8i/izw2RhxRhE39iGkCd3EEE9BgT1eWY6nA6e0WSCr5YY3dlyJ+KhdGHlG0feKobv9TchO+IEKoSXQ=
Received: from SN6PR01CA0010.prod.exchangelabs.com (2603:10b6:805:b6::23) by
 MN2PR02MB6623.namprd02.prod.outlook.com (2603:10b6:208:1dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 11:48:03 +0000
Received: from SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::bc) by SN6PR01CA0010.outlook.office365.com
 (2603:10b6:805:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Fri, 29 Jul 2022 11:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0041.mail.protection.outlook.com (10.97.5.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 29 Jul 2022 11:48:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Jul 2022 04:48:01 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Jul 2022 04:48:01 -0700
Envelope-to: linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 shubhrajyoti.datta@gmail.com,
 git@amd.com
Received: from [10.140.6.18] (port=57946 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oHOTJ-000DJo-Cu; Fri, 29 Jul 2022 04:48:01 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>, <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 3/7] tty: xilinx_uartps: Initialise the read_status_mask
Date:   Fri, 29 Jul 2022 17:17:44 +0530
Message-ID: <20220729114748.18332-4-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
References: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a10621cc-abc3-4f86-005b-08da7158319a
X-MS-TrafficTypeDiagnostic: MN2PR02MB6623:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T0XZJVqTJorc8cjmwuRlzQUOvOj6qQIuml3hcR9s6GdknBdufoeJaaNpLkQB/7Bi7LoDEOh20Sy5JufYEIdSTuSu/NslqJyDJd5rhApGSFPxP25CxVdowfR+wBWTGBCjZcs/n22WTg/qZ5GBhsjvSIXWzCFFmZarqP45MQo4mlB31JuKmBjcRdK+ohmIT97JXUeIErJa5mY36/ovSSUTrupxs1hhxG7AGOMGL9J/IO3IMJKNmXZz06IK0Q6cBQGqY0x+qlHugCa8C6WV0MZOsv/UtccZdha26baGOfuKr4BP0OI8moyAGjR2JsQJTDDeBbvYT+YtHTbG7ZgnuvGhTtj31fSbIP2L/U9CBtToUBBWvdwaAZjW8io0kN+S0yHWrp5VCUSWtR4VhH9Ugek2iQ75RNGkpXLnAfNMIsxiQX4zrCT27dnjpe/sA8GTtT2E6c742TRHzYskucBxPQC3CIu9ocax/j5dOm8qt/JNpaRR2FpI/0AbSEayaNI/aLX7VhtK+7dIpC9aK276449JjxmSWoyp4Gx2g2x7a3kbZD55efuJ93TMSFJfzVCo0/Jb5hJ3oaON5/coe65A8bKrIBeboL06DIUG1VbFjCDHTl/p9NTBqV1yeReIkFyYoOdYYAS/NN1+pwXopScG3jdgRB8Z8RM/uuyIhx+VEOzSDU9Ho26mMH73s0m3q3H4M9QnU6CQKjTcOnbX8hpjMLFy+yNeoeMzTl2tfV/2UI/4wv+sZxvcdZmDaHHORx47EN+0a/4NvgcAkRkMihO3ENX2ndYEnpZkVZMfPNA+BwfUN+IJ2UO6uNVoolMGkgTLRfzMBmf7Fzt7+AlFe5KTBQfECw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(426003)(2906002)(82740400003)(9786002)(44832011)(5660300002)(7636003)(107886003)(186003)(336012)(1076003)(356005)(36860700001)(47076005)(8676002)(36756003)(7696005)(26005)(6666004)(41300700001)(8936002)(316002)(478600001)(40460700003)(82310400005)(70586007)(4744005)(4326008)(40480700001)(2616005)(54906003)(6916009)(70206006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 11:48:02.8802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10621cc-abc3-4f86-005b-08da7158319a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6623
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Initialise the read status in probe.
It will be checked in the isr so to have the default values lets initialise
in probe.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
Split the patch.

 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8d2c21718869..94e1bc694457 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1559,6 +1559,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	port->dev = &pdev->dev;
 	port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
 	port->private_data = cdns_uart_data;
+	port->read_status_mask = CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_RXTRIG |
+			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
 	cdns_uart_data->port = port;
 	platform_set_drvdata(pdev, port);
 
-- 
2.25.1

