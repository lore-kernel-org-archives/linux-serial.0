Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7C31355C;
	Wed, 25 Feb 2026 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002800; cv=fail; b=ZzuRuYinMXLK5l0JTnwfzeUwrqPhZJvbQGHm8p2aM1MEcj5jplB5w1LSDvq3ukfjIUvHVDbfOcVSMAQXYCo6eg8uXYdYTskd+G5+nu64VIRyNAvTjZGlM8iFIAFlo1LSgeoCB4uX2ae69JPwWnlAX72kNwUTJjt1m9MEy0BWkNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002800; c=relaxed/simple;
	bh=WzHGw1+dIPBsvOfSmmuSca7FgObqq3pSuigSDIouYMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJU2jcrHeFBvIlYOLtt8rUanNfbGVgcz9whd3L4XQRaX6jfaXiJ7UcA8Zoa2JVvlbOI5Mv6ofIl4VF8EBU71vbwP3i2IHFraq6qlnDbgzFq/rF9mnxMz2DzAT4T/AL1dd67AIRJ+2z/RBNGgGi1Va3CQx+u3wwdZAde2604wlf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DEJNDJ1s; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DEJNDJ1s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh+PfcalmSGA35uZRa0s4s1XyUJK4T8nWJ0TxVWZ4+xMldP6jmJaWvD4xGSyQKBRgQlU/zoRrP6tLs42WsrMIiULzI9SDytHjFRG4BS3738NxCQXInaFGVfztWbiQD/50ecW2IUNvnhsB23aWUL80WJ8sYf4rw0ZKw3xL5/ZJSjBwdMyIzzyh5nMgpRM4X3Pq9iqfnLJaK62/NW9JE2BAk7OaJNPDv09W4rqF8+LRPVs33/s6su35sd7pfjsW5iOMTcy9/fAvut5eB3tJ2/HqypVhezMX9UDLT3rXBajSQjoNIEKIPtJmCIrjqzZad9eIV8+HSJ8Nrx6VkiW8NmzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOg9DxJ7dor6JKOnQ5yd8wcHPq2IfvqtGh3hi9zPsSg=;
 b=hcYxoc8aGU6x4buqHwx4ZuWeMoLQeIjbpqc5/7BpA8+XGx4iHAdYF6ipQuJr4expfn4hbWVuzHTB/CyLXmldEJhPQ+yqNnjxWlFXBx/wF44LTwLX67rP6lpZ4XS7EgX3qKTfXaqfJ31h/drJgRS/lGZf/RbHqghTwGl3yJduQ7aVPiIWgGed9dikLGNd8OkWFXSXhg0m6IyzsnvYaiybeYsvku/SPZ2RiMX5s+bxQ3zxDjzaL+J/WIXegzRt1MDCAewL+8/gaeZicVOCZdY3WPvCK74O7/E1fdm4wUCQ2Iv1EGkgOhKXX3ZOuy1JLkosokIL6fIqaLAjHb4shRVnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOg9DxJ7dor6JKOnQ5yd8wcHPq2IfvqtGh3hi9zPsSg=;
 b=DEJNDJ1sEnQc8TaqCda5XASbxwWZGZHsWrA2nNJ8tC8m9pDWBHzopzwjGfN0OCnoRF/pztqYwfD5Q6Gi2ofq9Cnn9SDPcIm4K9rPYRxttkbKacF5EA0AkcltJLuu/cJsUM51grNF2ZtmIbfn5OfZdHfCvMd6jg7oTjcWt5t0vEhS5UMu0XrQyhPCdaAvx13U+btpzd4+L1ktLQGy+i/n+uowamtnZDolGkKUBIkO3knJ4cLz7sg9TVZ8+V6OwFSgYm+NRxis0q2JZUKut2vmgQRyylLsYlGTGv3Jou9dMi/gcxw1vVlK/G9W3oA3leum7anePI3mtLZErsm1L/wEYg==
Received: from BL1PR13CA0325.namprd13.prod.outlook.com (2603:10b6:208:2c1::30)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 06:59:55 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::3d) by BL1PR13CA0325.outlook.office365.com
 (2603:10b6:208:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Wed,
 25 Feb 2026 06:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 06:59:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 22:59:37 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 22:59:37 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 22:59:34 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <linux@armlinux.org.uk>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <mingo@kernel.org>, <tglx@kernel.org>,
	<linmq006@gmail.com>, <arnd@arndb.de>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>
Subject: [PATCH 4/4] serial: amba-pl011: Respect DMA controller's copy_align requirement
Date: Wed, 25 Feb 2026 12:29:14 +0530
Message-ID: <20260225065915.341522-5-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4585f3-1ffd-436d-9f4a-08de743b7b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3fI8H/Z6dyZILrdQOvhaiPgp6DcMLKexcHl18p+PFFCph6J8JghNwTlTyL/p?=
 =?us-ascii?Q?vnaq7cZNp51vgPPVwCgd2nUwDHOpltON6g857kp1kuJWc+kNVJjyMYsqvnFV?=
 =?us-ascii?Q?749AC/jJ3SWEIYUPSoCeFlvvqbe/49FiXJRh9eGbMKS+Fn20pahkEUwA2fOd?=
 =?us-ascii?Q?qHYccPYnMWSy6BwM0MpSOEtXfT/HbXyedaqnedIWPIHz9l0/EpddPWSXpZIa?=
 =?us-ascii?Q?fEijX72GYls47CYGCLUpOqw4ZscsRhb41U9MThoFuXBwSPgOhGeupRBlGdIb?=
 =?us-ascii?Q?ESC3271W4UWQANt1Hwj1KD3B5O114oZDmsWqAz+G/fi/Q5NY11teLNR+9/a5?=
 =?us-ascii?Q?AJc2pufBA8FdcBsQ3/VWS5RZl2xZM6vhcE6UeSo03LR5rKLRWSIXN8O4VmUF?=
 =?us-ascii?Q?Z7xaWlU0K4jVB6pyM7RQzCOrAxlUTH5RbjNF7RRYqleD+u/ImVzYmGNAZVKS?=
 =?us-ascii?Q?Rq79xko0qn6kuBSoMUcDvMxZ0/4XyJR4CGlrKwmCS2XuFOLnOzucQKcuaWEX?=
 =?us-ascii?Q?aowM5Ii9nLjBI0wtvweh0WrXd5SrAJtjNu5lXvS2BOLOrVp8kgHK5jcpdRUk?=
 =?us-ascii?Q?fM39/ofLTEJ+XIvvkP1SJpIxpvlkjDzZDSwGDkpV/IrgJ8F3ofAi4VL4qmNN?=
 =?us-ascii?Q?cIhSj88Pn/onoUr4W0IicCS2AeeFJ4HJLaBzXjHTEbt6ds7AteH7jLQcZq9T?=
 =?us-ascii?Q?LpogCNfWBHy275ac7A1W9Fu5V6pMJdYV+5GvILNronMq1lMwHzxHgpwHw//O?=
 =?us-ascii?Q?OrF7/qw5UlMrrnCMl2vRGzgNTdVHalHNYn1JQKwUrfdUGqE9RpSjIihzbTns?=
 =?us-ascii?Q?mURLORFTWUSGCi96F0WxRQORBtqNr/x/8l1VmHpsnvVNbEsYaLMb2aAFq/43?=
 =?us-ascii?Q?z77Sj9StwsIPspR8R3pCxMEp4m814WqPRQ7dlDJws1jM0s/0J9BSnJD0HIe8?=
 =?us-ascii?Q?vDkHhmWAqtoPdsHsnIX09vHYQ+uTzizUD5tPG0vfjfS4pvkbu1KOqr+ZzAYl?=
 =?us-ascii?Q?qXVEwL2G4BuTWjothH1CGObF4Qr7hjhPkkOIXvVOP0LI+L63Q48NUQkoA0iS?=
 =?us-ascii?Q?APFT59mvr8hmkN8A3x1tSnT7jktVKbS2+6X1U5spccDjV6sX/BjO9GLQ1sqo?=
 =?us-ascii?Q?AkYhO9FH7uRnOOd8YX2Mgz8jyCqwX6hqzjd/U5/rrbUOBpJR4cLFa6GqqkEz?=
 =?us-ascii?Q?gYusJb9UyGFAMY5+cHrxgETvAhur/lWgeNMpjuXF/2n3pHcG1nd1ALL6IxRO?=
 =?us-ascii?Q?xy3AMuDfaqRwGRqqHlfIW25lfbXzcF30oVl009lp7rGaLPAiaCbrSaP0gdxC?=
 =?us-ascii?Q?JHQsdl0dQPuWkI+fyvQjiFEL6TEIWjwb/DNzZhU9yzi6eYWYqphaZhaVrCxr?=
 =?us-ascii?Q?Et6nWEVPwI9SSe9e0vNvWfM7CK4QCshXguKTJcJF624trqU+fqNXTj7HG1Jv?=
 =?us-ascii?Q?YZ5N/GTfPeqG4DOPD9VgAAwry7G+HkRQSk7hmOVpGEPqq8OXbrKqb4CQFp1z?=
 =?us-ascii?Q?JODJfLmbqsXlSHLgh5CutcbcXtApdWK+EIC40MEd0U4a3todjHYNRcASioF0?=
 =?us-ascii?Q?UgJM5z2Hcunumw/tDRAGGOtpFLY7XeYL50sA8YyH622ExrDjqxFC8q123CTB?=
 =?us-ascii?Q?dI2ykPZYZYoMhqr6QSnwfg7ZZI+b2akMHrWEMRQzQ+WLcpLvBOgAVgYQcFXB?=
 =?us-ascii?Q?1Vsk+A9oLW7rmmVMBXFJ/a8IfKg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ruha4Sx5htcAKqFamQ9rgOlnyg9tXjeovfrUe+V2pLProALTy328nAdrJ9WEBYmhqV1TYUje+8c9wJrgJgjJJXMGggVYpGRgYmlyfmJCOw3Lh5fWUpI6cey4duEucI0eiXR7zlsUolF1O7XR4LzcdXZXUv9kmVjTApqUb2aEf5TkF2Suo0B3qtosEwoDp/M2IrpfWS43oCuk3FKD02Q7c9FrWyAD+0CwoxGyI8ocl/0vq8QSjmT6zHFgZkLcWFK0rGA/4SB3ErAYkJpW3RoEyz6W92YoPmqvsYAGTR2iGofSBQsW4vlE9Nt2bmyFGZnzG67LrlhMQtdelwIBGnaaVhWvqicQ96NYaUfTmB/0JvzVfQoNj8o3JcyCtJNmjksLslQNQilg48ABTJXILzVxCfqX4PjgFXaboF9LgfidBKmD+tg/25FL2lrh26IEPSLg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 06:59:55.0544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4585f3-1ffd-436d-9f4a-08de743b7b3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

Some DMA controllers require transfer lengths to be aligned to a
specific boundary. For example, the Tegra GPC DMA requires 4-byte
(word) aligned transfers and will reject unaligned lengths.

Align the TX DMA buffer length down to the DMA controller's copy_align
boundary before submitting the transfer. Any remaining unaligned bytes
will be transmitted via PIO on subsequent calls, which is the existing
fallback behavior when DMA is not used.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/tty/serial/amba-pl011.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7f8deb30650a..98e434b0c30a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -649,6 +649,15 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 		count = PL011_DMA_BUFFER_SIZE;
 
 	count = kfifo_out_peek(&tport->xmit_fifo, dmatx->buf, count);
+
+	/*
+	 * Align the TX buffer length to the DMA controller's copy_align
+	 * requirements. Some DMA controllers (e.g., Tegra GPC DMA) require
+	 * word-aligned transfers. Unaligned bytes will be sent via PIO.
+	 */
+	if (chan->device->copy_align)
+		count = ALIGN_DOWN(count, 1 << chan->device->copy_align);
+
 	dmatx->len = count;
 	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
 				    DMA_TO_DEVICE);
-- 
2.43.0

