Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD3C07E95
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 06:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C54611C1
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 06:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhGMGvk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 02:51:40 -0400
Received: from mail-dm6nam08on2074.outbound.protection.outlook.com ([40.107.102.74]:44449
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232908AbhGMGvj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 02:51:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJr3ocVnCRFIUL9DiwE2MiTouY8i7qskFXRUxZD0VZzM6AMYgiULxQX97oWJLJ3WiX0TBGg3kGm48A7y8u6lmyXQfp0nwbNWNDXG0WMjAHOkgcfX92YmDOPSFbjkvaq8pQTv+4wysDlypE4uH7Q9pm0OeuH3jDmqk3IO0Gs55x5LxFHzGAWPvPn8iN86FEA6721JZH2DGe0FVQM22ESUhp/H+OGIdTwkhfStiQHhTOjRtbeFUIXDN2E5kTc8laTBHSJ0Eipc4UVS92o7H3BjK2rxdL3lCdg6KIYt9E3yFiLg9FKnm7ZFwyS/ocAUGIngQpT7NuE1pLhwgIQ5EdxsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp1E3HjXzT8kPozfoJqB47Hij/vx9Zct8B2ESTgJ5zQ=;
 b=QcNSfWx9gtesCO4HydtNc5amFygLjFTEDgDTcC/ZfjBLZi/0o7B0b+SeHl2Eozs3rI802fi1PFaGXAp+cy0RFdyJrnFfJ/zn69BrN0NEgShNHvw/sokJaGUOmm1eCUhIcb5196Sf51+dIqzgshJEO+WnfwIE5dMEXGFplObUpACMHaft20fqiTJyMqsa0H5TYmbQhzDZMTmfvNwyduyBRe4nJDiQMgCdhhlr12DEgpCbF62Bwj4IdiUjaozTZ8/90OEBsXVxZxI1YayRKCvh0xBkigGTud06FdJD/eZXu9L1Wnks1+jDwMTBeJFa0nIAjiesWbq8019+bdHzVcHwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp1E3HjXzT8kPozfoJqB47Hij/vx9Zct8B2ESTgJ5zQ=;
 b=h/TiwrFOxw1zyWSNJKpUSl+jP52NR51VW6IFWV5sTEvSa8Rklc4hIYloVv/1hijAL3LywhEPJZRyqRNJtSv9TRwITNCSEo4BkDnuH5zXL8VDJ04H64Yfh9KAdylpo48/QCbk9yJlgGIho9f8aPMIigTNwHKmuxvEF0s05Kg0A8E=
Received: from DM5PR16CA0015.namprd16.prod.outlook.com (2603:10b6:3:c0::25) by
 DM6PR02MB5001.namprd02.prod.outlook.com (2603:10b6:5:52::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20; Tue, 13 Jul 2021 06:48:47 +0000
Received: from DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::12) by DM5PR16CA0015.outlook.office365.com
 (2603:10b6:3:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 06:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT062.mail.protection.outlook.com (10.13.5.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 06:48:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 23:48:44 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 12 Jul 2021 23:48:44 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.140.6.59] (port=58696 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1m3CDi-000Gjm-Sy; Mon, 12 Jul 2021 23:48:43 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <git@xilinx.com>, <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 2/2] tty: serial: uartlite: Add runtime pm support
Date:   Tue, 13 Jul 2021 12:18:35 +0530
Message-ID: <20210713064835.27978-3-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210713064835.27978-1-shubhrajyoti.datta@xilinx.com>
References: <20210713064835.27978-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee9bee8e-aef8-460f-cef1-08d945ca4418
X-MS-TrafficTypeDiagnostic: DM6PR02MB5001:
X-Microsoft-Antispam-PRVS: <DM6PR02MB500118F4DD5F11D36FA260A3AA149@DM6PR02MB5001.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTNltlQAoSH4doxxDzzeQffePu3WWzd63iZA5lRnpTQkU1twKD8cCY57CLdGH2UR1qkC64iN//afpGo+GVoN1LPyytC16RFSbukWGl3wc89l9Y93ebHHUanWMtAyf+PAQPn3OEDPSXa+wVcFFY2PWK9rv3wKusaNGbr+J8jan8r7ko3C6uS6R1Q8h2nPuU2UBYFGcLvXi9Xr+inWDkACglhe8xW1QqkWGeenb3ndVmEzZtU0cztHyUmpgjLYUtsZ20FGdYTbKFcQM/pC0sCTN6NRGx+G67g5ffJQynlItgN4OoObmoaa2ySLjhLyWLzRl3BU9Eo46BpNkOtOR3s+yP6LuJyE7CC0YexBdOjs+7bwTWNnTy/rkJEphVjPTxTeSPir1wF9GW7Lih62ySUh/V9czNljTm0MoZnBxSM58LUQtXxRPZO+Mvv6+m5Qcf7PspZWLvgaXzk+zpxv+bbKItk+NTH7azNxtm/WAR+IepAd+9zAVDO7/ARQzP5wHhezQSMU3YRhI86X1fy+rWCi/McyeI+PbdzYahDufvLhEix4ge9IDlxJeJZTmTDl17onXEo0FnKNPK3hcFeRA41LChGp3pK75UFDVIwB9gZWkFQ9QuHztDoJfp2Iqz4dvnmpASWGuSyzyKnAHKtvEb4YjP/Ay9/I0svssa9joADBaQeEIU3MwSePCPp2TzmrpP5XhFP9QwQ31dGeKajKsG5fByqPflCY3B118NZSAPjHIiQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39830400003)(396003)(346002)(136003)(376002)(36840700001)(46966006)(356005)(8676002)(7636003)(107886003)(9786002)(83380400001)(36756003)(82310400003)(26005)(2906002)(8936002)(44832011)(70206006)(316002)(36906005)(70586007)(6666004)(336012)(426003)(54906003)(186003)(2616005)(4326008)(110136005)(1076003)(47076005)(7696005)(36860700001)(478600001)(5660300002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 06:48:47.6913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9bee8e-aef8-460f-cef1-08d945ca4418
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5001
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In the commit 07e5d4ff125a ("Revert serial-uartlite: Add runtime
support") the runtime pm support was reverted to aid reverting of
the other patches.

This patch adds the runtime PM support back.
The runtime pm calls are used to gate and enable the clocks.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 60 ++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index fd7a2f82c885..51d4a485f4a1 100644
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
+#define UART_AUTOSUSPEND_TIMEOUT	3000	/* ms */
 
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
@@ -734,11 +740,38 @@ static int __maybe_unused ulite_resume(struct device *dev)
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
+
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
@@ -794,6 +827,11 @@ static int ulite_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	if (!ulite_uart_driver.state) {
 		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
 		ret = uart_register_driver(&ulite_uart_driver);
@@ -806,7 +844,8 @@ static int ulite_probe(struct platform_device *pdev)
 
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
-	clk_disable(pdata->clk);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return ret;
 }
@@ -815,9 +854,14 @@ static int ulite_remove(struct platform_device *pdev)
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
2.17.1

