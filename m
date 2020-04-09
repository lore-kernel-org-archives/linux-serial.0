Return-Path: <SRS0=pwFA=5Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F21C2BB54
	for <linux-serial@archiver.kernel.org>; Thu,  9 Apr 2020 06:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8E820771
	for <linux-serial@archiver.kernel.org>; Thu,  9 Apr 2020 06:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kW0uf1h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgDIG1H (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:27:07 -0400
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:6180
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgDIG1G (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Apr 2020 02:27:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6PA/ctDEa9FiF2IxOy8K4vozdRYi0uah4BudUbCubGQNYkpPIzmkUl//K/Qq36U+8joByJU1Dr6ltIMinUToCRD+8OeZ+CYlSMAqMZE2IryJkkLKJyOwK24lC7OwqkY32tXx6TrAi6rVg8aA4MIa0IeYC3P2Wwz62zYQn9Lz4mf9BuBfAlM1r4323e2vQLDUn99GHFg2/keWDMgBX1BtHxEWetsm+INtmGUHtfrwRLfjJyyQViIKLuhr+dvf57oAtlvqXWdK2tGPw6ZcTHV795mXs/Ebb6gI+PtTJZPeOTV57gKmV6sa2Ctgssmd2oYYr9lPBkbUCYZe8LEYJAvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVUjpAO42Z6vvZnd80PGVWDuoZsUdVtLW/tWXRjNYiw=;
 b=VnU69USKGMwtFOqWy+oMbUBqzRilfDsoYTSysM5e1O/gDlc5IAP8wharsfUwILMj7Z01e1f78tnt7bXVeRdMOb+jKFkpzx+whiUxVzbqFh+wzfqEnEfBSfKDzUMBrkjhX+J7E7pDLD+Wp7mSYxLupzOivHPAp60+54e6gNmnNkH8spX3WCbhDpRTi1hSaDDV4aHAFXzMjpTkoWs7Z+uh7EzuFRr34UtHa32O41u4TjfuZEdz/iq3xQkKXdHlCFw8yLhdIdadAd2cdzt6wMRx3bKnZX+UIqn92snpJElwr9VTPR2+O5nbSoo9iGGftL0z2rpKK8P1GRbH5jSUAwgKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVUjpAO42Z6vvZnd80PGVWDuoZsUdVtLW/tWXRjNYiw=;
 b=kW0uf1h2URT+Pt9sI8U3Qf3TY1VHDU6QnDzAlfbPAyL+jGfqY2AraGAtj4kkwcTovQUiwRGnNnFXFuLms3PVwgpXmSjn16MkSa2nirnD9P2gWoU3lfWLKrMPE0NTG62j4LjxxcfL1mKCTf7LGuqN5GxoS4lf+Zcq9vLHgMV535Q=
Received: from CY4PR14CA0043.namprd14.prod.outlook.com (2603:10b6:903:101::29)
 by DM6PR02MB6235.namprd02.prod.outlook.com (2603:10b6:5:1f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 06:26:53 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:101:cafe::c) by CY4PR14CA0043.outlook.office365.com
 (2603:10b6:903:101::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend
 Transport; Thu, 9 Apr 2020 06:26:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 06:26:53
 +0000
Received: from [149.199.38.66] (port=46635 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jMQdw-00086r-4T; Wed, 08 Apr 2020 23:26:28 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jMQeL-0004Z5-1M; Wed, 08 Apr 2020 23:26:53 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0396Qj8Z027511;
        Wed, 8 Apr 2020 23:26:46 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jMQeD-00046h-CT; Wed, 08 Apr 2020 23:26:45 -0700
From:   Raviteja Narayanam <raviteja.narayanam@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Subject: [PATCH v2 1/2] serial: uartps: Wait for tx_empty in console setup
Date:   Thu,  9 Apr 2020 11:56:02 +0530
Message-Id: <1586413563-29125-2-git-send-email-raviteja.narayanam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586413563-29125-1-git-send-email-raviteja.narayanam@xilinx.com>
References: <1586413563-29125-1-git-send-email-raviteja.narayanam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966005)(70586007)(81156014)(316002)(4326008)(70206006)(478600001)(356004)(5660300002)(7696005)(6666004)(2616005)(426003)(26005)(6916009)(44832011)(82740400003)(36756003)(81166007)(9786002)(8676002)(8936002)(47076004)(186003)(336012)(2906002)(107886003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20dc1ec5-2623-49f1-d396-08d7dc4efe9b
X-MS-TrafficTypeDiagnostic: DM6PR02MB6235:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6235B9B9BAA1DD4A8F42BE37CAC10@DM6PR02MB6235.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK+yVkQM4tmuBLOditDZ7nPSS/8UE0Iam6k4BNcO45N+/5jrM/hvEanWqVkhZMn3cdeLHSg8qlvXXeDBVVVatMHmlMkgGyjAjEcIsTZBXPJdSj8Xq0aa72ENvpx+a00Sy5bpKccP/0uPh4tZbDjrYM88wZ7hBOgTY+TbEDGyFC3Lwr3PCWmksorGtTWVqUK8Rv8dDQT42pLqbF9SH/G0Ngek9Pcb4Gj9fIIHX5dVYkzSHcOdt0JYbmcSGH5MJCfRJBpg9ct24X0zhD0p8CafqPIbzsXL3rXjmcLR/RJrmA+Q0evd5yv2VMKkSVpR8ZFnaBLIsj3TdNMcBDOBymfkxquy61BfhsD31C4uWVFXJhzPU1WuoejOsxA5h+Ee3anYyyB5A1XPdnQK0epUTiUZqZppkxhAwvDv53J4kYHl+bZEQfQT23xkK4oxfxwEoeaKWF8/XdjbclzHHzVLi8Pek1/MintsNAqcuATyBoITIvKNPf7//3oqA0iPmfeXFmt/4+GMTlHBUYxv5X7xj8HBeg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 06:26:53.3309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dc1ec5-2623-49f1-d396-08d7dc4efe9b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6235
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On some platforms, the log is corrupted while console is being
registered. It is observed that when set_termios is called, there
are still some bytes in the FIFO to be transmitted.

So, wait for tx_empty inside cdns_uart_console_setup before calling
set_termios.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 6b26f76..0bf946b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1260,6 +1260,7 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	unsigned long time_out;
 
 	if (!port->membase) {
 		pr_debug("console on " CDNS_UART_TTY_NAME "%i not present\n",
@@ -1270,6 +1271,13 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
+	/* Wait for tx_empty before setting up the console */
+	time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
+
+	while (time_before(jiffies, time_out) &&
+	       cdns_uart_tx_empty(port) != TIOCSER_TEMT)
+		cpu_relax();
+
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
-- 
2.7.4

