Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2119.outbound.protection.outlook.com [40.107.241.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899B719F131;
	Sat, 11 Jan 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601831; cv=fail; b=mNwQ8q2o+PnFidmkUGTWNUMNBPj16p8uXBkGKM4TyWQNOhan2dLT6QzlQywTho2Mutimw/n9Cbt/kzRPx543iomAgevZiNEmduKy3mYMDlxemekQSbjwHB2/PTz9+eRbHJo/BRi15jFJ/x/XiB0YD91f0J9E6zF6IlpIYPYsmx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601831; c=relaxed/simple;
	bh=ALERq+5KHPuGw+liPkJZzDKAJg1LG+E5bVbeXZgUOd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=isKkRd4R1CTGn3WwEcMg8l+gqJ+hCMlA8+XZeh5U9NV3h+9rMmo1tTgMDFpHpOz28C3INo8RwuJMb+LRLlAlcmUTDdUCqJGZUihtakvoMyDcC/bQawBe2zH1S+P72fhk4A8CVmoc1Zj1THC22uBUpo15EKDg7asFzOjyIiCXuP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=IQZkCerY; arc=fail smtp.client-ip=40.107.241.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="IQZkCerY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvfV9pItCOaP2slIlpEyJSg3u+cRusp5BuNp3GmVngZZIrklUibV7Ke/mngL+vg8zjdc7pUDAZ88aRIWCnDoS82Jz+l8gTp06rvIxx1dAISDUSC4P8DW8tBbK2N5FDqaSU0gXZVxTjfLlgqe1EN1Fxn6Ch4nFvWHMC4tzQ+dxMTUZsXEbiD1Lnn89uLJjsiUfXvye9ZUfo8Fl9DD0pRXq9su0WI2XrHTLkLJNZzd0Y6O+aKEzC9VgDK8wrdr7o8lLowCSAVF+gYI/++vHmgkLiNQ6/oV2y2u+JO5kNn3v8FspA2WwAOMQ1siF0fqltKqHvll0KDSW8F2Rxzmd/X7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag/5I/jkhDBX5/3p3qbQRcmrsaihKDyDiViBCQPn5BM=;
 b=XMjGyb55Am9P92WMn1JelOdEKVEKlDBV9juqwtOc6DUg4Jzz9ngZs6umOGKyGtBYAjy35jtckzUbWdULrpp4Fuf9OrFtFHNjY+EpNd3pst61f1Ng3N/JlORfBPakECWbaYd1hkRMyf33Gx1ZYduqq7AWwGs7rNutckqUDb3XBUA6uE+prwPlqN8ccPfiocrGjFAoM2G5Ap8oDGIdglQVvcH39Xuji9THtky9Zpy6izBaSfHNCi4+c+KMzJyYzYukUJPtWIcoUwukA5BY0T1zYrISdaN6AJfWbGJAun3+Sp6mpfbAwR2gO8ipSi2X63h4XjuY6OIXtf1Xy5x5ZDxbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag/5I/jkhDBX5/3p3qbQRcmrsaihKDyDiViBCQPn5BM=;
 b=IQZkCerYeYyJRPQPB0Irzv/BkbQmbsBrMIEgUtOxYfwWFmu6JEp6KDHKrqNoL1Y39fha0yqqPIKByXjza2AaNIVvwjdkl403/9THlGmKb6vA/46rpQfnfHz/4EdwnQQNBl3YRUzc7BNNwcgvBl5F2Eje5gqN1Pr9WuHTsGZTm+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by DU2PR08MB10066.eurprd08.prod.outlook.com (2603:10a6:10:492::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.15; Sat, 11 Jan
 2025 13:23:45 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%4]) with mapi id 15.20.8335.011; Sat, 11 Jan 2025
 13:23:45 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	krzk@kernel.org,
	gregkh@linuxfoundation.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Date: Sat, 11 Jan 2025 14:22:50 +0100
Message-Id: <20250111132250.3642694-3-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111132250.3642694-1-benjamin.larsson@genexis.eu>
References: <20250111132250.3642694-1-benjamin.larsson@genexis.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::13) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|DU2PR08MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd0ac24-a01b-437b-5474-08dd32432c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eXntwAuDdI0Z6HQnEYdlY8808LOtifaXfBfQbvzus6WsFyLGEwq4F2j6ev/X?=
 =?us-ascii?Q?x37bGuT0MnsW2LFICm3LVYH62XKhFk7bxlL4sLK97vMo95BHpZdgVCYPMB+M?=
 =?us-ascii?Q?UdZtLsrX85sDeuAIDbwsyPHSQvLVGYOa+WXljPO1vh/miojOoJkOqvntq9ZG?=
 =?us-ascii?Q?USgc6iSDeE1LG45sEfV4i4xWROcZo9VOy3TFocinTCxGN/AFtr2FS8WqXkBM?=
 =?us-ascii?Q?c/TwMqVfKpONqUqWMoBfQX/zwJt5/jzNQI38gESImU8Etjkxqf41Mje83AeT?=
 =?us-ascii?Q?5/EmDk0DXcQMM4rU4+CXliIH9/57v7IJGooQA/Fvw3Y/hom0ZXigXF3TXhnj?=
 =?us-ascii?Q?lsIoWKLWrMq0j6drF7axAxfiY9kOJ1XU429556PKXI55gVxa4x1KLai8IRj2?=
 =?us-ascii?Q?w2VKnUWVmLI1+gI1UNpb1WFgLeKqAeF7U/bx3lwSVs9mPozLodNNF+IC6vNX?=
 =?us-ascii?Q?F5bqfWv7S+HdNiN1KJ4lcO5Y1bQwGgGg9iZ19wnZUOzPZtlsYZ/Pl9eepdqv?=
 =?us-ascii?Q?VGfXIyXJRMhUa+nq/LG9AOahwzA6aOLaifUSK6XmE8CXgdA2Po9ogdKzvGJn?=
 =?us-ascii?Q?RFwXxupu1be06Xs1yMNkwc/a4e4bsdNEiKCow/S/mfGyKlaV97yw7ei13IU3?=
 =?us-ascii?Q?e1AMvpjqaHFrZQbSzZosEqGiivAcfquevsY0G3BtoG1iO73MUa6YwLn0iDCG?=
 =?us-ascii?Q?dm1NU2cmfE0SyE1oHeWwYT2mGEQlpdYW/4yYFeyu1ETnTXgnh9EXxFRa28ix?=
 =?us-ascii?Q?Wx+Q7BDuZS+5XMn53x7PESKSeEZiARDPzTBIfTte8aU6IpLY9iqf96NAkOwK?=
 =?us-ascii?Q?PF9BCTd+E9leGIHtTvt3RrW/rK6lGXGWuX/NZLiuC4iuv/GrhM6JxplfFawk?=
 =?us-ascii?Q?+vnxcfVM21fWoMhxSuPan28jQHU+OTrA9JVsu8YoPnSU1IioAp3qT3i80P6u?=
 =?us-ascii?Q?J2zVG2mPp/O7TTAOYhJ1ppkRKGlewrrzVhSRCnvIHjnqfYQGBC6Z7DPb7RF4?=
 =?us-ascii?Q?5u6SJOydo87OP/aCLZLI1tPJHXSM54r8q3MnRQxuIPK4fz3Zta2HqLVMn6JP?=
 =?us-ascii?Q?SyHp5m/s2ki6wM4sgLM5RbbtRpsENOTzUPqgt99B9u613G+4BuejcWB5ggx8?=
 =?us-ascii?Q?EajgCmqGkYYlBbPVa+kyZ9koz/ph5EA7QLMdu8eQBPVNNtPSypnULmB1vj+Z?=
 =?us-ascii?Q?vdURjsgVJdQ6mnrcYiSlsN9O2Q/z4aa4uRBjX25jrWwN2rnlcxxRNYjMGEWz?=
 =?us-ascii?Q?K8IOP6JrwpUpNcPSAVoQ+P18IKbm7qHQM+VEdxuJQUt7QGFR1adV8pbinhir?=
 =?us-ascii?Q?vVh/EnzrQzUWWDhJWr7Q2zuaYNY955em00HgMzINtmVuI9OvJQe/BuXb/e0p?=
 =?us-ascii?Q?tAY9JptkJnn54x8AhtmY6U9sve27?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8inokAqbEDMLVKtjYxCrpyPXX1aXJDa1YrShTfPZ93reJA8m7EVAU8A4Bxvz?=
 =?us-ascii?Q?VOhTcFDeBwNVnevel9pjUyTEbZSvqVH2yGZIKxYBlfhg3uRdLFIiWHz/KCkl?=
 =?us-ascii?Q?6GE7c4tafHfrqZhWcgZpG9zFuI8yGWZQh/JJhbFjYhgGNV3tpB40nJQ8TmcT?=
 =?us-ascii?Q?VAHW4zP81KtonK8TeE88m+3mp/bPefXjMGKT1fPuYBvxXeCVxgTyScfLtmj0?=
 =?us-ascii?Q?19dz/EAJ/uX0fNNcq4PSoOs8Da0hyc4Cd3eUIQnry6WF0Oavx4Qoid4rsOiP?=
 =?us-ascii?Q?gASl8/DV1ZBKguJON2VphNydxE5duT7XPnV5TmfHJ2qAkrz3vbGe37JPeOVR?=
 =?us-ascii?Q?o+U+6mzgQ1PgwpaCdKdIbvcT1aG3ebS3Xi3r9t29tkDrsaLahXj3CqeMUorf?=
 =?us-ascii?Q?l8AiQEW7duUyJrHaKQc6GaOnPo49jTk7ms8cmzQIpqR/YIrCgwmvtznlcU4H?=
 =?us-ascii?Q?GNl0OyK0vWINbTMT81ZhvamLIWjsaAg/SkI8xS3DtamkV/fNEZjtJj6cMvED?=
 =?us-ascii?Q?6uFvCyeCJNetDbX8XSxU0IgjW6d1AbC8y29xZjTXafWdxkU35VJCylF6jdPB?=
 =?us-ascii?Q?S9NW14i3lSIK2Z6/xYdmjwLv+0lVaN+s9SdGGgnvkDrlv6KYhbrnN+BrxjXg?=
 =?us-ascii?Q?Ecsiq9gjXUdgYJSUK5WXBcrWtVDmgi74KdxKmSmmT7b0g5cMpa2AurU+cXAX?=
 =?us-ascii?Q?EhZ001aTHg4EY5MzWZy7W6rzum85U97XvUUwb4s529iCxexlR4bHsDNwQc6q?=
 =?us-ascii?Q?hIp7iE0NrSs12+sE5l/35D6E0v7gwJJ1VbpZf27AYJ/zWn6iknwIeKp+KyTM?=
 =?us-ascii?Q?C4xDXbSkHCnCdYCAzMWguEAfalAkY7wp+1p2hFBmJ6PQVBM59Mi1SIvieWS8?=
 =?us-ascii?Q?U650OGcr9cMbsJ04irWUBfSUp0r8KVK8xtEFF38/5s5+0p60FKO2hP65F8gx?=
 =?us-ascii?Q?zKlT07nWEjs5AehnzhToBVDwfGD2uOgKTMFkcOaubbNFTzrdvj90IVVPlm+i?=
 =?us-ascii?Q?8vGssPiDp6rQX1wV0acf7q+Q2e+bOrE2PfXLoOouCIdSJ0myUvmm+RX1H0z+?=
 =?us-ascii?Q?aBrGmKGUDhzLhUTZbYI69WJCNNV6ak4QjV43eTQ2kNpyPBnhaxaC34eSJYCL?=
 =?us-ascii?Q?3vqyPk6U+Dkc7Ur3HsBobA7ndeJdj3fHzjqS1GLVk/9v6nW8TVck5Eis3XIm?=
 =?us-ascii?Q?0+1RTduz/DlxEkx2VQshA9oINewFqJg38KIwLsNxPPkjUV816Sg/SW7aAnH8?=
 =?us-ascii?Q?ay6u4+9CJ9akvCD6hMRhDSSuXp3zSg5WhqN88f3wZlz/IzN2YXK9xvMsyiUF?=
 =?us-ascii?Q?jc/uel3J5ctglwdTwiTDpG/lpfCZVPhqPZGa1QgW0bHtk6OTlZRpGpRUBsZU?=
 =?us-ascii?Q?ofHZZWAvLI3rZjNe9lSt/8xkdyzQPXrrLDXmPlRWeKTBRHM4kgnPYlvLjs3J?=
 =?us-ascii?Q?kN9/Xn5HU5zeVfIRoZYTNMAOIXX3SjwjXiGCEAguodBUEQOkK5dUlJj57D2X?=
 =?us-ascii?Q?9qtS6b+tMbM1+cbmQaYUcve7PWDV4h3fJJjvuwncI9vHDUi5Cls8AwdczD58?=
 =?us-ascii?Q?aw23cqcts5ogzBFdbEMQ589QZlqyDbMC2nKG6gGdpp0j9IiDKwvGH+nv0d0X?=
 =?us-ascii?Q?mdaUwpggWuGgOjjQLZ7n8W4P4oyxxPOfJNXRT2q2+Us5E898k5upP07EE3g6?=
 =?us-ascii?Q?Ibvm7A=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd0ac24-a01b-437b-5474-08dd32432c66
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 13:23:45.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxK+oxCzzMvF9somfanuwhx7clJm1K1YqeG5erOO8fEW8Txj106jUDqhyMaIV7DLvPcvLCxgqSaiPvA9Ugr/sUyQSNsufGQQIujdfPwPtQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10066

Support for Airoha AN7581 SoC UART and HSUART baud rate
calculation routine.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
---
 drivers/tty/serial/8250/8250.h        | 15 +++++
 drivers/tty/serial/8250/8250_airoha.c | 82 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_of.c     |  2 +
 drivers/tty/serial/8250/8250_port.c   | 27 +++++++++
 drivers/tty/serial/8250/Kconfig       | 10 ++++
 drivers/tty/serial/8250/Makefile      |  1 +
 6 files changed, 137 insertions(+)
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
index 000000000000..d9d679e2188e
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_airoha.c
@@ -0,0 +1,82 @@
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
+/* The Airoha UART is 16550-compatible except for the baud rate calculation.
+ *
+ * crystal_clock = 20 MHz (fixed frequency)
+ * xindiv_clock = crystal_clock / clock_div
+ * (x/y) = XYD, 32 bit register with 16 bits of x and then 16 bits of y
+ * clock_div = XINCLK_DIVCNT (default set to 10 (0x4)),
+ *           - 3 bit register [ 1, 2, 4, 8, 10, 12, 16, 20 ]
+ *
+ * baud_rate = ((xindiv_clock) * (x/y)) / ([BRDH,BRDL] * 16)
+ *
+ * XYD_y seems to need to be larger then XYD_x for proper waveform generation.
+ * Setting [BRDH,BRDL] to [0,1] and XYD_y to 65000 give even values
+ * for usual baud rates.
+ *
+ * Selecting divider needs to fulfill
+ * 1.8432 MHz <= xindiv_clk <= APB clock / 2
+ * The clocks are unknown but a divider of value 1 did not result in a valid
+ * waveform.
+ *
+ */
+
+/* Custom Airoha UART registers */
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
+ * airoha8250_set_baud_rate() baud rate calculation routine
+ * @port: uart port
+ * @baud: requested uart baud rate
+ * @hs: uart type selector, 0 for regular uart and 1 for high-speed uart
+ *
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
+	/* calculate XYD_x and XINCLKDR register
+	 * for the HSUART xyd_x needs to be scale by a factor of 2
+	 */
+	for (i = 0 ; i < ARRAY_SIZE(clock_div_tab) ; i++) {
+		denom = (XINDIV_CLOCK/40) / clock_div_tab[i];
+		nom = (baud * (XYD_Y/40));
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
index 1ea52fce9bf1..3cf7f46538f3 100644
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
@@ -2847,6 +2865,15 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial8250_set_divisor(port, baud, quot, frac);
 
+
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

