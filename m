Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE82C433E1
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52EC20888
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MOAYogr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHSQoo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:44:44 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:46177
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbgHSQoV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 12:44:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dwq48Rp2BlThdd0YK5n1ol7kp1sQVYpRv+nMqgTqOMx4iWIIHWR4nLUxT9w5rS8FQjAOTbKwGgYBP7vbGl3AjXSHGrXQnne+ISprAKquPZCfgpyFGje7mhTWpiKuLDjqhuq4EkHNADNbMHbWq7t5MFcaxkAFcmdceQUNyZCnoyjyF3Bx5ZYfMxIer+1DfWO/Rp0KMknNdevgW7ABw8a/O6lkjqvPPpZeA/dkDRkxIJXiKkqYCDd48iAxrgtrjlY7XG4LeWf7tmfaDIVoxpXA69i+yhhK0WXsVKGNIKgO7GJ8CPEoRsmVOn1Z9aHkWGhaf42DAaq7QfdGJHEB0ecDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oiwv4EyHvBly0lGV1ps+sunoB217g11ygvpEj3Yo3Lg=;
 b=aJnTzgVjSypfQRb0TvYVKSA8Dy5dX1H7STHZ3Pc5V3YfCBjcy/LZYTqYs76ExUjMvTd4C4h++SOHcwkIqifS+D3k8+Lx0sDM7cxNjmXHzbK70AP54NS+/UWuuHL8Gm/tve2XbZrKW/a5YnGxf36D49KTAvm/WgYHS2Q1rVOY+1xnXX9Mx6nf9PyMco6MhP4lOD8z99d8wQYn9pGXvmuKwwo/vGkvD1PlFFV3wQBOtws+YPHbRNy0FmmYgN3DmJTaugb88zOs5ng12hFabQ6vogKTUjT2fvVtdUj0LanzsNjfItXSirbRJaMBGWOUZUznWd9ZyG+szOZmAKJTo0xhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oiwv4EyHvBly0lGV1ps+sunoB217g11ygvpEj3Yo3Lg=;
 b=MOAYogr9MYJ338Ons9lUGoEawunT9Kc436Ks127rfV4Shtm6gCWoEZC1CLHoUcwO5UeM/XImsYWD71r2g407argUu/4g8x0Af7+HRqVsPUaLVjeFnmLQaoDBkOdXfY1pu0t6wCisjdJqgSCsuOiSXOYzXVMlul8SvaWEpyNBq1Y=
Received: from SN4PR0501CA0106.namprd05.prod.outlook.com
 (2603:10b6:803:42::23) by BN8PR02MB5873.namprd02.prod.outlook.com
 (2603:10b6:408:af::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 16:44:17 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::e9) by SN4PR0501CA0106.outlook.office365.com
 (2603:10b6:803:42::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.10 via Frontend
 Transport; Wed, 19 Aug 2020 16:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server id 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 16:44:16
 +0000
Received: from [149.199.38.66] (port=33073 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1k8RBt-0004Du-3j; Wed, 19 Aug 2020 09:43:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1k8RCC-0002LD-OF; Wed, 19 Aug 2020 09:44:16 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07JGi7Lh017364;
        Wed, 19 Aug 2020 09:44:07 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1k8RC2-0002IZ-RU; Wed, 19 Aug 2020 09:44:07 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jslaby@suse.com, robh+dt@kernel.org,
        git-dev@xilinx.com, gregkh@linuxfoundation.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/2] tty: pl011: Add support for xilinx uart
Date:   Wed, 19 Aug 2020 22:13:59 +0530
Message-Id: <1597855439-746-2-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597855439-746-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1597855439-746-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d82e202e-84c1-481f-5451-08d8445f1ce0
X-MS-TrafficTypeDiagnostic: BN8PR02MB5873:
X-Microsoft-Antispam-PRVS: <BN8PR02MB58739F76BA1E10D2941226E2AA5D0@BN8PR02MB5873.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdjMzhfS3V2K/2JcMiv7yNbdeGNdRX2It+ZzJOTB0BIFCh4uLirjayO69YNKpcSvn3BT508Vzf6OLSz1yV2XQce2oyx/LMHtSck27jr/w50bpMgF3fJQpvE4/OB+TX9JNBvZkwI62S9P29baq3eD6Q0GKeGpqrZEsOHiPAJ5LpF+XTFtAq9GrKsfzpKfMg6VPC50ObWt7xCu82M/T9FQny2mmvCRaonc8o4TXJz7PNuh3JVuugyPClPXnL6bCYEOtH+poK+UJtPdNdJIT9q9bD5NkIf6b3AhEsgejHIYAvmdoR/8qUcSAhVKNwxJVBOWa0OZQc4VyUADamP4mYf9EDRgEjoT8cZ6kPvCxmzWWHu/zqU2gMsnAMXXA8QrT1ql4DOpO/NmhYlyTqUM7mUM7Q==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(346002)(39860400002)(396003)(376002)(46966005)(26005)(81166007)(316002)(8936002)(6666004)(107886003)(478600001)(2906002)(426003)(9786002)(7696005)(6916009)(4326008)(2616005)(336012)(8676002)(83380400001)(47076004)(36756003)(186003)(44832011)(5660300002)(70206006)(70586007)(356005)(82740400003)(82310400002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 16:44:16.9900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82e202e-84c1-481f-5451-08d8445f1ce0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5873
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Xilinx uart is similar to sbsa but it has configurable
parity and hardware flow. Add a compatible for the same.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/amba-pl011.c | 77 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8efd7c2..41dbcee 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2073,6 +2073,55 @@ sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+static void
+xlnx_sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
+			   struct ktermios *old)
+{
+	struct uart_amba_port *uap =
+	    container_of(port, struct uart_amba_port, port);
+	unsigned long flags;
+	unsigned int lcr_h, old_cr;
+
+	tty_termios_encode_baud_rate(termios, uap->fixed_baud, uap->fixed_baud);
+	/* The SBSA UART only supports 8n1 without hardware flow control. */
+	termios->c_cflag &= ~(CMSPAR | CRTSCTS);
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		lcr_h = UART01x_LCRH_WLEN_5;
+		break;
+	case CS6:
+		lcr_h = UART01x_LCRH_WLEN_6;
+		break;
+	case CS7:
+		lcr_h = UART01x_LCRH_WLEN_7;
+		break;
+	default:
+		lcr_h = UART01x_LCRH_WLEN_8;
+		break;
+	}
+	if (termios->c_cflag & CSTOPB)
+		lcr_h |= UART01x_LCRH_STP2;
+	if (termios->c_cflag & PARENB) {
+		lcr_h |= UART01x_LCRH_PEN;
+		if (!(termios->c_cflag & PARODD))
+			lcr_h |= UART01x_LCRH_EPS;
+		if (termios->c_cflag & CMSPAR)
+			lcr_h |= UART011_LCRH_SPS;
+	}
+	if (uap->fifosize > 1)
+		lcr_h |= UART01x_LCRH_FEN;
+
+	spin_lock_irqsave(&port->lock, flags);
+	uart_update_timeout(port, CS8, uap->fixed_baud);
+	pl011_setup_status_masks(port, termios);
+	/* first, disable everything */
+	old_cr = pl011_read(uap, REG_CR);
+	pl011_write(0, uap, REG_CR);
+	pl011_write_lcr_h(uap, lcr_h);
+	pl011_write(old_cr, uap, REG_CR);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static const char *pl011_type(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -2179,6 +2228,28 @@ static const struct uart_ops sbsa_uart_pops = {
 #endif
 };
 
+static const struct uart_ops xlnx_sbsa_uart_pops = {
+	.tx_empty	= pl011_tx_empty,
+	.set_mctrl	= sbsa_uart_set_mctrl,
+	.get_mctrl	= sbsa_uart_get_mctrl,
+	.stop_tx	= pl011_stop_tx,
+	.start_tx	= pl011_start_tx,
+	.stop_rx	= pl011_stop_rx,
+	.startup	= sbsa_uart_startup,
+	.shutdown	= sbsa_uart_shutdown,
+	.set_termios	= xlnx_sbsa_uart_set_termios,
+	.type		= pl011_type,
+	.release_port	= pl011_release_port,
+	.request_port	= pl011_request_port,
+	.config_port	= pl011_config_port,
+	.verify_port	= pl011_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init     = pl011_hwinit,
+	.poll_get_char = pl011_get_poll_char,
+	.poll_put_char = pl011_put_poll_char,
+#endif
+};
+
 static struct uart_amba_port *amba_ports[UART_NR];
 
 #ifdef CONFIG_SERIAL_AMBA_PL011_CONSOLE
@@ -2754,7 +2825,10 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	uap->reg_offset	= uap->vendor->reg_offset;
 	uap->fifosize	= 32;
 	uap->port.iotype = uap->vendor->access_32b ? UPIO_MEM32 : UPIO_MEM;
-	uap->port.ops	= &sbsa_uart_pops;
+	if (of_device_is_compatible(pdev->dev.of_node, "arm,xlnx-sbsa-uart"))
+		uap->port.ops	= &xlnx_sbsa_uart_pops;
+	else
+		uap->port.ops	= &sbsa_uart_pops;
 	uap->fixed_baud = baudrate;
 
 	snprintf(uap->type, sizeof(uap->type), "SBSA");
@@ -2781,6 +2855,7 @@ static int sbsa_uart_remove(struct platform_device *pdev)
 
 static const struct of_device_id sbsa_uart_of_match[] = {
 	{ .compatible = "arm,sbsa-uart", },
+	{ .compatible = "arm,xlnx-sbsa-uart", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
-- 
2.7.4

