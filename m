Return-Path: <SRS0=8eBw=5X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F15C2BB55
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 16:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A69D2082F
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="W2Ql8Q/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDGQx6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:53:58 -0400
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com ([40.107.244.54]:6271
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbgDGQx6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 12:53:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG20QeQdsK55JiNvGy+SfiyRq2zjW9dJ0IdPzQZN3KTnyEEteoNZCzWqYBKZZ1lYXFU9oHb38u8hbjWESYHJhQPCCww1I599oqiVpF0WvNYSVNm3m0a+YAynx8surusC1Dz+j3TTdSVi7+iFldRdYP4zlrqksXbiYyjbyGsjHoWY86h/t16PeGnC7gxSTmJc6BMfN76WoFRNhWtD8OtW0Ag+g4nSFAA9bY16CfkdsZ3FwNXv7HwvZXpoH+XqOeTY5DSWutbhmvYAu9TUON3T3uwHL20tYbUnuORV+7JDnp0BafbIt4xkLrMKnzzhfG//ILgNNjYNXZe8KN+UaECg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncLq4h6vTCWAcP0zMECTHr5V46u0rOk8RUFt3MyuRHc=;
 b=g5ZOol6/meevaZLvHiV6Wbo2dqxy5MT5lArgkCiMaEetrWI0+arobd+2GTao+9ehLFEPu8J3py/6AaKhE3qb/rxUuumX/4kSk7dn27OUmvAkZKyakAH97kOy1dR+oumQoul5Xg2rNPNMVZ66cnuztVaQAoLxJ12Q1mGs1x7Pm9+LjiHkeLxWS+MFc4J15cG7Fx+CCqKx5wT30IFW2WZtALNxgKcK+ICCXPIn6tgyYq1uniG5wwf6smfMlh/NNI9r9rgSlwl/iwCNHDUeQJ92W0qld66y5A89lnBrGS43dxsXq5teoohbIhizVDSKSpUmJTjaCacEiYKpZg3wiuZCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncLq4h6vTCWAcP0zMECTHr5V46u0rOk8RUFt3MyuRHc=;
 b=W2Ql8Q/myk33OEc93xJt+D0Q7vYgqK6pnh8XLMHDG4Je2Y2lVOQR+O1CU4vdBO1Kn/w+3erWtpvRbnbN10Y65iMrpAV0e3mrjYM69CmOEiAqOX9apDO9ewmjEFZ9evbrBdvbzvijxoQKs5ksp5pUOSF8ASaGbIocmvERuIer/sI=
Received: from SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) by DM5PR02MB3814.namprd02.prod.outlook.com
 (2603:10b6:4:b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 16:53:55 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::f6) by SN4PR0801CA0003.outlook.office365.com
 (2603:10b6:803:29::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Tue, 7 Apr 2020 16:53:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server id 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 16:53:54
 +0000
Received: from [149.199.38.66] (port=59348 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jLrTi-0004w3-1w; Tue, 07 Apr 2020 09:53:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jLrU2-0004bc-Dl; Tue, 07 Apr 2020 09:53:54 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1jLrTu-0004Xd-2s; Tue, 07 Apr 2020 09:53:46 -0700
From:   Raviteja Narayanam <raviteja.narayanam@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Subject: [PATCH] serial: uartps: Wait for tx_empty in console setup
Date:   Tue,  7 Apr 2020 22:23:11 +0530
Message-Id: <1586278391-9061-1-git-send-email-raviteja.narayanam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966005)(6916009)(82740400003)(2906002)(47076004)(478600001)(336012)(316002)(36756003)(26005)(5660300002)(356004)(186003)(426003)(9786002)(2616005)(70586007)(70206006)(107886003)(44832011)(4326008)(81166006)(81156014)(8936002)(7696005)(8676002)(6666004);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bc043e8-97d4-4930-6605-08d7db1441e1
X-MS-TrafficTypeDiagnostic: DM5PR02MB3814:
X-Microsoft-Antispam-PRVS: <DM5PR02MB381411B162DFD40D6A05155ECAC30@DM5PR02MB3814.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 036614DD9C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3RM3665aCbqmHuQhmJH6pxkGwlu2fPROoVpH/C0KVQs0iH06b2NIsiYI8EHHjSuUWMADqbdnctvBubQbGi1phrRWqe/bwJ6WHAbLpQVrPTIziQcajpSsOkcl6SA4G7/78xai4tjkAlip/mkfgeadKNUiaUFweawqpQAik99jvO2pvyu0CByC8PczaMgUR4+i8lamc7AS2rzUNM9lLIKjGIWgHqbzhw8UM9W/RpThUjKkzTMKqxB4GX4i2jhu+9A/cI8tRqWyWjo/2Hn0PbNIdHxA5Ek1SpE8Ovij2MNmsAiB/BQQyrI28slonC+fL3NhL7dfSSG7to0+xJwsNrsfbJVtn2AAEdVtsQXpAS5Wa92oA5RAvP4C44xMV8SZYUSLeUcxjeEKlcVVknZmOaG+Vee7kf6QNxCP4uYeSz9BidVy6qWTSOrc9mhlrFedSgKPFz52b+Dk5GWuwgLgItryYzPDxrd6gJLbucC95rdsjYmqTFxYLqnQR3cj9xo3JaRVxYCh6Z2hoJ6nfTzxKqL6g==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 16:53:54.7244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc043e8-97d4-4930-6605-08d7db1441e1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3814
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On some platforms, the log is corrupted while console is being
registered. It is observed that when set_termios is called, there
are still some bytes in the FIFO to be transmitted.

So, wait for tx_empty inside cdns_uart_console_setup before
calling set_termios.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 6b26f76..23468ff 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1260,6 +1260,8 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	unsigned long time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
+	int status;
 
 	if (!port->membase) {
 		pr_debug("console on " CDNS_UART_TTY_NAME "%i not present\n",
@@ -1270,6 +1272,14 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
+	/* Wait for tx_empty before setting up the console */
+	while (time_before(jiffies, time_out)) {
+		status = cdns_uart_tx_empty(port);
+		if (status == TIOCSER_TEMT)
+			break;
+		cpu_relax();
+	}
+
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
-- 
2.7.4

