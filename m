Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013059.outbound.protection.outlook.com [52.101.127.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C0368D63;
	Wed,  1 Jul 2026 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877438; cv=fail; b=Q75lbcjDEm9EFcDYH+rl/mGroGdlh+aO+J8jvg/BDZDRDSpq5fIGUJzWr6Hn77M9gBS4qPyNYk4BrK2HyUpfc51+fvVlckWL/JtCKi9cNLe/Q2UzU0ZktbAB6hC4v+2rNq2EeCEA7AN9nZp5jS1HarSCiGib/18vA43L+0AqC5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877438; c=relaxed/simple;
	bh=oYBbNz7ftOE0rwLfDUFhJVXyO78pH8wtcTlY6cm4U04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pA1aKx0oZCi+sQcqx62CKeV30WxmqPfACiWa0Ju3G5ZbGw7nCxlZTcb2w+w/pMakDzj+zpxKdiZVC1kiB0HEztiB8hVN3HwJpTIDSYainIAFf2BVvlm5Rdup9pLc9isRj1LDTUPtMfBxZaPvAd4fz+kMkRPn+nwZ4tqQMxCJXPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=PQMPPc3D; arc=fail smtp.client-ip=52.101.127.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="PQMPPc3D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HF48UqNP5v6uG9uva89gUQ3hqrDQQ9grM4OqMVpDEnbAuwUJ4rIJQh+7JeNyIHEG9QgaHrMC6X8loNKr0MylKwMoBr9RzKS4RhaVDNcFJkWzGRSk5pPyEjhJc6EWcxr/uiOz95LIrTC96vCc7pDQl80ywQckpxmPVv4L4vmyc2VCMwJN2sz+UGkpZnN7oY4NDrg6/HMg++pB0+/kLpqHhz+J0knikB/J2fKVsmui/IaZHnB7TeVNKl32vdFVdlAA/w2150ZrlS33X+xfd8EvDzpQolWW3LpKRUxaJqVd22y4CYNudsTxuzgqlFY3wzm53lZUvI7VqqQOd1SwKK7z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrrSTKwg47amz+GVF46AENVDwVxaie3ijaX251zeV4g=;
 b=LB6sRh6ey1bkgnqTGNiy/OP/aDnSIgIUFvKIqukzmtMLkJo85A0WeHE5bFQ7aiiU6oEbcH1R54TCSH6cJHN/BdWfU9Pj4k35h0vLcPqDT3LfeH/uyR/62SylrgW7azJvG3n7j2I+4x+gGtEG2UCvBI8LEPA8naJ7YOe3FarIdDQ/J5TIr5blM33lKigJsrRNq+hrNp+9hlcbyXCphOXPBfXWACYjm+ZCALhWiooxSVUQsZ5stijxTCi4HPYoYma0jFFeiz8MrOsK+DXJD6GAdaOuK9DYQqKV+p56dDtNRe9FO4qKxnH3NdlLSfnruoaRtxOGiVAse7LnnV6ofV5ruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrrSTKwg47amz+GVF46AENVDwVxaie3ijaX251zeV4g=;
 b=PQMPPc3D8kpQMS2JliWYj6TUXpuX7rNYspgRNHFpOkRB1zDVf6pUGK0wG3kVXPAFtKivm+0gsqpLL/zVt5ZFqNPwDzFY+pxrd4WDkBXLCtS9Qqs6/NObZeGiO50BW76ITOO9bnDE7dLbPM+DL++hzNl92xz2TFlOYcueFQ5eMc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:43:55 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:43:55 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 05/15] serial: 8250_mxpcie: offload XON/XOFF flow control to MUEx50 hardware
Date: Wed,  1 Jul 2026 11:41:18 +0800
Message-ID: <20260701034128.218569-6-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8eeaeb13-56f4-4af1-183b-08ded722f9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|6133799003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	/Xbu6EemkhDa0mGeBNTurnRBT57qQUT+m3rXgHcfXmjA0EjBd/3it3+atfmYBwBkChvSm8QvU9V01olY/Kg/5KKmxrURnrbvNe+xc5no2JwYYUOfz8CBYsIFlKazSLj8pjJs+dO4ACfOE7zy4BE83gm7DPlz8MvoO1XPBTY9AyDSgahriGqjPhaLmL46NFeoPhuOyqDroddaBcQ7Hm7r2oZBm2PFu4btoQFTgucH/b1VvXFvx8ri+77++6cC3ozw/ArRN1GXSEGd/zjqNRYjlb/KumCkZguX7V9LEqadHo1eYz8VEm7rawmeP6vXqGQOmP71HPxhALFCWmg4eIHWpuvKKmZN1IMlJHGYqNQLVGNDCw/4DGF9qa16XcpflNglUEIBNN0uT34l9WLnEAkd7Y4HZtXsSzF8tweZ7hfHK1PDWI2oGz4bHj8vCKmOJ0RBWvFI+d7LUFeEK++KhKGpn88lozmBhFa939x2Jm4DnpYrBDCWLCZpxrlXtDbQWwq452/4uu0e/E+Pxal4QTdnSBMyQr1wFGWV3FiXkgPK/CkrLCsR3j9NZ5xhHAuM18HwfoZZa3eWWjz+PNCv5vnud47hKxTEOX9/8YVnqAKOxEBamk6K3RAnGuC3nNouTC6QtddGj2oGzE9LIVO7t7H73Q42BdKe9FzrzcaHfYi1KRs97TvTkOtqh08bJ3Nb91s5m9Ju/Hxz/gKEWRKirGXMaVTPxQJJJu19mIfPuove0rQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(6133799003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K0ne3anOeQWyA6KLPmSkirEVWND4/0u/5UsuKoIPM93zIxOnXvGuLMhooJex?=
 =?us-ascii?Q?aCxk2J+aUD9cpvB3VHboIRZOhRRe6l6Vkb3nIj6WD3PMwVYs8qOQ4q+GG6bB?=
 =?us-ascii?Q?3q//4lWXbDlihQW0vbH4WCPjv+Y1B25OmoyHtaHYIyFARWjr2+J5SFvt4Tvb?=
 =?us-ascii?Q?UQlQ1yaY/UVFfORTejzZY2HARn4wc9xAo4hds5gYrhuWwzOk08DjD/oJ4LgZ?=
 =?us-ascii?Q?glGs+s6rCTF0aJym9CIEsYTdRJJl8a4O4hxwaKbvRsWlxMAUxIxl4dsxJWdQ?=
 =?us-ascii?Q?vBdTRyG3rLBg1il11+uuq+bh82dXM33CUFsUI93iyUyshV/V4M8ul3X+oRIx?=
 =?us-ascii?Q?NgbHSQSjbRPtuFg1acE2Jnxh0rA/LOLC40hLUPqlPra3mhjPHwJnfJKGm94m?=
 =?us-ascii?Q?3idQU614JwKitpSZRld1Ns2G1VTXzhkwiyF+4H/BkSHvhLT2XoEhOzhmykaI?=
 =?us-ascii?Q?ZJcFqQVRBws61yliR1ow35KtX25L0g2bsQoyIRP3YJ0E5Kl21tBBh9RcCxS5?=
 =?us-ascii?Q?ZZdt7imTspCC3WECI++BdJPvAU4lbgTg5tK2f2DhBKG2EM4ew0Ov+xUduYNs?=
 =?us-ascii?Q?FY8r/pIbBqcZTj1bQR7Ul1PjcEcj/zgx1fL+95L9/JsCHMB6wsr45xWmW7o0?=
 =?us-ascii?Q?Pmgc5HJl7Mb+fZJosbcdzzt8USlkwu2pAZtEs+O991CwaJDFQ4HYv5JXwxnx?=
 =?us-ascii?Q?CMmuQbt6C0cyxI0OdrJ80L/AYdfxlHUWGI8yc/vxTCIMPVqQZnSo2j1Gw833?=
 =?us-ascii?Q?TsFSWyfeejV07QftbdfdjkE96mBux2CKx8AyZxaKFCuPbWQk7tKejvmW2N27?=
 =?us-ascii?Q?bF4fydUvZoKDR4/IEYjOsuCOGSx0HK6w/aSOdIofxDN9jhQt6grKN7OymBfX?=
 =?us-ascii?Q?KGEYdA9dKKEriV164s1kdBiqG9fML+GsXrj3/XTEpXSrjkNGKfWikB792CG2?=
 =?us-ascii?Q?EBGipaoxPsdi887RqFvvB+yO41DpHfWxzDWctSOFdcVBTHovFckBF+QanqaA?=
 =?us-ascii?Q?E40SGs0CJUsyQZ1LW/TrHlV1aNLRqMdxhnc9IMXq7Gb2ZYgCW0Q/WVL9nDyn?=
 =?us-ascii?Q?NdCs0im1/UFGTq8xCuk90BECyioB9MJyMvzNitXCPMFKyXj5OpomkVIf8qeZ?=
 =?us-ascii?Q?ziJdPzTBicsVVSFmJfV6mprwkI1lg6AjvnOxULztTpehZX+W2JQ2xpOF0X05?=
 =?us-ascii?Q?cBB3q1w3fm4mBPd/9YX//m80s1zODeHGJVwKt94P1NgF2en8Kqv8+imJ0qVq?=
 =?us-ascii?Q?lYEvK/UyLDsso1BzQZ2K+WgiGeC8vyMP8D4dHJ+kRXpYXFN5qwaDGYvfop6Z?=
 =?us-ascii?Q?sXSOZ5kKZUTw/bsEh/+ScM21NqK+X1OSncNuj/l1rUUJxp7UkEuut9SyNvlY?=
 =?us-ascii?Q?FnZWefyYUPykw/Q3V0MK7XlaMb+VsUiRcBuP07u9XEXSDboqVzLIZH5IQ6E9?=
 =?us-ascii?Q?M0tubNWJFBCOGqfxzQZ/rhkzR1BxHS4gmwedeVVhUDyYRa+fDuRmzi+DxULw?=
 =?us-ascii?Q?DUx7st541zbmdd6Z/8eKCn9IXt0Ugdb06UC2ztM0Zc8hcdcWjfNxJSNjnryJ?=
 =?us-ascii?Q?YTnspQLqVoevpNfvY87ngwjPBOHBPJ3dP30+Fmb1ae67uK1Jty4ND4kb6R5I?=
 =?us-ascii?Q?rYmAk76YpeV7iLM2j8me80og2cUofWNqnvk2h4+ORboujBVb5ERudzE0mB3R?=
 =?us-ascii?Q?9Dz3lJpGlg32QYqgdxOv9TPQ4q0bmH0UX75zZCPYjucXXaaCEsgzROUIVUYI?=
 =?us-ascii?Q?Z2CyvE7VvIdXECv+AahHhmlHHzI0u4U=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeaeb13-56f4-4af1-183b-08ded722f9b4
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:43:55.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpLqvaSigI20t65KWdzFYLIwzrjDOaqwJnR+PJ0wj0T1d0cHvSu1eTvhT91tpOdnsDjv0qD26cJZdSrQdfWyEWi3A9TojAmMp/IhzOwcTdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

The MUEx50 UART can handle in-band software flow control (XON/XOFF)
directly in hardware.

Program the on-chip XON/XOFF characters from termios settings and enable
the corresponding MUEx50 flow control modes when IXON or IXOFF is
requested. Provide throttle and unthrottle callbacks so RX can be
stopped and resumed cleanly.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 55 ++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 0f5323581bba..0cdb7984cbcc 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -53,13 +53,31 @@
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
@@ -160,7 +178,7 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 
 	serial8250_do_set_termios(port, new, old);
 
-	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS | UPSTAT_AUTOXOFF);
 
 	efr = serial_in(up, MOXA_PUART_EFR);
 	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
@@ -169,6 +187,21 @@ static void mxpcie8250_set_termios(struct uart_port *port,
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
 
@@ -215,6 +248,24 @@ static void mxpcie8250_shutdown(struct uart_port *port)
 	serial8250_do_shutdown(port);
 }
 
+static void mxpcie8250_throttle(struct uart_port *port)
+{
+	guard(uart_port_lock_irqsave)(port);
+
+	port->ops->stop_rx(port);
+}
+
+static void mxpcie8250_unthrottle(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	guard(uart_port_lock_irqsave)(port);
+
+	up->ier |= UART_IER_RLSI | UART_IER_RDI;
+	port->read_status_mask |= UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -312,6 +363,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
+	up.port.throttle = mxpcie8250_throttle;
+	up.port.unthrottle = mxpcie8250_unthrottle;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

