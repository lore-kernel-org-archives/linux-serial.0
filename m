Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012011.outbound.protection.outlook.com [40.93.195.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8115F2D7D42;
	Wed, 25 Feb 2026 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002782; cv=fail; b=EFljioSvrgC1FN5TMCiWwZKQJrhjTlvKcwvk9ypG4NlM7/xIDrw3jQFWlia7ixFz39ci4cgSYmww634aqGfGqTd7/3Gep5Jp9TQf20sPWUikgz7hayEDAUt5dHfM3Lw1D+1DQXTCZK21xf/WFF2rPpFtfxUpNAJnbzEN3JtArtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002782; c=relaxed/simple;
	bh=yFbqjqBaUd3MqefWd4eWMmALrCYBfbgBrUWBGazpE0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JPezCAEGYHgUNHpUmZqhj+sIpkHazEIz7ZxPGmDrz/0FW8gwZwgpCLYI7EnPaNJ810KG+3b3tFUsRLQcTw0u02x4GD4huUb1/zNOGiAuuUfOTBPimlAq5dPAtfN5DpAsTIfIQWYqyowXw9AqD9iASKmIfFFfYPi7wM7QVZ6E3HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lR8RLo9X; arc=fail smtp.client-ip=40.93.195.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lR8RLo9X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzTBkJN5NTk6aItaPG5VZI3BYbNDh9ZojhRVYGQRQ5peDO0Q8GsQqyuHgZ3HBBKVQ2rswXkmkJ5RMKQuM96wszkh3MiNf9PSTwZe5hL8YgLWaPyOhsgd2B5R2ISucw6io5NdWi2l/ZMZWT/kY0OA9haTyJdTY/vcPDrx7IH6yTc8b1AlgQq/aMCPmhbFq0Hfmv5QKdO/WrCmydZ6iyyiKSnSv+munkNZEwe3Q5AOyVOmWj7s/03qMp6S7tHqBpnalgOhipcPHwFXQpjC/xNre2UcX5mWt1ZwYD2FNVvKjWYKWJOgHIl6+mNAluHAxg24PY/9Fv+uVHzpGmn13ChiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74P3+sjk4WLXAWH8bakLF8Ik+5MFcRxAhAVC72j+vgg=;
 b=QkMY1dkTbHwlvd4KaJeEVIGfXOXszkj6gyDYVL7xEqlqKo7ucXuAHRzX0C8ZRzAf1r4B3/B9DFQgq2YCuFFshN8LwVgcgJzuji4Rh/El5uWmXoM3WdPfua2oPO/wwbODztSzCuvqMRKKC3BsRKO5n+o8pLgAqUvh4r4EQpIijSvTYDrBQ30+FNxXT/+HS6iK9cRKYfqDJi2NcYp+KR4szabsp9gkwg57YnO8cHuAevedxvs+HER5SGRd/b+QJsjNChsxoJTbwYm+V4b7tF9Z+7Z2ti1wxVRQhY4r5tBEiiJ+HDk5juQC1SnlZoF64rXaGxsKF26nd6fWCD3+JmUuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74P3+sjk4WLXAWH8bakLF8Ik+5MFcRxAhAVC72j+vgg=;
 b=lR8RLo9X6F4TeOqqDMxO4bCwj/VoDm5E9TREr1zV/urLljScigakT+wSh6Z2d0WFx2H1EO/bAFxlMheM53lQTJXF2s2zgxlC3zlk+CSd/yjJzesOix5pif5A9MRZjgb8lyHnkZ7RzaHMkFjwMYWRiMfeNNiREUPbJzmLBlDJqjwXDtvCRr+BkJIEiOTUxafkcRSAIO4Okvb4ZVo6hDjOvvB8d0w7rSwQvRucuY/g0bhwISrTfwEUZDsWGl2gLFRG5XMcurFFxWfEH/P7oLhmKDVnmu3aNtI59PMezxZ5Q+d+bUYCOAlQ+JxtmFJjYfW3pS99ndP7KrpWJSZ2hCEGTg==
Received: from CH0PR03CA0257.namprd03.prod.outlook.com (2603:10b6:610:e5::22)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 06:59:36 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::8c) by CH0PR03CA0257.outlook.office365.com
 (2603:10b6:610:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 06:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 06:59:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 22:59:21 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 22:59:21 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 22:59:17 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <linux@armlinux.org.uk>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <mingo@kernel.org>, <tglx@kernel.org>,
	<linmq006@gmail.com>, <arnd@arndb.de>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>
Subject: [PATCH 0/4] serial: amba-pl011: Add Tegra264 UART support
Date: Wed, 25 Feb 2026 12:29:10 +0530
Message-ID: <20260225065915.341522-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2e6c15-27a4-4e1a-c2fb-08de743b6f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ztrM/RvI8dfTV2cOHeOFFT0UOm/QwTGBlyr2OYhjhX27K9jq7YhqfR0Hje5N?=
 =?us-ascii?Q?xoqMPrewRR+8FAp8cVVrQ64SFDjPLQ/EIJNJjtESVIlpJp1QXqWhzvr5NKDR?=
 =?us-ascii?Q?jHLONNeVja9futVF9js06Rot62Bce4TRdWTJm/a0QaiTunl6Xg5XEsIcNOkK?=
 =?us-ascii?Q?qwTshyqLw5k6KFmq0ldJx/W3EBsVYiESPmKCfH4CO2zDnHxXdTjFuDgEcu49?=
 =?us-ascii?Q?BNOG3m6kmwYyjtiMOZ/BNyPSK9EHFQAHaeCneerhqpyiRf4nQPd1S0/irM8D?=
 =?us-ascii?Q?bk4U+DFQnf3lE6hH5xr1+9DB2z23gS2boYIXG9ep53ascMv+R15l0QzF0tnD?=
 =?us-ascii?Q?wa/XE/bcfigkuP5DyzM2u+03UQ2AZwxn9ahWOAkkXB/lJaLfMg+rNQNGjcQ6?=
 =?us-ascii?Q?weVM0jfopXk85vpnXbT0ppyQeAJOqpfWhi2o0+5WBowztYOTBsFyHZEcFsf8?=
 =?us-ascii?Q?DNiHBhYUk7SgncSnlSduKtg9gb5IGS7vifK8FR8QPwgH9/14t4sfbV/g1vKR?=
 =?us-ascii?Q?NqZG4VqqlcTCIQxplCXNnLxeSF0E92cZyWrSSkA6ARujlOhmHpLk5+nXCRwE?=
 =?us-ascii?Q?2mxKw7q7bpQMJBtSLvHpgXovPwhh9h8kvO+In4EfcjHL93Elp5Zr248qAojx?=
 =?us-ascii?Q?wzNhMD/mKxQZqIerj/8jpo5N/zuVU/HNoyo9HJ5Rvpg9/sPU3oDfpkk6gCCl?=
 =?us-ascii?Q?SH3cF694w38hgEV1rET1UDBvLN5Dz4aD6twZGJNI7YLA+ZpR4Qm+6qrFi1H0?=
 =?us-ascii?Q?AKqXunbPTvD0U9LLGxr0yeoXYpjXkJha8KMHzPgXUBSZSmrNF3d+zKHti9cn?=
 =?us-ascii?Q?kusgykXurrykv5+w0su+jQ8MmKxp+BVfRHuEimHF0qqYBfJ55UMzhS4CRq2Q?=
 =?us-ascii?Q?mal4ogzzgHHXlCEENKYqmEnd93fN3uFYAFYc4R3sIPXgZYkqpZ+RaIjz9R9n?=
 =?us-ascii?Q?ioQrj/nHfjGhpvf/W3CnyDjTtrYX5KGysbOFCLFoZNDkimxrHfTdM6ug6n3z?=
 =?us-ascii?Q?hWF5/utAZZXeF2i0cj1+13B80dyI5HWq2jLPjnQywNS6gA2KWb8+gTjDyYGa?=
 =?us-ascii?Q?srcu+BGug0cs00zh/xayWFu34kADLdj6qlk5Ws2K6IWNnkAdNInKq29yyDok?=
 =?us-ascii?Q?ngKrI39uijtoLGxMM+UYY5ITP7HqIBysOcPCHKkUpCVVJ0Ypf0C1dv26Rz71?=
 =?us-ascii?Q?vBDkkhbPjXfmQodJjTOVY6V7JOTcxpr9OhCt2a/fbBiODeH8IvT222Df4Ql9?=
 =?us-ascii?Q?5HaQoe3ufCjJ6/HeLYpP3B2MltOxa6sofeY0JYrOOcb5ECGG9uUz0IhIPlcI?=
 =?us-ascii?Q?nrTVSG1rkUJ0dM1yQ9NmFaHSMhtcDsRwGwVfe81sT5tWm0Z/HVZEJfJj86gP?=
 =?us-ascii?Q?TVHUU1KaIUcP5gOizF9ZQj9w/rQnZlW89H0eoa20MD2SKDf9SjNYOtbiFjzn?=
 =?us-ascii?Q?FA5lerFQRTpwjFBamzDEG4mhx6gAayM9c5sY01vaiDJLfl5JTm568mGCqX0q?=
 =?us-ascii?Q?an0EdL38+7SgSclavlfge0QEv8LWdwRhip/2ESHGbC/NgV1PQK2gFzrNLfTT?=
 =?us-ascii?Q?CktIcy8F5k7qh/JmoiMnwvj8a0jlFhwVjYaX07tC69dBZxKw0TAQD+HVIaB+?=
 =?us-ascii?Q?UD2C0xEMKzltIg9Fun/l437MkCU8n/JHLBzgBfrBgBYlvM3DGLlK8LCvhuhm?=
 =?us-ascii?Q?/1z2wykKBZmUCFEEefz/XQ8hyqc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9Fv6OY6w0dS9jrnHcbofiDwdIIT11PHXdQ+BHY+NPzZcgDY8g9bAoV5Hn6zGAlk3tog7vi7t0QD56wan2IGJZdMvLAA5ylsoBmrXOwxkekhFEdirBElNQdkrWf4hWQc9AzY5wkAne8z8pEns6h7FKJ6KG5b+hshT1PaR7b+K74VUgZuu4qiaEUmozwh1vy3/jZzEPRojJkye0KCwCV1gUe7LiISyLIx1ceaJwyRlbHTMQmbnP7TfazTP7MCTDRJSpkqpTy9pnZCs2qIm7XnihQq/enEic4plZW0gnTGBcjS6pi6kcg3x9ErahsR4k3TxPyatwNRCDDzgX1YcQOgNnwhcxGOV/FdLO0T/lN/mhrt4GxR8h+B4Y/tudIEPU9Ua6PLomUBqQhtqpKgebiZ7IsD+ZRUB8uuMMUdqmBSbw5NsYFDcifQ8F26jtbMnfuq2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 06:59:35.4601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2e6c15-27a4-4e1a-c2fb-08de743b6f87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

This series adds support for the NVIDIA Tegra264 UART controller, which
is derived from the AMBA PL011.

On Tegra264, the fractional baud rate divisor (FBRD) register is
broken. Configuring the baud rate using IBRD and FBRD may result in the
baud rate falling outside the required tolerance. Instead, the baud
rate is derived by setting the UART clock.

The following vendor flags are introduced:
 - skip_ibrd_fbrd: to skip IBRD/FBRD programming
 - set_uartclk_rate: to configure the baud rate by setting the UART
   clock rate

Additionally, some DMA controllers (e.g. Tegra GPCDMA) require transfer
lengths to satisfy the controller's copy_align constraint. The PL011
driver does not currently enforce this, which can result in rejected
transfers. The DMA alignment change aligns the TX DMA length down to
the required boundary, with any remaining bytes handled via the
existing PIO fallback.

Kartik Rajput (4):
  serial: amba-pl011: Introduce skip_ibrd_fbrd vendor flag
  serial: amba-pl011: Introduce set_uartclk_rate vendor flag
  serial: amba-pl011: Add Tegra264 UART support
  serial: amba-pl011: Respect DMA controller's copy_align requirement

 drivers/tty/serial/amba-pl011.c | 118 +++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 24 deletions(-)

-- 
2.43.0

