Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497827FD48;
	Sun, 30 Nov 2025 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499527; cv=fail; b=M3BKTzwuXYQE12HztWb+XP6UArsDlo2nPEZYzNh208S1pTBxrL12q4erRE6+nnsNLMM409azLXRE8qLeFjHHnst0bsnrsnamyjSLCIGRHsFd9f31Ito69IjxJ/QGm8mFgR+v6JJqEpjZkSjhPf1vvSIfz2k88PNLAcBFAD6GYpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499527; c=relaxed/simple;
	bh=If8+y4NBkB3cX00ed7KKb3XA0NWMZtxDOXUfvGg97YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ds2+RvbYvq57ubCZhM8CZsPzeEsR4FhbrhOV0q28wpDLWKgmnbrm1Ag2j62hHx/fI0g+cHeSrZELszvUZg5wL/fuiyWg64kmdZhdD1bpiKljKSiZ9rhOzOYDZVlk7i5LnFqvZKNSyFKhpU30JWdJ7ai+t8tJTNlQOsDRZU0au7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=fH+UdzF3; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="fH+UdzF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABkHfauBeyTQienlPa1T7Q2CDZrntH06Nk5/ovtvdXSBByp8AkCxBgmIabkWrk4oUPC74vHCOWbX2ZrTGo/y/N2HZ/gwYe0m3DnfSW3DFCwe3JqUG9gkeiXJWqkS7FFlTKuPPmn9b0whrRkrbcO0olWJzpXZdoXHqYaGHMdrid6nPxw4pdIFApYu5HC4Ny/LNAz5+V6g5wmrppEqvraHJbPJOhOkiA/A4uxAzCczPWg5juVYO9lTJFeCMXQO5vhWyA/f9XAfY/CxjwRs52prNDa1L7kjv1EBfLKecfifKnTxg4nNwESkOjg8oFJBgVKF2fYDYvips0eV551LHDYJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5qnplESmJN8EVLkstzuyTH9YbG7Uy6vFVAZ0S4GMA8=;
 b=eRxhLs215pXmYtN1oWLoQSBhixk7gJ0j2R1mwPxRTPvtvEtvIrIR/cTPQNjTDxTMeaX5mv+QAmJQE9w8TpTsMpaV3zwridXiu8T9T88xMmxNbIHO0I+mRGHvaZJmD0tvHGCFRzgy9mpFyUc1pdOKH+rnL2dCJQ8x5n5TIHhAeaXOuZnKW2XXAFMR55k3PkpjXxy+ErhdMvnF2DjPAhg5FK1WqEFgf7LeYxw6wMeXoXFExnv2jPeB9UXjXBZt/sHLLNeC+FxvQTYU480s+XU7SA0OHFXSMTknl1Due/COLLx45BKFk19ipwsFNVUKGIA3zAPHIAqRSknU13dx85usKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5qnplESmJN8EVLkstzuyTH9YbG7Uy6vFVAZ0S4GMA8=;
 b=fH+UdzF3dN0pIuYlWtjjF/Tv2ebXO12KP1CEK0bopfIQBb9XBojBHPZFhnOAqYov5ZpFLONn/sanCsDoHyRFYjNNnfysrJNC4bxgkZ+FA+3izNF4U+lR5jlA16XKWQnTm3MkCa5roiLheCO/MYDWMSiCpBWLLug1df8bzOyc26c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:19 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:19 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 22/31] serial: 8250_mxupci: implement rx_trig_bytes callbacks and persist per-port level
Date: Sun, 30 Nov 2025 18:42:13 +0800
Message-ID: <20251130104222.63077-23-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 1466e2fe-1583-4a27-3a2d-08de2ffd8e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fpsnX8wzIFJKmoDbYO4O/cR4Z0dnm422tEgoyk8O47Af7eZP2ukbk11QW7bw?=
 =?us-ascii?Q?FJum780lBJp943A8EoDKvJs9engodWZF+nGwolwyD5T92AxTtUo1SlhtynmC?=
 =?us-ascii?Q?8SFm2akGYRpkJSWSIv2XpA/7zKLuj65TxsHn86xtcR0U/PFx+hykkHW1Vf7q?=
 =?us-ascii?Q?ZRIC6OUXH2EuozKDZaF4yxMMDmwMDJNtmwS+HcVo/eT3DEWYprnpR3FWHq8u?=
 =?us-ascii?Q?OQnpLPtUZ45ke//LenYE7zbJzEyTnOn/cLSFyOTFwmk+l+TqiAAU+07sYgbM?=
 =?us-ascii?Q?ypdBVsJRKKTwrRmhgEblWTidA5FaZkPsRvcQb3xAOVTNdHiVOttHdiPlDAta?=
 =?us-ascii?Q?8ZqmQRDNyVGNvVkwnB5sE4CJ2y0uqPmd8jcRcF1I9HmYWIhK0LiCWtOQny7U?=
 =?us-ascii?Q?9MagDkB1AJSYqF67rD2gzDQSgSr0V4juKSi17KbqY+k7RW+ZAQ9qc2xCcDAP?=
 =?us-ascii?Q?RdMupIvRCTidgCCQUIx1eCLAFuyzcMESIZUth1zgpUccGUC99oR8oLK5/YOc?=
 =?us-ascii?Q?89U2BgwD/TkVlPRkmX+DoMPwXEkp6/EwRchwgIahkAyhLsyQkww15Oy0bfm4?=
 =?us-ascii?Q?MFoZ1wGvw6M4w6BfZWObmmFv7QTJH9vhZ6I2GtivDJYG/n6z6d+5/vg2J8Kd?=
 =?us-ascii?Q?dTfWdxy+J5ig3bk+RgYDyWDpbjuxU5zGTYc4ScT9Q0+QC0S9V2SnmQL1EEcj?=
 =?us-ascii?Q?TaBybq4wdKFYYUUedKAMdLacFt8lk9VbYHyiX1zR6TNqhfs+VMzbCs+y3zXr?=
 =?us-ascii?Q?5DSJ6jc2THfgCCnVjf0UvXeuZ+PPix9aHSbr5mY2qDnq4R86JPbdthtiREKl?=
 =?us-ascii?Q?EdyCYZiZdSLkbJiMKB66TyHS8Zu0svMH01iC0quv8m4CV7I7w6yH73HN8VhE?=
 =?us-ascii?Q?4LRKLnOgUte2MbxJtb/+Nqnb/efaFuhqdRN8jgsKEWP7noZvzfjZ4mm1afND?=
 =?us-ascii?Q?xhBQxeBoluyz/uCsZQ+duIqidb27sy/3rLsYI5dUnQvl5XObwb9BwtXMjIHP?=
 =?us-ascii?Q?q77550R6CAA+HoArt/+LzIu5hI8Yi/+wCRiIkt9golHpqRyoROk09VBIhURQ?=
 =?us-ascii?Q?VXD1ejzD6EFKyvDyiiB2lZsewGhHzziTVx4GLiwVyU2d/m9fBCsjli+gEqJC?=
 =?us-ascii?Q?X19nHYnAWKS9yt/eo77ZC6UdcHX2rwhw21USAPUa7MvOop/1df7xA77so+tM?=
 =?us-ascii?Q?wvLX2yIGfR2HYUTn3eAXeHz0sjDcTs7VbmK7GHM2kJcxWIADs7D0EhtjFRj3?=
 =?us-ascii?Q?vGQ2ssuyTXhPwP2rz0RTIAykfHlqOoWuMSLQKTcZYJHAt7q3R0kDhQYNfrvX?=
 =?us-ascii?Q?kGW2C+6L4EuFTgvUvEoj7nwODLyYgCi0WNE5cb0BeSvdMIm7GvgN0k7A1R2h?=
 =?us-ascii?Q?+niE4wdVsbHHbrtsVq3GkhwOHF9sQHShIz7uC3h1Ro6vCKK6vJ68Gbj1BGYI?=
 =?us-ascii?Q?X5oeNqKEmcmd8X586/S9ScwKpA+vYg3g/KyG19zW5grW8urG+ihO+9I1DBGt?=
 =?us-ascii?Q?eaR2xxBFyqE3rX/woVPmJB04yT2842A7ioLJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+sOerlkIMrJmzV8Sry9xZtatkoYI+3dpSnVlJ57nEidfHOKRPg0y1Ypy/fmk?=
 =?us-ascii?Q?9nspP0SNkVc5MzpmmjowaW36UhwLjbwajYo8lGTZs7eZcMU80u1x3hoyMLuo?=
 =?us-ascii?Q?RbuGUT1YnN9DnOe5aXrNNKIlw/omKKT+QtFqBYrTBAP675GGcoUrz/23S+1B?=
 =?us-ascii?Q?wrXJKy/lzhs4HbQXZ9jkcewvvW888WYyav5WrGtUNr20pFJApo50y57J/9YS?=
 =?us-ascii?Q?hBO3S+SFOxen7v3yA4ABdPncBeTEU2B7ykrPmQ/gkCtgUav/gSc15MvUNja1?=
 =?us-ascii?Q?VA6Dr8aOchCCrZ5v5A0EY8KXly1/PBY/EyVnCCqJ80+tdo4eZNzxjcmNbUbu?=
 =?us-ascii?Q?MePgK9C7/ajF7+pwdiYibKIhEqEfKtLrHOz1+XdZ49CcVGuCwQLmyKaEVxaI?=
 =?us-ascii?Q?Ihfp42Paj/2y5fxiwp5oct5S3cAcA+LkFymjFFEqBP/Kf0hDa0hpgDacRqcW?=
 =?us-ascii?Q?jbTge82lT5D7a3pKxV/OCTpvJpy2zr2neJLM4UfAn2SljAnjLipWBwMeUs1/?=
 =?us-ascii?Q?9SZJD+TPC/uQBT821Z/NaiC7ZNPjo6BJXMZci74wFx7rXOg+ICFArRKYGGjj?=
 =?us-ascii?Q?LOFwWprlOnc8K3EkkujUY1DMusLNHpXr6wpXH8orZze5gjGG8tP0VmocrLZj?=
 =?us-ascii?Q?jAJUqR33ilXouFRqzEUrNjhhcwjAnncFsIRcaJf24IcMhMVtV1tx70jEkuJH?=
 =?us-ascii?Q?qE6g83+drJsa5S0cMjDA3rzZ1d13Od872kWuGSQZkLa7FIPmyYyAYnMgk9sf?=
 =?us-ascii?Q?dunaKoSDUtZhP1/jxP8PdNI0b2hjmWitGi4hMKKz3wm1yb9iU318V+pVj/XY?=
 =?us-ascii?Q?lI8erl18UT2Hc0TNXyIS1azwKMmFpovcmXcOk7w5JG8phghKa994u4nNRPvA?=
 =?us-ascii?Q?AvDq5uZywlRSGY+GLjmDxsqPzYodO+seKBl3Euew9XIUOBoGZa5tOFhGRaPf?=
 =?us-ascii?Q?OdmIElgROSFtL/NZJ1QxQ3CS1c+Bw7xf9HtsM4JqdQo3nwJVUts114QPwzew?=
 =?us-ascii?Q?y31vzqPBA0ph2+QY22HHVQrSNrkSrPqlX8BCTYUMZjc6vBpa+59qDYD8lcqq?=
 =?us-ascii?Q?6HojsIs3sofvWwVFu20oIzFmVoMU/jHIXKbihcWfeSUBmhO2t/GW331reKXZ?=
 =?us-ascii?Q?u9boivZFRU0m7W4YA4vmAve40U1oK3pdQMyXHieI8ZS57Vhu02gAsMRrHKsf?=
 =?us-ascii?Q?VHsOc6n3OuSgVRJBleL/fvIJvtWrigXXzghSYrw26pUhoQiSUbFxx43b+bcO?=
 =?us-ascii?Q?ziQJDZCC0R45/0/Q67fsYI5te5d68i/9GNfvXA6aPSUYoHsF9SFwnRuieD4F?=
 =?us-ascii?Q?EP4WX2dyzlKV7DQPnbF8+3yUmoRF88ZRBCDzeRgdZE8eUz4hxDGbDJJA1vNe?=
 =?us-ascii?Q?J2FIimTQ+WeuJkoq9T5Jwcqiyn6aefWp2r916FihDy8Rr8AR4QvTulTdFbs0?=
 =?us-ascii?Q?jYq/OFOLVVbx534SvqFKSSv+QOEL7C3uEgFTIxEu0zC3Agoe+Co5nmVPLlXA?=
 =?us-ascii?Q?/lKQ990xSgxdct10NIXcaa/truYjea367dT7SAyMT+wllMY0lKFfMhXssSGe?=
 =?us-ascii?Q?FEuIaG9TXbQF9J7GLlmkPKg7SDp+sFx9/U6+uEOfPXoYb5CX91Rs/zSmxAVe?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1466e2fe-1583-4a27-3a2d-08de2ffd8e2f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:19.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPIelBIMPY/HoeOAjyxK1n3k4g8JW8Bcgo5ESxyJbDFZWqOKPuxAjHYoFJye9/psBBTwQUyVIqSqUuDnSMFxS5t0tyj1oEyEFuGmqm5WSAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Implement device-specific RX trigger handling for the rx_trig_bytes sysfs
attribute on MXUPCI parts by programming the vendor registers directly.

Changes:
- Introduce a per-port structure to persist the registered line and the
  RX trigger level, so the level can be restored on startup.
- Implement uart_port callbacks:
    - set_rxtrig(port, bytes): program MOXA_UART_RBRTI and cache the level
    - get_rxtrig(port):        return the cached RX trigger level
- Use the cached RX trigger level during startup instead of a fixed
  default, while keeping the initial default at 96 for backward
  compatibility.

With these callbacks, writes to rx_trig_bytes update the hardware-specific
register and the selected threshold is preserved across open/close cycles.

No functional change for other 8250 drivers.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxupci.c | 61 ++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxupci.c b/drivers/tty/serial/8250/8250_mxupci.c
index 0eeaf0fa1538..15565729b7e4 100644
--- a/drivers/tty/serial/8250/8250_mxupci.c
+++ b/drivers/tty/serial/8250/8250_mxupci.c
@@ -86,10 +86,15 @@
 #define MOXA_UART_RBRTI	0x06	/* Rx Interrupt Trigger Level */
 #define MOXA_UART_THRTL	0x07	/* Tx Interrupt Trigger Level */
 
+struct mxupci8250_port {
+	int line;
+	u8 rx_trig_level;
+};
+
 struct mxupci8250 {
 	struct pci_dev *pdev;
 	unsigned int num_ports;
-	int line[];
+	struct mxupci8250_port port[];
 };
 
 static unsigned short mxupci8250_get_nports(unsigned short device)
@@ -150,6 +155,8 @@ static void mxupci8250_set_termios(struct uart_port *port, struct ktermios *new,
 
 static int mxupci8250_startup(struct uart_port *port)
 {
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxupci8250 *priv = pci_get_drvdata(pdev);
 	struct uart_8250_port *up = up_to_u8250p(port);
 	int ret;
 	u8 efr;
@@ -167,7 +174,7 @@ static int mxupci8250_startup(struct uart_port *port)
 	serial_out(up, UART_EFR, efr);
 
 	serial_out(up, MOXA_UART_THRTL, 0);
-	serial_out(up, MOXA_UART_RBRTI, 96);
+	serial_out(up, MOXA_UART_RBRTI, priv->port[port->port_id].rx_trig_level);
 	serial_out(up, MOXA_UART_RBRTL, 32);
 	serial_out(up, MOXA_UART_RBRTH, 96);
 
@@ -309,6 +316,43 @@ static int mxupci8250_handle_irq(struct uart_port *port)
 	return 1;
 }
 
+static int mxupci8250_set_rxtrig(struct uart_port *port, unsigned char bytes)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxupci8250 *priv = pci_get_drvdata(pdev);
+	u8 efr;
+
+	if (bytes > 128)
+		return -EINVAL;
+
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	efr = serial_in(up, UART_EFR);
+	efr |= UART_EFR_ECB;
+	serial_out(up, UART_EFR, efr);
+
+	efr &= ~MOXA_UART_EFR_PAGE_MASK;
+	efr |= MOXA_UART_EFR_PAGE_1;
+	serial_out(up, UART_EFR, efr);
+
+	serial_out(up, MOXA_UART_RBRTI, bytes);
+
+	serial_out(up, UART_LCR, up->lcr);
+
+	priv->port[port->port_id].rx_trig_level = bytes;
+
+	return 0;
+}
+
+static int mxupci8250_get_rxtrig(struct uart_port *port)
+{
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxupci8250 *priv = pci_get_drvdata(pdev);
+
+	return priv->port[port->port_id].rx_trig_level;
+}
+
 static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uart_8250_port up;
@@ -324,7 +368,7 @@ static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	num_ports = mxupci8250_get_nports(pdev->device);
 
-	priv = devm_kzalloc(&pdev->dev, struct_size(priv, line, num_ports), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, port, num_ports), GFP_KERNEL);
 
 	if (!priv)
 		return -ENOMEM;
@@ -346,6 +390,8 @@ static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.throttle = mxupci8250_throttle;
 	up.port.unthrottle = mxupci8250_unthrottle;
 	up.port.handle_irq = mxupci8250_handle_irq;
+	up.port.set_rxtrig = mxupci8250_set_rxtrig;
+	up.port.get_rxtrig = mxupci8250_get_rxtrig;
 
 	for (i = 0; i < num_ports; i++) {
 		if (serial8250_pci_setup_port(pdev, &up, FL_GET_BASE(FL_BASE2), i * MOXA_UART_OFFSET, 0))
@@ -354,15 +400,16 @@ static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			up.port.iobase, up.port.irq, up.port.iotype);
 
-		priv->line[i] = serial8250_register_8250_port(&up);
+		priv->port[i].line = serial8250_register_8250_port(&up);
 
-		if (priv->line[i] < 0) {
+		if (priv->port[i].line < 0) {
 			dev_err(&pdev->dev,
 				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
 				up.port.iobase, up.port.irq,
-				up.port.iotype, priv->line[i]);
+				up.port.iotype, priv->port[i].line);
 			break;
 		}
+		priv->port[i].rx_trig_level = 96;
 	}
 	pci_set_drvdata(pdev, priv);
 
@@ -375,7 +422,7 @@ static void mxupci8250_remove(struct pci_dev *pdev)
 	unsigned int i;
 
 	for (i = 0; i < priv->num_ports; i++)
-		serial8250_unregister_port(priv->line[i]);
+		serial8250_unregister_port(priv->port[i].line);
 }
 
 static const struct pci_device_id mxupci8250_pci_ids[] = {
-- 
2.45.2

