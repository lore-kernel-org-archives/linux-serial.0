Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D151221570;
	Thu, 13 Feb 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451430; cv=fail; b=elWX4ogwQn6L/MgZ41cVbbgCfE+F58GZQJSc+9uU4gBLR7tS3Tw0LCuBVS0dr3PHetLoeQ1ttdj361Wi3gowMRL3Rhtl0y5SyBwp7BtMyuU6IPRpXaPZFHeHrrbo3maTpgy83onXtv/wpqCGc1PPmd98rpXMT776BaJXgQLnhKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451430; c=relaxed/simple;
	bh=zi8A+61dLbkCy4RGbDTlha7HzoG6+dVyAaufcqW0s2Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwM5BYYbTcfCcoXxpsj3dullYLK53ELVy2n2I85tsbrUvl4MBDj9/UcTLW+IHiErbedj/Duy28qaaFmiltqCfbpDZqOq13qmLMzd7rvQ73gJjC1Xx5Qt9zbn7weL8vvoZbVrruXJsKAVRpmAvHbfF0AnJwu1HGbYkKisqCavGhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OTolKM3W; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OTolKM3W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggRvZWdgtfdMJkc2mH0Uj8RZf0gNriLSfQ7eQp1H4DHCC+JbtJmvpmIugVg71mxvGiUKN/atctl28Oyuj8rj+Lo1MIf/WlgJ6wMEV9wyxp6VMHLFhxnT/O5RwWEVtpQAuqkIiJ5hA+G6l1SocoMDZccUlpgOc/sTMKufgsUspSWlgtCcudKfrHijVENDgsCqni7hhcPOyqbKlRMh0f8X3qV2Ss9qokoMuFOAf54AbU17s4iBUzpN7Ncj519EB8ap27SqAZfKERpq2d+rH2CF+KV/D11rMm9INWBrLrrY6jKo1cVkDKx2gNalCrsEUFdXxKJ5/4aTUwd7lOeUVdYusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn9fgfxoH1yZbSGuc6+uv5M8AtHV8X4hjdTAWPfFTP4=;
 b=mlCr8T3xO3p8TpQ7+s6fdvmEIPeS9a2bBQmSAck+as5e51ABWzsWfH0Ps7B3S3QtHUB2/AqV0N7Ig8E40R4U95jmN9OVFKc2TzQFuPWq74uegFzeQEIHqZqr4lDfG/A2RnNB379q6I+XRheMGSGHCsTXLnJVRUwmo8nZvmxK01hMwFw5Id6MtGUYdV20SAMnken/QYsUengIpPyAKBhMegVUW2PHV94dA9JsOYIRwJGTkXjCSBUzJAcTx4vbcz3lFpSVHGKf/9PC6mRX6ssinUsGnc0t10nZIr4AeN9i9tgerOjE8yEEJUAzVzcw/+TiQTpRIhMb/5cudzbGsaDmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn9fgfxoH1yZbSGuc6+uv5M8AtHV8X4hjdTAWPfFTP4=;
 b=OTolKM3WFHK3A7/2QfTYXiTvdKx9ihmAkuFpnWWHY9BcfETGBcqwuaUw+v+lDMduKBSyKlaryvzr7+PMHkUfLbbFw3qXyx1ZrG59ynWXtffk5XeJ26ElRylqZfbqxfpJuEnXSRf2zPeM8KedgdyjVV82w2VbKalJfxYZ7gHWDCy0EYTTYO0tKykZqu7GBFDfXTH5sv8SYHe3WIuJTAXwAYlBtni0bdM8X4yIR06sbh4KllwFnsndDRUXA4NIT6KthTH9+3d0rYJYn+FZ47vIb6Pw7E4jfxQjhxK/OuatNCr9D/X9OMSkS9vphfHow1dy78mTZFKsG5PChQCGjkMeXA==
Received: from SA1P222CA0053.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::27)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 12:57:01 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:2d0:cafe::d) by SA1P222CA0053.outlook.office365.com
 (2603:10b6:806:2d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 12:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 12:56:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 04:56:46 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 04:56:45 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 04:56:40 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v6 2/2] serial: tegra-utc: Add driver for Tegra UART Trace Controller (UTC)
Date: Thu, 13 Feb 2025 18:26:12 +0530
Message-ID: <20250213125612.4705-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213125612.4705-1-kkartik@nvidia.com>
References: <20250213125612.4705-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c7774e-3d51-42ea-0c21-08dd4c2de790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q9W2WVgoyETJAZAAEDy/8hj9PM1LZSUurJkRHtZ4A3LmV6eJ0hhNJuLcsgDB?=
 =?us-ascii?Q?5YUVGeQO9zC0Rc3HAbpeJHlD0FZsAtQvvqDSy+ldi5bMsg7pJuAntTdTwb59?=
 =?us-ascii?Q?4MNgtIhlMMn+waj7WkD9I8gqs+xgOHbVy0711PFUJatE4fXuYm4uCwUBcdBb?=
 =?us-ascii?Q?mXQlGZm0+AJ/Az/yqVB/2gZbSS9cq9BwO0eWTfG51K3auC0p2q/fjLMsFv9K?=
 =?us-ascii?Q?IAo4zXPv7Lr0hSSfOKOy+1tTcxSN9FYvHBFm/rIvxSt9IjIqABcK/0DKDJXT?=
 =?us-ascii?Q?QRonzhens82JO38tRZShqNXIZMmp8S2f5quFB489jgemK10EHm5M/z4YsRPw?=
 =?us-ascii?Q?F0ujGr959hga67dlPyi1UpXtXkKyb1xb891QCATZPRO7HBA9ZtSe1/pBIBBy?=
 =?us-ascii?Q?f71pjFShqngwT9B4ShWvs39rYZYQUqeo2leJ1jVFDk555zBJNOfPc0Do8ESy?=
 =?us-ascii?Q?0NteERf6GQhGvDOH9YCXFDlKHYpORA2MwcBPgZ/fZ/FQwTpunn0t2Fod/8sm?=
 =?us-ascii?Q?Rcb8zNfwhNDMEtqdFE94g/MXAWRw6fO+39qLQ2Xz+7rIb9Su0XOviWwDHU5N?=
 =?us-ascii?Q?8Wz1IjyighZ/lBbtzvn6CLCM16G1lFI/PB/Q2k418uwStN8u3NNLSAMNC1Xv?=
 =?us-ascii?Q?vqPdTOIGwjo2HQExBULtCjdDc2RlScgg5hX4fC73YZtuGWRsUgq044HfYqUi?=
 =?us-ascii?Q?VNA1aybDLXIZZfROEwJNr7yesUDmNs52uEJlGVL4sx2ybzEaPjmROx/hLS4R?=
 =?us-ascii?Q?iMmgaaw/S8ZrRAtnES5K0iAa9mca9bwXOWM2osBJB3c3uuFhFHbLvhBAbFvK?=
 =?us-ascii?Q?7K4ShDWtKB3khiqaRYRQodT3mBSjerpQojq+FFvolKNgAn8PlKJCxoMCrlol?=
 =?us-ascii?Q?PCwUWQwfX/a9/tCGRegY1SlrLSzb8ZjBG6rzMGA5NZyYHmNXpIpxvAFXLtoy?=
 =?us-ascii?Q?WO+XJOBtT4ZoopPNZaU3GoxdKeiGoNAO88OLB1Zs0+iqrrMAkvZeBTkqNcBK?=
 =?us-ascii?Q?evehPJRU3m3VZlZBDTcoBV+GPeFWi7hGKoaSjXa5dFWKH+KgYCBQmcWqrogF?=
 =?us-ascii?Q?wdrNvyrR3ElUKNyD0OghNIA9TdCNwwO4t24MKjAIokouyfH2wYBfG2ZcT2aw?=
 =?us-ascii?Q?+ogkZlelYF7TMRfs3EqjJZ3L5qGcuMEhEeQxNUX/93Rr62h3mAvpAWiVqPKz?=
 =?us-ascii?Q?b2YwLQj8Vfo8tRcGUoKwH+LNMhuavE7UOG72zBVBrdEeWHJPVO9twFCyXnVg?=
 =?us-ascii?Q?znjoBBaBgvtaeie1zhlsoHv5V3gTT21Rx/Uf6T71ZFxWs8MId+3NScO0z7/m?=
 =?us-ascii?Q?geXLGu4rn8/9yQkRn9h+oPzjMxuNiKRCNxI3P8tUimgog6e3WEvdi9IpRTZ+?=
 =?us-ascii?Q?pM5j8fcbYWgiL3Mew1tgyAidB0tLzpZWZ36fqnM8iXBESDRxsZZ54cmEiuCs?=
 =?us-ascii?Q?A+wIWJMTPtJM9+kKaj7cLmIwT0SYkVVRKK5MoZl1HSNg7tow5SxrBZzuKgVP?=
 =?us-ascii?Q?B+jQeDp/7sQ4O6z3Ulbe9+YMeCKsQne6o4It?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:56:59.7288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c7774e-3d51-42ea-0c21-08dd4c2de790
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051

The Tegra264 SoC supports the UART Trace Controller (UTC), which allows
multiple firmware clients (up to 16) to share a single physical UART.
Each client is provided with its own interrupt and has access to a
128-character wide FIFO for both transmit (TX) and receive (RX)
operations.

Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
client.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
v5 -> v6:
	* Use fixed width values for the register offsets.
	* Use decimal value for `TEGRA_UTC_DEFAULT_FIFO_THRESHOLD`.
	* Replace instance of `&pdev->dev` with `dev` in
	  `tegra_utc_probe()`.
v4 -> v5:
	* No change (posted accidentally).
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
index 000000000000..39b14fe813c9
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
+#define TEGRA_UTC_ENABLE			0x000
+#define TEGRA_UTC_ENABLE_CLIENT_ENABLE		BIT(0)
+
+#define TEGRA_UTC_FIFO_THRESHOLD		0x008
+
+#define TEGRA_UTC_COMMAND			0x00c
+#define TEGRA_UTC_COMMAND_RESET			BIT(0)
+#define TEGRA_UTC_COMMAND_FLUSH			BIT(1)
+
+#define TEGRA_UTC_DATA				0x020
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
+#define TEGRA_UTC_DEFAULT_FIFO_THRESHOLD	4
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
+	tup = devm_kzalloc(dev, sizeof(*tup), GFP_KERNEL);
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
+	soc_fifosize = device_get_match_data(dev);
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
+	ret = tegra_utc_setup_port(dev, tup);
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

