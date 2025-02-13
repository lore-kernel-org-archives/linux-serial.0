Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCEA211474;
	Thu, 13 Feb 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441120; cv=fail; b=vFSnhEXHsj8niCPRS27xAVa6FRSmWNmOl6tmzg9coJDPXo63B1liWETLhyte2O0wIAgzU2cRKiOZQcnwu+hYXiORseg1xYHNPMoLZVkzFeFrmWeZBfYjyxzaSz2vkJHe+crbOYWtTrAH9QJ6vrQuBHrf13BAxKc/FjowoFktfQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441120; c=relaxed/simple;
	bh=Jlf6YrZjZjyKswlRWcGZen7WrnylwvP7ClaIDq75Jbw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZaCJS9sG6pPZnRhMHl+6Kv2NELOXTRuV4/Tj8yFiDoGFJnv1mpjusyQF48qHQHw/yiooRA3M+l09EH8XwccaMvwW7db/i0z62Y0huV3HFiJkITwGb1mk7X5z2c1uWyj3HFLh37LoX5W1RvUYiotiRJrnqWPik37lv/dO8lF3dYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WEUdk+p3; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WEUdk+p3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwDPKuq8+Hh03d5SdeEwy2gjlSupPCXiM50ckgyih0Jsynw6L8dznuZBu0/HFythN4IWZQH9L5y+ho5ynbcfaFFvrwn8Qh/Os+yFw6wb/dlT3ZmQxEzwZtPmlzTOJ7YdXXLqJiKHaiadYhOXifvpqU7DA2Lee9PK0anMS6EGA0cXsJdOPkOMhmuXki0qUhXt/vDqGriEoLQoiWHUHPg3L0CS4QjYdrg6cjbUH4BgyuxXkRDpruaLztlxLcqcZC7BAMytVcoWLgnRQlX0V3JTqEInIhmUYckbmYMfC6qx7TFTj+tw8dRjR+63LBJmijhPS/h7e3QbXo/VjdzfST5I/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4UVKXAu2bMNuD93pjAvo/2q8qW5+sybznugIUZsc9s=;
 b=pxQ14Cz/D5il81fGUyHLRgASBzXqZvoexQxObbEFOHJZQlFIWVKPMav95rYWZSRIjjaHXGeXVP4xayXl5VSdS04KXgg4mPKneBNc72fh301byifz9SWgbmpN4cb03cBKEpjl7jDBD170hFyYLqsddRfHRIVzlAx2Y/TuVF5LZhiE0XNNOBUGrbjuljHm4wGcM0Xv2OwrTL1e/ORI7lXFfZTxzPPbvWAlp5kYqlTo6ZUv0X0mfhXC7zc9/dLuJTZ/NYj+BmHAItbmuzZTAD+MZuVF9MB9HXdj/uN/krB3KR2Ul2AdS0UgWoIC80Zd3636xqJM8Dv3Y8bcTLRiVjhyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=temperror action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4UVKXAu2bMNuD93pjAvo/2q8qW5+sybznugIUZsc9s=;
 b=WEUdk+p3F+s3kbCegNNVkfY2VM8jgrq5GSqK1P3g1nArtlZyeoQ1YoXSRW/s6mpCPGB8u4Jw6qHgrbmQZCACrJaY6t4h+5f7dzM6ty64BdDSIFLsPAGX+BUJi9OCqkdJ2x4ugYJ3lbjCV3KIhEtHUIZEjw/ciJNow5tcTpdDpsjw2hZYAPm4b1Gg1aqy4v8d2b4nKnf7PH9TBl2PsfcK8+GNn4dakuOL3zLqb1gDLR8svZ2TNfGsutLUhTTqRs4nu1DC9BrTXq8sxjyaMOVS2kSGC/zkVeL4y1dwtuUbdlLKmnJKV1l15h9zwdXxqMrrZaS07YjMzDSNjpxNcALBgw==
Received: from BYAPR02CA0024.namprd02.prod.outlook.com (2603:10b6:a02:ee::37)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 10:05:13 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::a1) by BYAPR02CA0024.outlook.office365.com
 (2603:10b6:a02:ee::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 10:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 10:05:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 02:05:04 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 02:05:04 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 02:04:59 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v4 0/2] Add support for Tegra UART Trace Controller (UTC) client
Date: Thu, 13 Feb 2025 15:34:40 +0530
Message-ID: <20250213100442.45773-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 6976cf7a-803a-4236-c1f8-08dd4c15e768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ivND/Kwf7O4P1oFNXVzkpqznEjXUYINAUCWKxvYK9Thd+lUcx26aGeaggPm5?=
 =?us-ascii?Q?wV5lktsjFDhTxaHSD0d8bNJmhyDBTRdB0GjqA7BrULnn1tGXm6VqMKGQ4ko0?=
 =?us-ascii?Q?6R48PzHlHJ7rzfm4k5RhwU5uoJATc8O+JH9XJxHoZ6khA2ZYNKj6aQBzjgBw?=
 =?us-ascii?Q?zPM1zlnS6he4uZ3OH/mYCRBhSyUVZMXgkdyN0Lt1RdNlktkCJSDTY7903kOc?=
 =?us-ascii?Q?uUkid32/nTuzeAsTj14SHsT2jF0jf6bMeXFPRFa9z8SwY9rPfZYMhXqhts1k?=
 =?us-ascii?Q?wigJcvzxZhumWeH7WDBdKHIJkFleq+I5wX30w9xzDyuUdQmvfiTvh5gYAWIb?=
 =?us-ascii?Q?1woBxfHXFZnEI+2BHnl3sfQVqcLb2s6sK2rgnzVG85q9bAXWTXLPHQHuEEzG?=
 =?us-ascii?Q?2cJIF2oSNtZ2zIviq5rRVgAwaabizljwmrja5fhQbRgz4JgRAVDS26xkwVTc?=
 =?us-ascii?Q?a0IluhmAfj6oMvrJs61nH7rFPvPT9G8Laivq5D/aK/cFjKqkQPFSVPdFXa1T?=
 =?us-ascii?Q?dOgZQ96JskP5Yld3KHBrk0xgtBzLn6rXazDv1NkGQaCFZp86tnhsJF5mAf07?=
 =?us-ascii?Q?X8e5dJNANfKOZ+Wuc+LZpSB9hi52w06pSNxUBbS54NtHWCOieDcDmrjnF+H7?=
 =?us-ascii?Q?FXXzs1xD0jA8+8Zzxe4RcWNT/YtU1Rex65fqh/wyysZgWfU7inGgyKidoTHv?=
 =?us-ascii?Q?PgZCkBKqwcC3xCrAIBW5NufLIu6z8G1IDqXZLTYV+fG+UeFoZqzDE0Au3IKw?=
 =?us-ascii?Q?HgE1a2MnaUibJAUw0Dr7P0QpEgO1HOpNYJAQZ4EaglvN5iiyJNqs764+SHbr?=
 =?us-ascii?Q?XZRxErYNR/94qdCbJeXHq2gsxsz0cct0Rt+tLKwBzabToErpVIB+D/ksCDgQ?=
 =?us-ascii?Q?2BpKUE8+ft+sSfznto2FTatnp99aBVS9W22u4pQLC+G0SeWIHEb4IPaFmllA?=
 =?us-ascii?Q?MBrvFymCi9XsikJhG+2kpOBGkaDaoibxm2Wy6yo5WXdAv9efKuqdRrSy4atB?=
 =?us-ascii?Q?7w4oANw7+zDipPDf7k1Odgw8t+LmpdfHCSg32WIma0xC3FZHZ/efno/Lm3UQ?=
 =?us-ascii?Q?+wfFqe7sJQPF9mouju7PqjIW44S1i+SrJxmO+Oo/gENqW7V16DxyRKgQr0xo?=
 =?us-ascii?Q?V2ahT5vyqPTi2uLVLNVmhBnMDx1ed6+Vez8rJhS4XMllhYll+a/GbY6V8vHN?=
 =?us-ascii?Q?pMo2E5xQvN8q1cXZngqGN3ruz1aqBWO4RdiAAbeSNhpO/v2cQXvBeFARfX9L?=
 =?us-ascii?Q?5M8N1aCIim/oOJSU5siAIChFyTYEe8mwASzYOEIKohpv75Dt1tp9IHug6d8B?=
 =?us-ascii?Q?DhW/DS3zN86or3ZfH4q827fdoV6XMsDIthVe0WUkRhHM/YXdD7H8kU3SLEDL?=
 =?us-ascii?Q?oYoHjhy10SdR3vdz32cxU71Pr/6sG8HSz9u/KpuYwMjm6l6Y4sLFqX/1sKIc?=
 =?us-ascii?Q?+vWsweW3cJKuPjhUgmGg5XSHqW+qcNksn4AwxeiriVrRLQN9DwL5lQ76/0y6?=
 =?us-ascii?Q?jhX2r8piwwNY6w0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:05:11.6279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6976cf7a-803a-4236-c1f8-08dd4c15e768
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

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

