Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D7482EB;
	Wed, 13 Nov 2024 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731474647; cv=fail; b=kseacUUGeUQc29Vwowa7Vy8k+ol1O0exbIVr5wFP03I5M6uMfajuaoyVb7gMxK1KmtrZWin6WtQBZvUV+XWMKN3KmepfxVAwbNSa66SnKYiyia4J6abgNT9B/nt014DfWPY/vVIijOd6dRDd6iw00c8VKhyN4t95rEOPL/nrIPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731474647; c=relaxed/simple;
	bh=tUGnh56jpqet9OFzaX3gQqFzM4NH+E1o+8DS4ffHjtA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BS7laj43jzTkXN/wHcYISUdM+BZ/YePRFR9mvyj1EPs+aHMq4LKQ1JswsRJrj1acf5Wz7Yc00BVmyLY0iaI+GgCycVrQM4Ryw50OhwaNEugvabn6u4ioT24DMjSWuPcXxghZSPxU0beb3AatE8ejWkc0j/Iz10u4hc0qazq4tGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eGy+59dP; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eGy+59dP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/Mf82fdsu8ooAjnSd8jmQiYImVNZCvitFws+To507LwrssCznOvMqMK9lU05yiA7zDpdF7am/3ihIfy/+3uT9BpIiR6/CqIHDaH0noWCMbHkAuoM3KM4f+OaCEufeJKJJI9llVNa5/fix1Ix76d0Z/fbLKLh9LIgf7TzBsGmAQQncGXlyyjDfi+1gMrnDl9BAsYjCnx4Z7RU0OOlATAspusO8FKOkALYDuzKAv7QsAKONDIcj0eH5gJn2z34ZbjnnnkXaazzKO4zhppodsxPHcSbm3Fx9jQiZYe1Gw3qJa7KuvvRu2aGrB0Nl8Hk+MuDtaY1j1sNXc0lVcLA23V+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIb3az+o9K58hY06UVaLBjveahO587DIz7OTARaQ014=;
 b=OokmLW2FqTh4DuK2CCtqijFg2+QC5O30eZDHiw1lYpNMNC0uvxm1sgvH8Yjw3Uk58XZJOIlljd3W/O3t8ZTP4j3CvBkCGMuQ9YKcbxmZOQPWfoS0dLN1V9Rs3JXvMBF4PaKqXI0qx096eD+c8+e3U/DGxiowp35livoYUSTLfV2bQr6Qq4vxgRb33D2X7+NhjqLazlcdx+Z5KJRkPe8QXLbJOyVV03Zr89tPT55FJuaBwcnEXc5sHfnTHI43+mxuregGK7jw32k4QPdT47PT+Ebhl44WYW4QRPeJ/vGrWikpKm4G0T++CQED3+eRH0RU0LQU+j4q5vFXnDzw+wlbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIb3az+o9K58hY06UVaLBjveahO587DIz7OTARaQ014=;
 b=eGy+59dPfsdbx98w4/G2GJDoogwewf1mmRGVd1KL7AKxmQ86ObmllqFA98BxKOyk0dwpeZpv+VgjI3RcmrOY5hWcNkG2KuW5NmZlkS2mia2bd1spA4CL/+Qzr/jVXAl4IcMBUTBT+EMX6u/UzdEu6hFHvpsGMH6LBaI3vI3hOqmQeP6qBFmzYCIWOlKzYVrbPk+wU5YWjpztVKjep10tl0m6/vfOy3pPP8NoW7tGZU8q9sbIwk85u4sp/0h1X+FmfR2t/LETa8+9uYSLTXCat1rDhutAYARk6VM4LIpEkwtWMj33xq9HCayEmzPUAUpCrRF6NtpLAdyyeXu1x7fPzw==
Received: from BY3PR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:39b::33)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 05:10:42 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::a2) by BY3PR05CA0058.outlook.office365.com
 (2603:10b6:a03:39b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 05:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 05:10:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 21:10:31 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 21:10:30 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 21:10:27 -0800
From: Kartik <kkartik@nvidia.com>
To: <linux@armlinux.org.uk>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <theo.lebrun@bootlin.com>,
	<linus.walleij@linaro.org>, <ilpo.jarvinen@linux.intel.com>,
	<l.sanfilippo@kunbus.com>, <konradybcio@kernel.org>,
	<christophe.jaillet@wanadoo.fr>, <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH] serial: amba-pl011: Fix RX stall when DMA is used
Date: Wed, 13 Nov 2024 10:40:23 +0530
Message-ID: <20241113051023.3125-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d65215-ec01-4443-0fa7-08dd03a184ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wAF3yL+2LnzuSEIByLqaLTZ6oVBGvzKuUDlgSATMqONTjlHkzzYo/K/UJld1?=
 =?us-ascii?Q?hqFVnosdPVl2Tw8UFmCqHv1ru/3gLdr2cNDz7knkdgwM4YSQNqEYWyFmzmnB?=
 =?us-ascii?Q?SL/X9M/+QQr/4c13cScPtCU+HCgwxXr6eJFo6RHG4WiZfswalmRdVKVhxPUU?=
 =?us-ascii?Q?tNcMzpEG5TCM0zaas/52omLq0nUrIEKBdUlTpnoUZSyL/woRBhaxa14SVx+E?=
 =?us-ascii?Q?STMD5jK1fg3h5tQ4xlp7pkhemUOMMEz7URvdNnuEg7N4fy6kaYz10rZL0g5D?=
 =?us-ascii?Q?e00adBtL410tkyEYYXQsSrM8+pHDMeln61Pez2p/1Bb1WAeMaTV8g53XDEMu?=
 =?us-ascii?Q?4rBmdcrc5ID8LV7gScVg5yr9VgX68muVychc/ISSxHOsdccTQvwwycF/luB6?=
 =?us-ascii?Q?MzUKh9FGvGtJDqynkWVZjvUNyTds2TbtBOjsLb21+Ht12+Xg7QagdSpZseYa?=
 =?us-ascii?Q?GSgF2Db0XCxFToSXBpWFuSOYkBz1Nmk16qF+wPpmtfS8cZ9cv4jCu2eJNHQF?=
 =?us-ascii?Q?q452ULgzX9J+dMuS6AVmcQ0pH11ASPCa48lluo7Hj++cu3dxDOXp1X3VIpZp?=
 =?us-ascii?Q?OL30tkFwuu8jbZJYF8i+AlL4UQ7LkUOuVuNnkPwkeV6vgB4QiFkRMQFE3aoB?=
 =?us-ascii?Q?0nHFoUvd+F6SOz3gdi0GaRxVxKFSIFk38resnZDKhSpwojSJefq5rkVuh7/T?=
 =?us-ascii?Q?zMUj9Ni0Im8sHenPsdGh0T6i3c5i6Uyd3kcYnpeD4HtrPh2WaPELR/W/4IEr?=
 =?us-ascii?Q?JMBzmFaQrX+iiu3ycCy1JM9Qpd2M4ng/kp67Lxe6akPv5y50Ju4+JzTKwby9?=
 =?us-ascii?Q?ZwvahR/4B1eAMNdxyv89EYOMcoUb6tNjd6kevNjD5FbH0XUxV1GStYSoM5dj?=
 =?us-ascii?Q?BulgFmTMKmF8x71DgkIXQ3SE6z/0tECarMV/IU9jTSvjIrxySFC3iLo7kVFR?=
 =?us-ascii?Q?F4HtCzwG59Uo+Pgv6exsZuJi800xtlnRtu5FP5WnKAF2m0QT8xASE3ghC3Yg?=
 =?us-ascii?Q?2VAMnxevFJv9UNdckrCPGQNUCBxvFiveyFRyvbnSSry1y5BCmETvbaQQHD4z?=
 =?us-ascii?Q?dKQtrYXKyeQO3Uk3lBVfpAB1q4Q+IQ1iuFQdOezZglJhAT3TwqTeesxeYso9?=
 =?us-ascii?Q?X3PP+/HfOkjlFzmBnBea8yn9Kw993UwM4on626o1t/ZpECD0zuFDyC/g+akk?=
 =?us-ascii?Q?Xn4zAKp6FjpNtDpMCRvROY+emEke7pSMea7JoyzxVsNZiRw3YwinzXTAcOpb?=
 =?us-ascii?Q?VR3Qr+RKmeUQ2EAxs2gDX74DI7dZ356hQGjeVHRvoycIT7LDAJTGrIakw5Kb?=
 =?us-ascii?Q?lGcdagf8Hg4NHLv7u8nGeCgPceT+4MqzQuKT10VrTvmfOFFnPdQBzTHQJCTN?=
 =?us-ascii?Q?6jz47nMLQENkUvmxHYUCAD2oW0k/WCXaUAQAcoIP6ERnqEJia3KjNIzSR6lN?=
 =?us-ascii?Q?uiWQvbeqiQM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 05:10:41.0418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d65215-ec01-4443-0fa7-08dd03a184ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231

Function pl011_throttle_rx() calls pl011_stop_rx() to disable RX, which
also disables the RX DMA by clearing the RXDMAE bit of the DMACR
register. However, to properly unthrottle RX when DMA is used, the
function pl011_unthrottle_rx() is expected to set the RXDMAE bit of
the DMACR register, which it currently lacks. This causes RX to stall
after the throttle API is called.

Set RXDMAE bit in the DMACR register while unthrottling RX if RX DMA is
used.

Fixes: 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle")
Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/tty/serial/amba-pl011.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4c4b0d470c65..f40714685166 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1819,6 +1819,11 @@ static void pl011_unthrottle_rx(struct uart_port *port)
 
 	pl011_write(uap->im, uap, REG_IMSC);
 
+	if (uap->using_rx_dma) {
+		uap->dmacr |= UART011_RXDMAE;
+		pl011_write(uap->dmacr, uap, REG_DMACR);
+	}
+
 	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
-- 
2.47.0

