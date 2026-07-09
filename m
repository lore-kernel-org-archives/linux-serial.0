Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8973A8736;
	Thu,  9 Jul 2026 05:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575244; cv=fail; b=eEdHXAccchxnrrWW+k3KmXDwUMv/Zkx6jDD8kKzEOxOZIeD1FWHna42eHS3VBuKfoPY1MTdqM5eAArj3jUvYwPN5kdDjaBecJaVDCSIh7YMvVZsZYe9o8Yf30c4mW3Daxu+4xy3rRdeC79xf1kDUb+siY/arkEmVwec0XINXjHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575244; c=relaxed/simple;
	bh=tYw8CGLNqe7i3fNInu/lKyCssKGBrw/GsTeLhuG1Zoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qDKCp6A/VNcL89lGrYFzqRUzdFkElM575xjd1D+47Wpdst7f21ZC2602xqtNA9y9An64WK6pOp8wWTBSs1+I9f/mxS6cp3qOkwK4G1kfp9BB9WNoFGcc/q3CQ6P/tlL+l9VmzeoW03xsY7ThLDCrXdHhHkoCkkzDDV7W1USHEog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=h6omaoGy; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="h6omaoGy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOlBBmaAgVSM8N7Ft4ipAhDNzngQNxvqHWykqbZSXABedmgZd8L0/VMzK8yT/Byj5Am1CyuEzTTxRlhbx8shQIPD2+1gNA7enxZj4s5CC9dukEw4Bssi2soXanLmKsV8OnBOmYiKbdmiH0o6e6X0jLgQI4biPHRzYYwGumjEnPcyP3j4ZUg8pCb676aBRVTj3mEXIYAFulCYUA/jqYWUi/uK7TVr5JTZS9h9so0VVhSxYKAYtL4Zm8nPONRalXJAcxCiwrItnU3BLSpJHK6rpRoiTgmorV9xMDWQfvQfzcfzNiTgDPERIcbGLOIddlFj5Pb93CPgCsmLQj8Az8qaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlRv25jB0wCKMfniSq5c1mBrxOOymfFY5Nksnb86/a4=;
 b=nnrjRJp5l+wiL8JskSI+d+XFLLFcImnF7ZNtmhvlteAyCkazvqFgRbcLedY3snxkM7Gnoc2ymhIInPEDJhBQWg1FF4XgIHRB/5aWAarlqKv1wwLHrs4r0W7G9prGZnZGVtWDeKqTrez9HWkJh8KvuEHtSBhhOLRtIFWFBWqPvK4n7WWnBy/nbRpNrROXd/OelpN0qn+oB1UGhD/ApgF0kPrOAzue14E2I/7AFNsYrlmluncTq4sEwR2jii/Z1ghaT9DnQqapTxs03Gm/Tsqn3ed5d3rqszNSVRjoXxDw/qc10/zo5j1pJ/gMkTkad1QIlDqucEHogS+P3HYcCZCe1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlRv25jB0wCKMfniSq5c1mBrxOOymfFY5Nksnb86/a4=;
 b=h6omaoGyH4cMihcLPfFqnLM2bCkJkbMXoAslh4NvaST5iHAvU+mbvyhFMreLcULuO/qDUiwj1+xbi8Ef8cmnLu+2faf8QwqjKVmYp+uwkzQ4AEt7VXMZpdvRq2uad9DoUq7EITdlzSsOXYVNrAIYNbXgZS2ElBj+bwcMlu6/kJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:55 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:55 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 06/15] serial: 8250_mxpcie: add custom handle_irq callback
Date: Thu,  9 Jul 2026 13:33:05 +0800
Message-ID: <20260709053314.435629-7-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52536774-819e-4b6d-c6c8-08dedd7baa7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	44jX5+YLiwtpUODnph2QnFEuMnITr1NGqlJrpNxUIP3AK/wXfKUfrt7iTI+Xe30kLgEWdtbNhZVx99At5kE+89wJZZ5GWtyMaIYHjaUV0FEHj3U8wHeYAHLsFCd5hO8Otk/gaDEDByIQsksioyVaYifwJ+XN007Qfvl8DajVCh72D13YBJ7aUpsS9wqzeVWYaecv93uW8F0CteKJd1qk3xlGs2GK2I299V++M8Gne43mYwpSX00PLKz4UMz/Yq884n20dx4JZWE2N/fRErXWjPs/TRz7YVZEj6oe52oa/kbVHm5rYIXyb9BT7Od3u19bcvsSjusWv1+vJNO2rXkXCT3D6WUCSk90SFhXw2WqA+U+nGIPClrUGez8fandqWA7C+bZwUup15H5bxRE/kohyHWeYNVeQahdVaQqsQVORSbxKiwcNgB2FFcMJxmkH9R9BFZPrYTOj1ZQAbccV9mGlxj5DCcHh9TbOQN322felpJqshKQfUandSJRnCqwAppeSd84PVqTY5HSyPpZUcYW5h44lALBnisfDKgo3/ULKo0RzcWuUGZHOKpCh/4eCNSebvez5XtJmwQHje5vnDgX8q97MTUD7ShSyd7igvPchLawJ+zqENLPar92Qdfw0gx3XIlTxrqz7h4/WJrWx4QnZuv7vVWvQY57E+Urlb/SddJcNAEjL5iWZIUQEnsEEdFybDt3i2fvQ3GWBczhgRiLMn12h5fBK2HY3Njw+CPwMP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tDzd7HJdTxmWdRd22u0Be6nlCpZeHwia7JtbtWoO5bE/yUYwFwOE4Nygftzz?=
 =?us-ascii?Q?p6sNY55DKsjy3dPcYPuOJejPRgQgKeyAvzxtWCBG3Y5TIbIAoscjCerTEKoK?=
 =?us-ascii?Q?rPYUdqN99vh6MsFcg1Nix7tByQNpL4R/ILjfu571P6A9d9GT3yEpDgkKZpv5?=
 =?us-ascii?Q?KAEJu2E3bmcfzi9Aap4d0BoNr/n0K7EKqDkc3+kpRUt9ENmdSNdJfK+1ZL0R?=
 =?us-ascii?Q?M7HKhlYZ3bPgfmJNtH11RnmXnQ0JIZV7mALxnKUo3uehC/hgcW2ZFYj6cJV1?=
 =?us-ascii?Q?h2beRTU8x3TjZUkR8fXGSCIs0lrijBUZmIwfu7Y2fp6NsrQN+79AZSgk57ux?=
 =?us-ascii?Q?R/96TwakZA5/j/oHBGGd47VmEoHBDq6qoBPRWmeuOaKGqmcKONbtLoUnW0NV?=
 =?us-ascii?Q?JrZSu2xy03K0B8Yw6FDh9RRilQpWohcmyaEodCiz7Yo/AepcngTRhjVccnzk?=
 =?us-ascii?Q?IqDB2WiWh97ByErA8sRewXbyeUCKA3hn6zw/oZM/KvtCiyMhEnQbzNdb4BO2?=
 =?us-ascii?Q?QOPb735PbcbearBYxqrXJpsKBJcq/H8OA2j1Za9TM4z8ltTi8sZh9Q3voMeU?=
 =?us-ascii?Q?46IuraYlX7SihIaxTWCN7kxd/h6tNpQKlrktZgBBk4T3VOrveAtZ4N0yONiy?=
 =?us-ascii?Q?n1mikM0zZLhKd8BP94Ee3dXIUK11Brwu7L9knCoHkh8suLAwDyKcd4pcX1fD?=
 =?us-ascii?Q?H6PM4grZ+rQOTL9boiNBJRVV2obH5LUlSNVguALbjfzyaeLxroj8hBRyVg1U?=
 =?us-ascii?Q?ozwFkuq5Dc7p7SJEdZ1U+03pJl1CkdttyYgCozRuoA0g0ctTFcrlEDjHSt/2?=
 =?us-ascii?Q?yatMipZw4+2cvS4+BVg6ynoKw0NR3+5CNi5B2TWrLY4oMMsOQHPXkFq5Noxg?=
 =?us-ascii?Q?H4oxQINh23bWurNlpp/wEKb4Rv5JfcQfeolwt7m/GbxNGpugjkMIf+QcgWeY?=
 =?us-ascii?Q?Azh9ZlaVrlMtG5/o/hSytfcuzRkNLF81wlCrYo4GWf+ddOlPrXYCuNWbTwqs?=
 =?us-ascii?Q?vsJwMElLtiDAw2tAKa4hPu/uKaraSyRMiYQti6LpwE/iWUE8+ybDWTGXLiUD?=
 =?us-ascii?Q?m/P+uUj+m3KMmjIo7nSOMT3HSfc7vtjydf/tYaLQLC9ez1aFfPLac7fATU9j?=
 =?us-ascii?Q?lCkpg0jyePX+S0QXmrJbLHhXAPk3SvubDFbm2BQHXZ9SRk2shREga6K5+OAc?=
 =?us-ascii?Q?R9EZ9lTLYMAWlvGbY8wiLFS1QF5yqzw5OyNVvbx88UaijWI9244QT4Vb9WW/?=
 =?us-ascii?Q?bahRuGRkHiqXaUNYbQrT3l3qrTt0u9HJMp95K1+6/bdBRdWmzFa6/Q6mkEaZ?=
 =?us-ascii?Q?cFGdkfDjKS4/tjicevhHgzvMTlzTNjKUMlcaSgAfCPSmp3Hf8u5UPnYGZCHm?=
 =?us-ascii?Q?zO3iCtCLlbJmWU/9xyT62DP6QmGNX3NQSpWYBCHxRuaG15zO8aNUw/HB1RhI?=
 =?us-ascii?Q?4mZGOpVfvlkcDYbkCfn9+4FQgq8TtB0zhMK1Eyh7tbqRJ294M3O0xekL5roh?=
 =?us-ascii?Q?vAA2hRpurEhxH6wWxG2FawIcp1dABpUAMy2VHJlv81nivxSGC2q1kxvMkJid?=
 =?us-ascii?Q?IO8SGLEEprO4qwINDcU7rKaYXzxkwdF73CLb7Nn2sG/FT67kBH2I7N7GmTk6?=
 =?us-ascii?Q?PrQpMbIkFcmtyma0ev0Tr17w4dsGg7RmZ8P6tT/0pjIR1cwOL6qi5QUcWg5x?=
 =?us-ascii?Q?izIBI2sCS0GqcpWfqi7XoV69wdWcOQDq/98CKGNDSO8IsDB9MT13toGYPw1z?=
 =?us-ascii?Q?y5hChR7/fg+qyewISe/nc5Ijb5kXgk0=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52536774-819e-4b6d-c6c8-08dedd7baa7b
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:54.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4kl7G2Nr2u+K0phVu0lp5llv4GxHsttf2gfcUVXvczFbQCXJqnZIvwH0hsfTjo6OY8XxGliUpSHwdRqN3c5XWw1nTP2w48h7VvoRpRB/Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

Add a mxpcie-specific handle_irq() implementation for Moxa PCIe serial
ports.

This keeps the interrupt handling self-contained in the driver and
provides a hook point for MUEx50-specific RX/TX paths added in subsequent
patches. The handler processes RX, updates modem status, and handles TX
when THRE is asserted.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 43 +++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 0cdb7984cbcc..1d2e4ca994a7 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -266,6 +266,48 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 }
 
+static u16 mxpcie8250_rx_chars(struct uart_8250_port *up, u16 lsr)
+{
+	struct uart_port *port = &up->port;
+
+	if (!(lsr & (UART_LSR_DR | UART_LSR_BI)))
+		return lsr;
+
+	if (!(port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)))
+		goto do_rx;
+	if (lsr & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS))
+		goto do_rx;
+	if (port->read_status_mask & UART_LSR_DR)
+		goto do_rx;
+
+	return lsr;
+
+do_rx:
+	return serial8250_rx_chars(up, lsr);
+}
+
+static int mxpcie8250_handle_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	u16 lsr;
+	u8 iir;
+
+	iir = serial_in(up, UART_IIR);
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	guard(uart_port_lock_check_sysrq_irqsave)(port);
+
+	lsr = mxpcie8250_rx_chars(up, serial_lsr_in(up));
+
+	serial8250_modem_status(up);
+
+	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
+		serial8250_tx_chars(up);
+
+	return 1;
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -365,6 +407,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.shutdown = mxpcie8250_shutdown;
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
+	up.port.handle_irq = mxpcie8250_handle_irq;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

