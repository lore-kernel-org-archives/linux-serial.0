Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012007.outbound.protection.outlook.com [52.101.126.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F95318B9B;
	Mon,  4 May 2026 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884590; cv=fail; b=VOF8cEziI73Varn5DgUb7QNzv74YsI6LPkSeidYVxhIdo3sGLuZneyIVEuTGol4IO9bmY4+OfmnIQRSHYcHghf1NiH3A2RCT9w5oTPVBHDJwQrqEFX930H3IqS7Bu2tWlehAAtMN2eAqL+sowL/TQfczrukGt/2eKP07Xcc3+sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884590; c=relaxed/simple;
	bh=PreglOf6gsla9yNQ22n51jnAXR8en40NWwcD3xHuW2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQ10YGd31C7VSAVBj1HdEi/cXO4yumuGs1Oi4qFMtkYyCKMNGPpW+AuY3jFpO/2FOQeXRODnKx+aOQZ9n0OLbmogrNDj7CTKu0ZvptpK7kqTGcKqO+IAUgnQY2c4R1jGp2qdJCI3J1K4pBlVloYY3ssjOfkz4VItM8KF6AUd4m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=XtRgkdeA; arc=fail smtp.client-ip=52.101.126.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="XtRgkdeA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLXd/IPOYIbTh5rjDC5FsYpan6laLP9vNFz7JK/45r5ZXZD024tOP2dYMDgHEpS7+LXXSWL8N9EhnW3Xf9NjUngdIx3daBxzud6CXlOHpHyHgcXtT5QSXtg3V6rm/8qf9gRGw7CX3K2lCwEMEQ4B19UfDaBI5zE2Ksx75P6xMcMU9RtsNJovF1NcBjJYxGlENyINXTIQHpvfyjfSqwlDo9V1HulFjuTDxne0NwXu9bRjxUFyCStHn2pdP3aSVq4jw6eWwPBFRQswGKFiwbFV+xUjT1/uUFzqGWFMFQ8wZpIEoYYTvzdKvaC8ihzHx23sKNzygVrvTGros8hpAUHJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Fpcw9Ce5B3vTwfBTHvnNlYX1RlRSGX2gESz4cdXQTs=;
 b=negK0wrmn5UlETZq1roVsZ5BOEM2jMzHAak6oRP0MZBnXCyuGXcGcO/uM8GRnGylXYe9+bdWCK3Jx5JqjdC/MxA7AcnDetmcTsN9KaSIot4X5ZKoRYJ+JhyGYqejZ7U4SfnNMAGyIRk2P0ImZ/ARuTyXscAOtf7dPzrvj4hksmxj1C02U8MVqEaVFju2lpx7o4I90KUwYyw8k/X+rUbgP2tcgQxVo/pZ2bOQHAQsQA1QEsOPneYaCH4YbcbQMyxw0vN9Y5zRjSSn0edU6BM8Ytv6nAAaQI40kz2XG5OfNgHtsPV1uc5CTG99PFeEW4sNR/Ruys2dVKCUQr7OiVno4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Fpcw9Ce5B3vTwfBTHvnNlYX1RlRSGX2gESz4cdXQTs=;
 b=XtRgkdeAKmkvI636YuBfs6Nq0fTyQzjU+KR6U+1nmRnLaZEDMIqXp5w3yRocKsObtUW79kTQpHwh4OchbJ+geU2h3/URrdxKmxhtFAF6qZPDBSvbaOockposYmLpgnAqfGnoHi0rdCWvEldwwSq2shksJTo6cqqgpfWMHrhmp5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by OSQPR01MB7823.apcprd01.prod.exchangelabs.com
 (2603:1096:604:425::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:49:44 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:49:44 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 01/15] serial: 8250: split Moxa PCIe serial board support out of 8250_pci
Date: Mon,  4 May 2026 16:48:46 +0800
Message-ID: <20260504084900.22380-2-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|OSQPR01MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 364ebc39-d584-4e99-cc61-08dea9ba16a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	y7TPcerlc5Z4HKJOj3Xmj4Mx1Gzlq71crGB7ggfrO3sJV7dBMDu5mCgCZbxjWn1o/4AGv+46zDnSw08MNPOmMA0xbLxYd8ovriazlBuqQY7NdcAPCab8jNP2YkLCl05JeUQImJ9ANwme5YKtStS4H+hNHuQSFSY39trmY2Gpq5CZG4iI45qHmhXwJCsMmtt/zuYUFN8+6LGHDw250wW+EbUwYvMJbcVzCUONeAJ60isC9f3oCJbyOTagK2gAThwugh42Uw9gAGxG1KdOBh8LmOgCQ7Cp7TcFL6iWqAdXB86yDXyeuLTSRlFAcgj8OlaXX0QJQo+WggwhJyJzHi2aDW9nMPVWNwEOY01zKceI3MwD0lz9z05VcVqiiCvgrYxXxkV6jf2Bja3TDCRnlaBKkqeHzeEZkKrszbwEW3Ai0F++NZZL23PRdPQjM2oapDrzpLeJSe8olugRQf3wlqQrMZG19zwWBv6mdna9o+MzU/k27+RsHbEUFSNJwFztoGTYfnkRPaLzB1OMhL6MzRB8dQuInk9KQsLVvBBpkug31ZE+G7FnghpIR9p50vuMOsigwrAHWpjvbGoU8rM2Dj/RanajLdqpFSh5luvNW7U47BgvJdHdA7QLONwTcHUVdHHLoXfeWlmrbiowm4YCE1TMUgyrvYxZhnQDvTs66EUfynFgCX+o7qZb97UYwRajap23gOReIayUMH/obvKFIoxIX8rRkIlzi94jjGao8APKphF6g77H03oumR7cvjtrjSW8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ANbeJY8bmHNj3Qh20TyLIH+32csqnkB7N0/nkF1KZ7vKO1Uu+pHKv70gOboZ?=
 =?us-ascii?Q?o4zSFqIdCZeuTR8RpVbmU5V+oRnweBZzWZqbsVgrg32/LwHGFwG8Uz7Xe5dq?=
 =?us-ascii?Q?Ub7AEnskuxvLf4Ad3H3S8zYV7f+rZ0Cj/uuyREenzQ9IJhK/JWD6tJ4BoAmG?=
 =?us-ascii?Q?m0/ZUERDV8N9Zj0f4uOFncB0++9wmli6Zuf4Khpw0iHuTkp2fvjvx2MYc0pE?=
 =?us-ascii?Q?XbHHYcdvz6jDLuaAp0xA1Z2Bb/tT1E5jXJL3/QW16/ohfKXWAH8lJQZV1QuH?=
 =?us-ascii?Q?svCeeZX344ljVZEgMfqnlIwcXeall+5JbjM4h0yqdC48+OCNuXxPG+OC06lx?=
 =?us-ascii?Q?QjbzAurY72ylV+RCWmRjWpNAIJCPenltrSOPJvBVqRPI4hX/AibivaKF+o71?=
 =?us-ascii?Q?rAsi06sIaOaaRsGsg7BBANL56x5OeG1O9BiNO9EEVce6Mdf7cuYNvM6xsO/m?=
 =?us-ascii?Q?vQQHGen0eB/+FPl9uSFxwnGbZBDNa2jCuNcQAMSovmms6VBwk4uKSY3Ns+1u?=
 =?us-ascii?Q?sxiNA277QdmUfxhTijx5F7JbZhvRxFqWCqPPcryKMv9VrUGeHvVVp0YiVuc3?=
 =?us-ascii?Q?uY52G01f5eunTqoNI2bRgONbWsK155JVBXfKVTIqdIVovM4MJr1C2nPyMsuh?=
 =?us-ascii?Q?cH3SfBiFholo7jBy/KEaWvmt9v2nnxFSgBZMJSSrLEGZ3DwYAzqIFzl+yRtc?=
 =?us-ascii?Q?Zkz4YGHxJKFG6F8r6806yn2zC1tOxK/nahAvZZ+WghLvUYfK4N7FBkGULxwq?=
 =?us-ascii?Q?k9NmeaqRZK4XUV0cnf4I1NkrP0IAge3d6UtLiDrllRF0URitfGxTqJFk6Z4L?=
 =?us-ascii?Q?pggjQNzjfwY6C8gZI1n1f01dAexkUwUBIu34YZRQB/bKx1Z/hOkKLpueD6TY?=
 =?us-ascii?Q?jcKBMSIrVeykNSXFEG01DwsK329Ki+MUkuEYqA0ZjZGF6rgw8/nm4FulipXZ?=
 =?us-ascii?Q?7YHwhbOuVKZfe6GnePYM4xDQ9jJ4jyWS5z9iMSJSG6rQMIDE2tXOm1jeBdTS?=
 =?us-ascii?Q?abNOATgV1/rZ1LI03hoRAB85zLYTwFhrxhqdD6F14NM5nMdY3oBr/uqD1ef4?=
 =?us-ascii?Q?iV8fKTNUZMXqyIIDVDNYPbmPD7+6Aa66t8X4nz62SUIyl8QJlASTDp6P/C98?=
 =?us-ascii?Q?5tX3n5Wh63Gf+i724dadA+phXf0IAgWMHVqSbvab49o8lW5uC6OVHg/izxab?=
 =?us-ascii?Q?JiG24ePNn1eGci/3iDI78Zmri8YtqR9oiz+L3IvO8CiapgMeMMEUq9+N65p/?=
 =?us-ascii?Q?F4aANRqaWSJ0XIEn8ZZ5XzatIXZHBZ1qrLHJSUcFKAliUSgHY3xOJ+vApvVs?=
 =?us-ascii?Q?bgt0EUr9APwm/Iv8CxGSF5RmGVzts7E7lBJysVSEwhPUJAQGvqsbKATZcYQ5?=
 =?us-ascii?Q?Tl5Et+hrNmy+VVmxYEDMz+RQbOVACKJc17a+a+g0RkuVF8i0+9YTqsZARzr9?=
 =?us-ascii?Q?mAoAuD0CB2TIyd++2JW4e+W1kO+6U0EsgwtUoIJoozFiFCqwaC687ZhkttaN?=
 =?us-ascii?Q?1JSuUzidxA0g4vUyManaKYTw+8bxCsR572NbaC1PMtp59uaG3k83LEhi37Sw?=
 =?us-ascii?Q?cAVNEKawVGiPzo+esFJiTRBlgMbUPGgKdULIsd45GsjViYkzAcubl0Zi3bmB?=
 =?us-ascii?Q?kuHiGmdFqux/ROFiLOo4v0df2rQd/V/zkxvUxYcyZq/71j8zi+IATcISYO+y?=
 =?us-ascii?Q?UZNTXsswooBiRbGuGl7O9qLOrjS08F/+SblwKXnGpKQClsPgLVjJoQ5vaCwi?=
 =?us-ascii?Q?YrnnEGyZSSArPc0r4PE0QNPB1vQ6lG0=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364ebc39-d584-4e99-cc61-08dea9ba16a3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:49:44.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnWeFg/S0BW4ArMD+xrUnZIkT0PwFO0ckrDhkg+wROe/gvX8GG11UAUZj29QxRrtUCTaB19S0SXMQnbUC2l+4N+M3hWROb7SndhDDOzMKHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB7823

The Moxa PCIe multiport serial boards are currently handled as part of
8250_pci.c. In preparation for adding Moxa-specific UART features and
optimizations, move the Moxa PCIe implementation into a dedicated
driver.

This introduces drivers/tty/serial/8250/8250_mxpcie.c and wires it up
via Kconfig and Makefile, while preserving the existing probe flow and
device IDs.

This change was suggested during earlier review by Andy Shevchenko.

No functional change intended.

Link: https://lore.kernel.org/all/ZmQovC6TbDpTb3c8@surfacebook.localdomain/
Link: https://lore.kernel.org/all/CAHp75VeDsVt0GQYUFxLM+obfmqXBPa3hM3YMsFbc26uzWZG-SQ@mail.gmail.com/
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 292 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c    | 208 +-----------------
 drivers/tty/serial/8250/Kconfig       |  11 +
 drivers/tty/serial/8250/Makefile      |   1 +
 4 files changed, 307 insertions(+), 205 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_mxpcie.c

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
new file mode 100644
index 000000000000..aa0afdbed791
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Moxa PCIe multiport serial device driver
+ *
+ * Copyright (C) 2025 Moxa Inc. (support@moxa.com)
+ * Author: Crescent Hsieh <crescentcy.hsieh@moxa.com>
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/types.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/8250_pci.h>
+
+#include "8250.h"
+#include "8250_pcilib.h"
+
+#define PCI_DEVICE_ID_MOXA_CP102E	0x1024
+#define PCI_DEVICE_ID_MOXA_CP102EL	0x1025
+#define PCI_DEVICE_ID_MOXA_CP102N	0x1027
+#define PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
+#define PCI_DEVICE_ID_MOXA_CP104N	0x1046
+#define PCI_DEVICE_ID_MOXA_CP112N	0x1121
+#define PCI_DEVICE_ID_MOXA_CP114EL	0x1144
+#define PCI_DEVICE_ID_MOXA_CP114N	0x1145
+#define PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
+#define PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
+#define PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
+#define PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
+#define PCI_DEVICE_ID_MOXA_CP132EL	0x1322
+#define PCI_DEVICE_ID_MOXA_CP132N	0x1323
+#define PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
+#define PCI_DEVICE_ID_MOXA_CP134N	0x1343
+#define PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
+#define PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
+
+/* Bits in PCI device ID encoding board capabilities */
+#define MOXA_DEV_ID_IFACE_MASK	GENMASK(11, 8)	/* Supported serial interface */
+#define MOXA_DEV_ID_NPORTS_MASK	GENMASK(7, 4)	/* Number of UART ports */
+
+/* UART */
+#define MOXA_PUART_BASE_BAUD	921600
+#define MOXA_PUART_OFFSET	0x200
+
+#define MOXA_GPIO_DIRECTION	0x09
+#define MOXA_GPIO_OUTPUT	0x0A
+
+#define MOXA_GPIO_PIN2	BIT(2)
+
+#define MOXA_UIR_OFFSET		0x04
+#define MOXA_UIR_RS232		0x00
+#define MOXA_UIR_RS422		0x01
+#define MOXA_UIR_RS485_4W	0x0B
+#define MOXA_UIR_RS485_2W	0x0F
+
+#define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
+#define MOXA_ODD_RS_MASK	GENMASK(7, 4)
+
+struct mxpcie8250 {
+	unsigned int supp_rs;
+	unsigned int num_ports;
+	void __iomem *bar1_base; /* UART registers (MMIO) */
+	void __iomem *bar2_base; /* UIR / GPIO / CPLD (IO) */
+	int line[];
+};
+
+enum {
+	MOXA_SUPP_RS232 = BIT(0),
+	MOXA_SUPP_RS422 = BIT(1),
+	MOXA_SUPP_RS485 = BIT(2),
+};
+
+static bool mxpcie8250_is_mini_pcie(unsigned short device)
+{
+	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
+	    device == PCI_DEVICE_ID_MOXA_CP104N ||
+	    device == PCI_DEVICE_ID_MOXA_CP112N ||
+	    device == PCI_DEVICE_ID_MOXA_CP114N ||
+	    device == PCI_DEVICE_ID_MOXA_CP132N ||
+	    device == PCI_DEVICE_ID_MOXA_CP134N)
+		return true;
+
+	return false;
+}
+
+static unsigned int mxpcie8250_get_supp_rs(unsigned short device)
+{
+	switch (device & MOXA_DEV_ID_IFACE_MASK) {
+	case 0x0000:
+	case 0x0600:
+		return MOXA_SUPP_RS232;
+	case 0x0100:
+		return MOXA_SUPP_RS232 | MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
+	case 0x0300:
+		return MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
+	}
+
+	return 0;
+}
+
+static unsigned short mxpcie8250_get_nports(unsigned short device)
+{
+	switch (device) {
+	case PCI_DEVICE_ID_MOXA_CP116E_A_A:
+	case PCI_DEVICE_ID_MOXA_CP116E_A_B:
+		return 8;
+	}
+
+	return FIELD_GET(MOXA_DEV_ID_NPORTS_MASK, device);
+}
+
+static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
+				     unsigned int port_idx,
+				     u8 mode)
+{
+	void __iomem *uir_addr = priv->bar2_base + MOXA_UIR_OFFSET + port_idx / 2;
+	u8 cval;
+
+	cval = ioread8(uir_addr);
+
+	if (port_idx & 1)
+		cval = FIELD_MODIFY(MOXA_ODD_RS_MASK, &cval, mode);
+	else
+		cval = FIELD_MODIFY(MOXA_EVEN_RS_MASK, &cval, mode);
+
+	iowrite8(cval, uir_addr);
+}
+
+static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
+{
+	void __iomem *bar2_base = priv->bar2_base;
+	unsigned short device = pdev->device;
+	u8 cval;
+
+	/* Initial terminator */
+	if (device == PCI_DEVICE_ID_MOXA_CP114EL ||
+	    device == PCI_DEVICE_ID_MOXA_CP118EL_A) {
+		iowrite8(0xff, bar2_base + MOXA_GPIO_DIRECTION);
+		iowrite8(0x00, bar2_base + MOXA_GPIO_OUTPUT);
+	}
+	/*
+	 * Enable hardware buffer to prevent break signal output when system boots up.
+	 * This hardware buffer is only supported on Mini PCIe series.
+	 */
+	if (mxpcie8250_is_mini_pcie(device)) {
+		/* Set GPIO direction */
+		cval = ioread8(bar2_base + MOXA_GPIO_DIRECTION);
+		cval |= MOXA_GPIO_PIN2;
+		iowrite8(cval, bar2_base + MOXA_GPIO_DIRECTION);
+		/* Enable low GPIO */
+		cval = ioread8(bar2_base + MOXA_GPIO_OUTPUT);
+		cval &= ~MOXA_GPIO_PIN2;
+		iowrite8(cval, bar2_base + MOXA_GPIO_OUTPUT);
+	}
+}
+
+static void mxpcie8250_setup_port(struct pci_dev *pdev,
+				  struct mxpcie8250 *priv,
+				  struct uart_8250_port *up,
+				  int idx)
+{
+	unsigned short device = pdev->device;
+	int offset = idx * MOXA_PUART_OFFSET;
+	u8 init_mode = MOXA_UIR_RS232;
+
+	if (!(priv->supp_rs & MOXA_SUPP_RS232))
+		init_mode = MOXA_UIR_RS422;
+
+	mxpcie8250_set_interface(priv, idx, init_mode);
+
+	if (idx == 3 &&
+	    (device == PCI_DEVICE_ID_MOXA_CP104EL_A ||
+	     device == PCI_DEVICE_ID_MOXA_CP114EL   ||
+	     device == PCI_DEVICE_ID_MOXA_CP134EL_A))
+		offset = 7 * MOXA_PUART_OFFSET;
+
+	up->port.mapbase = pci_resource_start(pdev, FL_BASE1) + offset;
+	up->port.membase = pcim_iomap_table(pdev)[FL_BASE1] + offset;
+}
+
+static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct uart_8250_port up = {};
+	struct mxpcie8250 *priv;
+	unsigned short device = pdev->device;
+	unsigned int i, num_ports;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	num_ports = mxpcie8250_get_nports(device);
+
+	priv = devm_kzalloc(dev, struct_size(priv, line, num_ports), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->supp_rs = mxpcie8250_get_supp_rs(device);
+	priv->num_ports = num_ports;
+
+	priv->bar1_base = pcim_iomap(pdev, FL_BASE1, 0);
+	if (!priv->bar1_base)
+		return -ENOMEM;
+
+	priv->bar2_base = pcim_iomap(pdev, FL_BASE2, 0);
+	if (!priv->bar2_base)
+		return -ENOMEM;
+
+	mxpcie8250_init_board(pdev, priv);
+
+	up.port.dev = dev;
+	up.port.irq = pdev->irq;
+	up.port.uartclk = MOXA_PUART_BASE_BAUD * 16;
+	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+
+	up.port.iotype = UPIO_MEM;
+	up.port.iobase = 0;
+	up.port.regshift = 0;
+
+	for (i = 0; i < num_ports; i++) {
+		mxpcie8250_setup_port(pdev, priv, &up, i);
+
+		dev_dbg(dev, "Setup PCI port: port %lx, irq %d, type %d\n",
+			up.port.iobase, up.port.irq, up.port.iotype);
+
+		priv->line[i] = serial8250_register_8250_port(&up);
+		if (priv->line[i] < 0) {
+			dev_err(dev,
+				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
+				up.port.iobase, up.port.irq,
+				up.port.iotype, priv->line[i]);
+			break;
+		}
+	}
+	dev_set_drvdata(dev, priv);
+
+	return 0;
+}
+
+static void mxpcie8250_remove(struct pci_dev *pdev)
+{
+	struct mxpcie8250 *priv = dev_get_drvdata(&pdev->dev);
+	unsigned int i;
+
+	for (i = 0; i < priv->num_ports; i++)
+		serial8250_unregister_port(priv->line[i]);
+}
+
+static const struct pci_device_id mxpcie8250_pci_ids[] = {
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102E) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102EL) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102N) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104N) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112N) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114EL) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114N) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132N) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134N) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138E_A) },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, mxpcie8250_pci_ids);
+
+static struct pci_driver mxpcie8250_pci_driver = {
+	.name		= "8250_mxpcie",
+	.id_table	= mxpcie8250_pci_ids,
+	.probe		= mxpcie8250_probe,
+	.remove		= mxpcie8250_remove,
+};
+module_pci_driver(mxpcie8250_pci_driver);
+
+MODULE_AUTHOR("Moxa Inc.");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Moxa PCIe Multiport Serial Device Driver");
+MODULE_IMPORT_NS("SERIAL_8250_PCI");
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 152f914c599d..fa172477409a 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -76,25 +76,6 @@
 #define PCI_DEVICE_ID_WCHIC_CH384_4S	0x3470
 #define PCI_DEVICE_ID_WCHIC_CH384_8S	0x3853
 
-#define PCI_DEVICE_ID_MOXA_CP102E	0x1024
-#define PCI_DEVICE_ID_MOXA_CP102EL	0x1025
-#define PCI_DEVICE_ID_MOXA_CP102N	0x1027
-#define PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
-#define PCI_DEVICE_ID_MOXA_CP104N	0x1046
-#define PCI_DEVICE_ID_MOXA_CP112N	0x1121
-#define PCI_DEVICE_ID_MOXA_CP114EL	0x1144
-#define PCI_DEVICE_ID_MOXA_CP114N	0x1145
-#define PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
-#define PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
-#define PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
-#define PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
-#define PCI_DEVICE_ID_MOXA_CP132EL	0x1322
-#define PCI_DEVICE_ID_MOXA_CP132N	0x1323
-#define PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
-#define PCI_DEVICE_ID_MOXA_CP134N	0x1343
-#define PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
-#define PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
-
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1588	0x1588
@@ -1994,138 +1975,6 @@ pci_sunix_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }
 
-#define MOXA_PUART_GPIO_EN	0x09
-#define MOXA_PUART_GPIO_OUT	0x0A
-
-#define MOXA_GPIO_PIN2	BIT(2)
-
-#define MOXA_RS232	0x00
-#define MOXA_RS422	0x01
-#define MOXA_RS485_4W	0x0B
-#define MOXA_RS485_2W	0x0F
-#define MOXA_UIR_OFFSET	0x04
-#define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
-#define MOXA_ODD_RS_MASK	GENMASK(7, 4)
-
-enum {
-	MOXA_SUPP_RS232 = BIT(0),
-	MOXA_SUPP_RS422 = BIT(1),
-	MOXA_SUPP_RS485 = BIT(2),
-};
-
-static unsigned short moxa_get_nports(unsigned short device)
-{
-	switch (device) {
-	case PCI_DEVICE_ID_MOXA_CP116E_A_A:
-	case PCI_DEVICE_ID_MOXA_CP116E_A_B:
-		return 8;
-	}
-
-	return FIELD_GET(0x00F0, device);
-}
-
-static bool pci_moxa_is_mini_pcie(unsigned short device)
-{
-	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
-	    device == PCI_DEVICE_ID_MOXA_CP104N	||
-	    device == PCI_DEVICE_ID_MOXA_CP112N	||
-	    device == PCI_DEVICE_ID_MOXA_CP114N ||
-	    device == PCI_DEVICE_ID_MOXA_CP132N ||
-	    device == PCI_DEVICE_ID_MOXA_CP134N)
-		return true;
-
-	return false;
-}
-
-static unsigned int pci_moxa_supported_rs(struct pci_dev *dev)
-{
-	switch (dev->device & 0x0F00) {
-	case 0x0000:
-	case 0x0600:
-		return MOXA_SUPP_RS232;
-	case 0x0100:
-		return MOXA_SUPP_RS232 | MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
-	case 0x0300:
-		return MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
-	}
-	return 0;
-}
-
-static int pci_moxa_set_interface(const struct pci_dev *dev,
-				  unsigned int port_idx,
-				  u8 mode)
-{
-	resource_size_t iobar_addr = pci_resource_start(dev, 2);
-	resource_size_t UIR_addr = iobar_addr + MOXA_UIR_OFFSET + port_idx / 2;
-	u8 val;
-
-	val = inb(UIR_addr);
-
-	if (port_idx % 2) {
-		val &= ~MOXA_ODD_RS_MASK;
-		val |= FIELD_PREP(MOXA_ODD_RS_MASK, mode);
-	} else {
-		val &= ~MOXA_EVEN_RS_MASK;
-		val |= FIELD_PREP(MOXA_EVEN_RS_MASK, mode);
-	}
-	outb(val, UIR_addr);
-
-	return 0;
-}
-
-static int pci_moxa_init(struct pci_dev *dev)
-{
-	unsigned short device = dev->device;
-	resource_size_t iobar_addr = pci_resource_start(dev, 2);
-	unsigned int i, num_ports = moxa_get_nports(device);
-	u8 val, init_mode = MOXA_RS232;
-
-	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
-		return serial_8250_warn_need_ioport(dev);
-
-	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
-		init_mode = MOXA_RS422;
-	}
-	for (i = 0; i < num_ports; ++i)
-		pci_moxa_set_interface(dev, i, init_mode);
-
-	/*
-	 * Enable hardware buffer to prevent break signal output when system boots up.
-	 * This hardware buffer is only supported on Mini PCIe series.
-	 */
-	if (pci_moxa_is_mini_pcie(device)) {
-		/* Set GPIO direction */
-		val = inb(iobar_addr + MOXA_PUART_GPIO_EN);
-		val |= MOXA_GPIO_PIN2;
-		outb(val, iobar_addr + MOXA_PUART_GPIO_EN);
-		/* Enable low GPIO */
-		val = inb(iobar_addr + MOXA_PUART_GPIO_OUT);
-		val &= ~MOXA_GPIO_PIN2;
-		outb(val, iobar_addr + MOXA_PUART_GPIO_OUT);
-	}
-
-	return num_ports;
-}
-
-static int
-pci_moxa_setup(struct serial_private *priv,
-		const struct pciserial_board *board,
-		struct uart_8250_port *port, int idx)
-{
-	unsigned int bar = FL_GET_BASE(board->flags);
-	int offset;
-
-	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
-		return serial_8250_warn_need_ioport(priv->dev);
-
-	if (board->num_ports == 4 && idx == 3)
-		offset = 7 * board->uart_offset;
-	else
-		offset = idx * board->uart_offset;
-
-	return setup_port(priv, port, bar, offset, 0);
-}
-
 /*
  * Master list of serial port init/setup/exit quirks.
  * This does not describe the general nature of the port.
@@ -2941,17 +2790,6 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.setup		= pci_fintek_setup,
 		.init		= pci_fintek_init,
 	},
-	/*
-	 * MOXA
-	 */
-	{
-		.vendor		= PCI_VENDOR_ID_MOXA,
-		.device		= PCI_ANY_ID,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_moxa_init,
-		.setup		= pci_moxa_setup,
-	},
 	{
 		.vendor		= 0x1c29,
 		.device		= 0x1204,
@@ -3169,9 +3007,6 @@ enum pci_board_num_t {
 	pbn_titan_2_4000000,
 	pbn_titan_4_4000000,
 	pbn_titan_8_4000000,
-	pbn_moxa_2,
-	pbn_moxa_4,
-	pbn_moxa_8,
 };
 
 /*
@@ -3943,24 +3778,6 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
-	[pbn_moxa_2] = {
-		.flags		= FL_BASE1,
-		.num_ports      = 2,
-		.base_baud      = 921600,
-		.uart_offset	= 0x200,
-	},
-	[pbn_moxa_4] = {
-		.flags		= FL_BASE1,
-		.num_ports      = 4,
-		.base_baud      = 921600,
-		.uart_offset	= 0x200,
-	},
-	[pbn_moxa_8] = {
-		.flags		= FL_BASE1,
-		.num_ports      = 8,
-		.base_baud      = 921600,
-		.uart_offset	= 0x200,
-	},
 };
 
 #define REPORT_CONFIG(option) \
@@ -4014,6 +3831,9 @@ static const struct pci_device_id blacklist[] = {
 	{ PCI_VDEVICE(PERICOM, PCI_ANY_ID), REPORT_8250_CONFIG(PERICOM), },
 	{ PCI_VDEVICE(ACCESSIO, PCI_ANY_ID), REPORT_8250_CONFIG(PERICOM), },
 
+	/* Moxa devices */
+	{ PCI_VDEVICE(MOXA, PCI_ANY_ID), REPORT_8250_CONFIG(MOXA), },
+
 	/* End of the black list */
 	{ }
 };
@@ -5851,28 +5671,6 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_ni8430_4 },
 
-	/*
-	 * MOXA
-	 */
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102E),	    pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102EL),    pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102N),	    pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A),  pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104N),	    pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112N),	    pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114EL),    pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114N),	    pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A), pbn_moxa_8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B), pbn_moxa_8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A),  pbn_moxa_8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I), pbn_moxa_8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132N),     pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A),  pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134N),	    pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),   pbn_moxa_8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),  pbn_moxa_8 },
-
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
 	*/
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f64ef0819cd4..7cf8547d18f6 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -157,6 +157,17 @@ config SERIAL_8250_EXAR
 	  422x PCIe serial cards that are not covered by the more generic
 	  SERIAL_8250_PCI option.
 
+config SERIAL_8250_MOXA_PCIE
+	tristate "8250/16550 Moxa PCIe device support"
+	depends on SERIAL_8250 && PCI
+	select SERIAL_8250_PCILIB
+	default SERIAL_8250
+	help
+	  Say Y here if you have a Moxa PCIe serial card.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called 8250_mxpcie.
+
 config SERIAL_8250_HP300
 	tristate
 	depends on SERIAL_8250 && HP300
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 9ec4d5fe64de..be78fd6b337a 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_SERIAL_8250_LPC18XX)	+= 8250_lpc18xx.o
 obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
+obj-$(CONFIG_SERIAL_8250_MOXA_PCIE)	+= 8250_mxpcie.o
 obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
 obj-$(CONFIG_SERIAL_8250_NI)		+= 8250_ni.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
-- 
2.43.0

