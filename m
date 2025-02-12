Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521320898C;
	Wed, 12 Feb 2025 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356946; cv=fail; b=iOQ2sTeVwwMJrOo1hDvTD5y/S91bZxgHIXJT/ncoe1+RLd9t3IUglXnzMwk+H2JcbEQHLCYfDrTXyP2yn3YKTublIWf1kVx59OKYw7uyQ0cIud2FWd67gYYMm/5MIkxP/7Zr7xtQv7HSuhBGv4wgUXM6MojmAx0JJBx5tQvVbtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356946; c=relaxed/simple;
	bh=LT4xrR65GI7B5OOYSBnQtpFpZzAigF1upZ1Y3IKERew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0xtMbTY8cBiE7Z2waKvKQBt5ihqZI+UTd85HL87RVcoxh+DpTBgsILxt8bvteRDGk+fcBrt0jNWDDg/tr6fg+mosts0nG2Qep+rcCXVQ9G8w4uEPaAF2uL0vya9N18RVPiwnT0cr+4Kh7xFpCrRwFVwWeorIz22AR8zYejTKak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jk5QgP3G; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jk5QgP3G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhYUr+AuRnUuC0qgphwR29Twqcur0NOiBcNCTiez1ZcIbN3PDRiuHn8Fal2FfymlFhyVBBkm+opBXr200D56SY6wVD+PS28HQ30lYFPzHFY0zg6pVi8oomPpYZb1WpAcT8Ux+aaLjjD51hX34ZtbawS1cnIsjYPduWHR/xEd2Phe6QZ0KMLKyzkFMF3ufGeIMPnfF82wHXc9fm+1VRbbVMGBfVcUR6bseOpGB5ir1h1pFzod1z32OYczpVcmnNkDHBvd7qv49lE7plwTJh7zqViHgZa0w8jFGUZS1FfHpDZrRJBO2izpBi6TinB0z4Nf2N36uIFvwzlBSWEbWghWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOUMYdL7ctS1TV/TWVMDf6OEOs+ZvdvQ/p7CQz4hMK8=;
 b=n99C8Cbndr1/GjuDJOkblT68XMzWvnt2R1cH6cnC3Q1/NR5E55nESm57WPHSj6HmS5HIWz8ZWRWjXh/HyIhPKEAJveGaM8jaCmGVG1yIN7/FSyGWJfyrTISA7idr3o1we1Zr7Gr/tcEy6KTtJcmt2ObX3BV/zK2sYHVwqelKfbjgf9vNeyHrh6TNtOKfEXQg1dk9lKJvLc71hy5rYHWZaGBiQpBjf+LkGYQ3rTk3pIeHqFXS4Ze4PZ8sZLtA9rdCK8ZI1TAO5nZybH0t9OJH8tNc09TVkej4vZlB17kumIxyQCobKuX4OHx4bMUZ5PrGryYKjkst3lPo/troWK+0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOUMYdL7ctS1TV/TWVMDf6OEOs+ZvdvQ/p7CQz4hMK8=;
 b=jk5QgP3GJ6TeoKbMtqw/7LnKjCw8wgl7vxGffehOHMkXwG1mJ2SIkDrXuDx3wz5iA2z2OX3WsI+KWao1pUc+XG/BSCPyaOjzzxHhKgCL6EaA+ek8x3lI6Wv6Yh7EiDAxpLcthV3ud1A0U6vTTRQ30oP/NA5KeJZ9+vq/MXaQ6O57s8zKJvrPOLdQq+q/OYmlX9QJnbw+ugTgxnk0AlhHxRSbAgDaVpYyEhT8prOVWkqB4f/4DEhtsqgzr3FQ704RWTLubkf58B9M8y8Y07AFpxsZ0XBursv4Dyn5/azm89aiQUbhm9tSYvN3mXOfcHLVx740sDbN9O8z+b50v4zDAg==
Received: from DM6PR06CA0057.namprd06.prod.outlook.com (2603:10b6:5:54::34) by
 SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Wed, 12 Feb
 2025 10:42:18 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::b6) by DM6PR06CA0057.outlook.office365.com
 (2603:10b6:5:54::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Wed,
 12 Feb 2025 10:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 10:42:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 02:42:03 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 02:42:03 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 12 Feb 2025 02:41:58 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 2/2] serial: tegra-utc: Add driver for Tegra UART Trace Controller (UTC)
Date: Wed, 12 Feb 2025 16:11:32 +0530
Message-ID: <20250212104132.61060-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212104132.61060-1-kkartik@nvidia.com>
References: <20250212104132.61060-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 0269c031-f31b-43f2-e70c-08dd4b51ebfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x3k+0yQlJJl+blwqVypm4oHrdTQr7ofgaJNQP1Y4IHmvYcHK+uHd5E9gF25l?=
 =?us-ascii?Q?a45vmHO0Hz2xsIPNFFX8xD2FI+Rw1AFF0DmKjyUO7OaY7IMqDUjaDUqG9mq5?=
 =?us-ascii?Q?MVl9JiVq8MiRzxSgjydJ4N+uHKNLpoB5tC+JWDZsSW+UJbHNmDPOfmeWpImn?=
 =?us-ascii?Q?rI53HcFuOJhfbOVMsh7xss9miFUzf3Nzi1q2ZOw/HjyHlASL8/UzlMUMdnsN?=
 =?us-ascii?Q?3N5n3z7ysYWOBghmB6B7spSOVEbo2cEEBre06cCtM1B4RCmCrXancsU0sHx6?=
 =?us-ascii?Q?4LyhqecvyhEuKDbqcR3+ujFhO6MSLtlamhMk5lCuwqgVyjdlx+ja8MqHvitn?=
 =?us-ascii?Q?jg8etZsQMNvckkmkkQsyXKlM1ZGIX0apcSMP3CVQs7CJ2Jf5wLp5LwVWQ/rp?=
 =?us-ascii?Q?u4zEMpys3aTwr/gIzxthLEIhTaQ7gn1CVlLpgyo17Aka4fT6aLZO2Wy1SwLR?=
 =?us-ascii?Q?GsDALRIbMvPdKGn2hFMeJQnal9CVfksr9GxvDL7BmGvjz/VtIYPBVxSd0QuW?=
 =?us-ascii?Q?YrWlzcl6lOAV1wP4rD1WIVOhB4LFyesHl3AyjxWNu4zGTCJ1vT9X0QlBFb5f?=
 =?us-ascii?Q?fdT0+iJ3yOc7bTDZqmJ3ZgjeOfT87MDdxBXgsy5RCZLU2YFAmZ9Qhm/zZYeZ?=
 =?us-ascii?Q?7aIRg923CSPVCcyKYPjmu3ls0coOvxm65UPFrBAg4W/Ic7hnOI83q0rPA8om?=
 =?us-ascii?Q?V1W8SoNpIaWN1uQbQXGGf+PypJAqz5QizrE8p58n5Rr4l2gZ8GpFopAf7nc3?=
 =?us-ascii?Q?IuqVelFHswnOCGQaggESz20vJ2NUl6e/GE7FWGPu6ru62AfJyJVDz53JMtSg?=
 =?us-ascii?Q?v1lhvfOQ/xelOqUiV9by7RORmwJ995zrVTV3evTkB1nvzpUvWdbbgl1wN5r1?=
 =?us-ascii?Q?cA6+Rt8ksZ6fG844PWCNcxhLCVGtGcteKAnSs/lbNhSVE5T/TMtH9rMhNpNY?=
 =?us-ascii?Q?sQ0aGsPZSxs3z8o+dlUVjqc08tporhs97nZdlgHFmBCOrDHeYCFA0CHRkte2?=
 =?us-ascii?Q?wPPgLsxi0TQ1eIwTXVcL8teAH2VU3uukHs4b/NrhWFO/y4yD7Ay2eYUPpvO3?=
 =?us-ascii?Q?ZAhMKZOOxN5RCVRYDd53o5TlDYB3PU4N8im7Rn3uTwC+FMuYJCXOqw0c6pvu?=
 =?us-ascii?Q?duVhhjh0qbpbv9RlY96pELmWO49z/ovfMWHpw0aIXkaytnWuCO5U4E8Z06y5?=
 =?us-ascii?Q?fj2bxhosOG0pqB/nR1z65fyXM/+wdfpyuLeu7txVNogB89M1phH++lxHpyrs?=
 =?us-ascii?Q?zizYd9xuP8pdb86e48kDnQmnxUvfXruGtZrdTZIzQ4m7pzRwafRx/nmeoFCj?=
 =?us-ascii?Q?PAY5gvMzt79dRakP5H1gDmluqq/tj54pBTJy2jU/dSp2Oh7bYdacCRs4MRT8?=
 =?us-ascii?Q?qeGUOsF/ihahiDmR0dWvbDSJNxkcvXP58VGt4JKKXjotGblgF9KeiCiIIRVr?=
 =?us-ascii?Q?QWFV+IHAf7268E4ko9flNw5o1LJHJl+Z+c5vsN/JQjq5w2Iisf1ZkUCQBTDw?=
 =?us-ascii?Q?MpnDrEwm30qNNPytdoYUud7VbxavT8g3CDwi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 10:42:17.9260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0269c031-f31b-43f2-e70c-08dd4b51ebfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274

The Tegra264 SoC supports the UART Trace Controller (UTC), which allows
multiple firmware clients (up to 16) to share a single physical UART.
Each client is provided with its own interrupt and has access to a
128-character wide FIFO for both transmit (TX) and receive (RX)
operations.

Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
client.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
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
 drivers/tty/serial/tegra-utc.c | 634 +++++++++++++++++++++++++++++++++
 3 files changed, 658 insertions(+)
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
index 000000000000..7dfc242b25c4
--- /dev/null
+++ b/drivers/tty/serial/tegra-utc.c
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: Copyright (c) 2025 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+/*
+ * NVIDIA Tegra UTC (UART Trace Controller) driver.
+ */
+
+#include <linux/bits.h>
+#include <linux/console.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kfifo.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
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
+#define UART_NR					16
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
+	tegra_utc_rx_writel(tup, tup->rx_threshold, TEGRA_UTC_FIFO_THRESHOLD);
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
+	if (pending)
+		return true;
+
+	return false;
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
+	u32 val;
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
+
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
+	.nr		= UART_NR,
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
+		return dev_err_probe(dev, ret, "missing tx-threshold device-tree property\n");
+
+	ret = device_property_read_u32(dev, "rx-threshold", &tup->rx_threshold);
+	if (ret)
+		return dev_err_probe(dev, ret, "missing rx-threshold device-tree property\n");
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
+	unregister_console(&tup->console);
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

