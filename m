Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97822172C;
	Thu, 13 Feb 2025 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450941; cv=fail; b=DDHWQixgaADJ6CfjikYXpPEyblQK6h9xJy4xmfGvnhqUBWBZIw++2mBCyn0e2gkuaiIIbH2JV6Ec8w2N23eGiBur0KbswR0iQlg9hRiTNYBnUV2PeFqw+s482RqiEkitF0eKZphwbgEBu+snXvVbmJ2iwWtNLYes/fvIy+HrtQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450941; c=relaxed/simple;
	bh=Wq6tE/hpHpiaBqRmJS8UeeaSpOfO4FlNb+99lNO90dU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLCJR8VbxpxxD4es0tT+bzNAzfhbvcV4Scj5veXYtNixoWEJ17MsMxslKUdBgV4i6t7A4McoS+tMS1ghszIiB+zqWB/9pGtwMAmCFKDxwGFWn12PILo5gCpcY5Xl4MSDRLqQkiHnXICEJwc578XMPfTkqhfkaByx7GKz/dRpt04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EDVpbnaV; arc=fail smtp.client-ip=40.107.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EDVpbnaV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL/p3DezZZ45cE4DJxb86m/GOyLvhnrs1l9OLCvHHU8oPCoCivOk+fsmF2tE0e9yT421UA4ECzDH5Mu7D4GAOL8prKjyIIhCYkl1nE1gvlXIKInowT4VqngbGcFlrlEhHa/MbEKzZfIa5k8jDVnMlmQ6UJ0rlsOoxSx/XGKSBZyM1SBCr5dLl6OofoPxsaqHW9ceUa06wcNfNixa/jot57DHUvM5q0ZKqJqyVDIZ7ZWbUvBk5VH3RoK/2LuA/yURZhY+ZfzW6NmS30GB9t2q89jk8m/YmQv4ZW86y/oLqteEsj2coSCF2OZLiUqFcK54mvSbm34WpJy/Dgu4u4SDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V552+K0Y0vIj866al3xBFuiEhO50YGEEjZEZjnusXTg=;
 b=EtP+EUqlfrOWwi13czWCO2io3ZaMIpaa/bBeDLxgnQfj9rxhka4bZeESEFRlSqUh27B2XIpi3CACNpK5TcQFN7MleFPUD2Fpy601sd9lz/L4BKJvNvtIUfJOreFccu85RVlcz5LVsJ5erHCJdvip9lFAZl3wGDAQZy+EWdSTpZ2iNFI4JUHQPd5wxqJCeMaiB2P8/7+FbI2Ni7bef/vams8YGQKCQrZ9N75ui+vgoYmaPd+CXJKNB8FmHOAi/FDdzQO4Foi88R1RD8Dv1veH47nys83TJfKoVfUlHK1DZCvgn7kKveCAk2Qprmnbii+LaqAdS0sBpn8UfHtdZVzf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V552+K0Y0vIj866al3xBFuiEhO50YGEEjZEZjnusXTg=;
 b=EDVpbnaVkxt4QTzhtyUgbDjeCDDbKl5SsYBXasB7ZVh7FIb9sJfV1Fu07DyRVoeGZNsJ7YY8HnHYvsotGm9zQZCOfCzRSaWTA6RxR2GqJTkA1ma/ll7vd0sIXwPFLPTnjekGtfxjFTMyDwAPnILQPGpHHG4iqL9UokrSfzTdR16z6vfbDMdEON4tE+7eWEHKLasfoLIIDskrAhgC08nOv79OoGokFIqmMAlDRlwcRr4kUMuB+9NW09BE+RsBDkvUjV8pTarzBq5dLZAzLcAx+xF46hedSofA1+Z0A8AKf0q/zRX4VsX779Q7Z/Fk6/ZZMdwzv6Wqsz2xMDuQZfmMuQ==
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 12:48:51 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::d5) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Thu,
 13 Feb 2025 12:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 12:48:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 04:48:38 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 04:48:38 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 04:48:33 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v5 2/2] serial: tegra-utc: Add driver for Tegra UART Trace Controller (UTC)
Date: Thu, 13 Feb 2025 18:18:05 +0530
Message-ID: <20250213124805.2588-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213124805.2588-1-kkartik@nvidia.com>
References: <20250213124805.2588-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 4966420c-28bd-477c-bed4-08dd4c2cc460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h6mz3Cetqm9jha/yrfBLsXJt8oxv44KKrFOxlIwg90tqavgq7VGQHx9rnhUU?=
 =?us-ascii?Q?fX5DwK4yqhl0RCCyo5QZGoiUD6c0kcefYdiLRb1I/CKnMUpBjE0jPVECwV7Z?=
 =?us-ascii?Q?0kC04uz+gH8i02Iiw50uXBi7uRd5UWnCgtrCyAPZFC+da0KE/ytVF3+nHH6s?=
 =?us-ascii?Q?WNc0QExUzSmTv+o2AuIOVRHwfXTmKXDpDF4z5d77b9TMIfMSpRNhRQOM2E4f?=
 =?us-ascii?Q?v7AqTKm24K5Bdk60maLDhTzBX0+v7TGYcHnmT/bmqBmrO4E91PfCD9ksj6q5?=
 =?us-ascii?Q?cKRSZWA1eqykXbZOy6hRJbjut7LNJBN1zMru5sWm76JOiio2Gv4x5rLGhVTi?=
 =?us-ascii?Q?zbh9qaO+vgq0RAcHSgSo5d28O62S2gXA4vCxPUT6Av1nJxihEM9P+Gl4CemQ?=
 =?us-ascii?Q?DPL+uUEBpsRO6KokhOj8CURk6EU4fzUZ2fMS/0TRufHEA2U1qyLJqEo0SAjY?=
 =?us-ascii?Q?xwLdoEmE7U2nS3Qs4Eyf0iSI0CbrS2TrMw+jXCg6ok7utYvNuy4LjcuJAmeY?=
 =?us-ascii?Q?dklff77Skmmu6MMfGo+oXTh+kJmO0nwlwSGW0dFPf+viAOAeh60BHsNmUata?=
 =?us-ascii?Q?lSNhDLxKShx6RHjMrFy1xAqCj5lYdKB81PFifG4ktW3NWwn1mYts8Ft/8OdX?=
 =?us-ascii?Q?Y9OVND579UEHrCMyy5z7DVfqQ5ld4da0zxyAGtScXEjDmQovIVo5PKyjB+EH?=
 =?us-ascii?Q?aubrW7l3hMG5NtrgliMvToSlZTuMzgLAxyTE1yWK5R3+Zi//G6lkoI4PuR0d?=
 =?us-ascii?Q?So/LzLKO2twiTFiu43LVx+oG4zly3ouJEaDuxbSF8gOv3yEu+oLFxWKfn/fy?=
 =?us-ascii?Q?p801DWGU37ZqksPvbxxJfUGVNDlUQ/cS+MEPSmoMT2/Q4QJ5ifG3nhtJRQIQ?=
 =?us-ascii?Q?KcBch4UYct8Z0MVhVrAFHSTv4IerAEZNLSnWWiK0xHqM6ZMIQsLQnP3oPUnP?=
 =?us-ascii?Q?qf8xOapMP+PCJYRLe8rP6AmR1irNjZ3pEd6TvFwGYBAv7c2sbkvWNwT6w6FL?=
 =?us-ascii?Q?6yMyydgThqkGLeNsn0PgtcWOBuj4ne4ce32U2JB1/jc8U4DU9thmLsAhtoy3?=
 =?us-ascii?Q?haL7pJgpzN3xtGZBGoZyio/FQK1zzivvPX36IoMb+G43Z8vBK52+LtQ/Ouir?=
 =?us-ascii?Q?y/v/q6VMtfWaqr1FmyYJVwkscE/20isJKoQqqssRN5mCp3doWLsIjFfAVGk+?=
 =?us-ascii?Q?YaKWQYkHHGhhw25MvpMTR5R7Dznb+SWCF8i5mLqStgv/SEFsWIyGtGFG+9Lk?=
 =?us-ascii?Q?MDKsavvwz5CwqssHdstNMD/jy8AmoCq9QNjEg1NstGNPRNu+jhsx7xc7Svq7?=
 =?us-ascii?Q?jAJm/b7CHvhnrOMVBQMkB7qHBwqMSienWGXFZU7kO/Uucp98PlsAUa05BR3j?=
 =?us-ascii?Q?0u5I49Rq1vyY+xep37xZDL6GRxCiveLRP6vTxnQ7tHIUyhnbvrWtq8+iLaA8?=
 =?us-ascii?Q?ifpdCSRkryWpgoHhODgTHo2UQ5qiWqKeEcPUhhTY/bwqmgJan6A9gs8pbPKj?=
 =?us-ascii?Q?O3sJpqUWu9mkXcziVeuv1X15Npt6cF6iGhlQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:48:51.1393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4966420c-28bd-477c-bed4-08dd4c2cc460
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814

The Tegra264 SoC supports the UART Trace Controller (UTC), which allows
multiple firmware clients (up to 16) to share a single physical UART.
Each client is provided with its own interrupt and has access to a
128-character wide FIFO for both transmit (TX) and receive (RX)
operations.

Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
client.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
v4 -> v5:
	* Use fixed width values for the register offsets.
	* Use decimal value for `TEGRA_UTC_DEFAULT_FIFO_THRESHOLD`.
	* Replace instance of `&pdev->dev` with `dev` in
	  `tegra_utc_probe()`.
v3 -> v4:
	* Cleaned up included header files.
	* Guard `unregister_console()` with
	  `CONFIG_SERIAL_TEGRA_UTC_CONSOLE` macro.
	* Remove unused variable `val` from `tegra_utc_get_poll_char()`.
	* Define `TEGRA_UTC_INTR_COMMON` for the common interrupts
	  between TX and RX clients.
	* Improve error messages in `tegra_utc_probe()`.
	* Minor code clean up.
v2 -> v3:
	* Update included header files.
	* Remove `struct tegra_utc_soc` and move fifosize to `struct
	  tegra_utc_port`.
	* Remove `irq` from `struct tegra_utc_port` and use
	  uart_port::irq instead.
	* Update `tegra_utc_tx_chars` to use `uart_port_tx` API
	  instead.
	* Remove `flag` variable from `tegra_utc_rx_chars()` as it was
	  not really required.
	* Removed mask for `ch` in `tegra_utc_rx_chars()` as both
	  `uart_handle_sysrq_char()` and `tty_insert_flip_char()` takes
	  u8 value.
	* Update `tegra_utc_isr()` to return IRQ_HANDLED only when it
	  actually handles the interrupt.
	* Use uart_port_lock/unlock APIs in `tegra_utc_isr()` instead of
	  using irqsave/irqrestore counterparts.
	* Update `tegra_utc_get_poll_char()` logic to return NO_POLL_CHAR
	  if FIFO is empty.
	* Use `read_poll_timeout_atomic()` in `tegra_utc_put_poll_char()`
	  to avoid stall.
	* Introduce write_atomic/thread console APIs to make the driver
	  CON_NBCON compatible.
	* Unregister the console in `tegra_utc_remove()`.
	* Use `max_chars--` instead of `--max_chars` in
	  `tegra_utc_rx_chars()`.
	* Improve error handling logic of `tegra_utc_startup()` if
	  `request_irq()` fails.
	* Add trailing comma in tegra_utc_driver.
	* Propagate error if `uart_read_port_properties()` fails.
	* replace of_* APIs with device_* APIs.
v1 -> v2:
	* Use dev_err_probe() in tegra_utc_probe().
	* Use uart_read_port_properties() instead of manually parsing
	  the port line.
	* Remove duplicate error prints if platform_get_irq() fails.
	* In tegra_utc_of_match, remove `,` after terminator line.
	* Remove current-speed, as it is not always accurate.
---
 drivers/tty/serial/Kconfig     |  23 ++
 drivers/tty/serial/Makefile    |   1 +
 drivers/tty/serial/tegra-utc.c | 625 +++++++++++++++++++++++++++++++++
 3 files changed, 649 insertions(+)
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
index 000000000000..34dc34f25083
--- /dev/null
+++ b/drivers/tty/serial/tegra-utc.c
@@ -0,0 +1,625 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: Copyright (c) 2025 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+// NVIDIA Tegra UTC (UART Trace Controller) driver.
+
+#include <linux/bits.h>
+#include <linux/console.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/kfifo.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/types.h>
+
+#define TEGRA_UTC_ENABLE			0x0
+#define TEGRA_UTC_ENABLE_CLIENT_ENABLE		BIT(0)
+
+#define TEGRA_UTC_FIFO_THRESHOLD		0x8
+
+#define TEGRA_UTC_COMMAND			0xc
+#define TEGRA_UTC_COMMAND_RESET			BIT(0)
+#define TEGRA_UTC_COMMAND_FLUSH			BIT(1)
+
+#define TEGRA_UTC_DATA				0x20
+
+#define TEGRA_UTC_FIFO_STATUS			0x100
+#define TEGRA_UTC_FIFO_EMPTY			BIT(0)
+#define TEGRA_UTC_FIFO_FULL			BIT(1)
+#define TEGRA_UTC_FIFO_REQ			BIT(2)
+#define TEGRA_UTC_FIFO_OVERFLOW			BIT(3)
+#define TEGRA_UTC_FIFO_TIMEOUT			BIT(4)
+
+#define TEGRA_UTC_FIFO_OCCUPANCY		0x104
+
+#define TEGRA_UTC_INTR_STATUS			0x108
+#define TEGRA_UTC_INTR_SET			0x10c
+#define TEGRA_UTC_INTR_MASK			0x110
+#define TEGRA_UTC_INTR_CLEAR			0x114
+#define TEGRA_UTC_INTR_EMPTY			BIT(0)
+#define TEGRA_UTC_INTR_FULL			BIT(1)
+#define TEGRA_UTC_INTR_REQ			BIT(2)
+#define TEGRA_UTC_INTR_OVERFLOW			BIT(3)
+#define TEGRA_UTC_INTR_TIMEOUT			BIT(4)
+
+#define TEGRA_UTC_UART_NR			16
+
+#define TEGRA_UTC_INTR_COMMON	(TEGRA_UTC_INTR_REQ | TEGRA_UTC_INTR_FULL | TEGRA_UTC_INTR_EMPTY)
+
+struct tegra_utc_port {
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
+	unsigned int fifosize;
+	u32 tx_threshold;
+	u32 rx_threshold;
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
+	tegra_utc_tx_writel(tup, tup->tx_threshold, TEGRA_UTC_FIFO_THRESHOLD);
+
+	/* Clear and mask all the interrupts. */
+	tegra_utc_tx_writel(tup, TEGRA_UTC_INTR_COMMON, TEGRA_UTC_INTR_CLEAR);
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
+	tegra_utc_rx_writel(tup, tup->rx_threshold, TEGRA_UTC_FIFO_THRESHOLD);
+
+	/* Clear all the pending interrupts. */
+	tegra_utc_rx_writel(tup, TEGRA_UTC_INTR_TIMEOUT | TEGRA_UTC_INTR_OVERFLOW |
+			    TEGRA_UTC_INTR_COMMON, TEGRA_UTC_INTR_CLEAR);
+	tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_MASK);
+	tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_SET);
+
+	/* Enable RX. */
+	tegra_utc_rx_writel(tup, TEGRA_UTC_ENABLE_CLIENT_ENABLE, TEGRA_UTC_ENABLE);
+}
+
+static bool tegra_utc_tx_chars(struct tegra_utc_port *tup)
+{
+	struct uart_port *port = &tup->port;
+	unsigned int pending;
+	u8 c;
+
+	pending = uart_port_tx(port, c,
+		     !(tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_FULL),
+		     tegra_utc_tx_writel(tup, c, TEGRA_UTC_DATA));
+
+	return pending;
+}
+
+static void tegra_utc_rx_chars(struct tegra_utc_port *tup)
+{
+	struct tty_port *port = &tup->port.state->port;
+	unsigned int max_chars = 256;
+	u32 status;
+	int sysrq;
+	u32 ch;
+
+	while (max_chars--) {
+		status = tegra_utc_rx_readl(tup, TEGRA_UTC_FIFO_STATUS);
+		if (status & TEGRA_UTC_FIFO_EMPTY)
+			break;
+
+		ch = tegra_utc_rx_readl(tup, TEGRA_UTC_DATA);
+		tup->port.icount.rx++;
+
+		if (status & TEGRA_UTC_FIFO_OVERFLOW)
+			tup->port.icount.overrun++;
+
+		uart_port_unlock(&tup->port);
+		sysrq = uart_handle_sysrq_char(&tup->port, ch);
+		uart_port_lock(&tup->port);
+
+		if (!sysrq)
+			tty_insert_flip_char(port, ch, TTY_NORMAL);
+	}
+
+	tty_flip_buffer_push(port);
+}
+
+static irqreturn_t tegra_utc_isr(int irq, void *dev_id)
+{
+	struct tegra_utc_port *tup = dev_id;
+	unsigned int handled = 0;
+	u32 status;
+
+	uart_port_lock(&tup->port);
+
+	/* Process RX_REQ and RX_TIMEOUT interrupts. */
+	do {
+		status = tegra_utc_rx_readl(tup, TEGRA_UTC_INTR_STATUS) & tup->rx_irqmask;
+		if (status) {
+			tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_CLEAR);
+			tegra_utc_rx_chars(tup);
+			handled = 1;
+		}
+	} while (status);
+
+	/* Process TX_REQ interrupt. */
+	do {
+		status = tegra_utc_tx_readl(tup, TEGRA_UTC_INTR_STATUS) & tup->tx_irqmask;
+		if (status) {
+			tegra_utc_tx_writel(tup, tup->tx_irqmask, TEGRA_UTC_INTR_CLEAR);
+			tegra_utc_tx_chars(tup);
+			handled = 1;
+		}
+	} while (status);
+
+	uart_port_unlock(&tup->port);
+
+	return IRQ_RETVAL(handled);
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
+	/* Interrupt is dedicated to this UTC client. */
+	ret = request_irq(port->irq, tegra_utc_isr, 0, dev_name(port->dev), tup);
+	if (ret < 0)
+		dev_err(port->dev, "failed to register interrupt handler\n");
+
+	return ret;
+}
+
+static void tegra_utc_shutdown(struct uart_port *port)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+
+	tegra_utc_rx_writel(tup, 0x0, TEGRA_UTC_ENABLE);
+	free_irq(port->irq, tup);
+}
+
+static void tegra_utc_set_termios(struct uart_port *port, struct ktermios *termios,
+				  const struct ktermios *old)
+{
+	/* The Tegra UTC clients supports only 8-N-1 configuration without HW flow control */
+	termios->c_cflag &= ~(CSIZE | CSTOPB | PARENB | PARODD);
+	termios->c_cflag &= ~(CMSPAR | CRTSCTS);
+	termios->c_cflag |= CS8 | CLOCAL;
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
+	if (tegra_utc_rx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_EMPTY)
+		return NO_POLL_CHAR;
+
+	return tegra_utc_rx_readl(tup, TEGRA_UTC_DATA);
+}
+
+static void tegra_utc_put_poll_char(struct uart_port *port, unsigned char ch)
+{
+	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
+	u32 val;
+
+	read_poll_timeout_atomic(tegra_utc_tx_readl, val, !(val & TEGRA_UTC_FIFO_FULL),
+				 0, USEC_PER_SEC, false, tup, TEGRA_UTC_FIFO_STATUS);
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
+	writel(TEGRA_UTC_INTR_COMMON, device->port.membase + TEGRA_UTC_INTR_CLEAR);
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
+static void tegra_utc_console_write_atomic(struct console *cons, struct nbcon_write_context *wctxt)
+{
+	struct tegra_utc_port *tup = container_of(cons, struct tegra_utc_port, console);
+	unsigned int len;
+	char *outbuf;
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
+
+	outbuf = wctxt->outbuf;
+	len = wctxt->len;
+
+	while (len) {
+		u32 burst_size = tup->fifosize;
+
+		burst_size -= tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_OCCUPANCY);
+		if (len < burst_size)
+			burst_size = len;
+
+		uart_console_write(&tup->port, outbuf, burst_size, tegra_utc_console_putchar);
+
+		outbuf += burst_size;
+		len -= burst_size;
+	};
+
+	nbcon_exit_unsafe(wctxt);
+}
+
+static void tegra_utc_console_write_thread(struct console *cons, struct nbcon_write_context *wctxt)
+{
+	struct tegra_utc_port *tup = container_of(cons, struct tegra_utc_port, console);
+	unsigned int len = READ_ONCE(wctxt->len);
+	unsigned int i;
+	u32 val;
+
+	for (i = 0; i < len; i++) {
+		if (!nbcon_enter_unsafe(wctxt))
+			break;
+
+		read_poll_timeout_atomic(tegra_utc_tx_readl, val, !(val & TEGRA_UTC_FIFO_FULL),
+					 0, USEC_PER_SEC, false, tup, TEGRA_UTC_FIFO_STATUS);
+		uart_console_write(&tup->port, wctxt->outbuf + i, 1, tegra_utc_console_putchar);
+
+		if (!nbcon_exit_unsafe(wctxt))
+			break;
+	}
+}
+
+static void tegra_utc_console_device_lock(struct console *cons, unsigned long *flags)
+{
+	struct tegra_utc_port *tup = container_of(cons, struct tegra_utc_port, console);
+	struct uart_port *port = &tup->port;
+
+	__uart_port_lock_irqsave(port, flags);
+}
+
+static void tegra_utc_console_device_unlock(struct console *cons, unsigned long flags)
+{
+	struct tegra_utc_port *tup = container_of(cons, struct tegra_utc_port, console);
+	struct uart_port *port = &tup->port;
+
+	__uart_port_unlock_irqrestore(port, flags);
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
+	.nr		= TEGRA_UTC_UART_NR,
+};
+
+static int tegra_utc_setup_port(struct device *dev, struct tegra_utc_port *tup)
+{
+	tup->port.dev			= dev;
+	tup->port.fifosize		= tup->fifosize;
+	tup->port.flags			= UPF_BOOT_AUTOCONF;
+	tup->port.iotype		= UPIO_MEM;
+	tup->port.ops			= &tegra_utc_uart_ops;
+	tup->port.type			= PORT_TEGRA_TCU;
+	tup->port.private_data		= tup;
+
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_UTC_CONSOLE)
+	strscpy(tup->console.name, "ttyUTC", sizeof(tup->console.name));
+	tup->console.write_atomic	= tegra_utc_console_write_atomic;
+	tup->console.write_thread	= tegra_utc_console_write_thread;
+	tup->console.device_lock	= tegra_utc_console_device_lock;
+	tup->console.device_unlock	= tegra_utc_console_device_unlock;
+	tup->console.device		= uart_console_device;
+	tup->console.setup		= tegra_utc_console_setup;
+	tup->console.flags		= CON_PRINTBUFFER | CON_NBCON;
+	tup->console.data		= &tegra_utc_driver;
+#endif
+
+	return uart_read_port_properties(&tup->port);
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
+	const unsigned int *soc_fifosize;
+	struct device *dev = &pdev->dev;
+	struct tegra_utc_port *tup;
+	int ret;
+
+	tup = devm_kzalloc(&pdev->dev, sizeof(*tup), GFP_KERNEL);
+	if (!tup)
+		return -ENOMEM;
+
+	ret = device_property_read_u32(dev, "tx-threshold", &tup->tx_threshold);
+	if (ret)
+		return dev_err_probe(dev, ret, "missing %s property\n", "tx-threshold");
+
+	ret = device_property_read_u32(dev, "rx-threshold", &tup->rx_threshold);
+	if (ret)
+		return dev_err_probe(dev, ret, "missing %s property\n", "rx-threshold");
+
+	soc_fifosize = device_get_match_data(&pdev->dev);
+	tup->fifosize = *soc_fifosize;
+
+	tup->tx_base = devm_platform_ioremap_resource_byname(pdev, "tx");
+	if (IS_ERR(tup->tx_base))
+		return PTR_ERR(tup->tx_base);
+
+	tup->rx_base = devm_platform_ioremap_resource_byname(pdev, "rx");
+	if (IS_ERR(tup->rx_base))
+		return PTR_ERR(tup->rx_base);
+
+	ret = tegra_utc_setup_port(&pdev->dev, tup);
+	if (ret)
+		dev_err_probe(dev, ret, "failed to setup uart port\n");
+
+	platform_set_drvdata(pdev, tup);
+
+	return tegra_utc_register_port(tup);
+}
+
+static void tegra_utc_remove(struct platform_device *pdev)
+{
+	struct tegra_utc_port *tup = platform_get_drvdata(pdev);
+
+#if IS_ENABLED(CONFIG_SERIAL_TEGRA_UTC_CONSOLE)
+	unregister_console(&tup->console);
+#endif
+	uart_remove_one_port(&tegra_utc_driver, &tup->port);
+}
+
+static const unsigned int tegra264_utc_soc = 128;
+
+static const struct of_device_id tegra_utc_of_match[] = {
+	{ .compatible = "nvidia,tegra264-utc", .data = &tegra264_utc_soc },
+	{}
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
+	if (ret)
+		uart_unregister_driver(&tegra_utc_driver);
+
+	return ret;
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

