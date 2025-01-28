Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB131DED45;
	Tue, 28 Jan 2025 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738046831; cv=fail; b=oZcCPxy/4+gIMwk+uh9lCqswqpDtdCpH1a6vR7vDT1gFaINGlsavAMkOKq8mZkA4WDaHjRAEHiAyzQYRAfVpxk6VWmDAXTXGx3EhYxNX/p7PcT5a8YCtFcZraSe6VZCdR0m+rlexPw6VHFIFw+/ZvXNDIvoXohtu5wYoq05dCL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738046831; c=relaxed/simple;
	bh=FDvWkK0pAX3M/K0fit89rVQ+m4JMQEjw6QKAaS3ndyE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/SwCBztYJabLpZkah1LHnIokPzZ7aN6eawIzZy4B9tJusFdczEuw7LRNk39odOfdyD04uxhBPCA2S72a8Z4LW5EmRFcDKkhMeOP4UCMQ+gSu2IWsfPYX54QFS/Z7SsRTdVa8jbVG77rxFKrILvWhtTgl5WhtCJjfyyFQ3Eyc3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tQTTDC1P; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tQTTDC1P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgG0vfx/Zyx5fszzmr+F310K6ee2yVZbznXaJA2scl1aQXXx74C6yxXV7taeFW/Iyj2UV0MpBlcZaOf8byJD+L3JdKfYJY9U1v9IKJv5Uzlv9bEHcewTHoFRqTP4t8FgJyUK2fCn7sDxc1s0oOJKMqDuGzy0lNZmVPZ/qblTZCB+13rFTHO6kCkrEtBmOlnpkv2q8e9f3uSefS1me/ic+zZmntyKdM+RaqTE7VgkpfDmS4FfwVCC1p5ixxtK+r1oOaFxLMnSsRxv4zzZJPt9NgU2CNQ2G12F/x5dqvb8K8nJzwsmKRn5QzmcLFKIFA0ZQwvNbPBCd4ZsJblqU7NO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGxsOO59yMATV4oHZpZiBQH3SL8rPHhWV41cx3jS0JQ=;
 b=ZJ8QXBZrR99YykOH4+wzFnOJC+FXlUFsdXc8BP4+Be30pWyOUtwltfydGOralY3f2uoeWPCJTJ5jfoH1VKTF7NeOJ9snOR8sNPtjsCW3rbOPu8lKXi/3JdAh2KR+E0dxb9WBxDXKt2RbradKzn3C9ktiaEb7VdLB7BouDucNaMQDoo3D1TLsaT1LgkK0rltLXb7KglbhGKVPB0afSoRDSLIK5vLjWbbuNsrvUjpTpyyepdB58NEDNdCJQn3bamBUkGS5cGyG6dBR7Ci2P5OJCPlQwKVgyis5L+b1TDPLwzjnIB84VKc6wS+blKF9YI9LzXGA21NMD//FI4uW41JMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGxsOO59yMATV4oHZpZiBQH3SL8rPHhWV41cx3jS0JQ=;
 b=tQTTDC1P+bakTdiq8qbwh6Rb1CQVOdHVdxgMgFAbT1Lwwkjan+hMYwF8piJF8/qhcmOG4QRy3IM9Pu9OdG8kxDV0WjxgUHR0hOHMEtgmpztnFUoe+HJj5SD3deu6fO82QFgbU8Z1S+Xw5nXrqMAUh3AKM2s9Bd7nzzxy8y39GkCV8mRq6hqMZFCv/5ntVuM5GqqtPADo+ISmIlR5f8bsq8Jcp7OrFopCil4z59riKDmJqwraVeIr8MsxaIMDJhwrnirF/Y+cPXf+2C3DnHstO6xaeDVP20P94Kcxn3i2b5UvrFgc0UDjXSkvbjhLGas59kawyJ7vnmzSlg5BhPZa8w==
Received: from BYAPR07CA0106.namprd07.prod.outlook.com (2603:10b6:a03:12b::47)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 06:47:02 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::d6) by BYAPR07CA0106.outlook.office365.com
 (2603:10b6:a03:12b::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Tue,
 28 Jan 2025 06:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 06:47:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 27 Jan
 2025 22:47:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 27 Jan 2025 22:46:59 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 27 Jan 2025 22:46:54 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 2/2] serial: tegra-utc: Add driver for Tegra UART Trace Controller (UTC)
Date: Tue, 28 Jan 2025 12:16:33 +0530
Message-ID: <20250128064633.12381-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128064633.12381-1-kkartik@nvidia.com>
References: <20250128064633.12381-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a387a84-db57-44fb-dee5-08dd3f6791e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ws6pUNK03OQS0jTvUZcjdGMKIV/mBYoBsD5LOlBsPE85sncvxRvinEOdlgO9?=
 =?us-ascii?Q?JV4x6rwcsPhTfG9p5KmnMK5Jje1QQgOmcfz07sxYGSw4jO8v7BgIkVcn3Zww?=
 =?us-ascii?Q?A73Zeu0NYoiOGWPhndzdItsCQigU9dqMhFIWWGmYuakDOsRB6BkRJuIS8RI0?=
 =?us-ascii?Q?bLHAi5tyqVwBOR093sDJlUdWXK1kuu7XaELQGneO9Q9gfog0R94LORQohssS?=
 =?us-ascii?Q?TmO2M+GP82ReLVSO5x+YL2FrsAJGHV/3o8iHQjADAmV9N7Yu5pFBRhV5UCE3?=
 =?us-ascii?Q?eC8RrRRvu4uY6PjPtim6M+3NoRvhDkUXQf7U87cqm0wlriyqY+z4YPlyKQ39?=
 =?us-ascii?Q?gziSKKc5CKulKlLaXJdLIe33zpe3ezP/euSqdhWHxGh7JVceQKPug4pA6r1V?=
 =?us-ascii?Q?2xyJ/YAaDzLDwKI0mpd3k9P2PTVwJWJrCb6VRQqxMbx8sKSIGDlSw6gC7Gov?=
 =?us-ascii?Q?pnxTcQJiRNzR9TuFRDer5qObws0U2tguuCaU49YqvsBGgkJAApwWaVAwR5BZ?=
 =?us-ascii?Q?xXKojfi8vLfhN57dXB8f6J3Z93rZtJ/+VlHTMaGT32+59O1qaNDsuNyiybtc?=
 =?us-ascii?Q?PoKa7I0lbb7ytZOwHPT9wzAVvRNe4hDViz5dbh2jhq9hAeqeKJOWQJZCpYYM?=
 =?us-ascii?Q?vMCUD6urbdM8OWIqdGiQAB1n4nEcyuv4wzzfl+uJJrCfMTKlDiCrYMA5VHin?=
 =?us-ascii?Q?0uGqzIk4B+yjcbBjD3vt9P0z6EKn+5YOs0U3C7XiyXyPWfSJHwBVtKzNK7AQ?=
 =?us-ascii?Q?YAYN/8Pm6DW56XC5cbvrifG0zLWHQvGC6rK+1V8VB+7saQb1DeuB5NM3SYBK?=
 =?us-ascii?Q?O6NLKyowpM8vjMTqEpNIgDUb2iNXswVfkdft2EXm4ZSy2z3d0b7n+UDo0Ox/?=
 =?us-ascii?Q?+2IVIihoZAoVWkLUN0X0KyLBhEmwIy5kgu2kbiPUK9ranl//PEw52Nk3L0tE?=
 =?us-ascii?Q?QHVo960m1LQ75TzQ5HoNN4ByxkJQ/mAB7Wc1Hhx/YbuBFNk/HFt27CPef0gQ?=
 =?us-ascii?Q?mfL3plEZ4dX76yPK53zxnlryfmHr/94oGndPXLTPj028kDzNgI+1wuBZoO6G?=
 =?us-ascii?Q?ZVrlGa1dHDHSdMp1qCk7nZ5U6d1u4AN24M+MXHQXzDXyUgcC8ehhsiZsJbIQ?=
 =?us-ascii?Q?7vL0F0svgTQUNrgyx86Xo+fTBwtmRW7Tb2yjTUtCE1Hk/jWRxS1by/dv7pMZ?=
 =?us-ascii?Q?ZoNca5vgY1Z3ek7NfpQxUxZ31r68m04PECplsSEuGjqYpJuiLSuY+7RiWUyW?=
 =?us-ascii?Q?pP34elrsB0TJLR57KwL285ERqtneIqaRQM6bSQre4RIxQyOyuGmAe8lTuO0K?=
 =?us-ascii?Q?fOQNtdCP5SwhFcEamvEQJcXXlCOBrbM7Bis0N1ztUwNCOBATM/o7Rn4arNBd?=
 =?us-ascii?Q?KtvSKXVCZeCBorYK3xrAnmMpB/RYyZJVL0ujyTxnDt30LSRhyqoccD7LgiFO?=
 =?us-ascii?Q?Tp5XK1EbYJ2UA7Nf/SVpN6H7c8lKucbKdZG3tqv9h6lgzVMswr3Bx2einhh7?=
 =?us-ascii?Q?TfoMMRcqqjhPMsiwFDA8T/3s0z7zlb736gSq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 06:47:01.7977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a387a84-db57-44fb-dee5-08dd3f6791e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240

The Tegra264 SoC supports the UART Trace Controller (UTC), which allows
multiple firmware clients (up to 16) to share a single physical UART.
Each client is provided with its own interrupt and has access to a
128-character wide FIFO for both transmit (TX) and receive (RX)
operations.

Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
client.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/tty/serial/Kconfig     |  23 ++
 drivers/tty/serial/Makefile    |   1 +
 drivers/tty/serial/tegra-utc.c | 641 +++++++++++++++++++++++++++++++++
 3 files changed, 665 insertions(+)
 create mode 100644 drivers/tty/serial/tegra-utc.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 976dae3bb1bb..edc56a3c0ace 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -306,6 +306,29 @@ config SERIAL_TEGRA_TCU_CONSOLE
 
 	  If unsure, say Y.
 
+config SERIAL_TEGRA_UTC
+	tristate "NVIDIA Tegra UART Trace Controller"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	select SERIAL_CORE
+	help
+	  Support for Tegra UTC (UART Trace controller) client serial port.
+
+	  UTC is a HW based serial port that allows multiplexing multiple data
+	  streams of up to 16 UTC clients into a single hardware serial port.
+
+config SERIAL_TEGRA_UTC_CONSOLE
+	bool "Support for console on a Tegra UTC serial port"
+	depends on SERIAL_TEGRA_UTC
+	select SERIAL_CORE_CONSOLE
+	default SERIAL_TEGRA_UTC
+	help
+	  If you say Y here, it will be possible to use a Tegra UTC client as
+	  the system console (the system console is the device which receives
+	  all kernel messages and warnings and which allows logins in single
+	  user mode).
+
+	  If unsure, say Y.
+
 config SERIAL_MAX3100
 	tristate "MAX3100/3110/3111/3222 support"
 	depends on SPI
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 6ff74f0a9530..7190914ba707 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_SERIAL_STM32)		+= stm32-usart.o
 obj-$(CONFIG_SERIAL_SUNPLUS)		+= sunplus-uart.o
 obj-$(CONFIG_SERIAL_TEGRA)		+= serial-tegra.o
 obj-$(CONFIG_SERIAL_TEGRA_TCU)		+= tegra-tcu.o
+obj-$(CONFIG_SERIAL_TEGRA_UTC)		+= tegra-utc.o
 obj-$(CONFIG_SERIAL_TIMBERDALE)		+= timbuart.o
 obj-$(CONFIG_SERIAL_TXX9)		+= serial_txx9.o
 obj-$(CONFIG_SERIAL_UARTLITE)		+= uartlite.o
diff --git a/drivers/tty/serial/tegra-utc.c b/drivers/tty/serial/tegra-utc.c
new file mode 100644
index 000000000000..3d44e83f9302
--- /dev/null
+++ b/drivers/tty/serial/tegra-utc.c
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: Copyright (c) 2025 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+/*
+ * NVIDIA Tegra UTC (UART Trace Controller) driver.
+ */
+
+#include <linux/console.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+#define TEGRA_UTC_ENABLE			0x0
+#define TEGRA_UTC_ENABLE_CLIENT_ENABLE		BIT(0)
+
+#define TEGRA_UTC_FIFO_THRESHOLD		0x8
+
+#define TEGRA_UTC_COMMAND			0xc
+#define TEGRA_UTC_COMMAND_FLUSH			BIT(1)
+#define TEGRA_UTC_COMMAND_RESET			BIT(0)
+
+#define TEGRA_UTC_DATA				0x20
+
+#define TEGRA_UTC_FIFO_STATUS			0x100
+#define TEGRA_UTC_FIFO_TIMEOUT			BIT(4)
+#define TEGRA_UTC_FIFO_OVERFLOW			BIT(3)
+#define TEGRA_UTC_FIFO_REQ			BIT(2)
+#define TEGRA_UTC_FIFO_FULL			BIT(1)
+#define TEGRA_UTC_FIFO_EMPTY			BIT(0)
+
+#define TEGRA_UTC_FIFO_OCCUPANCY		0x104
+
+#define TEGRA_UTC_INTR_STATUS			0x108
+#define TEGRA_UTC_INTR_SET			0x10c
+#define TEGRA_UTC_INTR_MASK			0x110
+#define TEGRA_UTC_INTR_CLEAR			0x114
+#define TEGRA_UTC_INTR_TIMEOUT			BIT(4)
+#define TEGRA_UTC_INTR_OVERFLOW			BIT(3)
+#define TEGRA_UTC_INTR_REQ			BIT(2)
+#define TEGRA_UTC_INTR_FULL			BIT(1)
+#define TEGRA_UTC_INTR_EMPTY			BIT(0)
+
+#define UART_NR					16
+
+struct tegra_utc_soc {
+	unsigned int fifosize;
+};
+
+struct tegra_utc_port {
+	const struct tegra_utc_soc *soc;
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_UTC_CONSOLE)
+	struct console console;
+#endif
+	struct uart_port port;
+
+	void __iomem *rx_base;
+	void __iomem *tx_base;
+
+	u32 tx_irqmask;
+	u32 rx_irqmask;
+
+	u32 fifo_threshold;
+	u32 baudrate;
+	int irq;
+};
+
+static u32 tegra_utc_rx_readl(struct tegra_utc_port *tup, unsigned int offset)
+{
+	void __iomem *addr = tup->rx_base + offset;
+
+	return readl_relaxed(addr);
+}
+
+static void tegra_utc_rx_writel(struct tegra_utc_port *tup, u32 val, unsigned int offset)
+{
+	void __iomem *addr = tup->rx_base + offset;
+
+	writel_relaxed(val, addr);
+}
+
+static u32 tegra_utc_tx_readl(struct tegra_utc_port *tup, unsigned int offset)
+{
+	void __iomem *addr = tup->tx_base + offset;
+
+	return readl_relaxed(addr);
+}
+
+static void tegra_utc_tx_writel(struct tegra_utc_port *tup, u32 val, unsigned int offset)
+{
+	void __iomem *addr = tup->tx_base + offset;
+
+	writel_relaxed(val, addr);
+}
+
+static void tegra_utc_enable_tx_irq(struct tegra_utc_port *tup)
+{
+	tup->tx_irqmask = TEGRA_UTC_INTR_REQ;
+
+	tegra_utc_tx_writel(tup, tup->tx_irqmask, TEGRA_UTC_INTR_MASK);
+	tegra_utc_tx_writel(tup, tup->tx_irqmask, TEGRA_UTC_INTR_SET);
+}
+
+static void tegra_utc_disable_tx_irq(struct tegra_utc_port *tup)
+{
+	tup->tx_irqmask = 0x0;
+
+	tegra_utc_tx_writel(tup, tup->tx_irqmask, TEGRA_UTC_INTR_MASK);
+	tegra_utc_tx_writel(tup, tup->tx_irqmask, TEGRA_UTC_INTR_SET);
+}
+
+static void tegra_utc_stop_tx(struct uart_port *port)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+
+	tegra_utc_disable_tx_irq(tup);
+}
+
+static void tegra_utc_init_tx(struct tegra_utc_port *tup)
+{
+	/* Disable TX. */
+	tegra_utc_tx_writel(tup, 0x0, TEGRA_UTC_ENABLE);
+
+	/* Update the FIFO Threshold. */
+	tegra_utc_tx_writel(tup, tup->fifo_threshold, TEGRA_UTC_FIFO_THRESHOLD);
+
+	/* Clear and mask all the interrupts. */
+	tegra_utc_tx_writel(tup, TEGRA_UTC_INTR_REQ | TEGRA_UTC_INTR_FULL | TEGRA_UTC_INTR_EMPTY,
+			    TEGRA_UTC_INTR_CLEAR);
+	tegra_utc_disable_tx_irq(tup);
+
+	/* Enable TX. */
+	tegra_utc_tx_writel(tup, TEGRA_UTC_ENABLE_CLIENT_ENABLE, TEGRA_UTC_ENABLE);
+}
+
+static void tegra_utc_init_rx(struct tegra_utc_port *tup)
+{
+	tup->rx_irqmask = TEGRA_UTC_INTR_REQ | TEGRA_UTC_INTR_TIMEOUT;
+
+	tegra_utc_rx_writel(tup, TEGRA_UTC_COMMAND_RESET, TEGRA_UTC_COMMAND);
+	tegra_utc_rx_writel(tup, tup->fifo_threshold, TEGRA_UTC_FIFO_THRESHOLD);
+
+	/* Clear all the pending interrupts. */
+	tegra_utc_rx_writel(tup, TEGRA_UTC_INTR_TIMEOUT | TEGRA_UTC_INTR_OVERFLOW |
+			    TEGRA_UTC_INTR_REQ | TEGRA_UTC_INTR_FULL |
+			    TEGRA_UTC_INTR_EMPTY, TEGRA_UTC_INTR_CLEAR);
+	tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_MASK);
+	tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_SET);
+
+	/* Enable RX. */
+	tegra_utc_rx_writel(tup, TEGRA_UTC_ENABLE_CLIENT_ENABLE, TEGRA_UTC_ENABLE);
+}
+
+static bool tegra_utc_tx_char(struct tegra_utc_port *tup, u8 c)
+{
+	if (tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_FULL)
+		return false;
+
+	tegra_utc_tx_writel(tup, c, TEGRA_UTC_DATA);
+
+	return true;
+}
+
+static bool tegra_utc_tx_chars(struct tegra_utc_port *tup)
+{
+	struct tty_port *tport = &tup->port.state->port;
+	u8 c;
+
+	if (tup->port.x_char) {
+		if (!tegra_utc_tx_char(tup, tup->port.x_char))
+			return true;
+
+		tup->port.x_char = 0;
+	}
+
+	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(&tup->port)) {
+		tegra_utc_stop_tx(&tup->port);
+		return false;
+	}
+
+	while (kfifo_peek(&tport->xmit_fifo, &c)) {
+		if (!tegra_utc_tx_char(tup, c))
+			break;
+
+		kfifo_skip(&tport->xmit_fifo);
+	}
+
+	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+		uart_write_wakeup(&tup->port);
+
+	if (kfifo_is_empty(&tport->xmit_fifo)) {
+		tegra_utc_stop_tx(&tup->port);
+		return false;
+	}
+
+	return true;
+}
+
+static void tegra_utc_rx_chars(struct tegra_utc_port *tup)
+{
+	struct tty_port *port = &tup->port.state->port;
+	unsigned int max_chars = 256;
+	unsigned int flag;
+	u32 status;
+	int sysrq;
+	u32 ch;
+
+	while (--max_chars) {
+		status = tegra_utc_rx_readl(tup, TEGRA_UTC_FIFO_STATUS);
+		if (status & TEGRA_UTC_FIFO_EMPTY)
+			break;
+
+		ch = tegra_utc_rx_readl(tup, TEGRA_UTC_DATA);
+		flag = TTY_NORMAL;
+		tup->port.icount.rx++;
+
+		if (status & TEGRA_UTC_FIFO_OVERFLOW)
+			tup->port.icount.overrun++;
+
+		uart_port_unlock(&tup->port);
+		sysrq = uart_handle_sysrq_char(&tup->port, ch & 0xff);
+		uart_port_lock(&tup->port);
+
+		if (!sysrq)
+			tty_insert_flip_char(port, ch, flag);
+	}
+
+	tty_flip_buffer_push(port);
+}
+
+static irqreturn_t tegra_utc_isr(int irq, void *dev_id)
+{
+	struct tegra_utc_port *tup = dev_id;
+	unsigned long flags;
+	u32 status;
+
+	uart_port_lock_irqsave(&tup->port, &flags);
+
+	/* Process RX_REQ and RX_TIMEOUT interrupts. */
+	do {
+		status = tegra_utc_rx_readl(tup, TEGRA_UTC_INTR_STATUS) & tup->rx_irqmask;
+		if (status) {
+			tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_CLEAR);
+			tegra_utc_rx_chars(tup);
+		}
+	} while (status);
+
+	/* Process TX_REQ interrupt. */
+	do {
+		status = tegra_utc_tx_readl(tup, TEGRA_UTC_INTR_STATUS) & tup->tx_irqmask;
+		if (status) {
+			tegra_utc_tx_writel(tup, tup->tx_irqmask, TEGRA_UTC_INTR_CLEAR);
+			tegra_utc_tx_chars(tup);
+		}
+	} while (status);
+
+	uart_port_unlock_irqrestore(&tup->port, flags);
+
+	return IRQ_HANDLED;
+}
+
+static unsigned int tegra_utc_tx_empty(struct uart_port *port)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+
+	return tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_OCCUPANCY) ? 0 : TIOCSER_TEMT;
+}
+
+static void tegra_utc_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+}
+
+static unsigned int tegra_utc_get_mctrl(struct uart_port *port)
+{
+	return 0;
+}
+
+static void tegra_utc_start_tx(struct uart_port *port)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+
+	if (tegra_utc_tx_chars(tup))
+		tegra_utc_enable_tx_irq(tup);
+}
+
+static void tegra_utc_stop_rx(struct uart_port *port)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+
+	tup->rx_irqmask = 0x0;
+	tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_MASK);
+	tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_SET);
+}
+
+static void tegra_utc_hw_init(struct tegra_utc_port *tup)
+{
+	tegra_utc_init_tx(tup);
+	tegra_utc_init_rx(tup);
+}
+
+static int tegra_utc_startup(struct uart_port *port)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+	int ret;
+
+	tegra_utc_hw_init(tup);
+
+	ret = request_irq(tup->irq, tegra_utc_isr, 0, dev_name(port->dev), tup);
+	if (ret < 0) {
+		dev_err(port->dev, "failed to register interrupt handler\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void tegra_utc_shutdown(struct uart_port *port)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+
+	tegra_utc_rx_writel(tup, 0x0, TEGRA_UTC_ENABLE);
+	free_irq(tup->irq, tup);
+}
+
+static void tegra_utc_set_termios(struct uart_port *port, struct ktermios *termios,
+				  const struct ktermios *old)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+	unsigned long flags;
+
+	tty_termios_encode_baud_rate(termios, tup->baudrate, tup->baudrate);
+	termios->c_cflag &= ~(CSIZE | CSTOPB | PARENB | PARODD);
+	termios->c_cflag &= ~(CMSPAR | CRTSCTS);
+	termios->c_cflag |= CS8 | CLOCAL;
+
+	uart_port_lock_irqsave(port, &flags);
+	uart_update_timeout(port, CS8, tup->baudrate);
+	uart_port_unlock_irqrestore(port, flags);
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+
+static int tegra_utc_poll_init(struct uart_port *port)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+
+	tegra_utc_hw_init(tup);
+	return 0;
+}
+
+static int tegra_utc_get_poll_char(struct uart_port *port)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+
+	while (tegra_utc_rx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_EMPTY)
+		cpu_relax();
+
+	return tegra_utc_rx_readl(tup, TEGRA_UTC_DATA);
+}
+
+static void tegra_utc_put_poll_char(struct uart_port *port, unsigned char ch)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+
+	while (tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_FULL)
+		cpu_relax();
+
+	tegra_utc_tx_writel(tup, ch, TEGRA_UTC_DATA);
+}
+
+#endif
+
+static const struct uart_ops tegra_utc_uart_ops = {
+	.tx_empty = tegra_utc_tx_empty,
+	.set_mctrl = tegra_utc_set_mctrl,
+	.get_mctrl = tegra_utc_get_mctrl,
+	.stop_tx = tegra_utc_stop_tx,
+	.start_tx = tegra_utc_start_tx,
+	.stop_rx = tegra_utc_stop_rx,
+	.startup = tegra_utc_startup,
+	.shutdown = tegra_utc_shutdown,
+	.set_termios = tegra_utc_set_termios,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init = tegra_utc_poll_init,
+	.poll_get_char = tegra_utc_get_poll_char,
+	.poll_put_char = tegra_utc_put_poll_char,
+#endif
+};
+
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_UTC_CONSOLE)
+#define TEGRA_UTC_DEFAULT_FIFO_THRESHOLD	0x4
+#define TEGRA_UTC_EARLYCON_MAX_BURST_SIZE	128
+
+static void tegra_utc_putc(struct uart_port *port, unsigned char c)
+{
+	writel(c, port->membase + TEGRA_UTC_DATA);
+}
+
+static void tegra_utc_early_write(struct console *con, const char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	while (n) {
+		u32 burst_size = TEGRA_UTC_EARLYCON_MAX_BURST_SIZE;
+
+		burst_size -= readl(dev->port.membase + TEGRA_UTC_FIFO_OCCUPANCY);
+		if (n < burst_size)
+			burst_size = n;
+
+		uart_console_write(&dev->port, s, burst_size, tegra_utc_putc);
+
+		n -= burst_size;
+		s += burst_size;
+	}
+}
+
+static int __init tegra_utc_early_console_setup(struct earlycon_device *device, const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	/* Configure TX */
+	writel(TEGRA_UTC_COMMAND_FLUSH | TEGRA_UTC_COMMAND_RESET,
+		device->port.membase + TEGRA_UTC_COMMAND);
+	writel(TEGRA_UTC_DEFAULT_FIFO_THRESHOLD, device->port.membase + TEGRA_UTC_FIFO_THRESHOLD);
+
+	/* Clear and mask all the interrupts. */
+	writel(TEGRA_UTC_INTR_REQ | TEGRA_UTC_INTR_FULL | TEGRA_UTC_INTR_EMPTY,
+		device->port.membase + TEGRA_UTC_INTR_CLEAR);
+
+	writel(0x0, device->port.membase + TEGRA_UTC_INTR_MASK);
+	writel(0x0, device->port.membase + TEGRA_UTC_INTR_SET);
+
+	/* Enable TX. */
+	writel(TEGRA_UTC_ENABLE_CLIENT_ENABLE, device->port.membase + TEGRA_UTC_ENABLE);
+
+	device->con->write = tegra_utc_early_write;
+
+	return 0;
+}
+OF_EARLYCON_DECLARE(tegra_utc, "nvidia,tegra264-utc", tegra_utc_early_console_setup);
+
+static void tegra_utc_console_putchar(struct uart_port *port, unsigned char ch)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+
+	tegra_utc_tx_writel(tup, ch, TEGRA_UTC_DATA);
+}
+
+static void tegra_utc_console_write(struct console *cons, const char *s, unsigned int count)
+{
+	struct tegra_utc_port *tup = container_of(cons, struct tegra_utc_port, console);
+	unsigned long flags;
+	int locked = 1;
+
+	if (tup->port.sysrq || oops_in_progress)
+		locked = uart_port_trylock_irqsave(&tup->port, &flags);
+	else
+		uart_port_lock_irqsave(&tup->port, &flags);
+
+	while (count) {
+		u32 burst_size = tup->soc->fifosize;
+
+		burst_size -= tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_OCCUPANCY);
+		if (count < burst_size)
+			burst_size = count;
+
+		uart_console_write(&tup->port, s, burst_size, tegra_utc_console_putchar);
+
+		count -= burst_size;
+		s += burst_size;
+	};
+
+	if (locked)
+		uart_port_unlock_irqrestore(&tup->port, flags);
+}
+
+static int tegra_utc_console_setup(struct console *cons, char *options)
+{
+	struct tegra_utc_port *tup = container_of(cons, struct tegra_utc_port, console);
+
+	tegra_utc_init_tx(tup);
+
+	return 0;
+}
+#endif
+
+static struct uart_driver tegra_utc_driver = {
+	.driver_name	= "tegra-utc",
+	.dev_name	= "ttyUTC",
+	.nr		= UART_NR
+};
+
+static void tegra_utc_setup_port(struct device *dev, struct tegra_utc_port *tup,
+				 unsigned int index)
+{
+	tup->port.dev		= dev;
+	tup->port.fifosize	= tup->soc->fifosize;
+	tup->port.flags		= UPF_BOOT_AUTOCONF;
+	tup->port.iotype	= UPIO_MEM;
+	tup->port.ops		= &tegra_utc_uart_ops;
+	tup->port.type		= PORT_TEGRA_TCU;
+	tup->port.line		= index;
+	tup->port.private_data	= tup;
+
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_UTC_CONSOLE)
+	strscpy(tup->console.name, "ttyUTC", sizeof(tup->console.name));
+	tup->console.write	= tegra_utc_console_write;
+	tup->console.device	= uart_console_device;
+	tup->console.setup	= tegra_utc_console_setup;
+	tup->console.flags	= CON_PRINTBUFFER | CON_CONSDEV | CON_ANYTIME;
+	tup->console.data	= &tegra_utc_driver;
+#endif
+}
+
+static int tegra_utc_register_port(struct tegra_utc_port *tup)
+{
+	int ret;
+
+	ret = uart_add_one_port(&tegra_utc_driver, &tup->port);
+	if (ret)
+		return ret;
+
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_UTC_CONSOLE)
+	register_console(&tup->console);
+#endif
+
+	return 0;
+}
+
+static int tegra_utc_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct tegra_utc_port *tup;
+	int index;
+	int ret;
+
+	index = of_alias_get_id(np, "serial");
+	if (index < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, err %d\n", index);
+		return index;
+	}
+
+	tup = devm_kzalloc(&pdev->dev, sizeof(struct tegra_utc_port), GFP_KERNEL);
+	if (!tup)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(np, "current-speed", &tup->baudrate);
+	if (ret) {
+		dev_err(&pdev->dev, "missing current-speed device-tree property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "nvidia,utc-fifo-threshold", &tup->fifo_threshold);
+	if (ret) {
+		dev_err(&pdev->dev, "missing nvidia,fifo-threshold device-tree property\n");
+		return ret;
+	}
+
+	tup->irq = platform_get_irq(pdev, 0);
+	if (tup->irq < 0) {
+		dev_err(&pdev->dev, "failed to get interrupt\n");
+		return tup->irq;
+	}
+
+	tup->soc = of_device_get_match_data(&pdev->dev);
+
+	tup->tx_base = devm_platform_ioremap_resource_byname(pdev, "tx");
+	if (IS_ERR(tup->tx_base))
+		return PTR_ERR(tup->tx_base);
+
+	tup->rx_base = devm_platform_ioremap_resource_byname(pdev, "rx");
+	if (IS_ERR(tup->rx_base))
+		return PTR_ERR(tup->rx_base);
+
+	tegra_utc_setup_port(&pdev->dev, tup, index);
+	platform_set_drvdata(pdev, tup);
+
+	return tegra_utc_register_port(tup);
+}
+
+static void tegra_utc_remove(struct platform_device *pdev)
+{
+	struct tegra_utc_port *tup = platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&tegra_utc_driver, &tup->port);
+}
+
+static const struct tegra_utc_soc tegra264_utc_soc = {
+	.fifosize = 128,
+};
+
+static const struct of_device_id tegra_utc_of_match[] = {
+	{ .compatible = "nvidia,tegra264-utc", .data = &tegra264_utc_soc },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tegra_utc_of_match);
+
+static struct platform_driver tegra_utc_platform_driver = {
+	.probe = tegra_utc_probe,
+	.remove = tegra_utc_remove,
+	.driver = {
+		.name = "tegra-utc",
+		.of_match_table = tegra_utc_of_match,
+	},
+};
+
+static int __init tegra_utc_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&tegra_utc_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&tegra_utc_platform_driver);
+	if (ret) {
+		uart_unregister_driver(&tegra_utc_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(tegra_utc_init);
+
+static void __exit tegra_utc_exit(void)
+{
+	platform_driver_unregister(&tegra_utc_platform_driver);
+	uart_unregister_driver(&tegra_utc_driver);
+}
+module_exit(tegra_utc_exit);
+
+MODULE_AUTHOR("Kartik Rajput <kkartik@nvidia.com>");
+MODULE_DESCRIPTION("Tegra UART Trace Controller");
+MODULE_LICENSE("GPL");
-- 
2.43.0

