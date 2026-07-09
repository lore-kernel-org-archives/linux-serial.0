Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A33B38AF;
	Thu,  9 Jul 2026 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575250; cv=fail; b=WQOriEI1pjbN9fr9F5X0yHimZWcYBMXS4idZD3A3O7mB/VaG2k05xIW2mXSNkvqO0XfLbbKQOZ02Xqpm7OfjpWPgzPJ1tfhq69t67ZR7zRAY5WGVSjsS3K/XhV30mZronTCLtLWfX5vgoDh7U4bwKUGf6dyPoj1xG+woDxHZqjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575250; c=relaxed/simple;
	bh=IAJncchs6cx+RZbaSf6IQsT1pFtbygruVMg76S4DnEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DSkMBHFnpKmo3oIBKuEdILxEaZ9Vq2KW+LRUcyt+shYB9DdCzGj5Z+ZExRDajst1dpg/Mw26K6YYKLQt75WIp7aA+MtJEhwRk5h36H0Q8CnRzYTzbztPj4L6P3f87FxlciKqFtjMRQ30TGkBxbXh1Qo7+P6l8kueK1khxshLRBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=QwdmszpA; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="QwdmszpA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoNZK6l5RW/AtuBfXZ1PRwaF/gsCf8767Fshgw4wXRG32f/qWC969XRtmSlB6JV5cDsmuddM1MBJjYt66ZT3U2OGDH7aFN9jKE4+SjwwIWKjNQm1UNdvxxq3DAT6zGcodYC4cFiqtP7ktYsxtMWFJ2X9KiPfnvgy3ePf/RFaOwUcl7BEB8paTC5XugjAq2ab1/181CcnMhoXgUAiuXVNnjp6aknlnfqwv+J9ZTgN6ctIzLWbAQP2uETl0wh1mw9z+H/RCf429ts2IGQ6CPGqBXWEFfAOnwPe5iNfdCisA5wLE6vN2IlX+raKugAmrJjAeCTCHN7+82/OMrlgRqtS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J+/hhhu6LhfvcAobZdT6+H01MKEQria8jocXCYHTU4=;
 b=P0AO5oOoURTw3lZHZPnuTUbTG4KzSd9IHoJ/jt1uyvA/pyRg6a9tBfXE88fm+w2fRQoqIqPEjE/iKxsHI3C2sV733lLzEema4mm8u498CBgWzmdM5iVvdWu4YZhnf+pYGhshkq04ltrH5KW519sLco5hV+Hd1LsshIsNqoimg9QG51W42LFQGClIg2RNvXzTbhiJ5Mf7xbeeEQ8/UjgZWhHKBhs1YyNuFiZ85umT2uR4UEQQeEcLg9CEpKy1qrZOfvo7YxA62Lkr9bu9JFd2t2o/cMji1eP6p5L81gfdMr7ArYlKsdC/+ooYO1dPQ8d/aciLXQ/h2s9UHIIgnRDSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J+/hhhu6LhfvcAobZdT6+H01MKEQria8jocXCYHTU4=;
 b=QwdmszpAiMNddKHq6LfVwpQ0tmvmTu/dnqGG7tRhDRgEL/78XNnBiNxVVa9thz+9Xd46b1EHLnGu6EskP3MbTIS8pIspuv/zWpx/V5+3jdofw/cqlQ9D5PBKjPH/U6PLeef9esJ39FIluWfAk7dnUIHPH5k6z3LzUpYT8m+aAxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:58 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:58 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 11/15] serial: 8250_mxpcie: support serial interface mode switching
Date: Thu,  9 Jul 2026 13:33:10 +0800
Message-ID: <20260709053314.435629-12-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d280f71-6e2e-4b05-784b-08dedd7bacbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Hr8511wdSi+WC9zBml3Gclojo8aql3M2WtU8zTK3wWBxXtD9KuTIMjrrOwJ3d5KLSrco6BYWlotjtYmfErYUtsYanFiLgSCvCVcQr1EXwjn26s8U2uZtAZwDVWLQpR/t7gQgoWnkdG2fAeJMEZvj/AoPxkrVVP/g0S1ft68sy/Xg3oYPnpauNVUR0O64PdigPAw36FU2OYYsapyjHGekYcZpa7znLcFC3lZ9kb26X+oO+LpBdpT0cWw0rJNOYQec4u8tmbng0NQ5WLzL6865P2H4tn5sagljeuU825pM/z5LtdbaZSizoAnysbIsulgIZPtQRTIAd1iJrpfynF60j7I5znRXvCEN9BDYzs0XGWaEOKTJbeddv2Jns/N3VQwjaIu/6IHfXr4hBSo1KwK41HTL7AqzHCRyHpqc9qo12oqXM6iSR206RiDuvQ+5pND37cpuRd/yHDo885EPT0nImxowIIxAPtAX+dlMjRlbTkNpWUbvj9LV62UyUIQBisYDPMBPqaxE9Ns/XhpTKwIUdRGQNqvIQrFNNCfb4rnkQRHyp2Q0JnxMUpyolLvaCbGheJWtpjQiLXBMKoNjArAC3APJ1qYxRzY1Aqsz9xCmNPRWxbTPy9peb8kIeFFShUn0XbR68bnO2W3khV9KTMCcbKTmCBucBqKWwP1deAS+wdxZPuIEao8O9yhRBFGWN9mFo5uWpVtVhB7HOAJehYzrNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TfaYdcMYqqoJdoFt/utjjX3S89ZnUv9Hb50D1p+Vr7/oIEwofNHb/fx1Tx+b?=
 =?us-ascii?Q?VyrN9f5CeRok/CWyxJ0hvZd32+ZJW+haH0WuS0EemcK1oIKXocpi3gTObwWU?=
 =?us-ascii?Q?3HpDzp8JIHgBFCgAB5goB9O9C5IRVjg1ozZq1uejYseo7UCd0tldZTJkHdCR?=
 =?us-ascii?Q?9w6GfvdkQhuH2ejGN3Wk+M1yynDg4KWC/U8E6Z/UKHCSrd7oIHK0s1CqkrK4?=
 =?us-ascii?Q?2DxU8NIibeHp/KLY8k8lvtTSdJuC2qR0FWfXCCp/K0Jfz89C0sKqiMTjxWNe?=
 =?us-ascii?Q?fW042KuOT3WOK+O2T/rOQfxIZPDd48NJ63ncaiR4KBGIudToOV84Dn1huikU?=
 =?us-ascii?Q?hgfTYTiw0pZRlDxhaWmhk7JoDxLbixmmqrvPk7GAxrEfxV5IdSlC6wCFLlqG?=
 =?us-ascii?Q?vLVi3U1rqqVgUR4GM/93mvLj8Adcyn0Gdd1zhDHhcTqoNvyEwyQqWwUm+QOI?=
 =?us-ascii?Q?5c2a9x1nKColwgINnKoqrh/KJ6uKDCpVvtGODdRZM0sL5wbt3eP4YVmYid+0?=
 =?us-ascii?Q?D08LF2Vdn2u3aEGQ3pZ3MWQ44C3MetOv3OGBHlrht6v5sPonXCP/O0odkB2y?=
 =?us-ascii?Q?oWbPqB5Pi2epXyBliMpvV8KJkiT4oORo3LwasxQaaVK+BA4De2OhrhxlZJiX?=
 =?us-ascii?Q?QDZJgIFK9k/mskU9TwZnumod3z/t178Rfz2frQ296B6VtMBEUeacS7k2Ij+t?=
 =?us-ascii?Q?+7JwVIPgxA+T0403wOaNiI2dHhucME/hygprZjSjkM+6k3kIPFULNcwhtQV0?=
 =?us-ascii?Q?TzEFFQWS77Z07+qadkjs75M5E6FvatsLa7G+08+N3y0RiE6afmoYanRfnOTy?=
 =?us-ascii?Q?W6kiyS6iSLrEKcob+BhxdYU3ixwKUwKjNXM8//fBfWLEx/FPpIyfrm2Jaq8b?=
 =?us-ascii?Q?wte3durglXR4iZ4hXHEVRZq6VXI0s1VeLUQVfccr5GQ+6CBZeOqzg9tJh0Wn?=
 =?us-ascii?Q?hxv0gZpyKEyJE92V0ECihK4M/KpgplO1/ztA7errbrUhxqG2+xBHn/BnRn+G?=
 =?us-ascii?Q?Zedq/m8JqybFxM2f6hwDnB57lhoujEbVHOOimw5aaleQQhedJAD4a+Kqx/1P?=
 =?us-ascii?Q?PIWSb7DfZ1yob4qJY1AiVJLXxa4kr7uuMdRKBL6XaZLLr8WRGSnKrhTzUEtn?=
 =?us-ascii?Q?0z5AqSYxiVWXjclq56EH4tgK3+3b7EhgweA7RZIUOZg1MlEOSq/qQrf9BBAL?=
 =?us-ascii?Q?DxSzii0tIalXwxOKpxHacb1jvFDDnNVWRkTJqhC5Rxu1MR2z5KSoW19wzNSI?=
 =?us-ascii?Q?PKXHksUal0jeLi3DAhRQNez/QlBmiMZSRPszsDz63ZM/ohUfwkvUEW4QNVSG?=
 =?us-ascii?Q?QFZrmYtCF5zqh6L2zz/18Cntlzg5bAaSgpkh8V2MNKHuI9eLKHi4a9k4WkmZ?=
 =?us-ascii?Q?Lvz3kPp3vVJtx5sKCXDhoLt4+ksg88Gch8ZX7QveRkob+xwOGk+F9OzhKLJj?=
 =?us-ascii?Q?eOAMFwQkZX3MpktVo41XHvTgSM5beIa0TCHG1DgwUh0eUKn9Qk/tZJsvj0t6?=
 =?us-ascii?Q?CcPn4Ee0weSbj+Uiuq+uKxHKJmcMpdO/YR6U6/dsRHH/V0Z+k+df3koLzkwq?=
 =?us-ascii?Q?q1cWi57AaYXTHa+7B9Mf4E8ZXNUnedMtoxBEgFq6DfdqUvuJ5EQH98rNDSaJ?=
 =?us-ascii?Q?gyLCdbkvGmCHq2PYDh6Vzi2Z69QqLPe8EsaYqaiZnGQ7lqJ/g1zOQ0Qi4tlw?=
 =?us-ascii?Q?9fx20zt/gF7GDXKis2/dpMJN0w/tsQgFNqITl4ZNLp/IuQm2aKxE5rEjQdQt?=
 =?us-ascii?Q?2t1Vvxpbn1RhSFXnk6igeYoqKZ2lLcQ=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d280f71-6e2e-4b05-784b-08dedd7bacbc
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:58.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1HHo6muy+W7fYdH2Utn0vPsOMyzjqpfx18gw4XMDJ1DnaVIa+Zir5ITjiCgMP9FZ8hjGt59dGxQ0Vnv93dyLDwRs+hapZFJzdpj4g9Ib/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

Moxa PCIe multiport serial boards support switching the serial interface
mode between RS232, RS422, RS485-2W, and RS485-4W via on-board control
registers.

Implement an rs485_config() callback and map TIOCSRS485 requests to the
corresponding hardware modes using serial_rs485 flags:

  - RS232                  = (no flags set)
  - RS422                  = SER_RS485_ENABLED | SER_RS485_MODE_RS422
  - RS485_2W (half-duplex) = SER_RS485_ENABLED
  - RS485_4W (full-duplex) = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX

This allows users to reconfigure the serial mode at runtime via ioctl().

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 45 +++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 7b39ad19b331..695a896adf19 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -128,6 +128,10 @@ enum {
 	MOXA_SUPP_RS485 = BIT(2),
 };
 
+static const struct serial_rs485 mxpcie8250_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX | SER_RS485_MODE_RS422,
+};
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
@@ -184,6 +188,38 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+/*
+ * Moxa PCIe multiport serial boards support switching serial interfaces
+ * via the ioctl() command "TIOCSRS485". Supported modes and corresponding
+ * flags in "serial_rs485":
+ *
+ *	RS232			= (no flags set)
+ *	RS422			= SER_RS485_ENABLED | SER_RS485_MODE_RS422
+ *	RS485_2W (half-duplex)	= SER_RS485_ENABLED
+ *	RS485_4W (full-duplex)	= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
+ */
+static int mxpcie8250_rs485_config(struct uart_port *port,
+				   struct ktermios *termios,
+				   struct serial_rs485 *rs485)
+{
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
+	u8 mode = MOXA_UIR_RS232;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_MODE_RS422)
+			mode = MOXA_UIR_RS422;
+		else if (rs485->flags & SER_RS485_RX_DURING_TX)
+			mode = MOXA_UIR_RS485_4W;
+		else
+			mode = MOXA_UIR_RS485_2W;
+	} else if (!(priv->supp_rs & MOXA_SUPP_RS232)) {
+		return -ENODEV;
+	}
+	mxpcie8250_set_interface(priv, port->port_id, mode);
+
+	return 0;
+}
+
 static void mxpcie8250_set_termios(struct uart_port *port,
 				   struct ktermios *new,
 				   const struct ktermios *old)
@@ -431,9 +467,14 @@ static void mxpcie8250_setup_port(struct pci_dev *pdev,
 	int offset = idx * MOXA_PUART_OFFSET;
 	u8 init_mode = MOXA_UIR_RS232;
 
-	if (!(priv->supp_rs & MOXA_SUPP_RS232))
+	if (priv->supp_rs & MOXA_SUPP_RS485) {
+		up->port.rs485_config = mxpcie8250_rs485_config;
+		up->port.rs485_supported = mxpcie8250_rs485_supported;
+	}
+	if (!(priv->supp_rs & MOXA_SUPP_RS232)) {
 		init_mode = MOXA_UIR_RS422;
-
+		up->port.rs485.flags = SER_RS485_ENABLED | SER_RS485_MODE_RS422;
+	}
 	mxpcie8250_set_interface(priv, idx, init_mode);
 
 	if (idx == 3 &&
-- 
2.45.2

