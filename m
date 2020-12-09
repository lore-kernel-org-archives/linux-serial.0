Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CF3C19425
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 12:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC2923BE0
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 12:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgLIMT3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 07:19:29 -0500
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:62529
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730428AbgLIMT3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 07:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwclyBmtiSMjEgE6Pz3ZoYZYLffkrM9s92aq1yyIqIcdBNuoiv25al32C7jQeKDq73XnKlDRVVlHMHw7c94xouOs2C6bc/2HMUEnchgz7JCKonC81GtZvvOvzBsG2kRhtTjizGSCPbZ6h9bZnbAaNa8Tn7EKlSETgc1TgxdFvQHczYZKtQUxHWE9LIkXE66gXGyo9OgS8JvIJVHoLrw+ID02AEPbRqRhA8YTh0he5cRF1iEWnGtTD+btC2weNxXt4P4UboNFBgerOpMt4++F/QfXm8MlVTTq6UiQvnFcPus+JQpWnSIcNhOVKvP0We2tKOdbMeC30CxWwRV/nVcqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL4o0K8kgdcQmclItczMLRZXCFD3S6Lhwb4iCeF8r+o=;
 b=hr9Pflu23+iXoogweuObf7pQOZsyPpcEqCGdqNcB54GQcRIqMnGZU9lVGfeKpzHrxO8NgaounsTpig0/la7GlUV2fXKsIIjKZpFfQ8d7by2TV6NdXvrZoE1gRYha3iS0RCGtwfneoo0ecgUIy4BYLViV1CSmE1DpKtPIa8iB3ZxOmK/eu+F67jpzWhHmyJFt4GewQqTfBCuLzayGCRFQSONbfmE0DuEmpqGoDTZxAeL9AYjgXIPykVXT7RpcnI5kR3sJf7zar6B9SZOOW3na3QIo4pIeqpzBRqajTN9JkdDkS74FMkOlPOdld+nuM4Ag2o5/eGDukK7yBAPDg2wFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL4o0K8kgdcQmclItczMLRZXCFD3S6Lhwb4iCeF8r+o=;
 b=GuQp4uBxKfowlNp9oHd392cdmOdynZcpDFJhy8QtZStRQPYbaNbu0rNn9F/cEB6qjkCxiEez7rccjsQIDR4tc4fBiWgl7Gj5/nu9/Th+WQW3KgKhYQLBccjp2NdIkdGFR/VF6tWuHsQjcXr1SYs2wqXis5uX2CgLOls4gxyHZgE=
Received: from CY4PR12CA0048.namprd12.prod.outlook.com (2603:10b6:903:129::34)
 by MWHPR02MB3232.namprd02.prod.outlook.com (2603:10b6:301:64::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 12:18:36 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:129:cafe::93) by CY4PR12CA0048.outlook.office365.com
 (2603:10b6:903:129::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 12:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.21 via Frontend Transport; Wed, 9 Dec 2020 12:18:36 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 9 Dec 2020 04:18:29 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 9 Dec 2020 04:18:29 -0800
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jacmet@sunsite.dk
Received: from [10.140.6.59] (port=53746 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kmyQO-0007Zm-5Z; Wed, 09 Dec 2020 04:18:28 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@xilinx.com>, <jacmet@sunsite.dk>,
        <linuxfoundation.org@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/3] serial-uartlite: Add runtime pm support
Date:   Wed, 9 Dec 2020 17:48:20 +0530
Message-ID: <1607516301-26975-2-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1607516301-26975-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1607516301-26975-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b2bda91-3699-4e0a-5d70-08d89c3c8ddd
X-MS-TrafficTypeDiagnostic: MWHPR02MB3232:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3232CCF8F9FB670942F2ED99AACC0@MWHPR02MB3232.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJdRg+cTYgpsl9w/bx+gBGmZfdoKu8h8uBKq8suwBciZZx8od/HOkxE5/V2gEaUxiPEMlilWV9+h/DaZEutrzKMG/5WKbDOwz/aU4Jw0C/vby0Yn7o/k031ca/zs0pSlN6AgRoxTuTYWxhiT6V4u3n7qNSafC/H6op5xlQfkgJDivVCNLHC5vdvDaThgTu4+0em2EnKnTj96+RyM/VpxMcJRusCfs0Y1YyO/GyfbvmhCQtKye2Xg2YIoYNAWiK3YATKZK8aAbiVzl/cXvU7YZHqLL+m4p49mkUHuuyJCkLCHqdxN9sf3wGs9rHRUaZpd5cVmFmjNUUdLZkToAwQt8x7px81STqhLCEhuCAxFaJwnGYRICf2Vf8108dcVAHUUlmolR1V6GcMQuMplDCekjHIVWxmRxJBvG8kGhWz1ftc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(46966005)(9786002)(426003)(5660300002)(4326008)(54906003)(70586007)(36756003)(70206006)(2616005)(186003)(7636003)(6666004)(6916009)(107886003)(336012)(508600001)(44832011)(7696005)(26005)(82310400003)(36906005)(356005)(8676002)(47076004)(83380400001)(8936002)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 12:18:36.4361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2bda91-3699-4e0a-5d70-08d89c3c8ddd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3232
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

 Add runtime pm support

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 59 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index ab4954f..92dd528 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -22,6 +22,7 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
+#include <linux/pm_runtime.h>
 
 #define ULITE_NAME		"ttyUL"
 #define ULITE_MAJOR		204
@@ -54,6 +55,7 @@
 #define ULITE_CONTROL_RST_TX	0x01
 #define ULITE_CONTROL_RST_RX	0x02
 #define ULITE_CONTROL_IE	0x10
+#define UART_AUTOSUSPEND_TIMEOUT	3000
 
 /* Static pointer to console port */
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
@@ -390,12 +392,16 @@ static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
 static void ulite_pm(struct uart_port *port, unsigned int state,
 		     unsigned int oldstate)
 {
-	struct uartlite_data *pdata = port->private_data;
+	int ret;
 
-	if (!state)
-		clk_enable(pdata->clk);
-	else
-		clk_disable(pdata->clk);
+	if (!state) {
+		ret = pm_runtime_get_sync(port->dev);
+		if (ret < 0)
+			dev_err(port->dev, "Failed to enable clocks\n");
+	} else {
+		pm_runtime_mark_last_busy(port->dev);
+		pm_runtime_put_autosuspend(port->dev);
+	}
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -734,11 +740,37 @@ static int __maybe_unused ulite_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused ulite_runtime_suspend(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
+
+	clk_disable(pdata->clk);
+	return 0;
+};
+
+static int __maybe_unused ulite_runtime_resume(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
+	int ret;
+
+	ret = clk_enable(pdata->clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable clock.\n");
+		return ret;
+	}
+	return 0;
+}
 /* ---------------------------------------------------------------------
  * Platform bus binding
  */
 
-static SIMPLE_DEV_PM_OPS(ulite_pm_ops, ulite_suspend, ulite_resume);
+static const struct dev_pm_ops ulite_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ulite_suspend, ulite_resume)
+	SET_RUNTIME_PM_OPS(ulite_runtime_suspend,
+			   ulite_runtime_resume, NULL)
+};
 
 #if defined(CONFIG_OF)
 /* Match table for of_platform binding */
@@ -803,9 +835,15 @@ static int ulite_probe(struct platform_device *pdev)
 		}
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
-	clk_disable(pdata->clk);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return ret;
 
@@ -818,9 +856,14 @@ static int ulite_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = dev_get_drvdata(&pdev->dev);
 	struct uartlite_data *pdata = port->private_data;
+	int rc;
 
 	clk_disable_unprepare(pdata->clk);
-	return ulite_release(&pdev->dev);
+	rc = ulite_release(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	return rc;
 }
 
 /* work with hotplug and coldplug */
-- 
2.1.1

