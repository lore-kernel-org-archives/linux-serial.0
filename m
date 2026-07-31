Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013014.outbound.protection.outlook.com [40.107.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96B3947AC;
	Fri, 31 Jul 2026 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484147; cv=fail; b=BkZu43ZPGuCH3dRIlOdsEZXJvEpBTGMTGN3GBKXFpCROEr2A3KIfGsQeDeoMyOL5uyfTlmdCyv1GF1a/Jjuul1djLi8haz4g05l+uxbSm/ljuUYuu7mfbFmkOixDYVmQXT+hW+IoQmL/U6MUN7i+G8QRqk3rgmF+lWGziArgDPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484147; c=relaxed/simple;
	bh=rc8vShyLx+KwgdTVmWZoqju0h7QQ+xShE/aW+7hZ7yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NP+66NuB9EPreX/qHEt1JpiQn9KNLmX4gjdG5WxtJah8CHPbDuZc4ZsMdHATJO/6dYtnOwQlysa76/wVFwx9h3uzwYNZa3z9QVrzK7VHscyT2jJzgZNKNHSuNYUO9CW9TIrHmkSmxcInoyvQM8tZ2fUHkz7sbATW9Za9PBr+iwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=BmpZGmeh; arc=fail smtp.client-ip=40.107.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="BmpZGmeh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fj+5RLXQkOJIfRu6BCHxdQSV7qraxe+1uEdd6eVPDQpxeOKm3FHr0BsX0ODiW8KKcSqMBCXRZPmxzUnwc8TWpaUoufxkuiA01QQpIteQFYGTvPvnB5oc/dzHTOZmg3kH6F0tMX5Cje19R7eZ6/E5SiPbTfcO0hJsxkEVfCZz4OJSm+c5UxJSD0ZoIqFxIF2NFyHSV6MRAMUSeDF/6YTOlfHThT5FRKBpv3Phz+LyKJHIDz3WO0anL+QEQgwxMwIV2pR0M3HyP9Ozyx3PWJEKEoBl6K0UagSVspAYamyJmABBkjMLyQmFHS0LVYSedSmD04B03obkcFXxqPPPy2aOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EkYu0kjrGsQK19Obl99n17+DS4qqeUl4O5Tv8dU7EQ=;
 b=iZdtTr9nSvZHDhN1jBx8bv5PbXlLbpl3lr7qhl+S+NKHbm0zIx8vClTMxGdKxK9VOme4D2G0fbA3+Q7WaAfhA4ptWvjTuob6ng5JPv6aHYpkpZENnzBy8iwtavY59WncT4bxeh9jVMULdDJgR6E6HvQP/ZWaUrTae1nrmzTAhC14OpdeYmEpCpK204JYJXNfbtZv7FDpU4Dpi4v9dh3wnKDKtvSS2GmuClqneIV0rVxoDIQh1UTDTMtjtChyxw5FJylSp8fcLIvY3do9OL1AVgdEe7ZZohOsvFJd066hQD5ZJLfvtozbgNr/sa1ShQOGo3V66IoD6BQ3I2x7oySSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EkYu0kjrGsQK19Obl99n17+DS4qqeUl4O5Tv8dU7EQ=;
 b=BmpZGmehvHfFOdl+yjBJZm9WsdsWvz3KUDLtaCJ6sCA9h9ttlgeI/Sf4pqtJfHzNU7aEkXyNPty2FFfBJZn0UFcnvUarufKs4GrnQIupEPFgOvziNjrgsLRmnwI53peX4CR1l9g1HJbdMCu+3KtyXvIBN/6Hva9LguXv6o/qNRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:48:59 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:48:59 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v5 01/14] serial: 8250: split Moxa PCIe serial board support out of 8250_pci
Date: Fri, 31 Jul 2026 15:48:07 +0800
Message-ID: <20260731074820.735619-2-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be461e0-fe9e-4819-e9f2-08deeed82e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|6133799003|56012099006|10067099003|3023799007|4133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nzIkro//LC2gr9jP4PDl9dJTCXWcOYxZ9xzSCRfhwS2zFAONJq/dyJLNNNoAbnWK8Kcm9Ua6nb8DES4qZhBgJJIeYNFTn6aig3bcSwzpzHRYsK0Jg8ZEx+h+LP9Hce/KiLRCcp0MBFcHE5lVt9JyblFUKpyiGrf+lu5dn4zCqDBZufxnglVEhg6b2bY8BlHAzQevRacIBxE3rt4lMkxn+w9+7ZHI+9lNta81HQFYZ7FVqRHAYOWaFEUWd+hpcHX0DeLOixpdCeL6CDQL7HHWjNncZADrdMd2OCO3xtGtZLM9XSm2CDXfbDZ8BLTfz5hcRAOv0Ng8+ZuIJkcxgOA78kBbwnxHPwu9QEihVd9BMTwJwxOTyhTRf/p4aYVFfOBYsvDomm4Skwc/Ytoo68POOG2Q21tZCJmfb0wUTYY2e+l2JeIsck/XL93bswLuuDqrHcYoTLlDui/+WSwVqgBy1el2LXUoWJoIF8cTEGtQh4u1+LlOKzv80JCdd+44nP8NC3wNoXnWh3fRbRQnhn7TjThOqf4FYZsSQVglA296lv5G3RUuvcxjfBPw4tEP8bdOdLo+ittbxr3nAV7v13NhtO76bUr6Ss76WgaCxvD8eMR1EoAwFRtUeLEMqkwn8mhEUmoc6d5TDLJZFcpTZTNO8f5fXfxM0c+ZAHPnzTQaE9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(3023799007)(4133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNyYkg/rud9x2csEwF4Jsmn2KDUg+C40M3Ipx1479cytKMriwrTs31sIQcNr?=
 =?us-ascii?Q?sUBoh5+xVp/V8dRxbVnbVHCtKVH/Gfr0Of4p0efRqt1ptn8tYf9AWmnzqbzx?=
 =?us-ascii?Q?r5JxEOUgq0lyjhxJOMfjk9SwhuyURtP7kUHts+hA5a7OB+LAxXSXOisSWkzJ?=
 =?us-ascii?Q?p6Xv1IdLTqpKVsQaDIq4o9OpUcU5l83xT0NWz8E9+PVHsUDNKTGXNiYZeULf?=
 =?us-ascii?Q?4syfetQHh/efPbd23tB1uY0qFUg1QXFBEMvMnP2IKAwLnUGrfjHm2lBc/Kmb?=
 =?us-ascii?Q?poQbRVNNaD/LtTurrcsx1gQ3OHjJlVEa9RdLsJnCbkj6WxI/5LCd6uiqcN67?=
 =?us-ascii?Q?XJF/+7vhOV65O85hSqBxjp58LjwyPhKFLLbm/wqe0TlinO9R58LhG9dC4iz/?=
 =?us-ascii?Q?4IZd2Q6uoLLSGW5OZRoVkKa1ePK1OMZGaXC7xVeuLrNTox1bW4X8O56GbP/Y?=
 =?us-ascii?Q?KNoHvS/sEWazO1F5koZYsKfd1HruMw7HCLBz+D+vFXHWbskPu0WwE9h+HlnG?=
 =?us-ascii?Q?WusL2m/K+pTGn6HLXeyPJeH+uqU1sFsYS/CsCc8bWcGy7G7PfIDPRnXvc8GG?=
 =?us-ascii?Q?VY5VENc+vWL7ZdjMgLhc53iH3dmEQlqZV4viYbC3UJtQbmNIFVdZLvEv1u4D?=
 =?us-ascii?Q?kd8REzkLOxyHWcHxC3HpOosZZ0DU9EwBpehUCJR0MhNTrP0E1puw3NDbnH4P?=
 =?us-ascii?Q?25PL51T3/LT6wlwtO4oc4VCGxHyV0XW8DvGVJi2KHffpNUebW8PX76iiObQF?=
 =?us-ascii?Q?uclnjZhc1o3yM8cx8X0PPbg9WC0h5roGK4ynhR6h6Cr0a/2GR85B6LGGB09A?=
 =?us-ascii?Q?avEYoIhJjjfeLwG0/w1PVo9VunY894ZA03tLoEIk0R7ZGbeWPmvNOf1pixPG?=
 =?us-ascii?Q?2R7M+apyXqGbgMGvfqjVju++I81/Oil7kPCgu+P1vtpmFf7zomCVoT9tZ/Xf?=
 =?us-ascii?Q?UEif3f8KxyReUS1nLhWCQ7eq1mCZkZlonQaL7EosCmDbIa8iMybye7Pcu5IU?=
 =?us-ascii?Q?OTOKeszP0Lec6zLQoAZdRWWocwALW6sTPbN8jhDmkrbX6of72YRACDOoq0dO?=
 =?us-ascii?Q?7MYJ3n3NgMyiBJGUqRlzvDixSMn/DYGtWUzq1QBPKw6S4EUWxOqPpin6fXv6?=
 =?us-ascii?Q?Ajor2RhDhoA+byTyfKs0neI/mC1hUaHmPF7Y0SbHcl1xV3Ox7jOduM9+mVDN?=
 =?us-ascii?Q?8tKtAlXfQdi/esxeESYYI/H/vYuwlqgb3c9i1kDAVvgyAJYr+obuC49HO9dB?=
 =?us-ascii?Q?/1grTIpsrC4jX/2khfh7vPksjEIGilqghCzB1BcaRTWa+K4Sd5hEsponmrjN?=
 =?us-ascii?Q?tUtRBxqJ6iGf4SVuV9We4PN6Kn3NDexEtyw6Nu/Mbadhm5OTfQLGVcO8j4BS?=
 =?us-ascii?Q?xxIcTDTJcmjn1yQX3Qn1+Inzm6NdfVpf+a0J5FBSjNhWq4LkYF/Y7pr06610?=
 =?us-ascii?Q?dPv2oZ2hy8dyqxajia54ngWfYT4r/ehQuS0BNlyK9MM2HKhLCgeEe+pwUdAc?=
 =?us-ascii?Q?DjxjmRJ/TaeeC3DZQmwJQsdEtuPZ9gMMQ4nTyVba0faeoFhCPlUhYDQgY/7z?=
 =?us-ascii?Q?csO0+Ea5eJri8E2QcRw+86oIjLtxPPlhXdcPV+0bJoiskHH3fN6JnsslEARw?=
 =?us-ascii?Q?UOFjM5RKE0ra2gDLI4xQYGak2xBAZpxC8XKjFEyybWDsdiPv6neboRwW9p5I?=
 =?us-ascii?Q?n5GJ/Kz+I7ByQG/oCTM4ctZ0Qkdi/jSe31eK12ZY/sy7pWDAImwGGh8z5Cih?=
 =?us-ascii?Q?963XIT02KGeKgdlLFsGnA1SQovbHW3Y=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be461e0-fe9e-4819-e9f2-08deeed82e63
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:48:59.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdmEUHFbIJ4YcAtXkpO0i+pSU4c3vjQF2pYdH8L/2gW0+CCl4HF321OqLvtXmiBKCHLuB3eq341tWPViFOjQdJICEk27+Z4WKnlJN6wAzso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 288 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c    | 208 +------------------
 drivers/tty/serial/8250/Kconfig       |  10 +
 drivers/tty/serial/8250/Makefile      |   1 +
 4 files changed, 302 insertions(+), 205 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_mxpcie.c

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
new file mode 100644
index 000000000000..e75446923d08
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -0,0 +1,288 @@
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
+#define MOXA_PUART_BASE_BAUD		921600
+#define MOXA_PUART_OFFSET		0x200
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
+		FIELD_MODIFY(MOXA_ODD_RS_MASK, &cval, mode);
+	else
+		FIELD_MODIFY(MOXA_EVEN_RS_MASK, &cval, mode);
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
index f64ef0819cd4..c3151a91e39c 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -157,6 +157,16 @@ config SERIAL_8250_EXAR
 	  422x PCIe serial cards that are not covered by the more generic
 	  SERIAL_8250_PCI option.
 
+config SERIAL_8250_MOXA_PCIE
+	tristate "8250/16550 Moxa PCIe device support"
+	depends on SERIAL_8250 && PCI
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

