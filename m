Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A37384CF2;
	Tue, 12 May 2026 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568139; cv=fail; b=FdnjtnANWO9yhb5o4/bIwhEAg1F/k56+PHILnxSb5ikVnmdX6kiA9HPN0NN9xV3t/TGJW2FFTTLrsbtOCOmuP6fsVbgvyNifG44uehmTvic8P7Oy9p5l79oqBVqTeRLZmhWnnoiC9N9DbwejpLoEh8I4lpmiaohH2zyUGTVcr9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568139; c=relaxed/simple;
	bh=lMSuGzCSNWg4GA8w9IOe+093Rx9oNohED5LMJYhVzeE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UZKDqHDcrjQn8qOVU/uGppjrBNSsmV00p+QubK2xSNH2DBZ/4xx5aUM2mqPvQCBZZanfszykYCCvLSYKNBITuKoC6waOpydBbWTJvyw4AuTzvwt4j2hpaadNQZrMNBL7jaXmKWdCQQunpu1KCwiHAfLVxkgdlPPboZXOck/gRj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f1iW4QHh; arc=fail smtp.client-ip=52.101.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f1iW4QHh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mliRwfAhLkqlWrMdskG8KFKwQZO94J7DN692fOCVx5oqVSVeohNEl2UkhHYUY13+p++DLS8YmbMJZ4pluSdJPQ61Huf1NhHTs6R6P9AANAZEyFbcN/lQKnLiWmyCY5JuLX6VUIXBGQWhW74LiBZ3VCJySH36/pDjROnKZnUWoaCClk3L/wPeBBsVLob4mu9NGmFYerx0wSFm8juHUkTPTiPYscJHFML54JXN+VjER4eJue+ZWOVRHuqqvhTOAjqY50M1xcFd4fgxzXC8UwKmv0Us3SFYan0SFmazNVugzEZSIgtMJAnM8XAbRM/w0m0jmwDRs05pUAcrVtQoZzQgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TwZ/WVU9zRunH/cG52SEBtq+OaQK3ooUCuJE9skrd8=;
 b=G09f7jbNkTeiOV2PNfv7tDRi/v2JOIabTlzkppiz0eRFUdNQpDCTCzX4lWD8MdbHT6v1heOPRS94RGuUkrBGLIvu0SjprCnLYWnFj5Yq8jXtPFklvtUhFIgHciTIyui6vgHOJ/YyQp5JutXwrWcWHoNouihKVC07zL3/nPFlnaZ1NKL6ExwtCQV91cmA7P67DJ0DMDbkthu0maL/ysTPqGfmTqWepLdaEx3r0xzMFOlb3j7Whisa1mzLZOGWZygplx2mycuFHVs2kho8X0dUh5+woSz9tJhof9asKsNrpw1uJ6e9Wf5f8i/oTXgxTDdlItKUaAXgyXHShO63pGBAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TwZ/WVU9zRunH/cG52SEBtq+OaQK3ooUCuJE9skrd8=;
 b=f1iW4QHhQ7psDxfrPrjkTOjQwjrua860V9mnZjl/6jKwm+WfkjRK8W5gJWsTiLhgHLHfw1winA7XFBFWUYlZDJWVCxN8NE04h8Da/3VXFpP7isHA9iMgSEUEcKw3tkn/zSO5XHJ9H0OmXnRpXp1nv02THC7/wuVLq4FVjpEHSFA=
Received: from BN9PR03CA0465.namprd03.prod.outlook.com (2603:10b6:408:139::20)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:41:56 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::f7) by BN9PR03CA0465.outlook.office365.com
 (2603:10b6:408:139::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Tue,
 12 May 2026 06:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 06:41:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 12 May
 2026 01:41:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 May
 2026 01:41:54 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 01:41:52 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <git@amd.com>, <shubhrajyoti.datta@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Michal Simek
	<michal.simek@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	<linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [LINUX PATCH] serial: xilinx_uartps: fix runtime PM race during probe
Date: Tue, 12 May 2026 12:11:33 +0530
Message-ID: <176bdb50948e99c40f8baaeaac9ffc5eaf10816f.1778567817.git.shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c83fe93-8925-467f-3ed8-08deaff18f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A1wHy8Npn87Ndtgok5lXE4X+CYerdienXpFcpBUTvtswTy3XTsK/nKgYmB8W0bB+7dmycpRnFGbnTZFYULHFHlYAKGXm3MR5Orf0RHYsbm+DvlV268N4BaJDK+wsTGUZTM9fe6ZV8ZuFkrHkE+JaHFhBQRLfvYy4k239hvA84uJ+PcEkNoJ7m057TcC5B/6+/JmKy1Ani4RsDUw44D+8ySjpynpoL0MBVTqgne024Cnej493YBOjW+wyyh1QfX+TN06vZgLTJJL7MCf0eh0tHMyUvCh+PyckffiUOzCSubSS5vDz/+Agz26pmD4mvCDaEd9S9ApXbEBQCjNcLmJvp1f2zNjlxlIKUgMIia10VsCJTVciVkuPb3yTqnhzVaSn0jxEdr9mIu0hNrdowp8Tt0XLEkV5Iia6QrDtFAQEHfoQTg4u21gkdJgpDuGL+xde6yzF9e+DtHvKiSW4Y0KHWYjfXF7SeWvj5djVCigggZ7CYgPxI7LBGAAT8CifVK8r1JJnMoUomZNv+B1DZ0eDmo55JRsaqr+vvEKoP6Nu+UeJ0QJ1yU0xJdVI4ZXSSP/hhtV5rMAgWy6RU8WHWoEXFSaVvoOJZe8Vs4/TARc7PVGNg28snJ5f71G3oHDjvJ0ZH3DmBYAKhyfLvtAa2YsIJYzFWgkzXanfKRY5mBAInIYltH8r4Z6nBNL5FXYYoCEDYjqnujzY+VWWN1H+7tRjG6NkYYWRtbdt9TVpTm5mA1U=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bSeCu1eP6jFJW8E6utLUTaDOXDRdoOC//4h+qZ7pIp1OHdk+cGXC0+XCpgQU4PvlqM8xZtjENLlOZuc+ETwgeLdqQ8Hau46At8lTITlnhu7AnPXld9QdZ+xkkA/SE5yR1Q/tTCDtOmAFuEMRZYFIuWFfqY2YVbWaRetKLJusg5147u2RlMNKAzQpeheDg3k2/06doBgzJa69RZYCUkNTjCol2u+SriOacIZgYH9+tNyKVUOts1t1PypOKTmmrIdhdEKSgq/XD09PDfyi/TZSztlUfGavzRxJBWllXVvgfpSVVaJTiA1pV+CW0K4MBNHSU3Z0LlU+FbYt9Mn6fAFmH09wmHhl0S4InwfIxysJsXjXSbK3sh0gP7R8jJ8VE+QfGy16rRyG0sM7vpwTf6p760UD1pbFdMeFJpVI/XDsKGmO4QKWSCXQ6hv3lDiOJ43i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:41:56.2153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c83fe93-8925-467f-3ed8-08deaff18f7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192

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
-- 
2.49.1

