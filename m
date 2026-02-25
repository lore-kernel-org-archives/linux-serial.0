Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47583328630;
	Wed, 25 Feb 2026 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002787; cv=fail; b=CoBw8gch25XfHwuGWOv0wGlgoaPuk7Oll9nBv5CJSFEM+rz1q0Hu21GMvi8mwQr3ssXi/LxY3LxKHf+rIACnZDSpQOBYl+7lDtVRG9I/FS9JgXqJ9jJ4BecgDC2AbdhIjSCFNlsnb2+/FDa5K8kH+qomfQXD/4ByLc1VwtPowM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002787; c=relaxed/simple;
	bh=7kNiFc1IfJQdVdUC4YUBjdPywMS0qhi2nFmDJmSklW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnHdAmRdP2YQDydlax9AdO87lFWaVX3ua06ax8Nqwin6UeLebDjj6V9FYxHoDlxXFX1eoO4E73zoPmnkD/ZRJtkTcebNMAr4veWbJaqR+lfKa+6Un//Hm+yJaU4gSMw1WvJjAF1nEdhtKDj7l3EJ/80moRW2Wa6q4Zu/IWeeipY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=URfAo+e3; arc=fail smtp.client-ip=52.101.56.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="URfAo+e3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dELpgDxNx49TwCG3caaY2iuh0/aRORNsckj9Gii9DKkAxO+Evdjh3s/I6CbC7iFXmPcw+JlggKDQakwtprQoEw8Oaa1p1V7f7oPMiURp8J8KBMj687dy+geXWp6LGfqBbllbe7SsUu43T/rU6hPYy+Ym7gU/BtxdBfj4Qk89HXBHXnJjfq8zW5tz/KGzZMaIgdfGUKRfrXKY5S9IT+LNKyTZ0viQohgp5bnFph6Ev0kr6hytOJM9bE7MUuCHTyc16jVRifT32TNTEhHpksqZP8iXLEcvLH+0omW2HicPrY22Jf6xZLxxAVGta41V6pdTLay2E/o0K6U/MkDNQnQAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiLOcEkJAS09bY4JE1MKiyOlVyzwW2ROkQ2PnFqdfpA=;
 b=fRjF1TbCACXqKxzhBOKkIvcC/I/pbxxKPl4G8bYRifE05+Ja2SaM1V7R2GGubK0HBMp8XBi7lIcnqMzIk/2F5LQ6oQ1mF3bXPV4DIzQvguQsbspAsgJtPdWFUpk4AXO+0Xu+UoBXQP5UPEN4Mm7o3nayBN+ErsLNHba0YQTFKakyOM3s/TJC9ZMdW1h78Rc+YYak031sy5A7zds9ELu1aGw2N9Bf1yAAB1FJH1S+HEIRUNPwz6C5G+nZhexK7QlRFr9K8DC4VDHV3sCUHDyHuv+bvt7ji5/Ln3DEt+U9LZKCjk0quXT0FvauXnWqdsgEaaUl/x+QfioAW/XbvWrZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiLOcEkJAS09bY4JE1MKiyOlVyzwW2ROkQ2PnFqdfpA=;
 b=URfAo+e3DHgQhDpIIa7HO2hgk4YYmUzHsdyMddthHNbH28BDPPjwL6nx6yEF2fAm9yyOYt9uh0InOia9fYZwLSm20msh90Zc94g43/ykyM42/+ZT1DzVhYClylQ5kZobKOWiZptPc/W7BpYfU4WVmqQfkLL4Uup6lOg/MQeZRcPv/yB3dJxoozVHojmAwBPe+JpQ/DI5WkW+BRnAy8iSbDvZzf1Eu59X0FHmJAzhbxxTZtgS56Evqz9Bh5X/XyRSk+NifJ1xMu+0b1RQ+t3fURpIc1eEGhGxJ1abY6/zBlzdCq7a/2Y8ZAWkjs4hVuLvl8SV82xKyQKRDXkmpk4w5Q==
Received: from CH2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:610:51::38)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 06:59:39 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::1b) by CH2PR15CA0028.outlook.office365.com
 (2603:10b6:610:51::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend
 Transport; Wed, 25 Feb 2026 06:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 06:59:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 22:59:25 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 22:59:25 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 22:59:21 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <linux@armlinux.org.uk>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <mingo@kernel.org>, <tglx@kernel.org>,
	<linmq006@gmail.com>, <arnd@arndb.de>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>
Subject: [PATCH 1/4] serial: amba-pl011: Introduce skip_ibrd_fbrd vendor flag
Date: Wed, 25 Feb 2026 12:29:11 +0530
Message-ID: <20260225065915.341522-2-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cb81f8-c4b7-48e2-72d5-08de743b7142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dvt3O28EHbj8tZwvqBrvfldNSBHPei3Pvnu2AAgdjbzcyWBrycoDVcMEMtr6?=
 =?us-ascii?Q?7A+NAIzB69Y9HvFwZmXhFMojNsa9ZHqQpPZYVL2Bi9G7QHQkRajmVqT+dwZv?=
 =?us-ascii?Q?mTZq/NZtWslf2Eih/uIS3bCYZpp8EEEeDshRYhxw9s/111DsSL11FRZl+wsM?=
 =?us-ascii?Q?osde1DzFcsxEF82Q2qeVSLNXHS6b+xstLti1zs9kxDERAlA/nQigsY50sTJX?=
 =?us-ascii?Q?uJtQHvJpjF+y8P09veHOK6zTnpF7tg0FgXdxpX75+2pdRm201N486ua2HZIY?=
 =?us-ascii?Q?JxPG3oqs0yseGcww1HbO6xnQiRl3JZruI1uPogOV2pc+L7IGmBxTdsNuy6G2?=
 =?us-ascii?Q?Z4dKI6Kqmeid9uUIDfD5XFvXkVLp4sUAkAWkAgGPspR1unEFmbIf2zU5GN4Y?=
 =?us-ascii?Q?C/0WgHLzUnkp0Kzs/pcgxTsRjrY8U5WkNAT8f1Sko4uCCSBLvPJE1qLr7HHA?=
 =?us-ascii?Q?vXpfMx/jKtpVzJmCMONjkFSng+F4vLNNooFv7q6Muve1ielR3TP6Cr2QZdk3?=
 =?us-ascii?Q?QGoxV9rmI4/iYrQvP5l11uym6nWXYBc2rv8jC4PD0OixaXPvKRkWLuPDYv4c?=
 =?us-ascii?Q?vN1Nv506wxRoeEN8I2O2IkTHIp6KWr/707uXggq1nXIvQVMHB6SOcIEUL2ar?=
 =?us-ascii?Q?upMCn6GfcFbBkzPMOOSH9Nvd3+D15K8COv51XJc5mrZze0LW5qY29DgoHBOz?=
 =?us-ascii?Q?kVp/ceP8oRfCc5Nkfu4BgrXu4cBPdeKykMoXLFwuG0/GM1cvLeSh6nrWHWAR?=
 =?us-ascii?Q?AOrjxq1c+sOG2V+LF000L4YSUaDqmc01JjJSbhEynUTje3V4NRiLstzrPkIs?=
 =?us-ascii?Q?KsClfG/gvuRSMZOJiKvyu5KBnR3eisfdTP8UlA9R6MPEHDx45aoVfLvcsYHL?=
 =?us-ascii?Q?UM+PPkcEPz/BKj5VhBwIve4dXCnrVEMxiQEztGJss3CV+PMHW3C9G5NctbIx?=
 =?us-ascii?Q?kf4XpkWkKgzCoGBIulHr8P3dSodKNIq25h9hm7ehgTBitqwRKQ76gaY7KIeJ?=
 =?us-ascii?Q?l18jJEVcVm0AvGcfM/2pRbjxSGePmxYa8TkmwscY6e+dFA9zncI+o4G12+pc?=
 =?us-ascii?Q?FKVEHvwSfu77eZjqL32NRI55derdCuLiMbq8m5edKQ1srR6Ud/+90RzZrZ31?=
 =?us-ascii?Q?lMFhcIdGF2C9+2vyZiqa5m5mqBc9GhLyieso0Me1c1o7EDlwSzujqI3AF637?=
 =?us-ascii?Q?C7SBfYBzruiMngpmNbBtLNB1LlUbI0UfRWr7eeKM6GzHoNbdfCZz0J5mNiPm?=
 =?us-ascii?Q?4MHy5Nvi1MTQ6zR8Rw1p7UEktECk1Z8gZxZdUmimxk2K9h+HrFSAq0B1Q/Nq?=
 =?us-ascii?Q?XxFi0WZGoR0zLMuTM87toiR9Dajg6wvqGzKCIIO1J/oSaVmJotibGsKUd845?=
 =?us-ascii?Q?PcWjtk3W8gHk7DgUlJtxRoZzD288QyKK/ma42fDseG+y09uHTsi5E/b8JyOe?=
 =?us-ascii?Q?ir5nk944v4lX293RBdFWscBdoKR/RdfOiQxmHUDu6kj3aw5WiqNyHP7+J8RE?=
 =?us-ascii?Q?dMOWkJD9o6PTafH0JZB/Ksmy5u/r9ZCmYF85a2bjKzKxkU1RsN9KNXnXLUWv?=
 =?us-ascii?Q?pY97lWixPAV2i3QuuEZMGYQYgyO0vNxpCAEixdZMMWyb1MCE525MC9IoDXgk?=
 =?us-ascii?Q?Udjkv1EVHdjahqvTlD9Og3aZwhpzJnpjbvDmZcG2HhpYwcaivo7etLeArve7?=
 =?us-ascii?Q?up8XYQ+ENIhuA+T67mu6yfrcALQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AqUEteG825520uuJ7Ts2fTqAyusL5p9udmdrnldoHcBLLsnB4KapvlFsPmITmEQ3ah9JAD687pCp4FoX63eFI/0p5XahKmfrv0y31JcDqO+59mCJrIRAYpNAczP4NsZBBaPT0f7HbJtbymBgZa7s4iTk283DA/JykpjAOQ/mvxWVPn52NcM78rADBuCHUQddOxGbRFW51UsKUEG+Nw/NaadtNcjZHrpQmx7IRqgjlLVUgKPGhgHKTPrt2h7+z1gQQM3X88y8WViNcBELKGFVxyHFKeyG7FLGsIxrVURzAteYAkBzWkYyOG5GM7xaw/RISLLcLzsRmsWUxxHhmPlXMLQ58hUTPYwgIyEF2SNHmSkI9o1F28ujJiGCtpasRC9r55s8eefaj2KWx5SMKIcuwjKeho753k1y/LO55d6tEflBexjPzbZWzvpBUfVuZ7Yl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 06:59:38.3575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cb81f8-c4b7-48e2-72d5-08de743b7142
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301

The NVIDIA Tegra264 UART has a broken fractional baud rate
divisor register. Using IBRD and FBRD may cause the baud rate
to fall outside the required tolerance.

Introduce the skip_ibrd_fbrd vendor flag to skip IBRD/FBRD
programming. When set, the baud rate is derived directly from the
UART clock rate using a fixed divisor.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/tty/serial/amba-pl011.c | 53 +++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7f17d288c807..79e1c937a600 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -114,6 +114,7 @@ struct vendor_data {
 	bool			cts_event_workaround;
 	bool			always_enabled;
 	bool			fixed_options;
+	bool			skip_ibrd_fbrd;
 
 	unsigned int (*get_fifosize)(struct amba_device *dev);
 };
@@ -2115,11 +2116,6 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		uap->dmarx.poll_rate = DIV_ROUND_UP(10000000, baud);
 #endif
 
-	if (baud > port->uartclk / 16)
-		quot = DIV_ROUND_CLOSEST(port->uartclk * 8, baud);
-	else
-		quot = DIV_ROUND_CLOSEST(port->uartclk * 4, baud);
-
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
 		lcr_h = UART01x_LCRH_WLEN_5;
@@ -2190,21 +2186,28 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 			old_cr &= ~ST_UART011_CR_OVSFACT;
 	}
 
-	/*
-	 * Workaround for the ST Micro oversampling variants to
-	 * increase the bitrate slightly, by lowering the divisor,
-	 * to avoid delayed sampling of start bit at high speeds,
-	 * else we see data corruption.
-	 */
-	if (uap->vendor->oversampling) {
-		if (baud >= 3000000 && baud < 3250000 && quot > 1)
-			quot -= 1;
-		else if (baud > 3250000 && quot > 2)
-			quot -= 2;
+	if (!uap->vendor->skip_ibrd_fbrd) {
+		if (baud > port->uartclk / 16)
+			quot = DIV_ROUND_CLOSEST(port->uartclk * 8, baud);
+		else
+			quot = DIV_ROUND_CLOSEST(port->uartclk * 4, baud);
+
+		/*
+		 * Workaround for the ST Micro oversampling variants to
+		 * increase the bitrate slightly, by lowering the divisor,
+		 * to avoid delayed sampling of start bit at high speeds,
+		 * else we see data corruption.
+		 */
+		if (uap->vendor->oversampling) {
+			if (baud >= 3000000 && baud < 3250000 && quot > 1)
+				quot -= 1;
+			else if (baud > 3250000 && quot > 2)
+				quot -= 2;
+		}
+		/* Set baud rate */
+		pl011_write(quot & 0x3f, uap, REG_FBRD);
+		pl011_write(quot >> 6, uap, REG_IBRD);
 	}
-	/* Set baud rate */
-	pl011_write(quot & 0x3f, uap, REG_FBRD);
-	pl011_write(quot >> 6, uap, REG_IBRD);
 
 	/*
 	 * ----------v----------v----------v----------v-----
@@ -2374,6 +2377,7 @@ static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 				      int *parity, int *bits)
 {
 	unsigned int lcr_h, ibrd, fbrd;
+	unsigned int clkdiv;
 
 	if (!(pl011_read(uap, REG_CR) & UART01x_CR_UARTEN))
 		return;
@@ -2393,10 +2397,15 @@ static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 	else
 		*bits = 8;
 
-	ibrd = pl011_read(uap, REG_IBRD);
-	fbrd = pl011_read(uap, REG_FBRD);
+	if (uap->vendor->skip_ibrd_fbrd) {
+		clkdiv = 64;
+	} else {
+		ibrd = pl011_read(uap, REG_IBRD);
+		fbrd = pl011_read(uap, REG_FBRD);
+		clkdiv = 64 * ibrd + fbrd;
+	}
 
-	*baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
+	*baud = uap->port.uartclk * 4 / clkdiv;
 
 	if (uap->vendor->oversampling &&
 	    (pl011_read(uap, REG_CR) & ST_UART011_CR_OVSFACT))
-- 
2.43.0

