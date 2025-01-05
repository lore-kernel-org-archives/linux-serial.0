Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2125.outbound.protection.outlook.com [40.107.21.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAAF14F9E2;
	Sun,  5 Jan 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736082748; cv=fail; b=jpQsO+bbCnXUl+fN9WibwrdAI3n/o+q6iZLBiGhrVP1Yf1ozJUD4dycitIlAl0WmlCwNOO0tYr8CYqQHTCA3EzqjXnX027Tc5Uh/bFMfpNO6Jqt4HdNAlTGcLifZOg89bzwjQNXcNEXMKw2vZOyhtyP4R5AibTtUly4/lpaPzcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736082748; c=relaxed/simple;
	bh=0aY/M4barwYpYAT2ipKbpLBK59fQbP5NJLNlJyl+46Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GswAQ49PkeeRAJYepf6IJr3AuebSt+DzOdKW6FrJVzx4eC7B0fYEVTKZz1MvWgHUnpVG6/8aGEkbD5Wk1Cl/gcXBw2OU0Zb5Vhgf2zKEbYDVkLQKBbTHQr90Zjylr1eLjYtOQqhhIxOGbH5vn2A/nLvbulOjfJEOQnHKWNpAM7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=Zn0Txbxw; arc=fail smtp.client-ip=40.107.21.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="Zn0Txbxw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkBldhVs8Xbqh2zgBX5j7ycDiOpPFTqGTVBji/jBvSPN7AUSih9FVcsRVcI4t4DjuYDAWYiU5bAdmArosewI8CNjCWsbRPhd+vOSE7DuwyPTBGZtP0PufnjusvJnkEd4L+mFGjRQSRAkQSqOPj+TBQwxijPtEbMW0gA/dS5nG9o8ALMlWkW1WAm9cgdgqeLCeGA7SIGNip+kfvkdDlbogS0m6YCRgBbIhr4runmsCu49VKsI3ollAqXwIemLIZKWMeIycsMGoXUoh7z0jdnEeC6Bz2wX+J2MyZLZP7gssPYp+pZQvHJr+LOW67kOZii6FsK/pVeq8iRxZOwMje+TRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd+36EAui6O0tfut1PSp3SLXRLcKm/m8f+1qaM3NEdY=;
 b=dpSlk4Ah5jyFo00Y7a1pl0mmh+SKZm1DdpOomtOQW7autKUND8zx/mqt9I1GztJpxiQl5xASgn6mwf3bFXoCPoqNJaY/dZrF/vPLM8GmzFqVZyUgOmPMumI+bhze0yjpy6x5uLLPkeChfYIIrVMudTn9OBTT8QXLDE/LHs8Oggy9ZHliU++s3KQ6rb95KKOZaFSsE13rOQj6x+KcxN2Ho5nRYSIij2PAYD9f9qPOPqfylWJDKOEKc6gvSCQFkRsfB5dzNY+Eqw95k+BAe48lUqDK7P16HZ4AXBrZqTqhlfuyTUT0VFoHJd/g5cpy7pWosyoU6caGrZo+dMypz+6ZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd+36EAui6O0tfut1PSp3SLXRLcKm/m8f+1qaM3NEdY=;
 b=Zn0TxbxwI2CtJfT3OrjnilRNzFNhWky3USZ70XyJ10OiSrNwK/xywLBgz9uItX8TPNrwtgxFcCcwpSjuoG8okk0rD1JRNKEGnpNWROppDGh2Kiatw6ddL046cViqBaKfLVe27n+K1RaiGx0oDYfyxTlhxrPLL5GMJp2yyJrrh+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by PAWPR08MB9613.eurprd08.prod.outlook.com (2603:10a6:102:2e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Sun, 5 Jan
 2025 13:12:18 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%7]) with mapi id 15.20.8314.015; Sun, 5 Jan 2025
 13:12:18 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Date: Sun,  5 Jan 2025 14:11:47 +0100
Message-Id: <20250105131147.2290237-3-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
References: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BAE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:8) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|PAWPR08MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 77808265-84b3-47d3-4053-08dd2d8a94c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BPgtUyo8dlEVp2+a4CltepdZwpeEgzAH+Pihtuh0txxPl9NEFNJM41af5Sir?=
 =?us-ascii?Q?Oriwpnf6s/h1wHU9LKuhcKDpV41j0OX5p6AjvJEL5Oe5BCbZksjIblRSkgeC?=
 =?us-ascii?Q?fA/oA5Oi5fJQDQo2Tx4GPgdY/wHRQSDSah0jx6tQFeFr2PYur2IQ4D2ubHcN?=
 =?us-ascii?Q?CBCe67FQIpJ1wv7T30/s6s9nsFav73Hqw2q3fDDAPOTsxBXebXGe9iZOp25w?=
 =?us-ascii?Q?/8v8VOFphQXyVCpl8F2gfbSLgVNC0/T1+EK7pvvCOJohG3y+f+w3V+Ix9xZQ?=
 =?us-ascii?Q?lFFg0wW+m65bFMVDwA+5nBAA9DVETGeTum03MDLhBFYPkg39ArzIq49np0/5?=
 =?us-ascii?Q?aFToiqr7MrbL+3/Hz3X7mQRzMYMn1B+HRtx6z/EaEdghnjirc0456qJSFMJH?=
 =?us-ascii?Q?H26h2oHOs7DjoiOV331xoXHniDQmRWnXeqvDFb+U7eES4qL5+Z6lSfSRM06J?=
 =?us-ascii?Q?LfBM8Gwz/7BEeCbxaw7as8aqzeJCZCm/jC3J5kY6XpP2PIOMiHQhIRHqpm3D?=
 =?us-ascii?Q?U3llv1E8JUDMlzFcrce08qU5IVkK61EYQlt4KUMs7D43aRAaLjiPR5xXbAc4?=
 =?us-ascii?Q?ItGrpie8GlPbzsTVpmufMiy26gkfy/9o/ZMeNma5ujXSAC+XBrD3jJRCU04X?=
 =?us-ascii?Q?oxwCZp0DrxFIpEKggaJXEKyMfMnzhUh7cymwdQpcH8bL5BcmJyJwD7oPXy90?=
 =?us-ascii?Q?1wHDTgPgGszJBgLpPaGTIFM2PbfQfVxoem5bWnw/9W+k3EKigEJtVGeNjmRz?=
 =?us-ascii?Q?VdkWs2bM8xH9c3y2fYjo8ZcarKYwFnoSqLbNvKXn1wqWrcJXerIS3t2ufY51?=
 =?us-ascii?Q?bKYbPBL64H6iVz1fllnO4h0mhSvr9pdtqz2eJum4NLQ2CeweDmrbwxdYs1c6?=
 =?us-ascii?Q?dhjhf1Pk7IFtDSfl5ETQ2UzJxIqWdKhvKY4zkh1buTUu1dgg+q2bmG5Jxeni?=
 =?us-ascii?Q?RKpSpYJJsGbLCswYyj7JWOCafDsNg0BsAP8snRGk7A1dGJC+GNFnSs80xyOo?=
 =?us-ascii?Q?oPQ7+sRMHjGTTP5EFeXndhurzeaf6cdFvMW2eqjQVwUNt2bxgOhFUi6wMUrW?=
 =?us-ascii?Q?wdfeOQPBPm9dS232gBeZffUnQMPkOinSCQPl7jy57+Xfr9Kp7jgnQmqQhuGD?=
 =?us-ascii?Q?EUMIgiiQWgmc6nnrTDNWPvwPV4lURDZBxXULPVtzE+zHRiIAH+QYu+QXdTIB?=
 =?us-ascii?Q?swHTMDRdct+OnRJX34YpOL214gBPgMWAVsZ+x/WHJqa6WTKnO/SaLY7722Yn?=
 =?us-ascii?Q?ugnFpiuiRyNGM4krBhvJkjctqhL+rMrf5vPpmK2lpK8U79aVh2C9c2VTvxIR?=
 =?us-ascii?Q?GDkKhr3gyroQdxpXrazg4jCzGaJQwHQGFhWq76zLrA5besHNaJu2KUpA8Uin?=
 =?us-ascii?Q?B9FTmnKVGbCzarq2xozNbGaTgrYE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5StAOFcoebsyVHOD/JyI+mD94R8C4V9XpJVHD5WOl/IoKz2nVxhvC+L2eFTf?=
 =?us-ascii?Q?D47UYuy+HkCeyk5yfirR/HT/8gdN3XE/QN8kQ7aNQc7YIcc1nOTOviRRxGoH?=
 =?us-ascii?Q?naHRyuPVwF6hRbEJzCGUvvrJde4sxFdgCJPpN7JSwRwGRQbgQ3rnO2dc3uNb?=
 =?us-ascii?Q?p9w8HoakIy1ILlpG0PLKbExlnS0Z6i07zeXLtY1lR01cWcbOEyBaPwK+rjel?=
 =?us-ascii?Q?4A101/PvH+xFVr2Lvg/SDt2aQd4eWN5cz2X8PGCnKSuc7zs8Ex8jL2lp5CKI?=
 =?us-ascii?Q?Gnz/lfaPViW5GNv6FCj+vz9BO23cRbY5nJP9cza+yOfb1EjMDAC/WRWjlM6P?=
 =?us-ascii?Q?98nIwCCj/5xC8ZhjUM/hqGESqh9y8flDmH8bJQF4NKoT6VS8oJXCM1OtAgOj?=
 =?us-ascii?Q?FGf3UhbeLlVeLdNvSxu/HVkROibl9auy0uB1W4B6vpU2ovMhOVfWFV7WAr4v?=
 =?us-ascii?Q?LDxqLIdxJsZwovc0mamEmNhfKvUp7lUUpZYqVJpSECkXnR0Tj9xcScAxHlqY?=
 =?us-ascii?Q?7o2J+C1oehUTG/ghddgx3UFnvQfYeWR3xt5E7lYaiAIwq3bMvTajoBzabiRF?=
 =?us-ascii?Q?AqkUCEkxgaTq6wxJ8FLDA9IFL6JvRSddpQPKrEEC1iKPaRjZZMmLXfOrPwMB?=
 =?us-ascii?Q?bXI6xWCQfj79Gm0bfQu67zyfL/aflTSprxLe81v0ulrfRSJzxzlvsx10XVuU?=
 =?us-ascii?Q?Pk0PJRGgqyXO9mXc4A7/A7PI3yhSR1zU++q1MPWHQcNESRSLRhG/Hdw/eOyy?=
 =?us-ascii?Q?nnMVdr8S7P2/F78JO27TiWpTKS3zE/CvlTOmVz+T6yiIcKQvWLCY8DwO/ynS?=
 =?us-ascii?Q?GRqfElafv5jL7lX+ZOhm+UfBK5+jB+AI77KUJ0+vpkiREndfxfAU/q1iBx4B?=
 =?us-ascii?Q?od8KpiDAdfQ1JGei3Rb9KM3G+G8O+0fdx8ZtPQ7I9Hh/d9lKBNRk0Ynp3ZBM?=
 =?us-ascii?Q?57DxsEdfOxhvhI9IhHe88iZlZPpAuSh+PURU/nQmr2m3TtGYDF1ayw/zdftO?=
 =?us-ascii?Q?8ELB4NK5D8q7O65D5MQOd+ShgVnG742k6UvCZ3dAEwsWBXRbG3mvKusNOamn?=
 =?us-ascii?Q?PdA93rk18G0NnAn6HMndP6zcXTx+7xHKwzKzNGfTa6fQDdfil3+L9tSF4ANS?=
 =?us-ascii?Q?njtZyeNavd7QSao2gYDLCfquBW6wfKTTSu9dZnsQoKvZx/jrx84UXq56Cl6Y?=
 =?us-ascii?Q?FFPZg3YZoz8T3AMEBY/a5DVm9EFF5H2zfM52vBsThKj8f4a5XATChgHF83Y+?=
 =?us-ascii?Q?SvcIbaQeKr6LlOVZR9qBRqvqrHt9YBJCvonQLEDO1M1HK5gVKAbjCWvoAb6g?=
 =?us-ascii?Q?HfZ91Umve3evcdHLhIJ/VGNPzN03OoJL1BbphlnxnOmV9H/A0Xjxl6Lb5r/M?=
 =?us-ascii?Q?7h5q7eaL+cpuJBgJacf3mN6xMlFVp7C9mJZhvpMvk6K1CNq9l5ZHqPQ5SaAa?=
 =?us-ascii?Q?x32e3Dw/fCG6sHeYXRfp2+uR4wKVf/iqPSZxl12tWH0rYvIaG8cXQzN8bC1U?=
 =?us-ascii?Q?75dTaZkgkXf11I/jQmGt2cjROvDJzBxh34Z+LHoJdQTjL5f7uE/oHoLTXnQ1?=
 =?us-ascii?Q?HEYZerO3KUDcjlx2P0psY5aWSryoHhXLcWx2CQTlpSTFs80dvCE/Y+Bb2ubY?=
 =?us-ascii?Q?i+jsb71SOjCINVXQdvvKT+Acug4LARW9/7++oA3pZfrxTe2S1nKh031+hwTM?=
 =?us-ascii?Q?8L32Pg=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 77808265-84b3-47d3-4053-08dd2d8a94c2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 13:12:18.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCfhF6ckKZ44ffGRko427P1Nw+Hme91K49E8YmiFniGLVmgo2Y19W42iQrQgSX1VZ0F0aDsTop7vOttXYn8JQCPxpvyqdEYMnm3+VkRpcLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9613

Support for Airoha AN7581 SoC UART and HSUART baud rate
calculation routine.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
---
 drivers/tty/serial/8250/8250_airoha.c | 85 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_of.c     |  2 +
 drivers/tty/serial/8250/8250_port.c   | 26 ++++++++
 drivers/tty/serial/8250/Kconfig       | 10 ++++
 drivers/tty/serial/8250/Makefile      |  1 +
 include/linux/serial_8250.h           |  1 +
 include/uapi/linux/serial_core.h      |  6 ++
 include/uapi/linux/serial_reg.h       |  9 +++
 8 files changed, 140 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
new file mode 100644
index 000000000000..c57789dcc174
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_airoha.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Airoha UART driver.
+ *
+ * Copyright (c) 2025 Genexis Sweden AB
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+#include <linux/console.h>
+#include <linux/dma-mapping.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+#include "8250.h"
+
+/* The Airoha UART is 16550-compatible except for the baud rate calculation.
+ *
+ * crystal_clock = 20 MHz
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
+#define CLOCK_DIV_TAB_ELEMS 3
+#define XYD_Y 65000
+#define XINDIV_CLOCK 20000000
+#define UART_BRDL_20M 0x01
+#define UART_BRDH_20M 0x00
+static int clock_div_tab[] = { 10, 4, 2};
+static int clock_div_reg[] = {  4, 2, 1};
+
+int airoha8250_set_baud_rate(struct uart_port *port,
+			     unsigned int baud, unsigned int hs)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int xyd_x, nom, denom;
+
+	int i;
+	/* set DLAB to access the baud rate divider registers (BRDH, BRDL) */
+	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
+	/* set baud rate calculation defaults */
+	/* set BRDIV ([BRDH,BRDL]) to 1 */
+	serial_port_out(port, UART_BRDL, UART_BRDL_20M);
+	serial_port_out(port, UART_BRDH, UART_BRDH_20M);
+	/* calculate XYD_x and XINCLKDR register
+	 * for the HSUART xyd_x needs to be scale by a factor of 2
+	 */
+	for (i = 0 ; i < CLOCK_DIV_TAB_ELEMS ; i++) {
+		denom = (XINDIV_CLOCK/40) / clock_div_tab[i];
+		nom = (baud * (XYD_Y/40));
+		xyd_x = ((nom/denom) << 4) >> hs;
+		if (xyd_x < XYD_Y)
+			break;
+	}
+	serial_port_out(port, UART_XINCLKDR, clock_div_reg[i]);
+	serial_port_out(port, UART_XYD, (xyd_x<<16) | XYD_Y);
+	/* unset DLAB */
+	serial_port_out(port, UART_LCR, up->lcr);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(airoha8250_set_baud_rate);
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
index 1ea52fce9bf1..00163a3d35cd 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -319,6 +319,22 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
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
@@ -2847,6 +2863,16 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial8250_set_divisor(port, baud, quot, frac);
 
+
+	/*
+	 * Airoha SoCs have custom registers for baud rate settings
+	 */
+#ifdef CONFIG_SERIAL_8250_AIROHA
+	if (port->type == PORT_AIROHA)
+		airoha8250_set_baud_rate(port, baud, 0);
+	if (port->type == PORT_AIROHA_HS)
+		airoha8250_set_baud_rate(port, baud, 1);
+#endif
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
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index e0717c8393d7..33e7e1922149 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -195,6 +195,7 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot);
 int fsl8250_handle_irq(struct uart_port *port);
+int airoha8250_set_baud_rate(struct uart_port *port, unsigned int baud, unsigned int hs);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 9c007a106330..c71fb338accb 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -231,6 +231,12 @@
 /* Sunplus UART */
 #define PORT_SUNPLUS	123
 
+/* Airoha UART */
+#define PORT_AIROHA	124
+
+/* Airoha HSUART */
+#define PORT_AIROHA_HS	125
+
 /* Generic type identifier for ports which type is not important to userspace. */
 #define PORT_GENERIC	(-1)
 
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 9c987b04e2d0..72a71e171602 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -383,5 +383,14 @@
 #define UART_ALTR_EN_TXFIFO_LW	0x01	/* Enable the TX FIFO Low Watermark */
 #define UART_ALTR_TX_LOW	0x41	/* Tx FIFO Low Watermark */
 
+/*
+ * These are definitions for the Airoha UART
+ * Normalized because of 32 bit registers.
+ */
+#define UART_BRDL		0
+#define UART_BRDH		1
+#define UART_XINCLKDR		10
+#define UART_XYD		11
+
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
2.34.1

