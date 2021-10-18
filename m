Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636BEC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 08:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D64C610E8
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 08:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhJRIWb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:22:31 -0400
Received: from mail-mw2nam08on2071.outbound.protection.outlook.com ([40.107.101.71]:52288
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230526AbhJRIW3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Oct 2021 04:22:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGlx8Dfe1RQtcVvuYFfB3YHI0mcftEw0Kxk/7Squo9N/7Z5aM6FZyButt9K1lELx0ul1tZ+ef6sJn/GsHjK+0SV7wfOQekVJaVCtpg49n5mMDuLy/RtzfzbLiUNsH1UjnZaVPHxCb2fdtGvcGcFerZQiO3XlnVM6PuUHkBw/Sy0l3A7azaZ111qXDpTBEXMJ80cm6d0MxiCBnYHeYi8vhSx1hQfg8xiWJ0dRPdB7kNydw9pkiLn7CqlW19Dmh9yCRq8ZRZ99EgWldI3nGdSNOE0fR+VUzV7LJEfaZNesqORHYKxMR06hXhnnkSktIHmBRaHT4bP1TRacBU52HuWg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irJMCLKKJqjjq+EECBJU38KBOFC8p6DhO48HDvlqbLY=;
 b=nB+/TkI024ksC7hB9+fyYCqwJAuVwiG+Sv2yygTv9uXoeFfYPVLCax9U58owOQe6F/2gUc1QQT1/EOr58VlJwsPuiRe1ytPYaQL1iuiqlMwGg7xi29jsNClbdvpTT5ZQ2G2ZprblmLnOY99h4DoisoY3K78stP9ROIXeebT+m0QlRf5EIwlwbmG5Z0TkwBxZM1Cj2tyX1EFxQh4sWfbvEOt8HFbF15zRx/n1vzqolHO0SFSF0UPvaryQjqXcDLiIWRbLqixU/88+Yn8ACeOXqBpii6/keI1Lcdt2a0ysuSMYZS6NFXD7iGnwGUMTa4YUa6mw9Yej13hIjTyfIWY52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irJMCLKKJqjjq+EECBJU38KBOFC8p6DhO48HDvlqbLY=;
 b=MnACzre1Bn3jKZm4wyEnofC+5WD0q3ff55jvw9larIQgZIwH7xF+wAEXHmtvCQoG6GqG30xwzk7HroCnh5eGwrpGoRY369+UuDugCT5XUEpgOFzV7Uv6KjPePk50TsvNErMpwcYpLLdrqEEwPaMdwEiybygwrHpozvXs9SfnZCo=
Received: from BN6PR21CA0012.namprd21.prod.outlook.com (2603:10b6:404:8e::22)
 by DM6PR02MB5020.namprd02.prod.outlook.com (2603:10b6:5:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 08:20:15 +0000
Received: from BN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::54) by BN6PR21CA0012.outlook.office365.com
 (2603:10b6:404:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.1 via Frontend
 Transport; Mon, 18 Oct 2021 08:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT031.mail.protection.outlook.com (10.13.2.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 08:20:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 01:20:09 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 18 Oct 2021 01:20:09 -0700
Envelope-to: linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 shubhrajyoti.datta@gmail.com
Received: from [10.140.6.39] (port=34716 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1mcNsN-000Eye-4d; Mon, 18 Oct 2021 01:20:07 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <michals@xilinx.com>,
        <shubhrajyoti.datta@gmail.com>, <git-dev@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] uartlite: Update the default for the parameter
Date:   Mon, 18 Oct 2021 13:50:00 +0530
Message-ID: <20211018082000.607185-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fda9c69-711a-4288-7483-08d992101cf6
X-MS-TrafficTypeDiagnostic: DM6PR02MB5020:
X-Microsoft-Antispam-PRVS: <DM6PR02MB502008D18CFFA136674D20B6AABC9@DM6PR02MB5020.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3wUPvt+Qzsr9Re1KSJdmZq58JS9jsS8CkWc9vi2MK4tSwId5EDdqy5hDrR5INoSQaXpwcPHkorcCeRr+TsXO/DeO8x45XinZv0LnxNR7/mDun8TmhEpv6Dl4pMqETWAcaJcWuPPZ+G0pp0PVKKGblQOfa2gUt5K8FYOLPbc9bStHU/6Dwx6kqCp5i8xlhLnaBsX8udTsWS3yZi2pgcMTvNfgd0vetpfexx7WDkFSNSDukTG3ZDiZ9qSfLfEtrVbLG0vxivwrKMGPR6fZg1jJFZXtB70kLn8VdB41TzpsnmW2H3KnIeB8uHjeH7hIGU+aQEiFrbmLPrvk59k3egQB3GkmtTwwb+9ApoHYE/Y7LjL187Fg1CHTGnRITHLhFIE8r05rfLILXYrWAF7lGZlQ6RhFb1PuZpiFCxOjF0ncPTK2TgXp0VACKqzoK66waB9NKFLfE8Z1TDnCoxgDAISoptsmKTm9gjsE9NLZ+Zx91JtRHHcLXB/jEkrHSDbmy03f+Zyq/Sw55YvHlzADW/7dwiuH3Q+ZkRtjTYlcshk8gN8EnUUZFzjpZ85h34uMqrdeBNQNxpUrwpb1CYS7tMMWfr9xjLtdrlwbRTTLslqS2wjox+FnhEyufHK0F4jGGdbcqb5kELRXY6dlqnVmNvqHOwxFoNgPetqFicdOLm9M/OKUfGmMXMKqGdXTxvXPOVl3LzxDwjv1kqJ0i5TwOvWDKDdK6rLk1eQxGjXt2pzE8g=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(356005)(82310400003)(83380400001)(7636003)(36860700001)(26005)(47076005)(36756003)(70586007)(8936002)(4744005)(70206006)(6916009)(54906003)(36906005)(5660300002)(316002)(44832011)(6666004)(508600001)(186003)(15650500001)(2906002)(2616005)(7696005)(4326008)(1076003)(336012)(107886003)(8676002)(426003)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 08:20:15.1352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fda9c69-711a-4288-7483-08d992101cf6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5020
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Update the default number of uarts.
The commit b44b96a060f3 changed the default from 16 to 1 change it back to 16.

Fixes: b44b96a060f3 (uartlite: Adding a kernel parameter for the number of uartlites)

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
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

