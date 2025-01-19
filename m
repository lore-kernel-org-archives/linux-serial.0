Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2091.outbound.protection.outlook.com [40.107.241.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BFD1DEFEE;
	Sun, 19 Jan 2025 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737291714; cv=fail; b=AM0UlAb6pl3VRN5g5f78Wy8Y98CRk8YQ8xxY7fKsMpjvPYkOISG1zIA8OD8tVAYf56qvZayEe334etcpZIUzSXp+02PBXw3FbGVmgiaDTLWlpbmQS5+Mlx9stqCQw4YsiaaDcjrx1inDDQErfh5pnWCy2DDy8mA2USqmn13SDZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737291714; c=relaxed/simple;
	bh=SYw9l4r/Ay+k77bHtS45ADzZEz0XKb0Hkx8ohGAuoEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fn6Nn5xu7p4JyfSrN2VEiBgUMC0XfE/ayt9vADM2FqLyAUFDpjpYISo8QubRmKpX1WJmjQGlCBA6oh87GIFGoygrHcjymergtti1YY/s84VQy0v2zAb9OtrjSW/MxoYR70ZdLVR1JksjGz+91wr/To+X2fHlZJ1uXqqsAYktS0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=gauXmciN; arc=fail smtp.client-ip=40.107.241.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="gauXmciN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPgM1zcI8MNLZ3Cz02U65CGpIkeBkAoN/7c+ZZZzzkjjj5HTJjn2aEi+ieTpHBCR3wy/XytlYtWSLQ69eQq08PO5ZZ7ppioZJR0xOPAeuAECPz3pq8+w4B31DR3FPdJYKavNUBvKzKa01epmrxM8XD/luzUX7Z0bmhk1rMkKKl992RuFAD0CL7wnqus4k9AcSt7SWvp/bKH85cwbMzIiLopLVJNR3PrgNuxjHm3M5I1aAC5kU14uVxLDZloooUR51mtZKeCaPBfO7JIojYb2BamUj7MiSxV116zMf3tA+Auiq+WjI03O3iZ78OtLWVzxp9/uDE4jYSmD+lAEgPnGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2lnla1DTcOXalbkiX961c2F2tjZoA6Qhyi+GA+YVHE=;
 b=QWA7V5Fu3aFqf9cc1l2P4KFwfGAVAsgiHppTYyGPSXG7s04NVLqJoKQbGmI9JOGWW8VRJeQC7l3G0v9/TcE2iOilSkrWkAYJUS8+8zXq6oyIlLKMKHs6k+jV/zyhrHwfjjdzJAI/YLjVgtt8TH0W8n9xonCOz7cF/8Vc7apmmegr3P0Phsw126FLHLhLV0WrAUwQqRFcinTqYGMlF/wWDjMLA2yDc1N5xddF1vEWgc3iIF13vyFbcKVwT7QX0mmgCsJIuljvpN86D6a4M+7jJ4V0xpgtkwvPOkc3azhekLoGca0WFmMTB5uzRaTqmFSqZQGGyuMka/mGtCtkUUFHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2lnla1DTcOXalbkiX961c2F2tjZoA6Qhyi+GA+YVHE=;
 b=gauXmciNxml3MiR9FIYvpNKTDRPpqHSlst8dBJMiSPXPIGlvx4d0T1xAoItI5qSg3EJfq5cjIDJvRLVWQcZ7iI0vNH8yOkfrOFoS4XM9/6pRUCmhOrayiPSnBh722Sgh7RdYxzLV6IbdXGFWmmfu0kd7iR2uqMEOTLZjjWBLQqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by AS8PR08MB8326.eurprd08.prod.outlook.com (2603:10a6:20b:56f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Sun, 19 Jan
 2025 13:01:44 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%5]) with mapi id 15.20.8356.014; Sun, 19 Jan 2025
 13:01:44 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	krzk+dt@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Date: Sun, 19 Jan 2025 14:01:05 +0100
Message-Id: <20250119130105.2833517-3-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250119130105.2833517-1-benjamin.larsson@genexis.eu>
References: <20250119130105.2833517-1-benjamin.larsson@genexis.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE9.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30a) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|AS8PR08MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d331787-7f30-4311-f870-08dd38896cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lnOuTJ201niqcZu+hiZd33//MMzqpexBoVIxgycXOCew7sGRMEQsf9O4eCt6?=
 =?us-ascii?Q?B1w6/SBflTUF3us6OrDv+fdgci6rpQYG5zTMsdqpJwyYA7IqnkEp0RVCZ1QO?=
 =?us-ascii?Q?LhQrZQwxDXF4rOHFI4r08sb6c1sejaHnlcpVMiTn2OD8IwoXfFKFm0e0uQYA?=
 =?us-ascii?Q?XNR8jBIfhSioa+muECjfaBQuOV70SLVhHV3bmYksZGGrq11MoqP64cjqWH1V?=
 =?us-ascii?Q?kads7Q8v6KPH0awTkWbQkiJL1eXI+fOmb7jLDdrXQoMwEjvDyuGycH06YjhF?=
 =?us-ascii?Q?JpAI4iVvZ23x2Hbr5JnfWeFd449Koam2AGILCYCvYFPuVDKYSeQs/zH72+3n?=
 =?us-ascii?Q?ZMpO9mVV4hlzONBBq5Wato35FxMSFhx4ELadF7T8T/CEcH/9hlhxAouNA5MZ?=
 =?us-ascii?Q?Mo7BwRrvzff84Et2RGVVDowbjCjfHEnRjcLRVBVeogKVW4ftXLtxOw+EX2fn?=
 =?us-ascii?Q?XJLNu/1GHai/EmhCbmWgjQWlAq1eVupKoaGfq/gUnOjW6ri2UIaPneLEFKfj?=
 =?us-ascii?Q?qz2r4PizqGMjZsAVncnjJzJyTBfoEI+OKf+T9X8NFITBuTQtByHX0OWRwOHM?=
 =?us-ascii?Q?dpIlUextJQ62yHo/zlUpKikfZ34JyHw8rG4Yh24sj6eAjWwFGHVA8y8EwNmo?=
 =?us-ascii?Q?1OaaK8dMVCR1DORzNpmLj6eZhOtBYy5AmbWAdsgdzOnRujXsKBMGWuiXlxlx?=
 =?us-ascii?Q?KuHxNePvVspIuDz5ZRiF0Krgjrof0uXaUE7zlhhgSMG/knyAYQSoTtSioDN+?=
 =?us-ascii?Q?TO9pTPW5nhvox3I2zryT7h1aHbrWYKb6/6FLzyEfVyd4zgKHvcZw5Qy+F2Yz?=
 =?us-ascii?Q?/UMTZp0tx21zPEovNOHKdP3vN0s6IyLiDmiDMvO0ZEa3RhLzUy2n5RzOMcBJ?=
 =?us-ascii?Q?UEakO/CT98A4iPBFM7D11DUx0t8vV+wan4bwOmieshO7b5wnT4niIRm4C3qM?=
 =?us-ascii?Q?U0PKX+Z+dnb/nvmI01qGoMZTfVFX+wwkoEUtO9mE3d48A3wZugVv8FWCpzNn?=
 =?us-ascii?Q?GIRHdaHej20csDICS0THgLkP48NIDI03NJxlv1vMCTi7zCSLClDPTmy5R1FT?=
 =?us-ascii?Q?ulvyA9woZ5qk7LxyZZGhH3gZwP3neHiBYz/V8zv7XTxGvdWE1XqeNrkqPZ0o?=
 =?us-ascii?Q?q3XDueMHsE1lyYGQSKkgtfw03GHltyRdVnSE7d8mu5i68C9qLhZnfQZ0O0hb?=
 =?us-ascii?Q?oCb9YDEej2oSqvAaPgWr490CQdDrco2mTR5usm4WvLToJbQOEMVs6dudsuNH?=
 =?us-ascii?Q?WYsWOJIfVFTgoGaZUH+mXBDFxBHp+bBS9/95xiEfUmzEHLd5ltC87QwulHdb?=
 =?us-ascii?Q?gredqUMJWyVJ+Y27gJ3qOY97nNedTPtw/C/yA7St4yJFv/v3R9PJYoIgegPW?=
 =?us-ascii?Q?Nn6FpG/CnugFvOCrmDIthRt+JJ4L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UMza85u0UYReq8TwSXHBSki5CAVnC0cJLHn8F37EyNHkjjDW8/VAvpIMCvJP?=
 =?us-ascii?Q?HxdqXzNwBD4CA7wTpEjMZElA2og9sCnWDJBDa6Rr5D1tNVbOMD4Jby8hi2tR?=
 =?us-ascii?Q?w68/7e1u2zA/0sjLcjaYi7VkWtQsHATQTCSuBeDpK5B0WkZJDeljdMCtcLeX?=
 =?us-ascii?Q?sX2ulGNXdkVICIVoXoCbEcChoiICetl7Uj2wrZ44jLXC+4s/owrgOo1TzmtW?=
 =?us-ascii?Q?vul9ljhnq3fd/TxBSg2DZ00D3OiQ5laToAXgxE0gW4XKaNZFD7SRwkzTR0zw?=
 =?us-ascii?Q?jqURHT4k/vzELB4TvKPXdVx9YJpAi1TvCETrH9kBe9Vguxdx5i3N1PCSpPK5?=
 =?us-ascii?Q?A67Dlx/aeBTB6DxWPrHN27Uu85CyNEXMDySkR47Gr0C6gkpNG2ChiCZvigCX?=
 =?us-ascii?Q?733e4LQqK2jgw6VnCm8ce3L7KL66RYEaHVUVzG/giYV89M2yj1EoXa1cBJtF?=
 =?us-ascii?Q?AK4eBQ1kfTnZxT/j17e2+F/at5A+M5s3VbdK/vHh5qeMC6Ci3RS0i2NgYhsS?=
 =?us-ascii?Q?ww47gHy56WAxHB1OoRY4c0x39E6JVS98jgeJy7XV46KnL4FztwMySVRsIgrF?=
 =?us-ascii?Q?vQjSkuKMlvV61PLzrZxowGOZOHLNAQkfcVWS4qRvvjB9l+k7OCTm1tdcXERf?=
 =?us-ascii?Q?vDhvykdFrcqDM75h+BxnhBGcawYqSeu4TF+TgGnwk9P+Dgk6Q84P9YBorXTW?=
 =?us-ascii?Q?uL3S2wb7fDZ3wCCKIZ9B7ksv3g1KLhx1MJsXkOgbMjGAkh4JTUTDWhO+DF+3?=
 =?us-ascii?Q?DxUFHqUGq9gLzuSfSJXtvQ7FcZIxN6E+V0fe2T3wqLFtOZ2jO47nk9tYnj8j?=
 =?us-ascii?Q?VNMVR/sArO5/kvlF200xam7a4K5brO+1byRgGAsd9CYOF+B8Kopfzo3Sp/H+?=
 =?us-ascii?Q?GKChL61ChzFGF3MoBoqKnZoVMdgDRoOa7/yJ/TOeVsq0NLEWd/bM8qAnMTRV?=
 =?us-ascii?Q?ts3qdBh7vKNXIv/1FyE9wt+gV2LsMQ9sb5RqnhgIvmsgWwTDs5Z3bnuZ+Xmh?=
 =?us-ascii?Q?B0MV4kLyxh1sUOVLayJFJ7lOrMiwiDv+qY/2DODuRYEGh4FnaLg9Gjtru/7J?=
 =?us-ascii?Q?ie0WqtzjuIGqcInlHY2AKfMWAXd9EehlOq6y3VvLMipiOUwPXikqUaDMnEKr?=
 =?us-ascii?Q?HkoY26LBQhIQGI1f4aw7yNqI4bWA3vZwB+YrObEGFfrtPkuN796/jcvVdHVK?=
 =?us-ascii?Q?beiLVmDud21iCNfHY6CdpNTbKlTNpk3dzZ/JONJYzF4+zXxBiv1+lxomaHoM?=
 =?us-ascii?Q?yoa2n9pbQQUJGjBnuIZLgnb8Ve/N8nt8ITqAmgt1Z0SYAW+ga2ShpjB24cZg?=
 =?us-ascii?Q?kCV474KWW4Gl0TheiEONUxQ/ZENMES5mA6sf0X0vJyC8laYjT6JnNS603HFE?=
 =?us-ascii?Q?gaqETQNhWRMmm33HTxNj7+MHl8Na7lIHdpx5B2PNdoIwv3hXsKgVi0BV1wP+?=
 =?us-ascii?Q?T/cehaGFi9T8IFK1YgrjTYTuN16rqMf8Ia2g7SzSeOkdjN+8RzZMPI+r+DXB?=
 =?us-ascii?Q?n3qPX8nbBhPGitxi5/8BFt8J46XE4SH+8t4Px+4NpZCozuJVfHkc8R6+P0Iy?=
 =?us-ascii?Q?7qdj0BmFeHFUzzX9D4zwC/cDogUq+EoaOo4mfsmAV+musPb0DwKUYG6fc/CX?=
 =?us-ascii?Q?vsbkJ4es5ETu5TDt/IYWY36JokeDnfjpXF2exgKyTvgvXbynt8Me2ZQy7LYR?=
 =?us-ascii?Q?QqCLBg=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d331787-7f30-4311-f870-08dd38896cd7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 13:01:44.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U+VbGsT+zo6mRvk/h01VzCYluKWbxbjzNBZCHpZIaVz/OZKvVPlBetEyx6HgstR1xIwBp8q6h02nSFqRF1qvLuSxzaCJjkCbI+YnGU9I1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8326

Support for Airoha AN7581 SoC UART and HSUART baud rate
calculation routine.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
---
 drivers/tty/serial/8250/8250.h        | 15 +++++
 drivers/tty/serial/8250/8250_airoha.c | 81 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_of.c     |  2 +
 drivers/tty/serial/8250/8250_port.c   | 26 +++++++++
 drivers/tty/serial/8250/Kconfig       | 10 ++++
 drivers/tty/serial/8250/Makefile      |  1 +
 6 files changed, 135 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index e5310c65cf52..dd762289fa25 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -314,6 +314,21 @@ static inline int serial8250_in_MCR(struct uart_8250_port *up)
 	return mctrl;
 }
 
+/* uart_config[] table port type defines */
+/* Airoha UART */
+#define PORT_AIROHA	124
+
+/* Airoha HSUART */
+#define PORT_AIROHA_HS	125
+
+#ifdef CONFIG_SERIAL_8250_AIROHA
+void airoha8250_set_baud_rate(struct uart_port *port,
+			     unsigned int baud, unsigned int hs);
+#else
+static inline void airoha8250_set_baud_rate(struct uart_port *port,
+			     unsigned int baud, unsigned int hs) { }
+#endif
+
 #ifdef CONFIG_SERIAL_8250_PNP
 int serial8250_pnp_init(void);
 void serial8250_pnp_exit(void);
diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
new file mode 100644
index 000000000000..51e675605741
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_airoha.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Airoha UART baud rate calculation function
+ *
+ * Copyright (c) 2025 Genexis Sweden AB
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ */
+
+#include "8250.h"
+
+/* The Airoha UART is 16550-compatible except for the baud rate calculation. */
+
+/* Airoha UART registers */
+#define UART_AIROHA_BRDL	0
+#define UART_AIROHA_BRDH	1
+#define UART_AIROHA_XINCLKDR	10
+#define UART_AIROHA_XYD		11
+
+#define XYD_Y 65000
+#define XINDIV_CLOCK 20000000
+#define UART_BRDL_20M 0x01
+#define UART_BRDH_20M 0x00
+
+static const int clock_div_tab[] = { 10, 4, 2};
+static const int clock_div_reg[] = {  4, 2, 1};
+
+/**
+ * airoha8250_set_baud_rate() - baud rate calculation routine
+ * @port: uart port
+ * @baud: requested uart baud rate
+ * @hs: uart type selector, 0 for regular uart and 1 for high-speed uart
+ *
+ * crystal_clock = 20 MHz (fixed frequency)
+ * xindiv_clock = crystal_clock / clock_div
+ * (x/y) = XYD, 32 bit register with 16 bits of x and then 16 bits of y
+ * clock_div = XINCLK_DIVCNT (default set to 10 (0x4)),
+ *           - 3 bit register [ 1, 2, 4, 8, 10, 12, 16, 20 ]
+ *
+ * baud_rate = ((xindiv_clock) * (x/y)) / ([BRDH,BRDL] * 16)
+ *
+ * Selecting divider needs to fulfill
+ * 1.8432 MHz <= xindiv_clk <= APB clock / 2
+ * The clocks are unknown but a divider of value 1 did not result in a valid
+ * waveform.
+ *
+ * XYD_y seems to need to be larger then XYD_x for proper waveform generation.
+ * Setting [BRDH,BRDL] to [0,1] and XYD_y to 65000 gives even values
+ * for usual baud rates.
+ */
+
+void airoha8250_set_baud_rate(struct uart_port *port,
+			     unsigned int baud, unsigned int hs)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int xyd_x, nom, denom;
+	int i;
+
+	/* set DLAB to access the baud rate divider registers (BRDH, BRDL) */
+	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
+	/* set baud rate calculation defaults */
+	/* set BRDIV ([BRDH,BRDL]) to 1 */
+	serial_port_out(port, UART_AIROHA_BRDL, UART_BRDL_20M);
+	serial_port_out(port, UART_AIROHA_BRDH, UART_BRDH_20M);
+	/* calculate XYD_x and XINCLKDR register by searching
+	 * through a table of crystal_clock divisors
+	 *
+	 * for the HSUART xyd_x needs to be scaled by a factor of 2
+	 */
+	for (i = 0 ; i < ARRAY_SIZE(clock_div_tab) ; i++) {
+		denom = (XINDIV_CLOCK/40) / clock_div_tab[i];
+		nom = baud * (XYD_Y/40);
+		xyd_x = ((nom/denom) << 4) >> hs;
+		if (xyd_x < XYD_Y)
+			break;
+	}
+	serial_port_out(port, UART_AIROHA_XINCLKDR, clock_div_reg[i]);
+	serial_port_out(port, UART_AIROHA_XYD, (xyd_x<<16) | XYD_Y);
+	/* unset DLAB */
+	serial_port_out(port, UART_LCR, up->lcr);
+}
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 64aed7efc569..5315bc1bc06d 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -341,6 +341,8 @@ static const struct of_device_id of_platform_serial_table[] = {
 	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
 	{ .compatible = "nuvoton,wpcm450-uart", .data = (void *)PORT_NPCM, },
 	{ .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
+	{ .compatible = "airoha,airoha-uart", .data = (void *)PORT_AIROHA, },
+	{ .compatible = "airoha,airoha-hsuart", .data = (void *)PORT_AIROHA_HS, },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, of_platform_serial_table);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1ea52fce9bf1..040659de35a2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -319,6 +319,24 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	/* From here on after additional uart config port defines are placed in 8250.h
+	 */
+	[PORT_AIROHA] = {
+		.name		= "Airoha UART",
+		.fifo_size	= 8,
+		.tx_loadsz	= 1,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
+		.rxtrig_bytes	= {1, 4},
+		.flags		= UART_CAP_FIFO,
+	},
+	[PORT_AIROHA_HS] = {
+		.name		= "Airoha HSUART",
+		.fifo_size	= 128,
+		.tx_loadsz	= 128,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
+		.rxtrig_bytes	= {1, 4},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
@@ -2847,6 +2865,14 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial8250_set_divisor(port, baud, quot, frac);
 
+	/*
+	 * Airoha SoCs have custom registers for baud rate settings
+	 */
+	if (port->type == PORT_AIROHA)
+		airoha8250_set_baud_rate(port, baud, 0);
+	if (port->type == PORT_AIROHA_HS)
+		airoha8250_set_baud_rate(port, baud, 1);
+
 	/*
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
 	 * is written without DLAB set, this mode will be disabled.
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 55d26d16df9b..97fe6ea9393d 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -356,6 +356,16 @@ config SERIAL_8250_ACORN
 	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
 	  cards.  If unsure, say N.
 
+config SERIAL_8250_AIROHA
+	tristate "Airoha UART support"
+	depends on (ARCH_AIROHA || COMPILE_TEST) && OF && SERIAL_8250
+	help
+	  Selecting this option enables an Airoha SoC specific baud rate
+	  calculation routine on an otherwise 16550 compatible UART hardware.
+
+	  If you have an Airoha based board and want to use the serial port,
+	  say Y to this option. If unsure, say N.
+
 config SERIAL_8250_BCM2835AUX
 	tristate "BCM2835 auxiliar mini UART support"
 	depends on ARCH_BCM2835 || COMPILE_TEST
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 1516de629b61..b7f07d5c4cca 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
 
 obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_ACORN)		+= 8250_acorn.o
+obj-$(CONFIG_SERIAL_8250_AIROHA)	+= 8250_airoha.o
 obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
 obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
-- 
2.34.1

