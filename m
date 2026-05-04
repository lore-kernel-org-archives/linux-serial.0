Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012048.outbound.protection.outlook.com [40.107.75.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E4347BD7;
	Mon,  4 May 2026 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884607; cv=fail; b=eatRDjw8kn/tyfjZ4ZiS4dZd3xPi/YDKVkUt1SOa4L82dsiNgZgiMPMd6IgNtvhSCJjn5HQgKRudrVNC6QjFCWchQqJxLtewqJ4QSxMlg9NXvuRGbRN02LZDD9s/PiMJE8TvOMhe7czoq8f5XA1k5KYIaCKqH9KPY1xp8eMM66g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884607; c=relaxed/simple;
	bh=s/CoqFRSvRQ7BoR2NRV3X8TiBneQT6N6oKJkBvojWy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hbWhzJGqf7Sv2e1H8Sta/nVHqAkhjnWyMIRcM4XtbdXjq5DNeQjiRb1Yy1UH0gd+iEd6MuIGw11fifa1o7TA22EkDvak2BbkeALLAPTez13ZayGzRaWPdnAIKS+YewM/VKs7AYp1jzEpst0HJyNgC6JK1fauZvsCkE6IZE7a4Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Q2JQlVK+; arc=fail smtp.client-ip=40.107.75.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Q2JQlVK+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2TmIqxOstTZwMb4HZ1nA7usbCpFzwTHsn7zoc7BM5RsiEIF2E6Guvwxmrh1ShegRt4+55eNzVgjmgglXbrZx8Pi6/lxZEGg/wDV/kao/6thOQ1my50O/Y3kHDc25I9crnF17IZ4MzWpzuXON4lsOW0H3kTpxBJU2kUTpWjTH80SqqlOL/ZmTyi0SZyug+i+oNseqvNBArhORo6jEaqopkpvLL79neY5plEua/zCoUX1oAQ1+kAVKYUmgrJPRLF3B6Edy5xT0zfpRp7TtBNIWVJtK3V+At+UUC0Ryxdm+xAXj5I/k4aVjvdzl6eOgOXbdui9/pdx9RF5VpUOQW99Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjKuGHd8HjTQE6peK/KD9ozWXYBidJ47UlGeAfoQq4w=;
 b=N9gnk+/mIALjlP8e6D1m7T/uGzOBK7LBG8vkGawJAtrRsraGijGD+l+zZg7iHcRABT6bgw0eijzqHrBYqMTAUJ2PL6ANwo6jUkpcj+EkcxNBkzmIM156Ql1odWIpglKlsfxEIRx6iA+3P/ya3rmBHkH2DbZNhuWJCcmmK1wy5Zqena5ZJCBEsB3F+lSOBG3nww0Je7TT9nMPSx6bBzEfgLB41kLbtltaCkTOz3kIcyaA4ls8Tqx3JvUvHIZGOlSLJWRy6cj993LcPnxN97FYY8dRk1xq8KCv6a20/RljYHaRRJwdFeRC9hN28kiLSL6Nfk3QU7PPMIOxCfD/bfYeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjKuGHd8HjTQE6peK/KD9ozWXYBidJ47UlGeAfoQq4w=;
 b=Q2JQlVK+CivjnZG26tYemEpGLTU3aRxVbMilBuVWaNinRLKe03L7AbxTb2xSuWVZzhO1hHFUO4l9uBUtZ2Jsd5KYNTIabg+pNM08k2QZuGLvI0D/DpSVu/GxlY+GhwclIkXQYci91TieOPlhfyhSsPfUcQ6L2nZHDsLBBGtNzc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:50:03 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:50:02 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 04/15] serial: 8250_mxpcie: enable automatic RTS/CTS flow control
Date: Mon,  4 May 2026 16:48:49 +0800
Message-ID: <20260504084900.22380-5-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8803c427-1c5f-4665-5d34-08dea9ba215e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	PR2yzyl89THaTRYk7GY1yXXtJ+euYMFWqgjXHnKc8rHNuRjl2wHpVL38ddoSi2mxDguszWd7PC8QXIpBeYTGEiLktX4lpVuvjXimRtPYuhFogqf8lBkghy43lDOtOb4bxWfE1siZFfH+L5i47GJK0zpWTd1KG5BwvnGUDjK6STyE58KtRngzojYMJ5NwSmyC6HfLMzAwKz68ilJ5OCw05oWHRD/bkXBDTivlCpQdB7JRdrH3KKd9g1mfHdt+8zRIxheYiwP3t8i8wVShm4M4FF+l+O1OudHeJuR2GENUPmlIT4eQo/A6xd3Sag5EaW3gWYTRlYq6B967cdhPpAzMDhl99gnJCPGHI3YV+ZHmhQlEN8BTLcZL2gvFEkXIJHUHEHn1i7Fq/9tQfEA/86fzpdTbIFZrqitZWCg1RKD0SMeNTEv+oTEmYjJMBvAcnTLaveOZ4zNYpj1CHdUeJ8MYBwnRKQpE6/P2LSl+JqYa076yas+n8oMZ0ejFHj/HhUB/v8krMDlizRwRj/3OQZm/NmhnlENvnj46KZqcycLBs75H+Cq6hKCEyMy6UbkffPpeua+hqXllBx0fO4ISHb54aHAxefaYr7z5dN3RQkF7/eEbxX1Vl2r4vnlbrnI9Hu8vTwm46bwtoATdc/lQFUtT7tLY1lFVM/KLE4D2NNqAUyQaX+4WO5m3Sgm4lylBjzywvrt4MU2ysa1arv4Fshkj7wUqeK1Er1epHxlzdFFCmkCPAZ2SSkRGq68YSsk6xMio
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HuQNxaAmOHS+GDGPJOn0H8sGJTa9vAsheT8+DPFY7MMkjO8zhLgAJzSADr1W?=
 =?us-ascii?Q?XAlHJeE+5ll4bhQVHGn8gypnqrxJQscDYwAu7vpw07DzF8ml7SsUymJsUs9k?=
 =?us-ascii?Q?2xJiP0DUmEGlj9njNiwiu/KhlaN+N985G6LsffQfSv96x7ifoA/rWhJN3emj?=
 =?us-ascii?Q?leO+wul+1klVGvzSZA0Hv6byvrjsjvnRt+uOjcMpb0k4HCX3PNH3GkTVTXUW?=
 =?us-ascii?Q?z8Y4Y4h41A6KG5SwN7/C0EDsNuWDiJrUP/2PO88k6Q3KWwfaMJDScqzZvxu5?=
 =?us-ascii?Q?6FQtnqqL4AnPHif+Q5XujFPzom5m3+adE+TZZXhmYwmnXBIp0vv6RhGk37IN?=
 =?us-ascii?Q?VQHQJh7Tx/Csn323FpLZvkvoWeNI6V9iwXkQovXFeYeBVKG5WhyiBp9XjI/i?=
 =?us-ascii?Q?mqmlaF1CPhbQtjqC1aweOHqXAnKdIbElr8riwG7Ie/+HqytTREkYF0vuJpVl?=
 =?us-ascii?Q?v+kW0dltVj4FIZQgu0kebAbViLm9FOGv91JzcwwHktf3WZYsRuZ6elXhhyeO?=
 =?us-ascii?Q?d7EX+4Oe5TeBalC0eJkmba6tnl1v8q13idEvpui3mQ0Q9uxqv0zv0PLVPKJ9?=
 =?us-ascii?Q?bVgiq9C8wRjHQx60ksU706SwvVG1yLn2CGDzrbFUk9heZUZTDjHayMpL74ki?=
 =?us-ascii?Q?o0ZC+/lQA9xta212JYXfdBefduS3o1JwGSffLJ6IeOYwQXK61FsDEht4guwO?=
 =?us-ascii?Q?6ZMTIv4yFxsY1E4z0pbKdcfM719CVFGichA0rvIOwEDV6SQkZzCEfFJuqt41?=
 =?us-ascii?Q?og4S9f6slAgsRI0YyfGF5bxav+4g9CAwL3z8XHvaegHnsZ3/YYasHuF0He00?=
 =?us-ascii?Q?5793k4ip0cUmsrDc4tyasDZDVEhknjzKOfvdG2WmcysH33sPI3uUdbQqM4MT?=
 =?us-ascii?Q?tN9HfjxXxbWS1WRlNCwP9fqWMh2LdCMwwQeAAbeLJGkQxFmwTc0foYi/a5uw?=
 =?us-ascii?Q?9oRuQKbIElls24C4U25YIRpblj8maMmmyg2VuawLMHcKvMkkaMMMBSQmVKI8?=
 =?us-ascii?Q?X3eaUgRDXgcNhSNxByyor92YCvZJpDPe1nAUwRdaayGfMIIAIW/x8KBg3rhZ?=
 =?us-ascii?Q?fe1C8KeTW1c4K4w/mhXWBfozzHbDKrig3bGDZZfgEr+CTcGfOP2cc1gDAXJM?=
 =?us-ascii?Q?+K1ppdODFWd+itZW97c4mnf1ucK5MYumIh/417HSSo4UeBuXjFCQc/6RiAK4?=
 =?us-ascii?Q?4lSDIZyK2P/AdV8vWP7xaeTZWutWGyBjRGTzgwByz4heJVLl5wIAaL0CJmQD?=
 =?us-ascii?Q?ok9mzZ7uvXJNnSuxmmWJca+pp1iPRdhSnF3GT5mXc16ryGnKT21sSy7h3PZr?=
 =?us-ascii?Q?/frLtk9uGl6P7LYvhnvS+U6XjhCFxbFwyItsNdhMgspX86R/S0m68Wb5PVZr?=
 =?us-ascii?Q?cJHZYc9/AbDnUbBlK/aF3f36I8B4Po9WEuU56K54aST+3rKSTks9R3EQHxDQ?=
 =?us-ascii?Q?dn++cCph0R9MWjI4twb3PWGAId0wo+UWTzqtWPIWgFlQf8U7DeyD3nDtLojw?=
 =?us-ascii?Q?C/OQanG1A8wx/wuVgyU6Ay6Ki8jp0A+L20UpEOsPSe532RIDvlQIjYV3wNfd?=
 =?us-ascii?Q?C3I8QpjGgzIfLKF79cdpZNDV3XhJat54AbLlUSsT7T6PUsJEiZ08aVTNB9v+?=
 =?us-ascii?Q?Dm/2JDZz+FUxcY5xHB/JGk+WAYsJHwT22CoYyJBEvngZSWiDcyWrh9h0iujO?=
 =?us-ascii?Q?WsQTE/0ZbnaAEnir9XCwNeT7O25DUexuOFcVwVP1dnRi66Jbo2LdWa+z7aYP?=
 =?us-ascii?Q?m5TjMqZPprH/UmBB3e2VmRLPpUwZqf0=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8803c427-1c5f-4665-5d34-08dea9ba215e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:50:02.3337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBJJMQrmhgx05onc6SzlIpkOohtElFd7LZ4STJvy7VVvdCyo9uveVzV5SJ/ztCuO9rFdsw7YISSlpVSRL06CX60dog8izW489UXroF3SZfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

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
index 7ba96a954bb1..89086aa7b228 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -56,6 +56,10 @@
 /* Enhanced Function Register (EFR) */
 #define MOXA_PUART_EFR			0x0A
 #define MOXA_PUART_EFR_ENHANCED		BIT(4)
+#define MOXA_PUART_EFR_AUTO_RTS		BIT(6)
+#define MOXA_PUART_EFR_AUTO_CTS		BIT(7)
+#define MOXA_PUART_EFR_RX_FLOW_MASK	GENMASK(1, 0)
+#define MOXA_PUART_EFR_TX_FLOW_MASK	GENMASK(3, 2)
 
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
@@ -146,6 +150,29 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
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
@@ -274,6 +301,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.iobase = 0;
 	up.port.regshift = 0;
 
+	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
 
-- 
2.43.0

