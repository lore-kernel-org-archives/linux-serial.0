Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012063.outbound.protection.outlook.com [52.101.126.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69173A7590;
	Wed, 29 Jul 2026 06:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305196; cv=fail; b=dxzWMFXM9s3+CrGb9GWcWGQK2nmzyloUvE3kxnShMGWPWmP+wkroix0Uvdk5Bz2vefqaSqEqctt4/hxlg9YIJOdgH9C+Cz7THAG4KwfYLC7PGjH2ZAyvjsE4A/UUXYipQ1PMDRIIrT6bdJdEnNOI5vs5rD8AFRRiblyiTWPru/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305196; c=relaxed/simple;
	bh=88NjARGfbcE+QLV9ztharDjxWyXAWiWHXR1N9dii+4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KO+jTCa3qUMryWQalYq2iv94MCRGkXr7wEr4hPIWfVZPxOg8f7paWfzXKUhZFkUlY8RwqjT2+LPOE3T2qazNffLGTlITkG8iUO2QX6Xxiba8WBsw2g4Pwhwd65JiLXLOmlHrQUneZsIKbWzsxOQzB/gpX+BapHwjPa8aew9qKd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=aAqNpSOq; arc=fail smtp.client-ip=52.101.126.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="aAqNpSOq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QN/TZLhjBlYGdE2jNm61NdWiszDgOaLNKOhe7fjtsnIjzJOL8Frf27Y4R5U/Bmuo33mPVlmkUNslNlezfwodHVpkRr/m6plgqdVPjej4H8r3A6hXlp/RZlJLXoUjOVtxGRpWqNzw8YxNygPWfDN2qZPXjGthudQNemAHdFF5yiVNlIyc2gIQqCWvXWGA9DZOUBy9hcKW+v6vv4HcoKunrgdGD2kgOHd+logJJtKmpN/dOnC37ZWmKiM7fXSccIpUeDCr5IHKKRj7FV508PzUH+QSmXuC2XTCO00Uks+KqkdGiVNHqtr5WSb2P7mwvTeI9Q+E/D+or1k0OEmE1jQNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADZabaL7taykDZVAiCGzlKEt5iJSPR/tJopgHLV/WAw=;
 b=dHKJ9adRzJY/LHJcpwjUpbWZpKBQNgt1DRQILRkGpt7uOF6ZUMIrt5xvFS/L2LtWzvxSfggE0pmEBl0iZm1GtxYoDo9iyzchjEiZmdrupxz1yEfpDY2OOvyDchMHimtkdhdixVAjamSqViUmARzxFIL5xFPyuCHr8qQBEMp6MIjNZd1lu09AETzV1LRdu64cGo1P3LzqO1jbnQ2N7WXamRNFTQbV9NgewzxBMnRZ0HnrnDFkqM4G53TlsOxD7QahW9hgjgEBzs6hJ3B7V49Lq1frR5GAD7VuKUYnIU9GLYD1qUNktv8gBPUEm2KVCeuzmE191IqIbfU6bBYwHcJPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADZabaL7taykDZVAiCGzlKEt5iJSPR/tJopgHLV/WAw=;
 b=aAqNpSOqdZbDUl/Y8+biUW2q7vfTiwZyfMlGzlrJkfR0Mh9jxYcEfeK3d7lFIkNyVWxHF/mIJ5YLNaGKhQ3mffYO6hv+yaMfFmlObY5EaqNbmdWtxtxCISvLCs4pkxIggxC9ugIHHRPKAcF0bhh41v0hxaUiIg3PBRwJpgErHaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:28 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:26 +0000
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
Subject: [PATCH v4 04/14] serial: 8250_mxpcie: enable automatic RTS/CTS flow control
Date: Wed, 29 Jul 2026 14:05:52 +0800
Message-ID: <20260729060602.492430-5-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEL0PF4D55A38B9:EE_
X-MS-Office365-Filtering-Correlation-Id: c700e65b-bb6b-4598-2e2f-08deed378661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	0jkr8XEkPF74TFM5FvjSx0Aa+G9G6Y1C/LXKjugBhBrjjBP+vSRQIOVtYPzgscPtEB1JCrZPpcbZpEc5DOm4AxTqn1eMIm4myEHWs6CkVLkvhtbTOWQ0LbrkG8xBc/icyv9pAmVtLaz0yr3D61BP4i+04S16rVA2ACQ9Ny6qdOoMnr18oW06B6mcmVprJe7QW/d8b8tai2TuBP/K3xTRwggmIURR8kbngJr0yb+pwSOvg275uAw1xpQZAmYPpMKgQASEvapTIow+yzh7zVpFHpwm4vifm0huJrLnpW+tmfLd7SbexD42igZkSoqHTiLXvM/uUm1FfcXEQkgnVqa/xU9oOHvbSlY9sVMlPyyWbuTFaeHhVaOHIWvmxIfuopGJFJINibzsNcIPgsrxCUsyD3ja4h/E8eYtLFoqyp7r4Fps9QaG9qkicZYg3FiR89uWHrl+SAf2XY67K85DTQfDpyvgno8NxZIUakGtswUmGDNeWdTZrq1VQLcTnP/cBb2cWNa9tttHPhmXUYZg6so6fHNrRQkY6FnNHMpjZnp/oqxnWJYrVW0Cowsp20iHUDCLpSAtZTBSQSMwM0PhvFySbgSjhzmgubfcAbp8bR8P21U8nwRL8amIe4m+I44ii1zJRN+EmFEhURsfHVBClqUh3d7DJD7VKEJ8CiIg3PYQfUyQBG1LUi+HjocV4ofhl8qx4S4mvdx2ideaG1jUt1ih6uCmQKhuzSnS/nVz466xtMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mf6FayvoaCX5Pc2b0rxvcgmGsuwu4vlSnQ/JYl0Y+eLKytCWua6trgUCnYEk?=
 =?us-ascii?Q?0Du3n9zEHmOFluf5vRYd0qGe/gk+84yJePi/ItTW6YNrNDYodBlxzuXqJGKi?=
 =?us-ascii?Q?z12DTR2/kqtQYuWTKz26UWuGhu+amrBUlHuQOgQtlEVPZ+KnUcmRsDOxiPQD?=
 =?us-ascii?Q?wlNb9A+iqmaRomv5QMRPOnvF0nmCaGkiTWBmVmqfnz9Rf5jrCi2mZ2sCEJ4H?=
 =?us-ascii?Q?WrQu87B2M59Tzy0tQgvyGsy5QCVjhln6NU5CvWY0p8VTaOLVpBmxeDW6lZZx?=
 =?us-ascii?Q?J3+onjanpJKErRqSwr9PQv3GmpZ9/wv7gPaPpSrNi4/fxv7sIX0Wp1OKGm/J?=
 =?us-ascii?Q?VIDvXfWrX2mxJe2UkEh8/0JNENuJ7UG7jb8cEvFwvqnXQilCG2MpUokvI/27?=
 =?us-ascii?Q?fxEkdtfWi7WCdV1vNV3Dnvr2IoOiy4JZCmyf8u7IdQBHEjiYZB2Yy6CCWd3m?=
 =?us-ascii?Q?ZfInkXjEKFKBxnlJRy+3rjDy19KQg6pUMm2OY8t5cr0LYKVNM3+gdjpYUzwe?=
 =?us-ascii?Q?LCj9T7KBg7jKarlLWs7XydCa0E0NKgPzewzccUvjmMhtAExEPkjh8MK4xUMU?=
 =?us-ascii?Q?HHcibkfxZL2X4LtzhE+APWKmYaDDCiSIMtojWj+dJw48f4NmZdAfBg66GISS?=
 =?us-ascii?Q?mUx8Zv01ESY9vWdJ0+2mw+Vged/C5DnCJtrhGYChKz0KQAyH4m2424QzxKlA?=
 =?us-ascii?Q?CzFGLVGCUq94QVCZd6MznHQIBwby7iiS4J0xG66uVbSKB9izfb63L61vAw8u?=
 =?us-ascii?Q?a4OmcaoaHThiKy5t6h/1w8KVRtdDYKyh5zrGy+M5ZXI7dok60dKHFZiRMeqd?=
 =?us-ascii?Q?xKPqUsczRshsEDsUgg1EsQ7YSy7fGaPlDDsfT6U5m6r2Xc9WJEI+tlv8vpGU?=
 =?us-ascii?Q?7iT3fMZ31uXcGGGOaN9/7dW+m8xMdua2O1KXo/eMRhshDx2KKcObbVC0z/QT?=
 =?us-ascii?Q?vXRtWZhdcO9jJQvK4panrVPdnC2wvlfw18vmd3q0cMyB9QC716O0es6qtfDa?=
 =?us-ascii?Q?oAYx/beo/+Iqcbt6BEj2BWUrPko7M8HbH2xPu8twkbPvOPRnO7d5G//eqgre?=
 =?us-ascii?Q?prFlYuGZOUqXtreD+v+4sXLZF4BuwF+5ZPlCmdIn5sm9gnFggBRSitv7mlxS?=
 =?us-ascii?Q?r6pyqOj5v0uG0fzsedplFuR92HCghmMy1sJXiIiEUB2HOlu46ZxznLrsQT47?=
 =?us-ascii?Q?prVTpCCUy69ydMvdYghsFJUNVqdJJXn9+Woh5Nbjdt6wcIW7BCPAhJvnZvCS?=
 =?us-ascii?Q?Oyi0Pt6FAR3A+euuPv3afa0rQRaFckAKkRxpxwu2VSEaPxQXkb0Nco3vpKqA?=
 =?us-ascii?Q?EDKfsTzUwwVHnCVTrl6zPBgSHCjEsGlDdcUVMeIOMbadZrl/9KSZsgWjlR44?=
 =?us-ascii?Q?Ef9O+Ara3bFcfNVjRsHDYYIKXz4hEda6lRXTLr8LoqMdACy73/kkNmMe4WFL?=
 =?us-ascii?Q?mfIwmC7O4z8PUfpHr2BcqhjsjWkNHfPO7u94JxWhEYhFayuoSksEA2BWRYN+?=
 =?us-ascii?Q?ToqNqoDl2dW4aBbr6JS3BQt6v3BEbGPyIbB+3RBQG+Klz7kBHkSgMXa3i096?=
 =?us-ascii?Q?R5TSafqmt1YOtPeyLHiyaWHMbhLfGpVbOia9lwQzZPwkyjtypE4agiuGxJj5?=
 =?us-ascii?Q?YNGqWjcUgDPT3Tl4/9OwQLc6JXxSQt/s3fjrRVn8HlhWXmRC+AxYiTm1TS2f?=
 =?us-ascii?Q?wnM0zTHghfW55U293dmuv9wrUdCBWf9fJm6ihQfk5et6PPxLXTtlImPNBCFT?=
 =?us-ascii?Q?atbK96EOo66RTt7F1OSW3W9ic9beywk=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c700e65b-bb6b-4598-2e2f-08deed378661
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:26.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw2trqFHHW00h35vCSHu3YXjJI4Rhepys7it7lXXL1IaRtgedVkQROy3/BX4TIIQuyrq3nUrJWCWd1LMi2CDSXPuMHWiRnGuVy+exnAMy1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

The MUEx50 UART supports automatic RTS/CTS flow control via the enhanced
feature register.

Implement a mxpcie-specific set_termios() callback that enables MUEx50
auto-RTS/auto-CTS when CRTSCTS is requested and disables it otherwise.
Keep the 8250 port status flags in sync with the hardware configuration.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index a73cd44c55d3..1124c7d951b3 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -58,6 +58,10 @@
 /* Enhanced Function Register (EFR) */
 #define MOXA_PUART_EFR				0x0A
 #define MOXA_PUART_EFR_ENHANCED			BIT(4)
+#define MOXA_PUART_EFR_AUTO_RTS			BIT(6)
+#define MOXA_PUART_EFR_AUTO_CTS			BIT(7)
+#define MOXA_PUART_EFR_RX_FLOW_MASK		GENMASK(1, 0)
+#define MOXA_PUART_EFR_TX_FLOW_MASK		GENMASK(3, 2)
 
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
@@ -148,6 +152,29 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+static void mxpcie8250_set_termios(struct uart_port *port,
+				   struct ktermios *new,
+				   const struct ktermios *old)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_struct *tty = port->state->port.tty;
+	unsigned int cflag = tty->termios.c_cflag;
+	u8 efr;
+
+	serial8250_do_set_termios(port, new, old);
+
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+
+	efr = serial_in(up, MOXA_PUART_EFR);
+	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
+
+	if (cflag & CRTSCTS) {
+		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
+		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	}
+	serial_out(up, MOXA_PUART_EFR, efr);
+}
+
 static int mxpcie8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -285,6 +312,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.iobase = 0;
 	up.port.regshift = 0;
 
+	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
 
-- 
2.45.2

