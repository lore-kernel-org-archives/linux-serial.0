Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012069.outbound.protection.outlook.com [40.107.75.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775BF368D79;
	Wed,  1 Jul 2026 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877415; cv=fail; b=hBPUQMBFHmMQBce/Gw1JdsjsiCfbKcZGtJKhJGQwWl3Je9dAiKPKxEu87lzs13Dea8m03xG1+2tyMe6pc0C5UoaoMs7yKpj19YCOQWUFmCm9OcPMX/tPiKFfWnDr/WQSy2VyfvL80+gMUMpRleuyg4YG0jM3x23G67HYLxk5QVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877415; c=relaxed/simple;
	bh=I5V/X4UW9lgIfZzY/IoaFKmZmGlovhZzcKWtErxXQsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MDi3a8CMHtRUav6Qfp+52FV9y+EbVZO/yBzAmTRe5O/74ctNOhtFtiQnVXhv4jSI5KraiH+EIMsNiYz7oqkaayFYikHHUok7s4YvSgmwWjAZ5QDJx0/ssOSXTHh+p9BZDRIPFlgHKWVjchp06BWUe0DwND6ksF91Dct/rDjJncY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Qpoei/QH; arc=fail smtp.client-ip=40.107.75.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Qpoei/QH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnbLqBbtVU6lzu8uzPU5bnA/kibTafJFozx95bVh7sZnWmKC+xdb5E6midQmE2K8bFtV+V77d9p09px48vppG+C5WotIN0HfIOpzc1cHjUYY6UhedFtV+VSjY5rfaLciyl284+O8uGhg9QqZ09MN0s3lPEhV4jcu1c1lQiIOuKlMxU8zVAvMUpR6bejq7iLRu3PVt4xKelMIxaYyRRCIdIXVIACVBUHWb0l5LkT5pj7DaeustmfgZz8dKzQriPWe51X+Ko0IFiT5cg0SxMUXcVQKqJ2+yiK3Wjs/JxFBhrEt+bj8hnuzx0dtkWPVtDnafWU5XuKllQdNxcivZqu8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eMTpTaJFKYUfG+w3ekUOSVoLyCuxN19BQhJyzjDvaE=;
 b=Z691Sw7FF1h1YulSgC2avFNuDaEWfpNx8ZEDgfC9nEZqYXGrfm7smcAIkV4vBaVc9A0HFokAcQTBjN3shrrQbm78+blruMvmwu/XlO57s/978HP7dhrnAwXG22CPQoiUuqXoo2EAXH0WqiW7gQv/0bZukWmn5VZs40M1P4pQR12aPB7KgSuHYkpGle1a89a4zRMSRQM4A09bFoGs8ekdHAqpKy5eCZeR1dqtRl1qm15Dr9FFoATB1xS8rk4lSmGNljdRp/ITISyLfofVrIvP1IePPVGRI21oFnAtkDE7SjRx9mAtX6YVtt/8L+RibFm3BcpTYF0H67TBXSKpyoUaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eMTpTaJFKYUfG+w3ekUOSVoLyCuxN19BQhJyzjDvaE=;
 b=Qpoei/QH5q+JbBGAxE4RyHf0CHFyjpFut6DFGFzJw6GunLEWdXzjVrVaJSV10eJIOHdpOa+oQ+z1TPqafR9rjMY6/Oh1jWKUA+5I1ZdpJeuOPnRJH2ADjCoTsM0gKqPC0kgxkv9vDi62deWpgdbhXATLwJYqTi3pCAqDSv516DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:43:31 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:43:31 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 01/15] serial: 8250: split Moxa PCIe serial board support out of 8250_pci
Date: Wed,  1 Jul 2026 11:41:14 +0800
Message-ID: <20260701034128.218569-2-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KUXPR01MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0012f9-ff39-4fe3-b7bf-08ded722eb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|3023799007|6133799003|56012099006|18002099003|4133799003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	d+bjbkJw32KdPm4ElGyMQPoEwUSySb4KbkRDhIEIlTBIfMFlHnBQdLfpJCI0gSCVblr4exOXBNMfPim+sn5uDMA3lYxpRAIhsBhWIBaoaUODSA41barOd7Kjt2EdjkwCVI/PqC8jffF2Yz3/zMs6v2qXv9U5CarkfZT5lmCtoOtQSly4b/9vpbrl4cFqCh8S56P4TaWvmrdS85y/PL86KDN+ICD+sZTV6KYusoRkBF7eN7kkaNqfdseZ1ERTP5YLDN0MZVjT9WHLm1BXWmy1FwtwgrMxWf8cN+DWrPPChHOHlg7Zlr088FEV4AnsEV7xWucKCT//is9F5S7tX85WaHxj2LBeZz3qHoMOBUXRIknOb7cIM5wP3MUwNQRS/fmfpi2xW63VYF2zbQWBlpxO8NYgzSZBq3HAjiLKAh5Bt9YhjRbox1U+0LjS3O01W0vxQM5fNU+HjtyxZtXkLTTtPN8EG/1sap5qKCG4M/0gzjgg+qIBXn51XB2x7j5e6ucM1lvJgQjfEBXWmp1Rr/2LHEaBvYpFzx0AYm3WCysZoCTojALq2RcqrDrfO6SzK4vpQBeUKEVrXIn/f/BhRvZWVrmUg7qTU5ZQyVQ01Tx5g0yU52kCS72yoTvwnkH+9zj44mFs5t7HDuFGWDzFL5t27NFqaUw0mcjsSH7wpxxmYecVNx+QNHDLOPxf04Yt8gQ0xbv+7qaYv25/gR6LmhNa3HnaK9iAtrr3qvC0VWC1BwA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(3023799007)(6133799003)(56012099006)(18002099003)(4133799003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mf8QzZl4yR5L6sMbhzawOg5wNE5JzBycPJgorezqZ3fXDc4HeWvDNx0Z1zrb?=
 =?us-ascii?Q?YAV2czcE6wiHZlG4/UypJIaYk+0+9KqBNEXXW2UpQ8TulZfQUijNoTbj/uPx?=
 =?us-ascii?Q?dkN1UKEmTa0p9T56SAxFuknL26gkJiBsQuiybf5X+qXLXxcK0rM80NyS7Ds6?=
 =?us-ascii?Q?pEhso57ekXv9LA4FV1PNUknCz02UJRfqWEtaRrW6C6PLdXqw878NGknX8eW/?=
 =?us-ascii?Q?1mX5MJ6TiRBvayB3Wug+pfgOUFBFCMR8i8ydHDmjUZK+otTJ1Cc4L1TYMvaY?=
 =?us-ascii?Q?uWyQwuY1zEJ2u1rs37xhdpi8m55RhHihguK2Q+MCKCpnF4o2oFPcItbJ30iA?=
 =?us-ascii?Q?lWiccfdXM8dnhJta/HLmPk88AIMvjX5G6C4Kp8/TQn1g0M4tkGCorj1BYRmd?=
 =?us-ascii?Q?5OqWDokui7k9bMjqXMKrg6r4yULBMTZH1nFkBdutave0qlKoxKighKzZX++W?=
 =?us-ascii?Q?YICik3orQdoxRDhDuFA8xt0thjK8IAhoZLg6QQuoP3WmZJwT2K+dVj8sV+4I?=
 =?us-ascii?Q?pIXTKo0Mgyl0J+7jWy1lO7JqiWgkjMU4mFZuVmqidbE/RhEvrFeFUiGztdgA?=
 =?us-ascii?Q?iH8pB9C0uLmTTxgkm9Usd+jAN2bJ7CttyV1Cv1MCcOaDS1pSLUTm17E9ocFt?=
 =?us-ascii?Q?GgPDOP2Qy6QcqSF+JZHtIDIOwXlwAp/YC42IYrS7xH32dEIwafLzewuGr91p?=
 =?us-ascii?Q?nF1pa6g2h+OfYCx3Cc7pCTSZ0W4GX/hDBQgsNELn9DR+ImwVQdQOewALSHVn?=
 =?us-ascii?Q?CtNa2H60da//mVbOq5XFW18LojJWwMiJkYaYmV7zxKOqRCC3BNrqY3lMIYMF?=
 =?us-ascii?Q?k2aOW1Ey9W+KAVkEvrZSVbqygsEn85XQWjJreIFKteIU2LfvtoDrIFb4Kdh3?=
 =?us-ascii?Q?nd8JnAe9RoY0PPbwWK+QM7eL5SrOL+L8/bOSbTJE4DfeS6J21eDvpzmjwJ8K?=
 =?us-ascii?Q?yLdwAmilOq5VyYV4npY4rkLvHBDg/KCJR7Mm7C5y1xy/R4MGsXFdqIuZwNsK?=
 =?us-ascii?Q?nrTPMLGCLkxlDGNQPXPTnuCal/pVadJLQjym+9SH7MlVKI4DrFPcMeh3wSBi?=
 =?us-ascii?Q?qOjOueqeZC1XNIbEWSRkNGpTzXziD7iFxS8ItQJotKjS1yyGbWoIhXzP88/4?=
 =?us-ascii?Q?cUseIZgEQp4IBLbXKRMqpagsq3hCw1dQXKGXoGbNZP7amX+K9kUT7c+gDtMz?=
 =?us-ascii?Q?eRxCqhVvoCUJbkb2n6Ya06I+Aj7CTtTuCJHwGzGK28Gs0MaK0WuPGqHbCOA3?=
 =?us-ascii?Q?BU87o1SBw7yU9i6qTa1ldNTK6kqhzjNXpCBkyeSJkbdelNgjpXIWC4dCnUIG?=
 =?us-ascii?Q?2IPAjvZvDcZ1jyYinnX1O4f8dKrhw7oU792IgoTfDRxbirnjEhaYICb5Opea?=
 =?us-ascii?Q?3d4//JK/FKyqWNEGF2cf2OunH3AEVlBGND15O45gnPJ3ynAcTk2f3etjiLLw?=
 =?us-ascii?Q?zdYqKJ0BoI1szrurG24iCNlebU8o7r9x0hCC2WXo/wx+rUZvg0nUeXpPkgLu?=
 =?us-ascii?Q?L4iWcHgISXhYzFqnpIIvk8DtrwoLL+wNB1gq/w3AjybTHewyEfgVFzFX56GX?=
 =?us-ascii?Q?kLvBaAPy0NhrT2ylO4NtWrW1gonYrSBxT913i28a/yvR0DCq+zV5Xf/ERwgu?=
 =?us-ascii?Q?qZyaPQi1BZGlQSHYJ7rjhaqqGIJ4QZ+Lg0g+tmVZtkWb6dAChSybD5x/nbx8?=
 =?us-ascii?Q?HzZRc74JYDu3NbKUAciTBphtYRNUI+43Re4XwDQAR6b6eQ3iNNXQh46kRf8H?=
 =?us-ascii?Q?NuzWkCM1vRNbzFrUXqLgStY/rDOGVB0=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0012f9-ff39-4fe3-b7bf-08ded722eb4e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:43:31.2020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xd+qZCrYk+xuIRMKLRzxnCBuV1A/vfBR+bMgfDlNMxk5p2RxSqGBQWnTX8Syk+GqIX65imnB72X3W7q+smcaziFDWvsX0mlzH2AfAhaGSk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

The Moxa PCIe multiport serial boards are currently handled as part of
8250_pci.c. In preparation for adding Moxa-specific UART features and
optimizations, move the Moxa PCIe implementation into a dedicated
driver.

This introduces drivers/tty/serial/8250/8250_mxpcie.c and wires it up
via Kconfig and Makefile, while preserving the existing probe flow and
device IDs.

This change was suggested during earlier reviews by Andy Shevchenko [1][2].

No functional change intended.

Link: https://lore.kernel.org/all/ZmQovC6TbDpTb3c8@surfacebook.localdomain/ [1]
Link: https://lore.kernel.org/all/CAHp75VeDsVt0GQYUFxLM+obfmqXBPa3hM3YMsFbc26uzWZG-SQ@mail.gmail.com/ [2]
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 290 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c    | 208 +-----------------
 drivers/tty/serial/8250/Kconfig       |  11 +
 drivers/tty/serial/8250/Makefile      |   1 +
 4 files changed, 305 insertions(+), 205 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_mxpcie.c

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
new file mode 100644
index 000000000000..7a509e0a2bd7
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Moxa PCIe multiport serial device driver
+ *
+ * Copyright (C) 2025 Moxa Inc. (support@moxa.com)
+ * Author: Crescent Hsieh <crescentcy.hsieh@moxa.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include <linux/8250_pci.h>
+#include <linux/serial_8250.h>
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
+	int line[] __counted_by(num_ports);
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
+	default:
+		return 0;
+	}
+}
+
+static unsigned short mxpcie8250_get_nports(unsigned short device)
+{
+	switch (device) {
+	case PCI_DEVICE_ID_MOXA_CP116E_A_A:
+	case PCI_DEVICE_ID_MOXA_CP116E_A_B:
+		return 8;
+	default:
+		return FIELD_GET(MOXA_DEV_ID_NPORTS_MASK, device);
+	}
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
+	if (port_idx % 2)
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
+	unsigned int num_ports;
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
+	priv->num_ports = num_ports;
+	priv->supp_rs = mxpcie8250_get_supp_rs(device);
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
+	for (unsigned int i = 0; i < num_ports; i++) {
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
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static void mxpcie8250_remove(struct pci_dev *pdev)
+{
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
+
+	for (unsigned int i = 0; i < priv->num_ports; i++)
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
2.45.2

