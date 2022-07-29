Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06703C19F2B
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 11:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiG2LsB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jul 2022 07:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiG2Lr7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jul 2022 07:47:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC57E303
        for <linux-serial@vger.kernel.org>; Fri, 29 Jul 2022 04:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYJt/PPockCmbXWgGc8DbJWf9Ve4O7+xd7SAOdkBCXl0bfR/tAyL+DHbCKK6QB5nVWOZoauH+BxrsoKXwQXHik0CT/YuSvBy0CFLPPXOpijvoJco+rLvbtctmPVT/At0ZmjF0f4mdeq1F+z+HyaKUWSEcVB5G2VXdORy94hNVT2jneZjcef43/yvpNtPLVCr+iFBsP1cvqUPR2thM1QL3W/2k5zFASWFm5MVjOK7+8IMTgG+dJgi3coZ9Pd4avKFNw+oQlDF75kU8OT8EbEKrJn4OCzHC7dfzR73MvuJNtVNBT10B2dH0DqWAzaJYsSJXyeNwQ3Qt6Dx4cigv/NLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xFCCt9TPyjqA1DDUknywUqbPS1dp1bUQ/7tcJ7LK6s=;
 b=PtnOF6P8rkTPVOPYsQbb/h4B5FiABplbzgTCekG0cMQnWFpSwW61KDuXTGYpVURMDqG2hYp5iGDcjuv3F5UVe5XJDHrWIMNDmLInVEHc8EozISFBaYpaeX0Jb/8KCs1WTO0hm+NIN46mvGRczSBZH2+KzUDvftbaHVPboYkqKyakzMD9lIKQhMUuYFUSXpNjO4RN7JM1Gd6hOdRcZ/js8KfLsk0yGhBxMCz9+sHGfb1kD6cZLisi+J2Xd9OUG1X2RhFNYVs8sKSd18ucW/lwaHiGTRnqYwp/s+4OKYJq5ltdnU6/HXKy2haP8SBVnqjmMyah7IyhrZU03RaP4J8pZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xFCCt9TPyjqA1DDUknywUqbPS1dp1bUQ/7tcJ7LK6s=;
 b=BqCZQD4dPTf/CG6svkY382Q7sknZwb5kl17gfQCCueYmZP0mX4tkKFJYbjP9m7FqfxHlKNKMJyQ7l1jK/nnHlYzyHTJfMaz5ia4L8D8Zge4qojFTr4sGEMeWNDvr3i5YCmdCXaGkIBXKFOxaBxhYndfp0YHRwujWeoiEX7L7Ifk=
Received: from SA0PR11CA0200.namprd11.prod.outlook.com (2603:10b6:806:1bc::25)
 by SN6PR02MB5678.namprd02.prod.outlook.com (2603:10b6:805:e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Fri, 29 Jul
 2022 11:47:57 +0000
Received: from SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bc:cafe::c) by SA0PR11CA0200.outlook.office365.com
 (2603:10b6:806:1bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Fri, 29 Jul 2022 11:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0047.mail.protection.outlook.com (10.97.5.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 29 Jul 2022 11:47:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Jul 2022 04:47:56 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Jul 2022 04:47:56 -0700
Envelope-to: linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 shubhrajyoti.datta@gmail.com,
 git@amd.com
Received: from [10.140.6.18] (port=57946 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oHOTE-000DJo-6N; Fri, 29 Jul 2022 04:47:56 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>, <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 1/7] tty: xilinx_uartps: Check clk_enable return value
Date:   Fri, 29 Jul 2022 17:17:42 +0530
Message-ID: <20220729114748.18332-2-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
References: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a542e605-3469-4c0b-8bfb-08da71582e39
X-MS-TrafficTypeDiagnostic: SN6PR02MB5678:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0lBIkVwqmxmW4EzjDdvGnwSbqO6FyH3awK9CQjmd7NlzfOkGiJXGpARBUCh2ehl8fZy9sH+uzEeeg4+0f2HLLEtWSLbo7Nxs9XpkMlXW98aswM0xomY3axBVJ+BS/MPSz7TfY3rLcIdwbd1FRt7PtyytjsVgLTtxAU0nh+Rq6wn697qFehKtPTjibClGBIDjegoJgwrDPf88uuR9GvL8HTB65n4Xtf1pEISgwVqXCgoft9XWz2w+Wc+WrLt+JwMp9fcj2AgaS11C0AbtPy4h5Uegf4KQd8Iso3f+aQDBY8QsYeoAhDl6Q5aRckZNFd7TzwrH6v7EzxoaXvtgumXoLrnLLEavUKJ5q9eKmSrukHey9ALfckFaCX5H0YLAPTTeVUkk2IRWD2viauJdCzDkDSQshnlkckEnC7Z6vrnbv9qVKGv9l5T1ob2lGrI3iB9Mz32lmbffU1pIAKsSlAwtpM30mRL83LyNW+Y9HRrymxsgq2d/bID9Hd6agtwElc6TuaEeJbStgYTJnP5kjxWpPSK27mEc3iu4Cfv3leuZC7S0X9YplAuELD3/gNBEB0/k3bzt5YoIktAKj03iJD9SLHS71B0n/iRIVRIPlI1uAzNjL6kdmbfn55hvvnGnnsqT0FpP2WtRW2dkIzDDXnSSYock911vP8PCecf4aGx025UOQnlUSQOX25OjReQIEIpQN2ZSTSUHOHTZSm6lYINfVlr1So6+FKcFvhBKFahf2sFYPcfCvRLlrmxt9IbTOYeGWPzAbZ+DcUFdvWuvFTwQ2My2CWpVllVficY/kDZPqKrJST3xJw13RGyUJdxpmRx5BGmmfiMP3/O4/9O9LUYBQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(40470700004)(46966006)(36840700001)(6666004)(83380400001)(316002)(54906003)(47076005)(6916009)(82740400003)(36860700001)(40460700003)(7696005)(41300700001)(7636003)(44832011)(9786002)(356005)(426003)(70206006)(2616005)(1076003)(2906002)(8676002)(186003)(8936002)(5660300002)(70586007)(107886003)(336012)(36756003)(478600001)(4326008)(26005)(82310400005)(40480700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 11:47:57.2149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a542e605-3469-4c0b-8bfb-08da71582e39
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5678
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If clocks are not enabled the register access may hang the system.
Check for the clock enable return value and bail out if not enabled.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
Add clock disable in the error path.

 drivers/tty/serial/xilinx_uartps.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9e01fe6c0ab8..51fd09e14eda 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1329,12 +1329,20 @@ static int cdns_uart_resume(struct device *device)
 	unsigned long flags;
 	u32 ctrl_reg;
 	int may_wake;
+	int ret;
 
 	may_wake = device_may_wakeup(device);
 
 	if (console_suspend_enabled && uart_console(port) && !may_wake) {
-		clk_enable(cdns_uart->pclk);
-		clk_enable(cdns_uart->uartclk);
+		ret = clk_enable(cdns_uart->pclk);
+		if (ret)
+			return ret;
+
+		ret = clk_enable(cdns_uart->uartclk);
+		if (ret) {
+			clk_disable(cdns_uart->pclk);
+			return ret;
+		}
 
 		spin_lock_irqsave(&port->lock, flags);
 
-- 
2.25.1

