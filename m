Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A61DD539;
	Tue, 28 Jan 2025 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738046821; cv=fail; b=Bql1w0vt14bnUDyuKhLw5sfG2cKlctM4TclADWEJj2SU+u1R3msraEr8fvgqwsUT/cceRQKxekmwUNW7E8/rb5GpVK7Vg3mdwdVkNENGMKx/5gxK0DQp3i1HZkBsFpVZDbK9NlFELbK2/yJe8L0GSRnJSZ8AGQBZfaiMOq/tRaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738046821; c=relaxed/simple;
	bh=iuk6kVxht7V+l9uGHyjy6utJYBE+Hg+Xm5BGJGsnxB8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RTWLeNq4ncIjnFDv11YvPQMNVVqqBF3JjcjBGqQP/qR0LXfKJxZ8U2HZxelGMRtu0B1hMpNGuYusNUxyKBMRkQbDE7PT3nlUfMkJZGnn0YyERxglpy36afYqs/R3tNjQ/HuC3Rvsp8QbE8I4qnnKVQyGUasBB+Mk8sg58nuW9Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CcCL7H3V; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CcCL7H3V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/6bafAXNcxSJdunkTkzo7KEQa1L5Mzveab2tfJAUd/Xt3BIUkDdwTonuC9wAsuZWlnDVKgQH92JIqdrtyYgkPprCvDUP0D/jZ0A+wqC8GswaGBuSzae7ae5+nDbkVNzBSHTCycUENUg6/FQ/inDKoHzRFv94mDTOpoy+4OAHK7FMITONcLzZNel3w2tN3xzv7FMl4ZCEZJHJChzPDVrQgdq2cSGO8alteP5h7s8VZlqSafQ0NmxgLQRfgwp+gY+v5Qoy/ogYfdTADjuuAQygkh6UQ/5ZvuXWWYlfChAWx9ByoTEuD03hEAI0fCZZ+DS4EbEILJIJxTctbrLWOm8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEaL3rQ5dyert+mdTnJjCIn7ClR9cyKLB6VQ9fUvkVU=;
 b=VooERxvqManodeHEnAxvkSQ+iqs7kHkR3zFaDOqVjcbix4VrpU7xMFXolSsTjrQDxSabLSFo05nR33W+W1vkeCD0iYifsqCGtYCOcNRUV8P9orhRfvUSXqB2aPRaEhWCEka4r3sSTTb/u6qRXlnZ+lR/vS6BoUzZ4k9t0OER+vLxILRDZzWW67Nt0YAB3rdkKIh0h2iVSQ1eP+WxwljPqP4h9rKT06kbIW1kwaoBj3gE29XQGZuPI7sHlC2orXYALvW5Z1B70XaCYGY+wNx2cc2AETgTQU2U8+Y2wqH7pwgIjKro6unVxRFGHtVOw2/bChvcz4pG+Yz0B0hR829bcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEaL3rQ5dyert+mdTnJjCIn7ClR9cyKLB6VQ9fUvkVU=;
 b=CcCL7H3VsWQmVy4VDy7z8ZA9hqsiBaqIxxCNko7YxwPG72SVGTBZr2Oe7t6xE5dyWlOGoBBsYHuGOEzPDurQ7leLZMmpzhfKVsPsVnnpDR/r+VaTwu5c94x85/RRJv0BBNxEmIyTBw1qEHwa6q+VJwFKL1C7E4vD8xpZslBJ2Qcm2lNl0Jri4lvNt/pJ9pHYqGcWmR7qwmepvuHQHiJ72are9Ky0ON4jcyhsBTPWM5t14ISGi1/BH0mvutvP6tEe2/ccBNtOkMjJgiL6U8ZDzRWGNBcEVF8a2k/PPQ9JzyumiUCPid00T/H3IOR+cClxM1QtMQ52XbOqmR1KbC5/8Q==
Received: from SJ0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:a03:33e::25)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 06:46:56 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::d1) by SJ0PR03CA0050.outlook.office365.com
 (2603:10b6:a03:33e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 06:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 06:46:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 27 Jan
 2025 22:46:49 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 27 Jan 2025 22:46:49 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 27 Jan 2025 22:46:44 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 0/2] Add support for Tegra UART Trace Controller (UTC) client
Date: Tue, 28 Jan 2025 12:16:31 +0530
Message-ID: <20250128064633.12381-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: c100732d-159f-4c03-c467-08dd3f678ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IyEwkxZtH0GZTpBE70fOCIch9KKo45opIiFWFiHiUBaKw+jiejRM6sVwnE3C?=
 =?us-ascii?Q?AYhmp2hkfV1Y7kx+F2a5i0z+z60+yJ+GPNaaYoi63fPcAdXgTPsYJb4QDKjL?=
 =?us-ascii?Q?/k3FrK61w0H/KhAtSVUDiLrCuy/5k8u4wyYQuGJoTTF374vtXhb4gYKA6yFb?=
 =?us-ascii?Q?2gEnXiyj99lsXA9APKWFDmxuzCYvQ6T339dpBVS9J8DL5grchld/2xCeHqV+?=
 =?us-ascii?Q?45+u6ZUkmpNN6fzVFvD/gKGjwaSdhnViXqMhjTKyxuunpEDlJEOb+CMPN5Th?=
 =?us-ascii?Q?29Y41NqVymkp+QpHjButs92PdAhlLfE00/26IHsmVkshXCpKt2xtpSE1AyJX?=
 =?us-ascii?Q?L6ZSCDOnHQ3XMw+tqtFJt6Rb1bhus9K//V/I6/Z3lJQoCbhSMxYOKGD0BbAj?=
 =?us-ascii?Q?oeTKL9dqECeWD/3gNvlCbSEwUmclLISIto15g1dRrmJ8t7T//yQDmzNxN1WK?=
 =?us-ascii?Q?rMEFuJNmIkCuW/slxRsJvK0V6FaX2HrfmN1KJyn6QqlmfuA6jOgNO48zQLhi?=
 =?us-ascii?Q?l+saoONrulW+ixTextbvoYZgL1kfIYWwpZQixb/TvB0gkbMFc5Jcj4Cv4AQj?=
 =?us-ascii?Q?Xx9GfLStaMSAnPN00L26CaAeapqm1avZz0PvQ2UJ3GLTCgj3SeejcFkIe8If?=
 =?us-ascii?Q?/oMGKD5O12+Ti8kyIQt9vqbv8+7TxBuK9E90iOmLMRGfW76cQf6emIqO7KK0?=
 =?us-ascii?Q?K9/zNGpeNWHViUnBwiCgeT3CANJPhgXVwIoYzofMU73NA4aU02KL2Rg4JFA6?=
 =?us-ascii?Q?OtEiuA+jXAxBC5ZOISdYvEL11WPCDTfCKrQg3mk7R5vdmHIwmX97jKktTP1V?=
 =?us-ascii?Q?wZvrbETw+qmuDHGKTkVKjDn394nLxOu9Y65MFAFcfN5lPTiKlqVPodJgkj+y?=
 =?us-ascii?Q?zIem0i1d6Cebj5RkXQhTGZQD4aWbi5Ml5mlZe6KTNkTYAKBdMlxc3vT5ye34?=
 =?us-ascii?Q?aJIwcpR79+HWD/h6RZFv32fwgZK0L4rOAhcQHKWd/hsb8prLQ27sJLH/dH93?=
 =?us-ascii?Q?BVjkPyUxVFL1GooyvqogqwIBcnwtORQKaRZt0MqEeP7tnNVJCsm0llikKHya?=
 =?us-ascii?Q?+uNsRPa8Z2IbskcHaRZ0I93qGy+ZbEeE4I/6KQOkhLNosY0UYqOOg9hWRb00?=
 =?us-ascii?Q?gzS2lWsofG6te3kIs3FZ/FkmL4z0P537/sOnQ0CFoCGbKJObuiCB+hMo/y1u?=
 =?us-ascii?Q?W9YGvh+QkDAvINSm0gSpo83HwiKWNqbcWBGVYHlJgKC/rx6MkPmLq7fHtXgb?=
 =?us-ascii?Q?4i66dZnSFCQ69OzBHO22knPC836GCQBa22BCQhucNLUzvbNoKt3uqrMotIzX?=
 =?us-ascii?Q?jaD3+rVvinpexG+XnJk+WGag8hPlDanCB3Qe7ickjraJL3njwLO9mNUnKhOJ?=
 =?us-ascii?Q?1kRQl5i0jLubTzrJrvU+dmKYddQuq+MD8Uk3gpMjob5xuNmk0QKShn5ybdI8?=
 =?us-ascii?Q?dxSPVJU9zbwRyEE1NyAXc8Zi7Fj1Zeg2/GjXjemZX+HM96vD0BPi5zcFzRxl?=
 =?us-ascii?Q?AJo20T+tHOuj6us=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 06:46:56.7770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c100732d-159f-4c03-c467-08dd3f678ee5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163

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

 .../bindings/serial/nvidia,tegra264-utc.yaml  |  83 +++
 drivers/tty/serial/Kconfig                    |  23 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/tegra-utc.c                | 641 ++++++++++++++++++
 4 files changed, 748 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
 create mode 100644 drivers/tty/serial/tegra-utc.c

-- 
2.43.0

