Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022138.outbound.protection.outlook.com [40.107.75.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325C2820D1;
	Sun, 30 Nov 2025 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499452; cv=fail; b=EFtICGhOBW0FmGPX4UdQuNf+cZom8Kc9Lef3YvdeHwKth0kAiTXj8Y8+FYF9luyFN7J4uv4Uz1o4NcJbGSs47pLsiVZ9U0ih2g7okzHh9qnUBdePNkHic21OjIerI8Kq9XGNJiwUZvRizPzsi7Z0NtfhflUmfiNoQDpfbCBPNxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499452; c=relaxed/simple;
	bh=/69xuH+Hg22UUe1R1kdMC64ZwU9Ll5o6JsdSHNhQpao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXpeA9lfqp1PG0Ix5twISzl9ON7/oCE8x6MsXDxWftB3rXqokPX9Xmz9pjCf9jwokZu/o2IcmSJt4R7MhjEFCmRwXa0eIXAzw6sWKHFSb8oFmFss4b6X6W8X6qoBJEPpUGUtlAurt8tVcy+n9DlZ9aKWZdXq60PLM83lGI+BbeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=J33hypQO; arc=fail smtp.client-ip=40.107.75.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="J33hypQO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhDMAaHRZ5o/fn7lHbm5rfYUGp7tARkFHwfQx6TZh1meNzY8UgThGQCx9OvjsZJZ71vbkJVDDdfReQD/3sTpj40UG1N633ZYBoKi6CGZMOTuqcn/QnTcjwunBaSzcFjNchm/xapMC+lqfQIzkRvtyfC75eKo1Vk+Xx/8oozKj2GOex+RWCr9FHAH6BEiGBR7BD7mKhkhx9P+0B6Q7F99t0uWsPzd+62V762UkucWIkTOgidwqQ7j/bZRfBcLzEtZaAplfOF8bjiq485CPYQmZMMm+phZSM764FxXvMErQblxOvZ0N+ocaXLaDGtAzncwMnwTsl2gc34Vz3RBDQxUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUompVVNk4obSlitX/YKejYooJ2XFrT/n3nOGtcbng8=;
 b=RmaHV2OAwC7n2vWJpx93/T0R2dDHZKIcm9sA2MED+sWCk1C27d+2UxVzH2BqL3k73UJhcJaOEijqIHdqOavk20W/qSjDEzRO3SYMfSlRQKyqMuUefLIHCwkvN9/o+Jx8XQlVAWrn9XO0a5hwEQ3xKTK9KVER153vq+0jl4BLgU7J2ZurHJh9CylcO8jhDdO15fMH5WG7fxRuUxhDTED8+7uhc7lAvb1F4Ti9PI5JvgFEj79PI+1trSokv4GwfbgNcX6E2ag5KK3F7pFNiRC5pPaX0mPq87+E7jB+5pzuEPH3WVRPpTyisdezzNpwiPxCLeIAF4BxPeViJh55QkL9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUompVVNk4obSlitX/YKejYooJ2XFrT/n3nOGtcbng8=;
 b=J33hypQOYHTrlBXjQbRnAnEgAVHvC9TnmD6Raikl1pp/+oH858a1BQnHo9eBtR0ggDyeVfvTwc0Nn8VL0baEXMZXrHE0K6s/7GfkdrJ/WZoIIj3GwaC4wUCBjssIjKLo9IUA5FaNS6ZzckG4/83YC9L8oUUWMTj6n3xpaRmXXKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:44:04 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:44:04 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 09/31] serial: 8250: split 8250_mxpcie from 8250_pci
Date: Sun, 30 Nov 2025 18:42:00 +0800
Message-ID: <20251130104222.63077-10-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: ce76c31a-baee-4244-2612-08de2ffd61d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8KTVXYLGmFc0yrmKIH/MLZDGtB6L5POeKm1ojgbYRuZL6nPhpaeOSiNF006S?=
 =?us-ascii?Q?xrL0egSVOBf3YzdWrAylN9bskHiS3/xoTZdpp0+zINrSDHRd6x4F42jazgqw?=
 =?us-ascii?Q?Q/AaZr7F92ygUx1Bw/7plzbzDsrDVXmIFWEkC4+XruWTs7v9EH4KkR4gzzUk?=
 =?us-ascii?Q?c/C0ONy/ksBn7yyPWxSvgyPHBX3d8Z+PyCowaMw98EiqmykwIDlEdZfwG5Yq?=
 =?us-ascii?Q?HLL2Mt92R1k77JLDk2ByOfLAs7JdeP1NO63i9tpMTq2q5JRG3ayQRTzAlNN6?=
 =?us-ascii?Q?a4g9bNdqsCd0LkcfHrFfIzXtMpeHsHTjdcdTZ1K8gri9mXN4XY2abBsCXCTV?=
 =?us-ascii?Q?oPhXQLZD0ynQVKhuxKYxCO30thvuvP7ZFnTjfZPH2hyp8dJ4XKfKlu2N9Wx6?=
 =?us-ascii?Q?cFFvgdKzkdtnj6bWhPP3AjUgpkxzeAglfRqMuTo/koPiQ6Li/zUF7tXpMHdH?=
 =?us-ascii?Q?MJHVR9vOlfrw32oTKErbzQZOiU9uc8xCJu5vBlNK/5a1n1wC1CtNWiX+Yo0T?=
 =?us-ascii?Q?8A6JX9os9qpF3fz3xRyJ+deNk/K3I+Kkkz6PZQHegejK2wFvQe9CkL1KnReu?=
 =?us-ascii?Q?Wci4bln79oVHY7z9f+zmMxJ19ZbY6AiUx3KPtqKcg3mlgtugkpMzFcLAWR6f?=
 =?us-ascii?Q?AjrTFvR0ncrj2whEK6jvh3Ijd/EyVp/IntjR445cCxAFvfohq1bslNcHP8Od?=
 =?us-ascii?Q?ei1EDB7lbU2yqrxJ0fjyD4cQKVEOg4IAHuVgEYFRhrWkc4UBHFUUNzGrcd9/?=
 =?us-ascii?Q?BZNTKazSvh62eX8fa89is+GEdf/Fd1WgmZOtG++YqFwTDckYygIPVvm0Qk4M?=
 =?us-ascii?Q?hqiTaRahypTpgoLY78w+67Oc3emrNWQNHUZgwXKBfQU1QG6RxjYRK6qA8skh?=
 =?us-ascii?Q?pu/QDM0uk73jC5k5GFfB/gJiWpIdYvWevv/Twwuq7usic19LgIHeNN5vcK48?=
 =?us-ascii?Q?mCv0qnw3z5OSQHWqlihCs6O3zHbqQgg8ZTuXZ6Qqf1L0bLlkk/WYNeo3kpc+?=
 =?us-ascii?Q?PT1q+gxotcKmuBielab4GelyIkth4Hqdy4Qh8ySzhuuNgeoLEK7YmuhA3MiB?=
 =?us-ascii?Q?qRFq6NCui2pbhrMJOQ54SUcdw0ve9rrM1AhPTIIIFyIbf/mTRoLi7gjgXFiU?=
 =?us-ascii?Q?FJ65p3Fxlg3lqxAxlGp9lNZ65VNwR3Pg9MQLhFaw1jhnyZz/6MWH9gfPHs5j?=
 =?us-ascii?Q?Ft5arHPM24drdnWFa922J1AGAc1GVlyu7q/sk2l/iuPWI3GycmhL7LXsvRbe?=
 =?us-ascii?Q?4LyhT9vrHn4LR2CKMJb7dvZG5c1lYsd3sV8dI7n2R2atz92e65RqrbyaDtzM?=
 =?us-ascii?Q?vG9aZpt1LA1lW6pOcydHNajjb/62nl8WIpLI6+UF5MhzbvPGfEc/b80/jWij?=
 =?us-ascii?Q?0YCKmMtuIqwvaCvHketAHFtdga6GdEjuz0MdvoOJC+eAZ0nrcUySGLdQ1zmd?=
 =?us-ascii?Q?TgP0LIbpHoRGecNtpxDmChHG3GrgUEWVBILVNO/viidvIGKIW1i4mc8H/v2U?=
 =?us-ascii?Q?eQJlizzEBcADVl3xg2NJvV8MdPxOR0Q5GMB0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CdPnd1nPmvYaeQCAjuBIuZTOJX+KGuoSqD9x/k5YBtCYIoRNHYiY2aGtUbK1?=
 =?us-ascii?Q?sRNbPuQu6FFzQVB0Kh3EBU5vML9kriVzVbl5FGqT89tCSSapUwW0ckFUKJQJ?=
 =?us-ascii?Q?jeLmldLv1ZfWRmGiFN8NZps6bMJYKvXgLTlQoviOIpLb/Dxc5xIgwRFfiymJ?=
 =?us-ascii?Q?2VC67L2cnYrbb1qzzSHWvH8l+vcPhxtq8YPuzQ1lfImlBeYGT0gx6MJ+Pt/O?=
 =?us-ascii?Q?iMMYZAjqwJOLZnBHQqYmpJ+74keybi6A8JL3JTc00KooWC8j6ryhDGnqwj6v?=
 =?us-ascii?Q?sKvCfOlHoR3VUsDgZn6KvhrVrTnZ/h6Fth7MZrNMMFmZe/dJ3aFDRLI6BNHc?=
 =?us-ascii?Q?ax/clWATvgmUFg9lW6X+AYGdce5heU5pF3pDUJ6/lwhNYRoofrWeIYcu9H9c?=
 =?us-ascii?Q?cuRBOYMSmo4faq83sQI9lK3/OKcV9ccUoysOkEd4ey2RDTFanaJOvF8J9e2s?=
 =?us-ascii?Q?wP6r73HnHhurCPFqet0pwq2u5NWGMjMYQh2cVhElj9Tf1hroM4ZI/gl6EaDa?=
 =?us-ascii?Q?2ogzkZ7Ht/nZxgg5CQw5xl0RmpB6o8woPXUuYb2W3s50t4mvb1vXOQ8iXwiE?=
 =?us-ascii?Q?iY7Gray8FxfQIipDpVZ8D2ySErD6CIVHa4ZCIci5At7+WQMGPWcMGXuPNN/+?=
 =?us-ascii?Q?g3jP8cnlsJj3YmevYlUhkDKod58gYexqlkp5EpE9aG1t1srYhsuOZZFWu1eZ?=
 =?us-ascii?Q?2+SDTrgsEUsm2LlNhkvxaAK9xX+q5F6pxwPN4ZoQAOhxa6N5KZzcJEKbST69?=
 =?us-ascii?Q?Oo13me4mzXAwRVAaAP0+1V4aGQjWFdBqjemaujDY4jpi6a98LpbjcURg7TYL?=
 =?us-ascii?Q?U/LNN6z1cUArWfQYNPTjRzBuynhjmXuJQkp/SxSYksY7WZpw8V6vxm2NONIn?=
 =?us-ascii?Q?bxOzFTZQvpExziNJ0KDhiVJ/uYsIhScgH/+8uWMmn4P0+WumHSjPC7oG+iv/?=
 =?us-ascii?Q?dNQ18LCFAxWaHHC2aQ8hJNey5Fmb+ZC+GpYhBT8nttIgKVP0tm0n1AiYts5m?=
 =?us-ascii?Q?UPOeUlDeWwLt55bWxiosStU0+SRcIWcmKWo/A/VHoijTCvjIWree2T09UA/Z?=
 =?us-ascii?Q?CuNb4CCTuH3j8RvJiFXk3bsiRhGsbMKg7Fnf3sW67bjo1EI6qA4WvU2yapeT?=
 =?us-ascii?Q?DUGcyqwE1Qs/Y0XGuhVkKQpqM+IsDkVnhEMzNz1IUs9gS4okC98sKsulL8Js?=
 =?us-ascii?Q?C68dB55UPhXVMmOBuiJ2c7gctOhKEL6J27Jy1CzdxPaWr9GxYqy4cre6oEoZ?=
 =?us-ascii?Q?yUXEpfmU44VBC1P5FCXV0SpgHFbrkTqjkH7ga0ETLj1HggIa33ej9BOMw6Tq?=
 =?us-ascii?Q?46LXGA/5kMyfRGIzRSK8hIa+F2Q488P7MUjB1cL1CKtKU07Fw2+RmObUqGgd?=
 =?us-ascii?Q?BKCugHSlCkSqg7WCVT1ejG3APzpAnpVh/ShYXqicsnVu9IherfjFGOToCheC?=
 =?us-ascii?Q?E+sA4gk9HozdDpEkzv3NTTiqet5SV5Bn2W4wvNZP9aHpe8Ddrz1VbZaWrrTa?=
 =?us-ascii?Q?VriePkelJ11pLVhR9QTXh8HejfizXXRn6faNaEwEnVSFT8sTRwmipV5cKaNQ?=
 =?us-ascii?Q?1HsZjG7I08gvVAh7C1M3CT5Dvqb3kVU8swSE4Cxq5BoVrJyhh5TgV0gmwLnt?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce76c31a-baee-4244-2612-08de2ffd61d1
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:44:04.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMgBLb0XYl9yZQlR3zkuQxmOZVYus4IU4xnylybESDAnl8wc62Su6095TnSqmqkVFJMuC29x810pDUjQJO1Fta5Vst5B76W2/4oOR1nnZF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

To avoid polluting 8250_pci, as suggested by Andy Shevchenko, this patch
separates 8250_mxpcie into its own module.

- https://lore.kernel.org/all/ZmQovC6TbDpTb3c8@surfacebook.localdomain/

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 277 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c    | 205 -------------------
 drivers/tty/serial/8250/Kconfig       |  11 +
 drivers/tty/serial/8250/Makefile      |   1 +
 4 files changed, 289 insertions(+), 205 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_mxpcie.c

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
new file mode 100644
index 000000000000..2e26307a9fee
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 8250_mxpcie.c - Moxa PCIe multiport serial device driver
+ *
+ * Copyright (C) 2025 Moxa Inc. (support@moxa.com)
+ * Author: Crescent Hsieh <crescentcy.hsieh@moxa.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
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
+	struct pci_dev *pdev;
+	unsigned int supp_rs;
+	unsigned int num_ports;
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
+	switch (device & 0x0F00) {
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
+	return FIELD_GET(0x00F0, device);
+}
+
+static int mxpcie8250_set_interface(struct mxpcie8250 *priv,
+				    unsigned int port_idx,
+				    u8 mode)
+{
+	resource_size_t iobar_addr = pci_resource_start(priv->pdev, 2);
+	resource_size_t UIR_addr = iobar_addr + MOXA_UIR_OFFSET + port_idx / 2;
+	u8 cval;
+
+	cval = inb(UIR_addr);
+
+	if (port_idx % 2) {
+		cval &= ~MOXA_ODD_RS_MASK;
+		cval |= FIELD_PREP(MOXA_ODD_RS_MASK, mode);
+	} else {
+		cval &= ~MOXA_EVEN_RS_MASK;
+		cval |= FIELD_PREP(MOXA_EVEN_RS_MASK, mode);
+	}
+	outb(cval, UIR_addr);
+
+	return 0;
+}
+
+static int mxpcie8250_init(struct pci_dev *pdev)
+{
+	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
+	u8 cval;
+
+	/* Initial terminator */
+	if (pdev->device == PCI_DEVICE_ID_MOXA_CP114EL ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP118EL_A) {
+		outb(0xff, iobar_addr + MOXA_GPIO_DIRECTION);
+		outb(0x00, iobar_addr + MOXA_GPIO_OUTPUT);
+	}
+	/*
+	 * Enable hardware buffer to prevent break signal output when system boots up.
+	 * This hardware buffer is only supported on Mini PCIe series.
+	 */
+	if (mxpcie8250_is_mini_pcie(pdev->device)) {
+		/* Set GPIO direction */
+		cval = inb(iobar_addr + MOXA_GPIO_DIRECTION);
+		cval |= MOXA_GPIO_PIN2;
+		outb(cval, iobar_addr + MOXA_GPIO_DIRECTION);
+		/* Enable low GPIO */
+		cval = inb(iobar_addr + MOXA_GPIO_OUTPUT);
+		cval &= ~MOXA_GPIO_PIN2;
+		outb(cval, iobar_addr + MOXA_GPIO_OUTPUT);
+	}
+
+	return 0;
+}
+
+static int mxpcie8250_setup(struct pci_dev *pdev,
+			    struct mxpcie8250 *priv,
+			    struct uart_8250_port *up,
+			    int idx)
+{
+	unsigned int bar = FL_GET_BASE(FL_BASE1);
+	int offset = idx * MOXA_PUART_OFFSET;
+	u8 init_mode = MOXA_UIR_RS232;
+
+	if (!(priv->supp_rs & MOXA_SUPP_RS232))
+		init_mode = MOXA_UIR_RS422;
+
+	mxpcie8250_set_interface(priv, idx, init_mode);
+
+	if (idx == 3 &&
+	    (pdev->device == PCI_DEVICE_ID_MOXA_CP104EL_A ||
+	     pdev->device == PCI_DEVICE_ID_MOXA_CP114EL   ||
+	     pdev->device == PCI_DEVICE_ID_MOXA_CP134EL_A))
+		offset = 7 * MOXA_PUART_OFFSET;
+
+	return serial8250_pci_setup_port(pdev, up, bar, offset, 0);
+}
+
+static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct uart_8250_port up;
+	struct mxpcie8250 *priv;
+	unsigned int i, num_ports;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	pci_save_state(pdev);
+
+	if (ret)
+		return ret;
+
+	num_ports = mxpcie8250_get_nports(pdev->device);
+
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, line, num_ports), GFP_KERNEL);
+
+	if (!priv)
+		return -ENOMEM;
+
+	priv->supp_rs = mxpcie8250_get_supp_rs(pdev->device);
+	priv->num_ports = num_ports;
+
+	mxpcie8250_init(pdev);
+	priv->pdev = pdev;
+
+	memset(&up, 0, sizeof(up));
+
+	up.port.dev = &pdev->dev;
+	up.port.irq = pdev->irq;
+	up.port.uartclk = MOXA_PUART_BASE_BAUD * 16;
+	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+
+	for (i = 0; i < num_ports; i++) {
+		if (mxpcie8250_setup(pdev, priv, &up, i))
+			break;
+
+		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
+			up.port.iobase, up.port.irq, up.port.iotype);
+
+		priv->line[i] = serial8250_register_8250_port(&up);
+
+		if (priv->line[i] < 0) {
+			dev_err(&pdev->dev,
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
+	unsigned int i;
+
+	for (i = 0; i < priv->num_ports; i++)
+		serial8250_unregister_port(priv->line[i]);
+}
+
+static const struct pci_device_id mxpcie8250_pci_ids[] = {
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102E)		},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102EL)		},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102N)		},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A)	},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104N)		},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112N)		},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114EL)		},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114N)		},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A)	},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B)	},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A)	},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I)	},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL)		},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132N)		},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A)	},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134N)		},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138E_A)	},
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A)	},
+	{ }
+};
+
+static struct pci_driver mxpcie8250_pci_driver = {
+	.name           = "8250_mxpcie",
+	.id_table       = mxpcie8250_pci_ids,
+	.probe          = mxpcie8250_probe,
+	.remove         = mxpcie8250_remove,
+};
+
+module_pci_driver(mxpcie8250_pci_driver);
+MODULE_AUTHOR("Moxa Inc.");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Moxa PCIe Multiport Serial Device Driver");
+MODULE_DEVICE_TABLE(pci, mxpcie8250_pci_ids);
+MODULE_IMPORT_NS("SERIAL_8250_PCI");
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 3c3f7c926afb..7327a370318e 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -82,25 +82,6 @@
 #define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
 #define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
 
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
@@ -2000,138 +1981,6 @@ pci_sunix_setup(struct serial_private *priv,
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
@@ -2931,17 +2780,6 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
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
@@ -3159,9 +2997,6 @@ enum pci_board_num_t {
 	pbn_titan_2_4000000,
 	pbn_titan_4_4000000,
 	pbn_titan_8_4000000,
-	pbn_moxa_2,
-	pbn_moxa_4,
-	pbn_moxa_8,
 };
 
 /*
@@ -3933,24 +3768,6 @@ static struct pciserial_board pci_boards[] = {
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
@@ -5811,28 +5628,6 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
index e8b2878f8ab0..0db3ea0fd1d1 100644
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
 config SERIAL_8250_MOXA_UPCI
 	tristate "8250/16550 Moxa UPCI device support"
 	depends on SERIAL_8250 && PCI
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index da9d35911bd5..cf871a3a1fb7 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_SERIAL_8250_LPC18XX)	+= 8250_lpc18xx.o
 obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
+obj-$(CONFIG_SERIAL_8250_MOXA_PCIE)	+= 8250_mxpcie.o
 obj-$(CONFIG_SERIAL_8250_MOXA_UPCI)	+= 8250_mxupci.o
 obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
-- 
2.45.2

