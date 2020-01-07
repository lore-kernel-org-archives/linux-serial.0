Return-Path: <SRS0=kbyA=24=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264F7C33C8C
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 12:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ABC207E0
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 12:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgAGMAJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:00:09 -0500
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:42432
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbgAGMAJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jan 2020 07:00:09 -0500
Received: from SN4PR0201CA0068.namprd02.prod.outlook.com
 (2603:10b6:803:20::30) by MN2PR02MB5872.namprd02.prod.outlook.com
 (2603:10b6:208:116::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15; Tue, 7 Jan
 2020 12:00:07 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by SN4PR0201CA0068.outlook.office365.com
 (2603:10b6:803:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Tue, 7 Jan 2020 12:00:07 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Tue, 7 Jan 2020 12:00:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ionSc-0004e9-Hk; Tue, 07 Jan 2020 03:55:46 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ionSW-00080H-RZ; Tue, 07 Jan 2020 03:55:40 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 007BteSK016568;
        Tue, 7 Jan 2020 03:55:40 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ionSV-00080C-I5; Tue, 07 Jan 2020 03:55:39 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jacmet@sunsite.dk, git@xilinx.com,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Subject: [PATCH] serial: uartps: Add monitoring TACTIVE bit in set_termios
Date:   Tue,  7 Jan 2020 17:25:36 +0530
Message-Id: <1578398136-26170-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.154-7.0-31-1
X-imss-scan-details: No--5.154-7.0-31-1;No--5.154-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132228720076702582;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(356004)(316002)(8676002)(6666004)(82202003)(9686003)(2616005)(81166006)(81156014)(86362001)(76482006)(498600001)(4326008)(8936002)(107886003)(6916009)(36756003)(2906002)(70206006)(70586007)(336012)(5660300002)(26005)(426003)(55446002)(73392003)(9786002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB5872;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d4a277-9123-4e9e-f35f-08d7936923ae
X-MS-TrafficTypeDiagnostic: MN2PR02MB5872:
X-Microsoft-Antispam-PRVS: <MN2PR02MB587281C99277130BE24EA067873F0@MN2PR02MB5872.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 027578BB13
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slTO5cNimsOg+a8Wdo9bCYGF40QHia+XiA0MUZs6mUEmUNG8ENNRmKPObAfYXJh1FFaQxMCKbpp2zpXfJrllDakStWJkqTy4889vTyMZ6CP6ZGLfdfBzlD+BW0W8o5VS1hBr6ZmLLCApyq5cc2iX1k0C5AIQvxvmjVH9onV2fzVyEQa02uRD4wJjBS/laTLp+JzHeBxLWBEf9TcTGg95GUnrDytv3vbyBqYs2z5bMx385dSq+oRJoqAaKr4Hz16Pzz8ath9t7JVeBfnGdJAFqHF4hDFF5DRgtkM4GvmyHBNMOPX4EqqA2nawd091Z7oL2w00Z3tPNfWTp+WORFgZhSQkj6eT5PjtciLOyMAblz792zoP61s2ajIkNd6c7jqD9TS+LrVWe8mfc/l+P3FN936Qri/DjiBi+wI4b+OH7PLfN7Y8oWR9Ag8nEZpR0bMz
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 12:00:07.3960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d4a277-9123-4e9e-f35f-08d7936923ae
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5872
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>

Before setting up baud rate in set_termios function, make sure
all the data is shifted out from the Uart transmitter by
monitoring TACTIVE bit in the channel status register.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index ed2f325..c337544 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -703,11 +703,15 @@ static void cdns_uart_set_termios(struct uart_port *port,
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
2.7.4

