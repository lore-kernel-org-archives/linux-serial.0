Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871026BDB9;
	Tue, 11 Feb 2025 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254825; cv=fail; b=DA2gis+5aXc99ypVcHMbxhwRZGSZCXUraHUQNZLvIfw+LuWzRkLm4ADMdLrw/p9S4NS7276goJAcY+ggbwvOHeiJv4I82aBbt6k1ewBMjDvOsCZyv1R4nyZrSzmeU27BDNwIeFzSNdiEqWnFtzh39+3VwUXYshxnRv+5fk0Azps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254825; c=relaxed/simple;
	bh=IcQIFwLaNbaDyebpicyPbnfRdaTtEXHc5w3VRbc0J+o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ccnjsTgZrvb7UrVolerv+KbCmQDwMIUNC2pIMwgvTiHo3qnqKzXWeoWxgnNsUYNHTeeTnSq1FWlprCJ0/eoc+wwir97MWV93hSYZCz8b4u3NCkwmTMARHvG2VPA+k0GT4Rz2LAhT2lQhWbZ7FqCxxQKd8Vad/MAL1oKS8y05hsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WTZqMji7; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WTZqMji7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdAj1t0m5yppPGhDgGq0zNqfFBSg2OX4X6dKtatxhGxafPJBUlRB2FWcNGFMWhcFKsCJYDnWQB4ynuG5TY/DIarsgzATUPX5HHbW4GMl1OuslR3mlj/yL7NJ1UXMkq8JHUJjwnvAPo9zSnXXn3nZVQXzNutS8DcdKWsawPMgxwrsfw3BZWq5LY0oog+mLoncYjV5IQs1cKb7YmviLmz9TbirdlxdMtC7QdaMmZTwzySmcRuvTknYw+Ou4WKHAkH+eMmpKf0Efxypa47dAMNO1KK1eTZ2HydVx4Ag9r4ryT2RmfoHYAALfkpAfNAcH4F3it33twNqpaZWE9NSEXHxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSjb4RV15p8hLhIZgv8iMIG5Fj6gXzt5L6oUu3p4q60=;
 b=ktS8VWIw9nmmBhsYAnYpOY5g9EIZs/r7rOMcrm+1RO2VLbWMuy5l2l5kZ5XL7ja3x44cH/8FQ49QWOIaVNvGojMz48BWxtQR2ER1pOLNr2ep3xzX/KI6om5sGqnFwNnsZ/YS8NlGw4xu4C/ZQ2IHGmypoe/PcdxFKaJ0ZihnP7uZ/dMJ7f6/KekIpkhAjPD8ce51xVW4CDMtdqTIpglhYdbNDI+pmJvSFt6AmAaoGfaPuY5Ds5KdIHCc9JDr6ZZSggujMEH5/EVWol2S8qGMmNqZ6v2MHgCIfQMn8r7Ni9YaiAatrsERcK7ODHRU70ogTZ/nfnqaahL0cqmwnYPVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSjb4RV15p8hLhIZgv8iMIG5Fj6gXzt5L6oUu3p4q60=;
 b=WTZqMji7oGuCF09mnfGa+a9KQmAtWNAp/sv6XztKaGBd3CtMX0h27QNDfLKG9gw3dMS5Y45nOocAUva4comeRcQdppfyoj8tuc+1C7NKEOR4FvODZ+MvToQzmSTpwOMfHKw9hIY7gj3b8GjlQR8TaRTm+X/bdBd8xqTix7Nic/XJBMDc/prSCUtv3QWtDxlIRlSnkD6d5O1lbgL6R6hILtY8FooCP9ErWnV+pevvoETCmTzHeD4+ykHcVWgHRvEYm5yvhKTxoiDNfYKlw6jc0tRDHnj9bfP+NUybX1ujarEp4r6CZ9zlsNeQN2ebuLvadZzRBadMWM/Xod8Ga00mYA==
Received: from MW4PR03CA0199.namprd03.prod.outlook.com (2603:10b6:303:b8::24)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 06:20:16 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::23) by MW4PR03CA0199.outlook.office365.com
 (2603:10b6:303:b8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 06:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 06:20:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 22:20:06 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Feb
 2025 22:20:05 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Feb 2025 22:20:01 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v2 0/2] Add support for Tegra UART Trace Controller (UTC) client
Date: Tue, 11 Feb 2025 11:49:43 +0530
Message-ID: <20250211061945.18836-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: d857861d-602b-4450-048a-08dd4a6426c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7D1NNzadxT2k81jcw6oViB4o8LKjuunrEgTLk085LZCR16xhk5SxTHhqKIEI?=
 =?us-ascii?Q?ZQQysajqzS6Z5gZo66GMhKHBB515u29kfZUhV5K41Aj+OgdBhCTA+F+qV0cn?=
 =?us-ascii?Q?w9HuP6i3ndOakOCjRiOxxMbZp6UwVd4YTrRfl6D99nz4XvKwnnVaf07dnOSS?=
 =?us-ascii?Q?qOSjQTlVcijioJQ+bLFt+U2Zv9Th+pxWfT8Qgwr/mYabOKplLHnWFXGIh9tp?=
 =?us-ascii?Q?MQeCDNGP2J+lOdEqjABeRysAyH0vqa590qUvEmT/lwBwlNifPGG1oajZlrae?=
 =?us-ascii?Q?yRR4CT7aHCur78EJCNP3chDSQPvW+DW++F544VOAxQ412s8re5c8MT1igznC?=
 =?us-ascii?Q?Us64d0sRlbQ2ZyFwJAD7DTn6NQR7jU8fahA9eEqRTZlwaMGE9sqbXrRpthNL?=
 =?us-ascii?Q?3EsjDFiLNG2I7AwLGvoz0+sH+Ro3her+xnPv7QK/BK8nw9/ADWQ7Pu+4bbeD?=
 =?us-ascii?Q?m5BlYP0qc0l5WrTrHAFGv94bvecEMa5fJebFfgYk1V+vErZWCzy3d98R5Cud?=
 =?us-ascii?Q?eB7blIpESldaOKZ0oyK3edrJVM36mNfpOCIeI87uMlZPDEfhk2kj6q0yeF9+?=
 =?us-ascii?Q?Vbhc4iOS/j2iU04qXd+N+PxtJeb1/K7g8Wq7Tdx3wKBTzRLy2OrEKnzba/4W?=
 =?us-ascii?Q?lqcHonjFYit1Nec/sok/f0hYLGv3HwQ70vJVrJPPY0Vdj4TsQAVqWYyTWVdf?=
 =?us-ascii?Q?h2bv2BiVQDjtuODynNyeaKqO3AywDsTYMo1IsySUgIDwEBuQQazECHTcmNFp?=
 =?us-ascii?Q?zmEvS8o3R0N5wT72PCOPkshPLUAptvD3eE1T+mwiX5mnGzlCMXi9uGS9vm3I?=
 =?us-ascii?Q?nqFjFrIN931PGXI7/MJYzXOwFOKWn/H6Y7Zp0+NuOZNyJLVSCtPzbW+y4fMN?=
 =?us-ascii?Q?ifyZvRAnFDEeZBQG/AHhF8V8kpQ9j0VRtanQEMXUsF7Sm7KIuqoFvab00lq2?=
 =?us-ascii?Q?P0sH6O69/0CGut8M2DmJqj5pD1nHkAsozkc/aH0vhKHLNthU1FxIg5yxHtDJ?=
 =?us-ascii?Q?d2ui15j7uoGUXaw4Svy6z+HC4h4wpXP/mJXYwdj+dFlwH9k3bi5wf5gocnTC?=
 =?us-ascii?Q?di+m3JpZse8qDvouWAlcBDYmsSTQLzpQ+bQnrE+GXEiDTyGziP9dbGh3+aO7?=
 =?us-ascii?Q?49oejgWh5O2kMUWCZak2nzUAR4aKgKgHJHt1ZQAWyFSttObV8J07z6bZrHVd?=
 =?us-ascii?Q?NJ0O+VqUHgM+0YKzEAmmiPscY3JAmrXS+s8Hu6VtCr91j17WSdbIk+7JY4ty?=
 =?us-ascii?Q?EeCtOq/eguYHgaDyewTUOkp/hxm2GEuFdVrbHpm+mQnyzYb5pSHIey9Hjo61?=
 =?us-ascii?Q?v1hu0ZgCzEq2SVjWU72EjGq+6QQibwbaMtq80wHD1J1bjjPQA1rQ63JWPkee?=
 =?us-ascii?Q?/fb84IPno+qS2NcO/cDmZ4SZFNG6Llu9b6EjSPw6FZfoh+PZ6BlZTjc5ZZ9k?=
 =?us-ascii?Q?yfHIzUIYZaX4T3DxfnM8TrvNRtpMnFULcn3aqyuar6sT8XBwgABN50ZrNOuh?=
 =?us-ascii?Q?KgG2x/DSxykGSHY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:20:16.3665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d857861d-602b-4450-048a-08dd4a6426c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916

The Tegra UTC (UART Trace Controller) is a hardware controller that allows
multiple systems within the Tegra SoC to share a hardware UART interface.
It supports up to 16 clients, with each client having its own interrupt and a
FIFO buffer for both RX (receive) and TX (transmit), each capable of holding
128 characters.

The Tegra UTC uses 8-N-1 configuration and operates on a pre-configured
baudrate, which is configured by the bootloader.

Kartik Rajput (2):
  dt-bindings: serial: Add bindings for nvidia,tegra264-utc
  serial: tegra-utc: Add driver for Tegra UART Trace Controller (UTC)

 .../bindings/serial/nvidia,tegra264-utc.yaml  |  73 ++
 drivers/tty/serial/Kconfig                    |  23 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/tegra-utc.c                | 622 ++++++++++++++++++
 4 files changed, 719 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
 create mode 100644 drivers/tty/serial/tegra-utc.c

-- 
2.43.0

