Return-Path: <SRS0=H5Pf=3U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B019EC33CB2
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jan 2020 11:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7862320CC7
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jan 2020 11:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="koRWvq9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgAaLFI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:05:08 -0500
Received: from mail-eopbgr690080.outbound.protection.outlook.com ([40.107.69.80]:11776
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728268AbgAaLFH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 Jan 2020 06:05:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLH2fVk8kdOp49Ctq/T1A83gr1LlVQsSR5siT3yC87CgsK6cGYZN5Q/3yoAaIehY+QrITCcRNkhMZ+SaMKMRfh9F9BqvuR2Y2ke5uZO1jUb7yO7iR7QnnRC9kJYYMddSCQRr3qA8zhxejwisSoI3wgjeibDWayrXqdN3JwiHYM7VRIBIecklFNmBju5whkUWPWUbWDEZRR7hYhOfFmCPxw5yrb1aZ/tOwsD6DmUZxI3OuihBAjEvIQF5X8XsDEk7LadPV7GBNhVrpD0YaSL2BH2LN+TrUpRGx+kIElwn1wYaCLh5wgMX7GhVtSiMw3LLfkpJEzXapGO2cEPevEXF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ub5HeTpbX4QPtfuoJmIFkCKnY1miACH3zobzfjZHTM=;
 b=Dv8rDCKYB5mqOGseoTK0ZKl5MGWMdg0ESAvvmsXnJwOzdU6ESPrHj7D33JZdoepF9iZoCLIhR/LwPFHT3tP+06DZyyxZLVUOxSYuo6fxI/Mr6YCCNvb2xGOnPJ+SBEfNn1k+dLF7yELr/g/IKjeepYAzbIbZl/DB5en2t89j1qDLnTMBs+g1LXsULBvWODtf+U6H6X9HopvvI6Lk0wpEmRMb7WqeKM3FARTZcCLiPu0f6hSMvxCcW4ROPfrJfMfFs4IOpKeGGVT85PtdQeCS9whYhW5EjOvQ+XXGgobL7ouJVpMBPzZ1mCmqAtYjG0VpvAT91sRfCEP2izjGWKpb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ub5HeTpbX4QPtfuoJmIFkCKnY1miACH3zobzfjZHTM=;
 b=koRWvq9j04nifK3ho5wNpxepIpC5CA+yjmTQ/ddgRYTn1IxcGNcxBGPKW9y9LNK2BwqWm1SXSY3tEh0PxmguRQbnuYrSZ3v4r9Uaflsl9lcQRhy4gln7Ee+3XZN3J9E2EIH8IVQEW3q9n2WD1SYd6NrSlDu3hLxm0wjvuaDH5lw=
Received: from SN4PR0201CA0010.namprd02.prod.outlook.com
 (2603:10b6:803:2b::20) by SN6PR02MB4912.namprd02.prod.outlook.com
 (2603:10b6:805:99::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Fri, 31 Jan
 2020 11:05:04 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN4PR0201CA0010.outlook.office365.com
 (2603:10b6:803:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 11:05:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Fri, 31 Jan 2020 11:05:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1ixU6g-00054h-P3; Fri, 31 Jan 2020 03:05:02 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1ixU6b-000425-Tl; Fri, 31 Jan 2020 03:04:57 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1ixU6T-0003zV-4t; Fri, 31 Jan 2020 03:04:49 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v3] serial: uartps: Add TACTIVE bit in cdns_uart_tx_empty function
Date:   Fri, 31 Jan 2020 16:34:45 +0530
Message-Id: <1580468685-11373-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(376002)(136003)(346002)(199004)(189003)(426003)(26005)(8936002)(186003)(8676002)(107886003)(44832011)(9786002)(6666004)(356004)(81166006)(336012)(81156014)(478600001)(4326008)(6916009)(5660300002)(54906003)(316002)(2616005)(36756003)(70586007)(7696005)(70206006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4912;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4099da0-4a4c-48e6-1e2d-08d7a63d6c6f
X-MS-TrafficTypeDiagnostic: SN6PR02MB4912:
X-Microsoft-Antispam-PRVS: <SN6PR02MB491293242D0DCF632002F6D3AA070@SN6PR02MB4912.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7jinjI7D4jmRKBuSGV+baIpNZFm31aBIh6Ou2321nJmCrvVpCpQ/6np8HIm+NTDJ/Do00S0UkA3W5jsLvIFeISRZ3WC5u00fS/jwHY6zksOkR6zhPWPZv064t37pI8WKV+j4PGuv5b30zE1fdUYpq9nqZo6mmq4J81IMedFbZfujnJdUVgMJ4nKxvpLPFaSaCwimKsAuxss68Cs+htdQPbN5tHdgHE3xLnJ2yLAJVjYlVybC30VdTwcp24cFf9+aqi4Gm070F+QKTEcIPKyzG2lmkt4hjsE5nbTwMOZ+dMKVYEUI/K+dRf+KxNc0RpvtPg0gBIccOVaBXYm1Si/YFC1vnLeLsilxfeAUbMurgYKdpFipr8FcQat4rBC4kQdVc2D+OBq9LZILRUvuAVHYm3FFMw10NoibfFTYS3yWbTF/mmWyIDWRYtXcQTCrN1q
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 11:05:03.6880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4099da0-4a4c-48e6-1e2d-08d7a63d6c6f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4912
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>

Make sure that all the bytes are transmitted out of Uart by monitoring
TACTIVE bit as well.
Before setting up baud rate in set termios function, do not wait for
Tx empty as it is taken care by the tty layer if user specified.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v3:
removed the wait from the set_termios and added the TACTIVE to cdns_uart_tx_empty
As suggested by Johan.

 drivers/tty/serial/xilinx_uartps.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index ed2f325..ebd0a74 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -32,7 +32,6 @@
 #define CDNS_UART_NAME		"xuartps"
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
-#define TX_TIMEOUT		500000
 
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
@@ -656,8 +655,9 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
 {
 	unsigned int status;
 
-	status = readl(port->membase + CDNS_UART_SR) &
-				CDNS_UART_SR_TXEMPTY;
+	status = ((readl(port->membase + CDNS_UART_SR) &
+				(CDNS_UART_SR_TXEMPTY |
+				CDNS_UART_SR_TACTIVE)) == CDNS_UART_SR_TXEMPTY);
 	return status ? TIOCSER_TEMT : 0;
 }
 
@@ -700,20 +700,8 @@ static void cdns_uart_set_termios(struct uart_port *port,
 	u32 cval = 0;
 	unsigned int baud, minbaud, maxbaud;
 	unsigned long flags;
-	unsigned int ctrl_reg, mode_reg, val;
-	int err;
-
-	/* Wait for the transmit FIFO to empty before making changes */
-	if (!(readl(port->membase + CDNS_UART_CR) &
-				CDNS_UART_CR_TX_DIS)) {
-		err = readl_poll_timeout(port->membase + CDNS_UART_SR,
-					 val, (val & CDNS_UART_SR_TXEMPTY),
-					 1000, TX_TIMEOUT);
-		if (err) {
-			dev_err(port->dev, "timed out waiting for tx empty");
-			return;
-		}
-	}
+	unsigned int ctrl_reg, mode_reg;
+
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable the TX and RX to set baud rate */
-- 
2.7.4

