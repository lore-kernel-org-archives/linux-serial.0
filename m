Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1070C2B9F8
	for <linux-serial@archiver.kernel.org>; Tue, 25 May 2021 08:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84AEB611C9
	for <linux-serial@archiver.kernel.org>; Tue, 25 May 2021 08:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhEYIWB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 May 2021 04:22:01 -0400
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:52864
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230370AbhEYIWA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 May 2021 04:22:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpgUsUVeNqklX16REOfD44lPr7u6WO6IXKxVaqhzkmh7bD1H5WLLMA8/3o1Cofw58visi+QTUsdod3bvXls3fhAxl0Mlr6/rOOZWc6aKNxWz/y76jCfAAmq6pUAmE6MJr409AmG22I8uMIsx85KE0rHOw6sK+rO0zDpGXxPpMNuwyvpohZcpNaDjI9yBfPzEz0ukFK9920THege93A1QnX+yyHJM+sKqf+yMTyQInwjYq1ZdjiXNItpYx8B18NCIOAjUj/L+Kky4Qgkax0art8BKEpvHAxaLsbe7xRM/jKVDpeIkhuoBzfRFlYt5jz2xXHRBxfJ8kCdwEafgGgqP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNfFPOXTjMXT/0GGOPlK8DkloAsHXVYCW2junRpSp6g=;
 b=l8pXBqAFWVNH+RfA5KE8QOrT0/rMG3SxOaLoA3b7PyfYXJ83h7kP8JMg6n69rCqR4DPBKLoZzjpolND9WN8tadKs4wLAr8MHHF824j+b1XpUrNeQOUV0ObwGOJAR0lJaALFPblOD7cpxoQQWgwjnRap/29qp0BlG0oFL7hFO7lnjAuo9O4Awzb6Cb+U6PhCpGYc3zVvvnUBtEkiGlkX0tNQYIh6g7GTVMD/8IZi8Br0cNCHDgrJx9SpwIG/A+eS3IVTWQVPJ98rUWhdmp0eJZjpJx8LswabPkKEozOaqgBjBfucRV0VCNTDiBfcqp2Bncl6dvBqzK3l5Ew9mWLLEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNfFPOXTjMXT/0GGOPlK8DkloAsHXVYCW2junRpSp6g=;
 b=skIjdqdv4qQg/zIt+LVXIid1JDwhBkeICZUEF0salkmXP0FqHZC+5WTuFcIkSX1rlREhvkoawOLdqzl5x27yZGcRB8JaoOi9CmvUQYRaZg7GMGbNzlzOdECcPZ94QahDY9RtYOCRw1MPseQ6rD9xKMvydLrbeYSp3LOmxs0Z/Hw=
Received: from DM5PR06CA0079.namprd06.prod.outlook.com (2603:10b6:3:4::17) by
 DM6PR02MB4363.namprd02.prod.outlook.com (2603:10b6:5:2e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27; Tue, 25 May 2021 08:04:33 +0000
Received: from DM3NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::7f) by DM5PR06CA0079.outlook.office365.com
 (2603:10b6:3:4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Tue, 25 May 2021 08:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT053.mail.protection.outlook.com (10.13.5.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Tue, 25 May 2021 08:04:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 01:04:15 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 25 May 2021 01:04:15 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jacmet@sunsite.dk,
 gregkh@linuxfoundation.org
Received: from [10.140.6.59] (port=58378 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1llS2w-0004Kz-RF; Tue, 25 May 2021 01:04:15 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <jacmet@sunsite.dk>, <gregkh@linuxfoundation.org>,
        <git@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/2] tty: serial: uartlite: Add runtime pm support
Date:   Tue, 25 May 2021 13:34:04 +0530
Message-ID: <1621929844-19727-3-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1621929844-19727-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1621929844-19727-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2489b3d-56a5-4e70-f0a7-08d91f53bb4a
X-MS-TrafficTypeDiagnostic: DM6PR02MB4363:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4363C991A477F56A94C8F88CAA259@DM6PR02MB4363.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuGue27RgMT1s0lzShPLSkG++g+BcywpWS1qDWYphBoKhMhizF75bUFG2wwgxVJxzHe21rk5MOrOAAmE4oqa7t884/oGYeLdzbFP/Hm3ZNTY5wL+pRwcQuupnQk8hYI9g5jFV1w0aZuqu2a+iSa0bg35do70epA2k1I4AfTKlaiV+gLgQOC48thqipFf4vfxBIwHq/E2vpB45dPPzu2QtahyRVxHT+GBux3rHEbWQhAMcJyDK5RjZJC2mvDm2BxKcd8X+wFfFCoebPGZIF9WUSntjoYz/C7yw+BpeRiIrFBIEhCIrL1i0/wnJiBNZmQUrorhrGzim+Rbjnvv4c9bT6f6IhzYz21v6uYOC7K7NaGbxhGyDbQb0o9RAt2naiOBLOdD/Maw3/WmhfAgiDaOCUvQKI0gMIp6aoOwT20y7CNlkslEnqN1Oo1Ftoc3kuZMDpjclRD7xT4X2J0uPRfDZAjt5ExdaqEv/6Krn0eYgY6YTuV+kcHz40EzRly16EdLC7ZIbjdeXqbQ+jyHDYM3p1mft4STzB9HLFkLC9iFNceJmdhjl5P3tJrQLcjdMujD0QYkJ6uPOzUGtGOQLEVmjOviqk2cEXUZth9zElQXsohJgUHnBoiY+aRAMrbYsh4kftSqgKo1Z7XnySLCitUnyjYVTwc6Wq+yp3QFdWYyS0tsTTGd1+s+71MiUzAQbTmv
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39850400004)(376002)(36840700001)(46966006)(26005)(7636003)(36756003)(186003)(336012)(82740400003)(36860700001)(6916009)(316002)(47076005)(2906002)(36906005)(70206006)(70586007)(478600001)(44832011)(7696005)(6666004)(83380400001)(54906003)(82310400003)(8676002)(356005)(4326008)(426003)(2616005)(9786002)(107886003)(8936002)(5660300002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 08:04:33.3733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2489b3d-56a5-4e70-f0a7-08d91f53bb4a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4363
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add runtime pm support.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 59 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 39ea495..581689e 100644
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

