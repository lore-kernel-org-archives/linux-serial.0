Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012034.outbound.protection.outlook.com [40.107.75.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BD3A6B8D;
	Wed, 29 Jul 2026 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305207; cv=fail; b=qdujsXE/41C/eUIdydVzaIuwo9ISHAWAy2Tj4y0yao/NxCvMo22yisKos6ndA/VYMy532Fp3+DuS+l78Q/AFV9X6wBDFOb2UHTBqe08gayv77ewnrAENmfQTPo/uxEm2NoPUOq2TXdB1oe/jQjPeCn659kWnoa5XWayTNo4lIew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305207; c=relaxed/simple;
	bh=k2FmhMQ6e1MNXZbhm8B/8pYsQLc1I+pXeDoLGhYCc8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JziFMGKByp8hU4Tv4QQxSCRXpFEoP84J2DEhNL7ND5W9DP4ZxKozzSrb4vtXZfP7TT6ciO+njGlnvObvhX4/ftu8T8MHM6iVFFAGfroTIyE/Q/J4IOl4akuhUJvmuxKohggIxF0vflDMQeP+siI6+ezzz08JJag/BO5t6QWJH4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=BCWflUlR; arc=fail smtp.client-ip=40.107.75.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="BCWflUlR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTMyF8m9BlZpgxyMEO4VFIk5I7W5Tyr44q4mxux3Z7DpF8sZgkV5yrtUVlVtwHIr+S9BKC17JfO3OmYaWVFNcVatZSiQ7QjJHat2W/g/QlFziu/uscPr1RWNRKuD9FF98nah0Bjw5N7hqb/pJPQk8Dai1cjZjhT2g8V7kNOfiUwkWpFplZN0jHX2jndmdC0DgF8KnvWHm1rBw2fqMQuur6LvGPPJXK94BsvjmFWrcmiBrBJ0Xa1lou07kh88gyjZsp/L8L0pvxamVvC5MPCj4mULoGlNpMbmtNPBBAPPHP10ZmHzjHrE0wqo62sDlpLFQo3gsmYKrV5AWgj3T3HCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWZubmtUBXNZNQlU0LUUnDXkNcV7jTNu+rLRrc6vErk=;
 b=DqecRfrmDgkrq4fgnrV6GNuwzFuNjTF0HOBglEnju/jajS8pyatIQBKxVln4KVISF0wXJXWZRWhWWZR9kl2LSZkQEXMpjbaFrNeFqlfz39y3+DJHT+zBbLBV00U16gDZQGjtdwNdyTJkpIwRiasoctmAo3L0fjvOcg2+6Fvx4MuDjAIUUO6YEs67v69JSJwciG25x/322Ew9c4WWDxXoEojKFfe77wJ2gHW4nJKntCWLLLecuALojy3MS9Ah8qjy4qQFLoQUW8dmadkIOAYXduroqwj17pQYnvBIFRRhM88cuxVfLhXkyBlMk1AkGxtEGoKXW1CJUDLILgse/D9eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWZubmtUBXNZNQlU0LUUnDXkNcV7jTNu+rLRrc6vErk=;
 b=BCWflUlRAYzSRW9tY9utjnISqU+mUKhm7l0VA4bSTc3n0grYcgMrOCB9fJ+bFAqYVf6et1nTpBcCHSUm5rs5bE4PCJif48WOIAx4ird1iZ96KX7bLG2br19VBO/cYchnMjbEk3TAlHGIIUbU5H8HnL3sBSVz9BFJy71jjjCM8FM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:32 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:32 +0000
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
Subject: [PATCH v4 11/14] serial: 8250_mxpcie: add break support for RS485 using MUEx50 features
Date: Wed, 29 Jul 2026 14:05:59 +0800
Message-ID: <20260729060602.492430-12-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2df0ebf-d886-46e2-52c0-08deed3789be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	u5hzBlBWmXJcgh79aH3nMFhLm04nOxsfJj7x7f5PziE+MED54AnP9xoVLrEc4BaF4PH1AIxIWHvW1UX8ItT8/OucA9F1l415VgC7G7m0wty/0nWdbnt2EFl79prG6omC3+pDHTX06/4IaursvodaYS0Y8EOfZXlSjseaQr+7W9caCfNGJCnN8bebEM2Snwc1n/pKYkwZC9UhlJ/oPx/BmdVp1oIMySwiZ7U3s92sE8Olujy1bTMSH/b2/RXQGlLzLIPfbNzi4833kcB1L5bY8qhJabZUMz7Y+KX97j8yG3s265eO9IkDlviwcTHr+4w/EXzf3wSkMV/HHOGxOKuyOoAKUVIWY9d0YZBK6Qt5mtum/gPFCjZwlOz2P42iDSfVOEtL7MAjZMN8HkYtdYc7OYtgXP1+6fisazshT6G+EAF5aspWF1KAjGs/umpqaPtfvx8UCPJginweOzWqimXiK6DejQKWRfG4mwe0/lvIprrvKNb0N1+giwxxiXq50+NECuor8qDJZuyAo/A614PAKSEiZXEhUbbY2i2K5yDspugYn15UF9DxFFmZXaN4XyPxFTDla2GuChLmuyJHYHhsB9pb+yww2DfXdTb854KYhSwcVm0LIrhJdcqwNCKoYXn5B2A93blzC7KWc02p79yf+tE8Bekvw3iKFDSQMF/NCQTxgVXErQdgEhOYMsC2tEXAWUVEwuXL8zh1KyfSj+R0MiZhMgSnRAHtDrl8yW30esc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y12VycOfulF93F5p+EyYIMU60g8Fz5ia6d7VEzEaiuxgGBkIjDAni5nawERZ?=
 =?us-ascii?Q?xdxMCW4oDeG4fuWMeaXmEP8ByzU5Xdt3UMzBzaIBp1GM3bkPQewXM7BN6rI3?=
 =?us-ascii?Q?OBdte5prlWD/Mxb+ma02Rv2q1Ytuc26HrHaH0iy5F/FwUViC9CD2fn2Jh42L?=
 =?us-ascii?Q?+ZqI0sAmNWTwo8jv+rbGLBsQGxxICd+ntjv3kpfN9HE7+Iq/oRKA6eCHLqZc?=
 =?us-ascii?Q?ilyl2V8SWAz5djuIS7+6ukdel8jtoXADSJzjm/32aKpdFLbZqBNWwzJs7hy0?=
 =?us-ascii?Q?T6ytR9uNGXsF7T6MAWQ3KPaZ5Rdvm6u1k9IjtDIacsQK8xVZFld6/IUzfpPK?=
 =?us-ascii?Q?yf46+PTI+5HK8nlU2+ZlFPsDkPbf6VQS4q+JGctqFq4XoxXUzStW6JHiSlt2?=
 =?us-ascii?Q?ZvQj94fFNC3iQzMJu5rCd5kodZJbijnvkJZv0/71ynAZjnkHdHY1wOxJ1Wyg?=
 =?us-ascii?Q?HVazx6NgbkRumov4XxrwlCJg94ZjCf0+ROl2Xj/UzDFhMSf/QfXrNDdSPi1a?=
 =?us-ascii?Q?t53suOpZyOJl9IinvCTfKvcnAWX8v7CnZE5zyXDkGliHQwJWw6kgIxn3VGCq?=
 =?us-ascii?Q?3/sOAAINl1lJGxiXO3sFSSRXZqyzQ7wvWQpg8/JXKOv2XzJ8k6TvjfXiwvVF?=
 =?us-ascii?Q?hzWoZClnaQGHeAOwvEgLCLKdJ9DFpUqH4j/aZIpe1tLvjjPlxXQiGmqial/a?=
 =?us-ascii?Q?rUy2QnSJvjIuquABeCZ12whgeQo2NW90hNDA1bmDhtKWn4BDaRlrZLabi8Ga?=
 =?us-ascii?Q?5Esu8IDK9SCNIwrK79NWMPBJ9xfOOewY/zrzxppXlX5pS/RsgYiKtaWFKLry?=
 =?us-ascii?Q?/Slb82Rh++oUvewIMReXhhp24XKTY5aJxIG7korToB6VaKcWKDmLwCtezEfg?=
 =?us-ascii?Q?FEfC+QiyABrUHefuG7uteUvp37rnoo9ysxw4XEPruPCS77f7IAC08ff10g76?=
 =?us-ascii?Q?N142ttEKUSTGJnPER2MvVnTupo/oSZgCHWYM0NyEdGJtzr8PJYUq7V6q0mzP?=
 =?us-ascii?Q?xc+ui7mHNCgZCD5hMsL4/6H8DKzCKtQVShQxWNP+PheIYpzG3ursPYFeshvY?=
 =?us-ascii?Q?o6ZR7qMrlNhv+6ofzbKx7U4WsFo9rc9b49zB6cottnv3RGZ5SWdMNxoYTAxq?=
 =?us-ascii?Q?fH4aQ3p1UQwyfMx27iOH7URP4FvXAPtxd5I4I35/wGv293PTBeCLOWid8Tls?=
 =?us-ascii?Q?L3d9XIbfr7KgBxX89xXf9wqUW01y0ryzconZApGNouxYg7ISP2m1QiC5Z/CI?=
 =?us-ascii?Q?8GqTsngeBvUFYqVFyM0HgDghAr/m95klUHZ0Iz0RuVQQ4YpcQVUh2j6zDwW6?=
 =?us-ascii?Q?ib9ABZY4Au/QuoLZGsn1nGXB6Q1o1j4z0bo8ZCdxu4QsddOn8gKI8lH/aZpX?=
 =?us-ascii?Q?NNPeD7M044ChQbSQi8kpEhj97dBsqMnzQiBC4PabfVtHe5gwDEl/KF+hFuo6?=
 =?us-ascii?Q?He25aS5XJWMSOiyMbT6+M9Tk9RqE39q3kzMR3nHo4RntQC5cFoRWuZG/KJ6f?=
 =?us-ascii?Q?MPhGzYlaEiRQxG4Ee1nMI9ikasB02mFFhz0/l+r47m6RmG2hCxyxqPPc8u/i?=
 =?us-ascii?Q?kQbQRjhws8bseHRO7QptICXlQf37yEMIKGJkbblwaFrhKlUVvpAA6AvO/C5R?=
 =?us-ascii?Q?aHwg8NsQ/pxrHV0PwF9yJDrqGihN6taIUkJzV0V/R4D848r8BDjdnIzRfQZ6?=
 =?us-ascii?Q?wPFKhM6sndIEo1U0MlVnB0+a2i8MfrpTA2BkLPpKe7AM5ktVHPOqTnHLjKEk?=
 =?us-ascii?Q?fmlS1UjfrH3lkOWNk0rdutDhL0xP75k=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2df0ebf-d886-46e2-52c0-08deed3789be
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:32.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+lSAYJzKGlyc+pzgW6L8kKI8g+F74J6fa4+F2w477Hqf/Z9MKLdRFUsO75nY/1bQFkOtWIkpStvygtk1Q9G7G7JgJrmoUVzM7IOH8D9g4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

On MUEx50, break signaling under RS485 requires a driver-specific
sequence and cannot be handled correctly by the generic 8250 break
implementation alone.

Implement a mxpcie break_ctl callback that performs MUEx50-specific
break handling when RS485 is enabled and fall back to the default 8250
break handling for other modes.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 927615f2d724..878fc64c4451 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -54,6 +54,7 @@
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_FORCE_TX	BIT(0)
 #define MOXA_PUART_SFR_950	BIT(5)
 
 /* Enhanced Function Register (EFR) */
@@ -384,6 +385,53 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	return 1;
 }
 
+static void mxpcie8250_software_break_ctl(struct uart_port *port, int break_state)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_struct *tty = port->state->port.tty;
+	unsigned char tx_byte = 0x01;
+	unsigned int baud, quot;
+	u8 sfr;
+
+	guard(uart_port_lock_irqsave)(port);
+
+	if (break_state == -1) {
+		serial_out(up, UART_LCR, up->lcr | UART_LCR_DLAB);
+		serial_dl_write(up, 0);
+		serial_out(up, UART_LCR, up->lcr);
+
+		serial_out(up, MOXA_PUART_TX_FIFO_MEM, tx_byte);
+
+		sfr = serial_in(up, MOXA_PUART_SFR);
+		serial_out(up, MOXA_PUART_SFR, sfr | MOXA_PUART_SFR_FORCE_TX);
+
+		up->lcr |= UART_LCR_SBC;
+		serial_out(up, UART_LCR, up->lcr);
+	} else {
+		up->lcr &= ~UART_LCR_SBC;
+		serial_out(up, UART_LCR, up->lcr);
+
+		sfr = serial_in(up, MOXA_PUART_SFR);
+		serial_out(up, MOXA_PUART_SFR, sfr & ~MOXA_PUART_SFR_FORCE_TX);
+
+		serial_out(up, UART_FCR, UART_FCR_CLEAR_XMIT);
+
+		baud = tty_get_baud_rate(tty);
+		quot = uart_get_divisor(port, baud);
+		serial8250_do_set_divisor(port, baud, quot);
+		serial_out(up, UART_LCR, up->lcr);
+	}
+}
+
+static void mxpcie8250_break_ctl(struct uart_port *port, int break_state)
+{
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    !(port->rs485.flags & SER_RS485_MODE_RS422))
+		mxpcie8250_software_break_ctl(port, break_state);
+	else
+		serial8250_do_break_ctl(port, break_state);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -489,6 +537,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
 	up.port.handle_irq = mxpcie8250_handle_irq;
+	up.port.break_ctl = mxpcie8250_break_ctl;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

