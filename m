Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D51CB534;
	Wed, 13 Nov 2024 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490020; cv=fail; b=g74UxGppeCxFe9I+VtCK97bWWe5JbwTSpcZsYNRhAbpmoTL1NujUWf9kHtlvUOk6bOdI4/drvpn4Gb/EYjwqoFxV/htBhaxSPTTLcldDPmoBfSMReMoILin+xsyIGU/JQzF4y+lUYLxnBlX2Wz+/E8aHf2uiEBQMbJ3sOgIzqHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490020; c=relaxed/simple;
	bh=UWovm8MTa3Icv9fZBJzbAOm3Xas1okqLjfqEHDeWcdM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e/iMsgUrC2arrRK0fisMHEPDBH7DcSHJ4cWWnQyncKwaQMQCJ2jPgYuFYDL8LlIPHiad5ancwQLs1GRNR1e8GN7VnPwzGrRteMsRGZXPKqXEg70kWNvAnxOCknL5sqBcRcS8yf6nZ+r08+e9/zndAbx5ki3+e8Bw+AO7ElAZkaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QvTlfIj/; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QvTlfIj/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2dpgkESxsHhFl0Z53AYtx95rT2Uy+cwHdJ3aVewaJQtHTtyI+1CFO5FdoeljTrbQZR63zsZMJgNvZ/0Q377HFc1eQpWgzPIEJbPu1LgOniIVB791oV4YLiDGF+Fu/KougviBdyq7SnNDmomkwZIgJxaxs39IbRDMNeTWMqym3PgX7PB6s50yKsyNXL5RfWBSjfXy7izGLzdDoK6b7KEpb6VEiHr+h6yzePpbwcGex/ZDwH3MbfR4TMRmiRdq7mvzzy1DJMR/GKJOrRUtgJ5UJFsWTd1P4Cf+QtCFE/D0GlXy379FAAWWk0iBRTQ8YPWXR6RpYoxijEOQXNGLduD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZflyRqzrf2jh2qK2DB+guddZbSQpr4xUIAd/BCGlr+8=;
 b=WeRFKzLTPxl8Fzq7s5qqBs1Zt3MBZddOx4SVmxm65WbfxGwLMF0zyBZ2fE5kEf1Ynf1qSVVv3cYdBHSnm1JwkCzSgRgJHixFBd6NNbH9IakVd0nOm94W0J3q/Z70t58OzpegMouwuZKZf2uUiYGRxGIcLewC2KAn3pvIpIDHQ+3QY1Aut1qz4CrPr8QKUeQ+02TqOvOicIfUA+mdpe4gvrbQwt5R/Giw5jiEqjw5cMMpGS6udELVRl91f3QZfs+29u3tY5HZuPGB4Aa/AtYDvtvbDNf3NBIe38MbGrrHQmLnHhEcOf+VOM/lT2gx9+AfoW+L//CW7E619OWw1/kcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZflyRqzrf2jh2qK2DB+guddZbSQpr4xUIAd/BCGlr+8=;
 b=QvTlfIj/8H5U7Vz8uYurKgePVIFuI32O/Frz9f9BxQj7jXbznkkgC2xxlJ/Zem3to8hTkbJi2cAZS3Y6tjAkpEZVn8YXlrbMpnlKSu9NGUnpIEAWGyHIKn/RTN3MBw0dqph0ueUnhD5y9JIHkieLEL7NZydzntDNpoiFi1iM73456Kv0MD+Qr67nkKF5mUlI7LwLR/2bVuU8KkXwQj1nvkZ+bFsDD9oXrqoomD5QM51FGTvULtETRrc5iOH+vV9JMtlls9X/Ch5fhvzC3iWSmyj0igB/vmkwJJMo/KP8Al/2YyMpQVuazNoE+sh4gz7R5Liqj82PbNS/2UwJUdkpsQ==
Received: from DM6PR11CA0060.namprd11.prod.outlook.com (2603:10b6:5:14c::37)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 09:26:51 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::9f) by DM6PR11CA0060.outlook.office365.com
 (2603:10b6:5:14c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 09:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 09:26:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 01:26:37 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 01:26:37 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 01:26:33 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <linux@armlinux.org.uk>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <theo.lebrun@bootlin.com>,
	<linus.walleij@linaro.org>, <ilpo.jarvinen@linux.intel.com>,
	<l.sanfilippo@kunbus.com>, <konradybcio@kernel.org>,
	<christophe.jaillet@wanadoo.fr>, <bigeasy@linutronix.de>, <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v2] serial: amba-pl011: Fix RX stall when DMA is used
Date: Wed, 13 Nov 2024 14:56:29 +0530
Message-ID: <20241113092629.60226-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d25dbc-cbaf-485f-95bd-08dd03c54dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XLeswnHJVm/hhD+GS4DBtJ7Goczdh/2IGJJD50boeKiThC9qjh3j/GYJurov?=
 =?us-ascii?Q?U6C36K4fqRHFhD4rAE9K9+XxElzcIGwjSzM7/vm+X2inZIg+jOzanBdLRE/7?=
 =?us-ascii?Q?zbF/UG2uGNMlQFv0jwEWUSMhZ31XAfkN8jT6ztLn4kKhTE0VygfISOH8uok9?=
 =?us-ascii?Q?rhki1LQLh9/lC8OHBq9RmM1fObCp+PgZahSDApJgz/OXXgY20KwJlTwjh5ui?=
 =?us-ascii?Q?ngDFrYyyIk+yIJPGvtiU7i4n8Flrs9XQwTM2kaFcKKS/VvXcGw/11Z35jDqE?=
 =?us-ascii?Q?ziI2PKRHg7O8hZI5GMOP/UKubiYX+IaLRMPbfpqyoLNhTks9iZfDk3rjj6Sc?=
 =?us-ascii?Q?v+FZ3VYPoCvIOV3o5WgN+GCtn2rGgh4mwrRgIH2TCKB5TalqtD0Ya7n2/py5?=
 =?us-ascii?Q?EFK85hqSbcdj9K0XhO6tqfaw7D1Qbnh3aMCt1QeT7pCbMG5e0D5BzhzMonfm?=
 =?us-ascii?Q?c5SjvIDbiV2kQAWv/ZzZPvZl+fly7JSoMjCGaGnrOlUzf+QrLbEhOVR2FSm4?=
 =?us-ascii?Q?6koF1rNfP95TmhHghHv2RX7roVOX0m4y+NtAyuHqTYY+Met2/Tmwt/s4eyL2?=
 =?us-ascii?Q?aVultZ6pgeM3Z6ju8A1pbkqGtFncR+N+fIgFyiiBy5yQk9yRCaqZ3Ku6Vcwu?=
 =?us-ascii?Q?4z2xvHAVPQWFIYIo5Is+eD1hOktPWS6ql4OViOvtpmI52Z+Pvditu5GQaQPK?=
 =?us-ascii?Q?d2H9jB9twC1aBgW1pvhDtzCrSe5vWmDUM7QJ4aU18MuWX6bICWTeAVFqNlFn?=
 =?us-ascii?Q?6sPFmsJX6ges/bl0IGPRZfNXScnUXKUk6vd+/Ky91O4QJ/FDDOwhXo7Uay9Q?=
 =?us-ascii?Q?qpN3sQwlI+rZg3+9qBkQJLKswTJJzRiaqxZ0+SRpnBIrPHEuWRh6btKgL0Im?=
 =?us-ascii?Q?bxpKF8e8sdykK7GJYEtsglQ8HK9G0DPkWBSzLUgtkDLHdxPC0kyywMt380Pv?=
 =?us-ascii?Q?LKRazmwa5N8rn1ahLfzgPs3G21vNBu2atROT8UruDcOEsjWgoAKQuQ2roxIS?=
 =?us-ascii?Q?ALf5wbo6/1j7JPK5PxjH0eICbhwEgUuRBU6M61VT2atm7+VPKPowgNcEGHSh?=
 =?us-ascii?Q?6769WjZ5g5Zs4qADeTGpu6GkbRF95Kr3HjJGlt6j9wrELa3Le5fC2whXR2WK?=
 =?us-ascii?Q?mAhtp0R7LVQ6pLrwaUxCH7HGx6RjYcq52mDXsSrgPQ/gQKbHRAM09r/NWKvt?=
 =?us-ascii?Q?KAq/wQ2ghwhhBf4RrJDO5M6cPoLhQXCfn22MQ0DgdX9IcxYsygyqPJw1pXC+?=
 =?us-ascii?Q?Fvu+VJtvhUMiKClGeNsZRcWWZexPEkmPmYBOdtWdZrOtMJ+7eMPYWjqvPneA?=
 =?us-ascii?Q?ZRr1l4zzt5a4ChPb7+teaJmOpr/McfZ5QTIvXIuSlL7eKYmI8kwje+wWBm1B?=
 =?us-ascii?Q?RLzrR31I7EFE/VUEgvIghgWvoPsW9djO/tCMBNhqQxhb0esCjswm3bjb72TK?=
 =?us-ascii?Q?d0l5A2oPtcI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:26:50.4461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d25dbc-cbaf-485f-95bd-08dd03c54dd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833

Function pl011_throttle_rx() calls pl011_stop_rx() to disable RX, which
also disables the RX DMA by clearing the RXDMAE bit of the DMACR
register. However, to properly unthrottle RX when DMA is used, the
function pl011_unthrottle_rx() is expected to set the RXDMAE bit of
the DMACR register, which it currently lacks. This causes RX to stall
after the throttle API is called.

Set RXDMAE bit in the DMACR register while unthrottling RX if RX DMA is
used.

Fixes: 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
v1 -> v2:
	* Updated my Signed-off-by tag.
	* Added Cc: stable tag in the commit message.
---
 drivers/tty/serial/amba-pl011.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7d0134ecd82f..abd789c93c6b 100644
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
2.34.1

