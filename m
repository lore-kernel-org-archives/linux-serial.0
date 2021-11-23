Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252A0C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 18:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhKWStA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:49:00 -0500
Received: from mail-bn1nam07on2079.outbound.protection.outlook.com ([40.107.212.79]:43607
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234139AbhKWSs7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 13:48:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccNBicHlmftY5l6MHG2jIf/5sg2eFHMPzY2srHF4Ra7w+zsLSnykoC6fJt9h1fnJH2UYKOS07dF4NwlgpKaVknO3+/hCf6QkmQGF5abq6fKLyppZOcJT1wRYuPxX2bhLNiaheejZxJI3Y/A3LC8udxGwHLCdGQcS8CSL79OuDp2SysRoR5RRlGF19y8DGnMzeSQWv21p4iBF3SL5ssr4xWFPNRBifJDaTFsahoBhUMlax2XoZu+jYYFjjePKeZ2KsvU5VyOinArRt5o9QFq2DvP614Zy3vkftSOoX6VjXl0ZrRLBY9mg+dEK1FsJQVMUN4bl7DtAOmF8CUxHAUVgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fJvpXFNcOf/7SFtieQ68f2Uy2BxSvBVju2YztXWboM=;
 b=LrCenmXN5GwTPrvxL3Rmw5+ky34UuYW14J1Y0oeuOh2eObiDoE9GyfMmmIC01jXB4g69bfV9kKfKlG0mBzsdB6B1rqJkFwvwT7pWdDfB70VzlEgQg3IfB6buFxc2+54v4k4BreDMDJLLhO+Gt6w/VQQHCxw6BsHzBy94dCnK4op+vDFRA25N4TVTz6TA2DkXtRXVV2KgK/l49L73SI/Bj80trXQnVi6h5t5FIdie3JWr1WmxOJ3zNhQ4uIve5kWS2fWV9AxHIkgLNycdBeH5MCa1DYJbh/Zj1vYcW8Tubw6Ki3JMK5EWQShMsqND5ebMvD8B/+R/tbA/uYDDXXXkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fJvpXFNcOf/7SFtieQ68f2Uy2BxSvBVju2YztXWboM=;
 b=Z1kpi0E6jsaj7tJNtbMcow6CdtT3Yx48BYjWcZHexUZiFwaT1khGgZMGI9Sa82djdJ68j3ItLj6TMJpS33i7jZ0C4IO/BbYxInoMkocdg6+nYxzbLq0ael12QOqXcvBxMK/fqNSYTQ74WZU5eRByIdRiauXXw4xDIpjC3KqcOts=
Received: from DM6PR06CA0092.namprd06.prod.outlook.com (2603:10b6:5:336::25)
 by BYAPR02MB4982.namprd02.prod.outlook.com (2603:10b6:a03:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 18:45:48 +0000
Received: from DM3NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::b4) by DM6PR06CA0092.outlook.office365.com
 (2603:10b6:5:336::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Tue, 23 Nov 2021 18:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT054.mail.protection.outlook.com (10.13.5.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 18:45:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 23 Nov 2021 10:45:47 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 23 Nov 2021 10:45:47 -0800
Envelope-to: gregkh@linuxfoundation.org,
 jacmet@sunsite.dk,
 linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Received: from [172.19.72.93] (port=43548 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mpanb-000B2V-Ha; Tue, 23 Nov 2021 10:45:47 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 732E660010B; Tue, 23 Nov 2021 10:45:47 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jacmet@sunsite.dk>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>
Subject: [PATCH 1/1] tty: serial: uartlite: allow 64 bit address
Date:   Tue, 23 Nov 2021 10:45:06 -0800
Message-ID: <20211123184506.1184561-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696c8b5c-6762-48cb-a75a-08d9aeb1774a
X-MS-TrafficTypeDiagnostic: BYAPR02MB4982:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4982C52A086DAA2BE639036EA1609@BYAPR02MB4982.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lqi3+XXkYb+ayvF8fmFUGixwYGkW7PLBsi+kFHKcn0gzgSMTht4cyBC0sUH0DMkxDY5XCqB3aFi5eaHRZsAP0+Q2KAgRSkGq1uom6/OE35q2ouwWfWD6y3ltFqKSmqT+84OcNuGxlKKygQa21brSZtuiFwVNp5bIDcGQMzvL0dvIar7wGZHANZFxyJ1UZQZC1Ieg+yhIaTv6QfP7j5muj89B4HTBKJJsyOL3UqlCvUzojJkX8TNA6E4zYUv1gENIWevR6MkS/eCTJvOOxFsADu60hAV5rUpk3mvRbHCZ7OysE2hyE0LrNuiiR5EfJ3xCWsBG/kQUEkJ11quJVhqR78Qo2iNvR8G95J30BDKFFgVxcDRZSUt48LncWM2L8oBp9jQULU4f/Tz4L2DXBuaTCZDmRg08PA/xzAaUN6QKntL+ci4VncrP7WaP1oLnsPXVfG8qux9O2OOvVmcclHc1td1P9xh+yRTiBKUotJR2FCOgYp2lkC14/SaC3iLtoARmMDyDrV64RHAOeXgx/MkOFLPSSDgQ+3+7Gei2oGHXfNI75anZ3PiaKZBlT4LtXbQYTYWDEpynpvXfKt72JmyGPTVgdLLYdSUOM0EUtEo8QFf3PmUXPRRxaUz1V9C5QmBsZSLMFzjUZ1qFIUhlBw1dWFpmxL0PC7fGI4DIjxHCOGN8Unt0cxna3hG97MqgjqJX1KQkaM4Tmb9Z/gRMnGVqtg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(8676002)(1076003)(356005)(2616005)(5660300002)(6266002)(4744005)(186003)(426003)(70586007)(44832011)(2906002)(83380400001)(8936002)(7636003)(110136005)(42186006)(36756003)(107886003)(336012)(36860700001)(4326008)(508600001)(6666004)(70206006)(26005)(47076005)(316002)(82310400004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 18:45:48.2541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696c8b5c-6762-48cb-a75a-08d9aeb1774a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4982
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix the uartlite probe failure when it is mapped to address above 4G.

Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index d3d9566e5dbd..e1fa52d31474 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -626,7 +626,7 @@ static struct uart_driver ulite_uart_driver = {
  *
  * Returns: 0 on success, <0 otherwise
  */
-static int ulite_assign(struct device *dev, int id, u32 base, int irq,
+static int ulite_assign(struct device *dev, int id, phys_addr_t base, int irq,
 			struct uartlite_data *pdata)
 {
 	struct uart_port *port;
-- 
2.27.0

