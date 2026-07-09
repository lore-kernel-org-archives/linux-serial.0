Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CFD3A544A;
	Thu,  9 Jul 2026 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575237; cv=fail; b=G2n3HJE0OLZYtgBtZTEnPYeiFkma0b8nwIt2DOHMK+U1vUwN3KjqQtwMxA6ky02EFSgJdxvor6U6FdUhNAGADZ0WtStXBbSTx918vtZikzoKIoZgywWwILUg2WgOIuhHcsX/XuKuqxfL21jiCAmZpp9O17rEh9K6wdUqAS3Y9SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575237; c=relaxed/simple;
	bh=mzEM6+6pKRFt/rIQF7ZG5BShK5cfp1Rdg80bba6+Gx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOv8kSH84dcyQ8B1hAzPtZfVJbS6PND0ApS0390YvHsyTsUQY4IrfVE0CbCDzq5endnV3GQxBI6TyanONwLrCwjFu4tCtH1oGsYxXMrxZOMCMzmKlEZpUj+AuWB/k3In0UEPoXVFhlVfxqw36Z657m3UMljRjXstMPPPVSD2alw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=XLhgWAIx; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="XLhgWAIx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3RtX34j9oV5geJclND6CRtJ8C3dvnuF7k+xenwPKoAzcAxzCk5F68UjONunXe/K0LDgCkunePurSHdr/B8o4aS60pp1HFUTNshKKKTHNVX/+j98h3oBR/x1E341LFe7huWSTVU9hw/TEXEVXWhACeZdfvNHWzLjLq39O+EZqifKKSThSo8g0HbsfOnxUeP1D38QeaK3nLIDzo15UsesU79BiEg0Hp4jFVxH95gDwbAhuLlyLC74o+xQy+T0g1oamsD7UlCZym4P58/tYLo5iEvN2ZATOF6Ethz/SXIXD8miMRFsrkqaT0BgXba82xry+x5VlO/Usb8hwHjwOuKoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0Mmm10G4Jk3P4pwbHjGRgXN09HUIxlt1y9HwDmVqOs=;
 b=UR3eIbEzrJIEbCtC3zV40UbOQ57sMdoPmx6KseKuiG1SnZ0lqOJvO7M5GOBkZEtJ3dM2J5+nFAybPtxWS1JiG8PR1OOYkKSQsAv+Ud4soE0Wza34Zjt4RNxO+TJO/P0JewUgbrKllVqdfYY1v5yLpVVbwKvDzcX/JXLtAvvvmCeuR9KPe6jzy/cDUMlVLf8eqwTiFoa+H0EeEV7DL3YOGgAVlXONTL59eA03wp91Lsny5oZUCV8dXP5t7bctG/9lrfLfsnMaNmv5Ek6mLZpmPPaN8BhobUp8zLPK4mnE5GEOKBCXOzov4OxrV2WiU4DnHzY2hh1I7+IWhoIpQIbXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0Mmm10G4Jk3P4pwbHjGRgXN09HUIxlt1y9HwDmVqOs=;
 b=XLhgWAIxYV6LGlZKLA/SwJaZWlwG8HqJv/l8+Vf4S3BZ08aec8BQNYWLyziSMzbb+TRVjYDNcpACMtY9NX+0sYusONy6keA4yzxtVwSG1SCFl+vvhDmuTo9gMM9cSV+2CrgK55KBMvat4k6z/AOeLIwi4dWN/MbBUlx7Ol/R6n0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:52 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:52 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 01/15] serial: 8250: split Moxa PCIe serial board support out of 8250_pci
Date: Thu,  9 Jul 2026 13:33:00 +0800
Message-ID: <20260709053314.435629-2-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: d02a3113-a3b9-420c-7a02-08dedd7ba7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|4133799003|3023799007|22082099003|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	uKZiE1pWzlSfi3ZnGLEIyYNB7WMhNGCeqcMuSikDjDw0Ak2d1SsOvrB8yYh5qwvEae85+gKEOm5fFIuZx2CJK8qXJzHkYSMzpcL9HAmxIc/0YLgRa6z5HoSGs54hUkLg0tySqys83wvyMAbMbb7z/KqUbHwADiW71tAVDf2yojcyjTE6mYLkKhU0k743r34SsW3TFF9iH7RDkp9wteDACFSxZ2H+5ZmSC5Z5gCFnUg31nfY8o16UTnn1TaTyUMdzitUdEPnnBoJuyM8i67RHgXx99vyGVMb6lhIZaIympUQHmulL+asJhMJjQSA6l0FWzTEwH+m+KHrTYfDF8QYLa2v5XuicexWZ7nQQiE9ETO60LdsQS+Dab/ijcQJBCSxDqfmvv5lSTaqwA+9k2WNWR5yPfen0vdmza2GdKBB+wCpAtHu2OyPlqVeGl2GbNScIHqcJMycrYkSUQlc7lWBX+Hdih1j+zfjcKiMyukE1P853wtN5BNyY6qm2Cvm06zVCnmeoTJx3nkjkU8/rUkSbcbDoPqNHdE2gK3w15rar1XPMsYmDvQWQeGwASOVvaUVX11n0kMplANQyG7XGixyyPYj4+iBC0fz/YWhqe/xOqj0seo0I5Q7pf/6sTXx7q4nnqdpo4lj0Pq0uKbSg68ou9UlJ+kmh7j2+RKlc2IJ9PQOoX1rM712sGK6D5/nAQZOf6JJ8pyofvI/HLKxHBpF01EC7/gGZLQjPSdXWUdR/EHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(4133799003)(3023799007)(22082099003)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H6uMovMB97/9nUxsq5n2q1siwS52NmF+q5VHfQ8VCYv7bCjvs8lAEAnr47tS?=
 =?us-ascii?Q?jSagdAbk7Scd07YcsjNtHBI3FM8nPs9IX9ETjBKqHoJdnQClstJhoKR6e+eJ?=
 =?us-ascii?Q?bL1Kp5em6rU0EB0dq5+QOSZHZh9fXOJg+cJ8cHTCyjYGGR0wCRVGwo9FAaZP?=
 =?us-ascii?Q?Ql/Jn5LB43lQ9GwQwosuE+zKGAbdCNJrsJcJULaQoWRhkvgiIsRY6obWr/Ld?=
 =?us-ascii?Q?DajPRdVtvjIV8qhzl3beaNqm/FUmGXwUd84MSjSckdksfquftkTyJ7a7w+ut?=
 =?us-ascii?Q?n3ELM+UssCpYTnNs6lhDB2lKKfImsvcs9UNBxnvN19VOwwxVolU8reqxhI9c?=
 =?us-ascii?Q?Agh/v1sDb0W5kXyJuv/HxAZa5EC/2bEurNpnK/XaK73j6C7Xycf/0L/euv7n?=
 =?us-ascii?Q?2gBQNJ6oheVWOE3fe6hVtDrUTvcoTrkFk5sGuCapom3bCrENzOTXecaXTZSY?=
 =?us-ascii?Q?Rdr+sKbSb+PVU7ZAUmrsqAFw9dtuY37sn5ZDTaPtrq+8UdKA2NNMkkwdwROW?=
 =?us-ascii?Q?wToZSgt92a/NG59kx+gj7YYxqiMHPIzLi/P5t2Npg6/YtJ8Cp303eiEyAnP6?=
 =?us-ascii?Q?6gcuon6s6a2RjN/KbVJnN+HfUiXX+cS04+NiKN+24QoT1rk0TEBU/wSqnm1U?=
 =?us-ascii?Q?lAwM136U3ElwxrwZG4MybScBw/ov7MQYKDVw6r9wPu2bhLNJtxwjUj2KNLg7?=
 =?us-ascii?Q?V+Xz0+//sYc+/u32gvQwknsGzmZuavHC9V2aM86Am5LjtXYgpcjXiSGO9AgH?=
 =?us-ascii?Q?UTJQzFvOOSe+shihzISASIro3x848w1qViIAB9gXmhXXauG0zGmkshziiMke?=
 =?us-ascii?Q?EMtg/9VAG0mC3PLp0BrS+1Bwb6rMmNS95zfyINK1INjxVNLvN3JFtlxQM28S?=
 =?us-ascii?Q?mSqzQDREmiSgOCd4ePWPjGmiSKvLwqtgmE9Q49eOH5NHWrbYY0cY7PAtH4QG?=
 =?us-ascii?Q?1pbNuGYKiYieAdbqMov3bHmkvolwx40rnwmjlNjHTFFbDrrpwc6cnqHSJGjE?=
 =?us-ascii?Q?BYB90rYA1gOhfyNXjYl5T82swi9YA1tBPs/+4NS4qcbmVEGzJInIUZEKk0iY?=
 =?us-ascii?Q?5EUHShSiKalELus2BCRqc1wreziDS/kwCYYFiw6dZA+skOla9Pyz4+XLgxii?=
 =?us-ascii?Q?y+0i9R1i/LgmVyG/UMFDLdSwTxGrkCYH75obo3FZyjhiafGxTwCO55nfGYXx?=
 =?us-ascii?Q?Sp0lWHF0soekRg96qztVOEHAvB+l+ls+AI7elt27ITQkpVfq/ore1aaFqBwk?=
 =?us-ascii?Q?ffmtBJMBc2KR+DFzqaUXPpBqfYVxa5tejEYIn2GlZLM2MtEDALSlCBp51YM5?=
 =?us-ascii?Q?62+alsuLXLbdzATwuN1Urr+9vzOf5EuAte++Mx9bfgXY7RXi28ieg3sv+EJk?=
 =?us-ascii?Q?Tsj7sZ641Lpfu4kJUVA80uJT872bbM/jD4gu3c6fS3L7aDD7wDqKxMyIukZ5?=
 =?us-ascii?Q?hl+KD/2K4q3W8s2u28tZhyeVjtAgaaU1ozMFg31hcb0coL+WKUl4Uz2ys02O?=
 =?us-ascii?Q?mrc1Cx/57vnhaO5lt3Y7bLTzFui2Bbl+s3AtqSMzdLmWFPFAw8g3Q9DzCS5J?=
 =?us-ascii?Q?LxO1QlXJjR3tPXjbMhRhrAYF6u2pIdj9qIYOTopJs2+DrZINFuBUYgCjeyoc?=
 =?us-ascii?Q?ZpEbWWmxPfVO3w+JVf1180CSxKbngX6+E3UtTBAqqCEtHXiyCqmxwZ0TcdeK?=
 =?us-ascii?Q?3+xI4cEtI2bcQ8RAhCKv6AW+obO/0zuBkftWGqfP4kenprwzR5rw7PFmPafe?=
 =?us-ascii?Q?C75bNVtCIji6B3qtUDDIfXknphnmlAc=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02a3113-a3b9-420c-7a02-08dedd7ba7cd
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:50.5659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJXOSlvzYqf8cN6rZWHFWoSDm65bwaVnuMPrLY6qDASsqMnm8olyWOz3WPpC2i3d4SoVFeBeJ6YK9TB2zpiTwTk+wAF6ekX9EurqhwfiFAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

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

