Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0C1CCA480
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jul 2022 14:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiGTO0a (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiGTO0Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jul 2022 10:26:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B2118B16;
        Wed, 20 Jul 2022 07:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esLUyrYhbCPwqVlxFLA4dysmce2IcQtXCaDm5YW4oMPCnWb4yVbk/5s8qBWSDwU3yAHrPjVYTj2SbaRCpbpEjGW/E/CqEJSnbhgc1/EzodJVDrndO6hfJJXSzPyPQudeorAi+sPEoj+mkOpM+Tg42GjpNbqIIEqutXiEKcP9nf6xeE8IcuN6HA8jAtaLseMxI74ieCiyC5hFto0hQkDb5cglgy+IHC/shc1uN/pH7897Bt5+Ap5+D09j818AnWcSCdQapducUWRvYPT1sFYF+joezv+9WLBhOm9rnYJ/9ZvWrzboC4wh+vl/liCuEyhNZkrDW8qQVzXjaas4I2CmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLc0Bigpsyk6pzFgqGGXXuFvXixJ4mMfmAr3UlDDqtg=;
 b=EBA9O63uFuCFUMPAzbyUwgpcg6oJr/XGMHGdVo1n4t6X6/cKp6y5qV8jbDThGABGpQLmxHbWHlmOwCMqfeaM0YmftqUVDnYzdxtzDZF7AtMe/7VgOe1NjWujUT1vUU2Wzj5sFHXNFZyEqI0HjOSeongTfcNfmoxAuP3fszVzWK4Ee+DUHZ5E0WljzuyKHC2nQ5VwYE7Y76uu2a30jfJkKlKOC8XIKL73dmS6/h5pbKlZJIy/sg/uD6Y+yOi6Vjzdl7vtjlfqyhOwM1HnP0y0VCb1Myoakhq5CiwT8PHV4zqVa2kpCSOz0NueF6UzQx2P28sIY9oSHS2Lua6d0OHF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLc0Bigpsyk6pzFgqGGXXuFvXixJ4mMfmAr3UlDDqtg=;
 b=GhZRMgAk3Upc6oQk3OosPo8KDRWTC+FCNnSUmtb8yzjkXQrVJ+9C+k3VPjNRpWvBIPVziLQE/B3SqQ0HbSiY0SWaHVX3wEiro4RGsr6sD8toqWAFXNbN8jfMHU70gDdF2SGi+hpn+0YwRXodLNPzv3cMxkoO461f78t+2h6nQfM=
Received: from DM6PR02CA0134.namprd02.prod.outlook.com (2603:10b6:5:1b4::36)
 by SA0PR02MB7418.namprd02.prod.outlook.com (2603:10b6:806:e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 14:26:22 +0000
Received: from DM3NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::1a) by DM6PR02CA0134.outlook.office365.com
 (2603:10b6:5:1b4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21 via Frontend
 Transport; Wed, 20 Jul 2022 14:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT030.mail.protection.outlook.com (10.13.4.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 14:26:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Jul 2022 07:26:20 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Jul 2022 07:26:20 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 gregkh@linuxfoundation.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.59] (port=55844 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oEAeZ-0000jg-V7; Wed, 20 Jul 2022 07:26:20 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@xilinx.com>, <shubhrajyoti.datta@xilinx.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/2] serial: pl011: Add support for Xilinx Uart
Date:   Wed, 20 Jul 2022 19:56:12 +0530
Message-ID: <20220720142612.19779-3-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220720142612.19779-1-shubhrajyoti.datta@xilinx.com>
References: <20220720142612.19779-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95942d39-92d2-4fb9-b71e-08da6a5bd218
X-MS-TrafficTypeDiagnostic: SA0PR02MB7418:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7LTyMfJ8D6RL/fO/R9S6ECCwszlvNl5iXR3ORTT1d5FMnEvJSbEscUQiZ18pKDPL70nXy+P73dH711CqvyOryA4WbCdPAYLDUXqJEPjhEYWGE74WJoukOHgQuCZJlhDMcSnSwnEPmcZ7uQ0lmixh2YmhTjQJZVzHM9+v+v/nOvQQAOCFoF9710T8Jv23ZrZtkLMdWS71Dt433J1/M949TQDYjXzIMvLI6maZjVFmu8c04T09XWpp3kv/Oh8Z4QjTQ0Kl6tBhmuXCImI1mJEYV0g0DnHJFc3HRNEUxGj45erSTgh7Xp6AIIO06STKDC0tFyPuZ1kwFVjDyr8SPrJUJVRbApK2THw+KiyySAuyBAzayHaH+WYetC8vIpeGSxsacZts6UBzt1NgYRmrvKzoIJkWgtLlNEwpGsepCBB3MO4TWaTeTwVLz55LnsNKE3aRtOaifbLnYVPBml3JYzmTfUAL2ISZ1SaKkSFglnYmW71TtpMfRSZ+IURvdtzOafurOwPNWVptmkYD5O0kZvO1OZHv4d9fVEz8hqKSC1BqSkLJxr6Ibr7XL8TR09QXm7i2v3/So3/KGqV2nL0r5u9qFzDC+1ofqf7OJ+b7O02GacPumLOBx38/gKIh4jiG7c/mpvNhlBJ2GEP/qatlmCvzzuHGiDkQx0sszYkuveYo70WUdpseEne2wTxJqdtRqb+nvMA7Ei11BjNq2/f2XZ4rLqPRa75ShmLm1Nz33xs6Mv/bujR5oAbIU1kBmJhKjMa6UOE4sqCH4UbaYy2d5aE2K7t77FzNXPXJjgKcHaMe885PMikME4hEmCPn1MxTwagtXAmSB+LjmFeLwMLx/6VMQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(40470700004)(46966006)(36840700001)(70206006)(40460700003)(54906003)(316002)(336012)(6916009)(26005)(36860700001)(426003)(8676002)(47076005)(83380400001)(70586007)(82310400005)(36756003)(40480700001)(4326008)(44832011)(2906002)(186003)(6666004)(9786002)(8936002)(7696005)(41300700001)(478600001)(1076003)(2616005)(7636003)(82740400003)(356005)(5660300002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 14:26:22.4812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95942d39-92d2-4fb9-b71e-08da6a5bd218
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7418
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
index 97ef41cb2721..096a56f64d17 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -152,6 +152,21 @@ static const struct vendor_data vendor_sbsa = {
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
@@ -2581,6 +2596,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 }
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
 OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
+OF_EARLYCON_DECLARE(pl011, "arm,xlnx-uart", pl011_early_console_setup);
 
 /*
  * On Qualcomm Datacenter Technologies QDF2400 SOCs affected by
@@ -2824,6 +2840,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 {
 	struct uart_amba_port *uap;
 	struct resource *r;
+	int xlnx_uart = 0;
 	int portnr, ret;
 	int baudrate;
 
@@ -2834,6 +2851,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		struct device_node *np = pdev->dev.of_node;
 
+		xlnx_uart = of_device_is_compatible(np, "arm,xlnx-uart");
 		ret = of_property_read_u32(np, "current-speed", &baudrate);
 		if (ret)
 			return ret;
@@ -2863,13 +2881,23 @@ static int sbsa_uart_probe(struct platform_device *pdev)
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
 
@@ -2893,6 +2921,7 @@ static int sbsa_uart_remove(struct platform_device *pdev)
 
 static const struct of_device_id sbsa_uart_of_match[] = {
 	{ .compatible = "arm,sbsa-uart", },
+	{ .compatible = "arm,xlnx-uart", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
-- 
2.17.1

