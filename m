Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794208185;
	b=XVjXRLr/3N3IOSP25/ly3CI9mUxYBSo6f+oWtoPpT4q0GzEuIWqU9f3kprvHm80jbbq3
	 o/GZna+5tWOgoJ1WTeCFFuOmAcAiLzEK25VVNf5UZsY0IuiGWEbHqVDrDvrydZzlPsche
	 uc/mwDBaxXZBrYaSG1iUB+Mblf5cxzfe9oIgyJt9kAFL91tYH+254KUCnfy6pRrT0SOOV
	 fSRJ26kiDvzUWxY8BQ4+IjE3IznWtSQJTB3775q7nhQL3uxThwPw+XeJ8JWwhXgizYAp/
	 s9jgf/O8AgMnm8qh1vMwgNpDxveq8VYU1Z55el2YIAP8ooERS9Z5u54FWWBNNlcUbbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208185;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yAYks/SA0vJHt3hnV8Kh0aMzQk2/tXRPyQYdxACnaT0=;
	b=wa915z90ty6W6EWkwjR3YiTbdFLsfdh5v4w1hUn5y6YhfUGmekPpjP4jbzz6Qt/pFahB
	 Ctt71U7/WwDV/GUAHKfBt3idrqMRZPjRSloxe+wnz/3puKO2SDQtZqc6pzOwBN25x1XI5
	 NvmluLYvtT+4tHn2+W3gN66xRErlLWuqE5lOj0W/dmB9u+rEYct9AZpD61eBAWs72NLfc
	 Q7tqiE2SnrNS2K9mfsiC1B0BRxhUoK0PEFtpvgOyeCOGfpYRYKcsvZ9o9dw2wunJMlfW5
	 PPTKgDgrbyUmglqVX7PT44DMe7s/+9D0ZflBie6MC7FIoJVVmfdd9R1gvnqZY097TSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1dSGbqJ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.55
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E63606A31C;
	Mon,  9 Nov 2026 07:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2E63606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1dSGbqJ4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmLqLTGWGAH55N5AFI1RwR5cJU0HfZaJDH/ezxACZm8UgcXr2Vb+ZUYOi9m8jyf9y1wnPfgz9W9K3FjPl4mRe3Kgr09KAtt83So0R/2uTW6fF8LtzKXI9DfS4g/F0qhitu/H7Q/+SQa0ihYE+cdWzX9a19YsJ/3iT4rRHQVXT1E7gwGqTjxz92wyoPEFomVVRlfRGRs042UV70yc5wbg1W92C4rKF8t1dKBJdfljaLNhgg+nXcShy1edVxbfBjC4L06C6hXzeh5hYtgd7vhy3qn14YBJQUjikhnWCAt/0OVD9b0ilF4hqbOMRaVtSjXMOjcpY8x289d1DDw6BKTtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAYks/SA0vJHt3hnV8Kh0aMzQk2/tXRPyQYdxACnaT0=;
 b=RNXsdWWKFZNAl8S39gkQEA2GE9GRywOnJizDW4Ir0aJrWgOMERC6pPz3cYwtQj0dggECo+DbptJCcB32tXseYQEmWFo1xbHKMbGPJj/mstsF5sxz8t54S2SxsGVox8ZjNe/FbNRWFjOBHe2+yq6v8H+Y4N0veJZzFpuhG4CDYOsSGIbmV/kTD36SFa14l0gTYrLOVRnQJWXd8RIAK/OIC3/fw15fPevEd54KEYvw+Q14UhZiLd4UhmILqxdEQWhTRE3a6DtKSvI0MA/cp658pIK4V+LV9q+ph0RJNpbstCH5MSJTY9sACwb8Cc04wHSkaTZKjRIzd7a6OXyqU+K3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAYks/SA0vJHt3hnV8Kh0aMzQk2/tXRPyQYdxACnaT0=;
 b=1dSGbqJ4T96XfaR+HJwhpw+LfvZA2Ffn3m7KAjW0of+P7rZL876JyOa14diJ+7RdoM6kj6n6VSKVbiILMxTn+oxIBTuo7z+aSK7ld7hQVzqLXGkNDMiQXZS+83LITRVBzdBFc6kDwRbcX6QM4AZ3M/YO8XT7Thpj//iARE1vx0k=
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 07:09:40 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6e) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 07:09:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 07:09:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 01:09:24 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 01:09:23 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 01:09:21 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <git@amd.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>
Subject: [PATCH] serial: xilinx_uartps: fix runtime PM race during probe
Date: Mon, 9 Nov 2026 12:39:15 +0530
Message-ID: <20261109070915.727524-1-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 905f5fdf-9584-4f2d-c556-08df3e306bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|18002099003|10067099003|56012099006|261026140227099003|11063799006|261028144727099003|261009221727099003|261022105027099003|261009223327099003|261102123227099003|261021121427099003|261009223027099003|261021123027099003|261009220027099003|261026121527099003|261009221227099003;
X-Microsoft-Antispam-Message-Info:
	1fFy/CwWpEd2zSerqTOVKuNaH1TRBxQC/0kraFAj0+0TYnIxiiIRtVyBafe0or/y/KJgJXRz4RJGCVO7X1wQN/usI3jR93TffKIaQI2WS9Q0Zu6KtIRAY1+vdTIJN6lzMwPLwjOjCl+sl0xpk6VJtHO2oHAe9PTSRAenoZLUknlTEe1mX0tEGEew9P4K+Ylor7mxmvQ3W8nthQWBVyo2OZMLMkELStrrDSPkgmGwTJiGA1KbUoKC7blbFvAGwYf1aRye+9DPU6uCC1Mg08f6oFkBm2AF2Gp+sxvhTvzQm9+PfVoP2/dCWPySDYjvzLRjTIvDdsglw7qfWPw1DE/UA9zTtEJnlgPa2dX3cExqcLzTAy1b41JlfsTBnxgjopvhEZGUYai96BZuJjK7JkPvPhpoAlPfK9zaNNwxV15f4VvMjWt/JD181krUqeef2XY/jL7xdg3ztdcyf78DeefoY2kiDr2bXMgdEeFkrYfRiDt4x4PrFJ+MD7wF5PJOQ1X8DwGTqxl7clSeSfsme3MVi9kGKPc8BNhSHXW5g2/03WmZg2/RS6i8MqKOQJm5C2Yjg6ySbBCh2dZR78y3VWgsJ/BU4cBWwr/yYiZsuPqlGtS/u71uc9XWYC4+W62E0GmxTuAejB5XxguCbTIeaEDWjUSVDBWutD8+6/a99gmZAqQNBfeOrf26DDLIDWXS9tpxLDtuFyjsErssCY800Ys/5A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(18002099003)(10067099003)(56012099006)(261026140227099003)(11063799006)(261028144727099003)(261009221727099003)(261022105027099003)(261009223327099003)(261102123227099003)(261021121427099003)(261009223027099003)(261021123027099003)(261009220027099003)(261026121527099003)(261009221227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K+BAOT1h3NP04sUGCSxIJPHdGgPb9JooAu3xn/ino6dbk0LqotemHLv2azGh0VRxZgPEWo/ARrwxKnyFzAzv4/t8IvJ6Z2G6TXtq/BrvjNxH+QIlkP6DhFCHoWYTlyTJMYIt4ldWvNDWqoqUjwPWYehn9h95xh1wgwWFdhDPojAzeDgyjz18EspN0rjLlXjM3Q2Bx3YQGQeSQfLEqwx3G8MTuf4qN79P/C+Q4imUq9e9AsJHqbCDSCF7M5Zd/CmmSt4JnL4FWQAkijqnZ38tG778WkosvtbfVLnQkhzUe0gvDNvRPoRmf8VAKMcZKlSB3/IKbXzxnVpu1bloIVFZ5KZCDGJ8AP+8xMSDyJoYlxS0sH9qKD2rN3SKyzCJ42Q0UF1CaTQqwDuZbFmvtFl+TBU2sv+e0gz91rrWdQC6O5zQBdqS7AH3b6wjvAYbQX0A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 07:09:39.5886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905f5fdf-9584-4f2d-c556-08df3e306bc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208

From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

pm_runtime_enable() was called with usage_count=0, allowing the PM
core to immediately queue a deferred suspend via pm_runtime_work.
This raced with console write, causing cdns_runtime_suspend to
fire before the port was fully registered.

Hold a reference with pm_runtime_get_noresume() before enabling
runtime PM.

Fixes: d62100f1aac2 ("serial: xilinx_uartps: Add pm runtime support")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 drivers/tty/serial/xilinx_uartps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a072b75dbaf2..e316cac4f35b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1800,6 +1800,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	device_init_wakeup(port->dev, true);
 
@@ -1824,6 +1825,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 			"uart_add_one_port() failed; err=%i\n", rc);
 		goto err_out_pm_disable;
 	}
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
@@ -1842,6 +1845,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	return 0;
 
 err_out_pm_disable:
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);

base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.44.4

