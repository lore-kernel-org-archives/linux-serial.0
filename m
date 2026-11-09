Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794208780;
	b=Cq2Izy54U48vxOKFrm9x7WHQBTTxZZNtHQ0HchOoUSK+PpRMiRztjpaTUDdhPxBwdqYb
	 HeWj2dANH1ENv6PMT1XfiyLR8LMhxlNT93HuLgzjqRg9vbi4FNOp1Bi1bcDUJj/ynof4g
	 gOx8NSSix/o551tvfbNpmcPBDIlaItKBx7RojZgFctee2iY0DD2g52Og4ICH7uOHLRYmK
	 Bmwvx2TWg9XfXp2U4Y0mm3xEpzkKDSFAfY736XPykSAvupqoYFKEG0dS39O9MetE+0mn5
	 hwJ8fE6uT+A90F7ibcg016UWRssaFpVjFRWeis2AVzLKAg2dH2qPebNUWcH2mYi8tCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208780;
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
	bh=5m/LqfEs2Q6pvjEFjy4I+pXcRPMYw2RSQ8eG1V+I17s=;
	b=f2NY24vgRGgDMrKWsVhrZzPvNnQN+Y1a9Upp5tj0zftA7gUfKF/juF9/ZdrrvHB42AUf
	 etNRKvlx/lokCKbSNm2xxZLYxEE1FQSriRxHHZ/nQgjcHqECPTN8fE4fA0gSsGf/nOjOX
	 CLSZbUk79/iqwtxrSbr5oHIQFh7N/KjaGzbxGOoa+rJhS9UQOScOP5G3WjLUFeyGX7y0x
	 9Kp/CvPuzeUlwo6pzMoFhDZV+J/JFcaqNO1itJAZn0Wvp4W91qigLaZtX0LdZvSXo0BXj
	 UvIkw+fzBOj/soFfbEv4likki3OEwLGkHpulQJ6jNQLmHnJi4eoYkGrkkPnKJ6SSQ4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ukl6dKj0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.42
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B5606A31C;
	Mon,  9 Nov 2026 07:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C3B5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ukl6dKj0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTNMe90xK+takhjc7EbkwTPyUwkSOq+FQXufQro4Yy7I7YPhN17rC3r8kGnhvbdcqAFPcN6AcgTQuDbCv7uskL+slVSWMUxOGtGZdEwAvJoJdDC7I2ORQqYttt48JCfMuLIuwxncxWTwzhcwIVgbdKgpa+WZvwgx+RMYMjFDI7k2oW1Xpq7Zvx80AJgqGZC3QSKYZ+M9gWdp66ntlqF51VVwX5W/xgBmONVH7331AZOcogvf5I9LfH9uVGgVlzeKnnh+p76d6N5F9+lzV4BTSrMSWLL6OZO8TnK5DQNC1U3mouyMqn4JlLJhmD3U06PL8bpKVss9tSAaC9h1O7XOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m/LqfEs2Q6pvjEFjy4I+pXcRPMYw2RSQ8eG1V+I17s=;
 b=ZOo1m1n1GDkjNjAWhh31XeCZbz21f+2zZPK/DRTUCBwnFLZ8aaFhiqSbphbzyJENaqUEaiIeSYPdGjiLg6jQbDBqVh1wkPvd3E6S/jdo2aEPNwy0a3JxmnG99TzslA+1mKzSVXOd95SlhZY//HMdDj+HIWueH/EkVdCDf/0asDYs7xRBx7oCjmilhrLxYB0u0z1Ebbe7LupoidxXtpXPbTCBzwei2qYdzkRbnxM9ja+G6E3VDHMugvJBlNYy7GalLAXwoGLdWqDvfFvcPfrPMfXT6FcB/le9tek5YJvk9a/FygYQ3bQ6ZWEAyxGBSUue9EAqEIUN/YIPzBOXBBhofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m/LqfEs2Q6pvjEFjy4I+pXcRPMYw2RSQ8eG1V+I17s=;
 b=Ukl6dKj0ULmO5nwA4y/NU9RoSz/E7LQ/iKrYXPg5J2um9+ye9Z1m0rFXVI+LB17YrUt4Q5kIbRiaet96PqnTWcLXWE2Ii2OYLBe/BfMhKFGafUBSi8xZ2pVLoiEuUDBPGSglUh6YsiRU1F0iPe6mctRYCAi9hZxcix1uhG8lbZc=
Received: from BY3PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:39a::24)
 by LY0PR12MB727857.namprd12.prod.outlook.com (2603:10b6:408:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 07:19:30 +0000
Received: from MW1PEPF00018891.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::1) by BY3PR03CA0019.outlook.office365.com
 (2603:10b6:a03:39a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 07:19:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF00018891.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 07:19:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 01:19:29 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 01:19:28 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 01:19:25 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <git@amd.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH v2] serial: xilinx_uartps: fix runtime PM race during probe
Date: Mon, 9 Nov 2026 12:49:16 +0530
Message-ID: <20261109071916.731116-1-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00018891:EE_|LY0PR12MB727857:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7f09df-d0ea-4929-1e82-08df3e31cb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|261009220027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	svwkWAL5Id9IwXFa0XOEgdJndz4Xkw90MabQjdItJqNqBn/awfadT9TaDGsh+z7iaAiPlSh62GDigNa+k77ADOUSy1rAQeo5+l9f9gjxYwdlOBRW8e/hgxcr3f/ZOxVLaEVKoO6FWBxeJ73Ol5m/3dDCMd0RC/ZoMLzModGBdycWhtD3Ds2QAE5NIykdCcjgz4EBmWl5E86SW0VZPeaoe9TgtNqeE9izur2aChA61xpBFS/IiwTF5OSgceGpuYAA4KnnS8Jb2FYYZOZ7VdKp/JhWq2SBcjsAZ4EEQpxAE6Po63sIsQRJujXb+fCeZ+wdbhWQzkQylXk02IXRF7JiGFf5+lR6ou+Y7W+g/zrFh2iubutw8XctAMkXVJD3Gho+kVLnqFa64tO38s0CvP26Z6O8R+vqMgScT5NpuzgsjyCCMb3b/dskUsG+lMHdpD2zH1UXjHWJi5ZdiL/qgRhA3kQUAZa/DMP/CwLNKwVUdWXthyH62hBafFk26yODJY+0wEf9pYWg+Y503Trwsfvp/SEEIpE2DcHzJmyvovLZd5wmC/rYm3SkomGa53PpI5e1Rp9Y26rPL80356wjpwrUyBeoKAyRkhgF/iM9gZum8U6n0DmIEL/+hLM6FNUwArm3ggXW0yWlSQO0D7pbTx95tA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(261009220027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TMFaXJO+fD2zlECN/3cvHZvoslIDTcXxc0d8oHaa1rc82E48JNOHp02IAAPzkkZVUUywJeLtKPi2hMPrtFyU2Q5eC0ROOIZ6TaRF3vwEt8H8HUqVj546y2Iy2Ua9q7z3G8N95qmexe+Tyw+FtuIPLk3gtqEomPHxegWblcZWIDeeORlnjbjAG60v9TbQIfV0voNXXCf0CT+b0lP46VbKNqdxq5Nr0NFJIRTyyChPOGBnJECcdeld6tDCGDpkszatQsHY7tZCCJDxodMj+3uamSeLCv5lBii5jvYA6TbWeVdOwF1+4Neyx0Lq6Z+bpo8tWxwXw7DP+jWQilVzvfmIfJ0s3MLkHvqhjHDrlWZUt8OySUNvwXydo5NPFjrzMsl3CFAbGdGzf979RGoeim2EEpxEcCbHqExPXOWdc9YPCh39tKRzLUXYXk/hjr0WrXZm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 07:19:29.6436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7f09df-d0ea-4929-1e82-08df3e31cb6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00018891.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB727857

From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

pm_runtime_enable() was called with usage_count=0, allowing the PM
core to immediately queue a deferred suspend via pm_runtime_work.
This raced with console write, causing cdns_runtime_suspend to
fire before the port was fully registered.

Hold a reference with pm_runtime_get_noresume() before enabling
runtime PM.

Fixes: d62100f1aac2 ("serial: xilinx_uartps: Add pm runtime support")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Add my signed-off tag.
Link to v1: https://lore.kernel.org/all/20261109070915.727524-1-radhey.shyam.pandey@amd.com
- Use latest base.
---
 drivers/tty/serial/xilinx_uartps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e8c4b1fa7658..aa3e820760b1 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1799,6 +1799,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	device_init_wakeup(port->dev, true);
 
@@ -1823,6 +1824,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 			"uart_add_one_port() failed; err=%i\n", rc);
 		goto err_out_pm_disable;
 	}
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
@@ -1841,6 +1844,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	return 0;
 
 err_out_pm_disable:
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.44.4

