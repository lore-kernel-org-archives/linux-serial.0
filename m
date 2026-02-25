Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200D3081C2;
	Wed, 25 Feb 2026 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002789; cv=fail; b=szU7is/BisfeTdrlQ5NfiVULWG+i90g//0MClvOewSCfkaWi6O0SIBW30wtUMZMukYWu7The2a3Bq4YcTPCraurID/5n6voC3F0RLCX9bA8IJhqEDv9799ohp5RoIovXp7gLM/X/80AJlZ1W7Hv+2XIA8nubmX5PrD/nSLvbj10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002789; c=relaxed/simple;
	bh=P2zs0VWZn0unFBi3/h3BPH5kZ/B9Q/hM+KtgZy/5JmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btw9UdgNe3t1OHPnxDoqwEYw0R+xvB9uVgBV1dFkAzwLWq8Dv2drNx+8/pXmYLfeuz0qXwjEfQNO9od2t08fvHUTPJzXnb5LoXLL1i64ll3xEDFcHHCCQcX8TwE0qUgiMrvnymwyvCM4Rzo08e2eyPDa16Hyp13nAPkzX/mMWTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p+5YcsSR; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p+5YcsSR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyQW45RbL6hmvFuguM7hwfLFSgfteLcTZKcrmciIYH268f7w++3OAhMLij30oSF57BoeAD+RzzD50yvUz7X6nSTW9pIkdL50nsJkOPlnWXa+HmYhRKyYBywFOJI10Dfmx7FF9EoimxRBYw9eo0sVKZjP89xuIZLfK2FxlmA0vfJwAfLzo/oq/dVbik5ZN6eYOG1tC7o91FH9cpZiBJHqBNK3Sw1lPxJTt6CbbEUDn4E1pPUCwJF5qVtdErQpvaTCFLE4zt5M6piuxGUDw56C7+yMP/OamPNfUdknJhd2udDGLZYRZefVZYOcNfUfcCDuUC57wphZdfr+f14YC+dnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVtcThJPxQB7HK1DAs15Y1MAqXFbs5DESPi1onuNWjE=;
 b=ujaPAvm8JvQk/y456XH8Go7IwgLZ31pGZhyETolpTvrBH/A9cgI32KH3DY8QzIE4b4PeVSWJCH9HCiamQUYcRrd5DTOREuSGFyEZZirUg845N5+7A0IkweJrGYnQ81gU1C+QM0rLQ97cEKPDfxO+FR35S8aPxvzxYc8e3RK7LntIZLryLW/LCs/PhA+rfnRrna3qpYNu5H2lbnLgk+L78E2Htr29bks+u6sOjg8ESMIB/YGQUJXvECnYajHSmz5fzjmn3vPj8KFTSfELbsWO8J13BWn0opyKjxVyp63BavsVyf+msBhHcdOee8eWRVmwi+k/APe6NaTCeStm1R6eWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVtcThJPxQB7HK1DAs15Y1MAqXFbs5DESPi1onuNWjE=;
 b=p+5YcsSRG1C0L7e4qHOhBeb/nTmL2vmb/r0jn9yxKWdbxfYRb0hxkV/kmrsEJLEVyLrkl+rGDNxB8swCkFNZyBV8z7dY8uz0uO++VV/G/Ym/aNYCMWDwCAAsN015MeDWhaYjUOtfM+SLaFpFugztVqn3DNCJxY2Jy0D9AWAI2/JC7kkhwmFf1OBmqAtijwbAWE3440DL5wKgVADXiGtMcNrtZfSsCgH7MrFemqhDg/F+oQGuBO5xm+vL1ivV0RzqLZBr3w/kxHkyMLMCjTdzSi3qYLw0Ke9Llv8ByhtNn6vh5Y9my0b24hosY1gKH/C0MfWXJSWg9AfsXuoosqAdHg==
Received: from CH0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:610:e5::11)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 06:59:44 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::cc) by CH0PR03CA0246.outlook.office365.com
 (2603:10b6:610:e5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 06:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 06:59:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 22:59:29 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 22:59:29 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 22:59:25 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <linux@armlinux.org.uk>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <mingo@kernel.org>, <tglx@kernel.org>,
	<linmq006@gmail.com>, <arnd@arndb.de>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>
Subject: [PATCH 2/4] serial: amba-pl011: Introduce set_uartclk_rate vendor flag
Date: Wed, 25 Feb 2026 12:29:12 +0530
Message-ID: <20260225065915.341522-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225065915.341522-1-kkartik@nvidia.com>
References: <20260225065915.341522-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d343df9-c644-45ed-a998-08de743b74ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tH9mrFr/j0jLh31tRpb4gm9y9STMIWJif3s85SlTGMC5Eco9iaROg3590OkA?=
 =?us-ascii?Q?KCaGKMuRYZ4zJofBIPA9nahoyO5rbanNHZ7djtDqFdOIjXvxsCknmnGyA8fH?=
 =?us-ascii?Q?rFhUr4ncd/lsWPgKzaQbrd0rQpLXq+YPhLEsPlwhnzXXSDY9uh7bvCnUuEnK?=
 =?us-ascii?Q?fqAV0uSFDH4z1ogxj2LFmRyY/45wfQD3yJiqq3EWnBQPH6Rg1EMTBYxVpNLt?=
 =?us-ascii?Q?ieZ6BbV41nMH2QHo5FG1OxixI1bHtVh8GgseKQGVrR21vx6PR3HCuY/UfxqF?=
 =?us-ascii?Q?c+tXmWVTI96x5PFTU0eueVJkbyQclrmgceuGjH/Uc3gYe0gGEDZjk6v9Tonv?=
 =?us-ascii?Q?AAqrk8EIIXwktm3GB3RZC8lhB8rzIY8Ko1qC7UjoJIh6awcbGOAGtZF+df9u?=
 =?us-ascii?Q?ZX5nYiEFAgzi0OxtZkUM2TCEhvGsuUnI+MqxBua3zesuxIRKSVJFtjk5f3mQ?=
 =?us-ascii?Q?qyvMmfas532DzOsdNpDoVLIKXMhmpEPFDrtoKtBVHm+1YIO8oB7rTJhoc2oO?=
 =?us-ascii?Q?ZzBHvKjJKFL+hu2nQe8JlgkVI8nJNrS6vmn2CZkHVN4j3dXuy6Ekv0Niynm+?=
 =?us-ascii?Q?1Rw63/b+YW8AsKl4Z0Y/yvXxgpWKUjCR2qlagMdeNkGCsmduJOALzDKuJl1T?=
 =?us-ascii?Q?OlezrITgXT4w9Hv1QXXLJb9/uHtrK3II5OV0K53ycKHLaV+uOibJc733pf60?=
 =?us-ascii?Q?YsIsLgqriQO/Q5ZbUWi+62Yv7M3hNxF0FECscpU9tpIsF9YToTyE47z+LLAK?=
 =?us-ascii?Q?vrNa+MTW76vHKmEOdbwqrxoFfcAmzck9zstDK/WdUga5fZhAYFtFoBE3vjQu?=
 =?us-ascii?Q?8zpqOtdLjHt/n8MGrHH+NijUTCyNWLCr70uoCgfjGKQUlq4w9Xf2ABfSp9h0?=
 =?us-ascii?Q?FRS/E/yziQl8G5W4daPkcWx8uC7h2a2zAtOjuRoj2hOOQaja2VTnvSB8ZIgY?=
 =?us-ascii?Q?z9BYIjrOjuKQNZQPjFP7v/jXcOCqCSt0P534S+EQPhAwe3FUHALVx3SeuQ3W?=
 =?us-ascii?Q?6RfML3L02b3Xe0BahcZ54DnnXxsslR0MACsHTXPOwBr5docdoj/yx5QQaJaD?=
 =?us-ascii?Q?yzm0ZJZc1IJx8jAiUUV7e9X2t1bwglsF1oFe/iRNk+87xv463b/8rZ4rYL8L?=
 =?us-ascii?Q?QswPvill2bXHSuM6jYamsWQM6EugEiugPCKp0OO/qC5gnV80X7Vdb9qV9WpN?=
 =?us-ascii?Q?Wi8hZtUCoqM/LmR0HxUMCllFcq5+tAiVbyVtmMX+cIb715ZMwYW0InctrOQ2?=
 =?us-ascii?Q?lwzLBowm5Jg79uEBnDiqn64k/Konk+sFFNnSK7RRqpdSIzHJXh0iAQ2buu14?=
 =?us-ascii?Q?M2FeWZes9ymQkPb1pHs82n3D1ipkyMWF6O6Mde4pxFjd8Nx+zWMDtrwnMdDR?=
 =?us-ascii?Q?43J+6XFsQbj35gGdvEjR4HNe87OloNJaAT64pA/oiccXjI4uC+wdeMDCcc7P?=
 =?us-ascii?Q?3FTDVxyO7FyLU5Ii4cJ5jAmEmIUrjgS+MDSVf7li07mTHcdIoHTB3az4+DnK?=
 =?us-ascii?Q?mnMvxYYMuPfWRpAYCRww3Vx506TsoWkCFvYOSGkurNK3EWUIcmzEHi3t5mAy?=
 =?us-ascii?Q?DftX5hyDQAQ6IP++0e8Sxt33FdQWnwma4E+f0rwMEIoGVvFKOeh7ysGYKiMg?=
 =?us-ascii?Q?kJ3OczqFw7SDzARwuYsUhmxy+hTjz/i/D6Uh1pxAmQrjEmCM8NiCiRdWQXK7?=
 =?us-ascii?Q?C86jlMphk4QkPj6SfsKaDQCaLGM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1ofmuFBje+QlE+Mr0qbvQ/Awab4TMmj0EA8W4QeTz9LwR9fdMWqhHisBnZjUSgSLRP2Txe5lXEC9QohCtT+uhRuGwTxjO/oqLF8eXIPwJS9NXaL6BodQVzOd7daKx1lI7xMsuiAuUicC4aJ+4ZvKANu6ghG+8s1FmW66Wok0/Xsd7mLPnS/jk+CyOfR3MMr8x178WrVqulyKuIpbQFs5fgpcSozOOY+DaZLIuEfwX6XnP5KUdCF8fW9/ZN87NKNHOPHwKwcf2BaM2ft/m4S2eFghHCQMWjyYz3KVNev7Blw8MM49c2H5O+Bu5agRT6+5LXci59qBObuovB40y6Ab6IPFz6OeM79j25QuNa+xSpkjARtDSdlxk8RKVxV30fP0sfpZZizytthfeo9kOX8XtpNyBDWTClitnmXWWFZRRNbQHp38OID46HNi0gCp+bDR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 06:59:44.0640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d343df9-c644-45ed-a998-08de743b74ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463

The NVIDIA Tegra264 UART relies on configuring the UART clock rate
directly to program the desired baud rate.

Introduce the set_uartclk_rate vendor flag. When set, the driver
uses clk_set_rate() to program the UART clock to the desired baud
rate and clk_round_rate() to determine the maximum supported baud
rate.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/tty/serial/amba-pl011.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 79e1c937a600..ad06dc4cdf6e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -115,6 +115,7 @@ struct vendor_data {
 	bool			always_enabled;
 	bool			fixed_options;
 	bool			skip_ibrd_fbrd;
+	bool			set_uartclk_rate;
 
 	unsigned int (*get_fifosize)(struct amba_device *dev);
 };
@@ -2096,6 +2097,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int lcr_h, old_cr;
 	unsigned long flags;
 	unsigned int baud, quot, clkdiv;
+	unsigned int max_baud;
 	unsigned int bits;
 
 	if (uap->vendor->oversampling)
@@ -2103,11 +2105,34 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		clkdiv = 16;
 
+	max_baud = port->uartclk / clkdiv;
+
+	if (uap->vendor->set_uartclk_rate) {
+		long max_clkrate = clk_round_rate(uap->clk, UINT_MAX);
+
+		/*
+		 * Clock is reprogrammable - determine max baud from the clock's
+		 * maximum rate, not the current uartclk.
+		 */
+		if (max_clkrate > 0)
+			max_baud = max_clkrate / clkdiv;
+	}
+
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0,
-				  port->uartclk / clkdiv);
+	baud = uart_get_baud_rate(port, termios, old, 0, max_baud);
+
+	if (uap->vendor->set_uartclk_rate) {
+		int err;
+
+		err = clk_set_rate(uap->clk, baud * clkdiv);
+		if (err) {
+			dev_err(port->dev, "Failed to set clock rate: %d\n", err);
+			return;
+		}
+	}
+
 #ifdef CONFIG_DMA_ENGINE
 	/*
 	 * Adjust RX DMA polling rate with baud rate if not specified.
-- 
2.43.0

