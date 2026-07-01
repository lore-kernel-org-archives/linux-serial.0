Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013049.outbound.protection.outlook.com [40.107.44.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC8369992;
	Wed,  1 Jul 2026 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877486; cv=fail; b=nmceIYBJNclzLCpgg4fEcqju06D3g+lKS24gjoR/SJyH+AnZr2xvGwRsj1E3rhMyb7YfTGKuxOYpMd0sjiqYlvzHhsBS7eKC32YGjRJU96ag+IDppv2hiQhTTojbCwlponfXV/9F8KeKjurTS70mIIcym7iK/nZWRINB0ELt5P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877486; c=relaxed/simple;
	bh=sH1i6pOQSh9avipiNPKSk7O5SevOfRL/Mfwfu0uGHBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GY/p557OBhubQCeCaK9qfOJiWoHxNjiOb6gnfUwvyTV9aZgOzOOmLTWHz5PgtjprbN+FyP6P9USHVpINrd9CZbCAcujLpdlhRA2EE3ya2v9sCmS9ZemnufyFw7ss4BTvQmphWV8uhZwTCMp5xUE5UwARO+yvCDxUdTKN4slnemY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=KdhPjV1t; arc=fail smtp.client-ip=40.107.44.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="KdhPjV1t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWLFVbNpect1vkvJNjlfxLG3fh3sl7NPqVyZQtv1xkMNtbv+OFItVvWqiWrFL0lgQO5LMZBo3WByT2HfLyfc/vmQxYQlDfoSrvojVEThv5uOmjxOkQThlsT7zIbEFV1fQ3D5SRiMj8FBzU5oHtXrE/qUcjTUt61Y/0h6lJcH1Ovt2Kyg/67xemn6SvajjsvbzsMa8XOP1frGpU4FvoFCxc4TPMEK0u7NpFLSX4p7GoWj5P7I6LGCmMw3VTK/hE9LEEJ7FA4JexbaF+POnvsU+ft933dYf361sn+MEdy6ZYH7vsFEbc31kxYPB0oRBwRRSZ0JpFFuyQY4rOAPG9Lnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9PTIRVKzzofBI1+z1wWkxyCuRWGApgFFGdIFnK/VVg=;
 b=wl8ir3yqHDHws56JQ/8V3u8MKeaDHL8x3rN8ET3rgHT0+0ECUlarN4SxWaSJVy64bhYQ3TgAwBToDDNFOtAU0yAL6MxBhCSiq4hFwFXvywZyoIcwUpMfZk0glm+x9+/qzCAzGbQMO8hUBAbKcQ3wFy99lD8mSCqLNsGZBZtR6FljqSMjbnLfIFARGf87rM2dvulmbvymApUgQd0LvD3CZL/tsgSXuf1bUgen41L/ksbymtOrelFTyKGbAC835toglzt0pwNiPKHrGNpkLgnv9LCXzhniGhiFll2booQfAoaI5k0KHd1pLrIG9HUkb+BJEKrZPmzJqK/q4KbgbBil4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9PTIRVKzzofBI1+z1wWkxyCuRWGApgFFGdIFnK/VVg=;
 b=KdhPjV1tor34q6WMWPqFsFc+tSyqcBVPjEf/ZMMYLy4BNtEEndjayJgw59HC/wu0JbDXGMnm25Mz7fMmrd7wqIF70B8c8ilTtX3Sn6MjLzTZIIuZbTpTn+EFyd6Eg/zZtKA/y5/0VpeNbiVdE4mk1ZmdkuU9c+AoZ2jSe3Dy4HY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:44:42 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:44:42 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 13/15] serial: 8250_mxpcie: add break support for RS485 using MUEx50 features
Date: Wed,  1 Jul 2026 11:41:26 +0800
Message-ID: <20260701034128.218569-14-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: af7f7d43-2fe8-4663-d4fb-08ded72315e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	TRUyyApHtzcCPXxiwMI9q0zWOe/dVjfm2Q+nOPVuhDIy9BpjegK91CbB5IZ1brjrgi405IaJPQ0T2rE/4p5Ki+bNeQiZlOZUSlkyv0RZ/+8xZ65n6hnCN5H2yaP7ENtlNGknKsnsYSSpJtO3zaRkX+4eDR1I3NUFyGuQ0h9hww/YdMZpuTmLPvdlnRdHQ4J0HxoJm3RqqqL4TYF2YgcVOqcH9CiETkSr9vbzwg4zNbxZsZWhXpXBWQHfO/C6wPx3BYaylXA4fqFxkwuzk+wF9GCpkcfSSu0gAsWbTX2c+8RjpBzcgjMqB8YrPHWnhaB1XdX9cNfLZiqOPuDMFqZTADA9yjbe9mYV7Rl7q09LuvhF5UU4aVwLiSfrZPGkerxGF/OGO20ETAt+Wbc64nqeqRGtQNuV4dV7ttErjAddZ6rJ38xgE6zbVfTI+RbLpl8hyd2zC2KCVgZvSFgUGpNGNfFmm780c7bATnwbD7eoFEdLOqzfjGCeGW70MsglWijbjRk3pDrAq9H7XexGURDCvXD5NTIpVGS51pGyDjQScyI12MS2GHTb8xfFCZa2TIQJ1gzEPzL2QZ578wtkdY/avTuZtnn5DCuBhzmDxHmLgqrKlAsQLwrgnBEI+j9eVq2oELYs/O/hd47Yj2Arjjspd0zOilZUkEjnspzjPtzBFxghZFeA98U3bpG0c4zI56GDhJYizdDrEGwSctQnXbC6GGIeqQ6vAezN+wrzDpnD3IY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wEnvm2OTQmjw627hlIyT0Z3TZmfQ5wlYHwyHfcPy8vqGJkZHovLofgGJpbcp?=
 =?us-ascii?Q?D6fbevtldMTM/rm/U7y8wKjILmMvaAJ9giWeFm6v5S3syrOsGgqiwATlgER4?=
 =?us-ascii?Q?oLEGmJXCvBSQMsTau/6nQJmvtUjbrN8qABCJcNN+77FqolfUoE/sGZLkif6D?=
 =?us-ascii?Q?gbIG0Vi/Ubqh8l32PgsdMhAvnbIu9L/0hQiAkP/gou2HGRgK0xd1kbIhJjj6?=
 =?us-ascii?Q?fEWG/45ISicGXnhWOO0usuKWnAQtp6AyBonxfavEuVPFGmVUvbsCU+Aa5KhN?=
 =?us-ascii?Q?q0rYEFU+wRNoidEnDIetPPDKRAJ59MZy3zyumn5UKzL4MWVB8OE0vL4ZaAF3?=
 =?us-ascii?Q?s+I2dquLnsHmo64fdWIIdQBgVAXtwySfQG/wzAif1FBQelep7xuCPl0NPXaJ?=
 =?us-ascii?Q?FKi1sUFW/jAzwoMhJPm5R24h7ku36dYcT9d6IACpUbdxarvAZzrSOxTXImjB?=
 =?us-ascii?Q?MFBc5402X/H+aL2L12aOxF+v90fixVt1xKzmDRM7Y6a6La+e/Tb8h9SyC0hK?=
 =?us-ascii?Q?jBFjl8E21GUMWBVI9T1E6AeXSvkV3dFb6W0nAqENeI8dInghusz0lzvp3k+4?=
 =?us-ascii?Q?5OWJdGbitG4p50UELx9SaU04iI6wgBIkeyFb2SQLcRxSJLtMqkFqKQ4YCYM3?=
 =?us-ascii?Q?bEt7kD4nrl5lXvCQ4SAhpi4X7b1i8SEpfLl8x2ukRbjdWSjmOLGGLHN0IK85?=
 =?us-ascii?Q?N/nr1Wi7e6dFfdzvf5UEch7d4NjeKH2KOHjHB9HCTU/UV1By1yb/Mg8wCPda?=
 =?us-ascii?Q?U6+CGDG7TdbPLoiDrAODNlEcRxHbK+6JZ7XFL+hSVa3lnLTEKpZ5B92Tu816?=
 =?us-ascii?Q?TbeNGytXspLdQBcRzRkhzaCjKuNaOr0Yy0C6ymgDQbTcNwJXTFHL/KQySBFL?=
 =?us-ascii?Q?2uU6UD/JP7oqo5+F2g8RqN0tb4gX+ZfhjUnqqSO0xuurWabS8JVGsgsGTTVJ?=
 =?us-ascii?Q?KU4nbTYi/Ydta1fRJ4aATefXiZRMAs1o5/WSJmBSzU2rTdxMiuqSuHaqDP2q?=
 =?us-ascii?Q?OYqFdTIWf2ZfoJKfF+YdPLFN6ZDJhD7EuO8hgSkcS7oONFH4LDXY8JCWu6+M?=
 =?us-ascii?Q?mp09gh01tRNfc7rqT5/ph4LZFznxJsfuVSu4CAF+KTmNRJFoVhQ2BEc14n7q?=
 =?us-ascii?Q?mKfz77mGZaHPWjwtcCMyfahrlsXB6fl9SJjV7MlvuaGC0GQdQfeKL6R9TE/m?=
 =?us-ascii?Q?oee+I39jT1Ew/eD49npBVtpeSUff1fFIlAxOD/FKg0stqwrLPmEy9E9sGelH?=
 =?us-ascii?Q?PxPuTwjNdg1gGWJS7M7DTRCA315p/+NsGkQvVPUIW9gZizg6z3zQD9pglpzI?=
 =?us-ascii?Q?o3sHZyFL7g/XMpKd4zAkqXaVfMmO8YNJMO5V5npmg7Gak5DJNfJlCOtXqkJ1?=
 =?us-ascii?Q?mazgdUq4533dTWC8+MYg5XqHl/uh6cUmppc1saZxy6bIKIiOWOK11IJGzVPq?=
 =?us-ascii?Q?Z24tkcXMZhi9YB0HOrPOF3o4DgdQA2JpYsvYH32bWVzp9XAkes4t1i8y+iHo?=
 =?us-ascii?Q?UIFYS1zNJw/fq0TF2cAxNzkz0nwvbIBhie+mAqbTeRqQBn+DjOp8b29ZXcKD?=
 =?us-ascii?Q?iy5bzf5p2i0/ye1s7DNuC4E7r9OgRWJlEEpqoF9k6M94ro5Tom0W4PKbLupS?=
 =?us-ascii?Q?pMeZd3FuKZVeylRfHrJ3w6Z9OUF886Cj65GkjgGxmmI8sgkSnJByX6MZeZEe?=
 =?us-ascii?Q?RPiqhnxzPr94H2P9apm0czqHWfkHC9L4nGPG9pYzJ5RX7osmJB5Mf9KT7AjN?=
 =?us-ascii?Q?VLQUSu0+G3wRLmAmAUy4X5dzMVzaGc8=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7f7d43-2fe8-4663-d4fb-08ded72315e2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:44:42.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5BeOb/A76VB6h4P/PBWWBNQJBGVW5+Oj/nWx25HwLKmkkt0y3QNchKJde8pIkIZQ5Al5gsoAwN1uH/+g/ZUSIuJaQdr3eMUAUb0Tia1AqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

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
index db2b9a972a50..da81ea7970f0 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -53,6 +53,7 @@
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_FORCE_TX	BIT(0)
 #define MOXA_PUART_SFR_950	BIT(5)
 
 /* Enhanced Function Register (EFR) */
@@ -427,6 +428,53 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
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
 static void mxpcie8250_work_handler(struct work_struct *work)
 {
 	struct mxpcie8250_port *priv_port = container_of(work, struct mxpcie8250_port, work);
@@ -540,6 +588,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
 	up.port.handle_irq = mxpcie8250_handle_irq;
+	up.port.break_ctl = mxpcie8250_break_ctl;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

