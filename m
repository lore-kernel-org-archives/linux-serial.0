Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4F1A5AA;
	Thu, 13 Feb 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451413; cv=fail; b=EDUPGZESA0iKM/F/fnOA4lVSFB66ZvXByqu/UEjtNdX1r9N/AbIiH1f6l3d+oXkR6WSxDZX4bz/hADYBjfR4fItY5VDsh9VfEG4NXQkp7pY/cL5J0vj5LI+i+oE5JWHjzULNOtoequQlHX7+8RnsxULfviWSlg4WnA1nWpqUQkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451413; c=relaxed/simple;
	bh=Jlf6YrZjZjyKswlRWcGZen7WrnylwvP7ClaIDq75Jbw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eExD9qFogmxs9VsjOmIq34rmdrJQOWNpK1KNA4xrIikReQSvaYGT5co+9IZMiNuFuElou+PJPvgIFBrjOLq3mMiUEoGKkiS+OtgfXfeDJe1zYMHxZ6l0P4RYl+ZPs5CG/pYoMFnUm8Ymdxy5LeDq3wdFLJ54ppZtJtwZz2a4Y00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NNTehYPC; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NNTehYPC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MforfBVoMip1mGG4X3xW3ePfC6rGJtXaTyQ2iYq0G62/mEJiHP9JmO203sn8X7KQt1hLPnUCSg/kiJ/z7lKbS7FwtIlrAWZzAoSL+UpOvrO1CpmTUijOTPuUCLn1dh6FjwY2jryiW/q38+bO5ZroNHncIj715OUd09CBcplUzJ8QHaXBj8iWoqDpeV3ChL9BtGMJXjEfwqBx1xqhkjKHwbkmi5rylYd/vpq7BPaEumyuQtpiuZSP8HoybiGXbpNpIzG024couKO6rjb3hxPvEQVq7sOrQTVhxodleETDT3ZvTpkj2GlAOp0zfwQY5VALDVqDTdSxrYrBG70JbqLzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4UVKXAu2bMNuD93pjAvo/2q8qW5+sybznugIUZsc9s=;
 b=jQ+td4/zdt3RDzMW+BjGgwPDPotRp1EYfxoRgz7U5qJ7FrThwOTENsbDMt7fi03sh6Tenyut/yRL7nyKCNETF+sa66EO5wLoQ2pU3VmgQsjSVGaqFTKnsMS1kLIEDuc/jGGc6MGgQSSCKs3tJ7Xt0uTMrdgV12fdDKrVGngr63S7+zWULp7PpRub7ei2I/8r3dBC61FXx7LjVvWQIwGoPdAgCKQzZBt5XFATSM7Prlyx01H69yZANYM11wZpjpal4tis/urpSMYQPzTZH+/QHUyoJLEC8daePYuyuc/38YqpyfPn22kNBcJ55Yq9htLzmfGjvMmUTq6z8lvqr8e8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4UVKXAu2bMNuD93pjAvo/2q8qW5+sybznugIUZsc9s=;
 b=NNTehYPC8mXc1aFiamh3DShf+ZJCwf5oBovwFruuv0dxI3/ShnlIuX8YzM8dr9tfeqdog20KhWycR3gDvidnUShddq10usCd3BQEV4RHeMd+EK02VyvwhlPXcFQRz7UhtBQHqpMBxWgHLci7G9FlBWlyaaClZG8VcKkq03hYC94OGOpPFEIiu6w54SO33mgU2VAzvYGfczfZfRycb9WFj4Kffe7g42T/wB2VLxvtqYtXIefiZlwX5QvwywNR7mgTFbPE3DBE6JyKSeZjHprXOpB+5kD2XESrf6l23PbrFh+FwAc3TccQCEiJgNIQtx8HuHvP6xirTS0VnMjVNHTgGA==
Received: from SA9P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::31)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 12:56:47 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:25:cafe::9c) by SA9P221CA0026.outlook.office365.com
 (2603:10b6:806:25::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 12:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 12:56:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 04:56:35 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 04:56:34 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 04:56:30 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v6 0/2] Add support for Tegra UART Trace Controller (UTC) client
Date: Thu, 13 Feb 2025 18:26:10 +0530
Message-ID: <20250213125612.4705-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 3038aaf5-9adc-419b-6ed0-08dd4c2de044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bag9ZVq3CWTEyINfd0kQZxUd67X+6E9n/zTrquCuqvl79luGCur2b5XgCbmk?=
 =?us-ascii?Q?MOfS/yU47nIP5mcm02e61uwoiKUtTCmCADdk1ZBFjF32Usxaut65obxDH7dH?=
 =?us-ascii?Q?EGUf2VSoFZFGzeGCwp0NH9kWmGWaQozMDRKHq2obd+QhaLB4WH4FaLHQxL+q?=
 =?us-ascii?Q?MvCz4maYzIw00ivMdyacX+SwkQeb5f2SEKl3KT+OqREGp57RBvnhKWXADweO?=
 =?us-ascii?Q?8pU4mjgG+S4iJWbg4q9R8FxjBXDOjfVXlInxLOH+YX5kLaOGefTTS3Kv/iyk?=
 =?us-ascii?Q?FbCA2mDwyxFzZJubAjUl3kgUE2KP6GRrhHYC5xCAYWPxRaZj0JiK4xFtpav0?=
 =?us-ascii?Q?inrYY8hI9ayAh1483oYkUDGN5o1+//0Cu80w6i2EOTMpqPYjLtvtdMhnreIW?=
 =?us-ascii?Q?y4lwiVUK1jhyencmHfGT1HWVkmTfMtolatxuEOXnEBa/ajBBKz7j3ZSmZuj3?=
 =?us-ascii?Q?1PJGzEPhWryHy31jcJ5QfMj6s7okEOS8xdPQtkBsKfog6+FuDLt+GARZFn04?=
 =?us-ascii?Q?bH2bsbFezirfffbYmbH/U2Hg2D1m1R1sxziut3SkKKn72Er4OyQviYSysyvd?=
 =?us-ascii?Q?UCoc1cGSAGbERVk5fC75Oceh/i0xhV1RUB1FL6/fU+bjyGHrqUSeW04tHFyR?=
 =?us-ascii?Q?z6lIXnX5BIRW/aMxaC9muIZHineaVRle6X8ofw7qb8n6zNnOmlzBHDFjZ/Ld?=
 =?us-ascii?Q?Ih48mbdRjTgE+Ae3WfGxybZ9/pxnqQ7JTw14JfNc5V3evqK4QxQ0ohU5SDdI?=
 =?us-ascii?Q?9iTnu921YtRrXzFHZ6lBrSoKvJkE/K1XvZcD8bMDVka7FDBS27M6B5fcRmYy?=
 =?us-ascii?Q?6tdisagz8S6zNCMHj0NzCecPUA+7ru6REEl9IjxHP+WQUO/jnJS/+g52LxTD?=
 =?us-ascii?Q?HjtK8cg544hKxFJaap0F2L9Ok8Xhqk+KckuzfHmgoujxIvHNmr3XY0bsJ8Zb?=
 =?us-ascii?Q?bvk8VthbwM/4rRRoZi4fvC7ZK2CsrlqAgSpqM6gnJP/VS05gP9bQeL/NVfSq?=
 =?us-ascii?Q?zGOCOXJzU+O3DdB1r4Tm9yO4XbRaljodlDRGQ/uzqKPKq1AREvixV+Mx02G7?=
 =?us-ascii?Q?rdwiF/7+WXFr8vVRBWRtl8Rox7mlO1sATRas5zARXrtFmUCOqCahIYzIepFJ?=
 =?us-ascii?Q?JZeRRQd1/J5nPcIYPpvGo2XAwhD7W8TBdIoyZ/4yyDEacVB1RZ1vXy/ygycT?=
 =?us-ascii?Q?BQ6fgX2qXtrzFdps6a2jLqL5uMr1cGO+9U5+9MC20uO5WApzwxba1u3M1I4K?=
 =?us-ascii?Q?4cxVSJYAq0uZaNvwT98cmQe9bXwQcIoT0UN5IgnreVyYHaCL7v5mL/CgZTvt?=
 =?us-ascii?Q?nEs51GQ3LfsfHU2E3rLTY4WlADO1oj1LNBUmi84olurTGnL9ZKSPSGZhwgvk?=
 =?us-ascii?Q?gnYFqGKB+8hhk1oerDRLZccG2LVZcIz0M/X1+i5U+4CShEdJfVQErxADnmfE?=
 =?us-ascii?Q?eKfRZDo74iPGDvBw1iWXiTqbfgM/oq2IM7IlBbETe+HPAdvTTeHngeN+NfU/?=
 =?us-ascii?Q?e2Vsfb+1FF6ph2U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:56:47.4736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3038aaf5-9adc-419b-6ed0-08dd4c2de044
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715

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
 drivers/tty/serial/tegra-utc.c                | 625 ++++++++++++++++++
 4 files changed, 722 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
 create mode 100644 drivers/tty/serial/tegra-utc.c

-- 
2.43.0

