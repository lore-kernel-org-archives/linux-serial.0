Return-Path: <SRS0=kbyA=24=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BCCC33C8C
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 12:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7D92080A
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 12:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgAGMAM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:00:12 -0500
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com ([40.107.243.44]:60897
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbgAGMAM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jan 2020 07:00:12 -0500
Received: from CH2PR02CA0027.namprd02.prod.outlook.com (2603:10b6:610:4e::37)
 by MN2PR02MB6333.namprd02.prod.outlook.com (2603:10b6:208:1ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Tue, 7 Jan
 2020 12:00:10 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by CH2PR02CA0027.outlook.office365.com
 (2603:10b6:610:4e::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Tue, 7 Jan 2020 12:00:10 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Tue, 7 Jan 2020 12:00:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ionU2-0004eL-FN; Tue, 07 Jan 2020 03:57:14 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ionTw-0008FP-NV; Tue, 07 Jan 2020 03:57:08 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 007Bv7Wa017670;
        Tue, 7 Jan 2020 03:57:07 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ionTv-0008FC-7P; Tue, 07 Jan 2020 03:57:07 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jacmet@sunsite.dk, git@xilinx.com,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv2] serial: uartps: Add monitoring TACTIVE bit in set_termios
Date:   Tue,  7 Jan 2020 17:27:03 +0530
Message-Id: <1578398223-27523-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.518-7.0-31-1
X-imss-scan-details: No--5.518-7.0-31-1;No--5.518-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132228720101528312;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(70586007)(2616005)(426003)(70206006)(86362001)(4326008)(6916009)(54906003)(26005)(9786002)(336012)(76482006)(9686003)(5660300002)(73392003)(81166006)(81156014)(36756003)(82202003)(8676002)(2906002)(8936002)(6666004)(356004)(498600001)(55446002)(316002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6333;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6de77893-a38d-4a6c-3e7b-08d793692531
X-MS-TrafficTypeDiagnostic: MN2PR02MB6333:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6333C044951E529B9CC36B93873F0@MN2PR02MB6333.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 027578BB13
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noSkoTDFR/VrZiPUCPUpYk/9sU1HLkeLD/nrdUfPTz0wO7d7VAwNAHFUrKYyv3Rgnqtf58+PNjUo/0oe41ESMcHHboGjP4ZmXpq0xmAyCwIRX8kK1iQulb34z1H4zKhVtArQWE8SxQcg5Ht3b/TtIsDAsZ1RKXeiPIeQV6mlomXrfnwk7tenRHdcfRjQ7vYQyy0OoWWnYRkCw2Sq2ncBXxV5v0FQP5eY4fPWVbsS/Ns1Clxbi2IITdNVRDYoF5E4N3yqcE/oD09luBRxFhCm+GiQzJ4F86+eBRH/NsMd3zfdbmV3WvcePxxpxDVWIYWt1iKGSNYflKniOPFaLpf4O3idYrDUJHfUnKMS/BxGh88me/VVgDWQYOGTdtrxNEh2sTFaZIjenL4YGvg8Bo1UHcWvV+Dx7Mc3RM8yAO/Hys5g/n5S4SjZT1ypF6TKL7/2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 12:00:09.9937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de77893-a38d-4a6c-3e7b-08d793692531
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6333
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>

Before setting up baud rate in set_termios function, make sure
all the data is shifted out from the Uart transmitter by
monitoring TACTIVE bit in the channel status register.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2: fix the signed-off

 drivers/tty/serial/xilinx_uartps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4e55bc3..7424f33 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -690,11 +690,15 @@ static void cdns_uart_set_termios(struct uart_port *port,
 	unsigned int ctrl_reg, mode_reg, val;
 	int err;
 
-	/* Wait for the transmit FIFO to empty before making changes */
+	/* Wait for the transmit FIFO to empty and Transmitter to shift out
+	 * all the data before making changes
+	 */
 	if (!(readl(port->membase + CDNS_UART_CR) &
 				CDNS_UART_CR_TX_DIS)) {
 		err = readl_poll_timeout(port->membase + CDNS_UART_SR,
-					 val, (val & CDNS_UART_SR_TXEMPTY),
+					 val, ((val & (CDNS_UART_SR_TXEMPTY |
+					 CDNS_UART_SR_TACTIVE)) ==
+					 CDNS_UART_SR_TXEMPTY),
 					 1000, TX_TIMEOUT);
 		if (err) {
 			dev_err(port->dev, "timed out waiting for tx empty");
-- 
2.1.1

