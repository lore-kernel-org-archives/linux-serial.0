Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2429D1B21AD;
	Thu, 13 Feb 2025 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441147; cv=fail; b=OLsdo6Y5XBFDsrx7CimIv6cKnJ1h+BCA+Hpg4T7W5pbtThTaMZywr7MslAsdnKDQIALAJYcnVuu1d2QU34Ub+5kr5Ex0QckTQiw8iP50OXHiQqzWq6AD+9lvN1XfAUyUD7POoF0+kUFmgzAZ9YEurIdJJyCy/fPvfHUPV/FZeNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441147; c=relaxed/simple;
	bh=JqnEDLuj0fNgwdEZhD78E41rsFqlqPdtH+PJvW/5VTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o07h1asNU4hJL6QR/0cYqOXofjhftVJ+ZSOXnpY9E2j9ZC7aeHfEUcO3mlhrvGaM/z9vHdO2VZHSU8/+d7fttLMJ17cCso/sWyZrGT0fW190PC+7lJ7ovEm6nXvRurIu7c+SQoUHSzqlAt7YJp6ucCu9DaKyS7DKgC0UozKJWR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jY2sJezw; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jY2sJezw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GB9zf08HFZssGcv0T3dLOp1f7QdZKfoJjVMgLC+tf0xuPd1KCvgEkluziCb/YadcRT4rrcMqn9YNnY7t68hbEyb+P758D3n5KxfRcsZW8zK2JLCYSjBoDeb6u/uPuO8YMggBmJik6mDXsFPipt/L4OM5tLqrZ0fbH8Xld/oAW3q94Dh0ohjmLSchTaGPvcPA0QGC0GEQ7TsHvDgLlhZY67fBZUsH6Tv6iYznqyMaJFTRxawxT4EEaAciThYOa8lESfiVeeMNxLeRupEuaTFYO/k6vEAdKOxGP56DvpjXp7mknt0f5PYDomUT/4zI/j8xBWwjGHEzeoHbaQE86VdvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiC3/M9L/xqzURXgLpW/X3GxBxOkkVeiNCiFGdWxGvw=;
 b=TUHXebSzk1GmXd2fSpYi7o9DnuBL1y6AtvfMPDQ4t6o9b/MQSFo1sePFpfvr38ElZcwMC6UKv5OFgrIaQ5WMHL6PIr8TuQBQ9IfYHgjfjonkXRV0a1Z8Es2Scu5s/n7z5U8zdyTOH/Ry27mfupMiRKnU54JfSehJQMSqCmSD/kF71oXQsxdxQmfyKdHF1Uz1BWRhQeRjx+y5mIMZ+3/vtthrjuhoA77dE4arDn4hGaHoObKg60BU9oGXEXizmI58Di2fACxrE+6TXSRJBEnkFEl0GgaU2p4JFNaUTiWV7lhUDMnDKnPapseAPU6kKWhgJXXUC28m+nKNqV5+enLBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiC3/M9L/xqzURXgLpW/X3GxBxOkkVeiNCiFGdWxGvw=;
 b=jY2sJezwZDp2uFcLayJbEE6OyF858IBmiP9FUmeLMRdjJumvTaDW4Hfs/Al3tGYbqbDoK8C6IGSHUY2ct0XN+iGBc80j85rGwvKGV63ksIMmJSI+/vDrkL72KWUQWR8DmuMQisEbb+lilZSakF69j8nwh0kGV7TPPqu4DhLt2hNjg32d1vHXtWxUUYEeccLSNNiTbTnJ2BvsngkFEVUQkOQFqiIp5uescrw7lKgXQQ3TOs64VpT7iGVtoQr+MW8D43ZTH8a/pOZz7BG1boWxnipXjsKRYfqTQEJrIjFmoFHwmS5Usl5yQ/fGYpEKbzGMkjppiIWLZJr54TE4a3qMOA==
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 10:05:38 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::fb) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Thu,
 13 Feb 2025 10:05:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.0 via Frontend Transport; Thu, 13 Feb 2025 10:05:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 02:05:17 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 02:05:17 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 02:05:11 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v4 2/2] serial: tegra-utc: Add driver for Tegra UART Trace Controller (UTC)
Date: Thu, 13 Feb 2025 15:34:42 +0530
Message-ID: <20250213100442.45773-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213100442.45773-1-kkartik@nvidia.com>
References: <20250213100442.45773-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca528e3-1339-4381-2e1f-08dd4c15f678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8BPBsoikzwCMOYKnL/KlYWtP0xjWnwd0AtHJc/MDcXaY/AtLW6qLvv5o27r6?=
 =?us-ascii?Q?JpOBVjR8UE9nHZBbqFXMPhKcdAudlUshx1brjlaHz1CM+41fyWiArjLg4uNf?=
 =?us-ascii?Q?MsdUxYPYQGppNuNCHSbfg2F5g0F3TH0dRPK+EsNLsyfnKQptCNkzIPZYnXlm?=
 =?us-ascii?Q?EsmzFcKDAlfEhlqJcZEznc59+EifFcu1uUL3XIxRW0/38sFDVWQg88tIsJzO?=
 =?us-ascii?Q?+MPkRLevqpo6VrSCLvmHO1Refegm52FvNuGtNVE+SGG362Efs91Jm7E9uxhy?=
 =?us-ascii?Q?ETrsAV+FoEci8JJTFEiA+y1fSPKOd+0DIFTHq2DN25/gx5wMVJ3sE5kVDAmx?=
 =?us-ascii?Q?30DOtX/nTtBRwWrkXmmbwaQBVuU6BQTPRS3HjnKJsJH60v5MwtWGd2hTkAyQ?=
 =?us-ascii?Q?Rz75ZzVNDCjQuzVIrQvDTWjVM8AiJku732OygjizEVz0lvXFnvNcTIBYBcGG?=
 =?us-ascii?Q?NGhwkcXQm5kflZQwsEl8t0qiBRoBqvy9PAF0B36KGo38bp62lStZvZrEg7nO?=
 =?us-ascii?Q?YMhWB2Zb0UTu+m4Co1Tatjhu1XRnj6MLhUGLJ76lmtMDbmlxlJQOk8vLOjdQ?=
 =?us-ascii?Q?pNTNLkH4VmH6XxDyKa81ovtLA6VLdmvKItcSciXaLToq2/znF+QclMryY67H?=
 =?us-ascii?Q?aq4l4dw+ut03P2nNUKbyeft4j7D/ROl9fxr8J8aI/jm1uTjyHfUrFoX71e2l?=
 =?us-ascii?Q?0Kddpknut8S5932KZQ9Jt7el+FLnPX3WCkI0YX/bm7jL5oNRSr9VWacfOUsx?=
 =?us-ascii?Q?3B4uC1Uz1+GbHU7SLjn3tLWXo24VKxtb2EBVORa034NxODpMT7MlLruYF3eq?=
 =?us-ascii?Q?WtdpXlIzgIVrEpRwr0KYbqRTvDFzSSmHRcBVjBuVwm0gX4ZKv8V3D7w6mOZZ?=
 =?us-ascii?Q?M6xECD8zmhnyx3ncxYoJKrwB3WLBRLSTHw+bu7n3CRboltA8gVy9U7bpiNkl?=
 =?us-ascii?Q?2dLan3ZGL+F1DK5nk7IhmYCtThU1DwdTG+9m3NZSsGqrwpIwyxY5vgJSrSjT?=
 =?us-ascii?Q?2EL3c8ZBXXTn2Xmhs+PrpHstFqQX5Fx1gjgdyp1wq0DfAsm1/lvOlRWlgEYT?=
 =?us-ascii?Q?gbg/2JpENNGOdmMnhnP+WfmvY+OJ2rUVg9ZOkgysht6InyCbsC2n2YG4lK1N?=
 =?us-ascii?Q?UrLEmTPj3cRfbcQlcrCrFxCiJKrwxXMfKxG/qu6hIetMF/GQH4Eu7eU7fG7G?=
 =?us-ascii?Q?538Nv947fBYT9FyuVv9O/BzDvR85IW2V1Vw+ccXWxHyO6phQSSiC4X7ka93U?=
 =?us-ascii?Q?yJZijjYAQF9wNa6/K38ndErkws4/YFxzexKZElNI/oBE8kwimzoDWr5uAS1N?=
 =?us-ascii?Q?6oaA2dsdtQJzVvilhKYANmmjzBQinPfmdIBukORG4NMsigNN4dRZ2Ot3DUO5?=
 =?us-ascii?Q?5lNqoM31KhHnYNnEWWcrIK9Jka7CrP/A5xXTWv1KwXY1rbEOdj4tmJgq1nbh?=
 =?us-ascii?Q?SWgnheP6rHBCKeayAO3vhgzoSJ0yTcX/9dzUX2CL+gNN1Z3lyNZT7GKz8oU0?=
 =?us-ascii?Q?1fftk351Mu7C7X5dt6zr/g8IEtHG4ukqHK2s?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:05:36.7855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca528e3-1339-4381-2e1f-08dd4c15f678
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066

The Tegra264 SoC supports the UART Trace Controller (UTC), which allows
multiple firmware clients (up to 16) to share a single physical UART.
Each client is provided with its own interrupt and has access to a
128-character wide FIFO for both transmit (TX) and receive (RX)
operations.

Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
client.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
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

