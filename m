Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1600C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 11:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB19B63213
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 11:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhKPLVC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:21:02 -0500
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:43292
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234805AbhKPLUx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 06:20:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmDyl+QBwUNs+cggx0bLyx/CGdMtcmVPZSaUX+ZlUU722qUddRT9zRPgt9wgNaVD0ZtG5ED062bV76MXMkIPT9mtfR0L34K+VT7MdiPt7ZOs3/0FXsFDvKuyCSFmahkwuwpHMhwOPGakpXnAIBiLCPwAZM7jf/zheIuGr8N1KNu+Y67flihh72/mkGVag1cPZ8Jb9PX1thcGESn0RX41Kpr3iT/0ueEuh+AggBuEHUWyiyfwc/bdORdITDPDBLGUAnUb7XoiDgKIBS4PDWt8tIHpYnE4vKIV3BpRzH+Zgz7OWmzJur8BXjCE770KZeKH94NcMZETlb0cIL9mv6FDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8J2datZXpGKMZQSdeCfnK4/sXLgj24LIYR3AWoF+Mw=;
 b=NFy90H4MotFnpEntqBHGIMto4z7Acg7BLobohFW6eJ2gqddKkcKF4OYHMIiDbS0fMS+4+dqi1HHRD8oNPklxvNLtT0jccm8cgvUPH8uAjdGcGZcbMVPeIxBqrwnmViguCKkd67IG1baG4TCNNmrFLl69xLa+0CK6PIodfupMkbBxLqAD9m0neUc5fvRA4Dv9jcWemJxsMh3vi++KW2WxnPm8ezje9mOOs/TZZAkczKTvZMdSUs3og+aL9DsJLZkD4ZAjX9Tc87pd7JZw5L1Edf8azeKCS4awoag+cAfC/vJX+/aFEwqgCbN8zBLior3QHBUbqWlrCQq1R4g7Er5vWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8J2datZXpGKMZQSdeCfnK4/sXLgj24LIYR3AWoF+Mw=;
 b=shzmTOiyMiLaD86pv/LO86qohFcV477l0PfE+gbWGyGJKPP2pHO3RJNwpB6H/5xuCAILRv4hW73h6MFN+uUeaLBrLTpBDq4vce+CanXoP1EXCm6tx9l87uzUmsHM7oatyIfWtB2ou4dsy2MRktILesfK9VFgCwKTMJetdp29nXg=
Received: from BN9PR03CA0334.namprd03.prod.outlook.com (2603:10b6:408:f6::9)
 by DM6PR02MB5498.namprd02.prod.outlook.com (2603:10b6:5:7d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 11:17:55 +0000
Received: from BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::54) by BN9PR03CA0334.outlook.office365.com
 (2603:10b6:408:f6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Tue, 16 Nov 2021 11:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT020.mail.protection.outlook.com (10.13.2.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 11:17:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 03:17:54 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 03:17:54 -0800
Envelope-to: linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.140.6.39] (port=51454 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1mmwTK-0004ZS-Ff; Tue, 16 Nov 2021 03:17:54 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/2] serial: pl011: Add support for Xilinx Uart
Date:   Tue, 16 Nov 2021 16:47:46 +0530
Message-ID: <3d24a1f6dedd70794fd08f9b4f85a7d362d835d4.1637061057.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8e70c96-bf03-4ac3-d7d5-08d9a8f2bcd8
X-MS-TrafficTypeDiagnostic: DM6PR02MB5498:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5498515BA4E2FAF1CF65E76BAA999@DM6PR02MB5498.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arqnzpoSr593LaVSU7a6nKIaYmC6J5n25To6PkTnXpi/IlswBA7wk+jBarf08A4padzUXA34pWvoucqwE08olVUnHv5QC9KfLBhf1upQqbjIUrC3DLFERMkG3gEv7MojluzrT3FzEFIizIT2E+weCh+tRzyIvhXhTmLOInAlpCHH9vocb5Er4lzFwOjxQaMP/uT0WZJbHzZof836k/EdXZdNkbUMVZ2Wzbo+YajD37qVmkx86BRACOankSyIJYKiR+IkuynZYt5br/R7d+ezPZ3DuJQjdD0SIGt/R2TnOOyy/Egs+VKznk/23YzcMSClcVyWuppO35IJODfE5JerqCRy7YFLy+e80iPKsdy4RdmolYqTkeAMEfDgNwh6krIImxlJ0GTOvcm92/kJ74D6dMVRAxJa1sMlBLG/TwGmSiDim01E6mJqoD0L/0CifWMLAqkHFsEQfAOzxHs9A/7BXpSC6Bt9TzRcduA27NUhwdAg4sZMyxSWo6/gOLn9FzE69CRucAnk3THhyk2RSEdbxQ5Iv567DUUoOReH+XohG6f8hvSe9INqevSoaA/WVoDQ7iacGBY9oU27UJzgXRyl02W6vqaf3xwQXWypriBpC23qqhkFidEJDQTxy9UpFuUe4CsCG9pxZ1uVPNUZFdEXF6f4Jujh7otgvjDG8xYiYrd/bJHC/p+wg3K1IBEIG/stLKmYePnBjijK8n16JMD3MkvFd1OPKNYY7PJmmd4a7vU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(7636003)(7696005)(44832011)(508600001)(8676002)(2616005)(54906003)(36756003)(336012)(9786002)(5660300002)(4326008)(426003)(6666004)(356005)(6916009)(36860700001)(83380400001)(107886003)(47076005)(186003)(82310400003)(26005)(8936002)(316002)(2906002)(70586007)(36906005)(70206006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 11:17:55.2196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e70c96-bf03-4ac3-d7d5-08d9a8f2bcd8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5498
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>

The xilinx uart used in Versal SOC follows arm pl011 implementation
with just a minor change in data bus width. The minimum data
transaction width in Versal SOC is 32-bit as specified in the
TRM (Chapter 39: Transaction attributes). Pl011 defaults to 16-bit
in the driver.
So, add the xilinx uart as platform device with properties specified
in 'vendor_data' structure.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/amba-pl011.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d361cd84ff8c..278255a45ad9 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -124,6 +124,21 @@ static const struct vendor_data vendor_sbsa = {
 	.fixed_options		= true,
 };
 
+static const struct vendor_data vendor_xlnx = {
+	.reg_offset             = pl011_std_offsets,
+	.ifls                   = UART011_IFLS_RX4_8 | UART011_IFLS_TX4_8,
+	.fr_busy                = UART01x_FR_BUSY,
+	.fr_dsr                 = UART01x_FR_DSR,
+	.fr_cts                 = UART01x_FR_CTS,
+	.fr_ri                  = UART011_FR_RI,
+	.access_32b             = true,
+	.oversampling           = false,
+	.dma_threshold          = false,
+	.cts_event_workaround   = false,
+	.always_enabled         = true,
+	.fixed_options          = false,
+};
+
 #ifdef CONFIG_ACPI_SPCR_TABLE
 static const struct vendor_data vendor_qdt_qdf2400_e44 = {
 	.reg_offset		= pl011_std_offsets,
@@ -2628,6 +2643,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 }
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
 OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
+OF_EARLYCON_DECLARE(pl011, "arm,xlnx-uart", pl011_early_console_setup);
 
 /*
  * On Qualcomm Datacenter Technologies QDF2400 SOCs affected by
@@ -2872,6 +2888,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 {
 	struct uart_amba_port *uap;
 	struct resource *r;
+	int xlnx_uart = 0;
 	int portnr, ret;
 	int baudrate;
 
@@ -2882,6 +2899,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		struct device_node *np = pdev->dev.of_node;
 
+		xlnx_uart = of_device_is_compatible(np, "arm,xlnx-uart");
 		ret = of_property_read_u32(np, "current-speed", &baudrate);
 		if (ret)
 			return ret;
@@ -2911,13 +2929,23 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 #endif
 		uap->vendor = &vendor_sbsa;
 
+	uap->port.ops   = &sbsa_uart_pops;
+
+	if (xlnx_uart) {
+		uap->vendor = &vendor_xlnx;
+		uap->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(uap->clk))
+			return PTR_ERR(uap->clk);
+
+		uap->port.ops = &amba_pl011_pops;
+	}
+
 	uap->reg_offset	= uap->vendor->reg_offset;
 	uap->fifosize	= 32;
 	uap->port.iotype = uap->vendor->access_32b ? UPIO_MEM32 : UPIO_MEM;
-	uap->port.ops	= &sbsa_uart_pops;
 	uap->fixed_baud = baudrate;
 
-	snprintf(uap->type, sizeof(uap->type), "SBSA");
+	snprintf(uap->type, sizeof(uap->type), "%s\n", (xlnx_uart ? "xlnx_uart" : "SBSA"));
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
@@ -2941,6 +2969,7 @@ static int sbsa_uart_remove(struct platform_device *pdev)
 
 static const struct of_device_id sbsa_uart_of_match[] = {
 	{ .compatible = "arm,sbsa-uart", },
+	{ .compatible = "arm,xlnx-uart", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
-- 
2.25.1

