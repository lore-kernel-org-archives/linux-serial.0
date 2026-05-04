Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013061.outbound.protection.outlook.com [40.107.44.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35637347FD7;
	Mon,  4 May 2026 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884614; cv=fail; b=MjO/AV/yMjGSUO536uTtxPPDasirAAlw0zEhNdeUvWc8EoulF1/4KgBGRoJ32vQuV9zG6Pb32o0fIWd4hac51qmroAstgvi/xAYmiIKPC+V1f/WCask3am6DwjJs0WINptHWaUUhCJv5obC8Zm6SdKV0kd1PpAl/7eU3QiH2fbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884614; c=relaxed/simple;
	bh=2BWMsQcviIAlYSd5qOgjA7zWJr8/zjEjk8e4RdhTGMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UI7XsN7hPY6hcd8cM3wbGtqX3X6p4opR43D1Lp4KfaDvcmp7v9/LVr4BRo/D7AHXrSGCjdP7Dg3vB7OnLYVMqKkEYzcvHNPN8ZET7KUFOETissMqpFlosnw1slofE/jEtIT8372iz7D9CTzM9dQ9ABNwBUNyr8Ynf/roLGuPbkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=GKsndMlQ; arc=fail smtp.client-ip=40.107.44.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="GKsndMlQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sne6fUCQG4LWlf+rxN8ZaKjHP2bz+k6YW29l9XZkfGKwkLuRfIoz77hrABzyOBnVRpkVniKqt/kdH7jXpW8GMlxbVOnA2D8QGAHNqs1Uea7R7RDSFt8j4GvbdX89wlEozOonQrPPL2aiR76AO2lEGQ/9sVkcr+qEGvAsg3tVyqlUcVrhbRqFShu0OXzL+WkTu0RWYWn383jgTjJUWx+YYlCAs4IQdoO1c1GMLhv6Q90zhTZFAAkZM4N4wuX6tQeIbUz5D7k8o0m2zDQmvw6J7qK0XARL+gDyuD+kUGnYEUPppQ+Kv1EFWci/Tdfc6plQXZhKmcVUCviGmp8j5YHfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpS3JLL9xGV6JYf+ZycaWbhs7LicS2btM2YNSYqn6wY=;
 b=T2vbCGkgGXeOlX8hnkCicPItZjDQe79ahF57Po9vZpr3MYdJjP4NDN7CmcLY+spaXXI3AS5K7Hb56N01I51zDaF3rQOmCdNHUCilEdIIe4ZakU6leClp6xgNzaOlcspb/C0e+IBwtx29WFclvv31VAuXG+vGSzGmVJFWUxCTEKXqDeHtfIlJoxcQBiPbi5AM3GigNyO9/GQg3Mie/QpolAnO3Lmmd3CJyAW2IUbNGpANii1Z2GIG5H+s+dV7+d/iJmrqojAMFMSdGNpTk3/vWZXTW0Ay64SyMdzNUowM/DgrW3cfYS+mTaQrMXSEsLI2CmdWrxLn88Q2Cq1FYrlENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpS3JLL9xGV6JYf+ZycaWbhs7LicS2btM2YNSYqn6wY=;
 b=GKsndMlQkcbyZFCXIcEbzkJefG8Tp11PIg92kcbqqdsHgfJDu45n+xJm52zeiElR/oZ7ezBYxIt7xtwbxuYdHpHofJalwBle76UhVxwDNp7HiI0LnZhdSAGRzCtW01grEen4FyJtpZ9CqzXXpN/W2Z9aMj6OYKKWs8AgABlWAxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:50:10 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:50:10 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 05/15] serial: 8250_mxpcie: offload XON/XOFF flow control to MUEx50 hardware
Date: Mon,  4 May 2026 16:48:50 +0800
Message-ID: <20260504084900.22380-6-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f461246-124e-43a4-0bc8-08dea9ba25f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	HRVdQuwc3jmy0P8Lb4xJ8XvOAeXkC5Z/lIQNcBQrbnPNhOIiRzgV0qYjwuwGxgWCFAP8GFoZ697VwBWD9XZa0CV3eHOMpUQ0i06P4VxSofX54FoyzssASkK8ZhHS2xp3I712bBHu20i0WBuC33I8q96weZ9HOyiFiui7vz0X4dE89aW6GHiV45osf9W9CTnn8UjGRKmc0IgY33s64opoYuP6sIH4H5e9XxFvw0WCjoZVW2XS8wRtcfxVYo5rWme+b8ba2ZQX1ws5HqY0fe40dO3R6Ww7B3Uj1O6LkArgKq7JAG3n9pK2EzjCXTNoLTdgY2z1w3nyP9rE75GXwii0iCk8J1ZARneRhbgBunE1wXYGEwwcMu2rWEg/6A5qO6nj18ahuCGroVFNXgdxsN88mvEQzbvHtYgXcxIZORPa3njZglsyekt2e2FftZ8S+/DfSc4b0buOAciuSryPAdxTwvfDPPE9nowMTIumX1Z5HAZqJEBlHhcFAH0oji2dz+Zj94bsRnIEqKPOBEK74BvngR/F4t+fdKrLLFPp0VqH86uDprmBp+awaFdf36+DHIRb/ywX3E/4KJZbOiPVxvFINTCKg6zxsJDgxvXwY+9ywlFmOvlLSWQXziWXGXBg6V7+Vf5syP0RGqEeR3TCdtpgYYmewiesrlNbXaE08SnrlWyc3O5w6E5dzs9rtMa91TmQM5dPQO9/K2uKqXp46mxJhqXcIUHm5YW+B9byeR2qVPqqC0nbHMCHuiS1+gqG/+kH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?selcoiXpwcsakk9OvQpDbbZRt9iivfbCMd72taYotiuZ/QAnSJvl7QYGKjy9?=
 =?us-ascii?Q?4ct9NfWbQhnLGOgUEGV828Y+154pIYdgDKzd8QI8IYMTdY0L7ejyZwCTU8wJ?=
 =?us-ascii?Q?0HvSEn1EasycH84cGNNRmDFyEGKf+ldBD4kSAbuz3XDPSgqMfylWaS5wpCdh?=
 =?us-ascii?Q?BzidEaBDp2UXsPoBj7Pjqgs45qFFbKqTX4y8UiuhKTuEqivhHGz0QY6pwyT9?=
 =?us-ascii?Q?tzjEeYX1ffxrUT8H/5lAeQo25woAxakAu1GrlrO2GjRRSn2+p0Ek9355saFe?=
 =?us-ascii?Q?whRdWewXoXix109vMqllzLdJFumTAPYWMmG2bjqarZE6N9OeHErnoyK9spG2?=
 =?us-ascii?Q?4r9NQoXVoXy1tH0uhS17w6IPitjwCd2+anr6vPa5fJXt+LBDWiWcNcxDI41b?=
 =?us-ascii?Q?vFVrsvgPdriEAHa9N+6UDw7Ej+OazbsblcNTVEAaOCY44DYphs3dmARZ1tOw?=
 =?us-ascii?Q?Q1WbT6HNJVLKcnAeqdhcyag0iXA/vRHphewImIvMGNZ0BvSewm86WJGcnCbi?=
 =?us-ascii?Q?cr1h7JX4CxO4H5awAFw2PaS87lycqNoXlH4i/3wt1jwEenV6mxsZIhP+D96U?=
 =?us-ascii?Q?yMEPNS91vmDnEgyX+EM7w3KOaFAlYCsi/ffRLAbZ5RzEO3FOnxw2Twvr4hX+?=
 =?us-ascii?Q?bZFgE8AFLpQfi7/vpLNuCNBmsyPHsjW/bCU5VJpBweQru1jWNOV8EInrZkYz?=
 =?us-ascii?Q?osND4h3gMjG8uLYNXPOntl5MtO700hY3PF7GAMOEUSRt++UcExORhYsT1zOM?=
 =?us-ascii?Q?TXL2Uv+cush4WQK7h/4ZwwtRR7Wg2+0VAkWKT835VwoIkg1j4j9NLbrxxHxL?=
 =?us-ascii?Q?6/saCm04NzqGDDGHVnoUuqq1JEu6TiWvO+D0+OMH82WdD+QA2AEbxIkSpBDl?=
 =?us-ascii?Q?5bgTZ5+eKBJDiBvF4vRtZK0O+vxanMY0UwbiOGvVgSO0tT54goKZViY7y64Q?=
 =?us-ascii?Q?pVAkT/1AmRzWFhynNYq1GjbZ3eYh1m3IOXJ0iVVFlwP09SStaAubREwVStCx?=
 =?us-ascii?Q?1SAR0CeJ1WD92G+dtrwBcM7pCKiqDpczCX79vKcdV/S23OVMaW2juXrbCNkL?=
 =?us-ascii?Q?XTLk+0aYP2CUOC4zLeZBkqxq6lcDCR2LiiWyxzD8AitfiX2B5B10n4ZZLSml?=
 =?us-ascii?Q?ATi6m9hHRovF18nXQVo3vLOTjneZzgu1dEiIwicqsTsa0UHAk0Zn7RKS1qnw?=
 =?us-ascii?Q?mQyPvMXBuUhhAvloS+EdgY0XbFMlchZLZPxa9WdJFbDCHX5Tv+7/D21Fnt0r?=
 =?us-ascii?Q?k436H15v99xcfXp8TP0+k+5R1h4HH9L8mt8StqOeof0maa5S2J9W3UHAKSo5?=
 =?us-ascii?Q?KnSA/zSrTCXRl9Vr8Q6lDQ2aifXy6JZFnxv8VZDHpQo0QQqv/X+QNx9QuVdR?=
 =?us-ascii?Q?jfUSRZGocN6rFNipnP5f48b7QQzGZPWOEQw3n5gCRPMSGoC1nUCgEict7yx4?=
 =?us-ascii?Q?MjMg/a98g+tgpzR8YiDBT58Cbim9kNNS8nOIzmT1XIYxRTRYLy5vC8hJbk8g?=
 =?us-ascii?Q?Pppbj6iTbQKP2Czdanb/O/CkIVqvx3Cb+AExllisGeC+rwOMS1LlaPAQ5J+B?=
 =?us-ascii?Q?1e0+7AiDIO/GtjW6bjCAGR2onhl+CLX8ySoNByneLfWV9yV2UAEu92aY1iC8?=
 =?us-ascii?Q?tG5o+LQ8w/FygiD/UL9etjp4Ui75hUO14jj0FZX6r9t44QRivImMVnIZcS/q?=
 =?us-ascii?Q?7uXt7tkwtoZ27b5xz4x45q0sUjkC5KonTUVn763Cco9POpJslRm0kh7NrSkU?=
 =?us-ascii?Q?kHb5/FLHK0iPaFu7Sb2MWD/SJfXgA9o=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f461246-124e-43a4-0bc8-08dea9ba25f9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:50:10.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKzXwFbiVvAUm0xvhhU4JyyxE0Rr2z9GDE+y8OE1c35keHLaknD2WLghkMqiYi9RCoHJ8StyqmM2ptn4+dx0WfvxvO/u4eFcih+aTWUL448=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

The MUEx50 UART can handle in-band software flow control (XON/XOFF)
directly in hardware.

Program the on-chip XON/XOFF characters from termios settings and enable
the corresponding MUEx50 flow control modes when IXON or IXOFF is
requested. Provide throttle and unthrottle callbacks so RX can be
stopped and resumed cleanly.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 62 ++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 89086aa7b228..99fd789b7665 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -54,13 +54,31 @@
 #define MOXA_PUART_SFR_950	BIT(5)
 
 /* Enhanced Function Register (EFR) */
+/*
+ * EFR[1:0] - In-Band Receive Flow Control Mode (Compare XON/XOFF):
+ *	00b (0x00) = Disabled
+ *	01b (0x01) = Recognize XON2 & XOFF2 as XOFF character
+ *	10b (0x02) = Recognize XON1 & XOFF1 as XOFF character
+ *	11b (0x03) = Depends on EFR[3:2]
+ * EFR[3:2] - In-Band Transmit Flow Control Mode (Insert XON/XOFF):
+ *	00b (0x00) = Disabled
+ *	01b (0x04) = Use XON2 & XOFF2 as XOFF character
+ *	10b (0x08) = Use XON1 & XOFF1 as XOFF character
+ *	11b (0x0C) = Reserved
+ */
 #define MOXA_PUART_EFR			0x0A
+#define MOXA_PUART_EFR_RX_FLOW		0x02	/* Recognize XON1 & XOFF1 as XOFF character */
+#define MOXA_PUART_EFR_TX_FLOW		0x08	/* Use XON1 & XOFF1 as XOFF character */
 #define MOXA_PUART_EFR_ENHANCED		BIT(4)
 #define MOXA_PUART_EFR_AUTO_RTS		BIT(6)
 #define MOXA_PUART_EFR_AUTO_CTS		BIT(7)
 #define MOXA_PUART_EFR_RX_FLOW_MASK	GENMASK(1, 0)
 #define MOXA_PUART_EFR_TX_FLOW_MASK	GENMASK(3, 2)
 
+#define MOXA_PUART_XON1		0x0B
+#define MOXA_PUART_XON2		0x0C
+#define MOXA_PUART_XOFF1	0x0D
+#define MOXA_PUART_XOFF2	0x0E
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
@@ -161,7 +179,7 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 
 	serial8250_do_set_termios(port, new, old);
 
-	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS | UPSTAT_AUTOXOFF);
 
 	efr = serial_in(up, MOXA_PUART_EFR);
 	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
@@ -170,6 +188,21 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
 		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
 	}
+	/* Set on-chip software flow control character */
+	serial_out(up, MOXA_PUART_XON1, START_CHAR(tty));
+	serial_out(up, MOXA_PUART_XON2, START_CHAR(tty));
+	serial_out(up, MOXA_PUART_XOFF1, STOP_CHAR(tty));
+	serial_out(up, MOXA_PUART_XOFF2, STOP_CHAR(tty));
+
+	efr &= ~(MOXA_PUART_EFR_RX_FLOW_MASK | MOXA_PUART_EFR_TX_FLOW_MASK);
+
+	if (I_IXON(tty))
+		efr |= MOXA_PUART_EFR_RX_FLOW;
+
+	if (I_IXOFF(tty)) {
+		efr |= MOXA_PUART_EFR_TX_FLOW;
+		up->port.status |= UPSTAT_AUTOXOFF;
+	}
 	serial_out(up, MOXA_PUART_EFR, efr);
 }
 
@@ -207,6 +240,31 @@ static void mxpcie8250_shutdown(struct uart_port *port)
 	serial8250_do_shutdown(port);
 }
 
+static void mxpcie8250_throttle(struct uart_port *port)
+{
+	unsigned long flags;
+
+	uart_port_lock_irqsave(port, &flags);
+
+	port->ops->stop_rx(port);
+
+	uart_port_unlock_irqrestore(port, flags);
+}
+
+static void mxpcie8250_unthrottle(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned long flags;
+
+	uart_port_lock_irqsave(port, &flags);
+
+	up->ier |= UART_IER_RLSI | UART_IER_RDI;
+	port->read_status_mask |= UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+
+	uart_port_unlock_irqrestore(port, flags);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -304,6 +362,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
+	up.port.throttle = mxpcie8250_throttle;
+	up.port.unthrottle = mxpcie8250_unthrottle;
 
 	for (i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.43.0

