Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EF9C4361B
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937F323BDD
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 12:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbgLIMTr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 07:19:47 -0500
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com ([40.107.223.78]:9313
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731042AbgLIMTo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 07:19:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsZQXliny4uNxScwmoGUwc5cw7CQBrBfwMOb0dNiWA5Y1ZPAtNNMm9ZACM3z24ol7sqoQrFq6YqIpWiTE53VLFb6zvxVYAkt+wLWe3MYYII5zwazp8WmZyKOLuzKNhq2jzv2B7BgIAoqzdG9xiZ2ADkRanFJUBTLTN/XKYdd8+o+3GG5W3mHiXS8pI0YElb/psa5r0H9l+LHjtvLcIpKsoV+cAx+XWzVzLwwVTj3I0ahJcB91XewELMPG59eVknqo2PBlQ4X7LUVKZFrzKNfaTRZLnEftoeQBA2JmNtzfNn32LugrEjx5vcayZRJeAGk+UH4PSdfVxSp6J04lUDkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddaN5pXaDPjmNsHkErOdgEX21OdXeSnQu2sev9JAlpA=;
 b=B3qZkXqzq3OCffSNbv2IlP5+n1H/ofdQC07WM3RqVbiWxZUjkSxIg1joDJu5kxKxI1gaFQ94LJp7iUf3I8PE8ciiaVbw+05hOJAXRs9fseKsA60TGparKgMzLXoEKWjpZ1KykbAN0lEKXwjLawS/MjL78HPF1QxSXO01OZPSe6TTNihigu7Xqhkz6gByPZo7yyjBmVpdRjWT1LkCOUxbh1zQ9jmSHWK2QqrjS/BGg4WrRTL/4PUtz7Qlowp3PdQcWQbV5cl7MxCvw1RcXhM79Gmjs1x54q91/i0dc6lyRdKJORhZMGQWaIV50GAs+aJzy38E4kl+1otFPQgKl7NLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddaN5pXaDPjmNsHkErOdgEX21OdXeSnQu2sev9JAlpA=;
 b=qpNjKNdIPqhwe6NZLgRZR7/m0+Nlsyf6S53dvqNHNw26KvKKO7hUiPvVh+Pw6Of4HsMill1DMeqo3sOFux37LScSOb82ByVfzbjllsVGnAXyECwTqMbAKb+f08vVVTiFX3xFneQfabSawcEND6+1N9gLAX40eAub5CUfkG1GThg=
Received: from CY4PR2201CA0010.namprd22.prod.outlook.com
 (2603:10b6:910:5f::20) by MWHPR0201MB3498.namprd02.prod.outlook.com
 (2603:10b6:301:76::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 12:18:52 +0000
Received: from CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:5f:cafe::2f) by CY4PR2201CA0010.outlook.office365.com
 (2603:10b6:910:5f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 12:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT057.mail.protection.outlook.com (10.152.75.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 12:18:52 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 9 Dec 2020 04:18:32 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 9 Dec 2020 04:18:32 -0800
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jacmet@sunsite.dk
Received: from [10.140.6.59] (port=53746 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kmyQQ-0007Zm-T2; Wed, 09 Dec 2020 04:18:31 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@xilinx.com>, <jacmet@sunsite.dk>,
        <linuxfoundation.org@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 3/3] serial-uartlite: Remove an un-necessary read of control register
Date:   Wed, 9 Dec 2020 17:48:21 +0530
Message-ID: <1607516301-26975-3-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1607516301-26975-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1607516301-26975-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a6ae70-bdfe-4477-af74-08d89c3c9744
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3498:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB349837A70A23A8D0F9CAEE55AACC0@MWHPR0201MB3498.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRguFVj/pXsFTWT4xlzzHgQtRlQVSmZlKrQc2KFX3KO8yDS+VDGLkRTX7RiFRjU2Q9/qttsS1mzKLRVmn/Qfm9iSuLJ6Ur3H4KR2Zw7n2YGVnI6Im/XLv9iczfsQGM+UyJRxWoQ6AgF1EsTLNRTH8EULgM6fg4StWGpnOfTFCJ/br1fqRvNgVbH4Fgn9aDVN4azA607rg2NzMZMk5GafygTgxN4FS6gqgxW8Ho93Q4Chg4LrJ1ZKfsRYVUDYm6BrUByGMEWU4bSLLBDlRbT3knsg9uQ7Qh9DRfC1TYWWgjdGihyLEdSdtLA7a8+JUUiCNhP7qBnnQZyTXnyGZoGLasXvJEEAuZ3MRk4/KAUMSddYCwJJey3lIkIAY86kldR35GcB6zAPX2kVNQqeNICzJR+FmT+Za8DWa3XnGa4vIVk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(46966005)(47076004)(426003)(356005)(336012)(4744005)(83380400001)(8676002)(6666004)(5660300002)(54906003)(2616005)(6916009)(8936002)(107886003)(26005)(7636003)(7696005)(4326008)(36906005)(44832011)(9786002)(82310400003)(70586007)(36756003)(2906002)(186003)(508600001)(70206006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 12:18:52.2137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a6ae70-bdfe-4477-af74-08d89c3c9744
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3498
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The control register is a writeonly register that's why reading it
doesn't make any sense.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 92dd528..52c223f 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -296,7 +296,6 @@ static void ulite_shutdown(struct uart_port *port)
 	struct uartlite_data *pdata = port->private_data;
 
 	uart_out32(0, ULITE_CONTROL, port);
-	uart_in32(ULITE_CONTROL, port); /* dummy */
 	free_irq(port->irq, port);
 	clk_disable(pdata->clk);
 }
@@ -367,7 +366,6 @@ static int ulite_request_port(struct uart_port *port)
 	}
 
 	pdata->reg_ops = &uartlite_be;
-	ret = uart_in32(ULITE_CONTROL, port);
 	uart_out32(ULITE_CONTROL_RST_TX, ULITE_CONTROL, port);
 	ret = uart_in32(ULITE_STATUS, port);
 	/* Endianess detection */
-- 
2.1.1

